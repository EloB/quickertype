//! Translates `pluralize`'s rules and builds the automata that select
//! them (see `pluralize::Rules`) ahead of time. For each rule list it
//! writes the translated patterns, as a Rust expression
//! (`pluralize_<list>.rs`), and their dense DFA (`pluralize_<list>.dfa`).

use std::path::PathBuf;
use std::{env, fs};

use regex_automata::MatchKind;
use regex_automata::dfa::{StartKind, dense};
use regex_automata::nfa::thompson::{self, WhichCaptures};

include!("src/pluralize/rules.rs");
include!("src/pluralize/translate.rs");

fn main() {
    println!("cargo::rerun-if-changed=src/pluralize/rules.rs");
    println!("cargo::rerun-if-changed=src/pluralize/translate.rs");
    let out = PathBuf::from(env::var_os("OUT_DIR").expect("OUT_DIR"));
    // The automata are read in place, so they are written in the byte
    // order of the target, not of the machine that builds.
    let big_endian = env::var("CARGO_CFG_TARGET_ENDIAN").as_deref() == Ok("big");
    for (name, rules) in [("plural", PLURAL_RULES), ("singular", SINGULAR_RULES)] {
        let patterns = rule_patterns(rules, UNCOUNTABLE_RULES);
        let dfa = dense::Builder::new()
            .configure(
                dense::Config::new()
                    .match_kind(MatchKind::All)
                    .start_kind(StartKind::Unanchored),
            )
            .thompson(thompson::Config::new().which_captures(WhichCaptures::None))
            .build_many(&patterns)
            .unwrap_or_else(|e| panic!("the {name} rules do not build: {e}"));
        let (bytes, padding) = if big_endian {
            dfa.to_bytes_big_endian()
        } else {
            dfa.to_bytes_little_endian()
        };
        fs::write(out.join(format!("pluralize_{name}.dfa")), &bytes[padding..])
            .expect("write the automaton");
        // `{:?}` of a `str` is a Rust string literal.
        let literals: Vec<String> = patterns.iter().map(|p| format!("{p:?}")).collect();
        let built = format!("&[{}]\n", literals.join(", "));
        fs::write(out.join(format!("pluralize_{name}.rs")), built).expect("write the patterns");
    }
}
