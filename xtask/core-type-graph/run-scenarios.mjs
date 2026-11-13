// Runs the type graph scenarios in
// crates/quicktype-core/tests/fixtures/core-type-graph/scenarios/*.txt against
// the reference quicktype (built with `npm run build`) and writes each
// scenario's output next to it as *.expected. The Rust interpreter of the
// same scenario language is crates/quicktype-core/tests/type_graph_scenarios.rs;
// it must produce the same output byte for byte.
//
// Usage: node xtask/core-type-graph/run-scenarios.mjs ../quicktype
//
// Scenario language (one command per line, `#` starts a comment, tokens are
// separated by spaces). Variables name type refs of the builder.
//
//   builder [prov] [alpha] [allopt] [stm=none|string]  new TypeBuilder; stm=none (the default)
//                                         maps every transformed kind to itself, stm=string to string
//   reserve V                             V = reserveTypeRef()
//   prim V kind ATTRS                     getPrimitiveType(kind, attrs, fwd)
//   str V unrestricted|cases=a:1,b:2 ATTRS getStringType(attrs, stringTypes, fwd)
//   enum V a,b,c ATTRS                    getEnumType(attrs, cases, fwd)
//   arr V ITEMS ATTRS / uarr V ATTRS      getArrayType / getUniqueArrayType
//   items V ITEMS                         setArrayItems
//   cls V PROPS ATTRS                     getClassType
//   ucls V fixed|open PROPS|- ATTRS       getUniqueClassType (`-`: properties not set yet)
//   props V PROPS|- [ADDITIONAL]          setObjectProperties
//   map V VALUES ATTRS / umap V [fwd=F]   getMapType / getUniqueMapType
//   obj V PROPS|- ADDITIONAL|- ATTRS      getUniqueObjectType (`{}`: no properties)
//   union V MEMBERS ATTRS / uunion V ATTRS getUnionType / getUniqueUnionType
//   inter V MEMBERS ATTRS / uinter V ATTRS getIntersectionType / getUniqueIntersectionType
//   members V MEMBERS                     setSetOperationMembers
//   top NAME V                            addTopLevel
//   finish [printonrewrite]               finish the builder; the result is the current graph
//   print                                 print the current graph
//   gc [alpha] [debug]                    garbageCollect
//   fixedpoint [debug]                    rewriteFixedPoint(false)
//   nonetoany [debug] / opt2null [debug] / rmind [debug]
//   unify GROUPS [conflate] [alpha] [objects] [debug]
//                                         rewrite where each group (indexes of the current
//                                         graph, `1,2;3,4`) is replaced by unifyTypes of its
//                                         types, like CombineClasses
//   remap 3>1,4>2 [debug]                 remap
//   query WHAT ARGS                       prints a helper's result for types of the current
//                                         graph (by index): recmembers I,J [union|intersect],
//                                         groups I,J,K, compatible I J [conflate],
//                                         canonical I, nullable I, named, parents I,
//                                         nonnull I, reachable I
//
// PROPS = name:V,name?:V (optional with ?), MEMBERS = V,V (`-` for none). ATTRS are any of
// n=Name (given name), in=Name (inferred name), sing=Name (given name,
// singularized), many=prefix:count (that many
// inferred names), desc=Text, mm=lo:hi, ml=lo:hi (either side may be empty),
// pat=re, def=s:text|n:1.5|b:true|null, fwd=V (forwarding ref).
// Each command's console output is captured; an error prints `error: <message>`
// and ends the scenario.
import { readdirSync, readFileSync, writeFileSync } from "node:fs";
import { createRequire } from "node:module";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const quicktype = resolve(process.argv[2] ?? "../quicktype");
const require = createRequire(join(quicktype, "package.json"));
const dist = join(quicktype, "packages/quicktype-core/dist");
const load = (p) => require(join(dist, p));

const { TypeBuilder } = load("Type/TypeBuilder.js");
const { TypeGraph } = load("Type/TypeGraph.js");
const { getNoStringTypeMapping } = load("Type/TypeBuilderUtils.js");
const { combineTypeAttributes, emptyTypeAttributes } = load("attributes/TypeAttributes.js");
const {
    TypeNames,
    makeNamesTypeAttributes,
    initTypeNames,
    namesTypeAttributeKind,
    singularizeTypeNames,
} = load("attributes/TypeNames.js");
const { descriptionTypeAttributeKind } = load("attributes/Description.js");
const { minMaxTypeAttributeKind, minMaxLengthTypeAttributeKind, patternTypeAttributeKind } =
    load("attributes/Constraints.js");
