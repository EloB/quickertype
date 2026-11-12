// To parse the JSON, install kotlin's serialization plugin and do:
//
// val json     = Json { allowStructuredMapKeys = true }
// val topLevel = json.parse(TopLevel.serializer(), jsonString)

package quicktype

import kotlinx.serialization.*
import kotlinx.serialization.json.*
import kotlinx.serialization.descriptors.*
import kotlinx.serialization.encoding.*

@Serializable
data class TopLevel (
    val children: List<TopLevelChild>,
    val flags: GetSignatureFlags,
    val groups: List<Group>,
    val id: Long,
    val kind: Long,
    val name: String
)

@Serializable
data class TopLevelChild (
    val children: List<PurpleChild>,
    val comment: IndecentComment? = null,
    val flags: PurpleFlags,
    val groups: List<Group>,
    val id: Long,
    val kind: Long,
    val kindString: TentacledKindString,
    val name: String,
    val originalName: String,
    val sources: List<Source>
)

@Serializable
data class PurpleChild (
    val children: List<FluffyChild>? = null,
    val comment: StickyComment? = null,
    val defaultValue: String? = null,
    val extendedBy: List<ExtendedBy>? = null,
    val extendedTypes: List<ExtendedBy>? = null,
    val flags: IndecentFlags,
    val groups: List<Group>? = null,
    val id: Long,
    val implementedBy: List<ExtendedBy>? = null,
    val implementedTypes: List<ExtendedBy>? = null,
    val kind: Long,
    val kindString: FluffyKindString,
    val name: String,
    val signatures: List<StickySignature>? = null,
    val sources: List<Source>,
    val type: MagentaType? = null,
    val typeParameter: List<TypeParameter>? = null
)

@Serializable
data class FluffyChild (
    val children: List<TentacledChild>? = null,
    val comment: StickyComment? = null,
    val defaultValue: String? = null,
    val flags: StickyFlags,
    val getSignature: GetSignature? = null,
    val groups: List<Group>? = null,
    val id: Long,
    val implementationOf: ExtendedBy? = null,
    val inheritedFrom: ExtendedBy? = null,
    val kind: Long,
    val kindString: PurpleKindString,
    val name: String,
    val overwrites: ExtendedBy? = null,
    val setSignature: GetSignature? = null,
    val signatures: List<FluffySignature>? = null,
    val sources: List<Source>,
    val type: IndigoType? = null
)

@Serializable
data class TentacledChild (
    val comment: PurpleComment? = null,
    val defaultValue: String? = null,
    val flags: PurpleFlags,
    val id: Long,
    val kind: Long,
    val kindString: PurpleKindString,
    val name: String,
    val signatures: List<PurpleSignature>? = null,
    val sources: List<Source>,
    val type: TypeElement? = null
)

@Serializable
data class PurpleComment (
    val shortText: String
)

@Serializable
data class PurpleFlags (
    val isExported: Boolean? = null
)

@Serializable
enum class PurpleKindString(val value: String) {
    @SerialName("Variable") Variable("Variable"),
    @SerialName("Function") Function("Function"),
    @SerialName("Property") Property("Property"),
    @SerialName("Method") Method("Method"),
    @SerialName("Constructor") Constructor("Constructor"),
    @SerialName("Accessor") Accessor("Accessor"),
    @SerialName("Enumeration member") EnumerationMember("Enumeration member"),
    @SerialName("Module") Module("Module"),
    @SerialName("Object literal") ObjectLiteral("Object literal");
}

@Serializable
data class PurpleSignature (
    val comment: PurpleComment? = null,
    val flags: GetSignatureFlags,
    val id: Long,
    val kind: Long,
    val kindString: SignatureKindString,
    val name: String,
    val parameters: List<GetSignature>,
    val type: TentacledType
)

@Serializable
class GetSignatureFlags()

@Serializable
enum class SignatureKindString(val value: String) {
    @SerialName("Call signature") CallSignature("Call signature"),
    @SerialName("Constructor signature") ConstructorSignature("Constructor signature");
}

@Serializable
data class GetSignatureType (
    val declaration: GetSignature? = null,
    val elementType: ElementType? = null,
    val name: Name? = null,
    val type: TypeEnum
)

@Serializable
data class IndexSignatureElement (
    val flags: GetSignatureFlags,
    val id: Long,
    val kind: Long,
    val kindString: String,
    val name: String,
    val parameters: List<GetSignature>? = null,
    val type: PurpleType
)

@Serializable
data class PurpleType (
    val declaration: GetSignature? = null,
    val name: Name? = null,
    val type: TypeEnum
)

