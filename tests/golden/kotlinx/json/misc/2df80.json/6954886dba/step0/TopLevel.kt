// To parse the JSON, install kotlin's serialization plugin and do:
//
// val json     = Json { allowStructuredMapKeys = true }
// val topLevel = json.parse(TopLevel.serializer(), jsonString)

package quicktype

import kotlinx.serialization.*
import kotlinx.serialization.json.*
import kotlinx.serialization.descriptors.*
import kotlinx.serialization.encoding.*

typealias TopLevel = List<JsonElement>

typealias TopLevelUnion = JsonElement

@Serializable
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

@Serializable
data class Adminregion (
    val id: ID,
    val value: Value
)

@Serializable
enum class ID(val value: String) {
    @SerialName("") Empty(""),
    @SerialName("SAS") SAS("SAS"),
    @SerialName("SSA") SSA("SSA"),
    @SerialName("ECA") Eca("ECA"),
    @SerialName("LAC") Lac("LAC"),
    @SerialName("EAP") EAP("EAP"),
    @SerialName("MNA") Mna("MNA"),
    @SerialName("HIC") Hic("HIC"),
    @SerialName("LIC") Lic("LIC"),
    @SerialName("NA") Na("NA"),
    @SerialName("LMC") Lmc("LMC"),
    @SerialName("UMC") Umc("UMC"),
    @SerialName("LNX") Lnx("LNX"),
    @SerialName("IDX") Idx("IDX"),
    @SerialName("IBD") Ibd("IBD"),
    @SerialName("IDB") Idb("IDB"),
    @SerialName("LCN") Lcn("LCN"),
    @SerialName("SSF") Ssf("SSF"),
    @SerialName("ECS") Ecs("ECS"),
    @SerialName("MEA") Mea("MEA"),
    @SerialName("EAS") EAS("EAS"),
    @SerialName("NAC") Nac("NAC");
}

@Serializable
enum class Value(val value: String) {
    @SerialName("") Empty(""),
    @SerialName("South Asia") SouthAsia("South Asia"),
    @SerialName("Sub-Saharan Africa (excluding high income)") SubSaharanAfricaExcludingHighIncome("Sub-Saharan Africa (excluding high income)"),
    @SerialName("Europe & Central Asia (excluding high income)") EuropeCentralAsiaExcludingHighIncome("Europe & Central Asia (excluding high income)"),
    @SerialName("Latin America & Caribbean (excluding high income)") LatinAmericaCaribbeanExcludingHighIncome("Latin America & Caribbean (excluding high income)"),
    @SerialName("East Asia & Pacific (excluding high income)") EastAsiaPacificExcludingHighIncome("East Asia & Pacific (excluding high income)"),
    @SerialName("Middle East & North Africa (excluding high income)") MiddleEastNorthAfricaExcludingHighIncome("Middle East & North Africa (excluding high income)"),
    @SerialName("High income") HighIncome("High income"),
    @SerialName("Low income") LowIncome("Low income"),
    @SerialName("Aggregates") Aggregates("Aggregates"),
    @SerialName("Lower middle income") LowerMiddleIncome("Lower middle income"),
    @SerialName("Upper middle income") UpperMiddleIncome("Upper middle income"),
    @SerialName("Not classified") NotClassified("Not classified"),
    @SerialName("IDA") Ida("IDA"),
    @SerialName("IBRD") Ibrd("IBRD"),
    @SerialName("Blend") Blend("Blend"),
    @SerialName("Latin America & Caribbean ") LatinAmericaCaribbean("Latin America & Caribbean "),
    @SerialName("Sub-Saharan Africa ") SubSaharanAfrica("Sub-Saharan Africa "),
    @SerialName("Europe & Central Asia") EuropeCentralAsia("Europe & Central Asia"),
    @SerialName("Middle East & North Africa") MiddleEastNorthAfrica("Middle East & North Africa"),
    @SerialName("East Asia & Pacific") EastAsiaPacific("East Asia & Pacific"),
    @SerialName("North America") NorthAmerica("North America");
}

@Serializable
data class FluffyTopLevel (
    val page: Long,
    val pages: Long,

    @SerialName("per_page")
    val perPage: String,

    val total: Long
)
