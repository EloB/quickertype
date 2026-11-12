package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val count : Long,
    val next : String,
    val previous : Option[Json] = None,
    val results : Seq[Result]
) derives Encoder.AsObject, Decoder

case class Result (
    val code : String,
    val english : String,
    val fav : Boolean,
    val group : Group,
    val location : Location,
    val min_screens : Long,
    val num_views : Long,
    val showtimes : String,
    val stars : Long,
    val tel : Tel,
    val thai : String,
    val today_screens : Long,
    val url : String,
    val website : String
) derives Encoder.AsObject, Decoder

case class Group (
    val code : Code,
    val english : English,
    val thai : Thai,
    val website : String
) derives Encoder.AsObject, Decoder

enum Code : 
    case Sf

given Decoder[Code] = Decoder.decodeString.emap {
    case "sf" => scala.Right(Code.Sf)
    case other => scala.Left("invalid Code: " + other)
}
given Encoder[Code] = Encoder.encodeString.contramap {
    case Code.Sf => "sf"
}

enum English : 
    case Sf

given Decoder[English] = Decoder.decodeString.emap {
    case "SF" => scala.Right(English.Sf)
    case other => scala.Left("invalid English: " + other)
}
given Encoder[English] = Encoder.encodeString.contramap {
    case English.Sf => "SF"
}

enum Thai : 
    case เอสเอฟ

given Decoder[Thai] = Decoder.decodeString.emap {
    case "เอสเอฟ" => scala.Right(Thai.เอสเอฟ)
    case other => scala.Left("invalid Thai: " + other)
}
given Encoder[Thai] = Encoder.encodeString.contramap {
    case Thai.เอสเอฟ => "เอสเอฟ"
}

enum Location : 
    case Empty
    case The5ThFLEmporium

given Decoder[Location] = Decoder.decodeString.emap {
    case "" => scala.Right(Location.Empty)
    case "5th Fl. Emporium" => scala.Right(Location.The5ThFLEmporium)
    case other => scala.Left("invalid Location: " + other)
}
given Encoder[Location] = Encoder.encodeString.contramap {
    case Location.Empty => ""
    case Location.The5ThFLEmporium => "5th Fl. Emporium"
}

enum Tel : 
    case Empty
    case The022688899

given Decoder[Tel] = Decoder.decodeString.emap {
    case "" => scala.Right(Tel.Empty)
    case "02-268-8899" => scala.Right(Tel.The022688899)
    case other => scala.Left("invalid Tel: " + other)
}
given Encoder[Tel] = Encoder.encodeString.contramap {
    case Tel.Empty => ""
    case Tel.The022688899 => "02-268-8899"
}