const { defaultValueTypeAttributeKind } = load("attributes/DefaultValue.js");
const { StringTypes } = load("attributes/StringTypes.js");
const { noneToAny, optionalToNullable, removeIndirectionIntersections } = load(
    "Type/TypeGraphUtils.js",
);
const {
    combineTypeAttributesOfTypes,
    setOperationMembersRecursively,
    makeGroupsToFlatten,
    removeNullFromUnion,
    directlyReachableSingleNamedType,
} = load("Type/TypeUtils.js");
const { unifyTypes, unionBuilderForUnification } = load("UnifyClasses.js");

const scenarioDir = join(
    dirname(fileURLToPath(import.meta.url)),
    "../../crates/quicktype-core/tests/fixtures/core-type-graph/scenarios",
);

function parseMinMax(v) {
    const [lo, hi] = v.split(":");
    return [lo === "" ? undefined : Number(lo), hi === "" ? undefined : Number(hi)];
}

function parseAttributes(tokens, vars) {
    const parts = [];
    let fwd;
    for (const tok of tokens) {
        const eq = tok.indexOf("=");
        const key = tok.slice(0, eq);
        const v = tok.slice(eq + 1);
        switch (key) {
            case "n":
                parts.push(makeNamesTypeAttributes(v, false));
                break;
            case "in":
                parts.push(makeNamesTypeAttributes(v, true));
                break;
            case "sing":
                parts.push(singularizeTypeNames(makeNamesTypeAttributes(v, false)));
                break;
            case "many": {
                const [prefix, count] = v.split(":");
                const names = new Set();
                for (let i = 0; i < Number(count); i++) names.add(`${prefix}${i}`);
                parts.push(namesTypeAttributeKind.makeAttributes(TypeNames.make(names, undefined, true)));
                break;
            }
            case "desc":
                parts.push(descriptionTypeAttributeKind.makeAttributes(new Set([v])));
                break;
            case "mm":
                parts.push(minMaxTypeAttributeKind.makeAttributes(parseMinMax(v)));
                break;
            case "ml":
                parts.push(minMaxLengthTypeAttributeKind.makeAttributes(parseMinMax(v)));
                break;
            case "pat":
                parts.push(patternTypeAttributeKind.makeAttributes(v));
                break;
            case "def": {
                let value;
                if (v === "null") value = null;
                else if (v.startsWith("s:")) value = v.slice(2);
                else if (v.startsWith("n:")) value = Number(v.slice(2));
                else if (v.startsWith("b:")) value = v.slice(2) === "true";
                parts.push(defaultValueTypeAttributeKind.makeAttributes(value));
                break;
            }
            case "fwd":
                fwd = vars.get(v);
                if (fwd === undefined) throw new Error(`unknown variable ${v}`);
                break;
            default:
                throw new Error(`unknown attribute ${tok}`);
        }
    }
    return [combineTypeAttributes("union", parts), fwd];
}

function ref(vars, name) {
    const r = vars.get(name);
    if (r === undefined) throw new Error(`unknown variable ${name}`);
    return r;
}

function parseProps(spec, vars, builder) {
    const props = new Map();
    if (spec === "-" || spec === "{}") return props;
    for (const p of spec.split(",")) {
        const [name, v] = p.split(":");
        const optional = name.endsWith("?");
        props.set(optional ? name.slice(0, -1) : name, builder.makeClassProperty(ref(vars, v), optional));
    }
    return props;
}

function parseMembers(spec, vars) {
    if (spec === "-") return new Set();
    return new Set(spec.split(",").map((v) => ref(vars, v)));
}

function attributesText(attributes) {
    const parts = [];
    for (const [kind, value] of attributes) {
        const s = kind.stringify(value);
        if (s !== undefined) parts.push(s);
    }
    return parts.join(" | ");
}

