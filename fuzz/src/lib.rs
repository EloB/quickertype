//! Helpers shared by the fuzz targets.

use std::collections::HashMap;
use std::io::Read;

use quicktype_core::input::io::LocalBoxFuture;
use quicktype_core::messages::JsErrorName;
use quicktype_core::{
    HttpResponse, InferenceFlags, Io, IoError, IoErrorKind, OptionType, OptionValue, Options,
    RendererOptions, TargetLanguage, default_target_languages,
};

/// What the header of a pipeline input asks for: the target language,
/// the run options and the renderer options.
pub struct RunConfig {
    /// The target language.
    pub lang: &'static dyn TargetLanguage,
    /// The flag byte; bits 0, 1, 4, 6 and 7 are read by [`apply`](Self::apply),
    /// bits 2, 3 and 5 are the target's own.
    pub flags: u8,
    /// The inference flags.
    pub inference_flags: InferenceFlags,
    /// The renderer options.
    pub renderer_options: RendererOptions,
}

impl RunConfig {
    /// Reads a header from the start of `data`:
    ///
    /// - byte 0: the target language (an index into the built-in ones);
    /// - byte 1: flags: bit 0 `alphabetizeProperties`, bit 1
    ///   `allPropertiesOptional`, bit 4 `fixedTopLevels`, bit 6 indentation
    ///   with a tab, bit 7 an output file name with the language's
    ///   extension; the others are the target's;
    /// - byte 2: inference flags to turn off, one bit each, in
    ///   [`InferenceFlags`] field order;
    /// - byte 3: `n`, the number of renderer options (modulo 8), followed by
    ///   `n` pairs of bytes: an option (an index into the language's option
    ///   definitions) and its value (see [`option_value`]).
    ///
    /// Returns the configuration and the rest of `data`.
    pub fn read(data: &[u8]) -> Option<(RunConfig, &[u8])> {
        let [lang, flags, inference_off, n, rest @ ..] = data else {
            return None;
        };
        let languages = default_target_languages();
        let lang = languages[*lang as usize % languages.len()];
        let n = (*n % 8) as usize;
        if rest.len() < 2 * n {
            return None;
        }
        let (pairs, body) = rest.split_at(2 * n);
        let definitions = lang.option_definitions();
        let mut renderer_options = RendererOptions::new();
        if !definitions.is_empty() {
            for [option, value] in pairs.as_chunks::<2>().0 {
                let definition = &definitions[*option as usize % definitions.len()];
                renderer_options.set(
                    definition.name.clone().into_owned(),
                    option_value(definition.option_type, definition.values, *value),
                );
            }
        }
        let off = |bit: u8| inference_off & (1 << bit) != 0;
        let mut inference_flags = InferenceFlags::default();
        inference_flags.infer_maps = !off(0);
        inference_flags.infer_enums = !off(1);
        inference_flags.infer_uuids = !off(2);
        inference_flags.infer_date_times = !off(3);
        inference_flags.infer_integer_strings = !off(4);
        inference_flags.infer_boolean_strings = !off(5);
        inference_flags.combine_classes = !off(6);
        inference_flags.ignore_json_refs = !off(7);
        Some((
            RunConfig {
                lang,
                flags: *flags,
                inference_flags,
                renderer_options,
            },
            body,
        ))
    }

    /// The options for a run on `input_data` with this configuration.
    pub fn apply<'a>(&self, options: Options<'a>) -> Options<'a> {
        let flag = |bit: u8| self.flags & (1 << bit) != 0;
        let mut options = options
            .with_inference_flags(self.inference_flags)
            .with_alphabetize_properties(flag(0))
            .with_all_properties_optional(flag(1))
            .with_fixed_top_levels(flag(4))
            .with_renderer_options(self.renderer_options.clone());
        if flag(6) {
            options = options.with_indentation(Some("\t".to_owned()));
        }
        if flag(7) {
            options = options.with_output_filename(format!("TopLevel.{}", self.lang.extension()));
        }
        options
    }
}

