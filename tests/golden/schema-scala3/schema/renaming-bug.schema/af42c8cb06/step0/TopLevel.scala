package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val version : Option[String] = None,
    val fruits : Option[Seq[Fruit]] = None,
    val vehicles : Option[Seq[Vehicle]] = None
) derives Encoder.AsObject, Decoder

case class Fruit (
    val apple : Option[Boolean] = None,
    val berries : Option[Seq[Berry]] = None,
    val orange : Option[Boolean] = None
) derives Encoder.AsObject, Decoder

case class Berry (
    val color : Option[Color] = None,
    val name : Option[String] = None,
    val shapes : Option[Seq[Shape]] = None
) derives Encoder.AsObject, Decoder

case class Color (
    val rgb : Option[Double] = None
) derives Encoder.AsObject, Decoder

case class Shape (
    val geometry : Option[Geometry] = None,
    val history : Option[History] = None
) derives Encoder.AsObject, Decoder

case class Geometry (
    val rectShape : Option[RectShape] = None,
    val circularShape : Option[Seq[CircularShape]] = None
) derives Encoder.AsObject, Decoder

case class CircularShape (
    val shapeName : Option[String] = None
) derives Encoder.AsObject, Decoder

case class RectShape (
    val parts : Option[Seq[Part]] = None
) derives Encoder.AsObject, Decoder

case class Part (
    val depth : Option[String] = None,
    val length : Option[String] = None,
    val width : Option[String] = None
) derives Encoder.AsObject, Decoder

case class History (
    val `class` : Option[String] = None
) derives Encoder.AsObject, Decoder

case class Vehicle (
    val brand : Option[String] = None,
    val id : Option[String] = None,
    val speed : Option[Speed] = None,
    val subModule : Option[Boolean] = None,
    val `type` : Option[VehicleType] = None,
    val year : Option[String] = None
) derives Encoder.AsObject, Decoder

case class Speed (
    val velocity : Option[Limit] = None
) derives Encoder.AsObject, Decoder

case class Limit (
    val maximum : Option[Double] = None,
    val minimum : Option[Double] = None
) derives Encoder.AsObject, Decoder

case class VehicleType (
    val name : Option[Name] = None,
    val width : Option[Axis] = None,
    val length : Option[Axis] = None
) derives Encoder.AsObject, Decoder

enum Axis : 
    case X
    case Y
    case Z
    case Xy
    case Yz
    case Zx

given Decoder[Axis] = Decoder.decodeString.emap {
    case "X" => scala.Right(Axis.X)
    case "Y" => scala.Right(Axis.Y)
    case "Z" => scala.Right(Axis.Z)
    case "XY" => scala.Right(Axis.Xy)
    case "YZ" => scala.Right(Axis.Yz)
    case "ZX" => scala.Right(Axis.Zx)
    case other => scala.Left("invalid Axis: " + other)
}
given Encoder[Axis] = Encoder.encodeString.contramap {
    case Axis.X => "X"
    case Axis.Y => "Y"
    case Axis.Z => "Z"
    case Axis.Xy => "XY"
    case Axis.Yz => "YZ"
    case Axis.Zx => "ZX"
}

enum Name : 
    case Truck
    case Bus
    case Car
    case Van
    case Train
    case Bike
    case Aeroplane
    case Jeep
    case Trolley

given Decoder[Name] = Decoder.decodeString.emap {
    case "truck" => scala.Right(Name.Truck)
    case "bus" => scala.Right(Name.Bus)
    case "car" => scala.Right(Name.Car)
    case "van" => scala.Right(Name.Van)
    case "train" => scala.Right(Name.Train)
    case "Bike" => scala.Right(Name.Bike)
    case "Aeroplane" => scala.Right(Name.Aeroplane)
    case "Jeep" => scala.Right(Name.Jeep)
    case "Trolley" => scala.Right(Name.Trolley)
    case other => scala.Left("invalid Name: " + other)
}
given Encoder[Name] = Encoder.encodeString.contramap {
    case Name.Truck => "truck"
    case Name.Bus => "bus"
    case Name.Car => "car"
    case Name.Van => "van"
    case Name.Train => "train"
    case Name.Bike => "Bike"
    case Name.Aeroplane => "Aeroplane"
    case Name.Jeep => "Jeep"
    case Name.Trolley => "Trolley"
}
