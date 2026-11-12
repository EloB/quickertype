package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

type TopLevel = List[TopLevelUnion]
given (using ev : TopLevelUnion): Encoder[Seq[TopLevelUnion]] = Encoder.encodeSeq[TopLevelUnion]

type TopLevelUnion = FluffyTopLevel | Seq[PurpleTopLevel] | String
given Decoder[TopLevelUnion] = {
    List[Decoder[TopLevelUnion]](
        Decoder[String].widen,
        Decoder[Seq[PurpleTopLevel]].widen,
        Decoder[FluffyTopLevel].widen,
    ).reduceLeft(_ or _)
}

given Encoder[TopLevelUnion] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Seq[PurpleTopLevel] => Encoder.encodeSeq[PurpleTopLevel].apply(enc1)
    case enc2 : FluffyTopLevel => Encoder.AsObject[FluffyTopLevel].apply(enc2)
}

case class PurpleTopLevel (
    val ALIENLEVEL : Long,
    val BREED : Breed,
    val CHAR_DIMENSION : Long,
    val CHAR_INSTANCE : Long,
    val DEFENDER_RANK_TITLE : String,
    val FIRSTNAME : Firstname,
    val HEADID : Long,
    val LASTNAME : Lastname,
    val LEVELX : Long,
    val NAME : String,
    val PROF : String,
    val PROF_TITLE : String,
    val PVPRATING : Long,
    val PVPTITLE : Pvptitle,
    val RANK : Long,
    val RANK_TITLE : RankTitle,
    val SEX : Sex
) derives Encoder.AsObject, Decoder

enum Breed : 
    case Atrox
    case Solitus
    case Opifex
    case Nano

given Decoder[Breed] = Decoder.decodeString.emap {
    case "Atrox" => scala.Right(Breed.Atrox)
    case "Solitus" => scala.Right(Breed.Solitus)
    case "Opifex" => scala.Right(Breed.Opifex)
    case "Nano" => scala.Right(Breed.Nano)
    case other => scala.Left("invalid Breed: " + other)
}
given Encoder[Breed] = Encoder.encodeString.contramap {
    case Breed.Atrox => "Atrox"
    case Breed.Solitus => "Solitus"
    case Breed.Opifex => "Opifex"
    case Breed.Nano => "Nano"
}

enum Firstname : 
    case Empty
    case Chi

given Decoder[Firstname] = Decoder.decodeString.emap {
    case "" => scala.Right(Firstname.Empty)
    case "Chi" => scala.Right(Firstname.Chi)
    case other => scala.Left("invalid Firstname: " + other)
}
given Encoder[Firstname] = Encoder.encodeString.contramap {
    case Firstname.Empty => ""
    case Firstname.Chi => "Chi"
}

enum Lastname : 
    case Empty
    case Washko

given Decoder[Lastname] = Decoder.decodeString.emap {
    case "" => scala.Right(Lastname.Empty)
    case "Washko" => scala.Right(Lastname.Washko)
    case other => scala.Left("invalid Lastname: " + other)
}
given Encoder[Lastname] = Encoder.encodeString.contramap {
    case Lastname.Empty => ""
    case Lastname.Washko => "Washko"
}

enum Pvptitle : 
    case Freshman

given Decoder[Pvptitle] = Decoder.decodeString.emap {
    case "Freshman" => scala.Right(Pvptitle.Freshman)
    case other => scala.Left("invalid Pvptitle: " + other)
}
given Encoder[Pvptitle] = Encoder.encodeString.contramap {
    case Pvptitle.Freshman => "Freshman"
}

enum RankTitle : 
    case President
    case Advisor
    case Veteran
    case Applicant

given Decoder[RankTitle] = Decoder.decodeString.emap {
    case "President" => scala.Right(RankTitle.President)
    case "Advisor" => scala.Right(RankTitle.Advisor)
    case "Veteran" => scala.Right(RankTitle.Veteran)
    case "Applicant" => scala.Right(RankTitle.Applicant)
    case other => scala.Left("invalid RankTitle: " + other)
}
given Encoder[RankTitle] = Encoder.encodeString.contramap {
    case RankTitle.President => "President"
    case RankTitle.Advisor => "Advisor"
    case RankTitle.Veteran => "Veteran"
    case RankTitle.Applicant => "Applicant"
}

enum Sex : 
    case Neuter
    case Male
    case Female

given Decoder[Sex] = Decoder.decodeString.emap {
    case "Neuter" => scala.Right(Sex.Neuter)
    case "Male" => scala.Right(Sex.Male)
    case "Female" => scala.Right(Sex.Female)
    case other => scala.Left("invalid Sex: " + other)
}
given Encoder[Sex] = Encoder.encodeString.contramap {
    case Sex.Neuter => "Neuter"
    case Sex.Male => "Male"
    case Sex.Female => "Female"
}

case class FluffyTopLevel (
    val ADVENTURERCOUNT : Long,
    val AGENTCOUNT : Long,
    val ATROXCOUNT : Long,
    val AVGLVL : Double,
    val BTCOUNT : Long,
    val DESCRIPTION : String,
    val DOCTORCOUNT : Long,
    val ENFCOUNT : Long,
    val ENGINEEERCOUNT : Long,
    val FEMALECOUNT : Long,
    val FIXERCOUNT : Long,
    val GOVERNINGNAME : String,
    val HISTORY : String,
    val KEEPERCOUNT : Long,
    val MACOUNT : Long,
    val MALECOUNT : Long,
    val MAXLVL : Long,
    val METACOUNT : Long,
    val MINLVL : Long,
    val MONSTERCOUNT : Long,
    val NAME : String,
    val NANOCOUNT : Long,
    val NANORACECOUNT : Long,
    val NEUTERCOUNT : Long,
    val NUMMEMBERS : Long,
    val OBJECTIVE : String,
    val OPIFEXCOUNT : Long,
    val ORG_DIMENSION : Long,
    val ORG_INSTANCE : Long,
    val SHADECOUNT : Long,
    val SIDE : Long,
    val SIDE_NAME : String,
    val SOLIDERCOUNT : Long,
    val SOLITUSCOUNT : Long,
    val TRADERCOUNT : Long
) derives Encoder.AsObject, Decoder
