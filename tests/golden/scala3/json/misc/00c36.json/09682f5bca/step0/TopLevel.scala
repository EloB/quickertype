package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

type TopLevel = List[TopLevelUnion]
given (using ev : TopLevelUnion): Encoder[Seq[TopLevelUnion]] = Encoder.encodeSeq[TopLevelUnion]

type TopLevelUnion = FluffyTopLevel | Seq[PurpleTopLevel]
given Decoder[TopLevelUnion] = {
    List[Decoder[TopLevelUnion]](
        Decoder[Seq[PurpleTopLevel]].widen,
        Decoder[FluffyTopLevel].widen,
    ).reduceLeft(_ or _)
}

given Encoder[TopLevelUnion] = Encoder.instance {
    case enc0 : Seq[PurpleTopLevel] => Encoder.encodeSeq[PurpleTopLevel].apply(enc0)
    case enc1 : FluffyTopLevel => Encoder.AsObject[FluffyTopLevel].apply(enc1)
}

case class PurpleTopLevel (
    val country : Country,
    val date : String,
    val decimal : String,
    val indicator : Country,
    val value : String
) derives Encoder.AsObject, Decoder

case class Country (
    val id : ID,
    val value : Value
) derives Encoder.AsObject, Decoder

enum ID : 
    case Us
    case NyGdpMktpCD

given Decoder[ID] = Decoder.decodeString.emap {
    case "US" => scala.Right(ID.Us)
    case "NY.GDP.MKTP.CD" => scala.Right(ID.NyGdpMktpCD)
    case other => scala.Left("invalid ID: " + other)
}
given Encoder[ID] = Encoder.encodeString.contramap {
    case ID.Us => "US"
    case ID.NyGdpMktpCD => "NY.GDP.MKTP.CD"
}

enum Value : 
    case UnitedStates
    case GDPCurrentUS

given Decoder[Value] = Decoder.decodeString.emap {
    case "United States" => scala.Right(Value.UnitedStates)
    case "GDP (current US$)" => scala.Right(Value.GDPCurrentUS)
    case other => scala.Left("invalid Value: " + other)
}
given Encoder[Value] = Encoder.encodeString.contramap {
    case Value.UnitedStates => "United States"
    case Value.GDPCurrentUS => "GDP (current US$)"
}

case class FluffyTopLevel (
    val page : Long,
    val pages : Long,
    val per_page : String,
    val total : Long
) derives Encoder.AsObject, Decoder
