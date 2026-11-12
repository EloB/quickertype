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
    val created_at : java.time.Instant,
    val id : String,
    val name : String,
    val updated_at : java.time.Instant,
    val uri : String
) derives Encoder.AsObject, Decoder
