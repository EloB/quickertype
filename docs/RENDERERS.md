# Porting a renderer

How to port one `packages/quicktype-core/src/language/<Lang>/` directory.
The framework (`Source`, `Renderer`, `ConvenienceRenderer`, `Naming`,
`DeclarationIR`, `GatherNames`) is ported and frozen; a language package
touches only its own `crates/quicktype-core/src/language/<lang>/` files. The
Rust renderer (`language/rust/`) is the reference port; read it next to
`RustRenderer.ts` before starting.

## The shape

```
TargetLanguage::render(ctx, options, filename, alphabetize)   // TS makeRenderer + render
  └─ RustRenderer::new(self, ctx, RustOptions::parse(options)?)
       └─ render_with(renderer, filename, alphabetize)         // setAlphabetizeProperties + render
            set_up_naming → assign_names → process_graph → emit_source_structure → finish_file
TargetLanguage::render_graph_and_serialize(...)                // TS renderGraphAndSerialize (shared)
```

A renderer is a struct that owns a `ConvenienceRendererCore<'a>` (the fields
of TS `Renderer` and `ConvenienceRenderer`), its parsed options and its own
state, and implements two traits from `convenience_renderer`:

| Trait | What | TS counterpart |
|---|---|---|
| `ConvenienceRenderer<'a>` | the **hooks**: every method a subclass may override. Abstract ones are required; the rest default to `defaults::<name>(self, ...)`. | the `protected` methods subclasses override |
| `ConvenienceRendererExt<'a>` | the **machinery**: `emit_line`, `indent`, `for_each_*`, `name_for_*`, naming setup, `render`. Implemented for every renderer, cannot be overridden. | everything else on `Renderer`/`ConvenienceRenderer` |

`use crate::convenience_renderer::prelude::*;` brings both traits, `Source`,
`sl!`, `Name`, `Namer`, `TypeRef`, `TypeKind`, `BlankLinePosition`, `Result`
and friends into scope.

**`super.x(...)` becomes `defaults::x(self, ...)`.** For example a Go-style
`makeNameForEnumCase` override that falls back to the base class:

```rust
fn make_name_for_enum_case(&mut self, e: TypeRef, enum_name: Name, case: &str,
                           assigned: Option<&str>) -> Result<Name> {
    if !self.options.enum_type_name_suffix {
        return defaults::make_name_for_enum_case(self, e, enum_name, case, assigned);
    }
    // ... DependencyName variant
}
```

If you need to override something that is on `ConvenienceRendererExt`, the
TypeScript overrode a method we believed final: move it into
`ConvenienceRenderer` (with a `defaults` function) in a separate,
framework-labelled commit and tell the core owner.

## Files and steps

