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
    convert(OrbitClass::class, { OrbitClass.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(Pha::class,        { Pha.fromValue(it.asText()) },        { ObjectMapper().writeValueAsString(it.value) })
}

class TopLevel(elements: Collection<TopLevelElement> = emptyList()) : ArrayList<TopLevelElement>(elements) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class TopLevelElement (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val designation: String,

    @get:JsonProperty("discovery_date", required=true)@field:JsonProperty("discovery_date", required=true)
    val discoveryDate: String,

    @get:JsonProperty("h_mag")@field:JsonProperty("h_mag")
    val hMag: String? = null,

    @get:JsonProperty("i_deg", required=true)@field:JsonProperty("i_deg", required=true)
    val iDeg: String,

    @get:JsonProperty("moid_au", required=true)@field:JsonProperty("moid_au", required=true)
    val moidAu: String,

    @get:JsonProperty("orbit_class", required=true)@field:JsonProperty("orbit_class", required=true)
    val orbitClass: OrbitClass,

    @get:JsonProperty("period_yr")@field:JsonProperty("period_yr")
    val periodYr: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pha: Pha,

    @get:JsonProperty("q_au_1", required=true)@field:JsonProperty("q_au_1", required=true)
    val qAu1: String,

    @get:JsonProperty("q_au_2")@field:JsonProperty("q_au_2")
    val qAu2: String? = null
)

enum class OrbitClass(val value: String) {
    Apollo("Apollo"),
    Amor("Amor"),
    Aten("Aten"),
    Comet("Comet"),
    JupiterFamilyComet("Jupiter-family Comet"),
    HalleyTypeComet("Halley-type Comet*"),
    ParabolicComet("Parabolic Comet"),
    OrbitClassJupiterFamilyComet("Jupiter-family Comet*"),
    EnckeTypeComet("Encke-type Comet");

    companion object {
        fun fromValue(value: String): OrbitClass = when (value) {
            "Apollo"                -> Apollo
            "Amor"                  -> Amor
            "Aten"                  -> Aten
            "Comet"                 -> Comet
            "Jupiter-family Comet"  -> JupiterFamilyComet
            "Halley-type Comet*"    -> HalleyTypeComet
            "Parabolic Comet"       -> ParabolicComet
            "Jupiter-family Comet*" -> OrbitClassJupiterFamilyComet
            "Encke-type Comet"      -> EnckeTypeComet
            else                    -> throw IllegalArgumentException()
        }
    }
}

enum class Pha(val value: String) {
    Y("Y"),
    N("N"),
    NA("n/a");

    companion object {
        fun fromValue(value: String): Pha = when (value) {
            "Y"   -> Y
            "N"   -> N
            "n/a" -> NA
            else  -> throw IllegalArgumentException()
        }
    }
}
