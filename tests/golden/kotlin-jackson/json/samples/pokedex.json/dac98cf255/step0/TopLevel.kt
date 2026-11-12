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
    convert(Egg::class,  { Egg.fromValue(it.asText()) },  { ObjectMapper().writeValueAsString(it.value) })
    convert(Type::class, { Type.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pokemon: List<Pokemon>
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class Pokemon (
    @get:JsonProperty("avg_spawns", required=true)@field:JsonProperty("avg_spawns", required=true)
    val avgSpawns: Double,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val candy: String,

    @get:JsonProperty("candy_count")@field:JsonProperty("candy_count")
    val candyCount: Long? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val egg: Egg,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val height: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val img: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val multipliers: List<Double>?,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty("next_evolution")@field:JsonProperty("next_evolution")
    val nextEvolution: List<Evolution>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val num: String,

    @get:JsonProperty("prev_evolution")@field:JsonProperty("prev_evolution")
    val prevEvolution: List<Evolution>? = null,

    @get:JsonProperty("spawn_chance", required=true)@field:JsonProperty("spawn_chance", required=true)
    val spawnChance: Double,

    @get:JsonProperty("spawn_time", required=true)@field:JsonProperty("spawn_time", required=true)
    val spawnTime: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: List<Type>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val weaknesses: List<Type>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val weight: String
)

enum class Egg(val value: String) {
    The2KM("2 km"),
    NotInEggs("Not in Eggs"),
    The5KM("5 km"),
    The10KM("10 km"),
    OmanyteCandy("Omanyte Candy");

    companion object {
        fun fromValue(value: String): Egg = when (value) {
            "2 km"          -> The2KM
            "Not in Eggs"   -> NotInEggs
            "5 km"          -> The5KM
            "10 km"         -> The10KM
            "Omanyte Candy" -> OmanyteCandy
            else            -> throw IllegalArgumentException()
        }
    }
}

data class Evolution (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val num: String
)

enum class Type(val value: String) {
    Fire("Fire"),
    Ice("Ice"),
    Flying("Flying"),
    Psychic("Psychic"),
    Water("Water"),
    Ground("Ground"),
    Rock("Rock"),
    Electric("Electric"),
    Grass("Grass"),
    Fighting("Fighting"),
    Poison("Poison"),
    Bug("Bug"),
    Fairy("Fairy"),
    Ghost("Ghost"),
    Dark("Dark"),
    Steel("Steel"),
    Dragon("Dragon"),
    Normal("Normal");

    companion object {
        fun fromValue(value: String): Type = when (value) {
            "Fire"     -> Fire
            "Ice"      -> Ice
            "Flying"   -> Flying
            "Psychic"  -> Psychic
            "Water"    -> Water
            "Ground"   -> Ground
            "Rock"     -> Rock
            "Electric" -> Electric
            "Grass"    -> Grass
            "Fighting" -> Fighting
            "Poison"   -> Poison
            "Bug"      -> Bug
            "Fairy"    -> Fairy
            "Ghost"    -> Ghost
            "Dark"     -> Dark
            "Steel"    -> Steel
            "Dragon"   -> Dragon
            "Normal"   -> Normal
            else       -> throw IllegalArgumentException()
        }
    }
}
