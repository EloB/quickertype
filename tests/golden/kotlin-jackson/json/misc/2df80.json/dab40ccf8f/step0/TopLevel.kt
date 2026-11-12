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
    convert(ID::class,            { ID.fromValue(it.asText()) },    { ObjectMapper().writeValueAsString(it.value) })
    convert(Value::class,         { Value.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(TopLevelUnion::class, { TopLevelUnion.fromJson(it) },   { it.toJson() }, true)
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

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is FluffyTopLevelValue      -> this.value
        is PurpleTopLevelArrayValue -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): TopLevelUnion = when (jn) {
            is ObjectNode -> FluffyTopLevelValue(mapper.convertValue(jn))
            is ArrayNode  -> PurpleTopLevelArrayValue(mapper.convertValue(jn))
            else          -> throw IllegalArgumentException()
        }
    }
}

data class PurpleTopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val adminregion: Adminregion,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val capitalCity: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val incomeLevel: Adminregion,

    @get:JsonProperty("iso2Code", required=true)@field:JsonProperty("iso2Code", required=true)
    val iso2Code: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val latitude: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val lendingType: Adminregion,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val longitude: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val region: Adminregion
)

data class Adminregion (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: ID,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
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
        fun fromValue(value: String): ID = when (value) {
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
        fun fromValue(value: String): Value = when (value) {
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
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val page: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val pages: Long,

    @get:JsonProperty("per_page", required=true)@field:JsonProperty("per_page", required=true)
    val perPage: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val total: Long
)
