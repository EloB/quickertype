// Runs the render scenarios in
// crates/quicktype-core/tests/fixtures/core-rendering/scenarios/*.txt against
// the reference quicktype (built with `npm run build`) and writes each
// scenario's graph and expected output next to it as *.json. The Rust side,
// crates/quicktype-core/tests/render_scenarios.rs, replays them without Node.
//
// Usage: node xtask/core-rendering/run-render-scenarios.mjs ../quicktype
//
// Scenario language (one command per line, `#` starts a comment line):
//
//   input json NAME <JSON sample>        add a JSON sample as top-level NAME
//   input schema NAME <JSON Schema>      add a JSON Schema as top-level NAME
//   pipeline <JSON object>               extra quicktype options for the
//                                        inference pipeline (default lang rust)
//   render LANG <JSON object>            render the gathered graph with LANG:
//                                        { rendererOptions, alphabetize, filename,
//                                          indentation, leadingComments, probe }
//   render probe <JSON object> script    ... followed by an emit script, up to
//                                        the matching `end`
//
// The graph is built once with the real pipeline (`noRender`); it is dumped
// right before `gatherNames`, like in record-render-cases.mjs, and every
// `render` runs `renderGraphAndSerialize` on the gathered graph.
//
// `probe` is a test target language whose renderer is configured by the
// `probe` object (namers, forbidden names, namespaces, dependency names,
// forward declarations, cycle breakers, comment style) and whose
// `emitSourceStructure` runs the emit script; it exercises the
// ConvenienceRenderer framework directly. Its Rust twin is in
// render_scenarios.rs; both interpret the script language below.
//
// Script commands (arguments are JSON; SL is a sourcelike: a string, an
// array, {"top": name}, {"type": index}, {"prop": [index, json name]},
// {"case": [index, case]}, {"member": [union index, member index]},
// {"mod": "upper"|"lower"|"wrap", "s": SL}, {"ann": message, "s": SL} or
// {"nl": indentation change}):
//
//   default                  list top-levels, named types, properties, cases,
//                            members and dependency names
//   line [SL...]             emitLine(...parts)
//   lineonce [SL...]         emitLineOnce(...parts)
//   item SL                  emitItem(sl)
//   blank N                  ensureBlankLine(N)
//   prevent                  preventBlankLine()
//   indent N                 changeIndent(N)
//   table [[SL...]...]       emitTable(rows)
//   multiline "text"         emitMultiline(text)
//   finish "file"            finishFile(file)
//   reopen "file"            initializeEmitContextForFilename(file)
//   comments [COMMENT...]    emitComments(comments)
//   commentlines [[SL...], OPTIONS]   emitCommentLines(lines, options)
//   description [SL...]      emitDescription(lines)
//   description-of INDEX     emitDescription(descriptionForType(t))
//   property-table INDEX     emitPropertyTable with rows [name, ": ", json, ";"]
//   declarations             one line per declaration
//   cyclebreakers            one line per cycle breaker type
//   foreach WHAT CFG         WHAT: toplevel|object|enum|union|named; one line
//                            per item with its position
//   uniqueunions             forEachUniqueUnion keyed by member count
//   foreachtype              forEachType order
//   have                     haveUnions, haveMaps, ...
//   tostring SL              sourcelikeToString(sl), JSON-quoted
//   indented ... end         indent(() => ...)
//   annotate "msg" ... end   emitAnnotated(issue, () => ...)
//   gathertwice ... end      gather the block and emit it twice
//
// Each render's output (files, issue annotations and console.log lines) or
// error message is recorded.
import { readdirSync, readFileSync, writeFileSync } from "node:fs";
import { createRequire } from "node:module";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";

import { dumpTransformation } from "./dump-transformation.mjs";

const quicktype = resolve(process.argv[2] ?? "../quicktype");
const require = createRequire(join(quicktype, "package.json"));
const dist = join(quicktype, "packages/quicktype-core/dist");
const load = (p) => require(join(dist, p));

