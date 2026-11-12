require "json"

class TopLevel
  include JSON::Serializable

  property children : Array(TopLevelChild)

  property flags : GetSignatureFlags

  property groups : Array(Group)

  property id : Int64

  property kind : Int64

  property name : String
end

class TopLevelChild
  include JSON::Serializable

  property children : Array(PurpleChild)

  property comment : IndecentComment?

  property flags : PurpleFlags

  property groups : Array(Group)

  property id : Int64

  property kind : Int64

  @[JSON::Field(key: "kindString")]
  property kind_string : String

  property name : String

  @[JSON::Field(key: "originalName")]
  property original_name : String

  property sources : Array(Source)
end

class PurpleChild
  include JSON::Serializable

  @[JSON::Field(key: "type")]
  property child_type : MagentaType?

  property children : Array(FluffyChild)?

  property comment : StickyComment?

  @[JSON::Field(key: "defaultValue")]
  property default_value : String?

  @[JSON::Field(key: "extendedBy")]
  property extended_by : Array(ExtendedBy)?

  @[JSON::Field(key: "extendedTypes")]
  property extended_types : Array(ExtendedBy)?

  property flags : IndecentFlags

  property groups : Array(Group)?

  property id : Int64

  @[JSON::Field(key: "implementedBy")]
  property implemented_by : Array(ExtendedBy)?

  @[JSON::Field(key: "implementedTypes")]
  property implemented_types : Array(ExtendedBy)?

  property kind : Int64

  @[JSON::Field(key: "kindString")]
  property kind_string : String

  property name : String

  property signatures : Array(StickySignature)?

  property sources : Array(Source)

  @[JSON::Field(key: "typeParameter")]
  property type_parameter : Array(TypeParameter)?
end

class MagentaType
  include JSON::Serializable

  property declaration : StickyDeclaration?

  @[JSON::Field(key: "elementType")]
  property element_type : ElementType?

  property elements : Array(ExtendedBy)?

  property id : Int64?

  property name : String?

  @[JSON::Field(key: "typeArguments")]
  property type_arguments : Array(FluffyTypeArgument)?

  @[JSON::Field(key: "type")]
  property type_type : String

  property types : Array(ExtendedBy)?

  property value : String?
end

class StickyDeclaration
  include JSON::Serializable

  property children : Array(IndecentChild)?

  property flags : GetSignatureFlags

  property groups : Array(Group)?

  property id : Int64

  property kind : Int64

  @[JSON::Field(key: "kindString")]
  property kind_string : String

  property name : String

  property signatures : Array(GetSignature)

  property sources : Array(Source)
end

class IndecentChild
  include JSON::Serializable

  @[JSON::Field(key: "type")]
  property child_type : FriskyType

  property flags : FluffyFlags

  property id : Int64

  property kind : Int64

  @[JSON::Field(key: "kindString")]
  property kind_string : String

  property name : String

  property sources : Array(Source)
end

class FriskyType
  include JSON::Serializable

  property declaration : IndigoDeclaration?

  property name : String?

  @[JSON::Field(key: "type")]
  property type_type : String
end

class IndigoDeclaration
  include JSON::Serializable

  property children : Array(GetSignature)?

  property flags : GetSignatureFlags

  property groups : Array(Group)?

  property id : Int64

  property kind : Int64

  @[JSON::Field(key: "kindString")]
  property kind_string : String

  property name : String

  property signatures : Array(GetSignature)?

  property sources : Array(Source)
end

class IndexSignatureElement
  include JSON::Serializable

  property flags : GetSignatureFlags

  property id : Int64

  property kind : Int64

  @[JSON::Field(key: "kindString")]
  property kind_string : String

  property name : String

  property parameters : Array(GetSignature)?

  @[JSON::Field(key: "type")]
  property signature_type : PurpleType
end

class GetSignatureType
  include JSON::Serializable

  property declaration : GetSignature?

  @[JSON::Field(key: "elementType")]
  property element_type : ElementType?

  property name : String?

  @[JSON::Field(key: "type")]
  property type_type : String
