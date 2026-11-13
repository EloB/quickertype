//! Port of `packages/quicktype-core/src/language/Java/DateTimeProvider.ts`.
//!
//! How generated Java represents, imports, parses and formats dates and
//! times: `java.time` (`java8`, the default) or `java.util.Date`
//! (`legacy`). The TypeScript providers hold a reference to their renderer;
//! here the emitting methods take it as an argument.

use crate::convenience_renderer::prelude::*;

use super::java_renderer::JavaRenderer;

/// Which date-time API the generated code uses (the `datetime-provider`
/// option).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum DateTimeProviderKind {
    /// `"java8"`: `java.time` (TS `Java8DateTimeProvider`).
    Java8,
    /// `"legacy"`: `java.util.Date` (TS `JavaLegacyDateTimeProvider`).
    Legacy,
}

/// `JavaDateTimeProvider`: the date-time helpers of one render.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct JavaDateTimeProvider {
    kind: DateTimeProviderKind,
    /// `_className`: the converter class that holds the parse helpers.
    class_name: String,
}

impl JavaDateTimeProvider {
    /// `new Java8DateTimeProvider(renderer, className)` or
    /// `new JavaLegacyDateTimeProvider(renderer, className)`.
    pub fn new(kind: DateTimeProviderKind, class_name: impl Into<String>) -> Self {
        JavaDateTimeProvider {
            kind,
            class_name: class_name.into(),
        }
    }

    /// Which provider this is.
    pub fn kind(&self) -> DateTimeProviderKind {
        self.kind
    }

