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
    .convert(Scheme::class, { Scheme.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })

class TopLevel(elements: Collection<TopLevelElement>) : ArrayList<TopLevelElement>(elements) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = TopLevel(klaxon.parseArray<TopLevelElement>(json)!!)
    }
}

data class TopLevelElement (
    val id: String,
    val identifiers: List<Identifier>,
    val keywords: List<String>,
    val links: List<Link>,
    val name: String,

    @Json(name = "other_names")
    val otherNames: List<OtherName>,

    @Json(name = "superseded_by")
    val supersededBy: Any? = null,

    val text: List<Text>
)

data class Identifier (
    val identifier: String,
    val scheme: Scheme
)

enum class Scheme(val value: String) {
    Dep5("DEP5"),
    Spdx("SPDX"),
    Trove("Trove");

    companion object {
        public fun fromValue(value: String): Scheme = when (value) {
            "DEP5"  -> Dep5
            "SPDX"  -> Spdx
            "Trove" -> Trove
            else    -> throw IllegalArgumentException()
        }
    }
}

data class Link (
    val note: String,
    val url: String
)

data class OtherName (
    val name: String,
    val note: String? = null
)

data class Text (
    @Json(name = "media_type")
    val mediaType: String,

    val title: String,
    val url: String
)