end

class PurpleType
  include JSON::Serializable

  property declaration : GetSignature?

  property name : String?

  @[JSON::Field(key: "type")]
  property type_type : String
end

class GetSignatureChild
  include JSON::Serializable

  @[JSON::Field(key: "type")]
  property child_type : PurpleType

  property comment : FluffyComment?

  property flags : FluffyFlags

  property id : Int64

  property kind : Int64

  @[JSON::Field(key: "kindString")]
  property kind_string : String

  property name : String

  property sources : Array(Source)
end

class GetSignature
  include JSON::Serializable

  property children : Array(GetSignatureChild)?

  property comment : GetSignatureComment?

  @[JSON::Field(key: "defaultValue")]
  property default_value : String?

  property flags : GetSignatureFlags

  @[JSON::Field(key: "type")]
  property get_signature_type : GetSignatureType?

  property groups : Array(Group)?

  property id : Int64

  property kind : Int64

  @[JSON::Field(key: "kindString")]
  property kind_string : String

  property name : String

  property parameters : Array(GetSignatureParameter)?

  property signatures : Array(IndexSignatureElement)?

  property sources : Array(Source)?

  @[JSON::Field(key: "typeParameter")]
  property type_parameter : Array(GetSignature)?
end

class GetSignatureFlags
  include JSON::Serializable

end

class ElementType
  include JSON::Serializable

  @[JSON::Field(key: "type")]
  property element_type_type : String

  property name : String
end

class FluffyComment
  include JSON::Serializable

  property text : String
end

class FluffyFlags
  include JSON::Serializable

  @[JSON::Field(key: "isOptional")]
  property is_optional : Bool?
end

class Source
  include JSON::Serializable

  property character : Int64

  @[JSON::Field(key: "fileName")]
  property file_name : String

  property line : Int64
end

class GetSignatureComment
  include JSON::Serializable

  property returns : String?

  @[JSON::Field(key: "shortText")]
  property short_text : String?

  property text : String?
end

class Group
  include JSON::Serializable

  property children : Array(Int64)

  property kind : Int64

  property title : String
end

class GetSignatureParameter
  include JSON::Serializable

  property comment : TentacledComment?

  property flags : TentacledFlags

  property id : Int64

  property kind : Int64

  @[JSON::Field(key: "kindString")]
  property kind_string : String

  property name : String

  @[JSON::Field(key: "type")]
  property parameter_type : FluffyType
end

class TentacledComment
  include JSON::Serializable

  @[JSON::Field(key: "shortText")]
  property short_text : String?

  property text : String?
end

class TentacledFlags
  include JSON::Serializable

  @[JSON::Field(key: "isOptional")]
  property is_optional : Bool?

  @[JSON::Field(key: "isRest")]
  property is_rest : Bool?
end

class FluffyType
  include JSON::Serializable

  @[JSON::Field(key: "elementType")]
  property element_type : ElementType?

  property name : String?

  @[JSON::Field(key: "typeArguments")]
  property type_arguments : Array(ElementType)?

  @[JSON::Field(key: "type")]
  property type_type : String
end

class ExtendedBy
  include JSON::Serializable

  property constraint : ExtendedBy?

  @[JSON::Field(key: "type")]
  property extended_by_type : String

  property id : Int64?

  property name : String

  @[JSON::Field(key: "typeArguments")]
  property type_arguments : Array(ExtendedBy)?
end

class FluffyTypeArgument
  include JSON::Serializable

  @[JSON::Field(key: "type")]
  property type_argument_type : String

  property types : Array(ElementType)
end

