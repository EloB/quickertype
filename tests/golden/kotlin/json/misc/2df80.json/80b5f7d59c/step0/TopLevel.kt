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
    .convert(ID::class,            { ID.fromValue(it.string!!) },    { Klaxon().toJsonString(it.value) })
    .convert(Value::class,         { Value.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(TopLevelUnion::class, { TopLevelUnion.fromJson(it) },   { it.toJson() }, true)

class TopLevel(elements: Collection<TopLevelUnion>) : ArrayList<TopLevelUnion>(elements) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = TopLevel(klaxon.parseArray<TopLevelUnion>(json)!!)
    }
}

sealed class TopLevelUnion {
    class FluffyTopLevelValue(val value: FluffyTopLevel)            : TopLevelUnion()
    class PurpleTopLevelArrayValue(val value: List<PurpleTopLevel>) : TopLevelUnion()

    public fun toJson(): String = klaxon.toJsonString(when (this) {
        is FluffyTopLevelValue      -> this.value
        is PurpleTopLevelArrayValue -> this.value
    })

    companion object {
        public fun fromJson(jv: JsonValue): TopLevelUnion = when (jv.inside) {
            is JsonObject   -> FluffyTopLevelValue(jv.obj?.let { klaxon.parseFromJsonObject<FluffyTopLevel>(it) }!!)
            is JsonArray<*> -> PurpleTopLevelArrayValue(jv.array?.let { klaxon.parseFromJsonArray<PurpleTopLevel>(it) }!!)
            else            -> throw IllegalArgumentException()
        }
    }
}

data class PurpleTopLevel (
    val adminregion: Adminregion,
    val capitalCity: String,
    val id: String,
    val incomeLevel: Adminregion,
    val iso2Code: String,
    val latitude: String,
    val lendingType: Adminregion,
    val longitude: String,
    val name: String,
    val region: Adminregion
)

data class Adminregion (
    val id: ID,
    val value: Value
)

enum class ID(val value: String) {
    Empty(""),
    SAS("SAS"),
    SSA("SSA"),
    Eca("ECA"),
    Lac("LAC"),
    EAP("EAP"),
    Mna("MNA"),
    Hic("HIC"),
    Lic("LIC"),
    Na("NA"),
    Lmc("LMC"),
    Umc("UMC"),
    Lnx("LNX"),
    Idx("IDX"),
    Ibd("IBD"),
    Idb("IDB"),
    Lcn("LCN"),
    Ssf("SSF"),
    Ecs("ECS"),
    Mea("MEA"),
    EAS("EAS"),
    Nac("NAC");

    companion object {
        public fun fromValue(value: String): ID = when (value) {
            ""    -> Empty
            "SAS" -> SAS
            "SSA" -> SSA
            "ECA" -> Eca
            "LAC" -> Lac
            "EAP" -> EAP
            "MNA" -> Mna
            "HIC" -> Hic
            "LIC" -> Lic
            "NA"  -> Na
            "LMC" -> Lmc
            "UMC" -> Umc
            "LNX" -> Lnx
            "IDX" -> Idx
            "IBD" -> Ibd
            "IDB" -> Idb
            "LCN" -> Lcn
            "SSF" -> Ssf
            "ECS" -> Ecs
            "MEA" -> Mea
            "EAS" -> EAS
            "NAC" -> Nac
            else  -> throw IllegalArgumentException()
        }
    }
}

enum class Value(val value: String) {
    Empty(""),
    SouthAsia("South Asia"),
    SubSaharanAfricaExcludingHighIncome("Sub-Saharan Africa (excluding high income)"),
    EuropeCentralAsiaExcludingHighIncome("Europe & Central Asia (excluding high income)"),
    LatinAmericaCaribbeanExcludingHighIncome("Latin America & Caribbean (excluding high income)"),
    EastAsiaPacificExcludingHighIncome("East Asia & Pacific (excluding high income)"),
    MiddleEastNorthAfricaExcludingHighIncome("Middle East & North Africa (excluding high income)"),
    HighIncome("High income"),
    LowIncome("Low income"),
    Aggregates("Aggregates"),
    LowerMiddleIncome("Lower middle income"),
    UpperMiddleIncome("Upper middle income"),
    NotClassified("Not classified"),
    Ida("IDA"),
    Ibrd("IBRD"),
    Blend("Blend"),
    LatinAmericaCaribbean("Latin America & Caribbean "),
    SubSaharanAfrica("Sub-Saharan Africa "),
    EuropeCentralAsia("Europe & Central Asia"),
    MiddleEastNorthAfrica("Middle East & North Africa"),
    EastAsiaPacific("East Asia & Pacific"),
    NorthAmerica("North America");

    companion object {
        public fun fromValue(value: String): Value = when (value) {
            ""                                                   -> Empty
            "South Asia"                                         -> SouthAsia
            "Sub-Saharan Africa (excluding high income)"         -> SubSaharanAfricaExcludingHighIncome
            "Europe & Central Asia (excluding high income)"      -> EuropeCentralAsiaExcludingHighIncome
            "Latin America & Caribbean (excluding high income)"  -> LatinAmericaCaribbeanExcludingHighIncome
            "East Asia & Pacific (excluding high income)"        -> EastAsiaPacificExcludingHighIncome
            "Middle East & North Africa (excluding high income)" -> MiddleEastNorthAfricaExcludingHighIncome
            "High income"                                        -> HighIncome
            "Low income"                                         -> LowIncome
            "Aggregates"                                         -> Aggregates
            "Lower middle income"                                -> LowerMiddleIncome
            "Upper middle income"                                -> UpperMiddleIncome
            "Not classified"                                     -> NotClassified
            "IDA"                                                -> Ida
            "IBRD"                                               -> Ibrd
            "Blend"                                              -> Blend
            "Latin America & Caribbean "                         -> LatinAmericaCaribbean
            "Sub-Saharan Africa "                                -> SubSaharanAfrica
            "Europe & Central Asia"                              -> EuropeCentralAsia
            "Middle East & North Africa"                         -> MiddleEastNorthAfrica
            "East Asia & Pacific"                                -> EastAsiaPacific
            "North America"                                      -> NorthAmerica
            else                                                 -> throw IllegalArgumentException()
        }
    }
}

data class FluffyTopLevel (
    val page: Long,
    val pages: Long,

    @Json(name = "per_page")
    val perPage: String,

    val total: Long
)
