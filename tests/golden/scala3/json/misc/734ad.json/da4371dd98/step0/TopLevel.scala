package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val count : Long,
    val facets : Facets,
    val limit : Long,
    val next : String,
    val offset : Long,
    val previous : Boolean,
    val results : Seq[Result]
) derives Encoder.AsObject, Decoder

case class Facets()  derives Encoder.AsObject, Decoder

case class Result (
    val acronym : Option[String] = None,
    val activity_consult_committees : String,
    val activity_eu_legislative : String,
    val activity_expert_groups : String,
    val activity_high_level_groups : String,
    val activity_industry_forums : String,
    val activity_inter_groups : String,
    val activity_other : Option[String] = None,
    val activity_relevant_comm : String,
    val be_office_country : Option[String] = None,
    val be_office_lat : Option[Double] = None,
    val be_office_lon : Option[Double] = None,
    val be_office_phone : Option[String] = None,
    val be_office_post_code : Option[String] = None,
    val be_office_postbox : Option[String] = None,
    val be_office_street : Option[String] = None,
    val be_office_town : Option[String] = None,
    val code_of_conduct : String,
    val contact_country : Long,
    val created_at : java.time.Instant,
    val entity : String,
    val goals : String,
    val head : String,
    val head_office_country : String,
    val head_office_lat : Option[Double] = None,
    val head_office_lon : Option[Double] = None,
    val head_office_phone : String,
    val head_office_post_code : Option[String] = None,
    val head_office_postbox : Option[String] = None,
    val head_office_street : String,
    val head_office_town : String,
    val id : String,
    val identification_code : String,
    val info_members : String,
    val last_update_date : java.time.Instant,
    val legal : String,
    val legal_status : String,
    val main_category : Long,
    val main_category_title : String,
    val members : Long,
    val members_100 : Option[Long] = None,
    val members_25 : Option[Long] = None,
    val members_50 : Option[Long] = None,
    val members_75 : Option[Long] = None,
    val members_fte : Double,
    val name : String,
    val native_name : Option[Json] = None,
    val networking : Option[String] = None,
    val number_of_natural_persons : Option[Long] = None,
    val other_code_of_conduct : Option[String] = None,
    val registration_date : java.time.Instant,
    val status : Status,
    val structure_members : String,
    val sub_category : Long,
    val sub_category_title : String,
    val updated_at : java.time.Instant,
    val uri : String,
    val web_site_url : Option[String] = None
) derives Encoder.AsObject, Decoder

enum Status : 
    case Active
    case Inactive

given Decoder[Status] = Decoder.decodeString.emap {
    case "active" => scala.Right(Status.Active)
    case "inactive" => scala.Right(Status.Inactive)
    case other => scala.Left("invalid Status: " + other)
}
given Encoder[Status] = Encoder.encodeString.contramap {
    case Status.Active => "active"
    case Status.Inactive => "inactive"
}
