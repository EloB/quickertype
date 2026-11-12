package quicktype

// Custom pickler so that missing keys and JSON nulls both read as None,
// and None is left out when writing (upickle's default for Option is a
// JSON array).
object OptionPickler extends upickle.AttributeTagged:
    import upickle.default.Writer
    import upickle.default.Reader
    override implicit def OptionWriter[T: Writer]: Writer[Option[T]] =
        implicitly[Writer[T]].comap[Option[T]] {
            case None => null.asInstanceOf[T]
            case Some(x) => x
        }

    override implicit def OptionReader[T: Reader]: Reader[Option[T]] = {
        new Reader.Delegate[Any, Option[T]](implicitly[Reader[T]].map(Some(_))){
        override def visitNull(index: Int) = None
        }
    }
end OptionPickler

// If a union has a null in, then we'll need this too...
type NullValue = None.type
given OptionPickler.ReadWriter[NullValue] = OptionPickler.readwriter[ujson.Value].bimap[NullValue](
    _ => ujson.Null,
    json => if json.isNull then None else throw new upickle.core.Abort("not null")
)
given OptionPickler.ReadWriter[java.time.Instant] = OptionPickler.readwriter[ujson.Value].bimap(
    value => ujson.Str(value.toString),
    json => json match
        case ujson.Str(value) => java.time.Instant.parse(value)
        case other => throw new upickle.core.Abort("expected date-time, got " + other)
)
given OptionPickler.ReadWriter[java.util.UUID] = OptionPickler.readwriter[String].bimap(
    _.toString,
    value =>
        val uuid = java.util.UUID.fromString(value)
        if uuid.toString.equalsIgnoreCase(value) then uuid else throw new upickle.core.Abort("invalid UUID")
)

object JsonExt:
    val valueReader = OptionPickler.readwriter[ujson.Value]

    // upickle's built-in primitive readers are lenient -- the numeric and
    // boolean readers accept strings, and the string reader accepts
    // numbers and booleans -- so untagged unions need strict readers to
    // pick the right member.
    val strictString: OptionPickler.Reader[String] = valueReader.map {
        case ujson.Str(s) => s
        case json => throw new upickle.core.Abort("expected string, got " + json)
    }
    val strictLong: OptionPickler.Reader[Long] = valueReader.map {
        case ujson.Num(n) if n.isWhole => n.toLong
        case json => throw new upickle.core.Abort("expected integer, got " + json)
    }
    val strictDouble: OptionPickler.Reader[Double] = valueReader.map {
        case ujson.Num(n) => n
        case json => throw new upickle.core.Abort("expected number, got " + json)
    }
    val strictBoolean: OptionPickler.Reader[Boolean] = valueReader.map {
        case ujson.Bool(b) => b
        case json => throw new upickle.core.Abort("expected boolean, got " + json)
    }

    def badMerge[T](r1: => OptionPickler.Reader[?], rest: OptionPickler.Reader[?]*): OptionPickler.Reader[T] = valueReader.map { json =>
        var t: T | Null = null
        val stack       = Vector.newBuilder[Throwable]
        (r1 +: rest).foreach { reader =>
            if t == null then
            try
                t = OptionPickler.read[T](json, trace = true)(using reader.asInstanceOf[OptionPickler.Reader[T]])
            catch
                case exc => stack += exc
        }
        if t != null then t.nn else throw new Exception(json.toString(), stack.result().headOption.getOrElse(null))
    }
end JsonExt
given OptionPickler.Reader[Long] = JsonExt.strictLong


case class TopLevel (
    val children : Seq[TopLevelChild],
    val flags : GetSignatureFlags,
    val groups : Seq[Group],
    val id : Long,
    val kind : Long,
    val name : String
) derives OptionPickler.ReadWriter

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
) derives OptionPickler.ReadWriter

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
) derives OptionPickler.ReadWriter

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
) derives OptionPickler.ReadWriter

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
) derives OptionPickler.ReadWriter

case class IndecentChild (
    val `type` : FriskyType,
    val flags : FluffyFlags,
    val id : Long,
    val kind : Long,
    val kindString : PurpleKindString,
    val name : String,
    val sources : Seq[Source]
) derives OptionPickler.ReadWriter