const here = dirname(fileURLToPath(import.meta.url));
const scenarioDir = resolve(here, "../../crates/quicktype-core/tests/fixtures/core-rendering/scenarios");

const core = load("index.js");
const { TargetLanguage } = load("TargetLanguage.js");
const GatherNames = load("GatherNames.js");
const { Chance } = load("support/Chance.js");
const { RegularTypeNames, TooManyTypeNames } = load("attributes/TypeNames.js");
const { IssueAnnotationData } = load("Annotation.js");
const { ConvenienceRenderer, topLevelNameOrder } = load("ConvenienceRenderer.js");
const { Namer, DependencyName } = load("Naming.js");
const Strings = load("support/Strings.js");
const { directlyReachableSingleNamedType } = load("Type/TypeUtils.js");
const { modifySource, annotated } = load("Source.js");
const { FetchingJSONSchemaStore } = load("input/FetchingJSONSchemaStore.js");
const { languageNamed } = load("language/All.js");
const { typeRefIndex } = load("Type/TypeRef.js");

// ---- Graph dump (same format as record-render-cases.mjs) -------------------

let drawnNames = new Set();
let lastCity;
const originalCity = Chance.prototype.city;
const originalAnimal = Chance.prototype.animal;
Chance.prototype.city = function (...args) {
    lastCity = originalCity.apply(this, args);
    return lastCity;
};
Chance.prototype.animal = function (...args) {
    const animal = originalAnimal.apply(this, args);
    drawnNames.add(`${lastCity} ${animal}`);
    return animal;
};

function accessorEntry(entry) {
    return typeof entry === "string" ? entry : Array.from(entry);
}

function dumpAttributes(attributes) {
    const result = {};
    for (const [kind, value] of attributes) {
        switch (kind.name) {
            case "provenance":
                break;
            case "names":
                if (value instanceof RegularTypeNames) {
                    result.names = {
                        t: "regular",
                        names: Array.from(value.names),
                        alts: value._alternativeNames === undefined ? null : Array.from(value._alternativeNames),
                        d: value.distance,
                    };
                } else if (value instanceof TooManyTypeNames) {
                    result.names = { t: "toomany", name: Array.from(value.names)[0], d: value.distance };
                } else throw new Error("unknown TypeNames");
                break;
            case "description":
                result.description = Array.from(value);
                break;
            case "propertyDescriptions":
                result.propertyDescriptions = Array.from(value).map(([k, v]) => [k, Array.from(v)]);
                break;
            case "accessorNames":
            case "enumValues":
                result[kind.name] = Array.from(value).map(([k, v]) => [k, accessorEntry(v)]);
                break;
            case "unionIdentifier":
                result.unionIdentifier = Array.from(value);
                break;
            case "unionMemberNames":
                result.unionMemberNames = Array.from(value).map(([k, v]) => [k, accessorEntry(v)]);
                break;
            case "minMax":
            case "minMaxLength":
            case "minMaxItems":
                result[kind.name] = [value[0] ?? null, value[1] ?? null];
                break;
            case "pattern":
                result.pattern = value;
                break;
            case "defaultValue":
                if (value !== null && typeof value === "object") throw new Error("unsupported default value");
                result.defaultValue = value;
                break;
            case "stringTypes":
                result.stringTypes = {
                    cases: value.cases === undefined ? null : Array.from(value.cases),
                    tx: Array.from(value.transformations),
                };
                break;
            case "uriAttributes":
                result.uriAttributes = [Array.from(value[0]), Array.from(value[1])];
                break;
            case "transformation":
                result.transformation = dumpTransformation(value, typeRefIndex);
                break;
            default:
                throw new Error(`cannot dump attribute ${kind.name}`);
        }
    }
    return result;
}

