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
            override fun getNullValue(ctxt: DeserializationContext) = if (isUnion) fromJson(NullNode.instance) else null
    })
})

val mapper = jacksonObjectMapper().apply {
    propertyNamingStrategy = object : PropertyNamingStrategy.PropertyNamingStrategyBase() { override fun translate(name: String) = if (name == "empty") "" else name }
    setSerializationInclusion(JsonInclude.Include.NON_NULL)
    disable(DeserializationFeature.ACCEPT_FLOAT_AS_INT)
    convert(Datum::class, { Datum.fromJson(it) }, { it.toJson() }, true)
}

data class TopLevel (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val data: List<List<Datum>>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val meta: Meta
) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

sealed class Datum {
    class IntegerValue(val value: Long)  : Datum()
    class StringValue(val value: String) : Datum()
    class NullValue()                    : Datum()

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerValue -> this.value
        is StringValue  -> this.value
        is NullValue    -> null
    })

    companion object {
        fun fromJson(jn: JsonNode): Datum = when (jn) {
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is TextNode             -> StringValue(mapper.convertValue(jn))
            is NullNode             -> NullValue()
            else                    -> throw IllegalArgumentException()
        }
    }
}

data class Meta (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val view: View
)

data class View (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val attribution: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val attributionLink: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val averageRating: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val category: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val columns: List<Column>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val createdAt: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val description: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val displayType: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val downloadCount: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flags: List<String>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val grants: List<Grant>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val hideFromCatalog: Boolean,

    @get:JsonProperty("hideFromDataJson", required=true)@field:JsonProperty("hideFromDataJson", required=true)
    val hideFromDataJSON: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val indexUpdatedAt: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val locale: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val metadata: Metadata,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val newBackend: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val numberOfComments: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val oid: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val owner: Owner,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val provenance: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val publicationAppendEnabled: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val publicationDate: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val publicationGroup: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val publicationStage: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val query: Query,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rights: List<String>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rowsUpdatedAt: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rowsUpdatedBy: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tableAuthor: Owner,

    @get:JsonProperty("tableId", required=true)@field:JsonProperty("tableId", required=true)
    val tableID: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tags: List<String>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val totalTimesRated: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val viewCount: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val viewLastModified: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val viewType: String
)

data class Column (
    val cachedContents: CachedContents? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val dataTypeName: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val fieldName: String,

    val flags: List<String>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val format: Format,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val position: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val renderTypeName: String,

    @get:JsonProperty("tableColumnId")@field:JsonProperty("tableColumnId")
    val tableColumnID: Long? = null,

    val width: Long? = null
)

data class CachedContents (
    val average: String? = null,

    @get:JsonProperty("null", required=true)@field:JsonProperty("null", required=true)
    val cachedContentsNull: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val largest: String,

    @get:JsonProperty("non_null", required=true)@field:JsonProperty("non_null", required=true)
    val nonNull: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val smallest: String,

    val sum: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val top: List<Top>
)

data class Top (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val count: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val item: String
)

data class Format (
    val align: String? = null,
    val noCommas: String? = null,
    val precisionStyle: String? = null,
    val view: String? = null
)

data class Grant (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flags: List<String>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val inherited: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: String
)

data class Metadata (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val attachments: List<Attachment>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val availableDisplayTypes: List<String>,

    @get:JsonProperty("custom_fields", required=true)@field:JsonProperty("custom_fields", required=true)
    val customFields: CustomFields,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val jsonQuery: JSONQuery,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rdfSubject: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val renderTypeConfig: RenderTypeConfig
)

data class Attachment (
    @get:JsonProperty("assetId", required=true)@field:JsonProperty("assetId", required=true)
    val assetID: String,

    @get:JsonProperty("blobId", required=true)@field:JsonProperty("blobId", required=true)
    val blobID: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val filename: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String
)

