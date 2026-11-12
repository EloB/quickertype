// To parse the JSON, install kotlin's serialization plugin and do:
//
// val json     = Json { allowStructuredMapKeys = true }
// val topLevel = json.parse(TopLevel.serializer(), jsonString)

package quicktype

import kotlinx.serialization.*
import kotlinx.serialization.json.*
import kotlinx.serialization.descriptors.*
import kotlinx.serialization.encoding.*

typealias TopLevel = List<TopLevelElement>

@Serializable
data class TopLevelElement (
    val averageRating: Long,
    val category: String? = null,
    val createdAt: Long,
    val description: String? = null,
    val displayType: DisplayType? = null,
    val downloadCount: Long,
    val flags: List<TopLevelFlag>? = null,
    val grants: List<Grant>,
    val hideFromCatalog: Boolean,

    @SerialName("hideFromDataJson")
    val hideFromDataJSON: Boolean,

    val id: String,
    val indexUpdatedAt: Long? = null,
    val locale: String,
    val metadata: TopLevelMetadata,
    val moderationStatus: Boolean? = null,
    val modifyingViewUid: ModifyingViewUid? = null,
    val name: String,
    val newBackend: Boolean,
    val numberOfComments: Long,
    val oid: Long,
    val owner: Owner,
    val provenance: Provenance,
    val publicationAppendEnabled: Boolean,
    val publicationDate: Long? = null,
    val publicationGroup: Long,
    val publicationStage: PublicationStage,
    val ratings: Ratings? = null,
    val resourceName: String? = null,
    val rights: List<Right>,
    val rowClass: String? = null,

    @SerialName("rowIdentifierColumnId")
    val rowIdentifierColumnID: Long? = null,

    val rowsUpdatedAt: Long? = null,
    val rowsUpdatedBy: RowsUpdatedBy? = null,
    val tableAuthor: TableAuthor,

    @SerialName("tableId")
    val tableID: Long,

    val tags: List<String>? = null,
    val totalTimesRated: Long,
    val viewCount: Long,
    val viewLastModified: Long,
    val viewType: ViewType
)

@Serializable
enum class DisplayType(val value: String) {
    @SerialName("table") Table("table"),
    @SerialName("data_lens") DataLens("data_lens"),
    @SerialName("fatrow") Fatrow("fatrow"),
    @SerialName("page") Page("page");
}

@Serializable
enum class TopLevelFlag(val value: String) {
    @SerialName("default") Default("default"),
    @SerialName("restorable") Restorable("restorable"),
    @SerialName("restorePossibleForType") RestorePossibleForType("restorePossibleForType");
}

@Serializable
data class Grant (
    val flags: List<GrantFlag>,
    val inherited: Boolean,
    val type: GrantType
)

@Serializable
enum class GrantFlag(val value: String) {
    @SerialName("public") Public("public");
}

@Serializable
enum class GrantType(val value: String) {
    @SerialName("viewer") Viewer("viewer");
}

@Serializable
data class TopLevelMetadata (
    val availableDisplayTypes: List<DisplayType>? = null,

    @SerialName("custom_fields")
    val customFields: CustomFields? = null,

    val jsonQuery: JSONQuery? = null,
    val rdfClass: String? = null,
    val rdfSubject: String? = null,
    val renderTypeConfig: MetadataRenderTypeConfig? = null,
    val richRendererConfigs: RichRendererConfigs? = null,
    val rowIdentifier: String? = null,
    val rowLabel: String? = null,

    @SerialName("v1_archived_properties")
    val v1ArchivedProperties: V1ArchivedProperties? = null
)

@Serializable
data class CustomFields (
    @SerialName("TEST")
    val test: Test
)

@Serializable
data class Test (
    @SerialName("CFPB1")
    val cfpb1: String
)

@Serializable
data class JSONQuery (
    val group: List<Group>? = null,
    val order: List<Order>? = null,
    val select: List<Select>? = null,
    val where: Where? = null
)

@Serializable
data class Group (
    val columnFieldName: String
)

@Serializable
data class Order (
    val ascending: Boolean,
    val columnFieldName: OrderColumnFieldName
)

@Serializable
enum class OrderColumnFieldName(val value: String) {
    @SerialName("date_received") DateReceived("date_received"),
    @SerialName("agreement_date") AgreementDate("agreement_date"),
    @SerialName("in_effect_as_of_1_1_2012") InEffectAsOf1_1_2012("in_effect_as_of_1_1_2012");
}

@Serializable
data class Select (
    val aggregate: String? = null,
    val columnFieldName: String
)

@Serializable
data class Where (
    val children: List<Child>? = null,
    val columnFieldName: ChildColumnFieldName? = null,
    val metadata: ChildMetadata? = null,
    val operator: WhereOperator,
    val value: String? = null
)

@Serializable
data class Child (
    val columnFieldName: ChildColumnFieldName,
    val metadata: ChildMetadata? = null,
    val operator: ChildOperator,
    val value: String? = null
)

