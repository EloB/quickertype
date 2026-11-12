package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val mission_specs : Map[String, MissionSpec]
) derives Encoder.AsObject, Decoder

case class MissionSpec (
    val objectives : Map[String, Objective]
) derives Encoder.AsObject, Decoder

case class Objective (
    val rewards : Map[String, Reward]
) derives Encoder.AsObject, Decoder

case class Reward()  derives Encoder.AsObject, Decoder
