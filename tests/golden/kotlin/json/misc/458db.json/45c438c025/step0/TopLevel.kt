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
    .convert(Name::class, { Name.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })

data class TopLevel (
    val metadata: Metadata,
    val results: List<Result>
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class Metadata (
    val executionTime: Double,
    val responseInfo: ResponseInfo,
    val resultset: Resultset
)

data class ResponseInfo (
    val developerMessage: String,
    val status: Long
)

data class Resultset (
    val count: Long,
    val page: Long,
    val pagesize: Long
)

data class Result (
    val attachments: List<Any?>,
    val body: String,
    val changed: String,
    val component: List<Component>,
    val created: String,
    val date: String,
    val image: List<Any?>,
    val teaser: List<Any?>,
    val title: String,
    val topic: List<Any?>,
    val url: String,
    val uuid: String,
    val vuuid: String
)

data class Component (
    val name: Name,
    val uuid: String
)

enum class Name(val value: String) {
    OfficeOnViolenceAgainstWomen("Office on Violence Against Women");

    companion object {
        public fun fromValue(value: String): Name = when (value) {
            "Office on Violence Against Women" -> OfficeOnViolenceAgainstWomen
            else                               -> throw IllegalArgumentException()
        }
    }
}
