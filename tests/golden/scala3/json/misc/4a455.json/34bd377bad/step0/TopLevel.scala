package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val crs : CRS,
    val features : Seq[Feature],
    val `type` : String,
    val totalFeatures : Long
) derives Encoder.AsObject, Decoder

case class CRS (
    val `type` : String,
    val properties : CRSProperties
) derives Encoder.AsObject, Decoder

case class CRSProperties (
    val name : String
) derives Encoder.AsObject, Decoder

case class Feature (
    val `type` : FeatureType,
    val geometry : Geometry,
    val geometry_name : GeometryName,
    val id : String,
    val properties : FeatureProperties
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
    val coordinates : Seq[Seq[Double]],
    val `type` : GeometryType
) derives Encoder.AsObject, Decoder

enum GeometryType : 
    case MultiPoint

given Decoder[GeometryType] = Decoder.decodeString.emap {
    case "MultiPoint" => scala.Right(GeometryType.MultiPoint)
    case other => scala.Left("invalid GeometryType: " + other)
}
given Encoder[GeometryType] = Encoder.encodeString.contramap {
    case GeometryType.MultiPoint => "MultiPoint"
}

enum GeometryName : 
    case Geom

given Decoder[GeometryName] = Decoder.decodeString.emap {
    case "geom" => scala.Right(GeometryName.Geom)
    case other => scala.Left("invalid GeometryName: " + other)
}
given Encoder[GeometryName] = Encoder.encodeString.contramap {
    case GeometryName.Geom => "geom"
}

case class FeatureProperties (
    val facebookaccount : String,
    val frequencyfinderurl : String,
    val name : String,
    val siteurl : String,
    val streetaddress : String,
    val twitteraccount : String
) derives Encoder.AsObject, Decoder
