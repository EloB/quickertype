package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val children : Seq[TopLevelChild],
    val flags : GetSignatureFlags,
    val groups : Seq[Group],
    val id : Long,
    val kind : Long,
    val name : String
) derives Encoder.AsObject, Decoder

case class TopLevelChild (
    val children : Seq[PurpleChild],
    val comment : Option[IndecentComment] = None,
    val flags : PurpleFlags,
    val groups : Seq[Group],
    val id : Long,
    val kind : Long,
    val kindString : TentacledKindString,
    val name : String,
    val originalName : String,
    val sources : Seq[Source]
) derives Encoder.AsObject, Decoder

case class PurpleChild (
    val `type` : Option[MagentaType] = None,
    val children : Option[Seq[FluffyChild]] = None,
    val comment : Option[StickyComment] = None,
    val defaultValue : Option[String] = None,
    val extendedBy : Option[Seq[ExtendedBy]] = None,
    val extendedTypes : Option[Seq[ExtendedBy]] = None,
    val flags : IndecentFlags,
    val groups : Option[Seq[Group]] = None,
    val id : Long,
    val implementedBy : Option[Seq[ExtendedBy]] = None,
    val implementedTypes : Option[Seq[ExtendedBy]] = None,
    val kind : Long,
    val kindString : FluffyKindString,
    val name : String,
    val signatures : Option[Seq[StickySignature]] = None,
    val sources : Seq[Source],
    val typeParameter : Option[Seq[TypeParameter]] = None
) derives Encoder.AsObject, Decoder

case class MagentaType (
    val declaration : Option[StickyDeclaration] = None,
    val elementType : Option[ElementType] = None,
    val elements : Option[Seq[ExtendedBy]] = None,
    val id : Option[Long] = None,
    val name : Option[String] = None,
    val typeArguments : Option[Seq[FluffyTypeArgument]] = None,
    val `type` : TypeEnum,
    val types : Option[Seq[ExtendedBy]] = None,
    val value : Option[String] = None
) derives Encoder.AsObject, Decoder

case class StickyDeclaration (
    val children : Option[Seq[IndecentChild]] = None,
    val flags : GetSignatureFlags,
    val groups : Option[Seq[Group]] = None,
    val id : Long,
    val kind : Long,
    val kindString : String,
    val name : String,
    val signatures : Seq[GetSignature],
    val sources : Seq[Source]
) derives Encoder.AsObject, Decoder

case class IndecentChild (
    val `type` : FriskyType,
    val flags : FluffyFlags,
    val id : Long,
    val kind : Long,
    val kindString : PurpleKindString,
    val name : String,
    val sources : Seq[Source]
) derives Encoder.AsObject, Decoder

case class FriskyType (
    val declaration : Option[IndigoDeclaration] = None,
    val name : Option[Name] = None,
    val `type` : TypeEnum
) derives Encoder.AsObject, Decoder

case class IndigoDeclaration (
    val children : Option[Seq[GetSignature]] = None,
    val flags : GetSignatureFlags,
    val groups : Option[Seq[Group]] = None,
    val id : Long,
    val kind : Long,
    val kindString : String,
    val name : String,
    val signatures : Option[Seq[GetSignature]] = None,
    val sources : Seq[Source]
) derives Encoder.AsObject, Decoder

case class IndexSignatureElement (
    val flags : GetSignatureFlags,
    val id : Long,
    val kind : Long,
    val kindString : String,
    val name : String,
    val parameters : Option[Seq[GetSignature]] = None,
    val `type` : PurpleType
) derives Encoder.AsObject, Decoder

case class GetSignatureType (
    val declaration : Option[GetSignature] = None,
    val elementType : Option[ElementType] = None,
    val name : Option[Name] = None,
    val `type` : TypeEnum
) derives Encoder.AsObject, Decoder

