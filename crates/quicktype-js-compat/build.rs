//! Translates `pluralize`'s rules and builds the automata that select
//! them (see `pluralize::Rules`) ahead of time. For each rule list it
//! writes the dense DFA (`pluralize_<list>.dfa`) and, as a Rust expression
//! (`pluralize_<list>.rs`), the hash of the rule tables it read and the
//! translated patterns.

use std::path::PathBuf;
use std::{env, fs};

use regex_automata::MatchKind;
use regex_automata::dfa::{StartKind, dense};
use regex_automata::nfa::thompson::{self, WhichCaptures};

include!("src/pluralize/rules.rs");
include!("src/pluralize/translate.rs");

fn main() {
    // `seeded_foldhash`: `hash::SeededState` is foldhash with the seeds of
    // `hash::seeded`, on every target but native builds with `siphash`
    // (std's SipHash). One predicate for the module's every `cfg`.
    println!("cargo::rustc-check-cfg=cfg(seeded_foldhash)");
    let siphash = env::var_os("CARGO_FEATURE_SIPHASH").is_some();
    let wasm32 = env::var("CARGO_CFG_TARGET_ARCH").as_deref() == Ok("wasm32");
    if !siphash || wasm32 {
        println!("cargo::rustc-cfg=seeded_foldhash");
    }
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
                // Minimized, the DFAs are 3% smaller and load as fast.
                dense::Config::new()
                    .match_kind(MatchKind::All)
                    .start_kind(StartKind::Unanchored)
                    .minimize(true),
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
        let built = format!(
            "({:#018x}, &[{}])\n",
            rules_hash(rules, UNCOUNTABLE_RULES),
            literals.join(", ")
        );
        fs::write(out.join(format!("pluralize_{name}.rs")), built).expect("write the patterns");
    }
}