@Serializable
data class GetSignatureChild (
    val comment: FluffyComment? = null,
    val flags: FluffyFlags,
    val id: Long,
    val kind: Long,
    val kindString: PurpleKindString,
    val name: String,
    val sources: List<Source>,
    val type: PurpleType
)

@Serializable
data class GetSignature (
    val children: List<GetSignatureChild>? = null,
    val comment: GetSignatureComment? = null,
    val defaultValue: String? = null,
    val flags: GetSignatureFlags,
    val groups: List<Group>? = null,
    val id: Long,
    val kind: Long,
    val kindString: String,
    val name: String,
    val parameters: List<GetSignatureParameter>? = null,
    val signatures: List<IndexSignatureElement>? = null,
    val sources: List<Source>? = null,
    val type: GetSignatureType? = null,
    val typeParameter: List<GetSignature>? = null
)

@Serializable
data class ElementType (
    val name: Name,
    val type: TypeEnum
)

@Serializable
enum class Name(val value: String) {
    @SerialName("string") NameString("string"),
    @SerialName("number") Number("number"),
    @SerialName("void") Void("void"),
    @SerialName("T") T("T"),
    @SerialName("boolean") NameBoolean("boolean"),
    @SerialName("BaseClass") BaseClass("BaseClass"),
    @SerialName("any") NameAny("any"),
    @SerialName("Array") NameArray("Array"),
    @SerialName("MyNumber") MyNumber("MyNumber");
}

@Serializable
enum class TypeEnum(val value: String) {
    @SerialName("intrinsic") Intrinsic("intrinsic"),
    @SerialName("reflection") Reflection("reflection"),
    @SerialName("array") TypeArray("array"),
    @SerialName("reference") Reference("reference"),
    @SerialName("typeParameter") TypeParameter("typeParameter"),
    @SerialName("tuple") Tuple("tuple"),
    @SerialName("union") Union("union"),
    @SerialName("stringLiteral") StringLiteral("stringLiteral");
}

@Serializable
data class FluffyComment (
    val text: String
)

@Serializable
data class FluffyFlags (
    val isOptional: Boolean? = null
)

@Serializable
data class Source (
    val character: Long,
    val fileName: FileName,
    val line: Long
)

@Serializable
enum class FileName(val value: String) {
    @SerialName("modules.ts") ModulesTs("modules.ts"),
    @SerialName("classes.ts") ClassesTs("classes.ts"),
    @SerialName("flattened.ts") FlattenedTs("flattened.ts"),
    @SerialName("access.ts") AccessTs("access.ts"),
    @SerialName("default-export.ts") DefaultExportTs("default-export.ts"),
    @SerialName("enumerations.ts") EnumerationsTs("enumerations.ts"),
    @SerialName("functions.ts") FunctionsTs("functions.ts"),
    @SerialName("generics.ts") GenericsTs("generics.ts"),
    @SerialName("single-export.ts") SingleExportTs("single-export.ts"),
    @SerialName("typescript-1.3.ts") Typescript13Ts("typescript-1.3.ts"),
    @SerialName("typescript-1.4.ts") Typescript14Ts("typescript-1.4.ts"),
    @SerialName("typescript-1.5.ts") Typescript15Ts("typescript-1.5.ts"),
    @SerialName("variables.ts") VariablesTs("variables.ts");
}

@Serializable
data class GetSignatureComment (
    val returns: String? = null,
    val shortText: String? = null,
    val text: String? = null
)

@Serializable
data class Group (
    val children: List<Long>,
    val kind: Long,
    val title: String
)

@Serializable
data class GetSignatureParameter (
    val comment: TentacledComment? = null,
    val flags: TentacledFlags,
    val id: Long,
    val kind: Long,
    val kindString: ParameterKindString,
    val name: String,
    val type: FluffyType
)

@Serializable
data class TentacledComment (
    val shortText: String? = null,
    val text: String? = null
)

@Serializable
data class TentacledFlags (
    val isOptional: Boolean? = null,

    @SerialName("isRest")
    val isREST: Boolean? = null
)

@Serializable
enum class ParameterKindString(val value: String) {
    @SerialName("Parameter") Parameter("Parameter");
}

@Serializable
data class FluffyType (
    val elementType: ElementType? = null,
    val name: Name? = null,
    val type: TypeEnum,
    val typeArguments: List<ElementType>? = null
)

@Serializable
data class TentacledType (
    val declaration: PurpleDeclaration? = null,
    val name: Name? = null,
    val type: TypeEnum
)

@Serializable
data class PurpleDeclaration (
    val children: List<GetSignature>,
    val flags: GetSignatureFlags,
    val groups: List<Group>,
    val id: Long,
    val kind: Long,
    val kindString: String,
    val name: String
)

