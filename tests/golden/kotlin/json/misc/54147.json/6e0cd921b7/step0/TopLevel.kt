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
    val args: Args,
    val data: String,
    val files: Args,
    val form: Args,
    val headers: Headers,
    val origin: String,
    val url: String
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

typealias Args = JsonObject

data class Headers (
    @Json(name = "Accept-Encoding")
    val acceptEncoding: String,

    @Json(name = "Connection")
    val connection: String,

    @Json(name = "Host")
    val host: String,

    @Json(name = "User-Agent")
    val userAgent: String
)