case class PurpleType (
    val declaration : Option[GetSignature] = None,
    val name : Option[Name] = None,
    val `type` : TypeEnum
) derives Encoder.AsObject, Decoder

case class GetSignatureChild (
    val `type` : PurpleType,
    val comment : Option[FluffyComment] = None,
    val flags : FluffyFlags,
    val id : Long,
    val kind : Long,
    val kindString : PurpleKindString,
    val name : String,
    val sources : Seq[Source]
) derives Encoder.AsObject, Decoder

case class GetSignature (
    val children : Option[Seq[GetSignatureChild]] = None,
    val comment : Option[GetSignatureComment] = None,
    val defaultValue : Option[String] = None,
    val flags : GetSignatureFlags,
    val `type` : Option[GetSignatureType] = None,
    val groups : Option[Seq[Group]] = None,
    val id : Long,
    val kind : Long,
    val kindString : String,
    val name : String,
    val parameters : Option[Seq[GetSignatureParameter]] = None,
    val signatures : Option[Seq[IndexSignatureElement]] = None,
    val sources : Option[Seq[Source]] = None,
    val typeParameter : Option[Seq[GetSignature]] = None
) derives Encoder.AsObject, Decoder

case class GetSignatureFlags()  derives Encoder.AsObject, Decoder

case class ElementType (
    val `type` : TypeEnum,
    val name : Name
) derives Encoder.AsObject, Decoder

enum TypeEnum : 
    case Intrinsic
    case Reflection
    case TypeArray
    case Reference
    case TypeParameter
    case Tuple
    case Union
    case StringLiteral

given Decoder[TypeEnum] = Decoder.decodeString.emap {
    case "intrinsic" => scala.Right(TypeEnum.Intrinsic)
    case "reflection" => scala.Right(TypeEnum.Reflection)
    case "array" => scala.Right(TypeEnum.TypeArray)
    case "reference" => scala.Right(TypeEnum.Reference)
    case "typeParameter" => scala.Right(TypeEnum.TypeParameter)
    case "tuple" => scala.Right(TypeEnum.Tuple)
    case "union" => scala.Right(TypeEnum.Union)
    case "stringLiteral" => scala.Right(TypeEnum.StringLiteral)
    case other => scala.Left("invalid TypeEnum: " + other)
}
given Encoder[TypeEnum] = Encoder.encodeString.contramap {
    case TypeEnum.Intrinsic => "intrinsic"
    case TypeEnum.Reflection => "reflection"
    case TypeEnum.TypeArray => "array"
    case TypeEnum.Reference => "reference"
    case TypeEnum.TypeParameter => "typeParameter"
    case TypeEnum.Tuple => "tuple"
    case TypeEnum.Union => "union"
    case TypeEnum.StringLiteral => "stringLiteral"
}

enum Name : 
    case NameString
    case Number
    case Void
    case T
    case NameBoolean
    case BaseClass
    case NameAny
    case NameArray
    case MyNumber

given Decoder[Name] = Decoder.decodeString.emap {
    case "string" => scala.Right(Name.NameString)
    case "number" => scala.Right(Name.Number)
    case "void" => scala.Right(Name.Void)
    case "T" => scala.Right(Name.T)
    case "boolean" => scala.Right(Name.NameBoolean)
    case "BaseClass" => scala.Right(Name.BaseClass)
    case "any" => scala.Right(Name.NameAny)
    case "Array" => scala.Right(Name.NameArray)
    case "MyNumber" => scala.Right(Name.MyNumber)
    case other => scala.Left("invalid Name: " + other)
}
given Encoder[Name] = Encoder.encodeString.contramap {
    case Name.NameString => "string"
    case Name.Number => "number"
    case Name.Void => "void"
    case Name.T => "T"
    case Name.NameBoolean => "boolean"
    case Name.BaseClass => "BaseClass"
    case Name.NameAny => "any"
    case Name.NameArray => "Array"
    case Name.MyNumber => "MyNumber"
}

