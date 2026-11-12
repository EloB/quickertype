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


type TopLevel = List[TopLevelElement]

case class TopLevelElement (
    val averageRating : Long,
    val category : Option[String] = None,
    val createdAt : Long,
    val description : Option[String] = None,
    val displayType : Option[DisplayType] = None,
    val downloadCount : Long,
    val flags : Option[Seq[TopLevelFlag]] = None,
    val grants : Seq[Grant],
    val hideFromCatalog : Boolean,
    val hideFromDataJson : Boolean,
    val id : String,
    val indexUpdatedAt : Option[Long] = None,
    val locale : String,
    val metadata : TopLevelMetadata,
    val moderationStatus : Option[Boolean] = None,
    val modifyingViewUid : Option[ModifyingViewUid] = None,
    val name : String,
    val newBackend : Boolean,
    val numberOfComments : Long,
    val oid : Long,
    val owner : Owner,
    val provenance : Provenance,
    val publicationAppendEnabled : Boolean,
    val publicationDate : Option[Long] = None,
    val publicationGroup : Long,
    val publicationStage : PublicationStage,
    val ratings : Option[Ratings] = None,
    val resourceName : Option[String] = None,
    val rights : Seq[Right],
    val rowClass : Option[String] = None,
    val rowIdentifierColumnId : Option[Long] = None,
    val rowsUpdatedAt : Option[Long] = None,
    val rowsUpdatedBy : Option[RowsUpdatedBy] = None,
    val tableAuthor : TableAuthor,
    val tableId : Long,
    val tags : Option[Seq[String]] = None,
    val totalTimesRated : Long,
    val viewCount : Long,
    val viewLastModified : Long,
    val viewType : ViewType
) derives OptionPickler.ReadWriter

enum DisplayType : 
    case Table
    case DataLens
    case Fatrow
    case Page

given OptionPickler.ReadWriter[DisplayType] = OptionPickler.readwriter[String].bimap[DisplayType](
    {
        case DisplayType.Table => "table"
        case DisplayType.DataLens => "data_lens"
        case DisplayType.Fatrow => "fatrow"
        case DisplayType.Page => "page"
    },
    {
        case "table" => DisplayType.Table
        case "data_lens" => DisplayType.DataLens
        case "fatrow" => DisplayType.Fatrow
        case "page" => DisplayType.Page
        case other => throw new upickle.core.Abort("invalid DisplayType: " + other)
    }
)

enum TopLevelFlag : 
    case Default
    case Restorable
    case RestorePossibleForType

given OptionPickler.ReadWriter[TopLevelFlag] = OptionPickler.readwriter[String].bimap[TopLevelFlag](
    {
        case TopLevelFlag.Default => "default"
        case TopLevelFlag.Restorable => "restorable"
        case TopLevelFlag.RestorePossibleForType => "restorePossibleForType"
    },
    {
        case "default" => TopLevelFlag.Default
        case "restorable" => TopLevelFlag.Restorable
        case "restorePossibleForType" => TopLevelFlag.RestorePossibleForType
        case other => throw new upickle.core.Abort("invalid TopLevelFlag: " + other)
    }
)

case class Grant (
    val flags : Seq[GrantFlag],
    val `type` : GrantType,
    val inherited : Boolean
) derives OptionPickler.ReadWriter

enum GrantFlag : 
    case Public

given OptionPickler.ReadWriter[GrantFlag] = OptionPickler.readwriter[String].bimap[GrantFlag](
    {
        case GrantFlag.Public => "public"
    },
    {
        case "public" => GrantFlag.Public
        case other => throw new upickle.core.Abort("invalid GrantFlag: " + other)
    }
)

enum GrantType : 
    case Viewer

given OptionPickler.ReadWriter[GrantType] = OptionPickler.readwriter[String].bimap[GrantType](
    {
        case GrantType.Viewer => "viewer"
    },
    {
        case "viewer" => GrantType.Viewer
        case other => throw new upickle.core.Abort("invalid GrantType: " + other)
    }
)