@Serializable
data class TypeElement (
    val declaration: GetSignature? = null,
    val elementType: ElementType? = null,
    val name: Name? = null,
    val type: TypeEnum,
    val typeArguments: List<ElementType>? = null
)

@Serializable
data class StickyComment (
    val returns: String? = null,
    val shortText: String? = null,
    val tags: List<Tag>? = null,
    val text: String? = null
)

@Serializable
data class Tag (
    val tag: String,
    val text: String
)

@Serializable
data class StickyFlags (
    val isAbstract: Boolean? = null,
    val isConstructorProperty: Boolean? = null,
    val isExported: Boolean? = null,
    val isPrivate: Boolean? = null,
    val isProtected: Boolean? = null,
    val isPublic: Boolean? = null,
    val isStatic: Boolean? = null
)

@Serializable
data class ExtendedBy (
    val constraint: ExtendedBy? = null,
    val id: Long? = null,
    val name: String,
    val type: TypeEnum,
    val typeArguments: List<ExtendedBy>? = null
)

@Serializable
data class FluffySignature (
    val comment: StickyComment? = null,
    val flags: IndigoFlags,
    val id: Long,
    val implementationOf: ExtendedBy? = null,
    val inheritedFrom: ExtendedBy? = null,
    val kind: Long,
    val kindString: SignatureKindString,
    val name: String,
    val overwrites: ExtendedBy? = null,
    val parameters: List<PurpleParameter>? = null,
    val type: ExtendedBy,
    val typeParameter: List<GetSignature>? = null
)

@Serializable
data class IndigoFlags (
    val isPrivate: Boolean? = null,
    val isProtected: Boolean? = null
)

@Serializable
data class PurpleParameter (
    val comment: TentacledComment? = null,
    val flags: GetSignatureFlags,
    val id: Long,
    val kind: Long,
    val kindString: ParameterKindString,
    val name: String,
    val type: StickyType
)

@Serializable
data class StickyType (
    val constraint: ExtendedBy? = null,
    val declaration: GetSignature? = null,
    val elementType: ElementType? = null,
    val elements: List<ExtendedBy>? = null,
    val id: Long? = null,
    val name: String? = null,
    val type: TypeEnum,
    val typeArguments: List<ElementType>? = null
)

@Serializable
data class IndigoType (
    val constraint: ExtendedBy? = null,
    val declaration: FluffyDeclaration? = null,
    val elementType: ExtendedBy? = null,
    val elements: List<ElementType>? = null,
    val id: Long? = null,
    val name: String? = null,
    val type: TypeEnum,
    val typeArguments: List<PurpleTypeArgument>? = null,
    val types: List<TypeElement>? = null
)

@Serializable
data class FluffyDeclaration (
    val children: List<StickyChild>? = null,
    val flags: GetSignatureFlags,
    val groups: List<Group>? = null,
    val id: Long,
    val indexSignature: IndexSignature? = null,
    val kind: Long,
    val kindString: String,
    val name: String,
    val signatures: List<TentacledSignature>? = null,
    val sources: List<Source>
)

@Serializable
data class StickyChild (
    val comment: FluffyComment? = null,
    val flags: FluffyFlags,
    val id: Long,
    val kind: Long,
    val kindString: PurpleKindString,
    val name: String,
    val sources: List<Source>,
    val type: IndecentType
)

@Serializable
data class IndecentType (
    val declaration: GetSignature? = null,
    val elements: List<ElementType>? = null,
    val name: Name? = null,
    val type: TypeEnum
)

@Serializable
data class IndexSignature (
    val flags: GetSignatureFlags,
    val id: Long,
    val kind: Long,
    val kindString: String,
    val name: String,
    val parameters: List<GetSignature>,
    val type: HilariousType
)

@Serializable
data class HilariousType (
    val declaration: GetSignature,
    val type: TypeEnum
)

@Serializable
data class TentacledSignature (
    val comment: IndigoComment? = null,
    val flags: GetSignatureFlags,
    val id: Long,
    val kind: Long,
    val kindString: SignatureKindString,
    val name: String,
    val parameters: List<FluffyParameter>? = null,
    val type: ExtendedBy
)

@Serializable
data class IndigoComment (
    val returns: String,
    val shortText: String
)

@Serializable
data class FluffyParameter (
    val comment: FluffyComment? = null,
    val flags: FluffyFlags,
    val id: Long,
    val kind: Long,
    val kindString: String,
    val name: String,
    val sources: List<Source>? = null,
    val type: ElementType
)

@Serializable
data class PurpleTypeArgument (
    val operator: String,
    val target: ElementType,
    val type: String
)

@Serializable
data class IndecentFlags (
    val hasExportAssignment: Boolean? = null,
    val isAbstract: Boolean? = null,
    val isConst: Boolean? = null,
    val isExported: Boolean? = null,
    val isLet: Boolean? = null,
    val isPrivate: Boolean? = null,
    val isProtected: Boolean? = null
)