case class FriskyType (
    val declaration : Option[IndigoDeclaration] = None,
    val name : Option[Name] = None,
    val `type` : TypeEnum
) derives OptionPickler.ReadWriter

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
) derives OptionPickler.ReadWriter

case class IndexSignatureElement (
    val flags : GetSignatureFlags,
    val id : Long,
    val kind : Long,
    val kindString : String,
    val name : String,
    val parameters : Option[Seq[GetSignature]] = None,
    val `type` : PurpleType
) derives OptionPickler.ReadWriter

case class GetSignatureType (
    val declaration : Option[GetSignature] = None,
    val elementType : Option[ElementType] = None,
    val name : Option[Name] = None,
    val `type` : TypeEnum
) derives OptionPickler.ReadWriter

case class PurpleType (
    val declaration : Option[GetSignature] = None,
    val name : Option[Name] = None,
    val `type` : TypeEnum
) derives OptionPickler.ReadWriter

case class GetSignatureChild (
    val `type` : PurpleType,
    val comment : Option[FluffyComment] = None,
    val flags : FluffyFlags,
    val id : Long,
    val kind : Long,
    val kindString : PurpleKindString,
    val name : String,
    val sources : Seq[Source]
) derives OptionPickler.ReadWriter

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
) derives OptionPickler.ReadWriter

case class GetSignatureFlags()
 derives OptionPickler.ReadWriter
case class ElementType (
    val `type` : TypeEnum,
    val name : Name
) derives OptionPickler.ReadWriter

enum TypeEnum : 
    case Intrinsic
    case Reflection
    case TypeArray
    case Reference
    case TypeParameter
    case Tuple
    case Union
    case StringLiteral

given OptionPickler.ReadWriter[TypeEnum] = OptionPickler.readwriter[String].bimap[TypeEnum](
    {
        case TypeEnum.Intrinsic => "intrinsic"
        case TypeEnum.Reflection => "reflection"
        case TypeEnum.TypeArray => "array"
        case TypeEnum.Reference => "reference"
        case TypeEnum.TypeParameter => "typeParameter"
        case TypeEnum.Tuple => "tuple"
        case TypeEnum.Union => "union"
        case TypeEnum.StringLiteral => "stringLiteral"
    },
    {
        case "intrinsic" => TypeEnum.Intrinsic
        case "reflection" => TypeEnum.Reflection
        case "array" => TypeEnum.TypeArray
        case "reference" => TypeEnum.Reference
        case "typeParameter" => TypeEnum.TypeParameter
        case "tuple" => TypeEnum.Tuple
        case "union" => TypeEnum.Union
        case "stringLiteral" => TypeEnum.StringLiteral
        case other => throw new upickle.core.Abort("invalid TypeEnum: " + other)
    }
)

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

given OptionPickler.ReadWriter[Name] = OptionPickler.readwriter[String].bimap[Name](
    {
        case Name.NameString => "string"
        case Name.Number => "number"
        case Name.Void => "void"
        case Name.T => "T"
        case Name.NameBoolean => "boolean"
        case Name.BaseClass => "BaseClass"
        case Name.NameAny => "any"
        case Name.NameArray => "Array"
        case Name.MyNumber => "MyNumber"
    },
    {
        case "string" => Name.NameString
        case "number" => Name.Number
        case "void" => Name.Void
        case "T" => Name.T
        case "boolean" => Name.NameBoolean
        case "BaseClass" => Name.BaseClass
        case "any" => Name.NameAny
        case "Array" => Name.NameArray
        case "MyNumber" => Name.MyNumber
        case other => throw new upickle.core.Abort("invalid Name: " + other)
    }
)

case class FluffyComment (
    val text : String
) derives OptionPickler.ReadWriter

case class FluffyFlags (
    val isOptional : Option[Boolean] = None
) derives OptionPickler.ReadWriter

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