function dumpGraph(graph) {
    const types = [];
    for (const t of graph.allTypesUnordered()) {
        const entry = { k: t.kind, a: dumpAttributes(graph.attributeStore.attributesForType(t)) };
        switch (t.kind) {
            case "array":
                entry.items = t.items.index;
                break;
            case "class":
            case "object":
            case "map":
                entry.fixed = t.isFixed;
                entry.props = Array.from(t.getProperties()).map(([n, p]) => [n, p.type.index, p.isOptional]);
                entry.add = t.getAdditionalProperties()?.index ?? null;
                break;
            case "enum":
                entry.cases = Array.from(t.cases);
                break;
            case "union":
            case "intersection":
                entry.members = Array.from(t.members).map((m) => m.index);
                break;
            default:
                break;
        }
        types.push(entry);
    }
    return { types, topLevels: Array.from(graph.topLevels).map(([name, t]) => [name, t.index]) };
}

let captured;
const originalGatherNames = GatherNames.gatherNames;
GatherNames.gatherNames = function (graph, destructive, debugPrint) {
    if (captured !== undefined) {
        captured.graph = dumpGraph(graph);
        captured.gather = { destructive, randomNames: drawnNames.size };
        captured.graphObject = graph;
    }
    return originalGatherNames(graph, destructive, debugPrint);
};

// ---- The probe language ------------------------------------------------------

const funPrefixes = [
    "Purple", "Fluffy", "Tentacled", "Sticky", "Indigo", "Indecent", "Hilarious",
    "Ambitious", "Cunning", "Magenta", "Frisky", "Mischievous", "Braggadocious",
];
const legalize = Strings.legalizeCharacters(Strings.isLetterOrUnderscoreOrDigit);

function makeNamer(name, spec) {
    const style = Strings.makeNameStyle(spec.style, legalize);
    const prefixes = spec.prefixes === undefined || spec.prefixes === "fun" ? funPrefixes : spec.prefixes;
    return new Namer(name, style, prefixes, spec.ci === true);
}

const defaultProbe = {
    types: { style: "pascal" },
    props: { style: "camel" },
    cases: { style: "upper-underscore" },
    members: { style: "pascal" },
};

class ProbeRenderer extends ConvenienceRenderer {
    constructor(targetLanguage, renderContext, config, script) {
        super(targetLanguage, renderContext);
        this.cfg = { ...defaultProbe, ...config };
        this.script = script;
        this.deps = [];
        const cfg = this.cfg;
        this.typesNamer = makeNamer("types", cfg.types);
        this.propsNamer = cfg.props === null ? null : makeNamer("props", cfg.props);
        const other = (name, spec) => (spec === null ? null : spec === "types" ? this.typesNamer : makeNamer(name, spec));
        this.casesNamer = other("cases", cfg.cases);
        this.membersNamer = other("members", cfg.members);
    }

    makeNamedTypeNamer() {
        return this.typesNamer;
    }

    namerForObjectProperty() {
        if (this.cfg.props === null) return null;
        return this.cfg.props.fresh ? makeNamer("props", this.cfg.props) : this.propsNamer;
    }

    makeUnionMemberNamer() {
        return this.membersNamer;
    }

    makeEnumCaseNamer() {
        return this.casesNamer;
    }

    forbiddenNamesForGlobalNamespace() {
        return this.cfg.keywords ?? [];
    }

    forbiddenForObjectProperties(_o, className) {
        const names = [...(this.cfg.propForbid ?? [])];
        if (this.cfg.propForbidClass) names.push(className);
        return { names, includeGlobalForbidden: this.cfg.propGlobal === true };
    }

    forbiddenForUnionMembers() {
        return { names: this.cfg.memberForbid ?? [], includeGlobalForbidden: this.cfg.memberGlobal === true };
    }

    forbiddenForEnumCases() {
        return { names: this.cfg.caseForbid ?? [], includeGlobalForbidden: this.cfg.caseGlobal === true };
    }

