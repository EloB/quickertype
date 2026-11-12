package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

type TopLevel = Map[String, Option[Json]] | Boolean | Double | Long | String | Seq[TopLevelElement] | NullValue
given Decoder[TopLevel] = {
    List[Decoder[TopLevel]](
        Decoder[String].widen,
        Decoder[Boolean].widen,
        Decoder[Long].widen,
        Decoder[Double].widen,
        Decoder[Seq[TopLevelElement]].widen,
        Decoder[Map[String, Option[Json]]].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[TopLevel] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Boolean => Encoder.encodeBoolean(enc1)
    case enc2 : Long => Encoder.encodeLong(enc2)
    case enc3 : Double => Encoder.encodeDouble(enc3)
    case enc4 : Seq[TopLevelElement] => Encoder.encodeSeq[TopLevelElement].apply(enc4)
    case enc5 : Map[String, Option[Json]] => Encoder.encodeMap[String,Option[Json]].apply(enc5)
    case enc6 : NullValue => Encoder.encodeNone(enc6)
}

type TopLevelElement = Seq[Option[Json]] | Boolean | Double | Long | String | TopLevelClass | NullValue
given Decoder[TopLevelElement] = {
    List[Decoder[TopLevelElement]](
        Decoder[String].widen,
        Decoder[Boolean].widen,
        Decoder[Long].widen,
        Decoder[Double].widen,
        Decoder[Seq[Option[Json]]].widen,
        Decoder[TopLevelClass].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[TopLevelElement] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Boolean => Encoder.encodeBoolean(enc1)
    case enc2 : Long => Encoder.encodeLong(enc2)
    case enc3 : Double => Encoder.encodeDouble(enc3)
    case enc4 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc4)
    case enc5 : TopLevelClass => Encoder.AsObject[TopLevelClass].apply(enc5)
    case enc6 : NullValue => Encoder.encodeNone(enc6)
}

case class TopLevelClass (
    val x : Option[X] = None
) derives Encoder.AsObject, Decoder

case class XClass (
    val x : Option[X] = None
) derives Encoder.AsObject, Decoder

type XElement = Seq[Option[Json]] | Boolean | Double | Long | String | XClass | NullValue
given Decoder[XElement] = {
    List[Decoder[XElement]](
        Decoder[String].widen,
        Decoder[Boolean].widen,
        Decoder[Long].widen,
        Decoder[Double].widen,
        Decoder[Seq[Option[Json]]].widen,
        Decoder[XClass].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[XElement] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Boolean => Encoder.encodeBoolean(enc1)
    case enc2 : Long => Encoder.encodeLong(enc2)
    case enc3 : Double => Encoder.encodeDouble(enc3)
    case enc4 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc4)
    case enc5 : XClass => Encoder.AsObject[XClass].apply(enc5)
    case enc6 : NullValue => Encoder.encodeNone(enc6)
}

type X = Map[String, Option[Json]] | Boolean | Double | Long | String | Seq[XElement] | NullValue
given Decoder[X] = {
    List[Decoder[X]](
        Decoder[String].widen,
        Decoder[Boolean].widen,
        Decoder[Long].widen,
        Decoder[Double].widen,
        Decoder[Seq[XElement]].widen,
        Decoder[Map[String, Option[Json]]].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[X] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Boolean => Encoder.encodeBoolean(enc1)
    case enc2 : Long => Encoder.encodeLong(enc2)
    case enc3 : Double => Encoder.encodeDouble(enc3)
    case enc4 : Seq[XElement] => Encoder.encodeSeq[XElement].apply(enc4)
    case enc5 : Map[String, Option[Json]] => Encoder.encodeMap[String,Option[Json]].apply(enc5)
    case enc6 : NullValue => Encoder.encodeNone(enc6)
}
