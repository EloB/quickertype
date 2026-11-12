package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val city : String,
    val delay : String,
    val IATA : String,
    val ICAO : String,
    val name : String,
    val state : String,
    val status : Status,
    val weather : Weather
) derives Encoder.AsObject, Decoder

case class Status (
    val avgDelay : String,
    val closureBegin : String,
    val closureEnd : String,
    val endTime : String,
    val maxDelay : String,
    val minDelay : String,
    val reason : String,
    val `type` : String,
    val trend : String
) derives Encoder.AsObject, Decoder

case class Weather (
    val meta : Meta,
    val temp : String,
    val visibility : Double,
    val weather : String,
    val wind : String
) derives Encoder.AsObject, Decoder

case class Meta (
    val credit : String,
    val updated : String,
    val url : String
) derives Encoder.AsObject, Decoder
