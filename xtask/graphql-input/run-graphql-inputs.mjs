#!/usr/bin/env node
// Runs the reference GraphQLInput on GraphQL cases and records the type
// graph it builds, or the error it throws, for
// crates/quicktype-graphql-input/tests/graphql_input.rs to replay byte for
// byte without Node.
//
// usage: node xtask/graphql-input/run-graphql-inputs.mjs <path/to/quicktype>
//
// Each case adds its sources ({name, schema, query}) to a GraphQLInput, the
// schema read from its file or text with parseJSON (as the CLI reads
// `--graphql-schema`), runs addTypes with a TypeBuilder like Run's
// (provenance on, as the recorders of the other inputs use), finishes the
// graph and prints it (printGraph), then what the printer does not show:
// every class's properties ([name, type index, optional]), every enum's
// cases and the top-levels. An exception ends the output with
// `error: <class> <message>`, the class being QuickTypeError or the
// exception's `name` (GraphQLError, TypeError, ...).
//
// Cases:
// - every tests/inputs/graphql/*.graphql against github.gqlschema, as the
//   CLI adds a single query (name "TopLevel"), and all of them at once as
//   separate sources (named by typeNameFromFilename);
// - queries against the small schemas below (SDL, turned into
//   introspection results with graphql-js and written to
//   crates/quicktype-graphql-input/tests/fixtures/graphql-input/schemas):
//   fields, aliases, fragments, inline fragments, directives, interfaces,
//   unions, enums, lists, non-null, mutations, naming, errors;
// - graphql-js syntax errors;
// - malformed introspection results (JavaScript TypeErrors and
//   quicktype's panics);
// - recursive fragments, which the TypeScript cannot finish: recorded
//   with the outcome Node gives (a stack overflow), or skipped where Node
//   never terminates (see `nonTerminating`).
//
// It also records graphql-js's `parse` on its own (`parse-vectors.json`):
// accepted, or the error's message and position, for a few thousand
// seeded mutations of valid documents (queries and SDL), so the ported
// parser accepts and rejects the same documents with the same messages.
//
// Output: crates/quicktype-graphql-input/tests/fixtures/graphql-input/
// cases.json (the manifest), expected/<id>.txt, schemas/*.gqlschema and
// parse-vectors.json.

