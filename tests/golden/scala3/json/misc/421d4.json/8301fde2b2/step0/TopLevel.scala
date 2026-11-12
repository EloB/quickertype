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
    val license : License,
    val licenseId : String,
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
    val rowClass : String,
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
    val dataTypeName : String,
    val fieldName : String,
    val flags : Option[Seq[String]] = None,
    val format : Query,
    val id : Long,
    val name : String,
    val position : Long,
    val renderTypeName : String,
    val tableColumnId : Option[Long] = None,
    val width : Option[Long] = None
) derives Encoder.AsObject, Decoder

case class CachedContents (
    val average : Option[String] = None,
    val `null` : Long,
    val largest : Option[String] = None,
    val non_null : Long,
    val smallest : Option[String] = None,
    val sum : Option[String] = None,
    val top : Option[Seq[Top]] = None
) derives Encoder.AsObject, Decoder

case class Top (
    val count : Long,
    val item : String
) derives Encoder.AsObject, Decoder

case class Query()  derives Encoder.AsObject, Decoder

case class Grant (
    val flags : Seq[String],
    val `type` : String,
    val inherited : Boolean
) derives Encoder.AsObject, Decoder

case class License (
    val name : String
) derives Encoder.AsObject, Decoder

case class Metadata (
    val availableDisplayTypes : Seq[String],
    val rdfClass : String,
    val rdfSubject : String,
    val renderTypeConfig : RenderTypeConfig,
    val rowIdentifier : String
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
    val screenName : String
) derives Encoder.AsObject, Decoder
