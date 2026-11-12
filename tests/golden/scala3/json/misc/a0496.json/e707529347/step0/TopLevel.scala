package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val code : String,
    val column_names : Seq[String],
    val data : Seq[Seq[Datum]],
    val description : String,
    val display_url : String,
    val errors : Errors,
    val frequency : String,
    val from_date : String,
    val id : Long,
    val name : String,
    val premium : Boolean,
    val source_code : String,
    val source_name : String,
    val to_date : String,
    val `type` : String,
    val updated_at : java.time.Instant,
    val urlize_name : String
) derives Encoder.AsObject, Decoder

type Datum = Double | String | NullValue
given Decoder[Datum] = {
    List[Decoder[Datum]](
        Decoder[String].widen,
        Decoder[Double].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Datum] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Double => Encoder.encodeDouble(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

case class Errors()  derives Encoder.AsObject, Decoder
