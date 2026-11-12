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
    val coordinates : Seq[Seq[Seq[Seq[Double]]]],
    val `type` : GeometryType
) derives Encoder.AsObject, Decoder

enum GeometryType : 
    case MultiPolygon

given Decoder[GeometryType] = Decoder.decodeString.emap {
    case "MultiPolygon" => scala.Right(GeometryType.MultiPolygon)
    case other => scala.Left("invalid GeometryType: " + other)
}
given Encoder[GeometryType] = Encoder.encodeString.contramap {
    case GeometryType.MultiPolygon => "MultiPolygon"
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
    val add_improv : Option[AddImprov] = None,
    val `area_` : Double,
    val asset_numb : String,
    val comments : Option[String] = None,
    val condition : Long,
    val constructi : Option[String] = None,
    val createdate : Option[Json] = None,
    val createuser : Option[Json] = None,
    val disposal_d : Option[Json] = None,
    val documents : String,
    val drawing_nu : Option[String] = None,
    val file_numbe : Option[String] = None,
    val folder_num : Option[String] = None,
    val funding_ba : Option[FundingBa] = None,
    val historic_c : Long,
    val inspection : String,
    val inspectors : Option[Json] = None,
    val last_updat : Option[Json] = None,
    val level_accu : Option[LevelAccu] = None,
    val material : Material,
    val mi_prinx : Long,
    val mi_symbolo : MiSymbolo,
    val number_lan : Long,
    val owner : Option[String] = None,
    val positional : Option[LevelAccu] = None,
    val project_nu : Option[String] = None,
    val `type` : Option[PropertiesType] = None,
    val rec_id : Long,
    val record_cre : Option[String] = None,
    val shape_area : Double,
    val shape_leng : Double,
    val status : Status,
    val survey_num : Option[Json] = None,
    val toe_rl : Double,
    val top_rl : Double,
    val update_dat : String,
    val updatedate : Option[Json] = None,
    val updateuser : Option[Json] = None
) derives Encoder.AsObject, Decoder

enum AddImprov : 
    case F
    case AddImprovF
    case T

given Decoder[AddImprov] = Decoder.decodeString.emap {
    case "f" => scala.Right(AddImprov.F)
    case "F" => scala.Right(AddImprov.AddImprovF)
    case "t" => scala.Right(AddImprov.T)
    case other => scala.Left("invalid AddImprov: " + other)
}
given Encoder[AddImprov] = Encoder.encodeString.contramap {
    case AddImprov.F => "f"
    case AddImprov.AddImprovF => "F"
    case AddImprov.T => "t"
}

enum FundingBa : 
    case NonGCCC
    case Capex
    case Initial
    case Contribute

given Decoder[FundingBa] = Decoder.decodeString.emap {
    case "Non GCCC" => scala.Right(FundingBa.NonGCCC)
    case "Capex" => scala.Right(FundingBa.Capex)
    case "Initial" => scala.Right(FundingBa.Initial)
    case "Contribute" => scala.Right(FundingBa.Contribute)
    case other => scala.Left("invalid FundingBa: " + other)
}
given Encoder[FundingBa] = Encoder.encodeString.contramap {
    case FundingBa.NonGCCC => "Non GCCC"
    case FundingBa.Capex => "Capex"
    case FundingBa.Initial => "Initial"
    case FundingBa.Contribute => "Contribute"
}

enum LevelAccu : 
    case GPSCorrected10M
    case Approx
    case GPSCOrrected10M

given Decoder[LevelAccu] = Decoder.decodeString.emap {
    case "GPS Corrected 1.0M" => scala.Right(LevelAccu.GPSCorrected10M)
    case "APPROX" => scala.Right(LevelAccu.Approx)
    case "GPS COrrected 1.0M" => scala.Right(LevelAccu.GPSCOrrected10M)
    case other => scala.Left("invalid LevelAccu: " + other)
}
given Encoder[LevelAccu] = Encoder.encodeString.contramap {
    case LevelAccu.GPSCorrected10M => "GPS Corrected 1.0M"
    case LevelAccu.Approx => "APPROX"
    case LevelAccu.GPSCOrrected10M => "GPS COrrected 1.0M"
}

enum Material : 
    case Gravel
    case Concrete
    case Bitumen
    case InterlockConcBlock
    case Other
    case Earth

given Decoder[Material] = Decoder.decodeString.emap {
    case "Gravel" => scala.Right(Material.Gravel)
    case "Concrete" => scala.Right(Material.Concrete)
    case "Bitumen" => scala.Right(Material.Bitumen)
    case "Interlock Conc Block" => scala.Right(Material.InterlockConcBlock)
    case "Other" => scala.Right(Material.Other)
    case "Earth" => scala.Right(Material.Earth)
    case other => scala.Left("invalid Material: " + other)
}
given Encoder[Material] = Encoder.encodeString.contramap {
    case Material.Gravel => "Gravel"
    case Material.Concrete => "Concrete"
    case Material.Bitumen => "Bitumen"
    case Material.InterlockConcBlock => "Interlock Conc Block"
    case Material.Other => "Other"
    case Material.Earth => "Earth"
}

enum MiSymbolo : 
    case Pen2265535Brush1016777215

given Decoder[MiSymbolo] = Decoder.decodeString.emap {
    case "Pen (2, 2, 65535) Brush (1, 0, 16777215)" => scala.Right(MiSymbolo.Pen2265535Brush1016777215)
    case other => scala.Left("invalid MiSymbolo: " + other)
}
given Encoder[MiSymbolo] = Encoder.encodeString.contramap {
    case MiSymbolo.Pen2265535Brush1016777215 => "Pen (2, 2, 65535) Brush (1, 0, 16777215)"
}

enum PropertiesType : 
    case BoatRamp

given Decoder[PropertiesType] = Decoder.decodeString.emap {
    case "Boat Ramp" => scala.Right(PropertiesType.BoatRamp)
    case other => scala.Left("invalid PropertiesType: " + other)
}
given Encoder[PropertiesType] = Encoder.encodeString.contramap {
    case PropertiesType.BoatRamp => "Boat Ramp"
}

enum Status : 
    case Current

given Decoder[Status] = Decoder.decodeString.emap {
    case "CURRENT" => scala.Right(Status.Current)
    case other => scala.Left("invalid Status: " + other)
}
given Encoder[Status] = Encoder.encodeString.contramap {
    case Status.Current => "CURRENT"
}
