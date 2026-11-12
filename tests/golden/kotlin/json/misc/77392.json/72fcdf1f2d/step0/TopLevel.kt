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
    .convert(OrbitClass::class, { OrbitClass.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(Pha::class,        { Pha.fromValue(it.string!!) },        { Klaxon().toJsonString(it.value) })

class TopLevel(elements: Collection<TopLevelElement>) : ArrayList<TopLevelElement>(elements) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = TopLevel(klaxon.parseArray<TopLevelElement>(json)!!)
    }
}

data class TopLevelElement (
    val designation: String,

    @Json(name = "discovery_date")
    val discoveryDate: String,

    @Json(name = "h_mag")
    val hMag: String? = null,

    @Json(name = "i_deg")
    val iDeg: String,

    @Json(name = "moid_au")
    val moidAu: String,

    @Json(name = "orbit_class")
    val orbitClass: OrbitClass,

    @Json(name = "period_yr")
    val periodYr: String? = null,

    val pha: Pha,

    @Json(name = "q_au_1")
    val qAu1: String,

    @Json(name = "q_au_2")
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
        public fun fromValue(value: String): OrbitClass = when (value) {
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
        public fun fromValue(value: String): Pha = when (value) {
            "Y"   -> Y
            "N"   -> N
            "n/a" -> NA
            else  -> throw IllegalArgumentException()
        }
    }
}
