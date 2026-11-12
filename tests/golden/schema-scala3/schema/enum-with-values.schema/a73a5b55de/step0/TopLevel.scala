package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val weekdays : Weekdays
) derives Encoder.AsObject, Decoder

enum Weekdays : 
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    case Sunday

given Decoder[Weekdays] = Decoder.decodeString.emap {
    case "Monday" => scala.Right(Weekdays.Monday)
    case "Tuesday" => scala.Right(Weekdays.Tuesday)
    case "Wednesday" => scala.Right(Weekdays.Wednesday)
    case "Thursday" => scala.Right(Weekdays.Thursday)
    case "Friday" => scala.Right(Weekdays.Friday)
    case "Saturday" => scala.Right(Weekdays.Saturday)
    case "Sunday" => scala.Right(Weekdays.Sunday)
    case other => scala.Left("invalid Weekdays: " + other)
}
given Encoder[Weekdays] = Encoder.encodeString.contramap {
    case Weekdays.Monday => "Monday"
    case Weekdays.Tuesday => "Tuesday"
    case Weekdays.Wednesday => "Wednesday"
    case Weekdays.Thursday => "Thursday"
    case Weekdays.Friday => "Friday"
    case Weekdays.Saturday => "Saturday"
    case Weekdays.Sunday => "Sunday"
}
