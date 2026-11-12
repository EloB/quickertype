// Example code that deserializes and serializes the model.
// extern crate serde;
// #[macro_use]
// extern crate serde_derive;
// extern crate serde_json;
//
// use generated_module::TopLevel;
//
// fn main() {
//     let json = r#"{"answer": 42}"#;
//     let model: TopLevel = serde_json::from_str(&json).unwrap();
// }

use serde::{Serialize, Deserialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TopLevel {
    pub children: Vec<TopLevelChild>,

    pub flags: GetSignatureFlags,

    pub groups: Vec<Group>,

    pub id: i64,

    pub kind: i64,

    pub name: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct TopLevelChild {
    pub children: Vec<PurpleChild>,

    pub comment: Option<IndecentComment>,

    pub flags: PurpleFlags,

    pub groups: Vec<Group>,

    pub id: i64,

    pub kind: i64,

    pub kind_string: TentacledKindString,

    pub name: String,

    pub original_name: String,

    pub sources: Vec<Source>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct PurpleChild {
    #[serde(rename = "type")]
    pub child_type: Option<MagentaType>,

    pub children: Option<Vec<FluffyChild>>,

    pub comment: Option<StickyComment>,

    pub default_value: Option<String>,

    pub extended_by: Option<Vec<ExtendedBy>>,

    pub extended_types: Option<Vec<ExtendedBy>>,

    pub flags: IndecentFlags,

    pub groups: Option<Vec<Group>>,

    pub id: i64,

    pub implemented_by: Option<Vec<ExtendedBy>>,

    pub implemented_types: Option<Vec<ExtendedBy>>,

    pub kind: i64,

    pub kind_string: FluffyKindString,

    pub name: String,

    pub signatures: Option<Vec<StickySignature>>,

    pub sources: Vec<Source>,

    pub type_parameter: Option<Vec<TypeParameter>>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct MagentaType {
    pub declaration: Option<StickyDeclaration>,

    pub element_type: Option<ElementType>,

    pub elements: Option<Vec<ExtendedBy>>,

    pub id: Option<i64>,

    pub name: Option<String>,

    pub type_arguments: Option<Vec<FluffyTypeArgument>>,

    #[serde(rename = "type")]
    pub type_type: TypeEnum,

    pub types: Option<Vec<ExtendedBy>>,

    pub value: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct StickyDeclaration {
    pub children: Option<Vec<IndecentChild>>,

    pub flags: GetSignatureFlags,

    pub groups: Option<Vec<Group>>,

    pub id: i64,

    pub kind: i64,

    pub kind_string: String,

    pub name: String,

    pub signatures: Vec<GetSignature>,

    pub sources: Vec<Source>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct IndecentChild {
    #[serde(rename = "type")]
    pub child_type: FriskyType,

    pub flags: FluffyFlags,

    pub id: i64,

    pub kind: i64,

    pub kind_string: PurpleKindString,

    pub name: String,

    pub sources: Vec<Source>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FriskyType {
    pub declaration: Option<IndigoDeclaration>,

    pub name: Option<Name>,

    #[serde(rename = "type")]
    pub type_type: TypeEnum,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct IndigoDeclaration {
    pub children: Option<Vec<GetSignature>>,

    pub flags: GetSignatureFlags,

    pub groups: Option<Vec<Group>>,

    pub id: i64,

    pub kind: i64,

    pub kind_string: String,

    pub name: String,

    pub signatures: Option<Vec<GetSignature>>,

    pub sources: Vec<Source>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct IndexSignatureElement {
    pub flags: GetSignatureFlags,

    pub id: i64,

    pub kind: i64,

    pub kind_string: String,

    pub name: String,

    pub parameters: Option<Vec<GetSignature>>,

    #[serde(rename = "type")]
    pub signature_type: PurpleType,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct GetSignatureType {
    pub declaration: Option<Box<GetSignature>>,

    pub element_type: Option<ElementType>,

    pub name: Option<Name>,

    #[serde(rename = "type")]
    pub type_type: TypeEnum,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PurpleType {
    pub declaration: Option<Box<GetSignature>>,

    pub name: Option<Name>,

    #[serde(rename = "type")]
    pub type_type: TypeEnum,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct GetSignatureChild {
    #[serde(rename = "type")]
    pub child_type: PurpleType,

    pub comment: Option<FluffyComment>,

    pub flags: FluffyFlags,

    pub id: i64,

    pub kind: i64,

    pub kind_string: PurpleKindString,

    pub name: String,

    pub sources: Vec<Source>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct GetSignature {
    pub children: Option<Vec<GetSignatureChild>>,

    pub comment: Option<GetSignatureComment>,

    pub default_value: Option<String>,

    pub flags: GetSignatureFlags,

    #[serde(rename = "type")]
    pub get_signature_type: Option<GetSignatureType>,

    pub groups: Option<Vec<Group>>,

    pub id: i64,

    pub kind: i64,

    pub kind_string: String,

    pub name: String,

    pub parameters: Option<Vec<GetSignatureParameter>>,

    pub signatures: Option<Vec<IndexSignatureElement>>,

    pub sources: Option<Vec<Source>>,

    pub type_parameter: Option<Vec<GetSignature>>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct GetSignatureFlags {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ElementType {
    #[serde(rename = "type")]
    pub element_type_type: TypeEnum,

    pub name: Name,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub enum TypeEnum {
    Intrinsic,

    Reflection,

    Array,

    Reference,

    #[serde(rename = "typeParameter")]
    TypeParameter,

    Tuple,

    Union,

    #[serde(rename = "stringLiteral")]
    StringLiteral,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Name {
    #[serde(rename = "string")]
    NameString,

    Number,

    Void,

    #[serde(rename = "T")]
    T,

    Boolean,

    #[serde(rename = "BaseClass")]
    BaseClass,

    Any,

    #[serde(rename = "Array")]
    Array,

    #[serde(rename = "MyNumber")]
    MyNumber,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FluffyComment {
    pub text: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct FluffyFlags {
    pub is_optional: Option<bool>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum PurpleKindString {
    Variable,

    Function,

    Property,

    Method,

    Constructor,

    Accessor,

    #[serde(rename = "Enumeration member")]
    EnumerationMember,

    Module,

    #[serde(rename = "Object literal")]
    ObjectLiteral,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Source {
    pub character: i64,

    pub file_name: FileName,

    pub line: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum FileName {
    #[serde(rename = "modules.ts")]
    ModulesTs,

    #[serde(rename = "classes.ts")]
    ClassesTs,

    #[serde(rename = "flattened.ts")]
    FlattenedTs,

    #[serde(rename = "access.ts")]
    AccessTs,

    #[serde(rename = "default-export.ts")]
    DefaultExportTs,

    #[serde(rename = "enumerations.ts")]
    EnumerationsTs,

    #[serde(rename = "functions.ts")]
    FunctionsTs,

    #[serde(rename = "generics.ts")]
    GenericsTs,

    #[serde(rename = "single-export.ts")]
    SingleExportTs,

    #[serde(rename = "typescript-1.3.ts")]
    Typescript13Ts,

    #[serde(rename = "typescript-1.4.ts")]
    Typescript14Ts,

    #[serde(rename = "typescript-1.5.ts")]
    Typescript15Ts,

    #[serde(rename = "variables.ts")]
    VariablesTs,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct GetSignatureComment {
    pub returns: Option<String>,

    pub short_text: Option<String>,

    pub text: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Group {
    pub children: Vec<i64>,

    pub kind: i64,

    pub title: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct GetSignatureParameter {
    pub comment: Option<TentacledComment>,

    pub flags: TentacledFlags,

    pub id: i64,

    pub kind: i64,

    pub kind_string: ParameterKindString,

    pub name: String,

    #[serde(rename = "type")]
    pub parameter_type: FluffyType,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct TentacledComment {
    pub short_text: Option<String>,

    pub text: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct TentacledFlags {
    pub is_optional: Option<bool>,

    pub is_rest: Option<bool>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum ParameterKindString {
    Parameter,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct FluffyType {
    pub element_type: Option<ElementType>,

    pub name: Option<Name>,

    pub type_arguments: Option<Vec<ElementType>>,

    #[serde(rename = "type")]
    pub type_type: TypeEnum,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct ExtendedBy {
    pub constraint: Option<Box<ExtendedBy>>,

    #[serde(rename = "type")]
    pub extended_by_type: TypeEnum,

    pub id: Option<i64>,

    pub name: String,

    pub type_arguments: Option<Vec<ExtendedBy>>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FluffyTypeArgument {
    #[serde(rename = "type")]
    pub type_argument_type: TypeEnum,

    pub types: Vec<ElementType>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct FluffyChild {
    #[serde(rename = "type")]
    pub child_type: Option<IndigoType>,

    pub children: Option<Vec<TentacledChild>>,

    pub comment: Option<StickyComment>,

    pub default_value: Option<String>,

    pub flags: StickyFlags,

    pub get_signature: Option<Box<GetSignature>>,

    pub groups: Option<Vec<Group>>,

    pub id: i64,

    pub implementation_of: Option<Box<ExtendedBy>>,

    pub inherited_from: Option<Box<ExtendedBy>>,

    pub kind: i64,

    pub kind_string: PurpleKindString,

    pub name: String,

    pub overwrites: Option<Box<ExtendedBy>>,

    pub set_signature: Option<Box<GetSignature>>,

    pub signatures: Option<Vec<FluffySignature>>,

    pub sources: Vec<Source>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct IndigoType {
    pub constraint: Option<Box<ExtendedBy>>,

    pub declaration: Option<FluffyDeclaration>,

    pub element_type: Option<Box<ExtendedBy>>,

    pub elements: Option<Vec<ElementType>>,

    pub id: Option<i64>,

    pub name: Option<String>,

    pub type_arguments: Option<Vec<PurpleTypeArgument>>,

    #[serde(rename = "type")]
    pub type_type: TypeEnum,

    pub types: Option<Vec<TypeElement>>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct FluffyDeclaration {
    pub children: Option<Vec<StickyChild>>,

    pub flags: GetSignatureFlags,

    pub groups: Option<Vec<Group>>,

    pub id: i64,

    pub index_signature: Option<IndexSignature>,

    pub kind: i64,

    pub kind_string: String,

    pub name: String,

    pub signatures: Option<Vec<TentacledSignature>>,

    pub sources: Vec<Source>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct StickyChild {
    #[serde(rename = "type")]
    pub child_type: IndecentType,

    pub comment: Option<FluffyComment>,

    pub flags: FluffyFlags,

    pub id: i64,

    pub kind: i64,

    pub kind_string: PurpleKindString,

    pub name: String,

    pub sources: Vec<Source>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct IndecentType {
    pub declaration: Option<Box<GetSignature>>,

    pub elements: Option<Vec<ElementType>>,

    pub name: Option<Name>,

    #[serde(rename = "type")]
    pub type_type: TypeEnum,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct IndexSignature {
    pub flags: GetSignatureFlags,

    pub id: i64,

    #[serde(rename = "type")]
    pub index_signature_type: HilariousType,

    pub kind: i64,

    pub kind_string: String,

    pub name: String,

    pub parameters: Vec<GetSignature>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct HilariousType {
    pub declaration: Box<GetSignature>,

    #[serde(rename = "type")]
    pub type_type: TypeEnum,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct TentacledSignature {
    pub comment: Option<IndigoComment>,

    pub flags: GetSignatureFlags,

    pub id: i64,

    pub kind: i64,

    pub kind_string: SignatureKindString,

    pub name: String,

    pub parameters: Option<Vec<FluffyParameter>>,

    #[serde(rename = "type")]
    pub signature_type: Box<ExtendedBy>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct IndigoComment {
    pub returns: String,

    pub short_text: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum SignatureKindString {
    #[serde(rename = "Call signature")]
    CallSignature,

    #[serde(rename = "Constructor signature")]
    ConstructorSignature,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct FluffyParameter {
    pub comment: Option<FluffyComment>,

    pub flags: FluffyFlags,

    pub id: i64,

    pub kind: i64,

    pub kind_string: String,

    pub name: String,

    #[serde(rename = "type")]
    pub parameter_type: ElementType,

    pub sources: Option<Vec<Source>>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PurpleTypeArgument {
    pub operator: String,

    pub target: ElementType,

    #[serde(rename = "type")]
    pub type_argument_type: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct TypeElement {
    pub declaration: Option<Box<GetSignature>>,

    pub element_type: Option<ElementType>,

    pub name: Option<Name>,

    pub type_arguments: Option<Vec<ElementType>>,

    #[serde(rename = "type")]
    pub type_type: TypeEnum,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct TentacledChild {
    #[serde(rename = "type")]
    pub child_type: Option<TypeElement>,

    pub comment: Option<PurpleComment>,

    pub default_value: Option<String>,

    pub flags: PurpleFlags,

    pub id: i64,

    pub kind: i64,

    pub kind_string: PurpleKindString,

    pub name: String,

    pub signatures: Option<Vec<PurpleSignature>>,

    pub sources: Vec<Source>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct PurpleComment {
    pub short_text: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct PurpleFlags {
    pub is_exported: Option<bool>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct PurpleSignature {
    pub comment: Option<PurpleComment>,

    pub flags: GetSignatureFlags,

    pub id: i64,

    pub kind: i64,

    pub kind_string: SignatureKindString,

    pub name: String,

    pub parameters: Vec<GetSignature>,

    #[serde(rename = "type")]
    pub signature_type: TentacledType,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TentacledType {
    pub declaration: Option<PurpleDeclaration>,

    pub name: Option<Name>,

    #[serde(rename = "type")]
    pub type_type: TypeEnum,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct PurpleDeclaration {
    pub children: Vec<GetSignature>,

    pub flags: GetSignatureFlags,

    pub groups: Vec<Group>,

    pub id: i64,

    pub kind: i64,

    pub kind_string: String,

    pub name: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct StickyComment {
    pub returns: Option<String>,

    pub short_text: Option<String>,

    pub tags: Option<Vec<Tag>>,

    pub text: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Tag {
    pub tag: String,

    pub text: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct StickyFlags {
    pub is_abstract: Option<bool>,

    pub is_constructor_property: Option<bool>,

    pub is_exported: Option<bool>,

    pub is_private: Option<bool>,

    pub is_protected: Option<bool>,

    pub is_public: Option<bool>,

    pub is_static: Option<bool>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct FluffySignature {
    pub comment: Option<StickyComment>,

    pub flags: IndigoFlags,

    pub id: i64,

    pub implementation_of: Option<Box<ExtendedBy>>,

    pub inherited_from: Option<Box<ExtendedBy>>,

    pub kind: i64,

    pub kind_string: SignatureKindString,

    pub name: String,

    pub overwrites: Option<Box<ExtendedBy>>,

    pub parameters: Option<Vec<PurpleParameter>>,

    #[serde(rename = "type")]
    pub signature_type: Box<ExtendedBy>,

    pub type_parameter: Option<Vec<GetSignature>>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct IndigoFlags {
    pub is_private: Option<bool>,

    pub is_protected: Option<bool>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct PurpleParameter {
    pub comment: Option<TentacledComment>,

    pub flags: GetSignatureFlags,

    pub id: i64,

    pub kind: i64,

    pub kind_string: ParameterKindString,

    pub name: String,

    #[serde(rename = "type")]
    pub parameter_type: StickyType,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct StickyType {
    pub constraint: Option<Box<ExtendedBy>>,

    pub declaration: Option<Box<GetSignature>>,

    pub element_type: Option<ElementType>,

    pub elements: Option<Vec<ExtendedBy>>,

    pub id: Option<i64>,

    pub name: Option<String>,

    pub type_arguments: Option<Vec<ElementType>>,

    #[serde(rename = "type")]
    pub type_type: TypeEnum,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct IndecentFlags {
    pub has_export_assignment: Option<bool>,

    pub is_abstract: Option<bool>,

    pub is_const: Option<bool>,

    pub is_exported: Option<bool>,

    pub is_let: Option<bool>,

    pub is_private: Option<bool>,

    pub is_protected: Option<bool>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum FluffyKindString {
    Module,

    Class,

    Variable,

    Function,

    Interface,

    Enumeration,

    #[serde(rename = "Object literal")]
    ObjectLiteral,

    #[serde(rename = "Type alias")]
    TypeAlias,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct StickySignature {
    pub comment: StickyComment,

    pub flags: IndigoFlags,

    pub id: i64,

    pub kind: i64,

    pub kind_string: SignatureKindString,

    pub name: String,

    pub parameters: Option<Vec<TentacledParameter>>,

    #[serde(rename = "type")]
    pub signature_type: CunningType,

    pub type_parameter: Option<Vec<GetSignature>>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct TentacledParameter {
    pub comment: Option<TentacledComment>,

    pub default_value: Option<String>,

    pub flags: TentacledFlags,

    pub id: i64,

    pub kind: i64,

    pub kind_string: ParameterKindString,

    pub name: String,

    pub original_name: Option<String>,

    #[serde(rename = "type")]
    pub parameter_type: AmbitiousType,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct AmbitiousType {
    pub declaration: Option<TentacledDeclaration>,

    pub element_type: Option<ElementType>,

    pub id: Option<i64>,

    pub name: Option<String>,

    pub type_arguments: Option<Vec<ElementType>>,

    #[serde(rename = "type")]
    pub type_type: TypeEnum,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct TentacledDeclaration {
    pub children: Option<Vec<IndigoChild>>,

    pub flags: GetSignatureFlags,

    pub groups: Option<Vec<Group>>,

    pub id: i64,

    pub index_signature: Option<IndexSignatureElement>,

    pub kind: i64,

    pub kind_string: String,

    pub name: String,

    pub signatures: Option<Vec<GetSignature>>,

    pub sources: Vec<Source>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct IndigoChild {
    #[serde(rename = "type")]
    pub child_type: IndecentType,

    pub comment: FluffyComment,

    pub default_value: Option<String>,

    pub flags: FluffyFlags,

    pub id: i64,

    pub kind: i64,

    pub kind_string: PurpleKindString,

    pub name: String,

    pub sources: Vec<Source>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct CunningType {
    pub declaration: Option<PurpleDeclaration>,

    pub id: Option<i64>,

    pub name: Option<Name>,

    pub type_arguments: Option<Vec<ElementType>>,

    #[serde(rename = "type")]
    pub type_type: TypeEnum,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct TypeParameter {
    pub comment: Option<PurpleComment>,

    pub flags: GetSignatureFlags,

    pub id: i64,

    pub kind: i64,

    pub kind_string: String,

    pub name: String,

    #[serde(rename = "type")]
    pub type_parameter_type: Option<MischievousType>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MischievousType {
    pub id: Option<i64>,

    pub name: Option<Name>,

    pub operator: Option<String>,

    pub target: Option<ElementType>,

    #[serde(rename = "type")]
    pub type_type: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct IndecentComment {
    pub short_text: String,

    pub tags: Option<Vec<Tag>>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum TentacledKindString {
    #[serde(rename = "External module")]
    ExternalModule,
}