function query(graph, args) {
    const types = Array.from(graph.allTypesUnordered());
    const at = (i) => types[Number(i)];
    const indexes = (ts) => Array.from(ts).map((t) => t.index).join(",");
    switch (args[0]) {
        case "recmembers": {
            const kind = args[2] === undefined ? undefined : args[2];
            const [members, attributes] = setOperationMembersRecursively(
                args[1].split(",").map(at),
                kind,
            );
            return `${indexes(members)} | ${attributesText(attributes)}`;
        }
        case "groups":
            return makeGroupsToFlatten(args[1].split(",").map(at), undefined)
                .map(indexes)
                .join(";");
        case "compatible":
            return String(at(args[1]).structurallyCompatible(at(args[2]), args[3] === "conflate"));
        case "canonical":
            return String(at(args[1]).isCanonical);
        case "nullable":
            return String(at(args[1]).isNullable);
        case "named": {
            const { objects, enums, unions } = graph.allNamedTypesSeparated();
            return `objects ${indexes(objects)} enums ${indexes(enums)} unions ${indexes(unions)}`;
        }
        case "parents":
            return indexes(at(args[1]).getParentTypes());
        case "nonnull": {
            const [nullType, rest] = removeNullFromUnion(at(args[1]), true);
            return `${nullType === null ? "-" : nullType.index} | ${indexes(rest)}`;
        }
        case "reachable": {
            const t = directlyReachableSingleNamedType(at(args[1]));
            return t === undefined ? "-" : String(t.index);
        }
        default:
            throw new Error(`unknown query ${args[0]}`);
    }
}

