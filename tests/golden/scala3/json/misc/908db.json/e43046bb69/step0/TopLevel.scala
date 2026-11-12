package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val states : Seq[StateElement]
) derives Encoder.AsObject, Decoder

case class StateElement (
    val state : StateState
) derives Encoder.AsObject, Decoder

case class StateState (
    val state_id : String,
    val state_name : String
) derives Encoder.AsObject, Decoder
