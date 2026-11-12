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
    .convert(JsonObject::class, { it.obj!! }, { it.toJsonString() })

data class TopLevel (
    val count: Long,
    val facets: Facets,
    val limit: Long,
    val next: String,
    val offset: Long,
    val previous: Boolean,
    val results: List<Result>
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

typealias Facets = JsonObject

data class Result (
    val acronym: String? = null,

    @Json(name = "created_at")
    val createdAt: String,

    val id: String,
    val name: String,

    @Json(name = "updated_at")
    val updatedAt: String,

    val uri: String
)