data class CustomFields (
    @get:JsonProperty("Additional Resources", required=true)@field:JsonProperty("Additional Resources", required=true)
    val additionalResources: AdditionalResources,

    @get:JsonProperty("Common Core", required=true)@field:JsonProperty("Common Core", required=true)
    val commonCore: CommonCore,

    @get:JsonProperty("Dataset Information", required=true)@field:JsonProperty("Dataset Information", required=true)
    val datasetInformation: DatasetInformation,

    @get:JsonProperty("Dataset Summary", required=true)@field:JsonProperty("Dataset Summary", required=true)
    val datasetSummary: DatasetSummary,

    @get:JsonProperty("Notes", required=true)@field:JsonProperty("Notes", required=true)
    val notes: Notes
)

data class AdditionalResources (
    @get:JsonProperty("See Also ", required=true)@field:JsonProperty("See Also ", required=true)
    val additionalResourcesSeeAlso: String,

    @get:JsonProperty("See Also", required=true)@field:JsonProperty("See Also", required=true)
    val seeAlso: String
)

data class CommonCore (
    @get:JsonProperty("Contact Email", required=true)@field:JsonProperty("Contact Email", required=true)
    val contactEmail: String,

    @get:JsonProperty("Contact Name", required=true)@field:JsonProperty("Contact Name", required=true)
    val contactName: String,

    @get:JsonProperty("Publisher", required=true)@field:JsonProperty("Publisher", required=true)
    val publisher: String
)

data class DatasetInformation (
    @get:JsonProperty("Agency", required=true)@field:JsonProperty("Agency", required=true)
    val agency: String
)

data class DatasetSummary (
    @get:JsonProperty("Contact Information", required=true)@field:JsonProperty("Contact Information", required=true)
    val contactInformation: String,

    @get:JsonProperty("Coverage", required=true)@field:JsonProperty("Coverage", required=true)
    val coverage: String,

    @get:JsonProperty("Data Frequency", required=true)@field:JsonProperty("Data Frequency", required=true)
    val dataFrequency: String,

    @get:JsonProperty("Dataset Owner", required=true)@field:JsonProperty("Dataset Owner", required=true)
    val datasetOwner: String,

    @get:JsonProperty("Granularity", required=true)@field:JsonProperty("Granularity", required=true)
    val granularity: String,

    @get:JsonProperty("Organization", required=true)@field:JsonProperty("Organization", required=true)
    val organization: String,

    @get:JsonProperty("Posting Frequency", required=true)@field:JsonProperty("Posting Frequency", required=true)
    val postingFrequency: String,

    @get:JsonProperty("Time Period", required=true)@field:JsonProperty("Time Period", required=true)
    val timePeriod: String,

    @get:JsonProperty("Units", required=true)@field:JsonProperty("Units", required=true)
    val units: String
)

data class Notes (
    @get:JsonProperty("Notes", required=true)@field:JsonProperty("Notes", required=true)
    val notes: String
)

data class JSONQuery (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val order: List<Order>
)

data class Order (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val ascending: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val columnFieldName: String
)

data class RenderTypeConfig (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val visible: Visible
)

data class Visible (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val table: Boolean
)

data class Owner (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val displayName: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: String,

    @get:JsonProperty("profileImageUrlLarge", required=true)@field:JsonProperty("profileImageUrlLarge", required=true)
    val profileImageURLLarge: String,

    @get:JsonProperty("profileImageUrlMedium", required=true)@field:JsonProperty("profileImageUrlMedium", required=true)
    val profileImageURLMedium: String,

    @get:JsonProperty("profileImageUrlSmall", required=true)@field:JsonProperty("profileImageUrlSmall", required=true)
    val profileImageURLSmall: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rights: List<String>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val roleName: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val screenName: String
)

data class Query (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val orderBys: List<OrderBy>
)

data class OrderBy (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val ascending: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val expression: Expression
)

data class Expression (
    @get:JsonProperty("columnId", required=true)@field:JsonProperty("columnId", required=true)
    val columnID: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: String
)
