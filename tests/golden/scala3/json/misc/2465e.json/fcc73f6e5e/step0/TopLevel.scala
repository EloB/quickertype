package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val basePath : String,
    val definitions : Definitions,
    val host : String,
    val info : Info,
    val paths : Paths,
    val produces : Seq[String],
    val schemes : Seq[String],
    val swagger : String
) derives Encoder.AsObject, Decoder

case class Definitions (
    val Taxonomy : Taxonomy
) derives Encoder.AsObject, Decoder

case class Taxonomy (
    val properties : Properties
) derives Encoder.AsObject, Decoder

case class Properties (
    val annotations : Annotations,
    val datatype_properties : Annotations,
    val id : Annotations,
    val label : Annotations,
    val `type` : Annotations,
    val sub_class_of : Annotations
) derives Encoder.AsObject, Decoder

case class Annotations (
    val `type` : String,
    val description : String
) derives Encoder.AsObject, Decoder

case class Info (
    val description : String,
    val title : String,
    val version : String
) derives Encoder.AsObject, Decoder

case class Paths (
    val `/ita_taxonomies/search` : ItaTaxonomiesSearch
) derives Encoder.AsObject, Decoder

case class ItaTaxonomiesSearch (
    val get : Get
) derives Encoder.AsObject, Decoder

case class Get (
    val description : String,
    val parameters : Seq[Parameter],
    val responses : Responses,
    val summary : String,
    val tags : Seq[String]
) derives Encoder.AsObject, Decoder

case class Parameter (
    val description : String,
    val format : String,
    val in : String,
    val name : String,
    val `type` : String,
    val required : Boolean
) derives Encoder.AsObject, Decoder

case class Responses (
    val `200` : The200
) derives Encoder.AsObject, Decoder

case class The200 (
    val description : String,
    val schema : Schema
) derives Encoder.AsObject, Decoder

case class Schema (
    val `$ref` : String
) derives Encoder.AsObject, Decoder
