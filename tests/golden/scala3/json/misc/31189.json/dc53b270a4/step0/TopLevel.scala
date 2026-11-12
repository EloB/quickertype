package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val details : String,
    val rates : Seq[Rate],
    val version : Option[Json] = None
) derives Encoder.AsObject, Decoder

case class Rate (
    val code : String,
    val country_code : String,
    val name : String,
    val periods : Seq[Period]
) derives Encoder.AsObject, Decoder

case class Period (
    val effective_from : String,
    val rates : Rates
) derives Encoder.AsObject, Decoder

case class Rates (
    val parking : Option[Double] = None,
    val reduced : Option[Double] = None,
    val reduced1 : Option[Double] = None,
    val reduced2 : Option[Double] = None,
    val standard : Double,
    val super_reduced : Option[Double] = None
) derives Encoder.AsObject, Decoder
