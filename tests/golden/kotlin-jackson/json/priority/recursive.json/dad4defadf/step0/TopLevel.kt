// To parse the JSON, install jackson-module-kotlin and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.fasterxml.jackson.annotation.*
import com.fasterxml.jackson.core.*
import com.fasterxml.jackson.databind.*
import com.fasterxml.jackson.databind.deser.std.StdDeserializer
import com.fasterxml.jackson.databind.module.SimpleModule
import com.fasterxml.jackson.databind.node.*
import com.fasterxml.jackson.databind.ser.std.StdSerializer
import com.fasterxml.jackson.module.kotlin.*

val mapper = jacksonObjectMapper().apply {
    propertyNamingStrategy = object : PropertyNamingStrategy.PropertyNamingStrategyBase() { override fun translate(name: String) = if (name == "empty") "" else name }
    setSerializationInclusion(JsonInclude.Include.NON_NULL)
    disable(DeserializationFeature.ACCEPT_FLOAT_AS_INT)
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val category: Category,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val details: Details,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val match: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val page: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val product: List<ProductElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val schk: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val totallooseoffers: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val totalpages: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val totalresultsavailable: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val totalresultsreturned: Long
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class Category (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val concatenatecategoryname: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val hasoffer: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty("isfinal", required=true)@field:JsonProperty("isfinal", required=true)
    val isfinal: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val links: List<LinkElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val parentcategoryid: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val thumbnail: CategoryThumbnail
)

data class LinkElement (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val link: LinkLink
)

data class LinkLink (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String
)

data class CategoryThumbnail (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String
)

data class Details (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val applicationid: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val applicationversion: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val code: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val date: Date,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val elapsedtime: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val message: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val status: String
)

data class Date (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val day: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val eonandyear: Eonandyear,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val hour: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val millisecond: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val minute: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val month: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val second: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val timezone: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val valid: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val xmlschematype: Xmlschematype,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val year: Long
)

data class Eonandyear (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val lowestsetbit: Long
)

data class Xmlschematype (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val localpart: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val namespaceuri: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val prefix: String
)

data class ProductElement (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val product: ProductProduct
)

data class ProductProduct (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val categoryid: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val currency: Currency,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val eco: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val fulldescription: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val hasmetasearch: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val links: List<LinkElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val numoffers: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pricemax: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pricemin: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val productname: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val quantity: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rating: Rating,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val specification: Specification,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val thumbnail: FormatsClass,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val totalsellers: Long
)

data class Currency (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val abbreviation: String
)

data class Rating (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val useraveragerating: Useraveragerating
)

data class Useraveragerating (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val links: List<LinkElement>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val numcomments: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rating: String
)

data class Specification (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val links: List<LinkElement>
)

data class Format (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val formats: FormatsClass
)

data class FormatsClass (
    val formats: List<Format>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val height: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val url: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val width: Long
)
