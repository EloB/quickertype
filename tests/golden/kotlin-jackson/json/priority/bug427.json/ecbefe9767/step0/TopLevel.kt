// To parse the JSON, install jackson-module-kotlin and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.fasterxml.jackson.annotation.*
import com.fasterxml.jackson.core.*
import com.fasterxml.jackson.databind.*
import com.fasterxml.jackson.databind.deser.std.StdDeserializer
import com.fasterxml.jackson.databind.module.SimpleModule
import com.fasterxml.jackson.databind.node.*
import com.fasterxml.jackson.databind.ser.std.StdSerializer
import com.fasterxml.jackson.module.kotlin.*


@Suppress("UNCHECKED_CAST")
private fun <T> ObjectMapper.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonNode) -> T, toJson: (T) -> String, isUnion: Boolean = false) = registerModule(SimpleModule().apply {
    addSerializer(k.java as Class<T>, object : StdSerializer<T>(k.java as Class<T>) {
            override fun serialize(value: T, gen: JsonGenerator, provider: SerializerProvider) = gen.writeRawValue(toJson(value))
    })
    addDeserializer(k.java as Class<T>, object : StdDeserializer<T>(k.java as Class<T>) {
            override fun deserialize(p: JsonParser, ctxt: DeserializationContext) = fromJson(p.readValueAsTree())
    })
})