    /// `keywords`: names the generated code imports.
    pub fn keywords(&self) -> &'static [&'static str] {
        match self.kind {
            DateTimeProviderKind::Java8 => &[
                "LocalDate",
                "OffsetDateTime",
                "OffsetTime",
                "ZoneOffset",
                "ZonedDateTime",
                "DateTimeFormatter",
                "DateTimeFormatterBuilder",
                "ChronoField",
            ],
            DateTimeProviderKind::Legacy => &["SimpleDateFormat", "Date"],
        }
    }

    /// `dateTimeImports`.
    pub fn date_time_imports(&self) -> &'static [&'static str] {
        match self.kind {
            DateTimeProviderKind::Java8 => &["java.time.OffsetDateTime"],
            DateTimeProviderKind::Legacy => &["java.util.Date"],
        }
    }

    /// `dateImports`.
    pub fn date_imports(&self) -> &'static [&'static str] {
        match self.kind {
            DateTimeProviderKind::Java8 => &["java.time.LocalDate"],
            DateTimeProviderKind::Legacy => &["java.util.Date"],
        }
    }

    /// `timeImports`.
    pub fn time_imports(&self) -> &'static [&'static str] {
        match self.kind {
            DateTimeProviderKind::Java8 => &["java.time.OffsetTime"],
            DateTimeProviderKind::Legacy => &["java.util.Date"],
        }
    }

    /// `converterImports`: what `Converter.java` imports for the helpers.
    pub fn converter_imports(&self) -> &'static [&'static str] {
        match self.kind {
            DateTimeProviderKind::Java8 => &[
                "java.time.LocalDate",
                "java.time.OffsetDateTime",
                "java.time.OffsetTime",
                "java.time.ZoneOffset",
                "java.time.ZonedDateTime",
                "java.time.format.DateTimeFormatter",
                "java.time.format.DateTimeFormatterBuilder",
                "java.time.temporal.ChronoField",
            ],
            DateTimeProviderKind::Legacy => &["java.util.Date", "java.text.SimpleDateFormat"],
        }
    }

    /// `dateTimeType`.
    pub fn date_time_type(&self) -> &'static str {
        match self.kind {
            DateTimeProviderKind::Java8 => "OffsetDateTime",
            DateTimeProviderKind::Legacy => "Date",
        }
    }

    /// `dateType`.
    pub fn date_type(&self) -> &'static str {
        match self.kind {
            DateTimeProviderKind::Java8 => "LocalDate",
            DateTimeProviderKind::Legacy => "Date",
        }
    }

    /// `timeType`.
    pub fn time_type(&self) -> &'static str {
        match self.kind {
            DateTimeProviderKind::Java8 => "OffsetTime",
            DateTimeProviderKind::Legacy => "Date",
        }
    }

    /// `dateTimeJacksonAnnotations`.
    pub fn date_time_jackson_annotations(&self) -> &'static [&'static str] {
        match self.kind {
            DateTimeProviderKind::Java8 => &[],
            DateTimeProviderKind::Legacy => {
                &["@JsonFormat(pattern = \"yyyy-MM-dd'T'HH:mm:ss.SSSX\", timezone = \"UTC\")"]
            }
        }
    }

    /// `dateJacksonAnnotations`.
    pub fn date_jackson_annotations(&self) -> &'static [&'static str] {
        match self.kind {
            DateTimeProviderKind::Java8 => &[],
            DateTimeProviderKind::Legacy => &["@JsonFormat(pattern = \"yyyy-MM-dd\")"],
        }
    }

    /// `timeJacksonAnnotations`.
    pub fn time_jackson_annotations(&self) -> &'static [&'static str] {
        match self.kind {
            DateTimeProviderKind::Java8 => &[],
            DateTimeProviderKind::Legacy => {
                &["@JsonFormat(pattern = \"HH:mm:ssX\", timezone = \"UTC\")"]
            }
        }
    }

    /// `shouldEmitDateTimeConverter`.
    pub fn should_emit_date_time_converter(&self) -> bool {
        true
    }

    /// `shouldEmitTimeConverter`.
    pub fn should_emit_time_converter(&self) -> bool {
        self.kind == DateTimeProviderKind::Java8
    }

    /// `shouldEmitDateConverter`.
    pub fn should_emit_date_converter(&self) -> bool {
        self.kind == DateTimeProviderKind::Java8
    }

    /// `emitDateTimeConverters()`: the parse and format helpers inside
    /// `Converter`.
    pub fn emit_date_time_converters<'a, R: JavaRenderer<'a>>(&self, r: &mut R) -> Result<()> {
        match self.kind {
            DateTimeProviderKind::Java8 => emit_java8_converters(r),
            DateTimeProviderKind::Legacy => emit_legacy_converters(r),
        }
    }

    /// `convertStringToDateTime(variable)`.
    pub fn convert_string_to_date_time(&self, variable: impl Into<Source>) -> Source {
        let variable: Source = variable.into();
        match self.kind {
            DateTimeProviderKind::Java8 => {
                sl![
                    self.class_name.as_str(),
                    ".parseDateTimeString(",
                    variable,
                    ")"
                ]
            }
            DateTimeProviderKind::Legacy => self.parse_all(variable),
        }
    }

    /// `convertStringToTime(variable)`.
    pub fn convert_string_to_time(&self, variable: impl Into<Source>) -> Source {
        let variable: Source = variable.into();
        match self.kind {
            DateTimeProviderKind::Java8 => {
                sl![self.class_name.as_str(), ".parseTimeString(", variable, ")"]
            }
            DateTimeProviderKind::Legacy => self.parse_all(variable),
        }
    }

    /// `convertStringToDate(variable)`.
    pub fn convert_string_to_date(&self, variable: impl Into<Source>) -> Source {
        let variable: Source = variable.into();
        match self.kind {
            DateTimeProviderKind::Java8 => sl!["LocalDate.parse(", variable, ")"],
            DateTimeProviderKind::Legacy => self.parse_all(variable),
        }
    }

    /// `convertDateTimeToString(variable)`.
    pub fn convert_date_time_to_string(&self, variable: impl Into<Source>) -> Source {
        let variable: Source = variable.into();
        match self.kind {
            DateTimeProviderKind::Java8 => sl![
                variable,
                ".format(java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME)"
            ],
            DateTimeProviderKind::Legacy => {
                sl![
                    self.class_name.as_str(),
                    ".serializeDateTime(",
                    variable,
                    ")"
                ]
            }
        }
    }

    /// `convertTimeToString(variable)`.
    pub fn convert_time_to_string(&self, variable: impl Into<Source>) -> Source {
        let variable: Source = variable.into();
        match self.kind {
            DateTimeProviderKind::Java8 => sl![
                variable,
                ".format(java.time.format.DateTimeFormatter.ISO_OFFSET_TIME)"
            ],
            DateTimeProviderKind::Legacy => {
                sl![self.class_name.as_str(), ".serializeTime(", variable, ")"]
            }
        }
    }

    /// `convertDateToString(variable)`.
    pub fn convert_date_to_string(&self, variable: impl Into<Source>) -> Source {
        let variable: Source = variable.into();
        match self.kind {
            DateTimeProviderKind::Java8 => sl![
                variable,
                ".format(java.time.format.DateTimeFormatter.ISO_DATE)"
            ],
            DateTimeProviderKind::Legacy => {
                sl![self.class_name.as_str(), ".serializeDate(", variable, ")"]
            }
        }
    }

    /// The legacy provider parses all three kinds the same way.
    fn parse_all(&self, variable: Source) -> Source {
        sl![
            self.class_name.as_str(),
            ".parseAllDateTimeString(",
            variable,
            ")"
        ]
    }
}

