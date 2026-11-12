package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val category : Category,
    val details : Details,
    val page : Long,
    val product : Seq[ProductElement],
    val schk : Boolean,
    val `match` : String,
    val totallooseoffers : Long,
    val totalpages : Long,
    val totalresultsavailable : Long,
    val totalresultsreturned : Long
) derives Encoder.AsObject, Decoder

case class Category (
    val concatenatecategoryname : Boolean,
    val hasoffer : Boolean,
    val id : Long,
    val isfinal : Boolean,
    val links : Seq[LinkElement],
    val name : String,
    val parentcategoryid : Long,
    val thumbnail : CategoryThumbnail
) derives Encoder.AsObject, Decoder

case class LinkElement (
    val link : LinkLink
) derives Encoder.AsObject, Decoder

case class LinkLink (
    val `type` : String,
    val url : String
) derives Encoder.AsObject, Decoder

case class CategoryThumbnail (
    val url : String
) derives Encoder.AsObject, Decoder

case class Details (
    val applicationid : String,
    val applicationversion : String,
    val code : Long,
    val date : Date,
    val elapsedtime : Long,
    val message : String,
    val status : String
) derives Encoder.AsObject, Decoder

case class Date (
    val day : Long,
    val eonandyear : Eonandyear,
    val hour : Long,
    val millisecond : Long,
    val minute : Long,
    val month : Long,
    val second : Long,
    val timezone : Long,
    val valid : Boolean,
    val xmlschematype : Xmlschematype,
    val year : Long
) derives Encoder.AsObject, Decoder

case class Eonandyear (
    val lowestsetbit : Long
) derives Encoder.AsObject, Decoder

case class Xmlschematype (
    val localpart : String,
    val namespaceuri : String,
    val prefix : String
) derives Encoder.AsObject, Decoder

case class ProductElement (
    val product : ProductProduct
) derives Encoder.AsObject, Decoder

case class ProductProduct (
    val categoryid : Long,
    val currency : Currency,
    val eco : Boolean,
    val fulldescription : Boolean,
    val hasmetasearch : Boolean,
    val id : Long,
    val links : Seq[LinkElement],
    val numoffers : Long,
    val pricemax : String,
    val pricemin : String,
    val productname : String,
    val quantity : Long,
    val rating : Rating,
    val specification : Specification,
    val thumbnail : FormatsClass,
    val totalsellers : Long
) derives Encoder.AsObject, Decoder

case class Currency (
    val abbreviation : String
) derives Encoder.AsObject, Decoder

case class Rating (
    val useraveragerating : Useraveragerating
) derives Encoder.AsObject, Decoder

case class Useraveragerating (
    val links : Seq[LinkElement],
    val numcomments : Long,
    val rating : String
) derives Encoder.AsObject, Decoder

case class Specification (
    val links : Seq[LinkElement]
) derives Encoder.AsObject, Decoder

case class Format (
    val formats : FormatsClass
) derives Encoder.AsObject, Decoder

case class FormatsClass (
    val formats : Option[Seq[Format]] = None,
    val height : Long,
    val url : String,
    val width : Long
) derives Encoder.AsObject, Decoder
