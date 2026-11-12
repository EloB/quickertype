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
    .convert(LocalDate::class,         { LocalDate.parse(it.string!!) },             { "\"${java.time.format.DateTimeFormatter.ISO_LOCAL_DATE.format(it)}\"" })
    .convert(Party::class,             { Party.fromValue(it.string!!) },             { Klaxon().toJsonString(it.value) })
    .convert(Gender::class,            { Gender.fromValue(it.string!!) },            { Klaxon().toJsonString(it.value) })
    .convert(GenderLabel::class,       { GenderLabel.fromValue(it.string!!) },       { Klaxon().toJsonString(it.value) })
    .convert(Namemod::class,           { Namemod.fromValue(it.string!!) },           { Klaxon().toJsonString(it.value) })
    .convert(RoleType::class,          { RoleType.fromValue(it.string!!) },          { Klaxon().toJsonString(it.value) })
    .convert(RoleTypeLabel::class,     { RoleTypeLabel.fromValue(it.string!!) },     { Klaxon().toJsonString(it.value) })
    .convert(SenatorClass::class,      { SenatorClass.fromValue(it.string!!) },      { Klaxon().toJsonString(it.value) })
    .convert(SenatorClassLabel::class, { SenatorClassLabel.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(SenatorRank::class,       { SenatorRank.fromValue(it.string!!) },       { Klaxon().toJsonString(it.value) })
    .convert(SenatorRankLabel::class,  { SenatorRankLabel.fromValue(it.string!!) },  { Klaxon().toJsonString(it.value) })
    .convert(Title::class,             { Title.fromValue(it.string!!) },             { Klaxon().toJsonString(it.value) })

data class TopLevel (
    val meta: Meta,
    val objects: List<Object>
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class Meta (
    val limit: Long,
    val offset: Long,

    @Json(name = "total_count")
    val totalCount: Long
)

data class Object (
    val caucus: Party? = null,

    @Json(name = "congress_numbers")
    val congressNumbers: List<Long>,

    val current: Boolean,
    val description: String,
    val district: Any? = null,
    val enddate: LocalDate,
    val extra: Extra,
    val id: Long,

    @Json(name = "leadership_title")
    val leadershipTitle: String? = null,

    val party: Party,
    val person: Person,
    val phone: String,

    @Json(name = "role_type")
    val roleType: RoleType,

    @Json(name = "role_type_label")
    val roleTypeLabel: RoleTypeLabel,

    @Json(name = "senator_class")
    val senatorClass: SenatorClass,

    @Json(name = "senator_class_label")
    val senatorClassLabel: SenatorClassLabel,

    @Json(name = "senator_rank")
    val senatorRank: SenatorRank,

    @Json(name = "senator_rank_label")
    val senatorRankLabel: SenatorRankLabel,

    val startdate: LocalDate,
    val state: String,
    val title: Title,

    @Json(name = "title_long")
    val titleLong: RoleTypeLabel,

    val website: String
)

enum class Party(val value: String) {
    Republican("Republican"),
    Democrat("Democrat"),
    Independent("Independent");

    companion object {
        public fun fromValue(value: String): Party = when (value) {
            "Republican"  -> Republican
            "Democrat"    -> Democrat
            "Independent" -> Independent
            else          -> throw IllegalArgumentException()
        }
    }
}

data class Extra (
    val address: String,

    @Json(name = "contact_form")
    val contactForm: String,

    val fax: String? = null,
    val office: String,

    @Json(name = "rss_url")
    val rssURL: String? = null
)

data class Person (
    val bioguideid: String,
    val birthday: LocalDate,
    val cspanid: Long,
    val firstname: String,
    val gender: Gender,

    @Json(name = "gender_label")
    val genderLabel: GenderLabel,

    val id: Long,
    val lastname: String,
    val link: String,
    val middlename: String,
    val name: String,
    val namemod: Namemod,
    val nickname: String,
    val osid: String,
    val pvsid: String,
    val sortname: String,
    val twitterid: String? = null,
    val youtubeid: String? = null
)

enum class Gender(val value: String) {
    Male("male"),
    Female("female");

    companion object {
        public fun fromValue(value: String): Gender = when (value) {
            "male"   -> Male
            "female" -> Female
            else     -> throw IllegalArgumentException()
        }
    }
}

enum class GenderLabel(val value: String) {
    Male("Male"),
    Female("Female");

    companion object {
        public fun fromValue(value: String): GenderLabel = when (value) {
            "Male"   -> Male
            "Female" -> Female
            else     -> throw IllegalArgumentException()
        }
    }
}

enum class Namemod(val value: String) {
    Empty(""),
    Iii("III"),
    Jr("Jr.");

    companion object {
        public fun fromValue(value: String): Namemod = when (value) {
            ""    -> Empty
            "III" -> Iii
            "Jr." -> Jr
            else  -> throw IllegalArgumentException()
        }
    }
}

enum class RoleType(val value: String) {
    Senator("senator");

    companion object {
        public fun fromValue(value: String): RoleType = when (value) {
            "senator" -> Senator
            else      -> throw IllegalArgumentException()
        }
    }
}

enum class RoleTypeLabel(val value: String) {
    Senator("Senator");

    companion object {
        public fun fromValue(value: String): RoleTypeLabel = when (value) {
            "Senator" -> Senator
            else      -> throw IllegalArgumentException()
        }
    }
}

enum class SenatorClass(val value: String) {
    Class2("class2"),
    Class1("class1"),
    Class3("class3");

    companion object {
        public fun fromValue(value: String): SenatorClass = when (value) {
            "class2" -> Class2
            "class1" -> Class1
            "class3" -> Class3
            else     -> throw IllegalArgumentException()
        }
    }
}

enum class SenatorClassLabel(val value: String) {
    Class2("Class 2"),
    Class1("Class 1"),
    Class3("Class 3");

    companion object {
        public fun fromValue(value: String): SenatorClassLabel = when (value) {
            "Class 2" -> Class2
            "Class 1" -> Class1
            "Class 3" -> Class3
            else      -> throw IllegalArgumentException()
        }
    }
}

enum class SenatorRank(val value: String) {
    Senior("senior"),
    Junior("junior");

    companion object {
        public fun fromValue(value: String): SenatorRank = when (value) {
            "senior" -> Senior
            "junior" -> Junior
            else     -> throw IllegalArgumentException()
        }
    }
}

enum class SenatorRankLabel(val value: String) {
    Senior("Senior"),
    Junior("Junior");

    companion object {
        public fun fromValue(value: String): SenatorRankLabel = when (value) {
            "Senior" -> Senior
            "Junior" -> Junior
            else     -> throw IllegalArgumentException()
        }
    }
}

enum class Title(val value: String) {
    Sen("Sen.");

    companion object {
        public fun fromValue(value: String): Title = when (value) {
            "Sen." -> Sen
            else   -> throw IllegalArgumentException()
        }
    }
}
