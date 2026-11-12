package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

type TopLevel = Map[String, TopLevelValue]

given (using ev : TopLevelValue): Encoder[Map[String, TopLevelValue]] = Encoder.encodeMap[String, TopLevelValue]

case class TopLevelValue (
    val channel_id : String,
    val channel_name : String,
    val code : String,
    val emoticon_set : Long,
    val id : Long
) derives Encoder.AsObject, Decoder