class FluffyChild
  include JSON::Serializable

  @[JSON::Field(key: "type")]
  property child_type : IndigoType?

  property children : Array(TentacledChild)?

  property comment : StickyComment?

  @[JSON::Field(key: "defaultValue")]
  property default_value : String?

  property flags : StickyFlags

  @[JSON::Field(key: "getSignature")]
  property get_signature : GetSignature?

  property groups : Array(Group)?

  property id : Int64

  @[JSON::Field(key: "implementationOf")]
  property implementation_of : ExtendedBy?

  @[JSON::Field(key: "inheritedFrom")]
  property inherited_from : ExtendedBy?

  property kind : Int64

  @[JSON::Field(key: "kindString")]
  property kind_string : String

  property name : String

  property overwrites : ExtendedBy?

  @[JSON::Field(key: "setSignature")]
  property set_signature : GetSignature?

  property signatures : Array(FluffySignature)?

  property sources : Array(Source)
end

class IndigoType
  include JSON::Serializable

  property constraint : ExtendedBy?

  property declaration : FluffyDeclaration?

  @[JSON::Field(key: "elementType")]
  property element_type : ExtendedBy?

  property elements : Array(ElementType)?

  property id : Int64?

  property name : String?

  @[JSON::Field(key: "typeArguments")]
  property type_arguments : Array(PurpleTypeArgument)?

  @[JSON::Field(key: "type")]
  property type_type : String

  property types : Array(TypeElement)?
end

class FluffyDeclaration
  include JSON::Serializable

  property children : Array(StickyChild)?

  property flags : GetSignatureFlags

  property groups : Array(Group)?

  property id : Int64

  @[JSON::Field(key: "indexSignature")]
  property index_signature : IndexSignature?

  property kind : Int64

  @[JSON::Field(key: "kindString")]
  property kind_string : String

  property name : String

  property signatures : Array(TentacledSignature)?

  property sources : Array(Source)
end

class StickyChild
  include JSON::Serializable

  @[JSON::Field(key: "type")]
  property child_type : IndecentType

  property comment : FluffyComment?

  property flags : FluffyFlags

  property id : Int64

  property kind : Int64

  @[JSON::Field(key: "kindString")]
  property kind_string : String

  property name : String

  property sources : Array(Source)
end

class IndecentType
  include JSON::Serializable

  property declaration : GetSignature?

  property elements : Array(ElementType)?

  property name : String?

  @[JSON::Field(key: "type")]
  property type_type : String
end

class IndexSignature
  include JSON::Serializable

  property flags : GetSignatureFlags

  property id : Int64

  @[JSON::Field(key: "type")]
  property index_signature_type : HilariousType

  property kind : Int64

  @[JSON::Field(key: "kindString")]
  property kind_string : String

  property name : String

  property parameters : Array(GetSignature)
end

class HilariousType
  include JSON::Serializable

  property declaration : GetSignature

  @[JSON::Field(key: "type")]
  property type_type : String
end

class TentacledSignature
  include JSON::Serializable

  property comment : IndigoComment?

  property flags : GetSignatureFlags

  property id : Int64

  property kind : Int64

  @[JSON::Field(key: "kindString")]
  property kind_string : String

  property name : String

  property parameters : Array(FluffyParameter)?

  @[JSON::Field(key: "type")]
  property signature_type : ExtendedBy
end

class IndigoComment
  include JSON::Serializable

  property returns : String

  @[JSON::Field(key: "shortText")]
  property short_text : String
end

class FluffyParameter
  include JSON::Serializable

  property comment : FluffyComment?

  property flags : FluffyFlags

  property id : Int64

  property kind : Int64

  @[JSON::Field(key: "kindString")]
  property kind_string : String

  property name : String

  @[JSON::Field(key: "type")]
  property parameter_type : ElementType

  property sources : Array(Source)?
end

class PurpleTypeArgument
  include JSON::Serializable

  property operator : String

  property target : ElementType

  @[JSON::Field(key: "type")]
  property type_argument_type : String
end

class TypeElement
  include JSON::Serializable

  property declaration : GetSignature?

  @[JSON::Field(key: "elementType")]
  property element_type : ElementType?

  property name : String?

  @[JSON::Field(key: "typeArguments")]
  property type_arguments : Array(ElementType)?

  @[JSON::Field(key: "type")]
  property type_type : String
end

