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
    convert(TypeName::class, { TypeName.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(Datum::class,    { Datum.fromJson(it) },              { it.toJson() }, true)
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

    fun toJson(): String = mapper.writeValueAsString(when (this) {
        is IntegerValue -> this.value
        is StringValue  -> this.value
    })

    companion object {
        fun fromJson(jn: JsonNode): Datum = when (jn) {
            is IntNode, is LongNode -> IntegerValue(mapper.convertValue(jn))
            is TextNode             -> StringValue(mapper.convertValue(jn))
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
    val averageRating: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val category: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val columns: List<Column>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val createdAt: Long,

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
    val license: License,

    @get:JsonProperty("licenseId", required=true)@field:JsonProperty("licenseId", required=true)
    val licenseID: String,

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
    val rowClass: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rowsUpdatedAt: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rowsUpdatedBy: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tableAuthor: Owner,

    @get:JsonProperty("tableId", required=true)@field:JsonProperty("tableId", required=true)
    val tableID: Long,

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
    val dataTypeName: TypeName,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val fieldName: String,

    val flags: List<String>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val format: Query,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val position: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val renderTypeName: TypeName,

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

enum class TypeName(val value: String) {
    MetaData("meta_data"),
    Number("number"),
    Text("text");

    companion object {
        fun fromValue(value: String): TypeName = when (value) {
            "meta_data" -> MetaData
            "number"    -> Number
            "text"      -> Text
            else        -> throw IllegalArgumentException()
        }
    }
}

typealias Query = ObjectNode

data class Grant (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flags: List<String>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val inherited: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: String
)

data class License (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val name: String
)

data class Metadata (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val availableDisplayTypes: List<String>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rdfClass: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rdfSubject: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val renderTypeConfig: RenderTypeConfig,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rowIdentifier: String
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

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val screenName: String
)