@Serializable
enum class FluffyKindString(val value: String) {
    @SerialName("Module") Module("Module"),
    @SerialName("Class") KindStringClass("Class"),
    @SerialName("Variable") Variable("Variable"),
    @SerialName("Function") Function("Function"),
    @SerialName("Interface") Interface("Interface"),
    @SerialName("Enumeration") Enumeration("Enumeration"),
    @SerialName("Object literal") ObjectLiteral("Object literal"),
    @SerialName("Type alias") TypeAlias("Type alias");
}

@Serializable
data class StickySignature (
    val comment: StickyComment,
    val flags: IndigoFlags,
    val id: Long,
    val kind: Long,
    val kindString: SignatureKindString,
    val name: String,
    val parameters: List<TentacledParameter>? = null,
    val type: CunningType,
    val typeParameter: List<GetSignature>? = null
)

@Serializable
data class TentacledParameter (
    val comment: TentacledComment? = null,
    val defaultValue: String? = null,
    val flags: TentacledFlags,
    val id: Long,
    val kind: Long,
    val kindString: ParameterKindString,
    val name: String,
    val originalName: String? = null,
    val type: AmbitiousType
)

@Serializable
data class AmbitiousType (
    val declaration: TentacledDeclaration? = null,
    val elementType: ElementType? = null,
    val id: Long? = null,
    val name: String? = null,
    val type: TypeEnum,
    val typeArguments: List<ElementType>? = null
)

@Serializable
data class TentacledDeclaration (
    val children: List<IndigoChild>? = null,
    val flags: GetSignatureFlags,
    val groups: List<Group>? = null,
    val id: Long,
    val indexSignature: IndexSignatureElement? = null,
    val kind: Long,
    val kindString: String,
    val name: String,
    val signatures: List<GetSignature>? = null,
    val sources: List<Source>
)

@Serializable
data class IndigoChild (
    val comment: FluffyComment,
    val defaultValue: String? = null,
    val flags: FluffyFlags,
    val id: Long,
    val kind: Long,
    val kindString: PurpleKindString,
    val name: String,
    val sources: List<Source>,
    val type: IndecentType
)

@Serializable
data class CunningType (
    val declaration: PurpleDeclaration? = null,
    val id: Long? = null,
    val name: Name? = null,
    val type: TypeEnum,
    val typeArguments: List<ElementType>? = null
)

@Serializable
data class MagentaType (
    val declaration: StickyDeclaration? = null,
    val elementType: ElementType? = null,
    val elements: List<ExtendedBy>? = null,
    val id: Long? = null,
    val name: String? = null,
    val type: TypeEnum,
    val typeArguments: List<FluffyTypeArgument>? = null,
    val types: List<ExtendedBy>? = null,
    val value: String? = null
)

@Serializable
data class StickyDeclaration (
    val children: List<IndecentChild>? = null,
    val flags: GetSignatureFlags,
    val groups: List<Group>? = null,
    val id: Long,
    val kind: Long,
    val kindString: String,
    val name: String,
    val signatures: List<GetSignature>,
    val sources: List<Source>
)

@Serializable
data class IndecentChild (
    val flags: FluffyFlags,
    val id: Long,
    val kind: Long,
    val kindString: PurpleKindString,
    val name: String,
    val sources: List<Source>,
    val type: FriskyType
)

@Serializable
data class FriskyType (
    val declaration: IndigoDeclaration? = null,
    val name: Name? = null,
    val type: TypeEnum
)

@Serializable
data class IndigoDeclaration (
    val children: List<GetSignature>? = null,
    val flags: GetSignatureFlags,
    val groups: List<Group>? = null,
    val id: Long,
    val kind: Long,
    val kindString: String,
    val name: String,
    val signatures: List<GetSignature>? = null,
    val sources: List<Source>
)

@Serializable
data class FluffyTypeArgument (
    val type: TypeEnum,
    val types: List<ElementType>
)

@Serializable
data class TypeParameter (
    val comment: PurpleComment? = null,
    val flags: GetSignatureFlags,
    val id: Long,
    val kind: Long,
    val kindString: String,
    val name: String,
    val type: MischievousType? = null
)

@Serializable
data class MischievousType (
    val id: Long? = null,
    val name: Name? = null,
    val operator: String? = null,
    val target: ElementType? = null,
    val type: String
)

@Serializable
data class IndecentComment (
    val shortText: String,
    val tags: List<Tag>? = null
)

@Serializable
enum class TentacledKindString(val value: String) {
    @SerialName("External module") ExternalModule("External module");
}