class TentacledChild
  include JSON::Serializable

  @[JSON::Field(key: "type")]
  property child_type : TypeElement?

  property comment : PurpleComment?

  @[JSON::Field(key: "defaultValue")]
  property default_value : String?

  property flags : PurpleFlags

  property id : Int64

  property kind : Int64

  @[JSON::Field(key: "kindString")]
  property kind_string : String

  property name : String

  property signatures : Array(PurpleSignature)?

  property sources : Array(Source)
end

class PurpleComment
  include JSON::Serializable

  @[JSON::Field(key: "shortText")]
  property short_text : String
end

class PurpleFlags
  include JSON::Serializable

  @[JSON::Field(key: "isExported")]
  property is_exported : Bool?
end

class PurpleSignature
  include JSON::Serializable

  property comment : PurpleComment?

  property flags : GetSignatureFlags

  property id : Int64

  property kind : Int64

  @[JSON::Field(key: "kindString")]
  property kind_string : String

  property name : String

  property parameters : Array(GetSignature)

  @[JSON::Field(key: "type")]
  property signature_type : TentacledType
end

class TentacledType
  include JSON::Serializable

  property declaration : PurpleDeclaration?

  property name : String?

  @[JSON::Field(key: "type")]
  property type_type : String
end

class PurpleDeclaration
  include JSON::Serializable

  property children : Array(GetSignature)

  property flags : GetSignatureFlags

  property groups : Array(Group)

  property id : Int64

  property kind : Int64

  @[JSON::Field(key: "kindString")]
  property kind_string : String

  property name : String
end

class StickyComment
  include JSON::Serializable

  property returns : String?

  @[JSON::Field(key: "shortText")]
  property short_text : String?

  property tags : Array(Tag)?

  property text : String?
end

class Tag
  include JSON::Serializable

  property tag : String

  property text : String
end

class StickyFlags
  include JSON::Serializable

  @[JSON::Field(key: "isAbstract")]
  property is_abstract : Bool?

  @[JSON::Field(key: "isConstructorProperty")]
  property is_constructor_property : Bool?

  @[JSON::Field(key: "isExported")]
  property is_exported : Bool?

  @[JSON::Field(key: "isPrivate")]
  property is_private : Bool?

  @[JSON::Field(key: "isProtected")]
  property is_protected : Bool?

  @[JSON::Field(key: "isPublic")]
  property is_public : Bool?

  @[JSON::Field(key: "isStatic")]
  property is_static : Bool?
end

class FluffySignature
  include JSON::Serializable

  property comment : StickyComment?

  property flags : IndigoFlags

  property id : Int64

  @[JSON::Field(key: "implementationOf")]
  property implementation_of : ExtendedBy?

  @[JSON::Field(key: "inheritedFrom")]
  property inherited_from : ExtendedBy?

  property kind : Int64

  @[JSON::Field(key: "kindString")]
  property kind_string : String

  property name : String

  property overwrites : ExtendedBy?

  property parameters : Array(PurpleParameter)?

  @[JSON::Field(key: "type")]
  property signature_type : ExtendedBy

  @[JSON::Field(key: "typeParameter")]
  property type_parameter : Array(GetSignature)?
end

class IndigoFlags
  include JSON::Serializable

  @[JSON::Field(key: "isPrivate")]
  property is_private : Bool?

  @[JSON::Field(key: "isProtected")]
  property is_protected : Bool?
end

class PurpleParameter
  include JSON::Serializable

  property comment : TentacledComment?

  property flags : GetSignatureFlags

  property id : Int64

  property kind : Int64

  @[JSON::Field(key: "kindString")]
  property kind_string : String

  property name : String

  @[JSON::Field(key: "type")]
  property parameter_type : StickyType
end

class StickyType
  include JSON::Serializable

  property constraint : ExtendedBy?

  property declaration : GetSignature?

  @[JSON::Field(key: "elementType")]
  property element_type : ElementType?

  property elements : Array(ExtendedBy)?

  property id : Int64?

  property name : String?

  @[JSON::Field(key: "typeArguments")]
  property type_arguments : Array(ElementType)?

  @[JSON::Field(key: "type")]
  property type_type : String
