package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

type TopLevel = List[TopLevelElement]
given (using ev : TopLevelElement): Encoder[Seq[TopLevelElement]] = Encoder.encodeSeq[TopLevelElement]

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
) derives Encoder.AsObject, Decoder

enum DisplayType : 
    case Table
    case DataLens
    case Fatrow
    case Page

given Decoder[DisplayType] = Decoder.decodeString.emap {
    case "table" => scala.Right(DisplayType.Table)
    case "data_lens" => scala.Right(DisplayType.DataLens)
    case "fatrow" => scala.Right(DisplayType.Fatrow)
    case "page" => scala.Right(DisplayType.Page)
    case other => scala.Left("invalid DisplayType: " + other)
}
given Encoder[DisplayType] = Encoder.encodeString.contramap {
    case DisplayType.Table => "table"
    case DisplayType.DataLens => "data_lens"
    case DisplayType.Fatrow => "fatrow"
    case DisplayType.Page => "page"
}

enum TopLevelFlag : 
    case Default
    case Restorable
    case RestorePossibleForType

given Decoder[TopLevelFlag] = Decoder.decodeString.emap {
    case "default" => scala.Right(TopLevelFlag.Default)
    case "restorable" => scala.Right(TopLevelFlag.Restorable)
    case "restorePossibleForType" => scala.Right(TopLevelFlag.RestorePossibleForType)
    case other => scala.Left("invalid TopLevelFlag: " + other)
}
given Encoder[TopLevelFlag] = Encoder.encodeString.contramap {
    case TopLevelFlag.Default => "default"
    case TopLevelFlag.Restorable => "restorable"
    case TopLevelFlag.RestorePossibleForType => "restorePossibleForType"
}

case class Grant (
    val flags : Seq[GrantFlag],
    val `type` : GrantType,
    val inherited : Boolean
) derives Encoder.AsObject, Decoder

enum GrantFlag : 
    case Public

given Decoder[GrantFlag] = Decoder.decodeString.emap {
    case "public" => scala.Right(GrantFlag.Public)
    case other => scala.Left("invalid GrantFlag: " + other)
}
given Encoder[GrantFlag] = Encoder.encodeString.contramap {
    case GrantFlag.Public => "public"
}

enum GrantType : 
    case Viewer

given Decoder[GrantType] = Decoder.decodeString.emap {
    case "viewer" => scala.Right(GrantType.Viewer)
    case other => scala.Left("invalid GrantType: " + other)
}
given Encoder[GrantType] = Encoder.encodeString.contramap {
    case GrantType.Viewer => "viewer"
}

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
) derives Encoder.AsObject, Decoder

case class CustomFields (
    val TEST : Test
) derives Encoder.AsObject, Decoder

case class Test (
    val CFPB1 : String
) derives Encoder.AsObject, Decoder

case class JSONQuery (
    val group : Option[Seq[Group]] = None,
    val order : Option[Seq[Order]] = None,
    val select : Option[Seq[Select]] = None,
    val where : Option[Where] = None
) derives Encoder.AsObject, Decoder

case class Group (
    val columnFieldName : String
) derives Encoder.AsObject, Decoder

case class Order (
    val ascending : Boolean,
    val columnFieldName : OrderColumnFieldName
) derives Encoder.AsObject, Decoder

enum OrderColumnFieldName : 
    case DateReceived
    case AgreementDate
    case InEffectAsOf1_1_2012

given Decoder[OrderColumnFieldName] = Decoder.decodeString.emap {
    case "date_received" => scala.Right(OrderColumnFieldName.DateReceived)
    case "agreement_date" => scala.Right(OrderColumnFieldName.AgreementDate)
    case "in_effect_as_of_1_1_2012" => scala.Right(OrderColumnFieldName.InEffectAsOf1_1_2012)
    case other => scala.Left("invalid OrderColumnFieldName: " + other)
}
given Encoder[OrderColumnFieldName] = Encoder.encodeString.contramap {
    case OrderColumnFieldName.DateReceived => "date_received"
    case OrderColumnFieldName.AgreementDate => "agreement_date"
    case OrderColumnFieldName.InEffectAsOf1_1_2012 => "in_effect_as_of_1_1_2012"
}

case class Select (
    val aggregate : Option[String] = None,
    val columnFieldName : String
) derives Encoder.AsObject, Decoder

case class Where (
    val children : Option[Seq[Child]] = None,
    val columnFieldName : Option[ChildColumnFieldName] = None,
    val metadata : Option[ChildMetadata] = None,
    val operator : WhereOperator,
    val value : Option[String] = None
) derives Encoder.AsObject, Decoder

case class Child (
    val columnFieldName : ChildColumnFieldName,
    val metadata : Option[ChildMetadata] = None,
    val operator : ChildOperator,
    val value : Option[String] = None
) derives Encoder.AsObject, Decoder

