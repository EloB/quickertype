// To parse the JSON, install kotlin's serialization plugin and do:
//
// val json     = Json { allowStructuredMapKeys = true }
// val topLevel = json.parse(TopLevel.serializer(), jsonString)

package quicktype

import kotlinx.serialization.*
import kotlinx.serialization.json.*
import kotlinx.serialization.descriptors.*
import kotlinx.serialization.encoding.*

@Serializable
data class TopLevel (
    val category: Category,
    val details: Details,
    val match: String,
    val page: Long,
    val product: List<ProductElement>,
    val schk: Boolean,
    val totallooseoffers: Long,
    val totalpages: Long,
    val totalresultsavailable: Long,
    val totalresultsreturned: Long
)

@Serializable
data class Category (
    val concatenatecategoryname: Boolean,
    val hasoffer: Boolean,
    val id: Long,
    val isfinal: Boolean,
    val links: List<LinkElement>,
    val name: String,
    val parentcategoryid: Long,
    val thumbnail: CategoryThumbnail
)

@Serializable
data class LinkElement (
    val link: LinkLink
)

@Serializable
data class LinkLink (
    val type: String,
    val url: String
)

@Serializable
data class CategoryThumbnail (
    val url: String
)

@Serializable
data class Details (
    val applicationid: String,
    val applicationversion: String,
    val code: Long,
    val date: Date,
    val elapsedtime: Long,
    val message: String,
    val status: String
)

@Serializable
data class Date (
    val day: Long,
    val eonandyear: Eonandyear,
    val hour: Long,
    val millisecond: Long,
    val minute: Long,
    val month: Long,
    val second: Long,
    val timezone: Long,
    val valid: Boolean,
    val xmlschematype: Xmlschematype,
    val year: Long
)

@Serializable
data class Eonandyear (
    val lowestsetbit: Long
)

@Serializable
data class Xmlschematype (
    val localpart: String,
    val namespaceuri: String,
    val prefix: String
)

@Serializable
data class ProductElement (
    val product: ProductProduct
)

@Serializable
data class ProductProduct (
    val categoryid: Long,
    val currency: Currency,
    val eco: Boolean,
    val fulldescription: Boolean,
    val hasmetasearch: Boolean,
    val id: Long,
    val links: List<LinkElement>,
    val numoffers: Long,
    val pricemax: String,
    val pricemin: String,
    val productname: String,
    val quantity: Long,
    val rating: Rating,
    val specification: Specification,
    val thumbnail: FormatsClass,
    val totalsellers: Long
)

@Serializable
data class Currency (
    val abbreviation: String
)

@Serializable
data class Rating (
    val useraveragerating: Useraveragerating
)

@Serializable
data class Useraveragerating (
    val links: List<LinkElement>,
    val numcomments: Long,
    val rating: String
)

@Serializable
data class Specification (
    val links: List<LinkElement>
)

@Serializable
data class Format (
    val formats: FormatsClass
)

@Serializable
data class FormatsClass (
    val formats: List<Format>? = null,
    val height: Long,
    val url: String,
    val width: Long
)