case class FluffyComment (
    val text : String
) derives Encoder.AsObject, Decoder

case class FluffyFlags (
    val isOptional : Option[Boolean] = None
) derives Encoder.AsObject, Decoder

enum PurpleKindString : 
    case Variable
    case Function
    case Property
    case Method
    case Constructor
    case Accessor
    case EnumerationMember
    case Module
    case ObjectLiteral

given Decoder[PurpleKindString] = Decoder.decodeString.emap {
    case "Variable" => scala.Right(PurpleKindString.Variable)
    case "Function" => scala.Right(PurpleKindString.Function)
    case "Property" => scala.Right(PurpleKindString.Property)
    case "Method" => scala.Right(PurpleKindString.Method)
    case "Constructor" => scala.Right(PurpleKindString.Constructor)
    case "Accessor" => scala.Right(PurpleKindString.Accessor)
    case "Enumeration member" => scala.Right(PurpleKindString.EnumerationMember)
    case "Module" => scala.Right(PurpleKindString.Module)
    case "Object literal" => scala.Right(PurpleKindString.ObjectLiteral)
    case other => scala.Left("invalid PurpleKindString: " + other)
}
given Encoder[PurpleKindString] = Encoder.encodeString.contramap {
    case PurpleKindString.Variable => "Variable"
    case PurpleKindString.Function => "Function"
    case PurpleKindString.Property => "Property"
    case PurpleKindString.Method => "Method"
    case PurpleKindString.Constructor => "Constructor"
    case PurpleKindString.Accessor => "Accessor"
    case PurpleKindString.EnumerationMember => "Enumeration member"
    case PurpleKindString.Module => "Module"
    case PurpleKindString.ObjectLiteral => "Object literal"
}

case class Source (
    val character : Long,
    val fileName : FileName,
    val line : Long
) derives Encoder.AsObject, Decoder

enum FileName : 
    case ModulesTs
    case ClassesTs
    case FlattenedTs
    case AccessTs
    case DefaultExportTs
    case EnumerationsTs
    case FunctionsTs
    case GenericsTs
    case SingleExportTs
    case Typescript13Ts
    case Typescript14Ts
    case Typescript15Ts
    case VariablesTs

given Decoder[FileName] = Decoder.decodeString.emap {
    case "modules.ts" => scala.Right(FileName.ModulesTs)
    case "classes.ts" => scala.Right(FileName.ClassesTs)
    case "flattened.ts" => scala.Right(FileName.FlattenedTs)
    case "access.ts" => scala.Right(FileName.AccessTs)
    case "default-export.ts" => scala.Right(FileName.DefaultExportTs)
    case "enumerations.ts" => scala.Right(FileName.EnumerationsTs)
    case "functions.ts" => scala.Right(FileName.FunctionsTs)
    case "generics.ts" => scala.Right(FileName.GenericsTs)
    case "single-export.ts" => scala.Right(FileName.SingleExportTs)
    case "typescript-1.3.ts" => scala.Right(FileName.Typescript13Ts)
    case "typescript-1.4.ts" => scala.Right(FileName.Typescript14Ts)
    case "typescript-1.5.ts" => scala.Right(FileName.Typescript15Ts)
    case "variables.ts" => scala.Right(FileName.VariablesTs)
    case other => scala.Left("invalid FileName: " + other)
}
given Encoder[FileName] = Encoder.encodeString.contramap {
    case FileName.ModulesTs => "modules.ts"
    case FileName.ClassesTs => "classes.ts"
    case FileName.FlattenedTs => "flattened.ts"
    case FileName.AccessTs => "access.ts"
    case FileName.DefaultExportTs => "default-export.ts"
    case FileName.EnumerationsTs => "enumerations.ts"
    case FileName.FunctionsTs => "functions.ts"
    case FileName.GenericsTs => "generics.ts"
    case FileName.SingleExportTs => "single-export.ts"
    case FileName.Typescript13Ts => "typescript-1.3.ts"
    case FileName.Typescript14Ts => "typescript-1.4.ts"
    case FileName.Typescript15Ts => "typescript-1.5.ts"
    case FileName.VariablesTs => "variables.ts"
}

