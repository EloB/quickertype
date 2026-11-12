// To parse the JSON, install jackson-module-kotlin and do:
//
//   val topLevel = TopLevel.fromJson(jsonString)

package quicktype

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
    convert(Breed::class,         { Breed.fromValue(it.asText()) },     { ObjectMapper().writeValueAsString(it.value) })
    convert(Firstname::class,     { Firstname.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(Lastname::class,      { Lastname.fromValue(it.asText()) },  { ObjectMapper().writeValueAsString(it.value) })
    convert(Pvptitle::class,      { Pvptitle.fromValue(it.asText()) },  { ObjectMapper().writeValueAsString(it.value) })
    convert(RankTitle::class,     { RankTitle.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(Sex::class,           { Sex.fromValue(it.asText()) },       { ObjectMapper().writeValueAsString(it.value) })
    convert(TopLevelUnion::class, { TopLevelUnion.fromJson(it) },       { it.toJson() }, true)
}

class TopLevel(elements: Collection<TopLevelUnion> = emptyList()) : ArrayList<TopLevelUnion>(elements) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

sealed class TopLevelUnion {
    class FluffyTopLevelValue(val value: FluffyTopLevel)            : TopLevelUnion()
    class PurpleTopLevelArrayValue(val value: List<PurpleTopLevel>) : TopLevelUnion()
    class StringValue(val value: String)                            : TopLevelUnion()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is FluffyTopLevelValue      -> this.value
        is PurpleTopLevelArrayValue -> this.value
        is StringValue              -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): TopLevelUnion = when (jn) {
            is ObjectNode -> FluffyTopLevelValue(mapper.convertValue(jn))
            is ArrayNode  -> PurpleTopLevelArrayValue(mapper.convertValue(jn))
            is TextNode   -> StringValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

data class PurpleTopLevel (
    @get:JsonProperty("ALIENLEVEL", required=true)@field:JsonProperty("ALIENLEVEL", required=true)
    val alienlevel: Long,

    @get:JsonProperty("BREED", required=true)@field:JsonProperty("BREED", required=true)
    val breed: Breed,

    @get:JsonProperty("CHAR_DIMENSION", required=true)@field:JsonProperty("CHAR_DIMENSION", required=true)
    val charDimension: Long,

    @get:JsonProperty("CHAR_INSTANCE", required=true)@field:JsonProperty("CHAR_INSTANCE", required=true)
    val charInstance: Long,

    @get:JsonProperty("DEFENDER_RANK_TITLE", required=true)@field:JsonProperty("DEFENDER_RANK_TITLE", required=true)
    val defenderRankTitle: String,

    @get:JsonProperty("FIRSTNAME", required=true)@field:JsonProperty("FIRSTNAME", required=true)
    val firstname: Firstname,

    @get:JsonProperty("HEADID", required=true)@field:JsonProperty("HEADID", required=true)
    val headid: Long,

    @get:JsonProperty("LASTNAME", required=true)@field:JsonProperty("LASTNAME", required=true)
    val lastname: Lastname,

    @get:JsonProperty("LEVELX", required=true)@field:JsonProperty("LEVELX", required=true)
    val levelx: Long,

    @get:JsonProperty("NAME", required=true)@field:JsonProperty("NAME", required=true)
    val name: String,

    @get:JsonProperty("PROF", required=true)@field:JsonProperty("PROF", required=true)
    val prof: String,

    @get:JsonProperty("PROF_TITLE", required=true)@field:JsonProperty("PROF_TITLE", required=true)
    val profTitle: String,

    @get:JsonProperty("PVPRATING", required=true)@field:JsonProperty("PVPRATING", required=true)
    val pvprating: Long,

    @get:JsonProperty("PVPTITLE", required=true)@field:JsonProperty("PVPTITLE", required=true)
    val pvptitle: Pvptitle,

    @get:JsonProperty("RANK", required=true)@field:JsonProperty("RANK", required=true)
    val rank: Long,

    @get:JsonProperty("RANK_TITLE", required=true)@field:JsonProperty("RANK_TITLE", required=true)
    val rankTitle: RankTitle,

    @get:JsonProperty("SEX", required=true)@field:JsonProperty("SEX", required=true)
    val sex: Sex
)

enum class Breed(val value: String) {
    Atrox("Atrox"),
    Solitus("Solitus"),
    Opifex("Opifex"),
    Nano("Nano");

    companion object {
        fun fromValue(value: String): Breed = when (value) {
            "Atrox"   -> Atrox
            "Solitus" -> Solitus
            "Opifex"  -> Opifex
            "Nano"    -> Nano
            else      -> throw IllegalArgumentException()
        }
    }
}

enum class Firstname(val value: String) {
    Empty(""),
    Chi("Chi");

    companion object {
        fun fromValue(value: String): Firstname = when (value) {
            ""    -> Empty
            "Chi" -> Chi
            else  -> throw IllegalArgumentException()
        }
    }
}

enum class Lastname(val value: String) {
    Empty(""),
    Washko("Washko");

    companion object {
        fun fromValue(value: String): Lastname = when (value) {
            ""       -> Empty
            "Washko" -> Washko
            else     -> throw IllegalArgumentException()
        }
    }
}

enum class Pvptitle(val value: String) {
    Freshman("Freshman");

    companion object {
        fun fromValue(value: String): Pvptitle = when (value) {
            "Freshman" -> Freshman
            else       -> throw IllegalArgumentException()
        }
    }
}

enum class RankTitle(val value: String) {
    President("President"),
    Advisor("Advisor"),
    Veteran("Veteran"),
    Applicant("Applicant");

    companion object {
        fun fromValue(value: String): RankTitle = when (value) {
            "President" -> President
            "Advisor"   -> Advisor
            "Veteran"   -> Veteran
            "Applicant" -> Applicant
            else        -> throw IllegalArgumentException()
        }
    }
}

enum class Sex(val value: String) {
    Neuter("Neuter"),
    Male("Male"),
    Female("Female");

    companion object {
        fun fromValue(value: String): Sex = when (value) {
            "Neuter" -> Neuter
            "Male"   -> Male
            "Female" -> Female
            else     -> throw IllegalArgumentException()
        }
    }
}

data class FluffyTopLevel (
    @get:JsonProperty("ADVENTURERCOUNT", required=true)@field:JsonProperty("ADVENTURERCOUNT", required=true)
    val adventurercount: Long,

    @get:JsonProperty("AGENTCOUNT", required=true)@field:JsonProperty("AGENTCOUNT", required=true)
    val agentcount: Long,

    @get:JsonProperty("ATROXCOUNT", required=true)@field:JsonProperty("ATROXCOUNT", required=true)
    val atroxcount: Long,

    @get:JsonProperty("AVGLVL", required=true)@field:JsonProperty("AVGLVL", required=true)
    val avglvl: Double,

    @get:JsonProperty("BTCOUNT", required=true)@field:JsonProperty("BTCOUNT", required=true)
    val btcount: Long,

    @get:JsonProperty("DESCRIPTION", required=true)@field:JsonProperty("DESCRIPTION", required=true)
    val description: String,

    @get:JsonProperty("DOCTORCOUNT", required=true)@field:JsonProperty("DOCTORCOUNT", required=true)
    val doctorcount: Long,

    @get:JsonProperty("ENFCOUNT", required=true)@field:JsonProperty("ENFCOUNT", required=true)
    val enfcount: Long,

    @get:JsonProperty("ENGINEEERCOUNT", required=true)@field:JsonProperty("ENGINEEERCOUNT", required=true)
    val engineeercount: Long,

    @get:JsonProperty("FEMALECOUNT", required=true)@field:JsonProperty("FEMALECOUNT", required=true)
    val femalecount: Long,

    @get:JsonProperty("FIXERCOUNT", required=true)@field:JsonProperty("FIXERCOUNT", required=true)
    val fixercount: Long,

    @get:JsonProperty("GOVERNINGNAME", required=true)@field:JsonProperty("GOVERNINGNAME", required=true)
    val governingname: String,

    @get:JsonProperty("HISTORY", required=true)@field:JsonProperty("HISTORY", required=true)
    val history: String,

    @get:JsonProperty("KEEPERCOUNT", required=true)@field:JsonProperty("KEEPERCOUNT", required=true)
    val keepercount: Long,

    @get:JsonProperty("MACOUNT", required=true)@field:JsonProperty("MACOUNT", required=true)
    val macount: Long,

    @get:JsonProperty("MALECOUNT", required=true)@field:JsonProperty("MALECOUNT", required=true)
    val malecount: Long,

    @get:JsonProperty("MAXLVL", required=true)@field:JsonProperty("MAXLVL", required=true)
    val maxlvl: Long,

    @get:JsonProperty("METACOUNT", required=true)@field:JsonProperty("METACOUNT", required=true)
    val metacount: Long,

    @get:JsonProperty("MINLVL", required=true)@field:JsonProperty("MINLVL", required=true)
    val minlvl: Long,

    @get:JsonProperty("MONSTERCOUNT", required=true)@field:JsonProperty("MONSTERCOUNT", required=true)
    val monstercount: Long,

    @get:JsonProperty("NAME", required=true)@field:JsonProperty("NAME", required=true)
    val name: String,

    @get:JsonProperty("NANOCOUNT", required=true)@field:JsonProperty("NANOCOUNT", required=true)
    val nanocount: Long,

    @get:JsonProperty("NANORACECOUNT", required=true)@field:JsonProperty("NANORACECOUNT", required=true)
    val nanoracecount: Long,

    @get:JsonProperty("NEUTERCOUNT", required=true)@field:JsonProperty("NEUTERCOUNT", required=true)
    val neutercount: Long,

    @get:JsonProperty("NUMMEMBERS", required=true)@field:JsonProperty("NUMMEMBERS", required=true)
    val nummembers: Long,

    @get:JsonProperty("OBJECTIVE", required=true)@field:JsonProperty("OBJECTIVE", required=true)
    val objective: String,

    @get:JsonProperty("OPIFEXCOUNT", required=true)@field:JsonProperty("OPIFEXCOUNT", required=true)
    val opifexcount: Long,

    @get:JsonProperty("ORG_DIMENSION", required=true)@field:JsonProperty("ORG_DIMENSION", required=true)
    val orgDimension: Long,

    @get:JsonProperty("ORG_INSTANCE", required=true)@field:JsonProperty("ORG_INSTANCE", required=true)
    val orgInstance: Long,

    @get:JsonProperty("SHADECOUNT", required=true)@field:JsonProperty("SHADECOUNT", required=true)
    val shadecount: Long,

    @get:JsonProperty("SIDE", required=true)@field:JsonProperty("SIDE", required=true)
    val side: Long,

    @get:JsonProperty("SIDE_NAME", required=true)@field:JsonProperty("SIDE_NAME", required=true)
    val sideName: String,

    @get:JsonProperty("SOLIDERCOUNT", required=true)@field:JsonProperty("SOLIDERCOUNT", required=true)
    val solidercount: Long,

    @get:JsonProperty("SOLITUSCOUNT", required=true)@field:JsonProperty("SOLITUSCOUNT", required=true)
    val solituscount: Long,

    @get:JsonProperty("TRADERCOUNT", required=true)@field:JsonProperty("TRADERCOUNT", required=true)
    val tradercount: Long
)