case class TopLevelMetadata (
    val availableDisplayTypes : Option[Seq[DisplayType]] = None,
    val custom_fields : Option[CustomFields] = None,
    val jsonQuery : Option[JSONQuery] = None,
    val rdfClass : Option[String] = None,
    val rdfSubject : Option[String] = None,
    val renderTypeConfig : Option[MetadataRenderTypeConfig] = None,
    val richRendererConfigs : Option[RichRendererConfigs] = None,
    val rowIdentifier : Option[String] = None,
    val rowLabel : Option[String] = None,
    val v1_archived_properties : Option[V1ArchivedProperties] = None
) derives OptionPickler.ReadWriter

case class CustomFields (
    val TEST : Test
) derives OptionPickler.ReadWriter

case class Test (
    val CFPB1 : String
) derives OptionPickler.ReadWriter

case class JSONQuery (
    val group : Option[Seq[Group]] = None,
    val order : Option[Seq[Order]] = None,
    val select : Option[Seq[Select]] = None,
    val where : Option[Where] = None
) derives OptionPickler.ReadWriter

case class Group (
    val columnFieldName : String
) derives OptionPickler.ReadWriter

case class Order (
    val ascending : Boolean,
    val columnFieldName : OrderColumnFieldName
) derives OptionPickler.ReadWriter

enum OrderColumnFieldName : 
    case DateReceived
    case AgreementDate
    case InEffectAsOf1_1_2012

given OptionPickler.ReadWriter[OrderColumnFieldName] = OptionPickler.readwriter[String].bimap[OrderColumnFieldName](
    {
        case OrderColumnFieldName.DateReceived => "date_received"
        case OrderColumnFieldName.AgreementDate => "agreement_date"
        case OrderColumnFieldName.InEffectAsOf1_1_2012 => "in_effect_as_of_1_1_2012"
    },
    {
        case "date_received" => OrderColumnFieldName.DateReceived
        case "agreement_date" => OrderColumnFieldName.AgreementDate
        case "in_effect_as_of_1_1_2012" => OrderColumnFieldName.InEffectAsOf1_1_2012
        case other => throw new upickle.core.Abort("invalid OrderColumnFieldName: " + other)
    }
)

case class Select (
    val aggregate : Option[String] = None,
    val columnFieldName : String
) derives OptionPickler.ReadWriter

case class Where (
    val children : Option[Seq[Child]] = None,
    val columnFieldName : Option[ChildColumnFieldName] = None,
    val metadata : Option[ChildMetadata] = None,
    val operator : WhereOperator,
    val value : Option[String] = None
) derives OptionPickler.ReadWriter

case class Child (
    val columnFieldName : ChildColumnFieldName,
    val metadata : Option[ChildMetadata] = None,
    val operator : ChildOperator,
    val value : Option[String] = None
) derives OptionPickler.ReadWriter

enum ChildColumnFieldName : 
    case Product
    case ComplaintWhatHappened
    case SubProduct
    case Issue

given OptionPickler.ReadWriter[ChildColumnFieldName] = OptionPickler.readwriter[String].bimap[ChildColumnFieldName](
    {
        case ChildColumnFieldName.Product => "product"
        case ChildColumnFieldName.ComplaintWhatHappened => "complaint_what_happened"
        case ChildColumnFieldName.SubProduct => "sub_product"
        case ChildColumnFieldName.Issue => "issue"
    },
    {
        case "product" => ChildColumnFieldName.Product
        case "complaint_what_happened" => ChildColumnFieldName.ComplaintWhatHappened
        case "sub_product" => ChildColumnFieldName.SubProduct
        case "issue" => ChildColumnFieldName.Issue
        case other => throw new upickle.core.Abort("invalid ChildColumnFieldName: " + other)
    }
)

case class ChildMetadata (
    val customValues : Option[Seq[String]] = None,
    val freeform : Option[Boolean] = None,
    val includeAuto : Option[Long] = None,
    val operator : Option[MetadataOperator] = None,
    val tableColumnId : Option[TableColumnID] = None,
    val unifiedVersion : Option[Long] = None
) derives OptionPickler.ReadWriter

enum MetadataOperator : 
    case Equals
    case Blank