@Serializable
enum class ChildColumnFieldName(val value: String) {
    @SerialName("product") Product("product"),
    @SerialName("complaint_what_happened") ComplaintWhatHappened("complaint_what_happened"),
    @SerialName("sub_product") SubProduct("sub_product"),
    @SerialName("issue") Issue("issue");
}

@Serializable
data class ChildMetadata (
    val customValues: List<String>? = null,
    val freeform: Boolean? = null,
    val includeAuto: Long? = null,
    val operator: MetadataOperator? = null,

    @SerialName("tableColumnId")
    val tableColumnID: TableColumnID? = null,

    val unifiedVersion: Long? = null
)

@Serializable
enum class MetadataOperator(val value: String) {
    @SerialName("EQUALS") Equals("EQUALS"),
    @SerialName("blank?") Blank("blank?");
}

@Serializable
data class TableColumnID (
    @SerialName("2819740")
    val the2819740: Long
)

@Serializable
enum class ChildOperator(val value: String) {
    @SerialName("EQUALS") Equals("EQUALS"),
    @SerialName("IS_NOT_BLANK") IsNotBlank("IS_NOT_BLANK");
}

@Serializable
enum class WhereOperator(val value: String) {
    @SerialName("EQUALS") Equals("EQUALS"),
    @SerialName("AND") And("AND");
}

@Serializable
data class MetadataRenderTypeConfig (
    val visible: PurpleVisible
)

@Serializable
data class PurpleVisible (
    val fatrow: Boolean? = null,
    val table: Boolean? = null
)

@Serializable
data class RichRendererConfigs (
    val fatRow: FatRow
)

@Serializable
data class FatRow (
    val columns: List<Column>
)

@Serializable
data class Column (
    val rows: List<Row>,
    val styles: Styles
)

@Serializable
data class Row (
    val fields: List<Field>
)

@Serializable
data class Field (
    @SerialName("tableColumnId")
    val tableColumnID: Long,

    val type: FieldType
)

@Serializable
enum class FieldType(val value: String) {
    @SerialName("columnLabel") ColumnLabel("columnLabel"),
    @SerialName("columnData") ColumnData("columnData");
}

@Serializable
data class Styles (
    val width: Width
)

@Serializable
enum class Width(val value: String) {
    @SerialName("27%") The27("27%"),
    @SerialName("40%") The40("40%"),
    @SerialName("30%") The30("30%"),
    @SerialName("33%") The33("33%");
}

@Serializable
data class V1ArchivedProperties (
    val accessPoints: AccessPoints,

    @SerialName("blist_id")
    val blistID: String,

    val renderTypeConfig: V1ArchivedPropertiesRenderTypeConfig
)

@Serializable
data class AccessPoints (
    @SerialName("new_view")
    val newView: String
)

@Serializable
data class V1ArchivedPropertiesRenderTypeConfig (
    val visible: FluffyVisible
)

@Serializable
data class FluffyVisible (
    val href: Boolean
)

@Serializable
enum class ModifyingViewUid(val value: String) {
    @SerialName("s6ew-h6mp") S6EwH6Mp("s6ew-h6mp");
}

@Serializable
data class Owner (
    val displayName: String,
    val flags: List<String>? = null,
    val id: String,
    val lastNotificationSeenAt: Long? = null,

    @SerialName("profileImageUrlLarge")
    val profileImageURLLarge: String? = null,

    @SerialName("profileImageUrlMedium")
    val profileImageURLMedium: String? = null,

    @SerialName("profileImageUrlSmall")
    val profileImageURLSmall: String? = null,

    val rights: List<String>? = null,
    val roleName: RoleName? = null,
    val screenName: String
)

@Serializable
enum class RoleName(val value: String) {
    @SerialName("administrator") Administrator("administrator"),
    @SerialName("publisher") Publisher("publisher");
}

@Serializable
enum class Provenance(val value: String) {
    @SerialName("official") Official("official");
}

@Serializable
enum class PublicationStage(val value: String) {
    @SerialName("published") Published("published");
}

@Serializable
data class Ratings (
    val rating: Long
)

@Serializable
enum class Right(val value: String) {
    @SerialName("read") Read("read");
}

@Serializable
enum class RowsUpdatedBy(val value: String) {
    @SerialName("pjxg-ve4m") PjxgVe4M("pjxg-ve4m"),
    @SerialName("54a3-qyun") The54A3Qyun("54a3-qyun"),
    @SerialName("9e3m-2843") The9E3M2843("9e3m-2843"),
    @SerialName("vvca-fr6g") VvcaFr6G("vvca-fr6g");
}

@Serializable
data class TableAuthor (
    val displayName: String,
    val id: String,
    val rights: List<String>? = null,
    val roleName: RoleName? = null,
    val screenName: String
)

@Serializable
enum class ViewType(val value: String) {
    @SerialName("tabular") Tabular("tabular");
}
