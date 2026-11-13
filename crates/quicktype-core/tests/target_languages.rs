//! Checks the language registry against metadata dumped from the TypeScript
//! reference (`tests/data/target_languages.json`, produced from
//! `defaultTargetLanguages` of quicktype-core at the commit in
//! `tests/golden/REFERENCE`): names, display names, extensions and every
//! renderer option declaration, including the CLI expansions.

use quicktype_core::language::all::default_target_languages;
use quicktype_core::renderer_options::{OptionKind, OptionValue};
use serde_json::{Value, json};

fn default_json(value: Option<&OptionValue>) -> Value {
    match value {
        None => Value::Null,
        Some(OptionValue::Null) => Value::Null,
        Some(OptionValue::Bool(b)) => json!(b),
        Some(OptionValue::String(s)) => json!(s),
        Some(other) => panic!("unexpected default value {other:?}"),
    }
}

#[test]
fn registry_matches_reference_metadata() {
    let text = include_str!("data/target_languages.json");
    let reference: Vec<Value> = serde_json::from_str(text).expect("valid fixture");
    let languages = default_target_languages();
    assert_eq!(languages.len(), reference.len());

    for (language, expected) in languages.iter().zip(&reference) {
        let ours = json!({
            "name": language.name(),
            "names": language.names(),
            "displayName": language.display_name(),
            "extension": language.extension(),
            "options": language.option_definitions().iter().map(|d| json!({
                "name": d.name,
                "kind": d.kind.as_str(),
                "optionType": d.option_type.as_str(),
                "description": d.description,
                "typeLabel": d.type_label,
                "defaultValue": default_json(d.default_value.as_ref()),
                "values": d.values,
            })).collect::<Vec<_>>(),
            "cliActual": language.cli_option_definitions().actual.iter()
                .map(|d| json!([d.name, default_json(d.default_value.as_ref())]))
                .collect::<Vec<_>>(),
            "cliDisplay": language.cli_option_definitions().display.iter()
                .map(|d| json!([d.name, d.description]))
                .collect::<Vec<_>>(),
        });
        assert_eq!(&ours, expected, "metadata of {}", language.name());
        assert!(
            language
                .option_definitions()
                .iter()
                .all(|d| d.kind != OptionKind::Cli),
            "renderer options are never CLI options"
        );
    }
}
