// Random GraphQL inputs (CLI runs only; the WebAssembly engine has no
// GraphQL input): an introspection result (`--graphql-schema`) with
// scalars, enums, objects, interfaces and unions referring to each other,
// and a query document over it with aliases, `@include`/`@skip`, named and
// inline fragments, nested lists and non-nulls, and one or more operations.

const SCALARS = ["String", "Int", "Float", "Boolean", "ID"];
const CUSTOM_SCALARS = ["DateTime", "URI", "JSON", "Date", "BigInt"];
const NAME = /^[_A-Za-z][_0-9A-Za-z]*$/;

function graphqlName(rng, genKey, capital) {
    for (let i = 0; i < 20; i++) {
        let name = genKey(rng).replace(/[^_0-9A-Za-z]/g, "");
        if (!NAME.test(name) || name.startsWith("__")) continue;
        if (capital) name = name[0].toUpperCase() + name.slice(1);
        return name;
    }

    return capital ? "Thing" : "thing";
}

const named = (kind, name) => ({ kind, name, ofType: null });
const wrap = (kind, ofType) => ({ kind, name: null, ofType });

/** Builds the schema; returns { json, types } where `types` describes it for the query generator. */
function genSchema(rng, genKey, description) {
    const types = new Map();
    const used = new Set([...SCALARS, "Query", "Mutation"]);
    const fresh = () => {
        let name = graphqlName(rng, genKey, true);
        while (used.has(name)) name = `${name}${rng.range(1, 9)}`;
        used.add(name);
        return name;
    };

    const scalars = [...SCALARS, ...rng.sample(CUSTOM_SCALARS, rng.range(0, 2))];
    for (const s of scalars) types.set(s, { kind: "SCALAR", name: s });
    const enums = Array.from({ length: rng.range(0, 3) }, fresh);
    for (const e of enums) {
        const values = new Set();
        const n = rng.range(1, 6);
        for (let i = 0; i < n; i++) values.add(graphqlName(rng, genKey, false).toUpperCase());
        types.set(e, { kind: "ENUM", name: e, values: [...values] });
    }

    const objects = Array.from({ length: rng.range(2, 6) }, fresh);
    const iface = rng.chance(0.35) ? fresh() : undefined;
    const union = rng.chance(0.3) ? fresh() : undefined;

    const leafTypes = [...scalars, ...enums];
    const fieldType = (allowObjects) => {
        const base = allowObjects && rng.chance(0.45)
            ? rng.pick([...objects, ...(iface ? [iface] : []), ...(union ? [union] : [])])
            : rng.pick(leafTypes);
        let t = named(types.get(base)?.kind ?? (base === iface ? "INTERFACE" : base === union ? "UNION" : "OBJECT"), base);
        const wrappers = rng.weighted([[5, ""], [2, "N"], [2, "L"], [1, "NL"], [1, "LN"], [1, "NLN"], [0.3, "LL"]]);
        for (const w of wrappers.split("").reverse()) t = wrap(w === "N" ? "NON_NULL" : "LIST", t);
        return t;
    };

    const makeFields = (n, withObjects) => {
        const fields = [];
        const names = new Set();
        // At least one leaf field, so that every selection can end.
        const leaf = graphqlName(rng, genKey, false);
        names.add(leaf);
        fields.push({ name: leaf, type: fieldType(false), description: null });
        for (let i = 1; i < n; i++) {
            const name = graphqlName(rng, genKey, false);
            if (names.has(name)) continue;
            names.add(name);
            fields.push({ name, type: fieldType(withObjects), description: rng.chance(0.2) ? rng.pick(description) : null });
        }

        return fields;
    };

    const ifaceFields = iface ? makeFields(rng.range(1, 3), false) : [];
    for (const o of objects) {
        const implementsIface = iface !== undefined && rng.chance(0.6);
        const fields = makeFields(rng.range(1, 7), true);
        if (implementsIface) {
            for (const f of ifaceFields) if (!fields.some((g) => g.name === f.name)) fields.push(f);
        }

        types.set(o, { kind: "OBJECT", name: o, fields, interfaces: implementsIface ? [iface] : [] });
    }

    if (iface) {
        const possible = objects.filter((o) => types.get(o).interfaces.includes(iface));
        types.set(iface, { kind: "INTERFACE", name: iface, fields: ifaceFields, possibleTypes: possible.length > 0 ? possible : [objects[0]] });
    }

    if (union) types.set(union, { kind: "UNION", name: union, possibleTypes: rng.sample(objects, rng.range(1, objects.length)) });
    types.set("Query", { kind: "OBJECT", name: "Query", fields: makeFields(rng.range(1, 6), true), interfaces: [] });
    const hasMutation = rng.chance(0.2);
    if (hasMutation) types.set("Mutation", { kind: "OBJECT", name: "Mutation", fields: makeFields(rng.range(1, 3), true), interfaces: [] });

    const fieldJSON = (f) => ({
        name: f.name,
        description: f.description,
        args: rng.chance(0.2) ? [{ name: "first", description: null, type: named("SCALAR", "Int"), defaultValue: null }] : [],
        type: f.type,
        isDeprecated: false,
        deprecationReason: null,
    });
    const typeJSON = (t) => ({
        kind: t.kind,
        name: t.name,
        description: rng.chance(0.15) ? rng.pick(description) : null,
        fields: t.fields ? t.fields.map(fieldJSON) : null,
        inputFields: null,
        interfaces: t.kind === "OBJECT" ? (t.interfaces ?? []).map((i) => named("INTERFACE", i)) : null,
        enumValues: t.kind === "ENUM" ? t.values.map((v) => ({ name: v, description: null, isDeprecated: false, deprecationReason: null })) : null,
        possibleTypes: t.possibleTypes ? t.possibleTypes.map((p) => named("OBJECT", p)) : null,
    });
    const json = {
        data: {
            __schema: {
                queryType: { name: "Query" },
                mutationType: hasMutation ? { name: "Mutation" } : null,
                subscriptionType: null,
                types: rng.shuffle([...types.values()]).map(typeJSON),
                directives: [],
            },
        },
    };
    return { json, types, hasMutation };
}

