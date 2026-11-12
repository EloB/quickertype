package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val features : Seq[Feature],
    val name : String,
    val `type` : String
) derives Encoder.AsObject, Decoder

case class Feature (
    val `type` : FeatureType,
    val geometry : Geometry,
    val properties : Properties
) derives Encoder.AsObject, Decoder

enum FeatureType : 
    case Feature

given Decoder[FeatureType] = Decoder.decodeString.emap {
    case "Feature" => scala.Right(FeatureType.Feature)
    case other => scala.Left("invalid FeatureType: " + other)
}
given Encoder[FeatureType] = Encoder.encodeString.contramap {
    case FeatureType.Feature => "Feature"
}

case class Geometry (
    val coordinates : Seq[Double],
    val `type` : GeometryType
) derives Encoder.AsObject, Decoder

enum GeometryType : 
    case Point

given Decoder[GeometryType] = Decoder.decodeString.emap {
    case "Point" => scala.Right(GeometryType.Point)
    case other => scala.Left("invalid GeometryType: " + other)
}
given Encoder[GeometryType] = Encoder.encodeString.contramap {
    case GeometryType.Point => "Point"
}

case class Properties (
    val Area : String,
    val `Central Asset ID` : String,
    val `Feature Location` : String,
    val lat : String,
    val long : String,
    val `Maintaining Authority` : MaintainingAuthority,
    val Number : String,
    val Class : Class,
    val `Site Name` : String,
    val Ward : Ward
) derives Encoder.AsObject, Decoder

enum MaintainingAuthority : 
    case CityOfBallarat

given Decoder[MaintainingAuthority] = Decoder.decodeString.emap {
    case "City of Ballarat" => scala.Right(MaintainingAuthority.CityOfBallarat)
    case other => scala.Left("invalid MaintainingAuthority: " + other)
}
given Encoder[MaintainingAuthority] = Encoder.encodeString.contramap {
    case MaintainingAuthority.CityOfBallarat => "City of Ballarat"
}

enum Class : 
    case NoCodeAllocated
    case OSDistrict
    case OSNeighbourhood
    case OSRegional

given Decoder[Class] = Decoder.decodeString.emap {
    case "No Code Allocated" => scala.Right(Class.NoCodeAllocated)
    case "OS-District" => scala.Right(Class.OSDistrict)
    case "OS-Neighbourhood" => scala.Right(Class.OSNeighbourhood)
    case "OS-Regional" => scala.Right(Class.OSRegional)
    case other => scala.Left("invalid Class: " + other)
}
given Encoder[Class] = Encoder.encodeString.contramap {
    case Class.NoCodeAllocated => "No Code Allocated"
    case Class.OSDistrict => "OS-District"
    case Class.OSNeighbourhood => "OS-Neighbourhood"
    case Class.OSRegional => "OS-Regional"
}

enum Ward : 
    case South
    case North
    case Central

given Decoder[Ward] = Decoder.decodeString.emap {
    case "South" => scala.Right(Ward.South)
    case "North" => scala.Right(Ward.North)
    case "Central" => scala.Right(Ward.Central)
    case other => scala.Left("invalid Ward: " + other)
}
given Encoder[Ward] = Encoder.encodeString.contramap {
    case Ward.South => "South"
    case Ward.North => "North"
    case Ward.Central => "Central"
}
