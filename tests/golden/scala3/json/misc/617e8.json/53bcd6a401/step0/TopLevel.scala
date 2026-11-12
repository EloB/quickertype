package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val data : Seq[Seq[Datum]],
    val meta : Meta
) derives Encoder.AsObject, Decoder

type Datum = Long | String | NullValue
given Decoder[Datum] = {
    List[Decoder[Datum]](
        Decoder[String].widen,
        Decoder[Long].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Datum] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Long => Encoder.encodeLong(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

case class Meta (
    val view : View
) derives Encoder.AsObject, Decoder

case class View (
    val attribution : String,
    val attributionLink : String,
    val averageRating : Long,
    val category : String,
    val columns : Seq[Column],
    val createdAt : Long,
    val description : String,
    val displayType : String,
    val downloadCount : Long,
    val flags : Seq[String],
    val grants : Seq[Grant],
    val hideFromCatalog : Boolean,
    val hideFromDataJson : Boolean,
    val id : String,
    val indexUpdatedAt : Long,
    val locale : String,
    val metadata : Metadata,
    val name : String,
    val newBackend : Boolean,
    val numberOfComments : Long,
    val oid : Long,
    val owner : Owner,
    val provenance : String,
    val publicationAppendEnabled : Boolean,
    val publicationDate : Long,
    val publicationGroup : Long,
    val publicationStage : String,
    val query : Query,
    val rights : Seq[String],
    val rowsUpdatedAt : Long,
    val rowsUpdatedBy : String,
    val tableAuthor : Owner,
    val tableId : Long,
    val tags : Seq[String],
    val totalTimesRated : Long,
    val viewCount : Long,
    val viewLastModified : Long,
    val viewType : String
) derives Encoder.AsObject, Decoder

case class Column (
    val cachedContents : Option[CachedContents] = None,
    val dataTypeName : TypeName,
    val description : Option[String] = None,
    val fieldName : String,
    val flags : Option[Seq[String]] = None,
    val format : Format,
    val id : Long,
    val name : String,
    val position : Long,
    val renderTypeName : TypeName,
    val tableColumnId : Option[Long] = None,
    val width : Option[Long] = None
) derives Encoder.AsObject, Decoder

case class CachedContents (
    val `null` : Long,
    val largest : String,
    val non_null : Long,
    val smallest : String,
    val top : Seq[Top]
) derives Encoder.AsObject, Decoder

case class Top (
    val count : Long,
    val item : String
) derives Encoder.AsObject, Decoder

enum TypeName : 
    case MetaData
    case CalendarDate
    case Text

given Decoder[TypeName] = Decoder.decodeString.emap {
    case "meta_data" => scala.Right(TypeName.MetaData)
    case "calendar_date" => scala.Right(TypeName.CalendarDate)
    case "text" => scala.Right(TypeName.Text)
    case other => scala.Left("invalid TypeName: " + other)
}
given Encoder[TypeName] = Encoder.encodeString.contramap {
    case TypeName.MetaData => "meta_data"
    case TypeName.CalendarDate => "calendar_date"
    case TypeName.Text => "text"
}

case class Format (
    val align : Option[String] = None,
    val view : Option[String] = None
) derives Encoder.AsObject, Decoder

case class Grant (
    val flags : Seq[String],
    val `type` : String,
    val inherited : Boolean
) derives Encoder.AsObject, Decoder

case class Metadata (
    val attachments : Seq[Attachment],
    val availableDisplayTypes : Seq[String],
    val custom_fields : CustomFields,
    val jsonQuery : JSONQuery,
    val rdfSubject : String,
    val renderTypeConfig : RenderTypeConfig
) derives Encoder.AsObject, Decoder

case class Attachment (
    val assetId : String,
    val blobId : String,
    val filename : String,
    val name : String
) derives Encoder.AsObject, Decoder

case class CustomFields (
    val `Additional Resources` : AdditionalResources,
    val `Common Core` : CommonCore,
    val `Dataset Information` : DatasetInformation,
    val `Dataset Summary` : DatasetSummary,
    val Notes : Notes
) derives Encoder.AsObject, Decoder

case class AdditionalResources (
    val `See Also` : String
) derives Encoder.AsObject, Decoder

case class CommonCore (
    val `Contact Email` : String,
    val `Contact Name` : String,
    val Publisher : String
) derives Encoder.AsObject, Decoder

case class DatasetInformation (
    val Agency : String
) derives Encoder.AsObject, Decoder

case class DatasetSummary (
    val `Contact Information` : String,
    val Coverage : String,
    val `Data Frequency` : String,
    val `Dataset Owner` : String,
    val Granularity : String,
    val Organization : String,
    val `Posting Frequency` : String,
    val `Time Period` : String
) derives Encoder.AsObject, Decoder

case class Notes (
    val Notes : String
) derives Encoder.AsObject, Decoder

case class JSONQuery (
    val order : Seq[Order]
) derives Encoder.AsObject, Decoder

case class Order (
    val ascending : Boolean,
    val columnFieldName : String
) derives Encoder.AsObject, Decoder

case class RenderTypeConfig (
    val visible : Visible
) derives Encoder.AsObject, Decoder

case class Visible (
    val table : Boolean
) derives Encoder.AsObject, Decoder

case class Owner (
    val displayName : String,
    val id : String,
    val profileImageUrlLarge : String,
    val profileImageUrlMedium : String,
    val profileImageUrlSmall : String,
    val rights : Seq[String],
    val roleName : String,
    val screenName : String
) derives Encoder.AsObject, Decoder

case class Query (
    val orderBys : Seq[OrderBy]
) derives Encoder.AsObject, Decoder

case class OrderBy (
    val ascending : Boolean,
    val expression : Expression
) derives Encoder.AsObject, Decoder

case class Expression (
    val columnId : Long,
    val `type` : String
) derives Encoder.AsObject, Decoder
