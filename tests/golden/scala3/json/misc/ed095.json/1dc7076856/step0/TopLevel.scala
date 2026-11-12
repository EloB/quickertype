package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

type TopLevel = Map[String, String]

given (using ev : String): Encoder[Map[String, String]] = Encoder.encodeMap[String, String]