case class GetSignatureComment (
    val returns : Option[String] = None,
    val shortText : Option[String] = None,
    val text : Option[String] = None
) derives Encoder.AsObject, Decoder

case class Group (
    val children : Seq[Long],
    val kind : Long,
    val title : String
) derives Encoder.AsObject, Decoder

case class GetSignatureParameter (
    val comment : Option[TentacledComment] = None,
    val flags : TentacledFlags,
    val id : Long,
    val kind : Long,
    val kindString : ParameterKindString,
    val name : String,
    val `type` : FluffyType
) derives Encoder.AsObject, Decoder

case class TentacledComment (
    val shortText : Option[String] = None,
    val text : Option[String] = None
) derives Encoder.AsObject, Decoder

case class TentacledFlags (
    val isOptional : Option[Boolean] = None,
    val isRest : Option[Boolean] = None
) derives Encoder.AsObject, Decoder

enum ParameterKindString : 
    case Parameter

given Decoder[ParameterKindString] = Decoder.decodeString.emap {
    case "Parameter" => scala.Right(ParameterKindString.Parameter)
    case other => scala.Left("invalid ParameterKindString: " + other)
}
given Encoder[ParameterKindString] = Encoder.encodeString.contramap {
    case ParameterKindString.Parameter => "Parameter"
}

case class FluffyType (
    val elementType : Option[ElementType] = None,
    val name : Option[Name] = None,
    val typeArguments : Option[Seq[ElementType]] = None,
    val `type` : TypeEnum
) derives Encoder.AsObject, Decoder

case class ExtendedBy (
    val constraint : Option[ExtendedBy] = None,
    val `type` : TypeEnum,
    val id : Option[Long] = None,
    val name : String,
    val typeArguments : Option[Seq[ExtendedBy]] = None
) derives Encoder.AsObject, Decoder

case class FluffyTypeArgument (
    val `type` : TypeEnum,
    val types : Seq[ElementType]
) derives Encoder.AsObject, Decoder

case class FluffyChild (
    val `type` : Option[IndigoType] = None,
    val children : Option[Seq[TentacledChild]] = None,
    val comment : Option[StickyComment] = None,
    val defaultValue : Option[String] = None,
    val flags : StickyFlags,
    val getSignature : Option[GetSignature] = None,
    val groups : Option[Seq[Group]] = None,
    val id : Long,
    val implementationOf : Option[ExtendedBy] = None,
    val inheritedFrom : Option[ExtendedBy] = None,
    val kind : Long,
    val kindString : PurpleKindString,
    val name : String,
    val overwrites : Option[ExtendedBy] = None,
    val setSignature : Option[GetSignature] = None,
    val signatures : Option[Seq[FluffySignature]] = None,
    val sources : Seq[Source]
) derives Encoder.AsObject, Decoder

case class IndigoType (
    val constraint : Option[ExtendedBy] = None,
    val declaration : Option[FluffyDeclaration] = None,
    val elementType : Option[ExtendedBy] = None,
    val elements : Option[Seq[ElementType]] = None,
    val id : Option[Long] = None,
    val name : Option[String] = None,
    val typeArguments : Option[Seq[PurpleTypeArgument]] = None,
    val `type` : TypeEnum,
    val types : Option[Seq[TypeElement]] = None
) derives Encoder.AsObject, Decoder

case class FluffyDeclaration (
    val children : Option[Seq[StickyChild]] = None,
    val flags : GetSignatureFlags,
    val groups : Option[Seq[Group]] = None,
    val id : Long,
    val indexSignature : Option[IndexSignature] = None,
    val kind : Long,
    val kindString : String,
    val name : String,
    val signatures : Option[Seq[TentacledSignature]] = None,
    val sources : Seq[Source]
) derives Encoder.AsObject, Decoder

