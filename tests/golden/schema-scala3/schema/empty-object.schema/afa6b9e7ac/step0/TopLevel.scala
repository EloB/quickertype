package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

type TopLevel = Map[String, Option[Json]]

given (using ev : Option[Json]): Encoder[Map[String, Option[Json]]] = Encoder.encodeMap[String, Option[Json]]
