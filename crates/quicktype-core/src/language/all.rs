//! Port of `packages/quicktype-core/src/language/All.ts`.

use super::cjson::language::CJsonTargetLanguage;
use super::cplusplus::language::CPlusPlusTargetLanguage;
use super::crystal::language::CrystalTargetLanguage;
use super::csharp::language::CSharpTargetLanguage;
use super::dart::language::DartTargetLanguage;
use super::elixir::language::ElixirTargetLanguage;
use super::elm::language::ElmTargetLanguage;
use super::golang::language::GoTargetLanguage;
use super::haskell::language::HaskellTargetLanguage;
use super::java::language::JavaTargetLanguage;
use super::javascript::language::JavaScriptTargetLanguage;
use super::javascript_prop_types::language::JavaScriptPropTypesTargetLanguage;
use super::json_schema::language::JsonSchemaTargetLanguage;
use super::kotlin::language::KotlinTargetLanguage;
use super::objective_c::language::ObjectiveCTargetLanguage;
use super::php::language::PhpTargetLanguage;
use super::pike::language::PikeTargetLanguage;
use super::python::language::PythonTargetLanguage;
use super::ruby::language::RubyTargetLanguage;
use super::rust::language::RustTargetLanguage;
use super::scala3::language::Scala3TargetLanguage;
use super::smithy4s::language::SmithyTargetLanguage;
use super::swift::language::SwiftTargetLanguage;
use super::typescript_effect_schema::language::TypeScriptEffectSchemaTargetLanguage;
use super::typescript_flow::language::{FlowTargetLanguage, TypeScriptTargetLanguage};
use super::typescript_zod::language::TypeScriptZodTargetLanguage;
use crate::target_language::TargetLanguage;

/// Every built-in target language, in quicktype's order (TS `all`, exported
/// as `defaultTargetLanguages`). The order is visible in `--help`.
pub static ALL: [&dyn TargetLanguage; 27] = [
    &CJsonTargetLanguage,
    &CPlusPlusTargetLanguage,
    &CrystalTargetLanguage,
    &CSharpTargetLanguage,
    &DartTargetLanguage,
    &ElixirTargetLanguage,
    &ElmTargetLanguage,
    &FlowTargetLanguage,
    &GoTargetLanguage,
    &HaskellTargetLanguage,
    &JavaTargetLanguage,
    &JavaScriptTargetLanguage,
    &JavaScriptPropTypesTargetLanguage,
    &JsonSchemaTargetLanguage,
    &KotlinTargetLanguage,
    &ObjectiveCTargetLanguage,
    &PhpTargetLanguage,
    &PikeTargetLanguage,
    &PythonTargetLanguage,
    &RubyTargetLanguage,
    &RustTargetLanguage,
    &Scala3TargetLanguage,
    &SmithyTargetLanguage,
    &SwiftTargetLanguage,
    &TypeScriptTargetLanguage,
    &TypeScriptEffectSchemaTargetLanguage,
    &TypeScriptZodTargetLanguage,
];

/// Every built-in target language (TS `defaultTargetLanguages`).
pub fn default_target_languages() -> &'static [&'static dyn TargetLanguage] {
    &ALL
}

/// The first language in `target_languages` that has `name` among its
/// [`names`](TargetLanguage::names) (TS `languageNamed`, which throws where
/// this returns `None`). Names are case-sensitive.
pub fn language_named(
    name: &str,
    target_languages: &[&'static dyn TargetLanguage],
) -> Option<&'static dyn TargetLanguage> {
    target_languages
        .iter()
        .copied()
        .find(|language| language.names().contains(&name))
}

/// Whether `maybe_name` is a name of a built-in language (TS `isLanguageName`).
pub fn is_language_name(maybe_name: &str) -> bool {
    language_named(maybe_name, &ALL).is_some()
}

/// Whether `maybe_name` is the display name of a built-in language (TS
/// `isLanguageDisplayName`).
pub fn is_language_display_name(maybe_name: &str) -> bool {
    ALL.iter()
        .any(|language| language.display_name() == maybe_name)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn registry_order_and_names() {
        let names: Vec<&str> = ALL.iter().map(|l| l.name()).collect();
        assert_eq!(
            names.join(" "),
            "cjson c++ crystal cs dart elixir elm flow go haskell java javascript \
             javascript-prop-types schema kotlin objc php pike python ruby rust scala3 \
             smithy4a swift typescript typescript-effect-schema typescript-zod"
        );
    }

    #[test]
    fn lookup_by_alias() {
        assert_eq!(language_named("csharp", &ALL).map(|l| l.name()), Some("cs"));
        assert_eq!(
            language_named("cJSON", &ALL).map(|l| l.name()),
            Some("cjson")
        );
        assert!(language_named("CSharp", &ALL).is_none());
        assert!(is_language_name("json-schema"));
        assert!(!is_language_name("kt"));
        assert!(is_language_display_name("C (cJSON)"));
        assert!(!is_language_display_name("cs"));
    }

    #[test]
    fn option_counts() {
        let counts: Vec<usize> = ALL.iter().map(|l| l.options().len()).collect();
        assert_eq!(
            counts,
            [
                9, 13, 0, 15, 10, 2, 3, 13, 7, 3, 7, 5, 3, 0, 4, 5, 5, 0, 4, 3, 8, 3, 2, 18, 13, 1,
                1
            ]
        );
    }

    #[test]
    fn cli_definitions_expand_booleans() {
        let cs = language_named("cs", &ALL).expect("C# is registered");
        let defs = cs.cli_option_definitions();
        // 15 options, 6 of them boolean.
        assert_eq!(defs.display.len(), 15);
        assert_eq!(defs.actual.len(), 21);
        assert_eq!(defs.actual[7].name, "use-records");
        assert_eq!(defs.actual[8].name, "no-use-records");
        assert_eq!(defs.display[6].name, "[no-]use-records");
    }
}