end

class IndecentFlags
  include JSON::Serializable

  @[JSON::Field(key: "hasExportAssignment")]
  property has_export_assignment : Bool?

  @[JSON::Field(key: "isAbstract")]
  property is_abstract : Bool?

  @[JSON::Field(key: "isConst")]
  property is_const : Bool?

  @[JSON::Field(key: "isExported")]
  property is_exported : Bool?

  @[JSON::Field(key: "isLet")]
  property is_let : Bool?

  @[JSON::Field(key: "isPrivate")]
  property is_private : Bool?

  @[JSON::Field(key: "isProtected")]
  property is_protected : Bool?
end

class StickySignature
  include JSON::Serializable

  property comment : StickyComment

  property flags : IndigoFlags

  property id : Int64

  property kind : Int64

  @[JSON::Field(key: "kindString")]
  property kind_string : String

  property name : String

  property parameters : Array(TentacledParameter)?

  @[JSON::Field(key: "type")]
  property signature_type : CunningType

  @[JSON::Field(key: "typeParameter")]
  property type_parameter : Array(GetSignature)?
end

class TentacledParameter
  include JSON::Serializable

  property comment : TentacledComment?

  @[JSON::Field(key: "defaultValue")]
  property default_value : String?

  property flags : TentacledFlags

  property id : Int64

  property kind : Int64

  @[JSON::Field(key: "kindString")]
  property kind_string : String

  property name : String

  @[JSON::Field(key: "originalName")]
  property original_name : String?

  @[JSON::Field(key: "type")]
  property parameter_type : AmbitiousType
end

class AmbitiousType
  include JSON::Serializable

  property declaration : TentacledDeclaration?

  @[JSON::Field(key: "elementType")]
  property element_type : ElementType?

  property id : Int64?

  property name : String?

  @[JSON::Field(key: "typeArguments")]
  property type_arguments : Array(ElementType)?

  @[JSON::Field(key: "type")]
  property type_type : String
end

class TentacledDeclaration
  include JSON::Serializable

  property children : Array(IndigoChild)?

  property flags : GetSignatureFlags

  property groups : Array(Group)?

  property id : Int64

  @[JSON::Field(key: "indexSignature")]
  property index_signature : IndexSignatureElement?

  property kind : Int64

  @[JSON::Field(key: "kindString")]
  property kind_string : String

  property name : String

  property signatures : Array(GetSignature)?

  property sources : Array(Source)
end

class IndigoChild
  include JSON::Serializable

  @[JSON::Field(key: "type")]
  property child_type : IndecentType

  property comment : FluffyComment

  @[JSON::Field(key: "defaultValue")]
  property default_value : String?

  property flags : FluffyFlags

  property id : Int64

  property kind : Int64

  @[JSON::Field(key: "kindString")]
  property kind_string : String

  property name : String

  property sources : Array(Source)
end

class CunningType
  include JSON::Serializable

  property declaration : PurpleDeclaration?

  property id : Int64?

  property name : String?

  @[JSON::Field(key: "typeArguments")]
  property type_arguments : Array(ElementType)?

  @[JSON::Field(key: "type")]
  property type_type : String
end

class TypeParameter
  include JSON::Serializable

  property comment : PurpleComment?

  property flags : GetSignatureFlags

  property id : Int64

  property kind : Int64

  @[JSON::Field(key: "kindString")]
  property kind_string : String

  property name : String

  @[JSON::Field(key: "type")]
  property type_parameter_type : MischievousType?
end

class MischievousType
  include JSON::Serializable

  property id : Int64?

  property name : String?

  property operator : String?

  property target : ElementType?

  @[JSON::Field(key: "type")]
  property type_type : String
end

class IndecentComment
  include JSON::Serializable

  @[JSON::Field(key: "shortText")]
  property short_text : String

  property tags : Array(Tag)?
end
