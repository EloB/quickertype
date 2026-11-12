// To parse the JSON, install kotlin's serialization plugin and do:
//
// val json     = Json { allowStructuredMapKeys = true }
// val topLevel = json.parse(TopLevel.serializer(), jsonString)

package quicktype

import kotlinx.serialization.*
import kotlinx.serialization.json.*
import kotlinx.serialization.descriptors.*
import kotlinx.serialization.encoding.*

@Serializable
data class TopLevel (
    val pokemon: List<Pokemon>
)

@Serializable
data class Pokemon (
    @SerialName("avg_spawns")
    val avgSpawns: Double,

    val candy: String,

    @SerialName("candy_count")
    val candyCount: Long? = null,

    val egg: Egg,
    val height: String,
    val id: Long,
    val img: String,
    val multipliers: List<Double>? = null,
    val name: String,

    @SerialName("next_evolution")
    val nextEvolution: List<Evolution>? = null,

    val num: String,

    @SerialName("prev_evolution")
    val prevEvolution: List<Evolution>? = null,

    @SerialName("spawn_chance")
    val spawnChance: Double,

    @SerialName("spawn_time")
    val spawnTime: String,

    val type: List<Type>,
    val weaknesses: List<Type>,
    val weight: String
)

@Serializable
enum class Egg(val value: String) {
    @SerialName("2 km") The2KM("2 km"),
    @SerialName("Not in Eggs") NotInEggs("Not in Eggs"),
    @SerialName("5 km") The5KM("5 km"),
    @SerialName("10 km") The10KM("10 km"),
    @SerialName("Omanyte Candy") OmanyteCandy("Omanyte Candy");
}

@Serializable
data class Evolution (
    val name: String,
    val num: String
)

@Serializable
enum class Type(val value: String) {
    @SerialName("Fire") Fire("Fire"),
    @SerialName("Ice") Ice("Ice"),
    @SerialName("Flying") Flying("Flying"),
    @SerialName("Psychic") Psychic("Psychic"),
    @SerialName("Water") Water("Water"),
    @SerialName("Ground") Ground("Ground"),
    @SerialName("Rock") Rock("Rock"),
    @SerialName("Electric") Electric("Electric"),
    @SerialName("Grass") Grass("Grass"),
    @SerialName("Fighting") Fighting("Fighting"),
    @SerialName("Poison") Poison("Poison"),
    @SerialName("Bug") Bug("Bug"),
    @SerialName("Fairy") Fairy("Fairy"),
    @SerialName("Ghost") Ghost("Ghost"),
    @SerialName("Dark") Dark("Dark"),
    @SerialName("Steel") Steel("Steel"),
    @SerialName("Dragon") Dragon("Dragon"),
    @SerialName("Normal") Normal("Normal");
}
