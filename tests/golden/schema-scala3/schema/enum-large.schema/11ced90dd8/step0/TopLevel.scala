package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val callsign : Callsign,
    val priority : Priority
) derives Encoder.AsObject, Decoder

enum Callsign : 
    case Alpha
    case Bravo
    case Charlie
    case Delta
    case Echo
    case Foxtrot
    case Golf
    case Hotel
    case India
    case Juliett
    case Kilo
    case Lima
    case Mike
    case November
    case Oscar
    case Papa
    case Quebec
    case Romeo
    case Sierra
    case Tango

given Decoder[Callsign] = Decoder.decodeString.emap {
    case "alpha" => scala.Right(Callsign.Alpha)
    case "bravo" => scala.Right(Callsign.Bravo)
    case "charlie" => scala.Right(Callsign.Charlie)
    case "delta" => scala.Right(Callsign.Delta)
    case "echo" => scala.Right(Callsign.Echo)
    case "foxtrot" => scala.Right(Callsign.Foxtrot)
    case "golf" => scala.Right(Callsign.Golf)
    case "hotel" => scala.Right(Callsign.Hotel)
    case "india" => scala.Right(Callsign.India)
    case "juliett" => scala.Right(Callsign.Juliett)
    case "kilo" => scala.Right(Callsign.Kilo)
    case "lima" => scala.Right(Callsign.Lima)
    case "mike" => scala.Right(Callsign.Mike)
    case "november" => scala.Right(Callsign.November)
    case "oscar" => scala.Right(Callsign.Oscar)
    case "papa" => scala.Right(Callsign.Papa)
    case "quebec" => scala.Right(Callsign.Quebec)
    case "romeo" => scala.Right(Callsign.Romeo)
    case "sierra" => scala.Right(Callsign.Sierra)
    case "tango" => scala.Right(Callsign.Tango)
    case other => scala.Left("invalid Callsign: " + other)
}
given Encoder[Callsign] = Encoder.encodeString.contramap {
    case Callsign.Alpha => "alpha"
    case Callsign.Bravo => "bravo"
    case Callsign.Charlie => "charlie"
    case Callsign.Delta => "delta"
    case Callsign.Echo => "echo"
    case Callsign.Foxtrot => "foxtrot"
    case Callsign.Golf => "golf"
    case Callsign.Hotel => "hotel"
    case Callsign.India => "india"
    case Callsign.Juliett => "juliett"
    case Callsign.Kilo => "kilo"
    case Callsign.Lima => "lima"
    case Callsign.Mike => "mike"
    case Callsign.November => "november"
    case Callsign.Oscar => "oscar"
    case Callsign.Papa => "papa"
    case Callsign.Quebec => "quebec"
    case Callsign.Romeo => "romeo"
    case Callsign.Sierra => "sierra"
    case Callsign.Tango => "tango"
}

enum Priority : 
    case Low
    case Medium
    case High

given Decoder[Priority] = Decoder.decodeString.emap {
    case "low" => scala.Right(Priority.Low)
    case "medium" => scala.Right(Priority.Medium)
    case "high" => scala.Right(Priority.High)
    case other => scala.Left("invalid Priority: " + other)
}
given Encoder[Priority] = Encoder.encodeString.contramap {
    case Priority.Low => "low"
    case Priority.Medium => "medium"
    case Priority.High => "high"
}
