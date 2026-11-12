package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val anEasyOne : Long,
    val isMNISTLetter : Boolean,
    val JSONString : String,
    val PrettyEasyToo : Boolean,
    val should_know_that_id_is_an_initialism : String,
    val `   spaces are separators  too  ` : Boolean,
    val ZSR_HH_DEMO3_DELMATNR : Boolean
) derives Encoder.AsObject, Decoder
