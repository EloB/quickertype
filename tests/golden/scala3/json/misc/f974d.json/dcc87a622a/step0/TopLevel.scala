package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val block_index : Long,
    val hash : String,
    val height : Long,
    val time : Long,
    val txIndexes : Seq[Long]
) derives Encoder.AsObject, Decoder
