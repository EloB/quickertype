package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val LightParams : LightParams
) derives Encoder.AsObject, Decoder

case class LightParams (
    val app_id : String,
    val outlet_id : String,
    val rgba : String
) derives Encoder.AsObject, Decoder
