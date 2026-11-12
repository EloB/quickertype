package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val git : Seq[String],
    val github_services_sha : String,
    val hooks : Seq[String],
    val importer : Seq[String],
    val pages : Seq[String],
    val verifiable_password_authentication : Boolean
) derives Encoder.AsObject, Decoder
