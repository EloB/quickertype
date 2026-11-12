package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val txs : Seq[Tx]
) derives Encoder.AsObject, Decoder

case class Tx (
    val double_spend : Boolean,
    val hash : String,
    val inputs : Seq[Input],
    val lock_time : Long,
    val out : Seq[Out],
    val relayed_by : String,
    val size : Long,
    val time : Long,
    val tx_index : Long,
    val ver : Long,
    val vin_sz : Long,
    val vout_sz : Long
) derives Encoder.AsObject, Decoder

case class Input (
    val prev_out : Out,
    val script : String,
    val sequence : Long
) derives Encoder.AsObject, Decoder

case class Out (
    val addr : String,
    val n : Long,
    val `type` : Long,
    val script : String,
    val spent : Boolean,
    val tx_index : Long,
    val value : Long
) derives Encoder.AsObject, Decoder
