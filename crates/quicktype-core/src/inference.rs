//! Port of `packages/quicktype-core/src/Inference.ts`.
//!
//! The inference flags: which kinds of types quicktype infers from JSON
//! samples. All are on by default; the CLI turns each off with its
//! `--no-…` option.

use crate::ty::transformed_string_type::TypeKind;

/// The name of an inference flag (TS `InferenceFlagName`).
#[non_exhaustive]
#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub enum InferenceFlagName {
    /// `inferMaps`.
    InferMaps,
    /// `inferEnums`.
    InferEnums,
    /// `inferUuids`.
    InferUuids,
    /// `inferDateTimes`.
    InferDateTimes,
    /// `inferIntegerStrings`.
    InferIntegerStrings,
    /// `inferBooleanStrings`.
    InferBooleanStrings,
    /// `combineClasses`.
    CombineClasses,
    /// `ignoreJsonRefs`.
    IgnoreJsonRefs,
}

/// One inference flag's description (TS `InferenceFlag`).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct InferenceFlag {
    /// The flag.
    pub name: InferenceFlagName,
    /// The TypeScript property name, e.g. `"inferMaps"`.
    pub js_name: &'static str,
    /// `description`.
    pub description: &'static str,
    /// `negationDescription`: the CLI's `--no-…` help text (without the
    /// final period).
    pub negation_description: &'static str,
    /// `explanation`.
    pub explanation: &'static str,
    /// `order`.
    pub order: u32,
    /// `stringType`: the transformed string kind that turning the flag off
    /// maps to `string`.
    pub string_type: Option<TypeKind>,
}

/// `inferenceFlags`, in `inferenceFlagNames` order
/// (`Object.getOwnPropertyNames(inferenceFlagsObject)`).
pub static INFERENCE_FLAGS: [InferenceFlag; 8] = [
    InferenceFlag {
        name: InferenceFlagName::InferMaps,
        js_name: "inferMaps",
        description: "Detect maps",
        negation_description: "Don't infer maps, always use classes",
        explanation: "Infer maps when object keys look like map keys.",
        order: 1,
        string_type: None,
    },
    InferenceFlag {
        name: InferenceFlagName::InferEnums,
        js_name: "inferEnums",
        description: "Detect enums",
        negation_description: "Don't infer enums, always use strings",
        explanation: "If string values occur within a relatively small domain,\ninfer them as enum values.",
        order: 2,
        string_type: None,
    },
    InferenceFlag {
        name: InferenceFlagName::InferUuids,
        js_name: "inferUuids",
        description: "Detect UUIDs",
        negation_description: "Don't convert UUIDs to UUID objects",
        explanation: "Detect UUIDs like '123e4567-e89b-12d3-a456-426655440000' (partial support).",
        order: 3,
        string_type: Some(TypeKind::Uuid),
    },
    InferenceFlag {
        name: InferenceFlagName::InferDateTimes,
        js_name: "inferDateTimes",
        description: "Detect dates & times",
        negation_description: "Don't infer dates or times",
        explanation: "Infer dates from strings (partial support).",
        order: 4,
        string_type: Some(TypeKind::DateTime),
    },
    InferenceFlag {
        name: InferenceFlagName::InferIntegerStrings,
        js_name: "inferIntegerStrings",
        description: "Detect integers in strings",
        negation_description: "Don't convert stringified integers to integers",
        explanation: "Automatically convert stringified integers to integers.\nFor example, \"1\" is converted to 1.",
        order: 5,
        string_type: Some(TypeKind::IntegerString),
    },
    InferenceFlag {
        name: InferenceFlagName::InferBooleanStrings,
        js_name: "inferBooleanStrings",
        description: "Detect booleans in strings",
        negation_description: "Don't convert stringified booleans to booleans",
        explanation: "Automatically convert stringified booleans to booleans.\nFor example, \"true\" is converted to true.",
        order: 6,
        string_type: Some(TypeKind::BoolString),
    },
    InferenceFlag {
        name: InferenceFlagName::CombineClasses,
        js_name: "combineClasses",
        description: "Merge similar classes",
        negation_description: "Don't combine similar classes",
        explanation: "Combine classes with significantly overlapping properties,\ntreating contingent properties as nullable.",
        order: 7,
        string_type: None,
    },
    InferenceFlag {
        name: InferenceFlagName::IgnoreJsonRefs,
        js_name: "ignoreJsonRefs",
        description: "Don't treat $ref as a reference in JSON",
        negation_description: "Treat $ref as a reference in JSON",
        explanation: "Like in JSON Schema, allow objects like\n'{ $ref: \"#/foo/bar\" }' to refer\nto another part of the input.",
        order: 8,
        string_type: None,
    },
];

