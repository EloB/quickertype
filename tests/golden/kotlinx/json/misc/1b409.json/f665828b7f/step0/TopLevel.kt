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
    val caucus: JsonElement? = null,

    @SerialName("congress_numbers")
    val congressNumbers: List<Long>,

    val current: Boolean,
    val description: String,
    val district: Long,
    val enddate: LocalDate,
    val extra: Extra,
    val id: Long,

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
    val senatorClass: JsonElement? = null,

    @SerialName("senator_rank")
    val senatorRank: JsonElement? = null,

    val startdate: LocalDate,
    val state: String,
    val title: Title,

    @SerialName("title_long")
    val titleLong: RoleTypeLabel,

    val website: String
)

@Serializable
data class Extra (
    val address: String,

    @SerialName("contact_form")
    val contactForm: String? = null,

    val fax: String? = null,
    val office: String,

    @SerialName("rss_url")
    val rssURL: String? = null
)

@Serializable
enum class Party(val value: String) {
    @SerialName("Republican") Republican("Republican"),
    @SerialName("Democrat") Democrat("Democrat");
}

@Serializable
data class Person (
    val bioguideid: String,
    val birthday: LocalDate,
    val cspanid: Long,
    val firstname: String,
    val gender: Gender,

    @SerialName("gender_label")
    val genderLabel: GenderLabel,

    val id: Long,
    val lastname: String,
    val link: String,
    val middlename: String,
    val name: String,
    val namemod: Namemod,
    val nickname: String,
    val osid: String,
    val pvsid: String? = null,
    val sortname: String,
    val twitterid: String? = null,
    val youtubeid: String? = null
)

@Serializable
enum class Gender(val value: String) {
    @SerialName("male") Male("male"),
    @SerialName("female") Female("female");
}

@Serializable
enum class GenderLabel(val value: String) {
    @SerialName("Male") Male("Male"),
    @SerialName("Female") Female("Female");
}

@Serializable
enum class Namemod(val value: String) {
    @SerialName("") Empty(""),
    @SerialName("Jr.") Jr("Jr."),
    @SerialName("II") Ii("II"),
    @SerialName("III") Iii("III"),
    @SerialName("IV") Iv("IV");
}

@Serializable
enum class RoleType(val value: String) {
    @SerialName("representative") Representative("representative");
}

@Serializable
enum class RoleTypeLabel(val value: String) {
    @SerialName("Representative") Representative("Representative"),
    @SerialName("Delegate") Delegate("Delegate"),
    @SerialName("Resident Commissioner") ResidentCommissioner("Resident Commissioner");
}

@Serializable
enum class Title(val value: String) {
    @SerialName("Rep.") Rep("Rep."),
    @SerialName("Commish.") Commish("Commish.");
}

object LocalDateSerializer : KSerializer<LocalDate> {
    override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("LocalDate", PrimitiveKind.STRING)
    override fun deserialize(decoder: Decoder): LocalDate = LocalDate.parse(decoder.decodeString())
    override fun serialize(encoder: Encoder, value: LocalDate) {
        encoder.encodeString(java.time.format.DateTimeFormatter.ISO_LOCAL_DATE.format(value))
    }
}
