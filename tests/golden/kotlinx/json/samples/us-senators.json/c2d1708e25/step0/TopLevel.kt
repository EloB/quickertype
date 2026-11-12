// To parse the JSON, install kotlin's serialization plugin and do:
//
// val json     = Json { allowStructuredMapKeys = true }
// val topLevel = json.parse(TopLevel.serializer(), jsonString)

@file:UseSerializers(LocalDateSerializer::class)

package quicktype

import java.time.LocalDate

import kotlinx.serialization.*
import kotlinx.serialization.json.*
import kotlinx.serialization.descriptors.*
import kotlinx.serialization.encoding.*

@Serializable
data class TopLevel (
    val meta: Meta,
    val objects: List<Object>
)

@Serializable
data class Meta (
    val limit: Long,
    val offset: Long,

    @SerialName("total_count")
    val totalCount: Long
)

@Serializable
data class Object (
    val caucus: Party? = null,

    @SerialName("congress_numbers")
    val congressNumbers: List<Long>,

    val current: Boolean,
    val description: String,
    val district: JsonElement? = null,
    val enddate: LocalDate,
    val extra: Extra,

    @SerialName("leadership_title")
    val leadershipTitle: String? = null,

    val party: Party,
    val person: Person,
    val phone: String,

    @SerialName("role_type")
    val roleType: RoleType,

    @SerialName("role_type_label")
    val roleTypeLabel: RoleTypeLabel,

    @SerialName("senator_class")
    val senatorClass: SenatorClass,

    @SerialName("senator_class_label")
    val senatorClassLabel: SenatorClassLabel,

    @SerialName("senator_rank")
    val senatorRank: SenatorRank,

    @SerialName("senator_rank_label")
    val senatorRankLabel: SenatorRankLabel,

    val startdate: LocalDate,
    val state: String,
    val title: Title,

    @SerialName("title_long")
    val titleLong: RoleTypeLabel,

    val website: String
)

@Serializable
enum class Party(val value: String) {
    @SerialName("Democrat") Democrat("Democrat"),
    @SerialName("Republican") Republican("Republican"),
    @SerialName("Independent") Independent("Independent");
}

@Serializable
data class Extra (
    val address: String,

    @SerialName("contact_form")
    val contactForm: String,

    val fax: String? = null,
    val office: String,

    @SerialName("rss_url")
    val rssURL: String? = null
)

@Serializable
data class Person (
    val bioguideid: String,
    val birthday: LocalDate,
    val cspanid: Long,
    val firstname: String,
    val gender: Gender,

    @SerialName("gender_label")
    val genderLabel: GenderLabel,

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

@Serializable
enum class Gender(val value: String) {
    @SerialName("female") Female("female"),
    @SerialName("male") Male("male");
}

@Serializable
enum class GenderLabel(val value: String) {
    @SerialName("Female") Female("Female"),
    @SerialName("Male") Male("Male");
}

@Serializable
enum class Namemod(val value: String) {
    @SerialName("") Empty(""),
    @SerialName("Jr.") Jr("Jr."),
    @SerialName("III") Iii("III");
}

@Serializable
enum class RoleType(val value: String) {
    @SerialName("senator") Senator("senator");
}

@Serializable
enum class RoleTypeLabel(val value: String) {
    @SerialName("Senator") Senator("Senator");
}

@Serializable
enum class SenatorClass(val value: String) {
    @SerialName("class1") Class1("class1"),
    @SerialName("class2") Class2("class2"),
    @SerialName("class3") Class3("class3");
}

@Serializable
enum class SenatorClassLabel(val value: String) {
    @SerialName("Class 1") Class1("Class 1"),
    @SerialName("Class 2") Class2("Class 2"),
    @SerialName("Class 3") Class3("Class 3");
}

@Serializable
enum class SenatorRank(val value: String) {
    @SerialName("junior") Junior("junior"),
    @SerialName("senior") Senior("senior");
}

@Serializable
enum class SenatorRankLabel(val value: String) {
    @SerialName("Junior") Junior("Junior"),
    @SerialName("Senior") Senior("Senior");
}

@Serializable
enum class Title(val value: String) {
    @SerialName("Sen.") Sen("Sen.");
}

object LocalDateSerializer : KSerializer<LocalDate> {
    override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("LocalDate", PrimitiveKind.STRING)
    override fun deserialize(decoder: Decoder): LocalDate = LocalDate.parse(decoder.decodeString())
    override fun serialize(encoder: Encoder, value: LocalDate) {
        encoder.encodeString(java.time.format.DateTimeFormatter.ISO_LOCAL_DATE.format(value))
    }
}
