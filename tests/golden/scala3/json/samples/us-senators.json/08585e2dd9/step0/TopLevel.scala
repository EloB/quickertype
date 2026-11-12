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
    val caucus : Option[Party] = None,
    val congress_numbers : Seq[Long],
    val current : Boolean,
    val description : String,
    val district : Option[Json] = None,
    val enddate : String,
    val extra : Extra,
    val leadership_title : Option[String] = None,
    val party : Party,
    val person : Person,
    val phone : String,
    val role_type : RoleType,
    val role_type_label : RoleTypeLabel,
    val senator_class : SenatorClass,
    val senator_class_label : SenatorClassLabel,
    val senator_rank : SenatorRank,
    val senator_rank_label : SenatorRankLabel,
    val startdate : String,
    val state : String,
    val title : Title,
    val title_long : RoleTypeLabel,
    val website : String
) derives Encoder.AsObject, Decoder

enum Party : 
    case Democrat
    case Republican
    case Independent

given Decoder[Party] = Decoder.decodeString.emap {
    case "Democrat" => scala.Right(Party.Democrat)
    case "Republican" => scala.Right(Party.Republican)
    case "Independent" => scala.Right(Party.Independent)
    case other => scala.Left("invalid Party: " + other)
}
given Encoder[Party] = Encoder.encodeString.contramap {
    case Party.Democrat => "Democrat"
    case Party.Republican => "Republican"
    case Party.Independent => "Independent"
}

case class Extra (
    val address : String,
    val contact_form : String,
    val fax : Option[String] = None,
    val office : String,
    val rss_url : Option[String] = None
) derives Encoder.AsObject, Decoder

case class Person (
    val bioguideid : String,
    val birthday : String,
    val cspanid : Long,
    val firstname : String,
    val gender : Gender,
    val gender_label : GenderLabel,
    val lastname : String,
    val link : String,
    val middlename : String,
    val name : String,
    val namemod : Namemod,
    val nickname : String,
    val osid : String,
    val pvsid : String,
    val sortname : String,
    val twitterid : Option[String] = None,
    val youtubeid : Option[String] = None
) derives Encoder.AsObject, Decoder

enum Gender : 
    case Female
    case Male

given Decoder[Gender] = Decoder.decodeString.emap {
    case "female" => scala.Right(Gender.Female)
    case "male" => scala.Right(Gender.Male)
    case other => scala.Left("invalid Gender: " + other)
}
given Encoder[Gender] = Encoder.encodeString.contramap {
    case Gender.Female => "female"
    case Gender.Male => "male"
}

enum GenderLabel : 
    case Female
    case Male

given Decoder[GenderLabel] = Decoder.decodeString.emap {
    case "Female" => scala.Right(GenderLabel.Female)
    case "Male" => scala.Right(GenderLabel.Male)
    case other => scala.Left("invalid GenderLabel: " + other)
}
given Encoder[GenderLabel] = Encoder.encodeString.contramap {
    case GenderLabel.Female => "Female"
    case GenderLabel.Male => "Male"
}

enum Namemod : 
    case Empty
    case Jr
    case Iii

given Decoder[Namemod] = Decoder.decodeString.emap {
    case "" => scala.Right(Namemod.Empty)
    case "Jr." => scala.Right(Namemod.Jr)
    case "III" => scala.Right(Namemod.Iii)
    case other => scala.Left("invalid Namemod: " + other)
}
given Encoder[Namemod] = Encoder.encodeString.contramap {
    case Namemod.Empty => ""
    case Namemod.Jr => "Jr."
    case Namemod.Iii => "III"
}

enum RoleType : 
    case Senator

given Decoder[RoleType] = Decoder.decodeString.emap {
    case "senator" => scala.Right(RoleType.Senator)
    case other => scala.Left("invalid RoleType: " + other)
}
given Encoder[RoleType] = Encoder.encodeString.contramap {
    case RoleType.Senator => "senator"
}

enum RoleTypeLabel : 
    case Senator

given Decoder[RoleTypeLabel] = Decoder.decodeString.emap {
    case "Senator" => scala.Right(RoleTypeLabel.Senator)
    case other => scala.Left("invalid RoleTypeLabel: " + other)
}
given Encoder[RoleTypeLabel] = Encoder.encodeString.contramap {
    case RoleTypeLabel.Senator => "Senator"
}

enum SenatorClass : 
    case Class1
    case Class2
    case Class3

given Decoder[SenatorClass] = Decoder.decodeString.emap {
    case "class1" => scala.Right(SenatorClass.Class1)
    case "class2" => scala.Right(SenatorClass.Class2)
    case "class3" => scala.Right(SenatorClass.Class3)
    case other => scala.Left("invalid SenatorClass: " + other)
}
given Encoder[SenatorClass] = Encoder.encodeString.contramap {
    case SenatorClass.Class1 => "class1"
    case SenatorClass.Class2 => "class2"
    case SenatorClass.Class3 => "class3"
}

enum SenatorClassLabel : 
    case Class1
    case Class2
    case Class3

given Decoder[SenatorClassLabel] = Decoder.decodeString.emap {
    case "Class 1" => scala.Right(SenatorClassLabel.Class1)
    case "Class 2" => scala.Right(SenatorClassLabel.Class2)
    case "Class 3" => scala.Right(SenatorClassLabel.Class3)
    case other => scala.Left("invalid SenatorClassLabel: " + other)
}
given Encoder[SenatorClassLabel] = Encoder.encodeString.contramap {
    case SenatorClassLabel.Class1 => "Class 1"
    case SenatorClassLabel.Class2 => "Class 2"
    case SenatorClassLabel.Class3 => "Class 3"
}

enum SenatorRank : 
    case Junior
    case Senior

given Decoder[SenatorRank] = Decoder.decodeString.emap {
    case "junior" => scala.Right(SenatorRank.Junior)
    case "senior" => scala.Right(SenatorRank.Senior)
    case other => scala.Left("invalid SenatorRank: " + other)
}
given Encoder[SenatorRank] = Encoder.encodeString.contramap {
    case SenatorRank.Junior => "junior"
    case SenatorRank.Senior => "senior"
}

enum SenatorRankLabel : 
    case Junior
    case Senior

given Decoder[SenatorRankLabel] = Decoder.decodeString.emap {
    case "Junior" => scala.Right(SenatorRankLabel.Junior)
    case "Senior" => scala.Right(SenatorRankLabel.Senior)
    case other => scala.Left("invalid SenatorRankLabel: " + other)
}
given Encoder[SenatorRankLabel] = Encoder.encodeString.contramap {
    case SenatorRankLabel.Junior => "Junior"
    case SenatorRankLabel.Senior => "Senior"
}

enum Title : 
    case Sen

given Decoder[Title] = Decoder.decodeString.emap {
    case "Sen." => scala.Right(Title.Sen)
    case other => scala.Left("invalid Title: " + other)
}
given Encoder[Title] = Encoder.encodeString.contramap {
    case Title.Sen => "Sen."
}
