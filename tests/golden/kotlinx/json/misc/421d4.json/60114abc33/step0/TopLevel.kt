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
    val license: License,

    @SerialName("licenseId")
    val licenseID: String,

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
    val rowClass: String,
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
    val dataTypeName: String,
    val fieldName: String,
    val flags: List<String>? = null,
    val format: Query,
    val id: Long,
    val name: String,
    val position: Long,
    val renderTypeName: String,

    @SerialName("tableColumnId")
    val tableColumnID: Long? = null,

    val width: Long? = null
)

@Serializable
data class CachedContents (
    val average: String? = null,

    @SerialName("null")
    val cachedContentsNull: Long,

    val largest: String? = null,

    @SerialName("non_null")
    val nonNull: Long,

    val smallest: String? = null,
    val sum: String? = null,
    val top: List<Top>? = null
)

@Serializable
data class Top (
    val count: Long,
    val item: String
)

@Serializable
class Query()

@Serializable
data class Grant (
    val flags: List<String>,
    val inherited: Boolean,
    val type: String
)

@Serializable
data class License (
    val name: String
)

@Serializable
data class Metadata (
    val availableDisplayTypes: List<String>,
    val rdfClass: String,
    val rdfSubject: String,
    val renderTypeConfig: RenderTypeConfig,
    val rowIdentifier: String
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
    val screenName: String
)