/// The values of all inference flags (TS `InferenceFlags`); all `true` by
/// default (TS `defaultInferenceFlags`).
#[non_exhaustive]
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct InferenceFlags {
    /// Infer maps when object keys look like map keys.
    pub infer_maps: bool,
    /// Infer enums from strings in a small domain.
    pub infer_enums: bool,
    /// Infer UUIDs.
    pub infer_uuids: bool,
    /// Infer dates, times and date-times.
    pub infer_date_times: bool,
    /// Infer integers in strings.
    pub infer_integer_strings: bool,
    /// Infer booleans in strings.
    pub infer_boolean_strings: bool,
    /// Combine similar classes.
    pub combine_classes: bool,
    /// Don't treat `$ref` as a reference in JSON.
    pub ignore_json_refs: bool,
}

impl Default for InferenceFlags {
    fn default() -> Self {
        InferenceFlags {
            infer_maps: true,
            infer_enums: true,
            infer_uuids: true,
            infer_date_times: true,
            infer_integer_strings: true,
            infer_boolean_strings: true,
            combine_classes: true,
            ignore_json_refs: true,
        }
    }
}

impl InferenceFlags {
    /// The value of flag `name`.
    pub fn get(&self, name: InferenceFlagName) -> bool {
        *self.slot(name)
    }

    /// Sets flag `name`.
    pub fn set(&mut self, name: InferenceFlagName, value: bool) {
        *self.slot_mut(name) = value;
    }

    fn slot(&self, name: InferenceFlagName) -> &bool {
        match name {
            InferenceFlagName::InferMaps => &self.infer_maps,
            InferenceFlagName::InferEnums => &self.infer_enums,
            InferenceFlagName::InferUuids => &self.infer_uuids,
            InferenceFlagName::InferDateTimes => &self.infer_date_times,
            InferenceFlagName::InferIntegerStrings => &self.infer_integer_strings,
            InferenceFlagName::InferBooleanStrings => &self.infer_boolean_strings,
            InferenceFlagName::CombineClasses => &self.combine_classes,
            InferenceFlagName::IgnoreJsonRefs => &self.ignore_json_refs,
        }
    }

    fn slot_mut(&mut self, name: InferenceFlagName) -> &mut bool {
        match name {
            InferenceFlagName::InferMaps => &mut self.infer_maps,
            InferenceFlagName::InferEnums => &mut self.infer_enums,
            InferenceFlagName::InferUuids => &mut self.infer_uuids,
            InferenceFlagName::InferDateTimes => &mut self.infer_date_times,
            InferenceFlagName::InferIntegerStrings => &mut self.infer_integer_strings,
            InferenceFlagName::InferBooleanStrings => &mut self.infer_boolean_strings,
            InferenceFlagName::CombineClasses => &mut self.combine_classes,
            InferenceFlagName::IgnoreJsonRefs => &mut self.ignore_json_refs,
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn flags_in_declaration_order() {
        let names: Vec<&str> = INFERENCE_FLAGS.iter().map(|f| f.js_name).collect();
        assert_eq!(
            names,
            [
                "inferMaps",
                "inferEnums",
                "inferUuids",
                "inferDateTimes",
                "inferIntegerStrings",
                "inferBooleanStrings",
                "combineClasses",
                "ignoreJsonRefs"
            ]
        );
        for (i, flag) in INFERENCE_FLAGS.iter().enumerate() {
            assert_eq!(flag.order as usize, i + 1);
        }
        let mut flags = InferenceFlags::default();
        assert!(INFERENCE_FLAGS.iter().all(|f| flags.get(f.name)));
        flags.set(InferenceFlagName::IgnoreJsonRefs, false);
        assert!(!flags.ignore_json_refs);
    }
}