    get unionMembersInGlobalNamespace() {
        return this.cfg.globalMembers === true;
    }

    get enumCasesInGlobalNamespace() {
        return this.cfg.globalCases === true;
    }

    get needsTypeDeclarationBeforeUse() {
        return this.cfg.fwd === true;
    }

    canBeForwardDeclared(t) {
        return (this.cfg.forwardKinds ?? ["class"]).includes(t.kind);
    }

    isImplicitCycleBreaker(t) {
        return (this.cfg.breakers ?? []).includes(t.kind);
    }

    canBreakCycles(t) {
        return this.cfg.canBreak === undefined ? true : this.cfg.canBreak.includes(t.kind);
    }

    get commentLineStart() {
        return this.cfg.comment ?? "// ";
    }

    get commentLinesSpliceOnBackslash() {
        return this.cfg.splice === true;
    }

    unionNeedsName(u) {
        return this.cfg.allUnionsNamed === true ? true : super.unionNeedsName(u);
    }

    namedTypeToNameForTopLevel(t) {
        return this.cfg.topLevelReach === true ? directlyReachableSingleNamedType(t) : super.namedTypeToNameForTopLevel(t);
    }

    makeTopLevelDependencyNames(_t, name) {
        if (this.cfg.topLevelDep !== true) return [];
        const d = new DependencyName(this.typesNamer, topLevelNameOrder, (lookup) => `unmarshal_${lookup(name)}`);
        this.deps.push(d);
        return [d];
    }

    makeNamedTypeDependencyNames(_t, name) {
        if (this.cfg.typeDep !== true) return [];
        const d = new DependencyName(this.typesNamer, 60, (lookup) => `${lookup(name)}_extensions`);
        this.deps.push(d);
        return [d];
    }

    makeNameForEnumCase(e, enumName, caseName, assignedName) {
        if (this.cfg.caseDep !== true) return super.makeNameForEnumCase(e, enumName, caseName, assignedName);
        return new DependencyName(
            this.casesNamer,
            assignedName === undefined ? 20 : 10,
            (lookup) => `${assignedName ?? caseName}_${lookup(enumName)}`,
        );
    }

    proposedUnionMemberNameForTypeKind(kind) {
        return this.cfg.memberKind === true && kind !== "class" ? `${kind}_value` : null;
    }

    emitSourceStructure() {
        this.runScript(this.script);
    }

    // ---- Script interpreter ----

    typeAt(index) {
        return Array.from(this.typeGraph.allTypesUnordered())[index];
    }

    sl(v) {
        if (typeof v === "string") return v;
        if (Array.isArray(v)) return v.map((x) => this.sl(x));
        if ("top" in v) return this._nameStoreView.getForTopLevel(v.top);
        if ("type" in v) return this.nameForNamedType(this.typeAt(v.type));
        if ("prop" in v) return this._propertyNamesStoreView.get(this.typeAt(v.prop[0])).get(v.prop[1]);
        if ("case" in v) return this.nameForEnumCase(this.typeAt(v.case[0]), v.case[1]);
        if ("member" in v) return this.nameForUnionMember(this.typeAt(v.member[0]), this.typeAt(v.member[1]));
        if ("mod" in v) {
            const f = { upper: (s) => s.toUpperCase(), lower: (s) => s.toLowerCase(), wrap: (s) => `<${s}>` }[v.mod];
            return modifySource(f, this.sl(v.s));
        }
        if ("ann" in v) return annotated(new IssueAnnotationData(v.ann), this.sl(v.s));
        if ("nl" in v) return { kind: "newline", indentationChange: v.nl };
        throw new Error(`bad sourcelike ${JSON.stringify(v)}`);
    }

    comment(c) {
        if (typeof c === "string") return c;
        if ("lines" in c) return { lines: c.lines.map((l) => this.sl(l)) };
        if ("descriptionBlock" in c) return { descriptionBlock: c.descriptionBlock.map((l) => this.sl(l)) };
        return { ...c, customLines: c.customLines.map((l) => this.sl(l)) };
    }

