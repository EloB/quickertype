package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val bbox : Seq[Double],
    val features : Seq[Feature],
    val metadata : Metadata,
    val `type` : String
) derives Encoder.AsObject, Decoder

case class Feature (
    val `type` : FeatureType,
    val geometry : Geometry,
    val id : String,
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
    val alert : Option[Json] = None,
    val cdi : Option[Json] = None,
    val code : String,
    val detail : String,
    val dmin : Option[Double] = None,
    val felt : Option[Json] = None,
    val gap : Option[Long] = None,
    val ids : String,
    val mag : Double,
    val magType : MagType,
    val mmi : Option[Json] = None,
    val net : String,
    val nst : Option[Long] = None,
    val place : String,
    val `type` : PropertiesType,
    val rms : Double,
    val sig : Long,
    val sources : String,
    val status : Status,
    val time : Long,
    val title : String,
    val tsunami : Long,
    val types : String,
    val tz : Long,
    val updated : Long,
    val url : String
) derives Encoder.AsObject, Decoder

enum MagType : 
    case Md
    case Ml
    case MB

given Decoder[MagType] = Decoder.decodeString.emap {
    case "md" => scala.Right(MagType.Md)
    case "ml" => scala.Right(MagType.Ml)
    case "mb" => scala.Right(MagType.MB)
    case other => scala.Left("invalid MagType: " + other)
}
given Encoder[MagType] = Encoder.encodeString.contramap {
    case MagType.Md => "md"
    case MagType.Ml => "ml"
    case MagType.MB => "mb"
}

enum PropertiesType : 
    case Earthquake

given Decoder[PropertiesType] = Decoder.decodeString.emap {
    case "earthquake" => scala.Right(PropertiesType.Earthquake)
    case other => scala.Left("invalid PropertiesType: " + other)
}
given Encoder[PropertiesType] = Encoder.encodeString.contramap {
    case PropertiesType.Earthquake => "earthquake"
}

enum Status : 
    case Automatic
    case Reviewed

given Decoder[Status] = Decoder.decodeString.emap {
    case "automatic" => scala.Right(Status.Automatic)
    case "reviewed" => scala.Right(Status.Reviewed)
    case other => scala.Left("invalid Status: " + other)
}
given Encoder[Status] = Encoder.encodeString.contramap {
    case Status.Automatic => "automatic"
    case Status.Reviewed => "reviewed"
}

case class Metadata (
    val api : String,
    val count : Long,
    val generated : Long,
    val status : Long,
    val title : String,
    val url : String
) derives Encoder.AsObject, Decoder