case class StickyChild (
    val `type` : IndecentType,
    val comment : Option[FluffyComment] = None,
    val flags : FluffyFlags,
    val id : Long,
    val kind : Long,
    val kindString : PurpleKindString,
    val name : String,
    val sources : Seq[Source]
) derives Encoder.AsObject, Decoder

case class IndecentType (
    val declaration : Option[GetSignature] = None,
    val elements : Option[Seq[ElementType]] = None,
    val name : Option[Name] = None,
    val `type` : TypeEnum
) derives Encoder.AsObject, Decoder

case class IndexSignature (
    val flags : GetSignatureFlags,
    val id : Long,
    val `type` : HilariousType,
    val kind : Long,
    val kindString : String,
    val name : String,
    val parameters : Seq[GetSignature]
) derives Encoder.AsObject, Decoder

case class HilariousType (
    val declaration : GetSignature,
    val `type` : TypeEnum
) derives Encoder.AsObject, Decoder

case class TentacledSignature (
    val comment : Option[IndigoComment] = None,
    val flags : GetSignatureFlags,
    val id : Long,
    val kind : Long,
    val kindString : SignatureKindString,
    val name : String,
    val parameters : Option[Seq[FluffyParameter]] = None,
    val `type` : ExtendedBy
) derives Encoder.AsObject, Decoder

case class IndigoComment (
    val returns : String,
    val shortText : String
) derives Encoder.AsObject, Decoder

enum SignatureKindString : 
    case CallSignature
    case ConstructorSignature

given Decoder[SignatureKindString] = Decoder.decodeString.emap {
    case "Call signature" => scala.Right(SignatureKindString.CallSignature)
    case "Constructor signature" => scala.Right(SignatureKindString.ConstructorSignature)
    case other => scala.Left("invalid SignatureKindString: " + other)
}
given Encoder[SignatureKindString] = Encoder.encodeString.contramap {
    case SignatureKindString.CallSignature => "Call signature"
    case SignatureKindString.ConstructorSignature => "Constructor signature"
}

case class FluffyParameter (
    val comment : Option[FluffyComment] = None,
    val flags : FluffyFlags,
    val id : Long,
    val kind : Long,
    val kindString : String,
    val name : String,
    val `type` : ElementType,
    val sources : Option[Seq[Source]] = None
) derives Encoder.AsObject, Decoder

case class PurpleTypeArgument (
    val operator : String,
    val target : ElementType,
    val `type` : String
) derives Encoder.AsObject, Decoder

case class TypeElement (
    val declaration : Option[GetSignature] = None,
    val elementType : Option[ElementType] = None,
    val name : Option[Name] = None,
    val typeArguments : Option[Seq[ElementType]] = None,
    val `type` : TypeEnum
) derives Encoder.AsObject, Decoder

case class TentacledChild (
    val `type` : Option[TypeElement] = None,
    val comment : Option[PurpleComment] = None,
    val defaultValue : Option[String] = None,
    val flags : PurpleFlags,
    val id : Long,
    val kind : Long,
    val kindString : PurpleKindString,
    val name : String,
    val signatures : Option[Seq[PurpleSignature]] = None,
    val sources : Seq[Source]
) derives Encoder.AsObject, Decoder

case class PurpleComment (
    val shortText : String
) derives Encoder.AsObject, Decoder

case class PurpleFlags (
    val isExported : Option[Boolean] = None
) derives Encoder.AsObject, Decoder

case class PurpleSignature (
    val comment : Option[PurpleComment] = None,
    val flags : GetSignatureFlags,
    val id : Long,
    val kind : Long,
    val kindString : SignatureKindString,
    val name : String,
    val parameters : Seq[GetSignature],
    val `type` : TentacledType
) derives Encoder.AsObject, Decoder