function baseName(t) {
    while (t.ofType) t = t.ofType;
    return t.name;
}

/** The query document. */
function genQuery(rng, genKey, schema) {
    const { types } = schema;
    const fragments = [];
    const fragmentNames = new Set();
    const pad = (depth) => "  ".repeat(depth);

    const selection = (typeName, depth, budget) => {
        const t = types.get(typeName);
        const lines = [];
        const fieldsOf = t.fields ?? [];
        const selectable = fieldsOf.filter((f) => {
            const b = types.get(baseName(f.type));
            if (b.kind === "SCALAR" || b.kind === "ENUM") return true;
            return depth < 5 && budget.n > 0;
        });
        const picks = rng.sample(selectable, rng.range(1, Math.max(1, Math.min(5, selectable.length))));
        for (const f of picks) {
            budget.n--;
            const alias = rng.chance(0.12) ? `${graphqlName(rng, genKey, false)}: ` : "";
            const directive = rng.weighted([[10, ""], [1, " @include(if: true)"], [1, " @skip(if: false)"]]);
            const b = types.get(baseName(f.type));
            if (b.kind === "SCALAR" || b.kind === "ENUM") {
                lines.push(`${pad(depth)}${alias}${f.name}${directive}`);
            } else {
                lines.push(`${pad(depth)}${alias}${f.name}${directive} {`, ...selection(b.name, depth + 1, budget), `${pad(depth)}}`);
            }
        }

        if (t.kind === "UNION" || t.kind === "INTERFACE" || rng.chance(0.15)) {
            // Inline fragments, on possible types or without a condition.
            const targets = t.possibleTypes ?? [t.name];
            for (const target of rng.sample(targets, rng.range(1, Math.min(2, targets.length)))) {
                if (types.get(target).fields === undefined) continue;
                const condition = t.kind === "OBJECT" && rng.chance(0.5) ? "" : ` on ${target}`;
                lines.push(`${pad(depth)}...${condition} {`, ...selection(target, depth + 1, budget), `${pad(depth)}}`);
            }
        }

        if (t.fields && depth > 0 && rng.chance(0.12) && budget.n > 0) {
            // A named fragment on this type (or on an object implementing it).
            let name = `${graphqlName(rng, genKey, true)}Fragment`;
            while (fragmentNames.has(name)) name = `${name}X`;
            fragmentNames.add(name);
            const on = t.kind === "INTERFACE" && rng.chance(0.5) ? rng.pick(t.possibleTypes) : t.name;
            fragments.push(`fragment ${name} on ${on} {\n${selection(on, 1, budget).join("\n")}\n}`);
            lines.push(`${pad(depth)}...${name}`);
        }

        if (lines.length === 0) {
            const leaf = fieldsOf.find((f) => ["SCALAR", "ENUM"].includes(types.get(baseName(f.type)).kind));
            lines.push(`${pad(depth)}${(leaf ?? fieldsOf[0]).name}`);
        }

        return lines;
    };

    const operations = [];
    const n = rng.weighted([[12, 1], [2, 2], [1, 3]]);
    const opNames = new Set();
    for (let i = 0; i < n; i++) {
        const mutation = schema.hasMutation && rng.chance(0.3);
        let name = n === 1 && rng.chance(0.4) ? "" : graphqlName(rng, genKey, true);
        while (name !== "" && opNames.has(name)) name = `${name}${i}`;
        opNames.add(name);
        const variables = rng.chance(0.15) ? "($first: Int)" : "";
        const header = name === "" && variables === "" && !mutation && rng.chance(0.5) ? "" : `${mutation ? "mutation" : "query"} ${name}${variables} `;
        const body = selection(mutation ? "Mutation" : "Query", 1, { n: rng.range(4, 25) });
        operations.push(`${header}{\n${body.join("\n")}\n}`);
    }

    return [...operations, ...fragments].join("\n\n");
}

/**
 * { schema, queries: [{ name, query }] }: one query document, or several
 * (each its own top-level source, named after its file).
 */
export function genGraphQL(rng, genKey, description) {
    const schema = genSchema(rng, genKey, description);
    const count = rng.weighted([[7, 1], [2, 2], [1, 3]]);
    const queries = [];
    for (let i = 0; i < count; i++) {
        let name = graphqlName(rng, genKey, true);
        while (queries.some((q) => q.name.toLowerCase() === name.toLowerCase())) name = `${name}${i}`;
        queries.push({ name, query: genQuery(rng, genKey, schema) });
    }

    return { schema: JSON.stringify(schema.json, undefined, 2), queries };
}
