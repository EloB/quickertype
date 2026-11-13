//! quicktype's `--help` text. Port of `usage`, `makeSectionsBeforeRenderers`,
//! `sectionsAfterRenderers`, `makeLangTypeLabel` and
//! `tableOptionsForOptions` in `src/index.ts`.

use quicktype_core::target_language::TargetLanguage;

use crate::chalk::{Chalk, TemplateError};
use crate::cli_options::make_option_definitions;
use crate::command_line_usage::{
    ColumnOptions, Content, Section, TableOptions, command_line_usage,
};
use crate::js;

/// `tableOptionsForOptions`: two fixed columns of 60.
fn table_options_for_options() -> TableOptions {
    let column = |name: &str| ColumnOptions {
        name: name.to_owned(),
        width: Some(60),
        ..ColumnOptions::default()
    };
    TableOptions {
        columns: vec![column("option"), column("description")],
        ..TableOptions::default()
    }
}

/// `makeLangTypeLabel`: the shortest name of each language, joined by `|`.
fn make_lang_type_label(target_languages: &[&'static dyn TargetLanguage]) -> String {
    target_languages
        .iter()
        .map(|language| {
            // `_.minBy` keeps the first of equally short names.
            language
                .names()
                .iter()
                .copied()
                .reduce(|best, name| {
                    if js::len(name) < js::len(best) {
                        name
                    } else {
                        best
                    }
                })
                .unwrap_or_default()
        })
        .collect::<Vec<_>>()
        .join("|")
}

fn make_sections_before_renderers(
    chalk: &Chalk,
    target_languages: &[&'static dyn TargetLanguage],
) -> Vec<Section> {
    let lang_display_names = target_languages
        .iter()
        .map(|language| language.display_name())
        .collect::<Vec<_>>()
        .join(", ");
    vec![
        Section::Content {
            header: Some("Synopsis".to_owned()),
            content: Some(Content::Lines(vec![
                format!(
                    "$ quicktype [{} LANG] [{} SRC_LANG] [{} FILE] FILE|URL ...",
                    chalk.bold("--lang"),
                    chalk.bold("--src-lang"),
                    chalk.bold("--out"),
                ),
                String::new(),
                format!("  LANG ... {}", make_lang_type_label(target_languages)),
                String::new(),
                "SRC_LANG ... json|schema|graphql|postman|typescript".to_owned(),
            ])),
        },
        Section::Content {
            header: Some("Description".to_owned()),
            content: Some(Content::Text(format!(
                "Given JSON sample data, quicktype outputs code for working with that data in {lang_display_names}."
            ))),
        },
        Section::OptionList {
            header: Some("Options".to_owned()),
            options: make_option_definitions(target_languages),
            hide: vec!["no-render".to_owned(), "build-markov-chain".to_owned()],
            table_options: Some(table_options_for_options()),
        },
    ]
}

fn sections_after_renderers(chalk: &Chalk) -> Vec<Section> {
    vec![
        Section::Content {
            header: Some("Examples".to_owned()),
            content: Some(Content::Lines(vec![
                chalk.dim("Generate C# to parse a Bitcoin API"),
                "$ quicktype -o LatestBlock.cs https://blockchain.info/latestblock".to_owned(),
                String::new(),
                chalk.dim("Generate Go code from a directory of samples containing:"),
                chalk.dim(
                    "  - Foo.json\n  + Bar\n    - bar-sample-1.json\n    - bar-sample-2.json\n  - Baz.url",
                ),
                "$ quicktype -l go samples".to_owned(),
                String::new(),
                chalk.dim("Generate JSON Schema, then TypeScript"),
                "$ quicktype -o schema.json https://blockchain.info/latestblock".to_owned(),
                "$ quicktype -o bitcoin.ts --src-lang schema schema.json".to_owned(),
            ])),
        },
        Section::Content {
            header: None,
            content: Some(Content::Text(format!(
                "Learn more at {}",
                chalk.bold("quicktype.io")
            ))),
        },
    ]
}

/// The usage guide for `target_languages` (TS `usage`, minus the
/// `console.log`): the global options, then one section per language that
/// has options. Fails like command-line-usage on an invalid chalk template.
pub fn usage(
    chalk: &Chalk,
    target_languages: &[&'static dyn TargetLanguage],
) -> Result<String, TemplateError> {
    let mut sections = make_sections_before_renderers(chalk, target_languages);
    for language in target_languages {
        let definitions = language.cli_option_definitions().display;
        if definitions.is_empty() {
            continue;
        }
        sections.push(Section::OptionList {
            header: Some(format!("Options for {}", language.display_name())),
            options: definitions,
            hide: vec![],
            table_options: Some(table_options_for_options()),
        });
    }
    sections.extend(sections_after_renderers(chalk));
    command_line_usage(chalk, &sections)
}