case class TentacledType (
    val declaration : Option[PurpleDeclaration] = None,
    val name : Option[Name] = None,
    val `type` : TypeEnum
) derives Encoder.AsObject, Decoder

case class PurpleDeclaration (
    val children : Seq[GetSignature],
    val flags : GetSignatureFlags,
    val groups : Seq[Group],
    val id : Long,
    val kind : Long,
    val kindString : String,
    val name : String
) derives Encoder.AsObject, Decoder

case class StickyComment (
    val returns : Option[String] = None,
    val shortText : Option[String] = None,
    val tags : Option[Seq[Tag]] = None,
    val text : Option[String] = None
) derives Encoder.AsObject, Decoder

case class Tag (
    val tag : String,
    val text : String
) derives Encoder.AsObject, Decoder

case class StickyFlags (
    val isAbstract : Option[Boolean] = None,
    val isConstructorProperty : Option[Boolean] = None,
    val isExported : Option[Boolean] = None,
    val isPrivate : Option[Boolean] = None,
    val isProtected : Option[Boolean] = None,
    val isPublic : Option[Boolean] = None,
    val isStatic : Option[Boolean] = None
) derives Encoder.AsObject, Decoder

case class FluffySignature (
    val comment : Option[StickyComment] = None,
    val flags : IndigoFlags,
    val id : Long,
    val implementationOf : Option[ExtendedBy] = None,
    val inheritedFrom : Option[ExtendedBy] = None,
    val kind : Long,
    val kindString : SignatureKindString,
    val name : String,
    val overwrites : Option[ExtendedBy] = None,
    val parameters : Option[Seq[PurpleParameter]] = None,
    val `type` : ExtendedBy,
    val typeParameter : Option[Seq[GetSignature]] = None
) derives Encoder.AsObject, Decoder

case class IndigoFlags (
    val isPrivate : Option[Boolean] = None,
    val isProtected : Option[Boolean] = None
) derives Encoder.AsObject, Decoder

case class PurpleParameter (
    val comment : Option[TentacledComment] = None,
    val flags : GetSignatureFlags,
    val id : Long,
    val kind : Long,
    val kindString : ParameterKindString,
    val name : String,
    val `type` : StickyType
) derives Encoder.AsObject, Decoder

case class StickyType (
    val constraint : Option[ExtendedBy] = None,
    val declaration : Option[GetSignature] = None,
    val elementType : Option[ElementType] = None,
    val elements : Option[Seq[ExtendedBy]] = None,
    val id : Option[Long] = None,
    val name : Option[String] = None,
    val typeArguments : Option[Seq[ElementType]] = None,
    val `type` : TypeEnum
) derives Encoder.AsObject, Decoder

case class IndecentFlags (
    val hasExportAssignment : Option[Boolean] = None,
    val isAbstract : Option[Boolean] = None,
    val isConst : Option[Boolean] = None,
    val isExported : Option[Boolean] = None,
    val isLet : Option[Boolean] = None,
    val isPrivate : Option[Boolean] = None,
    val isProtected : Option[Boolean] = None
) derives Encoder.AsObject, Decoder

enum FluffyKindString : 
    case Module
    case Class
    case Variable
    case Function
    case Interface
    case Enumeration
    case ObjectLiteral
    case TypeAlias

