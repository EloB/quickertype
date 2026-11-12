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
    .convert(Breed::class,         { Breed.fromValue(it.string!!) },     { Klaxon().toJsonString(it.value) })
    .convert(Firstname::class,     { Firstname.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(Lastname::class,      { Lastname.fromValue(it.string!!) },  { Klaxon().toJsonString(it.value) })
    .convert(Pvptitle::class,      { Pvptitle.fromValue(it.string!!) },  { Klaxon().toJsonString(it.value) })
    .convert(RankTitle::class,     { RankTitle.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(Sex::class,           { Sex.fromValue(it.string!!) },       { Klaxon().toJsonString(it.value) })
    .convert(TopLevelUnion::class, { TopLevelUnion.fromJson(it) },       { it.toJson() }, true)

class TopLevel(elements: Collection<TopLevelUnion>) : ArrayList<TopLevelUnion>(elements) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = TopLevel(klaxon.parseArray<TopLevelUnion>(json)!!)
    }
}

sealed class TopLevelUnion {
    class FluffyTopLevelValue(val value: FluffyTopLevel)            : TopLevelUnion()
    class PurpleTopLevelArrayValue(val value: List<PurpleTopLevel>) : TopLevelUnion()
    class StringValue(val value: String)                            : TopLevelUnion()

    public fun toJson(): String = klaxon.toJsonString(when (this) {
        is FluffyTopLevelValue      -> this.value
        is PurpleTopLevelArrayValue -> this.value
        is StringValue              -> this.value
    })

    companion object {
        public fun fromJson(jv: JsonValue): TopLevelUnion = when (jv.inside) {
            is JsonObject   -> FluffyTopLevelValue(jv.obj?.let { klaxon.parseFromJsonObject<FluffyTopLevel>(it) }!!)
            is JsonArray<*> -> PurpleTopLevelArrayValue(jv.array?.let { klaxon.parseFromJsonArray<PurpleTopLevel>(it) }!!)
            is String       -> StringValue(jv.string!!)
            else            -> throw IllegalArgumentException()
        }
    }
}

data class PurpleTopLevel (
    @Json(name = "ALIENLEVEL")
    val alienlevel: Long,

    @Json(name = "BREED")
    val breed: Breed,

    @Json(name = "CHAR_DIMENSION")
    val charDimension: Long,

    @Json(name = "CHAR_INSTANCE")
    val charInstance: Long,

    @Json(name = "DEFENDER_RANK_TITLE")
    val defenderRankTitle: String,

    @Json(name = "FIRSTNAME")
    val firstname: Firstname,

    @Json(name = "HEADID")
    val headid: Long,

    @Json(name = "LASTNAME")
    val lastname: Lastname,

    @Json(name = "LEVELX")
    val levelx: Long,

    @Json(name = "NAME")
    val name: String,

    @Json(name = "PROF")
    val prof: String,

    @Json(name = "PROF_TITLE")
    val profTitle: String,

    @Json(name = "PVPRATING")
    val pvprating: Long,

    @Json(name = "PVPTITLE")
    val pvptitle: Pvptitle,

    @Json(name = "RANK")
    val rank: Long,

    @Json(name = "RANK_TITLE")
    val rankTitle: RankTitle,

    @Json(name = "SEX")
    val sex: Sex
)

enum class Breed(val value: String) {
    Atrox("Atrox"),
    Solitus("Solitus"),
    Opifex("Opifex"),
    Nano("Nano");

    companion object {
        public fun fromValue(value: String): Breed = when (value) {
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
        public fun fromValue(value: String): Firstname = when (value) {
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
        public fun fromValue(value: String): Lastname = when (value) {
            ""       -> Empty
            "Washko" -> Washko
            else     -> throw IllegalArgumentException()
        }
    }
}

enum class Pvptitle(val value: String) {
    Freshman("Freshman");

    companion object {
        public fun fromValue(value: String): Pvptitle = when (value) {
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
        public fun fromValue(value: String): RankTitle = when (value) {
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
        public fun fromValue(value: String): Sex = when (value) {
            "Neuter" -> Neuter
            "Male"   -> Male
            "Female" -> Female
            else     -> throw IllegalArgumentException()
        }
    }
}

data class FluffyTopLevel (
    @Json(name = "ADVENTURERCOUNT")
    val adventurercount: Long,

    @Json(name = "AGENTCOUNT")
    val agentcount: Long,

    @Json(name = "ATROXCOUNT")
    val atroxcount: Long,

    @Json(name = "AVGLVL")
    val avglvl: Double,

    @Json(name = "BTCOUNT")
    val btcount: Long,

    @Json(name = "DESCRIPTION")
    val description: String,

    @Json(name = "DOCTORCOUNT")
    val doctorcount: Long,

    @Json(name = "ENFCOUNT")
    val enfcount: Long,

    @Json(name = "ENGINEEERCOUNT")
    val engineeercount: Long,

    @Json(name = "FEMALECOUNT")
    val femalecount: Long,

    @Json(name = "FIXERCOUNT")
    val fixercount: Long,

    @Json(name = "GOVERNINGNAME")
    val governingname: String,

    @Json(name = "HISTORY")
    val history: String,

    @Json(name = "KEEPERCOUNT")
    val keepercount: Long,

    @Json(name = "MACOUNT")
    val macount: Long,

    @Json(name = "MALECOUNT")
    val malecount: Long,

    @Json(name = "MAXLVL")
    val maxlvl: Long,

    @Json(name = "METACOUNT")
    val metacount: Long,

    @Json(name = "MINLVL")
    val minlvl: Long,

    @Json(name = "MONSTERCOUNT")
    val monstercount: Long,

    @Json(name = "NAME")
    val name: String,

    @Json(name = "NANOCOUNT")
    val nanocount: Long,

    @Json(name = "NANORACECOUNT")
    val nanoracecount: Long,

    @Json(name = "NEUTERCOUNT")
    val neutercount: Long,

    @Json(name = "NUMMEMBERS")
    val nummembers: Long,

    @Json(name = "OBJECTIVE")
    val objective: String,

    @Json(name = "OPIFEXCOUNT")
    val opifexcount: Long,

    @Json(name = "ORG_DIMENSION")
    val orgDimension: Long,

    @Json(name = "ORG_INSTANCE")
    val orgInstance: Long,

    @Json(name = "SHADECOUNT")
    val shadecount: Long,

    @Json(name = "SIDE")
    val side: Long,

    @Json(name = "SIDE_NAME")
    val sideName: String,

    @Json(name = "SOLIDERCOUNT")
    val solidercount: Long,

    @Json(name = "SOLITUSCOUNT")
    val solituscount: Long,

    @Json(name = "TRADERCOUNT")
    val tradercount: Long
)
