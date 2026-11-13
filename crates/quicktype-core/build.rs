//! Decodes the shipped Markov chain ahead of time (see
//! `markov_chain::shared`), with the decoder the crate itself uses.

use std::path::PathBuf;
use std::{env, fs};

include!("src/markov_chain/decode.rs");

fn main() {
    println!("cargo::rerun-if-changed=src/markov_chain/decode.rs");
    println!("cargo::rerun-if-changed=src/encoded_markov_chain.txt");
    let encoded =
        fs::read_to_string("src/encoded_markov_chain.txt").expect("src/encoded_markov_chain.txt");
    let (codes, probabilities) = decode(encoded.trim_end()).expect("the Markov chain decodes");
    let out = PathBuf::from(env::var_os("OUT_DIR").expect("OUT_DIR"));
    fs::write(out.join("markov_chain_codes.bin"), codes).expect("write the codes");
    let probabilities: Vec<String> = probabilities
        .iter()
        .map(|p| format!("f32::from_bits({:#010x})", p.to_bits()))
        .collect();
    fs::write(
        out.join("markov_chain_probabilities.rs"),
        format!("[{}]\n", probabilities.join(", ")),
    )
    .expect("write the probabilities");
}
