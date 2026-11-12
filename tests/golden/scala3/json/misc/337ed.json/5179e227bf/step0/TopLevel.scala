package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val count : Long,
    val facets : Facets,
    val limit : Long,
    val next : String,
    val offset : Long,
    val previous : Boolean,
    val results : Seq[Result]
) derives Encoder.AsObject, Decoder

case class Facets()  derives Encoder.AsObject, Decoder

case class Result (
    val cost_absolute : Option[Long] = None,
    val cost_max : Option[Long] = None,
    val cost_min : Option[Long] = None,
    val created_at : java.time.Instant,
    val customIncomes : Seq[CustomIncome],
    val direct_rep_costs_max : Option[Json] = None,
    val direct_rep_costs_min : Option[Json] = None,
    val end_date : java.time.Instant,
    val eur_sources_grants : Long,
    val eur_sources_grants_src : Option[String] = None,
    val eur_sources_procurement : Long,
    val eur_sources_procurement_src : Option[String] = None,
    val id : String,
    val new_organisation : Option[Json] = None,
    val no_clients : Option[String] = None,
    val other_financial_information : Option[String] = None,
    val other_sources_contributions : Option[Long] = None,
    val other_sources_donation : Option[Long] = None,
    val other_sources_total : Option[Long] = None,
    val public_financing_infranational : Option[Long] = None,
    val public_financing_national : Option[Long] = None,
    val public_financing_total : Option[Long] = None,
    val representative : String,
    val `type` : ResultType,
    val start_date : java.time.Instant,
    val status : Status,
    val total_budget : Option[Long] = None,
    val turnover_absolute : Option[Long] = None,
    val turnover_max : Option[Long] = None,
    val turnover_min : Option[Long] = None,
    val updated_at : java.time.Instant,
    val uri : String
) derives Encoder.AsObject, Decoder

case class CustomIncome (
    val amount : Long,
    val created_at : java.time.Instant,
    val `type` : CustomIncomeType,
    val id : String,
    val name : String,
    val status : Status,
    val updated_at : java.time.Instant,
    val uri : String
) derives Encoder.AsObject, Decoder

enum CustomIncomeType : 
    case Public
    case Other

given Decoder[CustomIncomeType] = Decoder.decodeString.emap {
    case "public" => scala.Right(CustomIncomeType.Public)
    case "other" => scala.Right(CustomIncomeType.Other)
    case other => scala.Left("invalid CustomIncomeType: " + other)
}
given Encoder[CustomIncomeType] = Encoder.encodeString.contramap {
    case CustomIncomeType.Public => "public"
    case CustomIncomeType.Other => "other"
}

enum Status : 
    case Active
    case Inactive

given Decoder[Status] = Decoder.decodeString.emap {
    case "active" => scala.Right(Status.Active)
    case "inactive" => scala.Right(Status.Inactive)
    case other => scala.Left("invalid Status: " + other)
}
given Encoder[Status] = Encoder.encodeString.contramap {
    case Status.Active => "active"
    case Status.Inactive => "inactive"
}

enum ResultType : 
    case FinancialDataNGO
    case FinancialDataLawyer
    case FinancialDataTradeAssociation

given Decoder[ResultType] = Decoder.decodeString.emap {
    case "FinancialDataNGO" => scala.Right(ResultType.FinancialDataNGO)
    case "FinancialDataLawyer" => scala.Right(ResultType.FinancialDataLawyer)
    case "FinancialDataTradeAssociation" => scala.Right(ResultType.FinancialDataTradeAssociation)
    case other => scala.Left("invalid ResultType: " + other)
}
given Encoder[ResultType] = Encoder.encodeString.contramap {
    case ResultType.FinancialDataNGO => "FinancialDataNGO"
    case ResultType.FinancialDataLawyer => "FinancialDataLawyer"
    case ResultType.FinancialDataTradeAssociation => "FinancialDataTradeAssociation"
}
