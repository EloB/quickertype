package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val continue : String,
    val empty : String,
    val `x'` : String,
    val `{}` : String,
    val `null` : String,
    val `x"` : String,
    val undefined : String,
    val x : String,
    val `x y` : String
)

object TopLevel:
    given io.circe.derivation.Configuration =
        io.circe.derivation.Configuration.default.withTransformMemberNames(
            io.circe.derivation.renaming.replaceWith(
                "empty" -> ""
            )
        )
    given io.circe.Codec.AsObject[TopLevel] = io.circe.derivation.ConfiguredCodec.derived