impl RunConfig {
    /// The quicktype CLI arguments that ask for this configuration, and the
    /// settings the CLI cannot express (only the API can).
    pub fn cli_args(&self) -> (Vec<String>, Vec<String>) {
        let flag = |bit: u8| self.flags & (1 << bit) != 0;
        let mut args = vec!["--lang".to_owned(), self.lang.name().to_owned()];
        let mut api_only = Vec::new();
        for (name, value) in self.renderer_options.iter() {
            match value {
                OptionValue::Bool(true) => args.push(format!("--{name}")),
                OptionValue::Bool(false) => args.push(format!("--no-{name}")),
                OptionValue::String(s) => {
                    args.push(format!("--{name}"));
                    args.push(s.clone());
                }
                other => api_only.push(format!("{name}: {other:?}")),
            }
        }
        if flag(0) {
            args.push("--alphabetize-properties".to_owned());
        }
        if flag(1) {
            args.push("--all-properties-optional".to_owned());
        }
        let f = &self.inference_flags;
        for (on, name) in [
            (f.infer_maps, "--no-maps"),
            (f.infer_enums, "--no-enums"),
            (f.infer_uuids, "--no-uuids"),
            (f.infer_date_times, "--no-date-times"),
            (f.infer_integer_strings, "--no-integer-strings"),
            (f.infer_boolean_strings, "--no-boolean-strings"),
            (f.combine_classes, "--no-combine-classes"),
        ] {
            if !on {
                args.push(name.to_owned());
            }
        }
        if !f.ignore_json_refs {
            args.push("--no-ignore-json-refs".to_owned());
        }
        if flag(7) {
            args.push("--out".to_owned());
            args.push(format!("TopLevel.{}", self.lang.extension()));
        }
        if flag(4) {
            api_only.push("fixedTopLevels: true".to_owned());
        }
        if flag(6) {
            api_only.push("indentation: \"\\t\"".to_owned());
        }
        (args, api_only)
    }
}

/// For reproducing an input with the CLIs: with the environment variable
/// `QUICKTYPE_FUZZ_EXPLAIN` set to a directory, writes `files` there and
/// prints the quicktype command line that runs `config` on them (plus
/// `args`), and what only the API can express.
pub fn explain(config: &RunConfig, args: &[String], files: &[(String, Vec<u8>)]) {
    let Some(dir) = std::env::var_os("QUICKTYPE_FUZZ_EXPLAIN") else {
        return;
    };
    let dir = std::path::PathBuf::from(dir);
    for (name, content) in files {
        let path = dir.join(name);
        if let Some(parent) = path.parent() {
            std::fs::create_dir_all(parent).expect("create the directory");
        }
        std::fs::write(&path, content).expect("write the file");
    }
    let (mut cli, api_only) = config.cli_args();
    cli.extend(args.iter().cloned());
    let quoted: Vec<String> = cli.iter().map(|a| format!("{a:?}")).collect();
    eprintln!("cd {dir:?} && quicktype {}", quoted.join(" "));
    if !api_only.is_empty() {
        eprintln!("API only: {}", api_only.join(", "));
    }
}

/// A renderer option's value from one byte: for a boolean option
/// `true`/`false` (or, with the high bit set, one of [`STRINGS`], as the
/// JavaScript API allows); for an enum one of its values, one of
/// [`STRINGS`] or `null`; for a string option one of [`STRINGS`].
pub fn option_value(
    option_type: OptionType,
    values: Option<&'static [&'static str]>,
    byte: u8,
) -> OptionValue {
    let string = || OptionValue::String(STRINGS[byte as usize % STRINGS.len()].to_owned());
    match (option_type, values) {
        (OptionType::Boolean, _) if byte & 0x80 == 0 => OptionValue::Bool(byte & 1 != 0),
        (_, Some(values)) if !values.is_empty() => {
            let k = byte as usize % (values.len() + 2);
            if k < values.len() {
                OptionValue::String(values[k].to_owned())
            } else if k == values.len() {
                string()
            } else {
                OptionValue::Null
            }
        }
        _ => string(),
    }
}

/// An in-memory file system for [`quicktype_core::FetchingJsonSchemaStore`]:
/// files by path, no symbolic links, no standard input, no network.
pub struct MemIo {
    /// The files, by path.
    pub files: HashMap<String, String>,
}

impl Io for MemIo {
    fn is_symbolic_link(&self, _path: &str) -> Result<bool, IoError> {
        Ok(false)
    }