val mapper = jacksonObjectMapper().apply {
    propertyNamingStrategy = object : PropertyNamingStrategy.PropertyNamingStrategyBase() { override fun translate(name: String) = if (name == "empty") "" else name }
    setSerializationInclusion(JsonInclude.Include.NON_NULL)
    disable(DeserializationFeature.ACCEPT_FLOAT_AS_INT)
    convert(PurpleKindString::class,    { PurpleKindString.fromValue(it.asText()) },    { ObjectMapper().writeValueAsString(it.value) })
    convert(SignatureKindString::class, { SignatureKindString.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(Name::class,                { Name.fromValue(it.asText()) },                { ObjectMapper().writeValueAsString(it.value) })
    convert(TypeEnum::class,            { TypeEnum.fromValue(it.asText()) },            { ObjectMapper().writeValueAsString(it.value) })
    convert(FileName::class,            { FileName.fromValue(it.asText()) },            { ObjectMapper().writeValueAsString(it.value) })
    convert(ParameterKindString::class, { ParameterKindString.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(FluffyKindString::class,    { FluffyKindString.fromValue(it.asText()) },    { ObjectMapper().writeValueAsString(it.value) })
    convert(TentacledKindString::class, { TentacledKindString.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val children: List<TopLevelChild>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flags: GetSignatureFlags,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val groups: List<Group>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kind: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class TopLevelChild (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val children: List<PurpleChild>,

    val comment: IndecentComment? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flags: PurpleFlags,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val groups: List<Group>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kind: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kindString: TentacledKindString,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val originalName: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sources: List<Source>
)

data class PurpleChild (
    val children: List<FluffyChild>? = null,
    val comment: StickyComment? = null,
    val defaultValue: String? = null,
    val extendedBy: List<ExtendedBy>? = null,
    val extendedTypes: List<ExtendedBy>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flags: IndecentFlags,

    val groups: List<Group>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    val implementedBy: List<ExtendedBy>? = null,
    val implementedTypes: List<ExtendedBy>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kind: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kindString: FluffyKindString,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    val signatures: List<StickySignature>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sources: List<Source>,

    val type: MagentaType? = null,
    val typeParameter: List<TypeParameter>? = null
)

data class FluffyChild (
    val children: List<TentacledChild>? = null,
    val comment: StickyComment? = null,
    val defaultValue: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flags: StickyFlags,

    val getSignature: GetSignature? = null,
    val groups: List<Group>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    val implementationOf: ExtendedBy? = null,
    val inheritedFrom: ExtendedBy? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kind: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kindString: PurpleKindString,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    val overwrites: ExtendedBy? = null,
    val setSignature: GetSignature? = null,
    val signatures: List<FluffySignature>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sources: List<Source>,

    val type: IndigoType? = null
)

data class TentacledChild (
    val comment: PurpleComment? = null,
    val defaultValue: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flags: PurpleFlags,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kind: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kindString: PurpleKindString,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    val signatures: List<PurpleSignature>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sources: List<Source>,

    val type: TypeElement? = null
)

data class PurpleComment (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val shortText: String
)

data class PurpleFlags (
    @get:JsonProperty("isExported")@field:JsonProperty("isExported")
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
        fun fromValue(value: String): PurpleKindString = when (value) {
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

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flags: GetSignatureFlags,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kind: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kindString: SignatureKindString,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val parameters: List<GetSignature>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: TentacledType
)

typealias GetSignatureFlags = ObjectNode

enum class SignatureKindString(val value: String) {
    CallSignature("Call signature"),
    ConstructorSignature("Constructor signature");

    companion object {
        fun fromValue(value: String): SignatureKindString = when (value) {
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

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: TypeEnum
)

data class IndexSignatureElement (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flags: GetSignatureFlags,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kind: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kindString: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    val parameters: List<GetSignature>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: PurpleType
)

data class PurpleType (
    val declaration: GetSignature? = null,
    val name: Name? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: TypeEnum
)

data class GetSignatureChild (
    val comment: FluffyComment? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flags: FluffyFlags,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kind: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kindString: PurpleKindString,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sources: List<Source>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: PurpleType
)

data class GetSignature (
    val children: List<GetSignatureChild>? = null,
    val comment: GetSignatureComment? = null,
    val defaultValue: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flags: GetSignatureFlags,

    val groups: List<Group>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kind: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kindString: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    val parameters: List<GetSignatureParameter>? = null,
    val signatures: List<IndexSignatureElement>? = null,
    val sources: List<Source>? = null,
    val type: GetSignatureType? = null,
    val typeParameter: List<GetSignature>? = null
)

data class ElementType (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: Name,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
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
        fun fromValue(value: String): Name = when (value) {
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
        fun fromValue(value: String): TypeEnum = when (value) {
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
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val text: String
)

data class FluffyFlags (
    @get:JsonProperty("isOptional")@field:JsonProperty("isOptional")
    val isOptional: Boolean? = null
)

data class Source (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val character: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val fileName: FileName,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
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
        fun fromValue(value: String): FileName = when (value) {
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
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val children: List<Long>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kind: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val title: String
)

data class GetSignatureParameter (
    val comment: TentacledComment? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flags: TentacledFlags,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kind: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kindString: ParameterKindString,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: FluffyType
)

data class TentacledComment (
    val shortText: String? = null,
    val text: String? = null
)

data class TentacledFlags (
    @get:JsonProperty("isOptional")@field:JsonProperty("isOptional")
    val isOptional: Boolean? = null,

    @get:JsonProperty("isRest")@field:JsonProperty("isRest")
    val isREST: Boolean? = null
)

enum class ParameterKindString(val value: String) {
    Parameter("Parameter");

    companion object {
        fun fromValue(value: String): ParameterKindString = when (value) {
            "Parameter" -> Parameter
            else        -> throw IllegalArgumentException()
        }
    }
}

data class FluffyType (
    val elementType: ElementType? = null,
    val name: Name? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: TypeEnum,

    val typeArguments: List<ElementType>? = null
)

data class TentacledType (
    val declaration: PurpleDeclaration? = null,
    val name: Name? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: TypeEnum
)

data class PurpleDeclaration (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val children: List<GetSignature>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flags: GetSignatureFlags,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val groups: List<Group>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kind: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kindString: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String
)

data class TypeElement (
    val declaration: GetSignature? = null,
    val elementType: ElementType? = null,
    val name: Name? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
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
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tag: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val text: String
)

data class StickyFlags (
    @get:JsonProperty("isAbstract")@field:JsonProperty("isAbstract")
    val isAbstract: Boolean? = null,

    @get:JsonProperty("isConstructorProperty")@field:JsonProperty("isConstructorProperty")
    val isConstructorProperty: Boolean? = null,

    @get:JsonProperty("isExported")@field:JsonProperty("isExported")
    val isExported: Boolean? = null,

    @get:JsonProperty("isPrivate")@field:JsonProperty("isPrivate")
    val isPrivate: Boolean? = null,

    @get:JsonProperty("isProtected")@field:JsonProperty("isProtected")
    val isProtected: Boolean? = null,

    @get:JsonProperty("isPublic")@field:JsonProperty("isPublic")
    val isPublic: Boolean? = null,

    @get:JsonProperty("isStatic")@field:JsonProperty("isStatic")
    val isStatic: Boolean? = null
)

data class ExtendedBy (
    val constraint: ExtendedBy? = null,
    val id: Long? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: TypeEnum,

    val typeArguments: List<ExtendedBy>? = null
)

data class FluffySignature (
    val comment: StickyComment? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flags: IndigoFlags,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    val implementationOf: ExtendedBy? = null,
    val inheritedFrom: ExtendedBy? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kind: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kindString: SignatureKindString,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    val overwrites: ExtendedBy? = null,
    val parameters: List<PurpleParameter>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: ExtendedBy,

    val typeParameter: List<GetSignature>? = null
)

data class IndigoFlags (
    @get:JsonProperty("isPrivate")@field:JsonProperty("isPrivate")
    val isPrivate: Boolean? = null,

    @get:JsonProperty("isProtected")@field:JsonProperty("isProtected")
    val isProtected: Boolean? = null
)

data class PurpleParameter (
    val comment: TentacledComment? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flags: GetSignatureFlags,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kind: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kindString: ParameterKindString,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: StickyType
)

data class StickyType (
    val constraint: ExtendedBy? = null,
    val declaration: GetSignature? = null,
    val elementType: ElementType? = null,
    val elements: List<ExtendedBy>? = null,
    val id: Long? = null,
    val name: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
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

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: TypeEnum,

    val typeArguments: List<PurpleTypeArgument>? = null,
    val types: List<TypeElement>? = null
)

data class FluffyDeclaration (
    val children: List<StickyChild>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flags: GetSignatureFlags,

    val groups: List<Group>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    val indexSignature: IndexSignature? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kind: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kindString: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    val signatures: List<TentacledSignature>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sources: List<Source>
)

data class StickyChild (
    val comment: FluffyComment? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flags: FluffyFlags,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kind: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kindString: PurpleKindString,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sources: List<Source>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: IndecentType
)

data class IndecentType (
    val declaration: GetSignature? = null,
    val elements: List<ElementType>? = null,
    val name: Name? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: TypeEnum
)

data class IndexSignature (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flags: GetSignatureFlags,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kind: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kindString: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val parameters: List<GetSignature>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: HilariousType
)

data class HilariousType (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val declaration: GetSignature,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: TypeEnum
)

data class TentacledSignature (
    val comment: IndigoComment? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flags: GetSignatureFlags,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kind: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kindString: SignatureKindString,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    val parameters: List<FluffyParameter>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: ExtendedBy
)

data class IndigoComment (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val returns: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val shortText: String
)

data class FluffyParameter (
    val comment: FluffyComment? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flags: FluffyFlags,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kind: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kindString: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    val sources: List<Source>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: ElementType
)

data class PurpleTypeArgument (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val operator: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val target: ElementType,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: String
)

data class IndecentFlags (
    val hasExportAssignment: Boolean? = null,

    @get:JsonProperty("isAbstract")@field:JsonProperty("isAbstract")
    val isAbstract: Boolean? = null,

    @get:JsonProperty("isConst")@field:JsonProperty("isConst")
    val isConst: Boolean? = null,

    @get:JsonProperty("isExported")@field:JsonProperty("isExported")
    val isExported: Boolean? = null,

    @get:JsonProperty("isLet")@field:JsonProperty("isLet")
    val isLet: Boolean? = null,

    @get:JsonProperty("isPrivate")@field:JsonProperty("isPrivate")
    val isPrivate: Boolean? = null,

    @get:JsonProperty("isProtected")@field:JsonProperty("isProtected")
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
        fun fromValue(value: String): FluffyKindString = when (value) {
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
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val comment: StickyComment,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flags: IndigoFlags,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kind: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kindString: SignatureKindString,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    val parameters: List<TentacledParameter>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: CunningType,

    val typeParameter: List<GetSignature>? = null
)

data class TentacledParameter (
    val comment: TentacledComment? = null,
    val defaultValue: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flags: TentacledFlags,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kind: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kindString: ParameterKindString,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    val originalName: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: AmbitiousType
)

data class AmbitiousType (
    val declaration: TentacledDeclaration? = null,
    val elementType: ElementType? = null,
    val id: Long? = null,
    val name: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: TypeEnum,

    val typeArguments: List<ElementType>? = null
)

data class TentacledDeclaration (
    val children: List<IndigoChild>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flags: GetSignatureFlags,

    val groups: List<Group>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    val indexSignature: IndexSignatureElement? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kind: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kindString: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    val signatures: List<GetSignature>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sources: List<Source>
)

data class IndigoChild (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val comment: FluffyComment,

    val defaultValue: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flags: FluffyFlags,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kind: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kindString: PurpleKindString,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sources: List<Source>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: IndecentType
)

data class CunningType (
    val declaration: PurpleDeclaration? = null,
    val id: Long? = null,
    val name: Name? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: TypeEnum,

    val typeArguments: List<ElementType>? = null
)

data class MagentaType (
    val declaration: StickyDeclaration? = null,
    val elementType: ElementType? = null,
    val elements: List<ExtendedBy>? = null,
    val id: Long? = null,
    val name: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: TypeEnum,

    val typeArguments: List<FluffyTypeArgument>? = null,
    val types: List<ExtendedBy>? = null,
    val value: String? = null
)

data class StickyDeclaration (
    val children: List<IndecentChild>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flags: GetSignatureFlags,

    val groups: List<Group>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kind: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kindString: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val signatures: List<GetSignature>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sources: List<Source>
)

data class IndecentChild (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flags: FluffyFlags,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kind: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kindString: PurpleKindString,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sources: List<Source>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: FriskyType
)

data class FriskyType (
    val declaration: IndigoDeclaration? = null,
    val name: Name? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: TypeEnum
)

data class IndigoDeclaration (
    val children: List<GetSignature>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flags: GetSignatureFlags,

    val groups: List<Group>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kind: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kindString: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    val signatures: List<GetSignature>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sources: List<Source>
)

data class FluffyTypeArgument (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: TypeEnum,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val types: List<ElementType>
)

data class TypeParameter (
    val comment: PurpleComment? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flags: GetSignatureFlags,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kind: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val kindString: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    val type: MischievousType? = null
)

data class MischievousType (
    val id: Long? = null,
    val name: Name? = null,
    val operator: String? = null,
    val target: ElementType? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: String
)

data class IndecentComment (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val shortText: String,

    val tags: List<Tag>? = null
)

enum class TentacledKindString(val value: String) {
    ExternalModule("External module");

    companion object {
        fun fromValue(value: String): TentacledKindString = when (value) {
            "External module" -> ExternalModule
            else              -> throw IllegalArgumentException()
        }
    }
}
