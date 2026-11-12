// To parse the JSON, install Klaxon and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import java.time.LocalDate

import com.beust.klaxon.*

private fun <T> Klaxon.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonValue) -> T, toJson: (T) -> String, isUnion: Boolean = false) =
    this.converter(object: Converter {
        @Suppress("UNCHECKED_CAST")
        override fun toJson(value: Any)        = toJson(value as T)
        override fun fromJson(jv: JsonValue)   = fromJson(jv) as Any
        override fun canConvert(cls: Class<*>) = cls == k.java || (isUnion && cls.superclass == k.java)
    })

private val klaxon = Klaxon()
    .convert(LocalDate::class,          { LocalDate.parse(it.string!!) },    { "\"${java.time.format.DateTimeFormatter.ISO_LOCAL_DATE.format(it)}\"" })
    .convert(BornEnum::class,           { BornEnum.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(Gender::class,             { Gender.fromValue(it.string!!) },   { Klaxon().toJsonString(it.value) })
    .convert(Category::class,           { Category.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(BornUnion::class,          { BornUnion.fromJson(it) },          { it.toJson() }, true)
    .convert(AffiliationElement::class, { AffiliationElement.fromJson(it) }, { it.toJson() }, true)

data class TopLevel (
    val laureates: List<Laureate>
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class Laureate (
    val born: BornUnion,
    val bornCity: String? = null,
    val bornCountry: String? = null,
    val bornCountryCode: String? = null,
    val died: BornUnion,
    val diedCity: String? = null,
    val diedCountry: String? = null,
    val diedCountryCode: String? = null,
    val firstname: String? = null,
    val gender: Gender,
    val id: String,
    val prizes: List<Prize>,
    val surname: String? = null
)

sealed class BornUnion {
    class DateValue(val value: LocalDate) : BornUnion()
    class EnumValue(val value: BornEnum)  : BornUnion()

    public fun toJson(): String = klaxon.toJsonString(when (this) {
        is DateValue -> this.value
        is EnumValue -> this.value
    })

    companion object {
        public fun fromJson(jv: JsonValue): BornUnion = when (jv.inside) {
            is String -> try { DateValue(jv.string?.let { LocalDate.parse(it) }!!) } catch (e: Exception) { EnumValue(jv.string?.let { BornEnum.fromValue(it) }!!) }
            else      -> throw IllegalArgumentException()
        }
    }
}

enum class BornEnum(val value: String) {
    The00000000("0000-00-00"),
    The18980000("1898-00-00"),
    The19430000("1943-00-00");

    companion object {
        public fun fromValue(value: String): BornEnum = when (value) {
            "0000-00-00" -> The00000000
            "1898-00-00" -> The18980000
            "1943-00-00" -> The19430000
            else         -> throw IllegalArgumentException()
        }
    }
}

enum class Gender(val value: String) {
    Male("male"),
    Female("female"),
    Org("org");

    companion object {
        public fun fromValue(value: String): Gender = when (value) {
            "male"   -> Male
            "female" -> Female
            "org"    -> Org
            else     -> throw IllegalArgumentException()
        }
    }
}

data class Prize (
    val affiliations: List<AffiliationElement>,
    val category: Category? = null,
    val motivation: String? = null,
    val overallMotivation: String? = null,
    val share: String? = null,
    val year: String? = null
)

sealed class AffiliationElement {
    class AffiliationClassValue(val value: AffiliationClass) : AffiliationElement()
    class AnythingArrayValue(val value: List<Any?>)          : AffiliationElement()

    public fun toJson(): String = klaxon.toJsonString(when (this) {
        is AffiliationClassValue -> this.value
        is AnythingArrayValue    -> this.value
    })

    companion object {
        public fun fromJson(jv: JsonValue): AffiliationElement = when (jv.inside) {
            is JsonObject   -> AffiliationClassValue(jv.obj?.let { klaxon.parseFromJsonObject<AffiliationClass>(it) }!!)
            is JsonArray<*> -> AnythingArrayValue(jv.array?.let { klaxon.parseFromJsonArray<Any?>(it) }!!)
            else            -> throw IllegalArgumentException()
        }
    }
}

data class AffiliationClass (
    val city: String? = null,
    val country: String? = null,
    val name: String? = null
)

enum class Category(val value: String) {
    Physics("physics"),
    Chemistry("chemistry"),
    Peace("peace"),
    Medicine("medicine"),
    Literature("literature"),
    Economics("economics");

    companion object {
        public fun fromValue(value: String): Category = when (value) {
            "physics"    -> Physics
            "chemistry"  -> Chemistry
            "peace"      -> Peace
            "medicine"   -> Medicine
            "literature" -> Literature
            "economics"  -> Economics
            else         -> throw IllegalArgumentException()
        }
    }
}