    nameOrIndex(t) {
        const name = this._nameStoreView.tryGet(t);
        return name === undefined ? `#${t.index}` : name;
    }

    emitDefault() {
        this.forEachTopLevel("none", (t, name) => this.emitLine("top ", name, " -> ", t.kind, " #", String(t.index)));
        this.forEachNamedType(
            "leading",
            (c, name) => {
                this.emitLine("class ", name, " (", c.getCombinedName(), ")");
                if (this.cfg.props === null) return;
                this.indent(() =>
                    this.forEachClassProperty(c, "none", (n, json, p) =>
                        this.emitLine(n, " <- ", JSON.stringify(json), p.isOptional ? "?" : ""),
                    ),
                );
            },
            (e, name) => {
                this.emitLine("enum ", name);
                if (this.cfg.cases === null) return;
                this.indent(() => this.forEachEnumCase(e, "none", (n, json) => this.emitLine(n, " <- ", JSON.stringify(json))));
            },
            (u, name) => {
                this.emitLine("union ", name);
                if (this.cfg.members === null) return;
                this.indent(() => this.forEachUnionMember(u, null, "none", null, (n, t) => this.emitLine(n, " <- ", t.kind)));
            },
        );
        for (const d of this.deps) this.emitLine("dependency ", d);
    }

    runScript(script) {
        let i = 0;
        const block = () => {
            const start = i;
            let depth = 0;
            for (; i < script.length; i++) {
                const op = script[i].split(" ")[0];
                if (["indented", "annotate", "gathertwice"].includes(op)) depth++;
                if (op === "end") {
                    if (depth === 0) break;
                    depth--;
                }
            }
            const body = script.slice(start, i);
            i++;
            return body;
        };
        while (i < script.length) {
            const line = script[i++];
            const space = line.indexOf(" ");
            const op = space < 0 ? line : line.slice(0, space);
            const arg = space < 0 ? undefined : JSON.parse(line.slice(space + 1));
            switch (op) {
                case "default":
                    this.emitDefault();
                    break;
                case "line":
                    this.emitLine(...arg.map((x) => this.sl(x)));
                    break;
                case "lineonce":
                    this.emitLineOnce(...arg.map((x) => this.sl(x)));
                    break;
                case "item":
                    this.emitItem(this.sl(arg));
                    break;
                case "blank":
                    this.ensureBlankLine(arg);
                    break;
                case "prevent":
                    this.preventBlankLine();
                    break;
                case "indent":
                    this.changeIndent(arg);
                    break;
                case "table":
                    this.emitTable(arg.map((row) => row.map((c) => this.sl(c))));
                    break;
                case "multiline":
                    this.emitMultiline(arg);
                    break;
                case "finish":
                    this.finishFile(arg);
                    break;
                case "reopen":
                    this.initializeEmitContextForFilename(arg);
                    break;
                case "comments":
                    this.emitComments(arg.map((c) => this.comment(c)));
                    break;
                case "commentlines":
                    this.emitCommentLines(arg[0].map((l) => this.sl(l)), arg[1]);
                    break;
                case "description":
                    this.emitDescription(arg.map((l) => this.sl(l)));
                    break;
                case "description-of":
                    this.emitDescription(this.descriptionForType(this.typeAt(arg)));
                    break;
                case "property-table":
                    this.emitPropertyTable(this.typeAt(arg), (name, json, p) => [
                        name,
                        ": ",
                        JSON.stringify(json),
                        p.isOptional ? "?" : "",
                        ";",
                    ]);
                    break;
                case "declarations":
                    this.forEachDeclaration("none", (decl) => this.emitLine(decl.kind, " ", this.nameOrIndex(decl.type)));
                    break;
                case "cyclebreakers":
                    for (const t of this.typeGraph.allTypesUnordered()) {
                        if (this.isCycleBreakerType(t)) this.emitLine("breaker #", String(t.index), " ", t.kind);
                    }
                    break;
                case "foreach": {
                    const [what, cfg] = arg;
                    const emit = (label) => (t, name, pos) => this.emitLine(label, " ", name, " #", String(t.index), " ", pos);
                    if (what === "toplevel") this.forEachTopLevel(cfg, emit("top"));
                    else if (what === "object") this.forEachObject(cfg, emit("object"));
                    else if (what === "enum") this.forEachEnum(cfg, emit("enum"));
                    else if (what === "union") this.forEachUnion(cfg, emit("union"));
                    else if (what === "named") this.forEachNamedType(cfg, emit("object"), emit("enum"), emit("union"));
                    else throw new Error(`bad foreach ${what}`);
                    break;
                }
                case "uniqueunions":
                    this.forEachUniqueUnion(
                        "interposing",
                        (u) => String(u.members.size),
                        (u, v, pos) => this.emitLine("unique ", this.nameForNamedType(u), " ", v, " ", pos),
                    );
                    break;
                case "foreachtype":
                    this.emitLine("types ", Array.from(this.forEachType((t) => t.index)).join(","));
                    break;
                case "have":
                    this.emitLine(
                        `unions=${this.haveUnions} maps=${this.haveMaps} optional=${this.haveOptionalProperties}`,
                        ` namedUnions=${this.haveNamedUnions} namedTypes=${this.haveNamedTypes} enums=${this.haveEnums}`,
                    );
                    break;
                case "tostring":
                    this.emitLine(JSON.stringify(this.sourcelikeToString(this.sl(arg))));
                    break;
                case "indented": {
                    const body = block();
                    this.indent(() => this.runScript(body));
                    break;
                }
                case "annotate": {
                    const body = block();
                    this.emitAnnotated(new IssueAnnotationData(arg), () => this.runScript(body));
                    break;
                }
                case "gathertwice": {
                    const body = block();
                    const items = this.gatherSource(() => this.runScript(body));
                    this.emitGatheredSource(items);
                    this.emitGatheredSource(items);
                    break;
                }
                default:
                    throw new Error(`unknown script command ${op}`);
            }
        }
    }
}

