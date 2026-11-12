package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

type TopLevel = List[TopLevelElement]
given (using ev : TopLevelElement): Encoder[Seq[TopLevelElement]] = Encoder.encodeSeq[TopLevelElement]

case class TopLevelElement (
    val category : String,
    val context : String,
    val id : Long,
    val location : Location,
    val location_subtype : String,
    val location_type : String,
    val month : String,
    val outcome_status : OutcomeStatus,
    val persistent_id : String
) derives Encoder.AsObject, Decoder

case class Location (
    val latitude : String,
    val longitude : String,
    val street : Street
) derives Encoder.AsObject, Decoder

case class Street (
    val id : Long,
    val name : String
) derives Encoder.AsObject, Decoder

case class OutcomeStatus (
    val category : String,
    val date : String
) derives Encoder.AsObject, Decoder