given OptionPickler.ReadWriter[MetadataOperator] = OptionPickler.readwriter[String].bimap[MetadataOperator](
    {
        case MetadataOperator.Equals => "EQUALS"
        case MetadataOperator.Blank => "blank?"
    },
    {
        case "EQUALS" => MetadataOperator.Equals
        case "blank?" => MetadataOperator.Blank
        case other => throw new upickle.core.Abort("invalid MetadataOperator: " + other)
    }
)

case class TableColumnID (
    val `2819740` : Long
) derives OptionPickler.ReadWriter

enum ChildOperator : 
    case Equals
    case IsNotBlank

given OptionPickler.ReadWriter[ChildOperator] = OptionPickler.readwriter[String].bimap[ChildOperator](
    {
        case ChildOperator.Equals => "EQUALS"
        case ChildOperator.IsNotBlank => "IS_NOT_BLANK"
    },
    {
        case "EQUALS" => ChildOperator.Equals
        case "IS_NOT_BLANK" => ChildOperator.IsNotBlank
        case other => throw new upickle.core.Abort("invalid ChildOperator: " + other)
    }
)

enum WhereOperator : 
    case Equals
    case And

given OptionPickler.ReadWriter[WhereOperator] = OptionPickler.readwriter[String].bimap[WhereOperator](
    {
        case WhereOperator.Equals => "EQUALS"
        case WhereOperator.And => "AND"
    },
    {
        case "EQUALS" => WhereOperator.Equals
        case "AND" => WhereOperator.And
        case other => throw new upickle.core.Abort("invalid WhereOperator: " + other)
    }
)

case class MetadataRenderTypeConfig (
    val visible : PurpleVisible
) derives OptionPickler.ReadWriter

case class PurpleVisible (
    val fatrow : Option[Boolean] = None,
    val table : Option[Boolean] = None
) derives OptionPickler.ReadWriter

case class RichRendererConfigs (
    val fatRow : FatRow
) derives OptionPickler.ReadWriter

case class FatRow (
    val columns : Seq[Column]
) derives OptionPickler.ReadWriter

case class Column (
    val rows : Seq[Row],
    val styles : Styles
) derives OptionPickler.ReadWriter

case class Row (
    val fields : Seq[Field]
) derives OptionPickler.ReadWriter

case class Field (
    val `type` : FieldType,
    val tableColumnId : Long
) derives OptionPickler.ReadWriter

enum FieldType : 
    case ColumnLabel
    case ColumnData

given OptionPickler.ReadWriter[FieldType] = OptionPickler.readwriter[String].bimap[FieldType](
    {
        case FieldType.ColumnLabel => "columnLabel"
        case FieldType.ColumnData => "columnData"
    },
    {
        case "columnLabel" => FieldType.ColumnLabel
        case "columnData" => FieldType.ColumnData
        case other => throw new upickle.core.Abort("invalid FieldType: " + other)
    }
)

case class Styles (
    val width : Width
) derives OptionPickler.ReadWriter

enum Width : 
    case The27
    case The40
    case The30
    case The33

given OptionPickler.ReadWriter[Width] = OptionPickler.readwriter[String].bimap[Width](
    {
        case Width.The27 => "27%"
        case Width.The40 => "40%"
        case Width.The30 => "30%"
        case Width.The33 => "33%"
    },
    {
        case "27%" => Width.The27
        case "40%" => Width.The40
        case "30%" => Width.The30
        case "33%" => Width.The33
        case other => throw new upickle.core.Abort("invalid Width: " + other)
    }
)

case class V1ArchivedProperties (
    val accessPoints : AccessPoints,
    val blist_id : String,
    val renderTypeConfig : V1ArchivedPropertiesRenderTypeConfig
) derives OptionPickler.ReadWriter

case class AccessPoints (
    val new_view : String
) derives OptionPickler.ReadWriter

case class V1ArchivedPropertiesRenderTypeConfig (
    val visible : FluffyVisible
) derives OptionPickler.ReadWriter

case class FluffyVisible (
    val href : Boolean
) derives OptionPickler.ReadWriter

enum ModifyingViewUid : 
    case S6EwH6Mp