given Decoder[FluffyKindString] = Decoder.decodeString.emap {
    case "Module" => scala.Right(FluffyKindString.Module)
    case "Class" => scala.Right(FluffyKindString.Class)
    case "Variable" => scala.Right(FluffyKindString.Variable)
    case "Function" => scala.Right(FluffyKindString.Function)
    case "Interface" => scala.Right(FluffyKindString.Interface)
    case "Enumeration" => scala.Right(FluffyKindString.Enumeration)
    case "Object literal" => scala.Right(FluffyKindString.ObjectLiteral)
    case "Type alias" => scala.Right(FluffyKindString.TypeAlias)
    case other => scala.Left("invalid FluffyKindString: " + other)
}
given Encoder[FluffyKindString] = Encoder.encodeString.contramap {
    case FluffyKindString.Module => "Module"
    case FluffyKindString.Class => "Class"
    case FluffyKindString.Variable => "Variable"
    case FluffyKindString.Function => "Function"
    case FluffyKindString.Interface => "Interface"
    case FluffyKindString.Enumeration => "Enumeration"
    case FluffyKindString.ObjectLiteral => "Object literal"
    case FluffyKindString.TypeAlias => "Type alias"
}

case class StickySignature (
    val comment : StickyComment,
    val flags : IndigoFlags,
    val id : Long,
    val kind : Long,
    val kindString : SignatureKindString,
    val name : String,
    val parameters : Option[Seq[TentacledParameter]] = None,
    val `type` : CunningType,
    val typeParameter : Option[Seq[GetSignature]] = None
) derives Encoder.AsObject, Decoder

case class TentacledParameter (
    val comment : Option[TentacledComment] = None,
    val defaultValue : Option[String] = None,
    val flags : TentacledFlags,
    val id : Long,
    val kind : Long,
    val kindString : ParameterKindString,
    val name : String,
    val originalName : Option[String] = None,
    val `type` : AmbitiousType
) derives Encoder.AsObject, Decoder

case class AmbitiousType (
    val declaration : Option[TentacledDeclaration] = None,
    val elementType : Option[ElementType] = None,
    val id : Option[Long] = None,
    val name : Option[String] = None,
    val typeArguments : Option[Seq[ElementType]] = None,
    val `type` : TypeEnum
) derives Encoder.AsObject, Decoder

case class TentacledDeclaration (
    val children : Option[Seq[IndigoChild]] = None,
    val flags : GetSignatureFlags,
    val groups : Option[Seq[Group]] = None,
    val id : Long,
    val indexSignature : Option[IndexSignatureElement] = None,
    val kind : Long,
    val kindString : String,
    val name : String,
    val signatures : Option[Seq[GetSignature]] = None,
    val sources : Seq[Source]
) derives Encoder.AsObject, Decoder

case class IndigoChild (
    val `type` : IndecentType,
    val comment : FluffyComment,
    val defaultValue : Option[String] = None,
    val flags : FluffyFlags,
    val id : Long,
    val kind : Long,
    val kindString : PurpleKindString,
    val name : String,
    val sources : Seq[Source]
) derives Encoder.AsObject, Decoder

case class CunningType (
    val declaration : Option[PurpleDeclaration] = None,
    val id : Option[Long] = None,
    val name : Option[Name] = None,
    val typeArguments : Option[Seq[ElementType]] = None,
    val `type` : TypeEnum
) derives Encoder.AsObject, Decoder

case class TypeParameter (
    val comment : Option[PurpleComment] = None,
    val flags : GetSignatureFlags,
    val id : Long,
    val kind : Long,
    val kindString : String,
    val name : String,
    val `type` : Option[MischievousType] = None
) derives Encoder.AsObject, Decoder

case class MischievousType (
    val id : Option[Long] = None,
    val name : Option[Name] = None,
    val operator : Option[String] = None,
    val target : Option[ElementType] = None,
    val `type` : String
) derives Encoder.AsObject, Decoder

case class IndecentComment (
    val shortText : String,
    val tags : Option[Seq[Tag]] = None
) derives Encoder.AsObject, Decoder

enum TentacledKindString : 
    case ExternalModule

given Decoder[TentacledKindString] = Decoder.decodeString.emap {
    case "External module" => scala.Right(TentacledKindString.ExternalModule)
    case other => scala.Left("invalid TentacledKindString: " + other)
}
given Encoder[TentacledKindString] = Encoder.encodeString.contramap {
    case TentacledKindString.ExternalModule => "External module"
}