class ProbeLanguage extends TargetLanguage {
    constructor(config, script) {
        super({ displayName: "Probe", names: ["probe"], extension: "probe" });
        this.config = config;
        this.script = script;
    }

    getOptions() {
        return {};
    }

    makeRenderer(renderContext) {
        return new ProbeRenderer(this, renderContext, this.config, this.script);
    }
}

// ---- Scenarios ---------------------------------------------------------------

function parseScenario(text) {
    const lines = text.split("\n").map((l) => l.trim());
    const scenario = { inputs: [], pipeline: {}, renders: [] };
    for (let i = 0; i < lines.length; i++) {
        const line = lines[i];
        if (line === "" || line.startsWith("#")) continue;
        const [cmd] = line.split(" ", 1);
        if (cmd === "input") {
            const m = /^input (json|schema) (\S+) (.*)$/s.exec(line);
            if (m === null) throw new Error(`bad input: ${line}`);
            scenario.inputs.push({ kind: m[1], name: m[2], text: m[3] });
        } else if (cmd === "pipeline") {
            scenario.pipeline = JSON.parse(line.slice("pipeline ".length));
        } else if (cmd === "render") {
            const m = /^render (\S+)(?: (\{.*\}))?( script)?$/.exec(line);
            if (m === null) throw new Error(`bad render: ${line}`);
            const render = { lang: m[1], args: m[2] === undefined ? {} : JSON.parse(m[2]) };
            if (m[3] !== undefined) {
                const script = [];
                let depth = 0;
                for (i++; i < lines.length; i++) {
                    const s = lines[i];
                    if (s === "" || s.startsWith("#")) continue;
                    const op = s.split(" ")[0];
                    if (["indented", "annotate", "gathertwice"].includes(op)) depth++;
                    if (op === "end") {
                        if (depth === 0) break;
                        depth--;
                    }
                    script.push(s);
                }
                render.script = script;
            }
            scenario.renders.push(render);
        } else {
            throw new Error(`unknown command ${cmd}`);
        }
    }
    return scenario;
}

