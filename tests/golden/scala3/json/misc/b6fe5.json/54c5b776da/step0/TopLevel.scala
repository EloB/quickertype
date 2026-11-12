package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val group : String,
    val movie : String,
    val `movie-image` : String,
    val theater : String
) derives Encoder.AsObject, Decoder
