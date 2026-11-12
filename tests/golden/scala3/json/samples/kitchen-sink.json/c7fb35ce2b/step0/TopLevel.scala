package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val booleanValue : Boolean,
    val dateValue : String,
    val differentThings : Seq[DifferentThingElement],
    val doubleValue : Double,
    val intValue : Long,
    val mapValue : Map[String, Option[Long]],
    val `name with spaces` : Option[Json] = None,
    val nullValue : Option[Json] = None,
    val nullableMapValue : Map[String, Option[Long]],
    val people : Seq[PersonElement],
    val person : PurplePerson,
    val stringValue : String,
    val tuples : Seq[Seq[IntOrString]],
    val uuidValue : String
) derives Encoder.AsObject, Decoder

type DifferentThingElement = DifferentThingClass | Long | String
given Decoder[DifferentThingElement] = {
    List[Decoder[DifferentThingElement]](
        Decoder[String].widen,
        Decoder[Long].widen,
        Decoder[DifferentThingClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[DifferentThingElement] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Long => Encoder.encodeLong(enc1)
    case enc2 : DifferentThingClass => Encoder.AsObject[DifferentThingClass].apply(enc2)
}

case class DifferentThingClass (
    val name : String
) derives Encoder.AsObject, Decoder

case class PersonElement (
    val intOrString : IntOrString,
    val name : String,
    val optionalValue : Option[Boolean] = None
) derives Encoder.AsObject, Decoder

type IntOrString = Long | String
given Decoder[IntOrString] = {
    List[Decoder[IntOrString]](
        Decoder[String].widen,
        Decoder[Long].widen,
    ).reduceLeft(_ or _)
}

given Encoder[IntOrString] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Long => Encoder.encodeLong(enc1)
}

case class PurplePerson (
    val intOrString : Long,
    val name : String
) derives Encoder.AsObject, Decoder
