// To parse the JSON, install jackson-module-kotlin and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

import java.time.LocalDate

import com.fasterxml.jackson.annotation.*
import com.fasterxml.jackson.core.*
import com.fasterxml.jackson.databind.*
import com.fasterxml.jackson.databind.deser.std.StdDeserializer
import com.fasterxml.jackson.databind.module.SimpleModule
import com.fasterxml.jackson.databind.node.*
import com.fasterxml.jackson.databind.ser.std.StdSerializer
import com.fasterxml.jackson.module.kotlin.*


@Suppress("UNCHECKED_CAST")
private fun <T> ObjectMapper.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonNode) -> T, toJson: (T) -> String, isUnion: Boolean = false) = registerModule(SimpleModule().apply {
    addSerializer(k.java as Class<T>, object : StdSerializer<T>(k.java as Class<T>) {
            override fun serialize(value: T, gen: JsonGenerator, provider: SerializerProvider) = gen.writeRawValue(toJson(value))
    })
    addDeserializer(k.java as Class<T>, object : StdDeserializer<T>(k.java as Class<T>) {
            override fun deserialize(p: JsonParser, ctxt: DeserializationContext) = fromJson(p.readValueAsTree())
    })
})

val mapper = jacksonObjectMapper().apply {
    propertyNamingStrategy = object : PropertyNamingStrategy.PropertyNamingStrategyBase() { override fun translate(name: String) = if (name == "empty") "" else name }
    setSerializationInclusion(JsonInclude.Include.NON_NULL)
    disable(DeserializationFeature.ACCEPT_FLOAT_AS_INT)
    convert(LocalDate::class,         { LocalDate.parse(it.asText()) },             { "\"${java.time.format.DateTimeFormatter.ISO_LOCAL_DATE.format(it)}\"" })
    convert(Party::class,             { Party.fromValue(it.asText()) },             { ObjectMapper().writeValueAsString(it.value) })
    convert(Gender::class,            { Gender.fromValue(it.asText()) },            { ObjectMapper().writeValueAsString(it.value) })
    convert(GenderLabel::class,       { GenderLabel.fromValue(it.asText()) },       { ObjectMapper().writeValueAsString(it.value) })
    convert(Namemod::class,           { Namemod.fromValue(it.asText()) },           { ObjectMapper().writeValueAsString(it.value) })
    convert(RoleType::class,          { RoleType.fromValue(it.asText()) },          { ObjectMapper().writeValueAsString(it.value) })
    convert(RoleTypeLabel::class,     { RoleTypeLabel.fromValue(it.asText()) },     { ObjectMapper().writeValueAsString(it.value) })
    convert(SenatorClass::class,      { SenatorClass.fromValue(it.asText()) },      { ObjectMapper().writeValueAsString(it.value) })
    convert(SenatorClassLabel::class, { SenatorClassLabel.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(SenatorRank::class,       { SenatorRank.fromValue(it.asText()) },       { ObjectMapper().writeValueAsString(it.value) })
    convert(SenatorRankLabel::class,  { SenatorRankLabel.fromValue(it.asText()) },  { ObjectMapper().writeValueAsString(it.value) })
    convert(Title::class,             { Title.fromValue(it.asText()) },             { ObjectMapper().writeValueAsString(it.value) })
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val meta: Meta,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val objects: List<Object>
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class Meta (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val limit: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val offset: Long,

    @get:JsonProperty("total_count", required=true)@field:JsonProperty("total_count", required=true)
    val totalCount: Long
)

data class Object (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val caucus: Party?,

    @get:JsonProperty("congress_numbers", required=true)@field:JsonProperty("congress_numbers", required=true)
    val congressNumbers: List<Long>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val current: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val description: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val district: Any? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val enddate: LocalDate,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val extra: Extra,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty("leadership_title", required=true)@field:JsonProperty("leadership_title", required=true)
    val leadershipTitle: String?,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val party: Party,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val person: Person,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val phone: String,

    @get:JsonProperty("role_type", required=true)@field:JsonProperty("role_type", required=true)
    val roleType: RoleType,

    @get:JsonProperty("role_type_label", required=true)@field:JsonProperty("role_type_label", required=true)
    val roleTypeLabel: RoleTypeLabel,

    @get:JsonProperty("senator_class", required=true)@field:JsonProperty("senator_class", required=true)
    val senatorClass: SenatorClass,

    @get:JsonProperty("senator_class_label", required=true)@field:JsonProperty("senator_class_label", required=true)
    val senatorClassLabel: SenatorClassLabel,

    @get:JsonProperty("senator_rank", required=true)@field:JsonProperty("senator_rank", required=true)
    val senatorRank: SenatorRank,

    @get:JsonProperty("senator_rank_label", required=true)@field:JsonProperty("senator_rank_label", required=true)
    val senatorRankLabel: SenatorRankLabel,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val startdate: LocalDate,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val state: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val title: Title,

    @get:JsonProperty("title_long", required=true)@field:JsonProperty("title_long", required=true)
    val titleLong: RoleTypeLabel,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val website: String
)

enum class Party(val value: String) {
    Republican("Republican"),
    Democrat("Democrat"),
    Independent("Independent");

    companion object {
        fun fromValue(value: String): Party = when (value) {
            "Republican"  -> Republican
            "Democrat"    -> Democrat
            "Independent" -> Independent
            else          -> throw IllegalArgumentException()
        }
    }
}

data class Extra (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val address: String,

    @get:JsonProperty("contact_form", required=true)@field:JsonProperty("contact_form", required=true)
    val contactForm: String,

    val fax: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val office: String,

    @get:JsonProperty("rss_url")@field:JsonProperty("rss_url")
    val rssURL: String? = null
)

data class Person (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val bioguideid: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val birthday: LocalDate,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val cspanid: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val firstname: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val gender: Gender,

    @get:JsonProperty("gender_label", required=true)@field:JsonProperty("gender_label", required=true)
    val genderLabel: GenderLabel,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val lastname: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val link: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val middlename: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val namemod: Namemod,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val nickname: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val osid: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pvsid: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val sortname: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val twitterid: String?,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val youtubeid: String?
)

enum class Gender(val value: String) {
    Male("male"),
    Female("female");

    companion object {
        fun fromValue(value: String): Gender = when (value) {
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
        fun fromValue(value: String): GenderLabel = when (value) {
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
        fun fromValue(value: String): Namemod = when (value) {
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
        fun fromValue(value: String): RoleType = when (value) {
            "senator" -> Senator
            else      -> throw IllegalArgumentException()
        }
    }
}

enum class RoleTypeLabel(val value: String) {
    Senator("Senator");

    companion object {
        fun fromValue(value: String): RoleTypeLabel = when (value) {
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
        fun fromValue(value: String): SenatorClass = when (value) {
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
        fun fromValue(value: String): SenatorClassLabel = when (value) {
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
        fun fromValue(value: String): SenatorRank = when (value) {
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
        fun fromValue(value: String): SenatorRankLabel = when (value) {
            "Senior" -> Senior
            "Junior" -> Junior
            else     -> throw IllegalArgumentException()
        }
    }
}

enum class Title(val value: String) {
    Sen("Sen.");

    companion object {
        fun fromValue(value: String): Title = when (value) {
            "Sen." -> Sen
            else   -> throw IllegalArgumentException()
        }
    }
}
