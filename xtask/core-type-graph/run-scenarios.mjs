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
//   builder [prov] [alpha] [allopt] [stm=none|string|K[:V],...]  new TypeBuilder; stm=none (the
//                                         default) maps every transformed kind to itself, stm=string
//                                         to string, a list maps each K to V (or itself), others to
//                                         string. The passes below use the same mapping.
//   reserve V                             V = reserveTypeRef()
//   prim V kind ATTRS                     getPrimitiveType(kind, attrs, fwd)
//   str V unrestricted|cases=a:1,b:2[/K,K] ATTRS
//                                         getStringType(attrs, stringTypes, fwd); the cases may
//                                         be empty, each needs a count (1 to 15 digits), `/K,K`
//                                         adds transformed string kinds
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
//   flatten [conflate] [objects] [debug]  flattenUnions; prints whether it is done
//   resolve [debug]                       resolveIntersections; prints whether it is done
//   replaceobj [full] [debug]             replaceObjectType (full: leaveFullObjects)
//   combine [alpha] [conflate] [same] [debug]
//                                         combineClasses (same: onlyWithSameProperties)
//   infermaps [conflate] [debug]          inferMaps
//   expand all|infer|none [debug]         expandStrings
//   flattenstrings [debug]                flattenStrings
//   maketx csharp|python|kinds=K,K [debugtx] [debug]
//                                         makeTransformations with C#'s or Python's
//                                         needsTransformerForType, or one that is true for the
//                                         given kinds; debugtx prints the transformations
//   xf I                                  prints type I's transformation, its reverse, and
//                                         their canFail and node counts
//   query WHAT ARGS                       prints a helper's result for types of the current
//                                         graph (by index): recmembers I,J [union|intersect],
//                                         groups I,J,K, compatible I J [conflate],
//                                         canonical I, nullable I, named, parents I,
//                                         nonnull I, reachable I, cases I (enum cases)
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

import { referenceCheckout } from "../reference.mjs";

const quicktype = referenceCheckout(process.argv[2]);
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
const { flattenUnions } = load("rewrites/FlattenUnions.js");
const { resolveIntersections } = load("rewrites/ResolveIntersections.js");
const { replaceObjectType } = load("rewrites/ReplaceObjectType.js");
const { combineClasses } = load("rewrites/CombineClasses.js");
const { inferMaps } = load("rewrites/InferMaps.js");
const { expandStrings } = load("rewrites/ExpandStrings.js");
const { flattenStrings } = load("rewrites/FlattenStrings.js");
const { makeTransformations } = load("MakeTransformations.js");
const { transformationForType } = load("Transformers.js");
const { languageNamed } = load("language/All.js");

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
        case "cases":
            return Array.from(at(args[1]).cases).join(",");
        case "reachable": {
            const t = directlyReachableSingleNamedType(at(args[1]));
            return t === undefined ? "-" : String(t.index);
        }
        default:
            throw new Error(`unknown query ${args[0]}`);
    }
}

function parseStringTypeMapping(flags) {
    const spec = Array.from(flags).find((f) => f.startsWith("stm="));
    if (spec === undefined || spec === "stm=none") return getNoStringTypeMapping();
    if (spec === "stm=string") return new Map();
    return new Map(
        spec
            .slice("stm=".length)
            .split(",")
            .map((e) => {
                const [k, v] = e.split(":");
                return [k, v ?? k];
            }),
    );
}

function targetLanguageFor(spec) {
    if (spec === "csharp" || spec === "python") return languageNamed(spec);
    if (spec.startsWith("kinds=")) {
        const kinds = new Set(spec.slice("kinds=".length).split(","));
        return { needsTransformerForType: (t) => kinds.has(t.kind) };
    }
    throw new Error(`unknown language ${spec}`);
}

function runContext(stm, flags) {
    return {
        stringTypeMapping: stm,
        debugPrintReconstitution: flags.has("debug"),
        debugPrintTransformations: flags.has("debugtx"),
        time: (_name, f) => f(),
    };
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
        let stm = getNoStringTypeMapping();
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
                    stm = parseStringTypeMapping(flags);
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
                        const [casesSpec, kindsSpec] = args[1].slice("cases=".length).split("/");
                        const cases = new Map(
                            casesSpec === ""
                                ? []
                                : casesSpec.split(",").map((c) => {
                                      const parts = c.split(":");
                                      if (parts.length !== 2 || !/^[0-9]{1,15}$/.test(parts[1])) {
                                          throw new Error(`bad string case ${c}`);
                                      }
                                      return [parts[0], Number(parts[1])];
                                  }),
                        );
                        const kinds = kindsSpec === undefined ? [] : kindsSpec.split(",");
                        st = new StringTypes(cases, new Set(kinds));
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
                case "flatten": {
                    const [g, done] = flattenUnions(
                        graph,
                        stm,
                        flags.has("conflate"),
                        flags.has("objects"),
                        debug,
                    );
                    set(g, "flatten");
                    out.push(`(flatten done: ${done})`);
                    break;
                }
                case "resolve": {
                    const [g, done] = resolveIntersections(graph, stm, debug);
                    set(g, "resolve");
                    out.push(`(resolve done: ${done})`);
                    break;
                }
                case "replaceobj":
                    set(replaceObjectType(graph, stm, false, flags.has("full"), debug), "replaceobj");
                    break;
                case "combine":
                    set(
                        combineClasses(
                            runContext(stm, flags),
                            graph,
                            flags.has("alpha"),
                            flags.has("conflate"),
                            flags.has("same"),
                            debug,
                        ),
                        "combine",
                    );
                    break;
                case "infermaps":
                    set(inferMaps(graph, stm, flags.has("conflate"), debug), "infermaps");
                    break;
                case "expand":
                    set(expandStrings(runContext(stm, flags), graph, args[0]), "expand");
                    break;
                case "flattenstrings":
                    set(flattenStrings(graph, stm, debug), "flattenstrings");
                    break;
                case "maketx":
                    set(
                        makeTransformations(runContext(stm, flags), graph, targetLanguageFor(args[0])),
                        "maketx",
                    );
                    break;
                case "xf": {
                    const t = Array.from(graph.allTypesUnordered())[Number(args[0])];
                    const xf = transformationForType(t);
                    if (xf === undefined) {
                        out.push(`xf ${args[0]}: none`);
                        break;
                    }
                    out.push(`xf ${args[0]}:`);
                    xf.debugPrint();
                    const reverse = xf.reverse;
                    out.push("reverse:");
                    reverse.debugPrint();
                    out.push(
                        `canFail ${xf.transformer.canFail} nodes ${xf.transformer.getNumberOfNodes()}` +
                            ` reverse canFail ${reverse.transformer.canFail} nodes ${reverse.transformer.getNumberOfNodes()}`,
                    );
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