1. `language.rs` (already declares names and options): add the renderer
   hook inside the `TargetLanguage` impl, and the TS enums of option values
   (`IntegerType` in Rust's case):

   ```rust
   fn render(&self, render_context: RenderContext<'_>, renderer_options: &RendererOptions,
             given_output_filename: &str, alphabetize_properties: bool) -> Result<RenderResult> {
       let options = RustOptions::parse(renderer_options)?;              // getOptionValues
       let renderer = RustRenderer::new(self, render_context, options);  // new RustRenderer(...)
       render_with(renderer, given_output_filename, alphabetize_properties)
   }
   ```

   Also override `default_indentation` (Go: `"\t"`, Crystal/Elixir/Ruby:
   two spaces) and `supports_full_object_type` (TypeScript, Flow,
   JavaScript, JSON Schema: `true`) if the TS class does.
2. `constants.ts` → `constants.rs`: keyword lists as `pub const X: [&str; N]`,
   comments kept.
3. `utils.ts` → `utils.rs`: name styles, legalizers, escapers. Use
   `support::strings` (every helper is there, with JS semantics) and
   `quicktype_js_compat` (`utf16`, `json::quote` for `JSON.stringify` of a
   string, `number::to_string` for `${n}`, `sort`).
4. `<Lang>Renderer.ts` → `<lang>_renderer.rs`: an options struct with a
   `parse` that reads the options **in declaration order** (the first bad
   enum value is the error), the renderer struct, an inherent `impl` for
   the private/protected helpers, and `impl ConvenienceRenderer` for the
   hooks.

## TypeScript → Rust cheat sheet

| TypeScript | Rust |
|---|---|
| `class XRenderer extends ConvenienceRenderer` | `struct XRenderer<'a> { core: ConvenienceRendererCore<'a>, options: XOptions, ... }` + `impl<'a> ConvenienceRenderer<'a> for XRenderer<'a>` |
| `private readonly _options: OptionValues<typeof xOptions>` | `options: XOptions` (plain struct of enums/bools/strings) |
| module-level `const fooNamer = funPrefixNamer(...)` | a `Namer` field created in `new()`, returned with `.clone()` (namer **identity** decides naming groups) |
| a namer created inside a hook (`new Namer(...)` per call) | `Namer::new(...)` inside the hook: a fresh identity per call, as in TS |
| `this.typeGraph`, `this.targetLanguage`, `this.leadingComments` | `self.type_graph()`, `self.target_language()`, `self.leading_comments()` |
| `t.kind`, `t.getCombinedName()`, `c.getProperties()` | `graph.kind(t)?`, `graph.combined_name(t)?`, `graph.type_at(c)?.properties()?` |
| `matchType(t, any => ..., ...)` | `match graph.kind(t)? { TypeKind::Any => ..., ..., kind => return type_not_supported(kind) }` |
| `nullableFromUnion(u)`, `removeNullFromUnion(u)` | `ty::type_utils::nullable_from_union(graph, u)?`, `remove_null_from_union(graph, u, NullRemovalSort::None)?` |
| `this.emitLine("a ", name, " {")` | `self.emit_line(sl!["a ", name, " {"])` (keep the parts; see [Item identity](#item-identity-emitlineonce-emititemonce)) |
| `this.emitLine(x)` (one part) | `self.emit_line(x)` |
| `this.emitLine(["x"])` (one array part) | `self.emit_line(sl!["x"])` |
| `this.emitLine()` | `self.emit_line_parts(vec![])` |
| `this.emitLineOnce(...parts)` | `self.emit_line_once(vec![...])` |
| Sourcelike value `["Vec<", t, ">"]` | `sl!["Vec<", t, ">"]` (a `Source::Sequence`, even with one part) |
| `this.forEachUniqueUnion(cfg, u => key, f)` | `self.for_each_unique_union(cfg, \|r, u\| Ok(key), f)?`; the key type implements `SameValueZeroKey` (see below) |
| `this.indent(() => { ... })` | `self.indent(\|r\| { ...; Ok(()) })?` |
| `this.forEachClassProperty(c, "none", (name, json, p) => ...)` | `self.for_each_class_property(c, BlankLinePosition::None, \|r, name, json, p, _pos\| { ...; Ok(()) })?` |
| `"leading-and-interposing"`, `["interposing", 2]` | `BlankLinePosition::LeadingAndInterposing`, `(BlankLinePosition::Interposing, 2)` |
| `this.ensureBlankLine()` / `(n)` | `self.ensure_blank_line()` / `self.ensure_blank_lines(n)` |
| `new SimpleName([a, b], namer, order)` | `self.naming_mut().simple_name([a, b], &namer, order)` |
| `new DependencyName(namer, order, lookup => \`${lookup(n)}_x\`)` | `self.naming_mut().dependency_name(Some(&namer), order, move \|lookup\| format!("{}_x", lookup(n)))` |
| `new FixedName("x")` | `self.naming_mut().fixed_name("x")` |
| `{ names: [className, "foo"], includeGlobalForbidden: true }` | `ForbiddenWordsInfo { names: vec![class_name.into(), "foo".into()], include_global_forbidden: true }` |
| `this.sourcelikeToString(sl)` | `self.sourcelike_to_string(&sl)?` |
| `modifySource(capitalize, name)` | `modify_source(capitalize, name)` |
| `maybeAnnotated(withIssues, anyTypeIssueAnnotation, "x")` | `maybe_annotated(with_issues, any_type_issue_annotation(), "x")` |
| `this.descriptionForType(t)` + `emitDescription` | `let d = self.description_for_type(t)?; self.emit_description(d)?;` |
| `get commentLineStart() { return "# "; }` | `fn comment_line_start(&self) -> &'static str { "# " }` |
| `assert(...)`, `defined(x)`, `panic("...")` | `support::support::{assert, defined, panic}`, all return `Result` |
| `${someNumber}` | `quicktype_js_compat::number::to_string(n)` |

### Callbacks and the borrow checker

- Every callback gets the renderer as its first argument (`|r, ...|`) and
  returns `Result<()>`; use `r`, never `self`, inside it.
- Compute values *before* emitting when they need `&self` and the emit needs
  `&mut self`: `let rust_type = r.break_cycle(t, true)?; r.emit_line(sl![..., rust_type, ...]);`.
- Helpers that only read (type expressions, names, descriptions) take
  `&self` and return `Result<Source>`; emitters take `&mut self`.
- Iteration helpers collect their items first, so the callback may emit
  freely.

### Item identity (`emitLineOnce`, `emitItemOnce`)

`emitLineOnce`/`emitItemOnce` skip an item that is already in the file,
comparing with JavaScript `===`, and the port reproduces that exactly:

- a **string** item (`emit_line("x")`, `emit_line(format!(...))`,
  `emit_line_once(vec!["x".into()])`) equals an earlier string item with the
  same text;
- a **`Name`** item equals the same name;
- an **array** (`sl![...]`, with any number of parts, or several parts to
  `emit_line_parts`/`emit_line_once`) and every other source object equals
  nothing, so it is always emitted.

So port the *shape* of each TS argument, not just its text. TS
`emitLine(["import \"fmt\""])` is `emit_line(sl!["import \"fmt\""])`, not
`emit_line("import \"fmt\"")`: a later `emitLineOnce("import \"fmt\"")`
emits again after the array but not after the string. Likewise, don't
collapse a multi-part TS `emitLine("a", b, "c")` into
`emit_line(format!("a{b}c"))` in a file that uses `emitLineOnce` or
`emitItemOnce`: the array becomes a string that a later once-call would
match. (`sl!` also keeps `Name`s as names, which `format!` cannot.)

### JavaScript `Map` keys (`forEachUniqueUnion`)

`forEachUniqueUnion` deduplicates unions by a computed value with
JavaScript `Map` semantics (SameValueZero): the value's type implements
`SameValueZeroKey`. `String`, `&str`, numbers and `bool` compare by value,
a `Name` by identity, and a value that stands for a fresh TS array or
object must be wrapped in `JsObject(...)`, which equals nothing (each union
is then its own key). Use `support::collection_utils::first_by_same_value_zero`
for other `if (!map.has(k)) map.set(k, v)` patterns.

### Union member names (`proposeUnionMemberName`)

TS proposers are closures over the renderer. In Rust,
`propose_union_member_name` returns a `Proposer` built eagerly: it resolves
the names it needs (e.g. `self.name_for_named_type(class)?`) when it is
created and captures them by value. To post-process the default (CJSON,
Elm, Haskell), wrap it:

```rust
fn propose_union_member_name(&mut self, u: TypeRef, union_name: Name, t: TypeRef) -> Result<Proposer> {
    let base = defaults::propose_union_member_name(self, u, union_name, t)?;
    Ok(Rc::new(move |lookup| format!("{}_in_{}", base(lookup), lookup(union_name))))
}
```

### Recursive type functions (`support::recursion::guard`)

A function that recurses into a type's children (`csType`, `sourceFor`,
`rustType`, a `needTransformerForType`, ...) runs forever on a graph that
cycles without passing a named type, e.g. a nullable union whose member is
an array of the union itself (`{"type": ["array", "null"], "items":
{"$ref": "#"}}`). TypeScript then throws V8's `RangeError: Maximum call
stack size exceeded`; the same Rust recursion would overflow the native
stack and abort. So wrap the body of every such function in
`support::recursion::guard`, which fails with that `RangeError` past a fixed
depth and grows the native stack until then:

```rust
fn cs_type(&self, t: TypeRef, follow: Follow, with_issues: bool) -> Result<Source> {
    // Endless on a cycle through a nullable union (V8 overflows its stack).
    guard(|| {
        // ... the body, recursing into cs_type
    })
}
```

The `recursion-overflow` render scenario records the reference's error for
C# and Pike; add your language's renders to it.

### Mid-level base classes

Families (JavaScript → TypeScriptFlowBase → TypeScript/Flow, CSharp →
Newtonsoft/SystemTextJson, Java → Jackson, Kotlin → Klaxon/Jackson/KotlinX,
Scala3 → Circe/Upickle, Python → JSONPython) forward **every**
`ConvenienceRenderer` hook mechanically, so no level can forget one:

- **State.** The base class's fields become a state struct
  (`JavaScriptState`) that every leaf owns next to its
  `ConvenienceRendererCore`.
- **Family methods.** The base class's own methods (not hooks) become a
  family trait with default bodies:
  `trait JavaScriptRenderer<'a>: ConvenienceRenderer<'a> { fn js(&self) -> &JavaScriptState; fn emit_types(&mut self) -> Result<()> { ... } }`.
  Leaves override them in their `impl JavaScriptRenderer`.
- **Hooks.** Each level has a *hooks module* with one function per hook,
  named like the hook, taking the renderer first. It glob-imports the level
  above and defines only what this level overrides; an explicit item
  shadows the glob, so the module always has every hook:

  ```rust
  // language/javascript/java_script_renderer.rs
  pub mod javascript_hooks {
      pub use crate::convenience_renderer::defaults::*;   // everything else
      pub fn make_name_for_property<'a, R: JavaScriptRenderer<'a>>(r: &mut R, o: TypeRef,
          class_name: Name, p: &ClassProperty, json_name: &str, _assigned: Option<&str>)
          -> Result<Option<Name>> {
          // JS ignores assigned names: `super.makeNameForProperty(o, className, p, jsonName, undefined)`
          crate::convenience_renderer::defaults::make_name_for_property(r, o, class_name, p, json_name, None)
      }
      pub fn emit_source_structure<'a, R: JavaScriptRenderer<'a>>(r: &mut R, f: &str) -> Result<()> { ... }
      // ... the abstract hooks (namers) and the other overrides
  }

  // language/typescript_flow/typescript_renderer.rs
  mod typescript_hooks {
      pub use crate::language::typescript_flow::typescript_flow_base_hooks::*;
      // TypeScriptRenderer's own hook overrides, e.g. calling `super`:
      // crate::language::typescript_flow::typescript_flow_base_hooks::x(r, ...)
  }

  impl<'a> ConvenienceRenderer<'a> for TypeScriptRenderer<'a> {
      fn core(&self) -> &ConvenienceRendererCore<'a> { &self.core }
      fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> { &mut self.core }
      forward_convenience_renderer_hooks!(typescript_hooks);
  }
  ```

`forward_convenience_renderer_hooks!(module)` implements every hook of the
trait as a call to `module::<hook>(self, ...)`; it is generated from the same
hook list as the trait itself, so it cannot miss one. `module` must be a
single identifier in scope (`use ... as hooks;` if needed). A required
(abstract) hook that no level defines is a compile error, as is overriding a
hook in the `impl` next to the macro: in a family, every hook override is a
function in the leaf's hooks module. `super.x()` is a call to the level
above by path (`<family>_hooks::x(r, ...)`, or `defaults::x(r, ...)` at the
top). The test `convenience_renderer::family_tests` is a complete two-level
example.

## Testing a port

No Node is needed to run the tests; Node (with a built `../quicktype`) is
needed only to record fixtures.

1. **Record render cases** for your language: it runs the reference CLI on
   every golden case of the language, dumps the type graph that reaches
   name gathering, and checks the intercepted render against the golden
   files:

   ```sh
   node xtask/core-rendering/record-render-cases.mjs ../quicktype go
   RENDER_CASES_FILTER=golang cargo test -p quicktype-core --test render_cases
   ```

   `render_cases.rs` rebuilds each graph, runs `gather_names` and your
   renderer, and compares every file and (without `--quiet`) the issue
   annotations. This tests the renderer in isolation, before the JSON input
   and pipeline are wired end to end. Graphs with `transformation`
   attributes (C#, Python) are dumped too.
2. **Scenarios** for options and paths the corpus doesn't cover: add a
   `.txt` to `crates/quicktype-core/tests/fixtures/core-rendering/scenarios/`
   with `input json|schema NAME <json>` lines and `render <lang> {"rendererOptions": {...}}`
   lines, then `node xtask/core-rendering/run-render-scenarios.mjs ../quicktype`
   and `cargo test -p quicktype-core --test render_scenarios`.
3. `cargo xtask parity` once the CLI generates code (Phase 3).

## Worked example: `RustRenderer`

TypeScript (`RustRenderer.ts`):

```ts
protected namerForObjectProperty(): Namer | null { return snakeNamingFunction; }

protected forbiddenForObjectProperties(_c: ClassType, _className: Name): ForbiddenWordsInfo {
    return { names: [], includeGlobalForbidden: true };
}

private breakCycle(t: Type, withIssues: boolean): Sourcelike {
    const rustType = this.rustType(t, withIssues);
    const isCycleBreaker = this.isCycleBreakerType(t);
    if (isCycleBreaker && t instanceof UnionType) {
        const nullable = nullableFromUnion(t);
        if (nullable === null || this.isCycleBreakerType(nullable)) return rustType;
    }
    return isCycleBreaker ? ["Box<", rustType, ">"] : rustType;
}

protected emitStructDefinition(c: ClassType, className: Name): void {
    this.emitDescription(this.descriptionForType(c));
    // ...
    const blankLines = this._options.density === Density.Dense ? "none" : "interposing";
    const structBody = (): void =>
        this.forEachClassProperty(c, blankLines, (name, jsonName, prop) => {
            this.emitDescription(this.descriptionForClassProperty(c, jsonName));
            this.emitRenameAttribute(name, jsonName, defaultStyle, preferedNamingStyle);
            if (this._options.skipSerializingNone) this.emitSkipSerializeNone(prop.type);
            this.emitLine(this.visibility, name, ": ", this.breakCycle(prop.type, true), ",");
        });
    this.emitBlock(["pub struct ", className], structBody);
}
```

Rust (`rust_renderer.rs`):

```rust
// hooks: impl<'a> ConvenienceRenderer<'a> for RustRenderer<'a>
fn namer_for_object_property(&mut self, _o: TypeRef, _p: &ClassProperty) -> Result<Option<Namer>> {
    Ok(Some(self.snake_naming_function.clone()))
}

fn forbidden_for_object_properties(&mut self, _c: TypeRef, _class_name: Name)
    -> Result<ForbiddenWordsInfo> {
    Ok(ForbiddenWordsInfo { names: Vec::new(), include_global_forbidden: true })
}

// helpers: impl<'a> RustRenderer<'a>
fn break_cycle(&self, t: TypeRef, with_issues: bool) -> Result<Source> {
    let rust_type = self.rust_type(t, with_issues)?;
    let is_cycle_breaker = self.is_cycle_breaker_type(t)?;
    if is_cycle_breaker && self.type_graph().type_at(t)?.is_union() {
        match nullable_from_union(self.type_graph(), t)? {
            None => return Ok(rust_type),
            Some(nullable) if self.is_cycle_breaker_type(nullable)? => return Ok(rust_type),
            Some(_) => {}
        }
    }
    Ok(if is_cycle_breaker { sl!["Box<", rust_type, ">"] } else { rust_type })
}

fn emit_struct_definition(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
    let description = self.description_for_type(c)?;
    self.emit_description(description)?;
    // ...
    let blank_lines = self.blank_lines();
    self.emit_block(sl!["pub struct ", class_name], |r| {
        r.for_each_class_property(c, blank_lines, |r, name, json_name, prop, _| {
            let description = r.description_for_class_property(c, json_name)?;
            r.emit_description(description)?;
            r.emit_rename_attribute(name, json_name, default_style, prefered_naming_style)?;
            if r.options.skip_serializing_none {
                r.emit_skip_serialize_none(prop.type_ref)?;
            }
            let rust_type = r.break_cycle(prop.type_ref, true)?;
            let visibility = r.visibility();
            r.emit_line(sl![visibility, name, ": ", rust_type, ","]);
            Ok(())
        })
    })
}
```

Points to notice: `snakeNamingFunction` (a module singleton) became a field
so that every property shares one namer; `this` inside the closure became
`r`; the type expression is computed before `emit_line`; every fallible
step ends in `?`.

## Framework behaviors worth knowing

- Names are assigned before `emit_source_structure` runs; any `Name` can be
  emitted, and `sourcelike_to_string` resolves them.
- Property names are created in sorted JSON-name order (that is their
  priority); `for_each_class_property` iterates in property order, or
  alphabetically by assigned name with `--alphabetize-properties`.
- A renderer never stores names in the graph (TypeScript does, in the
  attribute store), so a graph can be rendered more than once.
- `emit_line_once`/`emit_item_once` only deduplicate string items (by
  value) and names (by identity); see [Item identity](#item-identity-emitlineonce-emititemonce).
- Blank lines requested at the end of a file never appear; `emit_line("")`
  inside an indent produces an indentation-only line.
- `finish_file` twice with the same name prints the `[WARNING] ...` line on
  stdout via `console_log`, as TypeScript does.
