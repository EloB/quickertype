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
    val data: List<JsonArray>,
    val meta: Meta
)

typealias Datum = JsonElement

@Serializable
data class Meta (
    val view: View
)

@Serializable
data class View (
    val attribution: String,
    val attributionLink: String,
    val averageRating: Long,
    val category: String,
    val columns: List<Column>,
    val createdAt: Long,
    val description: String,
    val displayType: String,
    val downloadCount: Long,
    val flags: List<String>,
    val grants: List<Grant>,
    val hideFromCatalog: Boolean,

    @SerialName("hideFromDataJson")
    val hideFromDataJSON: Boolean,

    val id: String,
    val indexUpdatedAt: Long,
    val locale: String,
    val metadata: Metadata,
    val name: String,
    val newBackend: Boolean,
    val numberOfComments: Long,
    val oid: Long,
    val owner: Owner,
    val provenance: String,
    val publicationAppendEnabled: Boolean,
    val publicationDate: Long,
    val publicationGroup: Long,
    val publicationStage: String,
    val query: Query,
    val rights: List<String>,
    val rowsUpdatedAt: Long,
    val rowsUpdatedBy: String,
    val tableAuthor: Owner,

    @SerialName("tableId")
    val tableID: Long,

    val tags: List<String>,
    val totalTimesRated: Long,
    val viewCount: Long,
    val viewLastModified: Long,
    val viewType: String
)

@Serializable
data class Column (
    val cachedContents: CachedContents? = null,
    val dataTypeName: TypeName,
    val fieldName: String,
    val flags: List<String>? = null,
    val format: Format,
    val id: Long,
    val name: String,
    val position: Long,
    val renderTypeName: TypeName,

    @SerialName("tableColumnId")
    val tableColumnID: Long? = null,

    val width: Long? = null
)

@Serializable
data class CachedContents (
    @SerialName("null")
    val cachedContentsNull: Long,

    val largest: String,

    @SerialName("non_null")
    val nonNull: Long,

    val smallest: String,
    val top: List<Top>
)

@Serializable
data class Top (
    val count: Long,
    val item: String
)

@Serializable
enum class TypeName(val value: String) {
    @SerialName("meta_data") MetaData("meta_data"),
    @SerialName("calendar_date") CalendarDate("calendar_date"),
    @SerialName("text") Text("text");
}

@Serializable
data class Format (
    val align: String? = null,
    val view: String? = null
)

@Serializable
data class Grant (
    val flags: List<String>,
    val inherited: Boolean,
    val type: String
)

@Serializable
data class Metadata (
    val attachments: List<Attachment>,
    val availableDisplayTypes: List<String>,

    @SerialName("custom_fields")
    val customFields: CustomFields,

    val jsonQuery: JSONQuery,
    val rdfSubject: String,
    val renderTypeConfig: RenderTypeConfig
)

@Serializable
data class Attachment (
    @SerialName("assetId")
    val assetID: String,

    @SerialName("blobId")
    val blobID: String,

    val filename: String,
    val name: String
)

@Serializable
data class CustomFields (
    @SerialName("Additional Resources")
    val additionalResources: AdditionalResources,

    @SerialName("Common Core")
    val commonCore: CommonCore,

    @SerialName("Dataset Information")
    val datasetInformation: DatasetInformation,

    @SerialName("Dataset Summary")
    val datasetSummary: DatasetSummary,

    @SerialName("Notes")
    val notes: Notes
)

@Serializable
data class AdditionalResources (
    @SerialName("See Also ")
    val additionalResourcesSeeAlso: String,

    @SerialName("See Also")
    val seeAlso: String
)

@Serializable
data class CommonCore (
    @SerialName("Contact Email")
    val contactEmail: String,

    @SerialName("Contact Name")
    val contactName: String,

    @SerialName("Publisher")
    val publisher: String
)

@Serializable
data class DatasetInformation (
    @SerialName("Agency")
    val agency: String
)

@Serializable
data class DatasetSummary (
    @SerialName("Contact Information")
    val contactInformation: String,

    @SerialName("Coverage")
    val coverage: String,

    @SerialName("Data Frequency")
    val dataFrequency: String,

    @SerialName("Dataset Owner")
    val datasetOwner: String,

    @SerialName("Granularity")
    val granularity: String,

    @SerialName("Organization")
    val organization: String,

    @SerialName("Posting Frequency")
    val postingFrequency: String,

    @SerialName("Time Period")
    val timePeriod: String,

    @SerialName("Units")
    val units: String
)

@Serializable
data class Notes (
    @SerialName("Notes")
    val notes: String
)

@Serializable
data class JSONQuery (
    val order: List<Order>
)

@Serializable
data class Order (
    val ascending: Boolean,
    val columnFieldName: String
)

@Serializable
data class RenderTypeConfig (
    val visible: Visible
)

@Serializable
data class Visible (
    val table: Boolean
)

@Serializable
data class Owner (
    val displayName: String,
    val id: String,

    @SerialName("profileImageUrlLarge")
    val profileImageURLLarge: String,

    @SerialName("profileImageUrlMedium")
    val profileImageURLMedium: String,

    @SerialName("profileImageUrlSmall")
    val profileImageURLSmall: String,

    val rights: List<String>,
    val roleName: String,
    val screenName: String
)

@Serializable
data class Query (
    val orderBys: List<OrderBy>
)

@Serializable
data class OrderBy (
    val ascending: Boolean,
    val expression: Expression
)

@Serializable
data class Expression (
    @SerialName("columnId")
    val columnID: Long,

    val type: String
)
