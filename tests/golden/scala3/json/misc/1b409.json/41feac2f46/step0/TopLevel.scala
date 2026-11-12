package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val meta : Meta,
    val objects : Seq[Object]
) derives Encoder.AsObject, Decoder

case class Meta (
    val limit : Long,
    val offset : Long,
    val total_count : Long
) derives Encoder.AsObject, Decoder

case class Object (
    val caucus : Option[Json] = None,
    val congress_numbers : Seq[Long],
    val current : Boolean,
    val description : String,
    val district : Long,
    val enddate : String,
    val extra : Extra,
    val id : Long,
    val leadership_title : Option[String] = None,
    val party : Party,
    val person : Person,
    val phone : String,
    val role_type : RoleType,
    val role_type_label : RoleTypeLabel,
    val senator_class : Option[Json] = None,
    val senator_rank : Option[Json] = None,
    val startdate : String,
    val state : String,
    val title : Title,
    val title_long : RoleTypeLabel,
    val website : String
) derives Encoder.AsObject, Decoder

case class Extra (
    val address : String,
    val contact_form : Option[String] = None,
    val fax : Option[String] = None,
    val office : String,
    val rss_url : Option[String] = None
) derives Encoder.AsObject, Decoder

enum Party : 
    case Republican
    case Democrat

given Decoder[Party] = Decoder.decodeString.emap {
    case "Republican" => scala.Right(Party.Republican)
    case "Democrat" => scala.Right(Party.Democrat)
    case other => scala.Left("invalid Party: " + other)
}
given Encoder[Party] = Encoder.encodeString.contramap {
    case Party.Republican => "Republican"
    case Party.Democrat => "Democrat"
}

case class Person (
    val bioguideid : String,
    val birthday : String,
    val cspanid : Long,
    val firstname : String,
    val gender : Gender,
    val gender_label : GenderLabel,
    val id : Long,
    val lastname : String,
    val link : String,
    val middlename : String,
    val name : String,
    val namemod : Namemod,
    val nickname : String,
    val osid : String,
    val pvsid : Option[String] = None,
    val sortname : String,
    val twitterid : Option[String] = None,
    val youtubeid : Option[String] = None
) derives Encoder.AsObject, Decoder

enum Gender : 
    case Male
    case Female

given Decoder[Gender] = Decoder.decodeString.emap {
    case "male" => scala.Right(Gender.Male)
    case "female" => scala.Right(Gender.Female)
    case other => scala.Left("invalid Gender: " + other)
}
given Encoder[Gender] = Encoder.encodeString.contramap {
    case Gender.Male => "male"
    case Gender.Female => "female"
}

enum GenderLabel : 
    case Male
    case Female

given Decoder[GenderLabel] = Decoder.decodeString.emap {
    case "Male" => scala.Right(GenderLabel.Male)
    case "Female" => scala.Right(GenderLabel.Female)
    case other => scala.Left("invalid GenderLabel: " + other)
}
given Encoder[GenderLabel] = Encoder.encodeString.contramap {
    case GenderLabel.Male => "Male"
    case GenderLabel.Female => "Female"
}

enum Namemod : 
    case Empty
    case Jr
    case Ii
    case Iii
    case Iv

given Decoder[Namemod] = Decoder.decodeString.emap {
    case "" => scala.Right(Namemod.Empty)
    case "Jr." => scala.Right(Namemod.Jr)
    case "II" => scala.Right(Namemod.Ii)
    case "III" => scala.Right(Namemod.Iii)
    case "IV" => scala.Right(Namemod.Iv)
    case other => scala.Left("invalid Namemod: " + other)
}
given Encoder[Namemod] = Encoder.encodeString.contramap {
    case Namemod.Empty => ""
    case Namemod.Jr => "Jr."
    case Namemod.Ii => "II"
    case Namemod.Iii => "III"
    case Namemod.Iv => "IV"
}

enum RoleType : 
    case Representative

given Decoder[RoleType] = Decoder.decodeString.emap {
    case "representative" => scala.Right(RoleType.Representative)
    case other => scala.Left("invalid RoleType: " + other)
}
given Encoder[RoleType] = Encoder.encodeString.contramap {
    case RoleType.Representative => "representative"
}

enum RoleTypeLabel : 
    case Representative
    case Delegate
    case ResidentCommissioner

given Decoder[RoleTypeLabel] = Decoder.decodeString.emap {
    case "Representative" => scala.Right(RoleTypeLabel.Representative)
    case "Delegate" => scala.Right(RoleTypeLabel.Delegate)
    case "Resident Commissioner" => scala.Right(RoleTypeLabel.ResidentCommissioner)
    case other => scala.Left("invalid RoleTypeLabel: " + other)
}
given Encoder[RoleTypeLabel] = Encoder.encodeString.contramap {
    case RoleTypeLabel.Representative => "Representative"
    case RoleTypeLabel.Delegate => "Delegate"
    case RoleTypeLabel.ResidentCommissioner => "Resident Commissioner"
}

enum Title : 
    case Rep
    case Commish

given Decoder[Title] = Decoder.decodeString.emap {
    case "Rep." => scala.Right(Title.Rep)
    case "Commish." => scala.Right(Title.Commish)
    case other => scala.Left("invalid Title: " + other)
}
given Encoder[Title] = Encoder.encodeString.contramap {
    case Title.Rep => "Rep."
    case Title.Commish => "Commish."
}