// Runs the inference pipeline and returns the dump of the graph that reached
// gatherNames and the gathered graph.
async function makeGraph(scenario) {
    const inputData = new core.InputData();
    const lang = scenario.pipeline.lang ?? "rust";
    for (const input of scenario.inputs) {
        if (input.kind === "json") {
            const jsonInput = core.jsonInputForTargetLanguage(lang);
            await jsonInput.addSource({ name: input.name, samples: [input.text] });
            inputData.addInput(jsonInput);
        } else {
            const schemaInput = new core.JSONSchemaInput(new FetchingJSONSchemaStore());
            await schemaInput.addSource({ name: input.name, schema: input.text });
            inputData.addInput(schemaInput);
        }
    }
    captured = {};
    drawnNames = new Set();
    await core.quicktypeMultiFile({ ...scenario.pipeline, inputData, lang, noRender: true });
    const rec = captured;
    captured = undefined;
    return rec;
}

async function runScenario(text) {
    const scenario = parseScenario(text);
    const rec = await makeGraph(scenario);

    const renders = [];
    for (const render of scenario.renders) {
        // A renderer stores the names it assigns in the graph's attribute
        // store, and a second renderer would reuse those stale names, so
        // every render gets a freshly built (identical) graph.
        const graph = renders.length === 0 ? rec.graphObject : (await makeGraph(scenario)).graphObject;
        const a = render.args;
        const language =
            render.lang === "probe" ? new ProbeLanguage(a.probe ?? {}, render.script ?? ["default"]) : languageNamed(render.lang);
        const consoleLines = [];
        const originalLog = console.log;
        console.log = (...args) => consoleLines.push(args.join(" "));
        const entry = {
            lang: render.lang,
            filename: a.filename ?? "out.txt",
            alphabetize: a.alphabetize ?? false,
            rendererOptions: a.rendererOptions ?? {},
            indentation: a.indentation ?? null,
            leadingComments: a.leadingComments ?? null,
            probe: a.probe ?? {},
            script: render.script ?? ["default"],
        };
        try {
            const result = language.renderGraphAndSerialize(
                graph,
                entry.filename,
                entry.alphabetize,
                a.leadingComments,
                entry.rendererOptions,
                a.indentation,
            );
            entry.files = Array.from(result).map(([name, srr]) => ({
                name,
                text: srr.lines.join("\n"),
                annotations: srr.annotations
                    .filter((x) => x.annotation instanceof IssueAnnotationData)
                    .map((x) => [x.annotation.message, x.span.start.line, x.span.start.column, x.span.end.line, x.span.end.column]),
            }));
        } catch (e) {
            entry.error = e.message;
        } finally {
            console.log = originalLog;
        }
        entry.console = consoleLines;
        renders.push(entry);
    }
    return { graph: rec.graph, gather: rec.gather, renders };
}

for (const file of readdirSync(scenarioDir).sort()) {
    if (!file.endsWith(".txt")) continue;
    const text = readFileSync(join(scenarioDir, file), "utf8");
    const result = await runScenario(text);
    result.id = file.replace(/\.txt$/, "");
    writeFileSync(join(scenarioDir, file.replace(/\.txt$/, ".json")), `${JSON.stringify(result, null, 1)}\n`);
    const errors = result.renders.filter((r) => r.error !== undefined).length;
    console.log(`${file}: ${result.renders.length} renders${errors > 0 ? `, ${errors} errors` : ""}`);
}