/// `Java8DateTimeProvider.emitDateTimeConverters()`.
fn emit_java8_converters<'a, R: JavaRenderer<'a>>(r: &mut R) -> Result<()> {
    r.ensure_blank_line();
    r.emit_line(
        "private static final DateTimeFormatter DATE_TIME_FORMATTER = new DateTimeFormatterBuilder()",
    );
    r.indent(|r| {
        r.indent(|r| {
            r.emit_line(".appendOptional(DateTimeFormatter.ISO_DATE_TIME)");
            r.emit_line(".appendOptional(DateTimeFormatter.ISO_OFFSET_DATE_TIME)");
            r.emit_line(".appendOptional(DateTimeFormatter.ISO_INSTANT)");
            r.emit_line(".appendOptional(DateTimeFormatter.ofPattern(\"yyyy-MM-dd HH:mm:ss.SX\"))");
            r.emit_line(".appendOptional(DateTimeFormatter.ofPattern(\"yyyy-MM-dd HH:mm:ssX\"))");
            r.emit_line(".appendOptional(DateTimeFormatter.ofPattern(\"yyyy-MM-dd HH:mm:ss\"))");
            r.emit_line(".toFormatter()");
            r.emit_line(".withZone(ZoneOffset.UTC);");
            Ok(())
        })
    })?;
    r.ensure_blank_line();
    r.emit_block(
        "public static OffsetDateTime parseDateTimeString(String str)".into(),
        |r| {
            r.emit_line(
                "return ZonedDateTime.from(Converter.DATE_TIME_FORMATTER.parse(str)).toOffsetDateTime();",
            );
            Ok(())
        },
    )?;

    r.ensure_blank_line();
    r.emit_line(
        "private static final DateTimeFormatter TIME_FORMATTER = new DateTimeFormatterBuilder()",
    );
    r.indent(|r| {
        r.indent(|r| {
            r.emit_line(".appendOptional(DateTimeFormatter.ISO_TIME)");
            r.emit_line(".appendOptional(DateTimeFormatter.ISO_OFFSET_TIME)");
            r.emit_line(".parseDefaulting(ChronoField.YEAR, 2020)");
            r.emit_line(".parseDefaulting(ChronoField.MONTH_OF_YEAR, 1)");
            r.emit_line(".parseDefaulting(ChronoField.DAY_OF_MONTH, 1)");
            r.emit_line(".toFormatter()");
            r.emit_line(".withZone(ZoneOffset.UTC);");
            Ok(())
        })
    })?;
    r.ensure_blank_line();
    r.emit_block(
        "public static OffsetTime parseTimeString(String str)".into(),
        |r| {
            r.emit_line(
                "return ZonedDateTime.from(Converter.TIME_FORMATTER.parse(str)).toOffsetDateTime().toOffsetTime();",
            );
            Ok(())
        },
    )
}

/// `JavaLegacyDateTimeProvider.emitDateTimeConverters()`.
fn emit_legacy_converters<'a, R: JavaRenderer<'a>>(r: &mut R) -> Result<()> {
    r.ensure_blank_line();
    r.emit_line("private static final String[] DATE_TIME_FORMATS = {");
    r.indent(|r| {
        r.indent(|r| {
            r.emit_line("\"yyyy-MM-dd'T'HH:mm:ss.SX\",");
            r.emit_line("\"yyyy-MM-dd'T'HH:mm:ss.S\",");
            r.emit_line("\"yyyy-MM-dd'T'HH:mm:ssX\",");
            r.emit_line("\"yyyy-MM-dd'T'HH:mm:ss\",");
            r.emit_line("\"yyyy-MM-dd HH:mm:ss.SX\",");
            r.emit_line("\"yyyy-MM-dd HH:mm:ss.S\",");
            r.emit_line("\"yyyy-MM-dd HH:mm:ssX\",");
            r.emit_line("\"yyyy-MM-dd HH:mm:ss\",");
            r.emit_line("\"HH:mm:ss.SZ\",");
            r.emit_line("\"HH:mm:ss.S\",");
            r.emit_line("\"HH:mm:ssZ\",");
            r.emit_line("\"HH:mm:ss\",");
            r.emit_line("\"yyyy-MM-dd\",");
            Ok(())
        })
    })?;
    r.emit_line("};");
    r.ensure_blank_line();
    r.emit_block(
        "public static Date parseAllDateTimeString(String str)".into(),
        |r| {
            r.emit_line("str = str.replaceFirst(\"(\\\\.\\\\d{3})\\\\d+\", \"$1\");");
            r.emit_block("for (String format : DATE_TIME_FORMATS)".into(), |r| {
                r.emit_ignored_try_catch_block(|r| {
                    r.emit_line("return new SimpleDateFormat(format).parse(str);");
                    Ok(())
                })
            })?;
            r.emit_line("return null;");
            Ok(())
        },
    )?;

    r.ensure_blank_line();
    r.emit_block(
        "public static String serializeDateTime(Date datetime)".into(),
        |r| {
            r.emit_line(
                "return new SimpleDateFormat(\"yyyy-MM-dd'T'hh:mm:ssZ\").format(datetime);",
            );
            Ok(())
        },
    )?;

    r.ensure_blank_line();
    r.emit_block(
        "public static String serializeDate(Date datetime)".into(),
        |r| {
            r.emit_line("return new SimpleDateFormat(\"yyyy-MM-dd\").format(datetime);");
            Ok(())
        },
    )?;

    r.ensure_blank_line();
    r.emit_block(
        "public static String serializeTime(Date datetime)".into(),
        |r| {
            r.emit_line("return new SimpleDateFormat(\"hh:mm:ssZ\").format(datetime);");
            Ok(())
        },
    )
}