given OptionPickler.ReadWriter[PurpleKindString] = OptionPickler.readwriter[String].bimap[PurpleKindString](
    {
        case PurpleKindString.Variable => "Variable"
        case PurpleKindString.Function => "Function"
        case PurpleKindString.Property => "Property"
        case PurpleKindString.Method => "Method"
        case PurpleKindString.Constructor => "Constructor"
        case PurpleKindString.Accessor => "Accessor"
        case PurpleKindString.EnumerationMember => "Enumeration member"
        case PurpleKindString.Module => "Module"
        case PurpleKindString.ObjectLiteral => "Object literal"
    },
    {
        case "Variable" => PurpleKindString.Variable
        case "Function" => PurpleKindString.Function
        case "Property" => PurpleKindString.Property
        case "Method" => PurpleKindString.Method
        case "Constructor" => PurpleKindString.Constructor
        case "Accessor" => PurpleKindString.Accessor
        case "Enumeration member" => PurpleKindString.EnumerationMember
        case "Module" => PurpleKindString.Module
        case "Object literal" => PurpleKindString.ObjectLiteral
        case other => throw new upickle.core.Abort("invalid PurpleKindString: " + other)
    }
)

case class Source (
    val character : Long,
    val fileName : FileName,
    val line : Long
) derives OptionPickler.ReadWriter

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

given OptionPickler.ReadWriter[FileName] = OptionPickler.readwriter[String].bimap[FileName](
    {
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
    },
    {
        case "modules.ts" => FileName.ModulesTs
        case "classes.ts" => FileName.ClassesTs
        case "flattened.ts" => FileName.FlattenedTs
        case "access.ts" => FileName.AccessTs
        case "default-export.ts" => FileName.DefaultExportTs
        case "enumerations.ts" => FileName.EnumerationsTs
        case "functions.ts" => FileName.FunctionsTs
        case "generics.ts" => FileName.GenericsTs
        case "single-export.ts" => FileName.SingleExportTs
        case "typescript-1.3.ts" => FileName.Typescript13Ts
        case "typescript-1.4.ts" => FileName.Typescript14Ts
        case "typescript-1.5.ts" => FileName.Typescript15Ts
        case "variables.ts" => FileName.VariablesTs
        case other => throw new upickle.core.Abort("invalid FileName: " + other)
    }
)

case class GetSignatureComment (
    val returns : Option[String] = None,
    val shortText : Option[String] = None,
    val text : Option[String] = None
) derives OptionPickler.ReadWriter

case class Group (
    val children : Seq[Long],
    val kind : Long,
    val title : String
) derives OptionPickler.ReadWriter

case class GetSignatureParameter (
    val comment : Option[TentacledComment] = None,
    val flags : TentacledFlags,
    val id : Long,
    val kind : Long,
    val kindString : ParameterKindString,
    val name : String,
    val `type` : FluffyType
) derives OptionPickler.ReadWriter

case class TentacledComment (
    val shortText : Option[String] = None,
    val text : Option[String] = None
) derives OptionPickler.ReadWriter

case class TentacledFlags (
    val isOptional : Option[Boolean] = None,
    val isRest : Option[Boolean] = None
) derives OptionPickler.ReadWriter

enum ParameterKindString : 
    case Parameter

given OptionPickler.ReadWriter[ParameterKindString] = OptionPickler.readwriter[String].bimap[ParameterKindString](
    {
        case ParameterKindString.Parameter => "Parameter"
    },
    {
        case "Parameter" => ParameterKindString.Parameter
        case other => throw new upickle.core.Abort("invalid ParameterKindString: " + other)
    }
)

case class FluffyType (
    val elementType : Option[ElementType] = None,
    val name : Option[Name] = None,
    val typeArguments : Option[Seq[ElementType]] = None,
    val `type` : TypeEnum
) derives OptionPickler.ReadWriter

case class ExtendedBy (
    val constraint : Option[ExtendedBy] = None,
    val `type` : TypeEnum,
    val id : Option[Long] = None,
    val name : String,
    val typeArguments : Option[Seq[ExtendedBy]] = None
) derives OptionPickler.ReadWriter

case class FluffyTypeArgument (
    val `type` : TypeEnum,
    val types : Seq[ElementType]
) derives OptionPickler.ReadWriter

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
) derives OptionPickler.ReadWriter

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
) derives OptionPickler.ReadWriter

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
) derives OptionPickler.ReadWriter

case class StickyChild (
    val `type` : IndecentType,
    val comment : Option[FluffyComment] = None,
    val flags : FluffyFlags,
    val id : Long,
    val kind : Long,
    val kindString : PurpleKindString,
    val name : String,
    val sources : Seq[Source]
) derives OptionPickler.ReadWriter