    fn read_link(&self, path: &str) -> Result<String, IoError> {
        Err(not_found("readlink", path))
    }

    fn exists(&self, path: &str) -> bool {
        self.files.contains_key(path)
    }

    fn read_file<'a>(&'a self, path: &'a str) -> LocalBoxFuture<'a, Result<String, IoError>> {
        let result = self
            .files
            .get(path)
            .cloned()
            .ok_or_else(|| not_found("open", path));
        Box::pin(async move { result })
    }

    fn read_stdin(&self) -> LocalBoxFuture<'_, Result<String, IoError>> {
        Box::pin(async { Ok(String::new()) })
    }

    fn fetch<'a>(
        &'a self,
        _url: &'a str,
        _headers: &'a [(String, String)],
    ) -> LocalBoxFuture<'a, Result<HttpResponse, IoError>> {
        Box::pin(async {
            Err(IoError::new(
                IoErrorKind::Network,
                JsErrorName::TypeError,
                "fetch failed",
            ))
        })
    }
}

fn not_found(syscall: &str, path: &str) -> IoError {
    IoError::new(
        IoErrorKind::NotFound,
        JsErrorName::Error,
        format!("ENOENT: no such file or directory, {syscall} '{path}'"),
    )
}

/// The pieces of `data` between `separator` bytes (at least one).
pub fn split(data: &[u8], separator: u8) -> Vec<&[u8]> {
    data.split(|&b| b == separator).collect()
}

/// `bytes` as text, with invalid UTF-8 replaced (as Node decodes it).
pub fn text(bytes: &[u8]) -> String {
    String::from_utf8_lossy(bytes).into_owned()
}

/// Splits off the first line (up to `\n`), returning it and the rest.
pub fn first_line(data: &[u8]) -> (&[u8], &[u8]) {
    match data.iter().position(|&b| b == b'\n') {
        Some(i) => (&data[..i], &data[i + 1..]),
        None => (data, &[]),
    }
}

/// A reader that hands out its bytes a few at a time (1 to 7 per read,
/// cycling), so that every token boundary falls between two reads
/// somewhere.
pub struct Trickle<'a> {
    data: &'a [u8],
    step: usize,
}

impl<'a> Trickle<'a> {
    /// A reader over `data`.
    pub fn new(data: &'a [u8]) -> Self {
        Trickle { data, step: 0 }
    }
}

impl Read for Trickle<'_> {
    fn read(&mut self, buf: &mut [u8]) -> std::io::Result<usize> {
        self.step = self.step % 7 + 1;
        let n = self.step.min(buf.len()).min(self.data.len());
        buf[..n].copy_from_slice(&self.data[..n]);
        self.data = &self.data[n..];
        Ok(n)
    }
}

/// The stack of the CLI's generation thread (`STACK_SIZE` in
/// `crates/quicktype-cli/src/main.rs`).
pub const CLI_STACK_SIZE: usize = 256 << 20;

/// Runs `f` on a thread with the CLI's stack size, as the CLI runs
/// quicktype. A panic in `f` is re-raised (and aborts the fuzzer).
pub fn on_cli_stack<T: Send + 'static>(f: impl FnOnce() -> T + Send + 'static) -> T {
    let handle = std::thread::Builder::new()
        .stack_size(CLI_STACK_SIZE)
        .spawn(f)
        .expect("spawn the generation thread");
    match handle.join() {
        Ok(value) => value,
        Err(payload) => std::panic::resume_unwind(payload),
    }
}

/// Strings that renderer options and names are worth trying with: empty,
/// identifiers, keywords, separators, numbers, non-ASCII, `$` patterns.
pub const STRINGS: &[&str] = &[
    "",
    "x",
    "Foo",
    "foo.bar",
    "Foo::Bar",
    "a b",
    "a,b, c",
    "class",
    "1",
    "0",
    "-1",
    "64",
    "1.5",
    "1e400",
    "NaN",
    "0x10",
    "99999999999999999999",
    "é",
    "日本語",
    "😀",
    "$&",
    "$'",
    "\\",
    "\"",
    "'",
    "-",
    "_",
    "...",
    "a/b",
    "\n",
    "  ",
    "toString",
    "__proto__",
    "true",
    "false",
];
