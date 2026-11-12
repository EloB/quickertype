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
    val adminregion : Adminregion,
    val capitalCity : String,
    val id : String,
    val incomeLevel : Adminregion,
    val iso2Code : String,
    val latitude : String,
    val lendingType : Adminregion,
    val longitude : String,
    val name : String,
    val region : Adminregion
) derives Encoder.AsObject, Decoder

case class Adminregion (
    val id : ID,
    val value : Value
) derives Encoder.AsObject, Decoder

enum ID : 
    case Empty
    case SAS
    case SSA
    case Eca
    case Lac
    case EAP
    case Mna
    case Hic
    case Lic
    case Na
    case Lmc
    case Umc
    case Lnx
    case Idx
    case Ibd
    case Idb
    case Lcn
    case Ssf
    case Ecs
    case Mea
    case EAS
    case Nac

given Decoder[ID] = Decoder.decodeString.emap {
    case "" => scala.Right(ID.Empty)
    case "SAS" => scala.Right(ID.SAS)
    case "SSA" => scala.Right(ID.SSA)
    case "ECA" => scala.Right(ID.Eca)
    case "LAC" => scala.Right(ID.Lac)
    case "EAP" => scala.Right(ID.EAP)
    case "MNA" => scala.Right(ID.Mna)
    case "HIC" => scala.Right(ID.Hic)
    case "LIC" => scala.Right(ID.Lic)
    case "NA" => scala.Right(ID.Na)
    case "LMC" => scala.Right(ID.Lmc)
    case "UMC" => scala.Right(ID.Umc)
    case "LNX" => scala.Right(ID.Lnx)
    case "IDX" => scala.Right(ID.Idx)
    case "IBD" => scala.Right(ID.Ibd)
    case "IDB" => scala.Right(ID.Idb)
    case "LCN" => scala.Right(ID.Lcn)
    case "SSF" => scala.Right(ID.Ssf)
    case "ECS" => scala.Right(ID.Ecs)
    case "MEA" => scala.Right(ID.Mea)
    case "EAS" => scala.Right(ID.EAS)
    case "NAC" => scala.Right(ID.Nac)
    case other => scala.Left("invalid ID: " + other)
}
given Encoder[ID] = Encoder.encodeString.contramap {
    case ID.Empty => ""
    case ID.SAS => "SAS"
    case ID.SSA => "SSA"
    case ID.Eca => "ECA"
    case ID.Lac => "LAC"
    case ID.EAP => "EAP"
    case ID.Mna => "MNA"
    case ID.Hic => "HIC"
    case ID.Lic => "LIC"
    case ID.Na => "NA"
    case ID.Lmc => "LMC"
    case ID.Umc => "UMC"
    case ID.Lnx => "LNX"
    case ID.Idx => "IDX"
    case ID.Ibd => "IBD"
    case ID.Idb => "IDB"
    case ID.Lcn => "LCN"
    case ID.Ssf => "SSF"
    case ID.Ecs => "ECS"
    case ID.Mea => "MEA"
    case ID.EAS => "EAS"
    case ID.Nac => "NAC"
}

enum Value : 
    case Empty
    case SouthAsia
    case SubSaharanAfricaExcludingHighIncome
    case EuropeCentralAsiaExcludingHighIncome
    case LatinAmericaCaribbeanExcludingHighIncome
    case EastAsiaPacificExcludingHighIncome
    case MiddleEastNorthAfricaExcludingHighIncome
    case HighIncome
    case LowIncome
    case Aggregates
    case LowerMiddleIncome
    case UpperMiddleIncome
    case NotClassified
    case Ida
    case Ibrd
    case Blend
    case LatinAmericaCaribbean
    case SubSaharanAfrica
    case EuropeCentralAsia
    case MiddleEastNorthAfrica
    case EastAsiaPacific
    case NorthAmerica

given Decoder[Value] = Decoder.decodeString.emap {
    case "" => scala.Right(Value.Empty)
    case "South Asia" => scala.Right(Value.SouthAsia)
    case "Sub-Saharan Africa (excluding high income)" => scala.Right(Value.SubSaharanAfricaExcludingHighIncome)
    case "Europe & Central Asia (excluding high income)" => scala.Right(Value.EuropeCentralAsiaExcludingHighIncome)
    case "Latin America & Caribbean (excluding high income)" => scala.Right(Value.LatinAmericaCaribbeanExcludingHighIncome)
    case "East Asia & Pacific (excluding high income)" => scala.Right(Value.EastAsiaPacificExcludingHighIncome)
    case "Middle East & North Africa (excluding high income)" => scala.Right(Value.MiddleEastNorthAfricaExcludingHighIncome)
    case "High income" => scala.Right(Value.HighIncome)
    case "Low income" => scala.Right(Value.LowIncome)
    case "Aggregates" => scala.Right(Value.Aggregates)
    case "Lower middle income" => scala.Right(Value.LowerMiddleIncome)
    case "Upper middle income" => scala.Right(Value.UpperMiddleIncome)
    case "Not classified" => scala.Right(Value.NotClassified)
    case "IDA" => scala.Right(Value.Ida)
    case "IBRD" => scala.Right(Value.Ibrd)
    case "Blend" => scala.Right(Value.Blend)
    case "Latin America & Caribbean " => scala.Right(Value.LatinAmericaCaribbean)
    case "Sub-Saharan Africa " => scala.Right(Value.SubSaharanAfrica)
    case "Europe & Central Asia" => scala.Right(Value.EuropeCentralAsia)
    case "Middle East & North Africa" => scala.Right(Value.MiddleEastNorthAfrica)
    case "East Asia & Pacific" => scala.Right(Value.EastAsiaPacific)
    case "North America" => scala.Right(Value.NorthAmerica)
    case other => scala.Left("invalid Value: " + other)
}
given Encoder[Value] = Encoder.encodeString.contramap {
    case Value.Empty => ""
    case Value.SouthAsia => "South Asia"
    case Value.SubSaharanAfricaExcludingHighIncome => "Sub-Saharan Africa (excluding high income)"
    case Value.EuropeCentralAsiaExcludingHighIncome => "Europe & Central Asia (excluding high income)"
    case Value.LatinAmericaCaribbeanExcludingHighIncome => "Latin America & Caribbean (excluding high income)"
    case Value.EastAsiaPacificExcludingHighIncome => "East Asia & Pacific (excluding high income)"
    case Value.MiddleEastNorthAfricaExcludingHighIncome => "Middle East & North Africa (excluding high income)"
    case Value.HighIncome => "High income"
    case Value.LowIncome => "Low income"
    case Value.Aggregates => "Aggregates"
    case Value.LowerMiddleIncome => "Lower middle income"
    case Value.UpperMiddleIncome => "Upper middle income"
    case Value.NotClassified => "Not classified"
    case Value.Ida => "IDA"
    case Value.Ibrd => "IBRD"
    case Value.Blend => "Blend"
    case Value.LatinAmericaCaribbean => "Latin America & Caribbean "
    case Value.SubSaharanAfrica => "Sub-Saharan Africa "
    case Value.EuropeCentralAsia => "Europe & Central Asia"
    case Value.MiddleEastNorthAfrica => "Middle East & North Africa"
    case Value.EastAsiaPacific => "East Asia & Pacific"
    case Value.NorthAmerica => "North America"
}

case class FluffyTopLevel (
    val page : Long,
    val pages : Long,
    val per_page : String,
    val total : Long
) derives Encoder.AsObject, Decoder