case class IndecentType (
    val declaration : Option[GetSignature] = None,
    val elements : Option[Seq[ElementType]] = None,
    val name : Option[Name] = None,
    val `type` : TypeEnum
) derives OptionPickler.ReadWriter

case class IndexSignature (
    val flags : GetSignatureFlags,
    val id : Long,
    val `type` : HilariousType,
    val kind : Long,
    val kindString : String,
    val name : String,
    val parameters : Seq[GetSignature]
) derives OptionPickler.ReadWriter

case class HilariousType (
    val declaration : GetSignature,
    val `type` : TypeEnum
) derives OptionPickler.ReadWriter

case class TentacledSignature (
    val comment : Option[IndigoComment] = None,
    val flags : GetSignatureFlags,
    val id : Long,
    val kind : Long,
    val kindString : SignatureKindString,
    val name : String,
    val parameters : Option[Seq[FluffyParameter]] = None,
    val `type` : ExtendedBy
) derives OptionPickler.ReadWriter

case class IndigoComment (
    val returns : String,
    val shortText : String
) derives OptionPickler.ReadWriter

enum SignatureKindString : 
    case CallSignature
    case ConstructorSignature

given OptionPickler.ReadWriter[SignatureKindString] = OptionPickler.readwriter[String].bimap[SignatureKindString](
    {
        case SignatureKindString.CallSignature => "Call signature"
        case SignatureKindString.ConstructorSignature => "Constructor signature"
    },
    {
        case "Call signature" => SignatureKindString.CallSignature
        case "Constructor signature" => SignatureKindString.ConstructorSignature
        case other => throw new upickle.core.Abort("invalid SignatureKindString: " + other)
    }
)

case class FluffyParameter (
    val comment : Option[FluffyComment] = None,
    val flags : FluffyFlags,
    val id : Long,
    val kind : Long,
    val kindString : String,
    val name : String,
    val `type` : ElementType,
    val sources : Option[Seq[Source]] = None
) derives OptionPickler.ReadWriter

case class PurpleTypeArgument (
    val operator : String,
    val target : ElementType,
    val `type` : String
) derives OptionPickler.ReadWriter

case class TypeElement (
    val declaration : Option[GetSignature] = None,
    val elementType : Option[ElementType] = None,
    val name : Option[Name] = None,
    val typeArguments : Option[Seq[ElementType]] = None,
    val `type` : TypeEnum
) derives OptionPickler.ReadWriter

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
) derives OptionPickler.ReadWriter

case class PurpleComment (
    val shortText : String
) derives OptionPickler.ReadWriter

case class PurpleFlags (
    val isExported : Option[Boolean] = None
) derives OptionPickler.ReadWriter

case class PurpleSignature (
    val comment : Option[PurpleComment] = None,
    val flags : GetSignatureFlags,
    val id : Long,
    val kind : Long,
    val kindString : SignatureKindString,
    val name : String,
    val parameters : Seq[GetSignature],
    val `type` : TentacledType
) derives OptionPickler.ReadWriter

case class TentacledType (
    val declaration : Option[PurpleDeclaration] = None,
    val name : Option[Name] = None,
    val `type` : TypeEnum
) derives OptionPickler.ReadWriter

case class PurpleDeclaration (
    val children : Seq[GetSignature],
    val flags : GetSignatureFlags,
    val groups : Seq[Group],
    val id : Long,
    val kind : Long,
    val kindString : String,
    val name : String
) derives OptionPickler.ReadWriter

case class StickyComment (
    val returns : Option[String] = None,
    val shortText : Option[String] = None,
    val tags : Option[Seq[Tag]] = None,
    val text : Option[String] = None
) derives OptionPickler.ReadWriter

case class Tag (
    val tag : String,
    val text : String
) derives OptionPickler.ReadWriter

case class StickyFlags (
    val isAbstract : Option[Boolean] = None,
    val isConstructorProperty : Option[Boolean] = None,
    val isExported : Option[Boolean] = None,
    val isPrivate : Option[Boolean] = None,
    val isProtected : Option[Boolean] = None,
    val isPublic : Option[Boolean] = None,
    val isStatic : Option[Boolean] = None
) derives OptionPickler.ReadWriter

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
) derives OptionPickler.ReadWriter

case class IndigoFlags (
    val isPrivate : Option[Boolean] = None,
    val isProtected : Option[Boolean] = None
) derives OptionPickler.ReadWriter

