package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val message : Seq[Option[Json]],
    val responseTime : Long,
    val Results : Results,
    val status : String
) derives Encoder.AsObject, Decoder

case class Results (
    val series : Seq[Series]
) derives Encoder.AsObject, Decoder

case class Series (
    val data : Seq[Datum],
    val seriesID : String
) derives Encoder.AsObject, Decoder

case class Datum (
    val footnotes : Seq[Footnote],
    val period : String,
    val periodName : String,
    val value : String,
    val year : String
) derives Encoder.AsObject, Decoder

case class Footnote (
    val code : Option[String] = None,
    val text : Option[String] = None
) derives Encoder.AsObject, Decoder