function runScenario(text) {
    const out = [];
    const originalLog = console.log;
    console.log = (...args) => out.push(args.join(" "));
    try {
        initTypeNames();
        const vars = new Map();
        let builder;
        let graph;
        for (const rawLine of text.split("\n")) {
            const line = rawLine.replace(/#.*$/, "").trim();
            if (line === "") continue;
            const [cmd, ...args] = line.split(/ +/);
            const flags = new Set(args);
            const debug = flags.has("debug");
            const set = (g, label) => {
                if (g === graph) out.push(`(${label}: unchanged)`);
                graph = g;
            };
            switch (cmd) {
                case "builder": {
                    const stm = flags.has("stm=string") ? new Map() : getNoStringTypeMapping();
                    const prov = flags.has("prov");
                    builder = new TypeBuilder(stm, flags.has("alpha"), flags.has("allopt"), prov, false);
                    builder.typeGraph = new TypeGraph(builder, 0, prov);
                    break;
                }
                case "reserve":
                    vars.set(args[0], builder.reserveTypeRef());
                    break;
                case "prim": {
                    const [a, fwd] = parseAttributes(args.slice(2), vars);
                    vars.set(args[0], builder.getPrimitiveType(args[1], a, fwd));
                    break;
                }
                case "str": {
                    const [a, fwd] = parseAttributes(args.slice(2), vars);
                    let st;
                    if (args[1] === "unrestricted") st = StringTypes.unrestricted;
                    else {
                        const cases = new Map(
                            args[1]
                                .slice("cases=".length)
                                .split(",")
                                .map((c) => {
                                    const [k, n] = c.split(":");
                                    return [k, Number(n)];
                                }),
                        );
                        st = new StringTypes(cases, new Set());
                    }
                    vars.set(args[0], builder.getStringType(a, st, fwd));
                    break;
                }
                case "enum": {
                    const [a, fwd] = parseAttributes(args.slice(2), vars);
                    vars.set(args[0], builder.getEnumType(a, new Set(args[1].split(",")), fwd));
                    break;
                }
                case "arr": {
                    const [a, fwd] = parseAttributes(args.slice(2), vars);
                    vars.set(args[0], builder.getArrayType(a, ref(vars, args[1]), fwd));
                    break;
                }
                case "uarr": {
                    const [a, fwd] = parseAttributes(args.slice(1), vars);
                    vars.set(args[0], builder.getUniqueArrayType(a, fwd));
                    break;
                }
                case "items":
                    builder.setArrayItems(ref(vars, args[0]), ref(vars, args[1]));
                    break;
                case "cls": {
                    const [a, fwd] = parseAttributes(args.slice(2), vars);
                    vars.set(args[0], builder.getClassType(a, parseProps(args[1], vars, builder), fwd));
                    break;
                }
                case "ucls": {
                    const [a, fwd] = parseAttributes(args.slice(3), vars);
                    const props = args[2] === "-" ? undefined : parseProps(args[2], vars, builder);
                    vars.set(args[0], builder.getUniqueClassType(a, args[1] === "fixed", props, fwd));
                    break;
                }
                case "props":
                    builder.setObjectProperties(
                        ref(vars, args[0]),
                        parseProps(args[1], vars, builder),
                        args[2] === undefined ? undefined : ref(vars, args[2]),
                    );
                    break;
                case "map": {
                    const [a, fwd] = parseAttributes(args.slice(2), vars);
                    vars.set(args[0], builder.getMapType(a, ref(vars, args[1]), fwd));
                    break;
                }
                case "umap": {
                    const [, fwd] = parseAttributes(args.slice(1), vars);
                    vars.set(args[0], builder.getUniqueMapType(fwd));
                    break;
                }
                case "obj": {
                    const [a, fwd] = parseAttributes(args.slice(3), vars);
                    const props = args[1] === "-" ? undefined : parseProps(args[1], vars, builder);
                    const additional = args[2] === "-" ? undefined : ref(vars, args[2]);
                    vars.set(args[0], builder.getUniqueObjectType(a, props, additional, fwd));
                    break;
                }
                case "union": {
                    const [a, fwd] = parseAttributes(args.slice(2), vars);
                    vars.set(args[0], builder.getUnionType(a, parseMembers(args[1], vars), fwd));
                    break;
                }
                case "uunion": {
                    const [a, fwd] = parseAttributes(args.slice(1), vars);
                    vars.set(args[0], builder.getUniqueUnionType(a, undefined, fwd));
                    break;
                }
                case "inter": {
                    const [a, fwd] = parseAttributes(args.slice(2), vars);
                    vars.set(args[0], builder.getIntersectionType(a, parseMembers(args[1], vars), fwd));
                    break;
                }
                case "uinter": {
                    const [a, fwd] = parseAttributes(args.slice(1), vars);
                    vars.set(args[0], builder.getUniqueIntersectionType(a, undefined, fwd));
                    break;
                }
                case "members":
                    builder.setSetOperationMembers(ref(vars, args[0]), parseMembers(args[1], vars));
                    break;
                case "top":
                    builder.addTopLevel(args[0], ref(vars, args[1]));
                    break;
                case "finish":
                    graph = builder.finish();
                    if (flags.has("printonrewrite")) graph.setPrintOnRewrite();
                    out.push(`(forwarding intersections: ${builder.didAddForwardingIntersection})`);
                    break;
                case "print":
                    graph.printGraph();
                    break;
                case "gc":
                    set(graph.garbageCollect(flags.has("alpha"), debug), "gc");
                    break;
                case "fixedpoint":
                    set(graph.rewriteFixedPoint(false, debug), "fixedpoint");
                    break;
                case "nonetoany":
                    set(noneToAny(graph, getNoStringTypeMapping(), debug), "nonetoany");
                    break;
                case "opt2null":
                    set(optionalToNullable(graph, getNoStringTypeMapping(), debug), "opt2null");
                    break;
                case "rmind":
                    set(removeIndirectionIntersections(graph, getNoStringTypeMapping(), debug), "rmind");
                    break;
                case "unify": {
                    const types = Array.from(graph.allTypesUnordered());
                    const groups = args[0]
                        .split(";")
                        .map((g) => g.split(",").map((i) => types[Number(i)]));
                    const conflate = flags.has("conflate");
                    const makeObjects = flags.has("objects");
                    const g = graph.rewrite(
                        "unify",
                        getNoStringTypeMapping(),
                        flags.has("alpha"),
                        groups,
                        debug,
                        (ts, b, fwd) =>
                            unifyTypes(
                                ts,
                                combineTypeAttributesOfTypes("union", ts),
                                b,
                                unionBuilderForUnification(b, makeObjects, false, conflate),
                                conflate,
                                fwd,
                            ),
                    );
                    set(g, "unify");
                    break;
                }
                case "remap": {
                    const types = Array.from(graph.allTypesUnordered());
                    const map = new Map(
                        args[0].split(",").map((p) => {
                            const [from, to] = p.split(">");
                            return [types[Number(from)], types[Number(to)]];
                        }),
                    );
                    set(graph.remap("remap", getNoStringTypeMapping(), false, map, debug), "remap");
                    break;
                }
                case "query":
                    out.push(`${args.join(" ")}: ${query(graph, args)}`);
                    break;
                default:
                    throw new Error(`unknown command ${cmd}`);
            }
        }
    } catch (e) {
        out.push(`error: ${e.message}`);
    } finally {
        console.log = originalLog;
    }
    return `${out.join("\n")}\n`;
}

for (const file of readdirSync(scenarioDir).sort()) {
    if (!file.endsWith(".txt")) continue;
    const text = readFileSync(join(scenarioDir, file), "utf8");
    const expected = runScenario(text);
    writeFileSync(join(scenarioDir, file.replace(/\.txt$/, ".expected")), expected);
    console.log(`${file}: ${expected.split("\n").length - 1} lines`);
}
