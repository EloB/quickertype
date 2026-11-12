package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val bla : TopLevelBla,
    val empty : Empty,
    val foo : Foo,
    val thisIsAToughOne : ThisIsAToughOne,
    val `!` : Long,
    val Empty : EmptyClass
)

object TopLevel:
    given io.circe.derivation.Configuration =
        io.circe.derivation.Configuration.default.withTransformMemberNames(
            io.circe.derivation.renaming.replaceWith(
                "empty" -> "",
                "thisIsAToughOne" -> "ThisIsA\ud83d\ude1cTough\"\n\nOne"
            )
        )
    given io.circe.Codec.AsObject[TopLevel] = io.circe.derivation.ConfiguredCodec.derived

case class TopLevelBla (
    val bar : Long
) derives Encoder.AsObject, Decoder

case class Empty (
    val x : Long
) derives Encoder.AsObject, Decoder

case class Foo (
    val bla : FooBla,
    val empty : Long,
    val `__` : Long
)

object Foo:
    given io.circe.derivation.Configuration =
        io.circe.derivation.Configuration.default.withTransformMemberNames(
            io.circe.derivation.renaming.replaceWith(
                "empty" -> "_"
            )
        )
    given io.circe.Codec.AsObject[Foo] = io.circe.derivation.ConfiguredCodec.derived

case class FooBla()  derives Encoder.AsObject, Decoder

case class ThisIsAToughOne (
    val empty : Long,
    val `"` : Long
)

object ThisIsAToughOne:
    given io.circe.derivation.Configuration =
        io.circe.derivation.Configuration.default.withTransformMemberNames(
            io.circe.derivation.renaming.replaceWith(
                "empty" -> "\n\n\n"
            )
        )
    given io.circe.Codec.AsObject[ThisIsAToughOne] = io.circe.derivation.ConfiguredCodec.derived

case class EmptyClass (
    val y : Long
) derives Encoder.AsObject, Decoder
