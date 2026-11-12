// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private fun <T> Klaxon.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonValue) -> T, toJson: (T) -> String, isUnion: Boolean = false) =
    this.converter(object: Converter {
        @Suppress("UNCHECKED_CAST")
        override fun toJson(value: Any)        = toJson(value as T)
        override fun fromJson(jv: JsonValue)   = fromJson(jv) as Any
        override fun canConvert(cls: Class<*>) = cls == k.java || (isUnion && cls.superclass == k.java)
    })

private val klaxon = Klaxon()
    .convert(Type::class, { Type.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })

data class TopLevel (
    val basePath: String,
    val definitions: Definitions,
    val host: String,
    val info: Info,
    val paths: Paths,
    val produces: List<String>,
    val schemes: List<String>,
    val swagger: String
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class Definitions (
    @Json(name = "Report")
    val report: Report
)

data class Report (
    val properties: Properties
)

data class Properties (
    @Json(name = "click_url")
    val clickURL: ClickURL,

    val country: ClickURL,
    val description: ClickURL,

    @Json(name = "expiration_date")
    val expirationDate: ClickURL,

    val id: ClickURL,
    val industry: ClickURL,

    @Json(name = "report_type")
    val reportType: ClickURL,

    @Json(name = "source_industry")
    val sourceIndustry: ClickURL,

    val title: ClickURL,
    val url: ClickURL
)

data class ClickURL (
    val description: String,
    val type: Type
)

enum class Type(val value: String) {
    TypeString("string");

    companion object {
        public fun fromValue(value: String): Type = when (value) {
            "string" -> TypeString
            else     -> throw IllegalArgumentException()
        }
    }
}

data class Info (
    val description: String,
    val title: String,
    val version: String
)

data class Paths (
    @Json(name = "/market_research_library/search")
    val marketResearchLibrarySearch: MarketResearchLibrarySearch
)

data class MarketResearchLibrarySearch (
    val get: Get
)

data class Get (
    val description: String,
    val parameters: List<Parameter>,
    val responses: Responses,
    val summary: String,
    val tags: List<String>
)

data class Parameter (
    val description: String,
    val format: Type,
    val name: String,

    @Json(name = "in")
    val parameterIn: String,

    val required: Boolean,
    val type: Type
)

data class Responses (
    @Json(name = "200")
    val the200: The200
)

data class The200 (
    val description: String,
    val schema: Schema
)

data class Schema (
    val items: Items,
    val type: String
)

data class Items (
    @Json(name = "\$ref")
    val ref: String
)
