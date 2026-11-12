// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import java.time.OffsetDateTime

import com.beust.klaxon.*

private fun <T> Klaxon.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonValue) -> T, toJson: (T) -> String, isUnion: Boolean = false) =
    this.converter(object: Converter {
        @Suppress("UNCHECKED_CAST")
        override fun toJson(value: Any)        = toJson(value as T)
        override fun fromJson(jv: JsonValue)   = fromJson(jv) as Any
        override fun canConvert(cls: Class<*>) = cls == k.java || (isUnion && cls.superclass == k.java)
    })

private val klaxon = Klaxon()
    .convert(OffsetDateTime::class, { OffsetDateTime.parse(it.string!!) }, { "\"${java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME.format(it)}\"" })

class TopLevel(elements: Collection<TopLevelElement>) : ArrayList<TopLevelElement>(elements) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = TopLevel(klaxon.parseArray<TopLevelElement>(json)!!)
    }
}

data class TopLevelElement (
    @Json(name = "BirthDate")
    val birthDate: OffsetDateTime? = null,

    @Json(name = "BirthDateIsProtected")
    val birthDateIsProtected: Boolean,

    @Json(name = "GenderTypeID")
    val genderTypeID: Long,

    @Json(name = "Notes")
    val notes: String,

    @Json(name = "ParliamentaryName")
    val parliamentaryName: String,

    @Json(name = "PersonID")
    val personID: Long,

    @Json(name = "PhotoURL")
    val photoURL: String,

    @Json(name = "PreferredName")
    val preferredName: String
)
