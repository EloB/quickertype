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
    .convert(Egg::class,  { Egg.fromValue(it.string!!) },  { Klaxon().toJsonString(it.value) })
    .convert(Type::class, { Type.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })

data class TopLevel (
    val pokemon: List<Pokemon>
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<TopLevel>(json)
    }
}

data class Pokemon (
    @Json(name = "avg_spawns")
    val avgSpawns: Double,

    val candy: String,

    @Json(name = "candy_count")
    val candyCount: Long? = null,

    val egg: Egg,
    val height: String,
    val id: Long,
    val img: String,
    val multipliers: List<Double>? = null,
    val name: String,

    @Json(name = "next_evolution")
    val nextEvolution: List<Evolution>? = null,

    val num: String,

    @Json(name = "prev_evolution")
    val prevEvolution: List<Evolution>? = null,

    @Json(name = "spawn_chance")
    val spawnChance: Double,

    @Json(name = "spawn_time")
    val spawnTime: String,

    val type: List<Type>,
    val weaknesses: List<Type>,
    val weight: String
)

enum class Egg(val value: String) {
    The2KM("2 km"),
    NotInEggs("Not in Eggs"),
    The5KM("5 km"),
    The10KM("10 km"),
    OmanyteCandy("Omanyte Candy");

    companion object {
        public fun fromValue(value: String): Egg = when (value) {
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
    val name: String,
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
        public fun fromValue(value: String): Type = when (value) {
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
