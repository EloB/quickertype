// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private fun <T> Klaxon.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonValue) -> T, toJson: (T) -> String, isUnion: Boolean = false) =
    this.converter(object: Converter {
        @Suppress("UNCHECKED_CAST")
        override fun toJson(value: Any)        = toJson(value as T)
        override fun fromJson(jv: JsonValue)   = fromJson(jv) as Any
        override fun canConvert(cls: Class<*>) = cls == k.java || (isUnion && cls.superclass == k.java)
    })

private val klaxon = Klaxon()
    .convert(JsonObject::class,          { it.obj!! },                                   { it.toJsonString() })
    .convert(PurpleKindString::class,    { PurpleKindString.fromValue(it.string!!) },    { Klaxon().toJsonString(it.value) })
    .convert(SignatureKindString::class, { SignatureKindString.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(Name::class,                { Name.fromValue(it.string!!) },                { Klaxon().toJsonString(it.value) })
    .convert(TypeEnum::class,            { TypeEnum.fromValue(it.string!!) },            { Klaxon().toJsonString(it.value) })
    .convert(FileName::class,            { FileName.fromValue(it.string!!) },            { Klaxon().toJsonString(it.value) })
    .convert(ParameterKindString::class, { ParameterKindString.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(FluffyKindString::class,    { FluffyKindString.fromValue(it.string!!) },    { Klaxon().toJsonString(it.value) })
    .convert(TentacledKindString::class, { TentacledKindString.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })

data class TopLevel (
    val children: List<TopLevelChild>,
    val flags: GetSignatureFlags,
    val groups: List<Group>,
    val id: Long,
    val kind: Long,
    val name: String
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

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

data class PurpleComment (
    val shortText: String
)

data class PurpleFlags (
    val isExported: Boolean? = null
)

enum class PurpleKindString(val value: String) {
    Variable("Variable"),
    Function("Function"),
    Property("Property"),
    Method("Method"),
    Constructor("Constructor"),
    Accessor("Accessor"),
    EnumerationMember("Enumeration member"),
    Module("Module"),
    ObjectLiteral("Object literal");

    companion object {
        public fun fromValue(value: String): PurpleKindString = when (value) {
            "Variable"           -> Variable
            "Function"           -> Function
            "Property"           -> Property
            "Method"             -> Method
            "Constructor"        -> Constructor
            "Accessor"           -> Accessor
            "Enumeration member" -> EnumerationMember
            "Module"             -> Module
            "Object literal"     -> ObjectLiteral
            else                 -> throw IllegalArgumentException()
        }
    }
}

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

typealias GetSignatureFlags = JsonObject

enum class SignatureKindString(val value: String) {
    CallSignature("Call signature"),
    ConstructorSignature("Constructor signature");

    companion object {
        public fun fromValue(value: String): SignatureKindString = when (value) {
            "Call signature"        -> CallSignature
            "Constructor signature" -> ConstructorSignature
            else                    -> throw IllegalArgumentException()
        }
    }
}

data class GetSignatureType (
    val declaration: GetSignature? = null,
    val elementType: ElementType? = null,
    val name: Name? = null,
    val type: TypeEnum
)

data class IndexSignatureElement (
    val flags: GetSignatureFlags,
    val id: Long,
    val kind: Long,
    val kindString: String,
    val name: String,
    val parameters: List<GetSignature>? = null,
    val type: PurpleType
)

data class PurpleType (
    val declaration: GetSignature? = null,
    val name: Name? = null,
    val type: TypeEnum
)

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

data class ElementType (
    val name: Name,
    val type: TypeEnum
)

enum class Name(val value: String) {
    NameString("string"),
    Number("number"),
    Void("void"),
    T("T"),
    NameBoolean("boolean"),
    BaseClass("BaseClass"),
    NameAny("any"),
    NameArray("Array"),
    MyNumber("MyNumber");

    companion object {
        public fun fromValue(value: String): Name = when (value) {
            "string"    -> NameString
            "number"    -> Number
            "void"      -> Void
            "T"         -> T
            "boolean"   -> NameBoolean
            "BaseClass" -> BaseClass
            "any"       -> NameAny
            "Array"     -> NameArray
            "MyNumber"  -> MyNumber
            else        -> throw IllegalArgumentException()
        }
    }
}

enum class TypeEnum(val value: String) {
    Intrinsic("intrinsic"),
    Reflection("reflection"),
    TypeArray("array"),
    Reference("reference"),
    TypeParameter("typeParameter"),
    Tuple("tuple"),
    Union("union"),
    StringLiteral("stringLiteral");

    companion object {
        public fun fromValue(value: String): TypeEnum = when (value) {
            "intrinsic"     -> Intrinsic
            "reflection"    -> Reflection
            "array"         -> TypeArray
            "reference"     -> Reference
            "typeParameter" -> TypeParameter
            "tuple"         -> Tuple
            "union"         -> Union
            "stringLiteral" -> StringLiteral
            else            -> throw IllegalArgumentException()
        }
    }
}

data class FluffyComment (
    val text: String
)

data class FluffyFlags (
    val isOptional: Boolean? = null
)

data class Source (
    val character: Long,
    val fileName: FileName,
    val line: Long
)

enum class FileName(val value: String) {
    ModulesTs("modules.ts"),
    ClassesTs("classes.ts"),
    FlattenedTs("flattened.ts"),
    AccessTs("access.ts"),
    DefaultExportTs("default-export.ts"),
    EnumerationsTs("enumerations.ts"),
    FunctionsTs("functions.ts"),
    GenericsTs("generics.ts"),
    SingleExportTs("single-export.ts"),
    Typescript13Ts("typescript-1.3.ts"),
    Typescript14Ts("typescript-1.4.ts"),
    Typescript15Ts("typescript-1.5.ts"),
    VariablesTs("variables.ts");

    companion object {
        public fun fromValue(value: String): FileName = when (value) {
            "modules.ts"        -> ModulesTs
            "classes.ts"        -> ClassesTs
            "flattened.ts"      -> FlattenedTs
            "access.ts"         -> AccessTs
            "default-export.ts" -> DefaultExportTs
            "enumerations.ts"   -> EnumerationsTs
            "functions.ts"      -> FunctionsTs
            "generics.ts"       -> GenericsTs
            "single-export.ts"  -> SingleExportTs
            "typescript-1.3.ts" -> Typescript13Ts
            "typescript-1.4.ts" -> Typescript14Ts
            "typescript-1.5.ts" -> Typescript15Ts
            "variables.ts"      -> VariablesTs
            else                -> throw IllegalArgumentException()
        }
    }
}

data class GetSignatureComment (
    val returns: String? = null,
    val shortText: String? = null,
    val text: String? = null
)

data class Group (
    val children: List<Long>,
    val kind: Long,
    val title: String
)

data class GetSignatureParameter (
    val comment: TentacledComment? = null,
    val flags: TentacledFlags,
    val id: Long,
    val kind: Long,
    val kindString: ParameterKindString,
    val name: String,
    val type: FluffyType
)

data class TentacledComment (
    val shortText: String? = null,
    val text: String? = null
)

data class TentacledFlags (
    val isOptional: Boolean? = null,

    @Json(name = "isRest")
    val isREST: Boolean? = null
)

enum class ParameterKindString(val value: String) {
    Parameter("Parameter");

    companion object {
        public fun fromValue(value: String): ParameterKindString = when (value) {
            "Parameter" -> Parameter
            else        -> throw IllegalArgumentException()
        }
    }
}

data class FluffyType (
    val elementType: ElementType? = null,
    val name: Name? = null,
    val type: TypeEnum,
    val typeArguments: List<ElementType>? = null
)

data class TentacledType (
    val declaration: PurpleDeclaration? = null,
    val name: Name? = null,
    val type: TypeEnum
)

data class PurpleDeclaration (
    val children: List<GetSignature>,
    val flags: GetSignatureFlags,
    val groups: List<Group>,
    val id: Long,
    val kind: Long,
    val kindString: String,
    val name: String
)

data class TypeElement (
    val declaration: GetSignature? = null,
    val elementType: ElementType? = null,
    val name: Name? = null,
    val type: TypeEnum,
    val typeArguments: List<ElementType>? = null
)

data class StickyComment (
    val returns: String? = null,
    val shortText: String? = null,
    val tags: List<Tag>? = null,
    val text: String? = null
)

data class Tag (
    val tag: String,
    val text: String
)

data class StickyFlags (
    val isAbstract: Boolean? = null,
    val isConstructorProperty: Boolean? = null,
    val isExported: Boolean? = null,
    val isPrivate: Boolean? = null,
    val isProtected: Boolean? = null,
    val isPublic: Boolean? = null,
    val isStatic: Boolean? = null
)

data class ExtendedBy (
    val constraint: ExtendedBy? = null,
    val id: Long? = null,
    val name: String,
    val type: TypeEnum,
    val typeArguments: List<ExtendedBy>? = null
)

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

data class IndigoFlags (
    val isPrivate: Boolean? = null,
    val isProtected: Boolean? = null
)

data class PurpleParameter (
    val comment: TentacledComment? = null,
    val flags: GetSignatureFlags,
    val id: Long,
    val kind: Long,
    val kindString: ParameterKindString,
    val name: String,
    val type: StickyType
)

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

data class IndecentType (
    val declaration: GetSignature? = null,
    val elements: List<ElementType>? = null,
    val name: Name? = null,
    val type: TypeEnum
)

data class IndexSignature (
    val flags: GetSignatureFlags,
    val id: Long,
    val kind: Long,
    val kindString: String,
    val name: String,
    val parameters: List<GetSignature>,
    val type: HilariousType
)

data class HilariousType (
    val declaration: GetSignature,
    val type: TypeEnum
)

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

data class IndigoComment (
    val returns: String,
    val shortText: String
)

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

data class PurpleTypeArgument (
    val operator: String,
    val target: ElementType,
    val type: String
)

data class IndecentFlags (
    val hasExportAssignment: Boolean? = null,
    val isAbstract: Boolean? = null,
    val isConst: Boolean? = null,
    val isExported: Boolean? = null,
    val isLet: Boolean? = null,
    val isPrivate: Boolean? = null,
    val isProtected: Boolean? = null
)

enum class FluffyKindString(val value: String) {
    Module("Module"),
    KindStringClass("Class"),
    Variable("Variable"),
    Function("Function"),
    Interface("Interface"),
    Enumeration("Enumeration"),
    ObjectLiteral("Object literal"),
    TypeAlias("Type alias");

    companion object {
        public fun fromValue(value: String): FluffyKindString = when (value) {
            "Module"         -> Module
            "Class"          -> KindStringClass
            "Variable"       -> Variable
            "Function"       -> Function
            "Interface"      -> Interface
            "Enumeration"    -> Enumeration
            "Object literal" -> ObjectLiteral
            "Type alias"     -> TypeAlias
            else             -> throw IllegalArgumentException()
        }
    }
}

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

data class AmbitiousType (
    val declaration: TentacledDeclaration? = null,
    val elementType: ElementType? = null,
    val id: Long? = null,
    val name: String? = null,
    val type: TypeEnum,
    val typeArguments: List<ElementType>? = null
)

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

data class CunningType (
    val declaration: PurpleDeclaration? = null,
    val id: Long? = null,
    val name: Name? = null,
    val type: TypeEnum,
    val typeArguments: List<ElementType>? = null
)

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

data class IndecentChild (
    val flags: FluffyFlags,
    val id: Long,
    val kind: Long,
    val kindString: PurpleKindString,
    val name: String,
    val sources: List<Source>,
    val type: FriskyType
)

data class FriskyType (
    val declaration: IndigoDeclaration? = null,
    val name: Name? = null,
    val type: TypeEnum
)

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

data class FluffyTypeArgument (
    val type: TypeEnum,
    val types: List<ElementType>
)

data class TypeParameter (
    val comment: PurpleComment? = null,
    val flags: GetSignatureFlags,
    val id: Long,
    val kind: Long,
    val kindString: String,
    val name: String,
    val type: MischievousType? = null
)

data class MischievousType (
    val id: Long? = null,
    val name: Name? = null,
    val operator: String? = null,
    val target: ElementType? = null,
    val type: String
)

data class IndecentComment (
    val shortText: String,
    val tags: List<Tag>? = null
)

enum class TentacledKindString(val value: String) {
    ExternalModule("External module");

    companion object {
        public fun fromValue(value: String): TentacledKindString = when (value) {
            "External module" -> ExternalModule
            else              -> throw IllegalArgumentException()
        }
    }
}
