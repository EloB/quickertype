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
    val division : String,
    val fax : Double,
    val fire_ban_r : Option[FireBanR] = None,
    val latitude : Double,
    val local_govt : String,
    val longitude : Double,
    val no : Option[String] = None,
    val phone : Double,
    val postcode : Long,
    val `type` : Option[PropertiesType] = None,
    val psa : String,
    val region : Region,
    val station : String,
    val street : String,
    val suburb : String
) derives Encoder.AsObject, Decoder

enum FireBanR : 
    case NorthCentral
    case Central
    case SouthWest
    case Wimmera
    case NorthernCountry
    case EastGippsland
    case NorthEast
    case Mallee
    case WestSouthGippsland
    case Ballarat

given Decoder[FireBanR] = Decoder.decodeString.emap {
    case "North Central" => scala.Right(FireBanR.NorthCentral)
    case "Central" => scala.Right(FireBanR.Central)
    case "South West" => scala.Right(FireBanR.SouthWest)
    case "Wimmera" => scala.Right(FireBanR.Wimmera)
    case "Northern Country" => scala.Right(FireBanR.NorthernCountry)
    case "East Gippsland" => scala.Right(FireBanR.EastGippsland)
    case "North East" => scala.Right(FireBanR.NorthEast)
    case "Mallee" => scala.Right(FireBanR.Mallee)
    case "West &South Gippsland" => scala.Right(FireBanR.WestSouthGippsland)
    case "Ballarat" => scala.Right(FireBanR.Ballarat)
    case other => scala.Left("invalid FireBanR: " + other)
}
given Encoder[FireBanR] = Encoder.encodeString.contramap {
    case FireBanR.NorthCentral => "North Central"
    case FireBanR.Central => "Central"
    case FireBanR.SouthWest => "South West"
    case FireBanR.Wimmera => "Wimmera"
    case FireBanR.NorthernCountry => "Northern Country"
    case FireBanR.EastGippsland => "East Gippsland"
    case FireBanR.NorthEast => "North East"
    case FireBanR.Mallee => "Mallee"
    case FireBanR.WestSouthGippsland => "West &South Gippsland"
    case FireBanR.Ballarat => "Ballarat"
}

enum PropertiesType : 
    case Street
    case Avenue
    case Road
    case Highway
    case Boulevard
    case Court
    case Way
    case Drive
    case South
    case Hill
    case Lane
    case Close
    case Parade
    case TypeRoad
    case Place
    case RD

given Decoder[PropertiesType] = Decoder.decodeString.emap {
    case "STREET" => scala.Right(PropertiesType.Street)
    case "AVENUE" => scala.Right(PropertiesType.Avenue)
    case "ROAD" => scala.Right(PropertiesType.Road)
    case "HIGHWAY" => scala.Right(PropertiesType.Highway)
    case "BOULEVARD" => scala.Right(PropertiesType.Boulevard)
    case "COURT" => scala.Right(PropertiesType.Court)
    case "WAY" => scala.Right(PropertiesType.Way)
    case "DRIVE" => scala.Right(PropertiesType.Drive)
    case "SOUTH" => scala.Right(PropertiesType.South)
    case "HILL" => scala.Right(PropertiesType.Hill)
    case "LANE" => scala.Right(PropertiesType.Lane)
    case "CLOSE" => scala.Right(PropertiesType.Close)
    case "PARADE" => scala.Right(PropertiesType.Parade)
    case "Road" => scala.Right(PropertiesType.TypeRoad)
    case "PLACE" => scala.Right(PropertiesType.Place)
    case "RD" => scala.Right(PropertiesType.RD)
    case other => scala.Left("invalid PropertiesType: " + other)
}
given Encoder[PropertiesType] = Encoder.encodeString.contramap {
    case PropertiesType.Street => "STREET"
    case PropertiesType.Avenue => "AVENUE"
    case PropertiesType.Road => "ROAD"
    case PropertiesType.Highway => "HIGHWAY"
    case PropertiesType.Boulevard => "BOULEVARD"
    case PropertiesType.Court => "COURT"
    case PropertiesType.Way => "WAY"
    case PropertiesType.Drive => "DRIVE"
    case PropertiesType.South => "SOUTH"
    case PropertiesType.Hill => "HILL"
    case PropertiesType.Lane => "LANE"
    case PropertiesType.Close => "CLOSE"
    case PropertiesType.Parade => "PARADE"
    case PropertiesType.TypeRoad => "Road"
    case PropertiesType.Place => "PLACE"
    case PropertiesType.RD => "RD"
}

enum Region : 
    case Eastern
    case NorthernMetro
    case Western
    case SouthernMetro

given Decoder[Region] = Decoder.decodeString.emap {
    case "Eastern" => scala.Right(Region.Eastern)
    case "Northern Metro" => scala.Right(Region.NorthernMetro)
    case "Western" => scala.Right(Region.Western)
    case "Southern Metro" => scala.Right(Region.SouthernMetro)
    case other => scala.Left("invalid Region: " + other)
}
given Encoder[Region] = Encoder.encodeString.contramap {
    case Region.Eastern => "Eastern"
    case Region.NorthernMetro => "Northern Metro"
    case Region.Western => "Western"
    case Region.SouthernMetro => "Southern Metro"
}