enum ChildColumnFieldName : 
    case Product
    case ComplaintWhatHappened
    case SubProduct
    case Issue

given Decoder[ChildColumnFieldName] = Decoder.decodeString.emap {
    case "product" => scala.Right(ChildColumnFieldName.Product)
    case "complaint_what_happened" => scala.Right(ChildColumnFieldName.ComplaintWhatHappened)
    case "sub_product" => scala.Right(ChildColumnFieldName.SubProduct)
    case "issue" => scala.Right(ChildColumnFieldName.Issue)
    case other => scala.Left("invalid ChildColumnFieldName: " + other)
}
given Encoder[ChildColumnFieldName] = Encoder.encodeString.contramap {
    case ChildColumnFieldName.Product => "product"
    case ChildColumnFieldName.ComplaintWhatHappened => "complaint_what_happened"
    case ChildColumnFieldName.SubProduct => "sub_product"
    case ChildColumnFieldName.Issue => "issue"
}

case class ChildMetadata (
    val customValues : Option[Seq[String]] = None,
    val freeform : Option[Boolean] = None,
    val includeAuto : Option[Long] = None,
    val operator : Option[MetadataOperator] = None,
    val tableColumnId : Option[TableColumnID] = None,
    val unifiedVersion : Option[Long] = None
) derives Encoder.AsObject, Decoder

enum MetadataOperator : 
    case Equals
    case Blank

given Decoder[MetadataOperator] = Decoder.decodeString.emap {
    case "EQUALS" => scala.Right(MetadataOperator.Equals)
    case "blank?" => scala.Right(MetadataOperator.Blank)
    case other => scala.Left("invalid MetadataOperator: " + other)
}
given Encoder[MetadataOperator] = Encoder.encodeString.contramap {
    case MetadataOperator.Equals => "EQUALS"
    case MetadataOperator.Blank => "blank?"
}

case class TableColumnID (
    val `2819740` : Long
) derives Encoder.AsObject, Decoder

enum ChildOperator : 
    case Equals
    case IsNotBlank

given Decoder[ChildOperator] = Decoder.decodeString.emap {
    case "EQUALS" => scala.Right(ChildOperator.Equals)
    case "IS_NOT_BLANK" => scala.Right(ChildOperator.IsNotBlank)
    case other => scala.Left("invalid ChildOperator: " + other)
}
given Encoder[ChildOperator] = Encoder.encodeString.contramap {
    case ChildOperator.Equals => "EQUALS"
    case ChildOperator.IsNotBlank => "IS_NOT_BLANK"
}

enum WhereOperator : 
    case Equals
    case And

given Decoder[WhereOperator] = Decoder.decodeString.emap {
    case "EQUALS" => scala.Right(WhereOperator.Equals)
    case "AND" => scala.Right(WhereOperator.And)
    case other => scala.Left("invalid WhereOperator: " + other)
}
given Encoder[WhereOperator] = Encoder.encodeString.contramap {
    case WhereOperator.Equals => "EQUALS"
    case WhereOperator.And => "AND"
}

case class MetadataRenderTypeConfig (
    val visible : PurpleVisible
) derives Encoder.AsObject, Decoder

case class PurpleVisible (
    val fatrow : Option[Boolean] = None,
    val table : Option[Boolean] = None
) derives Encoder.AsObject, Decoder

case class RichRendererConfigs (
    val fatRow : FatRow
) derives Encoder.AsObject, Decoder

case class FatRow (
    val columns : Seq[Column]
) derives Encoder.AsObject, Decoder

case class Column (
    val rows : Seq[Row],
    val styles : Styles
) derives Encoder.AsObject, Decoder

case class Row (
    val fields : Seq[Field]
) derives Encoder.AsObject, Decoder

case class Field (
    val `type` : FieldType,
    val tableColumnId : Long
) derives Encoder.AsObject, Decoder

enum FieldType : 
    case ColumnLabel
    case ColumnData

given Decoder[FieldType] = Decoder.decodeString.emap {
    case "columnLabel" => scala.Right(FieldType.ColumnLabel)
    case "columnData" => scala.Right(FieldType.ColumnData)
    case other => scala.Left("invalid FieldType: " + other)
}
given Encoder[FieldType] = Encoder.encodeString.contramap {
    case FieldType.ColumnLabel => "columnLabel"
    case FieldType.ColumnData => "columnData"
}

case class Styles (
    val width : Width
) derives Encoder.AsObject, Decoder

enum Width : 
    case The27
    case The40
    case The30
    case The33