import { mkdirSync, readdirSync, readFileSync, rmSync, writeFileSync } from "node:fs";
import { createRequire } from "node:module";
import { basename, dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const repoRoot = resolve(dirname(fileURLToPath(import.meta.url)), "..", "..");
const quicktypeDir = resolve(process.argv[2] ?? process.env.QUICKTYPE_DIR ?? join(repoRoot, "..", "quicktype"));
const coreDist = join(quicktypeDir, "packages/quicktype-core/dist");
const require = createRequire(join(coreDist, "index.js"));
const load = (p) => require(join(coreDist, p));

const { GraphQLInput } = require(join(quicktypeDir, "packages/quicktype-graphql-input/dist/index.js"));
const graphql = require(require.resolve("graphql", { paths: [join(quicktypeDir, "packages/quicktype-graphql-input")] }));
const { TypeBuilder } = load("Type/TypeBuilder.js");
const { TypeGraph } = load("Type/TypeGraph.js");
const { getNoStringTypeMapping } = load("Type/TypeBuilderUtils.js");
const { parseJSON } = load("support/ParseJSON.js");
const { QuickTypeError } = load("Messages.js");

process.chdir(repoRoot);
const fixtureDir = "crates/quicktype-graphql-input/tests/fixtures/graphql-input";
const schemaDir = `${fixtureDir}/schemas`;
const github = "tests/inputs/graphql/github.gqlschema";

// ---- Schemas ---------------------------------------------------------------

const sdl = {
    // Most query cases run against this one.
    basic: `
        scalar DateTime
        enum Color { RED GREEN BLUE }
        enum Size { SMALL LARGE }
        interface Node { id: ID! }
        interface Named { name: String }
        type User implements Node & Named {
            id: ID!
            name: String
            age: Int
            score: Float
            active: Boolean!
            born: DateTime
            color: Color
            colors: [Color!]!
            friends(first: Int): [User]
            best: User
            pets: [Pet!]
            matrix: [[Int!]]!
            tags: [String]
            size: Size!
        }
        type Dog implements Node & Named { id: ID! name: String barks: Boolean! owner: User }
        type Cat implements Node & Named { id: ID! name: String meows: Boolean! lives: Int }
        union Pet = Dog | Cat
        input UserFilter { name: String }
        type Query {
            viewer: User!
            user(id: ID!): User
            node(id: ID!): Node
            named: Named
            pet: Pet
            pets: [Pet]
            users(filter: UserFilter): [User!]!
            color: Color
            hello: String
            count: Int!
        }
        type Mutation {
            rename(name: String!): User
            like(id: ID!): Pet!
        }
        type Subscription { tick: Int }
    `,
    // No mutation type.
    queryOnly: `
        type Query { a: Int b: Thing }
        type Thing { x: String y: [Thing] }
    `,
};

mkdirSync(schemaDir, { recursive: true });
for (const [name, text] of Object.entries(sdl)) {
    const introspection = graphql.introspectionFromSchema(graphql.buildSchema(text));
    writeFileSync(`${schemaDir}/${name}.gqlschema`, `${JSON.stringify({ data: introspection }, null, 2)}\n`);
}
const basic = `${schemaDir}/basic.gqlschema`;
const queryOnly = `${schemaDir}/query-only.gqlschema`;
writeFileSync(queryOnly, readFileSync(`${schemaDir}/queryOnly.gqlschema`));
rmSync(`${schemaDir}/queryOnly.gqlschema`);

// A minimal valid schema as JSON text, modified for the malformed cases.
const minimal = () => ({
    data: {
        __schema: {
            queryType: { name: "Query" },
            mutationType: null,
            types: [
                {
                    kind: "OBJECT",
                    name: "Query",
                    fields: [
                        { name: "a", args: [], type: { kind: "SCALAR", name: "Int" } },
                        { name: "o", args: [], type: { kind: "OBJECT", name: "O" } },
                    ],
                },
                { kind: "SCALAR", name: "Int" },
                {
                    kind: "OBJECT",
                    name: "O",
                    fields: [{ name: "x", args: [], type: { kind: "SCALAR", name: "Int" } }],
                },
            ],
        },
    },
});
const modified = (f) => {
    const s = minimal();
    f(s, s.data.__schema, s.data.__schema.types);
    return JSON.stringify(s);
};

// ---- Cases -------------------------------------------------------------------

const cases = [];
// A source: the schema is a path (`schemaFile`) or text (`schemaText`).
const src = (name, schema, query) =>
    schema.startsWith("{") || schema.startsWith("[") || !schema.includes("/")
        ? { name, schemaText: schema, query }
        : { name, schemaFile: schema, query };
const one = (id, schema, query) => cases.push({ id, sources: [src("TopLevel", schema, query)] });

// tests/inputs/graphql, as the CLI adds them.
const inputDir = "tests/inputs/graphql";
const queryFiles = readdirSync(inputDir).filter((f) => f.endsWith(".graphql")).sort();
for (const f of queryFiles) {
    one(`inputs/${f.replace(/\.graphql$/, "")}`, github, readFileSync(`${inputDir}/${f}`, "utf8"));
}
cases.push({
    id: "inputs/all-as-sources",
    sources: queryFiles.map((f) => src(basename(f, ".graphql"), github, readFileSync(`${inputDir}/${f}`, "utf8"))),
});
cases.push({
    id: "inputs/two-sources",
    sources: ["github1.graphql", "github2.graphql"].map((f) =>
        src(f.replace(/\.graphql$/, ""), github, readFileSync(`${inputDir}/${f}`, "utf8")),
    ),
});

// Selections against the basic schema.
const q = (id, query) => one(`queries/${id}`, basic, query);
q("scalars", "{ viewer { id name age score active born tags size } count hello }");
q("aliases", "{ me: viewer { login: name n2: name name } you: user(id: 1) { name } }");
q("alias-replaces", "{ viewer { a: name b: age a: id } }");
q("same-field-twice", "{ viewer { name age name } }");
q("enums", "{ viewer { color colors size } color }");
q("lists", "{ viewer { matrix friends { name friends { age } } pets { ... on Dog { barks } } } }");
q("nested-objects", "{ viewer { best { best { best { name } } } } }");
q("non-null-object", "{ viewer { name } user(id: 2) { name } }");
q("fragment-same-type", "{ viewer { ...U } } fragment U on User { name age }");
q("fragment-interface", "{ viewer { ...N } } fragment N on Named { name }");
q("fragment-nested", "{ viewer { ...A } } fragment A on User { name ...B } fragment B on User { age best { ...A2 } } fragment A2 on User { id }");
q("fragment-order", "{ viewer { age ...U id } } fragment U on User { name size }");
q("fragment-later-wins", "{ viewer { ...U } } fragment U on User { name } fragment U on User { age }");
q("fragment-twice", "{ viewer { ...U ...U } } fragment U on User { name }");
q("inline-fragment-no-condition", "{ viewer { ... { name } ... @include(if: true) { age } } }");
q("inline-fragments-union", "{ pet { ... on Dog { name barks } ... on Cat { name lives } } pets { ... on Cat { meows } } }");
q("inline-fragments-interface", "{ node(id: 1) { id ... on User { name } ... on Dog { barks } } named { name ... on Cat { lives } } }");
q("directives", "query($b: Boolean!) { viewer { name @include(if: $b) age @skip(if: $b) id @deprecated active @include(if: $b) @skip(if: true) best @skip(if: $b) { name } } }");
q("directive-on-spread", "{ viewer { ...U @include(if: false) id } } fragment U on User { name }");
q("directive-on-fragment-definition", "{ viewer { ...U } } fragment U on User @include(if: false) { name }");
q("directive-on-inline-fragment", "{ viewer { ... on User @skip(if: true) { name } } }");
q("directive-on-object", "{ viewer { best @include(if: true) { name } colors @skip(if: false) } }");
q("named-query", "query Mine { viewer { name } }");
q("two-queries-one-source", "query A { viewer { name } } query B { count }");
q("anonymous-and-named", "{ count } query B { hello }");
q("mutation", "mutation M { rename(name: \"x\") { name } like(id: 1) { ... on Dog { barks } } }");
q("subscription-only", "subscription { tick }");
q("subscription-and-query", "subscription S { tick } query { count }");
q("type-system-definitions", "type Ignored { a: Int } { count } extend type Ignored @x scalar S");
q("variables", "query Q($id: ID! = 3, $f: UserFilter = {name: \"n\"}, $l: [[Int!]!]) { user(id: $id) { name } users(filter: $f) { age } }");
q("typename", "{ viewer { __typename name } }");
q("schema-introspection", "{ __schema { types { name } } }");
q("unknown-field", "{ viewer { nosuchfield } }");
q("unknown-field-nested", "{ viewer { best { nope } } }");
q("unknown-fragment", "{ viewer { ...Nope } }");
q("fragment-on-unknown-type", "{ viewer { ...F } } fragment F on Nope { name }");
q("inline-on-unknown-type", "{ viewer { ... on Nope { name } } }");
q("field-on-union", "{ pet { name } }");
// An optional fragment on a type the schema lacks: TypeScript never reads
// the missing type's name and carries `undefined` along.
q("optional-spread-unknown-type", "query { ...F @skip(if: true) } fragment F on Nope { hello }");
q("optional-inline-unknown-type", "query { ... on Nope @include(if: true) { hello } }");
q("optional-unknown-type-nested-inline", "query { ...F @skip(if: true) } fragment F on Nope { ... { hello } }");
q("optional-unknown-type-known-spread", "query { ...F @skip(if: true) } fragment F on Nope { ...G } fragment G on Query { count }");
q("optional-unknown-type-known-inline", "query { ...F @include(if: true) } fragment F on Nope { ... on Query { hello } }");
q("optional-field-unknown-inline", "{ viewer @include(if: true) { ... on Nope { name } } }");
q("fragment-again-after-expansion", "{ viewer { ...A best { ...A } friends { ...B } } } fragment A on User { name } fragment B on User { ...A age }");
q("fragment-chain", `{ viewer { ...F0 } } ${Array.from({ length: 60 }, (_, i) => `fragment F${i} on User { ${i % 2 ? "name" : "age"} ${i < 59 ? `...F${i + 1}` : "id"} }`).join(" ")}`);
q("object-without-selection", "{ viewer }");
q("scalar-with-selection", "{ count { x } }");
q("input-object-field", "{ users { name } }");
q("enum-with-selection", "{ color { x } }");
q("duplicate-query-names", "query A { count } query A { hello }");
q("prototype-fragment-name", "{ viewer { ...toString } }");
q("prototype-type-condition", "{ viewer { ... on toString { name } } }");
q("prototype-constructor", "{ viewer { ... on constructor { name } } }");
q("proto-fragment", "{ viewer { ...__proto__ } }");
q("proto-fragment-defined", "{ viewer { ...__proto__ ...kind } } fragment __proto__ on User { name }");
q("proto-fragment-description", "{ viewer { ...description } } fragment __proto__ on User { name }");
q("proto-fragment-builtin", "{ viewer { ...hasOwnProperty } } fragment __proto__ on User { name }");
q("proto-type-condition", "{ viewer { ... on __proto__ { name } } }");
q("recursive-fragment-through-field", "{ viewer { ...R } } fragment R on User { name friends { ...R } }");
q("recursive-fragments-through-field", "{ viewer { ...A } } fragment A on User { best { ...B } } fragment B on User { name ...A }");
q("deep-nesting", `{ viewer ${"{ best ".repeat(40)}{ name }${" }".repeat(40)} }`);
q("deep-lists", "{ viewer { matrix } }");
one("queries/mutation-without-mutation-type", queryOnly, "mutation { a }");
one("queries/query-only", queryOnly, "{ a b { x y { y { x } } } }");
one("queries/naming-empty-top-level", queryOnly, "{ b { x } }");
cases[cases.length - 1].sources[0].name = "";

// Several sources.
cases.push({
    id: "sources/named-queries",
    sources: [src("First", basic, "query A { count } query B { hello }"), src("Second", basic, "{ viewer { name } }")],
});
cases.push({
    id: "sources/same-query-name",
    sources: [src("First", basic, "query A { count }"), src("Second", basic, "query A { hello }")],
});
cases.push({
    id: "sources/same-source-name",
    sources: [src("Same", basic, "{ count }"), src("Same", queryOnly, "{ a }")],
});
cases.push({
    id: "sources/different-schemas",
    sources: [src("One", basic, "{ viewer { name } }"), src("Two", queryOnly, "{ b { x } }")],
});
cases.push({
    id: "sources/error-in-second",
    sources: [src("One", basic, "{ count }"), src("Two", basic, "{ nope }")],
});

// graphql-js syntax errors.
const syntax = [
    "",
    " ",
    "{",
    "{ a",
    "{ a(",
    "{ a(b: ) }",
    "{ a(b: $) }",
    "{ a } }",
    "{ ...on }",
    "{ ... on }",
    "fragment on on User { a }",
    "fragment F User { a }",
    "query Q($a: Int = $b) { a }",
    "query Q($a: Int = [$b]) { a }",
    "query Q($a: [Int) { a }",
    "query Q($a) { a }",
    "query Q($a: Int @dir(x: $y)) { a }",
    "\"desc\" { a }",
    "\"desc\" extend type T @a",
    "\"\"\"\n  block\n    desc\n  \"\"\" query { a }",
    "query \"\"\"  x  \"\"\"",
    "query \"x\\ny\"",
    "enum E { true }",
    "enum E { \"null\" }",
    "directive @d on FOO",
    "directive @d repeatable on FIELD | QUERY",
    "directive @d on | FIELD",
    "extend directive @d @x",
    "extend type T",
    "extend schema",
    "extend scalar S",
    "extend union U",
    "extend enum E",
    "extend input I",
    "extend interface I",
    "extend foo",
    "schema { query: Q, mutation: M }",
    "schema { }",
    "type T implements & A & B { a: Int }",
    "union U = | A | B",
    "input I { a: Int = 1 @d }",
    "subscribe { a }",
    "query Q { a } fragment",
    "{ a: }",
    "{ a: b: c }",
    "{ a @ }",
    "{ a(x: {b: 1, c: [1, 2.5, \"s\", true, null, ENUM, {d: $v}]}) }",
    "{ a(x: 01) }",
    "{ a(x: 1.) }",
    "{ a(x: 1.5e) }",
    "{ a(x: 1a) }",
    "{ a(x: -x) }",
    "{ a(x: 0x1) }",
    "{ a(x: 1.2.3) }",
    "{ a(x: \"unterminated) }",
    "{ a(x: \"line\nbreak\") }",
    "{ a(x: \"\\q\") }",
    "{ a(x: \"\\u12\") }",
    "{ a(x: \"\\u{}\") }",
    "{ a(x: \"\\u{110000}\") }",
    "{ a(x: \"\\u{7FFFFFFF}\") }",
    "{ a(x: \"\\u{FFFFFFFFF}\") }",
    "{ a(x: \"\\uD83D\") }",
    "{ a(x: \"\\uD83D\\u0041\") }",
    "{ a(x: \"\\uDE00\") }",
    "{ a(x: \"\\uD83D\\uDE00\\u{1F600}\") } }",
    "{ a(x: \"\"\"unterminated) }",
    "{ a(x: \"\"\" a \\\"\"\" b \"\"\") } }",
    "{ a(x: 'single') }",
    "{ a ? }",
    "{ a . }",
    "{ a .. }",
    "{ a \u0007 }",
    "{ a \u00e9 }",
    "{ a \u{1F600} }",
    "{ a \u2028 }",
    "\ufeff{ a } }",
    "{ a } # comment\n }",
    "{ a } # comment \u{1F600}\r\n }",
    "{ a(x: \"\u{1F600}\") } }",
    "query Q @a(b: 1) @c { a } query",
    "{ a } mutation",
    "mutation",
    "fragment F on T @d(x: $v) { a } }",
    "query Q($a: Int = 1 $b: [Int!]! = [1]) { a } }",
];
syntax.forEach((s, i) => q(`syntax/${String(i).padStart(3, "0")}`, s));

// Malformed introspection results.
const m = (id, schemaText, query = "{ a }") => one(`malformed/${id}`, schemaText, query);
m("null", "null");
m("number", "5");
m("string", "\"x\"");
m("array", "[]");
m("empty-object", "{}");
m("data-null", JSON.stringify({ data: null }));
m("data-empty", JSON.stringify({ data: {} }));
m("schema-empty", JSON.stringify({ data: { __schema: {} } }));
m("query-type-name-null", modified((_, s) => { s.queryType.name = null; }));
m("query-type-no-name", modified((_, s) => { delete s.queryType.name; }));
m("query-type-missing", modified((_, s) => { s.queryType.name = "Nope"; }));
m("query-type-number", modified((_, s, t) => { s.queryType.name = 5; t[0].name = 5; }));
m("types-missing", modified((_, s) => { delete s.types; }));
m("types-null", modified((_, s) => { s.types = null; }));
m("types-object", modified((_, s) => { s.types = {}; }));
m("types-number", modified((_, s) => { s.types = 3; }));
m("types-string", modified((_, s) => { s.types = "ab"; }));
m("types-empty-string", modified((_, s) => { s.types = ""; }));
m("type-null", modified((_, _s, t) => { t.push(null); }));
m("type-number", modified((_, _s, t) => { t.push(1); }));
m("type-no-name", modified((_, _s, t) => { t.push({ kind: "OBJECT" }); }));
m("type-empty-name", modified((_, _s, t) => { t.push({ kind: "OBJECT", name: "" }); }));
m("fields-object", modified((_, _s, t) => { t[0].fields = {}; }));
m("fields-string", modified((_, _s, t) => { t[0].fields = "x"; }));
m("fields-empty-string", modified((_, _s, t) => { t[0].fields = ""; }));
m("fields-element-null", modified((_, _s, t) => { t[0].fields.push(null); }));
m("field-no-type", modified((_, _s, t) => { delete t[0].fields[0].type; }));
m("field-type-no-name", modified((_, _s, t) => { t[0].fields[0].type = { kind: "SCALAR" }; }));
m("field-type-unknown", modified((_, _s, t) => { t[0].fields[0].type = { kind: "SCALAR", name: "Missing" }; }));
m("field-type-number-name", modified((_, _s, t) => { t[0].fields[0].type = { kind: "SCALAR", name: 7 }; }));
m("field-type-kind-object", modified((_, _s, t) => { t[0].fields[0].type = { kind: { a: 1 }, ofType: null }; }));
m("field-no-args", modified((_, _s, t) => { delete t[0].fields[0].args; }));
m("field-args-null", modified((_, _s, t) => { t[0].fields[0].args = null; }));
m("field-args-number", modified((_, _s, t) => { t[0].fields[0].args = 3; }));
m("field-arg-null", modified((_, _s, t) => { t[0].fields[0].args = [null]; }));
m("field-arg-no-type", modified((_, _s, t) => { t[0].fields[0].args = [{ name: "x" }]; }));
m("field-arg-unknown-type", modified((_, _s, t) => { t[0].fields[0].args = [{ name: "x", type: { name: "Nope" } }]; }));
m("interfaces-object", modified((_, _s, t) => { t[2].interfaces = {}; }));
m("interfaces-element-null", modified((_, _s, t) => { t[2].interfaces = [null]; }));
m("interfaces-unknown", modified((_, _s, t) => { t[2].interfaces = [{ kind: "INTERFACE", name: "Nope" }]; }));
m("possible-types-unknown", modified((_, _s, t) => { t[2].possibleTypes = [{ kind: "OBJECT", name: "Nope" }]; }));
m("input-fields-element-null", modified((_, _s, t) => { t[2].inputFields = [null]; }));
m("enum-values-element-null", modified((_, _s, t) => { t[2].enumValues = [null]; }));
m("enum-values-number", modified((_, _s, t) => { t[2].enumValues = 1; }));
m("mutation-type-missing", modified((_, s) => { delete s.mutationType; }));
m("mutation-type-name-null", modified((_, s) => { s.mutationType = { name: null }; }));
m("mutation-type-unknown", modified((_, s) => { s.mutationType = { name: "Nope" }; }));
m("mutation-type-string", modified((_, s) => { s.mutationType = "Query"; }));
m("mutation-type-ok", modified((_, s) => { s.mutationType = { name: "O" }; }), "mutation { x }");
m("kind-unknown", modified((_, _s, t) => { t[0].fields[0].type = { kind: "WEIRD", name: "Int" }; t[1].kind = "WEIRD"; }));
m("kind-missing", modified((_, _s, t) => { delete t[1].kind; }));
m("kind-number", modified((_, _s, t) => { t[1].kind = 3; }));
m("kind-array", modified((_, _s, t) => { t[1].kind = ["A", null, ["B"]]; }));
m("list-without-of-type", modified((_, _s, t) => { t[1].kind = "LIST"; }));
m("non-null-without-of-type", modified((_, _s, t) => { t[1].kind = "NON_NULL"; }));
m("enum-without-values", modified((_, _s, t) => { t[1].kind = "ENUM"; }));
m("enum-values", modified((_, _s, t) => { t[1].kind = "ENUM"; t[1].enumValues = [{ name: "A" }, { name: "B" }, { name: "A" }]; }));
m("enum-wrapper-without-name", modified((_, _s, t) => {
    t[0].fields[0].type = { kind: "ENUM", ofType: { kind: "SCALAR", name: "Int" }, enumValues: [{ name: "X" }] };
}));
m("input-object", modified((_, _s, t) => { t[1].kind = "INPUT_OBJECT"; }));
m("query-type-scalar", modified((_, _s, t) => { t[0].kind = "SCALAR"; }));
m("query-type-builtin", modified((_, s) => { s.queryType.name = "toString"; }));
m("query-type-proto", modified((_, s) => { s.queryType.name = "__proto__"; }));
m("field-type-builtin", modified((_, _s, t) => { t[0].fields[0].type = { kind: "SCALAR", name: "valueOf" }; }));
m("field-type-constructor", modified((_, _s, t) => { t[0].fields[1].type = { kind: "OBJECT", name: "constructor" }; }), "{ o { x } }");
m("duplicate-types", modified((_, _s, t) => {
    t.push({ kind: "OBJECT", name: "O", fields: [{ name: "y", args: [], type: { kind: "SCALAR", name: "Int" } }] });
}), "{ o { y } }");
m("duplicate-types-fields-kept", modified((_, _s, t) => { t.push({ kind: "OBJECT", name: "O" }); }), "{ o { x } }");
m("type-named-constructor", modified((_, _s, t) => {
    t.push({ kind: "OBJECT", name: "constructor", fields: [{ name: "z", args: [], type: { kind: "SCALAR", name: "Int" } }] });
    t[0].fields[1].type = { kind: "OBJECT", name: "constructor" };
}), "{ o { z } }");
m("names-are-numbers", modified((_, _s, t) => {
    t[2].name = 12;
    t[0].fields[1].type = { kind: "OBJECT", name: 12 };
}), "{ o { x } }");
m("yaml", "data:\n  __schema:\n    queryType: {name: Query}\n    mutationType: null\n    types:\n      - {kind: OBJECT, name: Query, fields: [{name: a, args: [], type: {kind: SCALAR, name: Boolean}}]}\n      - {kind: SCALAR, name: Boolean}\n");

// Where the TypeScript never terminates (an endless loop expanding a
// fragment that spreads itself): no recording; the Rust test checks its
// own error for these.
const nonTerminating = [
    { id: "nonterminating/self-spread", sources: [src("TopLevel", basic, "{ viewer { ...A } } fragment A on User { name ...A }")] },
    { id: "nonterminating/mutual-spread", sources: [src("TopLevel", basic, "{ viewer { ...A } } fragment A on User { ...B } fragment B on User { age ...A }")] },
];

// ---- Running -----------------------------------------------------------------

function schemaOf(source) {
    if (source.schemaFile !== undefined) {
        return parseJSON(readFileSync(source.schemaFile, "utf8"), "GraphQL schema", source.schemaFile);
    }
    return parseJSON(source.schemaText, "GraphQL schema", undefined);
}

function propertyLines(graph) {
    const lines = [];
    for (let i = 0; i < graph._types.length; i++) {
        const t = graph.atIndex(i)[0];
        if (t.kind === "class" || t.kind === "object") {
            const props = Array.from(t.getProperties(), ([name, p]) => [name, p.type.index, p.isOptional]);
            lines.push(`${i} properties ${JSON.stringify(props)}`);
        } else if (t.kind === "enum") {
            lines.push(`${i} cases ${JSON.stringify(Array.from(t.cases))}`);
        }
    }
    return lines;
}

function runCase(c) {
    const out = [];
    const originalLog = console.log;
    console.log = (...args) => out.push(args.join(" "));
    try {
        const input = new GraphQLInput();
        for (const source of c.sources) {
            input.addSourceSync({ name: source.name, schema: schemaOf(source), query: source.query });
        }
        const stm = getNoStringTypeMapping();
        const builder = new TypeBuilder(stm, false, false, true, false);
        builder.typeGraph = new TypeGraph(builder, 0, true);
        input.addTypesSync({}, builder);
        out.push(`# kind ${input.kind}; needIR ${input.needIR}; needSchemaProcessing ${input.needSchemaProcessing}`);
        out.push("# graph");
        const graph = builder.finish();
        graph.printGraph();
        out.push("# properties");
        out.push(...propertyLines(graph));
        out.push("# top-levels");
        for (const [name, t] of graph.topLevels) out.push(`${JSON.stringify(name)}: ${t.index}`);
    } catch (e) {
        const kind = e instanceof QuickTypeError ? "QuickTypeError" : e.name;
        out.push(`error: ${kind} ${e.message}`);
    } finally {
        console.log = originalLog;
    }
    return `${out.join("\n")}\n`;
}

const expectedDir = `${fixtureDir}/expected`;
rmSync(expectedDir, { recursive: true, force: true });
let errors = 0;
for (const c of cases) {
    const text = runCase(c);
    const file = `${expectedDir}/${c.id}.txt`;
    mkdirSync(dirname(file), { recursive: true });
    writeFileSync(file, text);
    if (/^error: /m.test(text)) errors++;
}
writeFileSync(
    `${fixtureDir}/cases.json`,
    `${JSON.stringify({ introspectionQuery: graphql.getIntrospectionQuery(), cases, nonTerminating }, null, 1)}\n`,
);
console.log(`recorded ${cases.length} cases (${errors} ending in an error)`);

// ---- Parser vectors -----------------------------------------------------------

// A seeded PRNG (mulberry32), so the vectors are stable.
function random(seed) {
    let a = seed;
    return () => {
        a = (a + 0x6d2b79f5) | 0;
        let t = Math.imul(a ^ (a >>> 15), 1 | a);
        t = (t + Math.imul(t ^ (t >>> 7), 61 | t)) ^ t;
        return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
    };
}
const kitchenSink = `
query queryName($foo: ComplexType, $site: Site = MOBILE, "desc" $x: [Int!]! = [1, 2]) @onQuery {
  whoever123is: node(id: [123, 456]) {
    id ,
    ... on User @onInlineFragment { field2 { id , alias: field1(first:10, after:$foo,) @include(if: $foo) { id, ...frag @onFragmentSpread } } }
    ... @skip(unless: $foo) { id }
    ... { id }
  }
}
mutation likeStory @onMutation { like(story: 123) @onField { story { id @onField } } }
subscription StoryLikeSubscription($input: StoryLikeSubscribeInput @onVariableDefinition) @onSubscription {
  storyLikeSubscribe(input: $input) { story { likers { count } likeSentence { text } } }
}
"""
Fragment description
"""
fragment frag on Friend @onFragmentDefinition {
  foo(size: $size, bar: $b, obj: {key: "value", block: """
      block string uses \\"""
  """})
}
{ unnamed(truthy: true, falsy: false, nullish: null, float: -1.5e-3, int: -0), query }
query { __typename }
schema @onSchema { query: QueryType mutation: MutationType }
"Description" type Foo implements Bar & Baz @onObject { one: Type "d" two(argument: InputType!): Type three(argument: InputType, other: String): Int four(argument: String = "string"): String five(argument: [String] = ["string", "string"]): String six(argument: InputType = {key: "value"}): Type seven(argument: Int = null): Type }
extend type Foo @onObject
interface Bar implements Two @onInterface { one: Type four(argument: String = "string"): String }
union Feed @onUnion = | Story | Article | Advert
extend union Feed = Photo | Video
scalar CustomScalar @onScalar
extend scalar CustomScalar @onScalar
enum Site @onEnum { DESKTOP MOBILE "d" WEB @onEnumValue }
extend enum Site { VR }
input InputType @onInputObject { key: String! answer: Int = 42 }
extend input InputType { other: Float = 1.23e4 @onInputFieldDefinition }
directive @skip(if: Boolean!) on FIELD | FRAGMENT_SPREAD | INLINE_FRAGMENT
directive @include2(if: Boolean!) repeatable on | FIELD | FRAGMENT_SPREAD | INLINE_FRAGMENT
extend schema @onSchema { subscription: SubscriptionType }
`;
const bases = [kitchenSink, sdl.basic, ...queryFiles.map((f) => readFileSync(`${inputDir}/${f}`, "utf8"))];
const fragments = [
    "{", "}", "(", ")", "[", "]", ":", "=", "@", "$", "!", "&", "|", "...", ".", "..", ",", "#x\n", "\n", "\r", "\t",
    '"', '"""', "\\", "\\u", "\\u{", "'", "on", "fragment", "query", "extend", "type", "true", "null", "0", "01",
    "1.", "1e", "-", "_a", "a1", "é", "\u{1F600}", "﻿", " ", "\u0000", "\\uD83D", "\\uDE00",
];
// [text, null] if graphql-js accepts the text, else [text, [message, position]].
function parseVector(text) {
    try {
        graphql.parse(text);
        return [text, null];
    } catch (e) {
        return [text, [e.message, e.positions?.[0] ?? null]];
    }
}
const vectors = [];
const rng = random(20261113);
const pick = (xs) => xs[Math.floor(rng() * xs.length)];
for (let i = 0; i < 2500; i++) {
    let text = pick(bases);
    const edits = 1 + Math.floor(rng() * 3);
    for (let e = 0; e < edits; e++) {
        const at = Math.floor(rng() * (text.length + 1));
        const r = rng();
        if (r < 0.35) {
            text = text.slice(0, at) + text.slice(at + 1 + Math.floor(rng() * 4));
        } else if (r < 0.8) {
            text = text.slice(0, at) + pick(fragments) + text.slice(at);
        } else if (r < 0.9) {
            text = text.slice(0, at);
        } else {
            text = text.slice(at);
        }
    }
    // A query read from a file cannot hold a lone surrogate.
    if (text.isWellFormed()) vectors.push(parseVector(text));
}
for (const base of bases) {
    const vector = parseVector(base);
    if (vector[1] !== null) throw new Error(`invalid base document: ${vector[1][0]}`);
    vectors.push(vector);
}
writeFileSync(`${fixtureDir}/parse-vectors.json`, `${JSON.stringify(vectors)}\n`);
const rejected = vectors.filter(([, o]) => o !== null).length;
console.log(`recorded ${vectors.length} parser vectors (${rejected} rejected)`);
