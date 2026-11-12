package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val children_data : Seq[TopLevel],
    val id : Long,
    val is_active : Boolean,
    val level : Long,
    val name : String,
    val parent_id : Long,
    val position : Long,
    val product_count : Long
) derives Encoder.AsObject, Decoder
