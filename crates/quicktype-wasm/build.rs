//! Gives the WebAssembly module a larger stack than wasm-ld's 1 MiB
//! default: the engine recurses once per nesting level of the input (as the
//! TypeScript does), and JSON nested a few hundred levels deep must not
//! trap where Node succeeds.

fn main() {
    if std::env::var("CARGO_CFG_TARGET_ARCH").as_deref() == Ok("wasm32") {
        println!("cargo:rustc-link-arg-cdylib=-zstack-size=16777216");
    }
}