given Decoder[Width] = Decoder.decodeString.emap {
    case "27%" => scala.Right(Width.The27)
    case "40%" => scala.Right(Width.The40)
    case "30%" => scala.Right(Width.The30)
    case "33%" => scala.Right(Width.The33)
    case other => scala.Left("invalid Width: " + other)
}
given Encoder[Width] = Encoder.encodeString.contramap {
    case Width.The27 => "27%"
    case Width.The40 => "40%"
    case Width.The30 => "30%"
    case Width.The33 => "33%"
}

case class V1ArchivedProperties (
    val accessPoints : AccessPoints,
    val blist_id : String,
    val renderTypeConfig : V1ArchivedPropertiesRenderTypeConfig
) derives Encoder.AsObject, Decoder

case class AccessPoints (
    val new_view : String
) derives Encoder.AsObject, Decoder

case class V1ArchivedPropertiesRenderTypeConfig (
    val visible : FluffyVisible
) derives Encoder.AsObject, Decoder

case class FluffyVisible (
    val href : Boolean
) derives Encoder.AsObject, Decoder

enum ModifyingViewUid : 
    case S6EwH6Mp

given Decoder[ModifyingViewUid] = Decoder.decodeString.emap {
    case "s6ew-h6mp" => scala.Right(ModifyingViewUid.S6EwH6Mp)
    case other => scala.Left("invalid ModifyingViewUid: " + other)
}
given Encoder[ModifyingViewUid] = Encoder.encodeString.contramap {
    case ModifyingViewUid.S6EwH6Mp => "s6ew-h6mp"
}

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
) derives Encoder.AsObject, Decoder

enum RoleName : 
    case Administrator
    case Publisher

given Decoder[RoleName] = Decoder.decodeString.emap {
    case "administrator" => scala.Right(RoleName.Administrator)
    case "publisher" => scala.Right(RoleName.Publisher)
    case other => scala.Left("invalid RoleName: " + other)
}
given Encoder[RoleName] = Encoder.encodeString.contramap {
    case RoleName.Administrator => "administrator"
    case RoleName.Publisher => "publisher"
}

enum Provenance : 
    case Official

given Decoder[Provenance] = Decoder.decodeString.emap {
    case "official" => scala.Right(Provenance.Official)
    case other => scala.Left("invalid Provenance: " + other)
}
given Encoder[Provenance] = Encoder.encodeString.contramap {
    case Provenance.Official => "official"
}

enum PublicationStage : 
    case Published

given Decoder[PublicationStage] = Decoder.decodeString.emap {
    case "published" => scala.Right(PublicationStage.Published)
    case other => scala.Left("invalid PublicationStage: " + other)
}
given Encoder[PublicationStage] = Encoder.encodeString.contramap {
    case PublicationStage.Published => "published"
}

case class Ratings (
    val rating : Long
) derives Encoder.AsObject, Decoder

enum Right : 
    case Read

given Decoder[Right] = Decoder.decodeString.emap {
    case "read" => scala.Right(Right.Read)
    case other => scala.Left("invalid Right: " + other)
}
given Encoder[Right] = Encoder.encodeString.contramap {
    case Right.Read => "read"
}

enum RowsUpdatedBy : 
    case PjxgVe4M
    case The54A3Qyun
    case The9E3M2843
    case VvcaFr6G

given Decoder[RowsUpdatedBy] = Decoder.decodeString.emap {
    case "pjxg-ve4m" => scala.Right(RowsUpdatedBy.PjxgVe4M)
    case "54a3-qyun" => scala.Right(RowsUpdatedBy.The54A3Qyun)
    case "9e3m-2843" => scala.Right(RowsUpdatedBy.The9E3M2843)
    case "vvca-fr6g" => scala.Right(RowsUpdatedBy.VvcaFr6G)
    case other => scala.Left("invalid RowsUpdatedBy: " + other)
}
given Encoder[RowsUpdatedBy] = Encoder.encodeString.contramap {
    case RowsUpdatedBy.PjxgVe4M => "pjxg-ve4m"
    case RowsUpdatedBy.The54A3Qyun => "54a3-qyun"
    case RowsUpdatedBy.The9E3M2843 => "9e3m-2843"
    case RowsUpdatedBy.VvcaFr6G => "vvca-fr6g"
}

case class TableAuthor (
    val displayName : String,
    val id : String,
    val rights : Option[Seq[String]] = None,
    val roleName : Option[RoleName] = None,
    val screenName : String
) derives Encoder.AsObject, Decoder

enum ViewType : 
    case Tabular

given Decoder[ViewType] = Decoder.decodeString.emap {
    case "tabular" => scala.Right(ViewType.Tabular)
    case other => scala.Left("invalid ViewType: " + other)
}
given Encoder[ViewType] = Encoder.encodeString.contramap {
    case ViewType.Tabular => "tabular"
}
