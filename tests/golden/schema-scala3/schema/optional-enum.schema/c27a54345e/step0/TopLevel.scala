package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val name : String,
    val shortcut : Option[Shortcut] = None
) derives Encoder.AsObject, Decoder

enum Shortcut : 
    case Hidden
    case Visible

given Decoder[Shortcut] = Decoder.decodeString.emap {
    case "hidden" => scala.Right(Shortcut.Hidden)
    case "visible" => scala.Right(Shortcut.Visible)
    case other => scala.Left("invalid Shortcut: " + other)
}
given Encoder[Shortcut] = Encoder.encodeString.contramap {
    case Shortcut.Hidden => "hidden"
    case Shortcut.Visible => "visible"
}
