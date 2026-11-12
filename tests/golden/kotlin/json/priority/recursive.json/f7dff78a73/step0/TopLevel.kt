// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

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
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

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

data class LinkElement (
    val link: LinkLink
)

data class LinkLink (
    val type: String,
    val url: String
)

data class CategoryThumbnail (
    val url: String
)

data class Details (
    val applicationid: String,
    val applicationversion: String,
    val code: Long,
    val date: Date,
    val elapsedtime: Long,
    val message: String,
    val status: String
)

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

data class Eonandyear (
    val lowestsetbit: Long
)

data class Xmlschematype (
    val localpart: String,
    val namespaceuri: String,
    val prefix: String
)

data class ProductElement (
    val product: ProductProduct
)

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

data class Currency (
    val abbreviation: String
)

data class Rating (
    val useraveragerating: Useraveragerating
)

data class Useraveragerating (
    val links: List<LinkElement>,
    val numcomments: Long,
    val rating: String
)

data class Specification (
    val links: List<LinkElement>
)

data class Format (
    val formats: FormatsClass
)

data class FormatsClass (
    val formats: List<Format>? = null,
    val height: Long,
    val url: String,
    val width: Long
)