case class PurpleParameter (
    val comment : Option[TentacledComment] = None,
    val flags : GetSignatureFlags,
    val id : Long,
    val kind : Long,
    val kindString : ParameterKindString,
    val name : String,
    val `type` : StickyType
) derives OptionPickler.ReadWriter

case class StickyType (
    val constraint : Option[ExtendedBy] = None,
    val declaration : Option[GetSignature] = None,
    val elementType : Option[ElementType] = None,
    val elements : Option[Seq[ExtendedBy]] = None,
    val id : Option[Long] = None,
    val name : Option[String] = None,
    val typeArguments : Option[Seq[ElementType]] = None,
    val `type` : TypeEnum
) derives OptionPickler.ReadWriter

case class IndecentFlags (
    val hasExportAssignment : Option[Boolean] = None,
    val isAbstract : Option[Boolean] = None,
    val isConst : Option[Boolean] = None,
    val isExported : Option[Boolean] = None,
    val isLet : Option[Boolean] = None,
    val isPrivate : Option[Boolean] = None,
    val isProtected : Option[Boolean] = None
) derives OptionPickler.ReadWriter

enum FluffyKindString : 
    case Module
    case Class
    case Variable
    case Function
    case Interface
    case Enumeration
    case ObjectLiteral
    case TypeAlias

given OptionPickler.ReadWriter[FluffyKindString] = OptionPickler.readwriter[String].bimap[FluffyKindString](
    {
        case FluffyKindString.Module => "Module"
        case FluffyKindString.Class => "Class"
        case FluffyKindString.Variable => "Variable"
        case FluffyKindString.Function => "Function"
        case FluffyKindString.Interface => "Interface"
        case FluffyKindString.Enumeration => "Enumeration"
        case FluffyKindString.ObjectLiteral => "Object literal"
        case FluffyKindString.TypeAlias => "Type alias"
    },
    {
        case "Module" => FluffyKindString.Module
        case "Class" => FluffyKindString.Class
        case "Variable" => FluffyKindString.Variable
        case "Function" => FluffyKindString.Function
        case "Interface" => FluffyKindString.Interface
        case "Enumeration" => FluffyKindString.Enumeration
        case "Object literal" => FluffyKindString.ObjectLiteral
        case "Type alias" => FluffyKindString.TypeAlias
        case other => throw new upickle.core.Abort("invalid FluffyKindString: " + other)
    }
)

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
) derives OptionPickler.ReadWriter

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
) derives OptionPickler.ReadWriter

case class AmbitiousType (
    val declaration : Option[TentacledDeclaration] = None,
    val elementType : Option[ElementType] = None,
    val id : Option[Long] = None,
    val name : Option[String] = None,
    val typeArguments : Option[Seq[ElementType]] = None,
    val `type` : TypeEnum
) derives OptionPickler.ReadWriter

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
) derives OptionPickler.ReadWriter

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
) derives OptionPickler.ReadWriter

case class CunningType (
    val declaration : Option[PurpleDeclaration] = None,
    val id : Option[Long] = None,
    val name : Option[Name] = None,
    val typeArguments : Option[Seq[ElementType]] = None,
    val `type` : TypeEnum
) derives OptionPickler.ReadWriter

case class TypeParameter (
    val comment : Option[PurpleComment] = None,
    val flags : GetSignatureFlags,
    val id : Long,
    val kind : Long,
    val kindString : String,
    val name : String,
    val `type` : Option[MischievousType] = None
) derives OptionPickler.ReadWriter

case class MischievousType (
    val id : Option[Long] = None,
    val name : Option[Name] = None,
    val operator : Option[String] = None,
    val target : Option[ElementType] = None,
    val `type` : String
) derives OptionPickler.ReadWriter

case class IndecentComment (
    val shortText : String,
    val tags : Option[Seq[Tag]] = None
) derives OptionPickler.ReadWriter

enum TentacledKindString : 
    case ExternalModule

given OptionPickler.ReadWriter[TentacledKindString] = OptionPickler.readwriter[String].bimap[TentacledKindString](
    {
        case TentacledKindString.ExternalModule => "External module"
    },
    {
        case "External module" => TentacledKindString.ExternalModule
        case other => throw new upickle.core.Abort("invalid TentacledKindString: " + other)
    }
)