given OptionPickler.ReadWriter[ModifyingViewUid] = OptionPickler.readwriter[String].bimap[ModifyingViewUid](
    {
        case ModifyingViewUid.S6EwH6Mp => "s6ew-h6mp"
    },
    {
        case "s6ew-h6mp" => ModifyingViewUid.S6EwH6Mp
        case other => throw new upickle.core.Abort("invalid ModifyingViewUid: " + other)
    }
)

case class Owner (
    val displayName : String,
    val flags : Option[Seq[String]] = None,
    val id : String,
    val lastNotificationSeenAt : Option[Long] = None,
    val profileImageUrlLarge : Option[String] = None,
    val profileImageUrlMedium : Option[String] = None,
    val profileImageUrlSmall : Option[String] = None,
    val rights : Option[Seq[String]] = None,
    val roleName : Option[RoleName] = None,
    val screenName : String
) derives OptionPickler.ReadWriter

enum RoleName : 
    case Administrator
    case Publisher

given OptionPickler.ReadWriter[RoleName] = OptionPickler.readwriter[String].bimap[RoleName](
    {
        case RoleName.Administrator => "administrator"
        case RoleName.Publisher => "publisher"
    },
    {
        case "administrator" => RoleName.Administrator
        case "publisher" => RoleName.Publisher
        case other => throw new upickle.core.Abort("invalid RoleName: " + other)
    }
)

enum Provenance : 
    case Official

given OptionPickler.ReadWriter[Provenance] = OptionPickler.readwriter[String].bimap[Provenance](
    {
        case Provenance.Official => "official"
    },
    {
        case "official" => Provenance.Official
        case other => throw new upickle.core.Abort("invalid Provenance: " + other)
    }
)

enum PublicationStage : 
    case Published

given OptionPickler.ReadWriter[PublicationStage] = OptionPickler.readwriter[String].bimap[PublicationStage](
    {
        case PublicationStage.Published => "published"
    },
    {
        case "published" => PublicationStage.Published
        case other => throw new upickle.core.Abort("invalid PublicationStage: " + other)
    }
)

case class Ratings (
    val rating : Long
) derives OptionPickler.ReadWriter

enum Right : 
    case Read

given OptionPickler.ReadWriter[Right] = OptionPickler.readwriter[String].bimap[Right](
    {
        case Right.Read => "read"
    },
    {
        case "read" => Right.Read
        case other => throw new upickle.core.Abort("invalid Right: " + other)
    }
)

enum RowsUpdatedBy : 
    case PjxgVe4M
    case The54A3Qyun
    case The9E3M2843
    case VvcaFr6G

given OptionPickler.ReadWriter[RowsUpdatedBy] = OptionPickler.readwriter[String].bimap[RowsUpdatedBy](
    {
        case RowsUpdatedBy.PjxgVe4M => "pjxg-ve4m"
        case RowsUpdatedBy.The54A3Qyun => "54a3-qyun"
        case RowsUpdatedBy.The9E3M2843 => "9e3m-2843"
        case RowsUpdatedBy.VvcaFr6G => "vvca-fr6g"
    },
    {
        case "pjxg-ve4m" => RowsUpdatedBy.PjxgVe4M
        case "54a3-qyun" => RowsUpdatedBy.The54A3Qyun
        case "9e3m-2843" => RowsUpdatedBy.The9E3M2843
        case "vvca-fr6g" => RowsUpdatedBy.VvcaFr6G
        case other => throw new upickle.core.Abort("invalid RowsUpdatedBy: " + other)
    }
)

case class TableAuthor (
    val displayName : String,
    val id : String,
    val rights : Option[Seq[String]] = None,
    val roleName : Option[RoleName] = None,
    val screenName : String
) derives OptionPickler.ReadWriter

enum ViewType : 
    case Tabular

given OptionPickler.ReadWriter[ViewType] = OptionPickler.readwriter[String].bimap[ViewType](
    {
        case ViewType.Tabular => "tabular"
    },
    {
        case "tabular" => ViewType.Tabular
        case other => throw new upickle.core.Abort("invalid ViewType: " + other)
    }
)
