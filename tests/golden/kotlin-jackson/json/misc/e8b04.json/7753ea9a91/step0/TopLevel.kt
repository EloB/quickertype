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
    convert(DisplayType::class,          { DisplayType.fromValue(it.asText()) },          { ObjectMapper().writeValueAsString(it.value) })
    convert(TopLevelFlag::class,         { TopLevelFlag.fromValue(it.asText()) },         { ObjectMapper().writeValueAsString(it.value) })
    convert(GrantFlag::class,            { GrantFlag.fromValue(it.asText()) },            { ObjectMapper().writeValueAsString(it.value) })
    convert(GrantType::class,            { GrantType.fromValue(it.asText()) },            { ObjectMapper().writeValueAsString(it.value) })
    convert(OrderColumnFieldName::class, { OrderColumnFieldName.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(ChildColumnFieldName::class, { ChildColumnFieldName.fromValue(it.asText()) }, { ObjectMapper().writeValueAsString(it.value) })
    convert(MetadataOperator::class,     { MetadataOperator.fromValue(it.asText()) },     { ObjectMapper().writeValueAsString(it.value) })
    convert(ChildOperator::class,        { ChildOperator.fromValue(it.asText()) },        { ObjectMapper().writeValueAsString(it.value) })
    convert(WhereOperator::class,        { WhereOperator.fromValue(it.asText()) },        { ObjectMapper().writeValueAsString(it.value) })
    convert(FieldType::class,            { FieldType.fromValue(it.asText()) },            { ObjectMapper().writeValueAsString(it.value) })
    convert(Width::class,                { Width.fromValue(it.asText()) },                { ObjectMapper().writeValueAsString(it.value) })
    convert(ModifyingViewUid::class,     { ModifyingViewUid.fromValue(it.asText()) },     { ObjectMapper().writeValueAsString(it.value) })
    convert(RoleName::class,             { RoleName.fromValue(it.asText()) },             { ObjectMapper().writeValueAsString(it.value) })
    convert(Provenance::class,           { Provenance.fromValue(it.asText()) },           { ObjectMapper().writeValueAsString(it.value) })
    convert(PublicationStage::class,     { PublicationStage.fromValue(it.asText()) },     { ObjectMapper().writeValueAsString(it.value) })
    convert(Right::class,                { Right.fromValue(it.asText()) },                { ObjectMapper().writeValueAsString(it.value) })
    convert(RowsUpdatedBy::class,        { RowsUpdatedBy.fromValue(it.asText()) },        { ObjectMapper().writeValueAsString(it.value) })
    convert(ViewType::class,             { ViewType.fromValue(it.asText()) },             { ObjectMapper().writeValueAsString(it.value) })
}

class TopLevel(elements: Collection<TopLevelElement> = emptyList()) : ArrayList<TopLevelElement>(elements) {
    fun toJson() = mapper.writeValueAsString(this)

    companion object {
        fun fromJson(json: String) = mapper.readValue<TopLevel>(json)
    }
}

data class TopLevelElement (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val averageRating: Long,

    val category: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val createdAt: Long,

    val description: String? = null,
    val displayType: DisplayType? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val downloadCount: Long,

    val flags: List<TopLevelFlag>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val grants: List<Grant>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val hideFromCatalog: Boolean,

    @get:JsonProperty("hideFromDataJson", required=true)@field:JsonProperty("hideFromDataJson", required=true)
    val hideFromDataJSON: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: String,

    val indexUpdatedAt: Long? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val locale: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val metadata: TopLevelMetadata,

    val moderationStatus: Boolean? = null,
    val modifyingViewUid: ModifyingViewUid? = null,

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
    val provenance: Provenance,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val publicationAppendEnabled: Boolean,

    val publicationDate: Long? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val publicationGroup: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val publicationStage: PublicationStage,

    val ratings: Ratings? = null,
    val resourceName: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rights: List<Right>,

    val rowClass: String? = null,

    @get:JsonProperty("rowIdentifierColumnId")@field:JsonProperty("rowIdentifierColumnId")
    val rowIdentifierColumnID: Long? = null,

    val rowsUpdatedAt: Long? = null,
    val rowsUpdatedBy: RowsUpdatedBy? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val tableAuthor: TableAuthor,

    @get:JsonProperty("tableId", required=true)@field:JsonProperty("tableId", required=true)
    val tableID: Long,

    val tags: List<String>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val totalTimesRated: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val viewCount: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val viewLastModified: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val viewType: ViewType
)

enum class DisplayType(val value: String) {
    Table("table"),
    DataLens("data_lens"),
    Fatrow("fatrow"),
    Page("page");

    companion object {
        fun fromValue(value: String): DisplayType = when (value) {
            "table"     -> Table
            "data_lens" -> DataLens
            "fatrow"    -> Fatrow
            "page"      -> Page
            else        -> throw IllegalArgumentException()
        }
    }
}

enum class TopLevelFlag(val value: String) {
    Default("default"),
    Restorable("restorable"),
    RestorePossibleForType("restorePossibleForType");

    companion object {
        fun fromValue(value: String): TopLevelFlag = when (value) {
            "default"                -> Default
            "restorable"             -> Restorable
            "restorePossibleForType" -> RestorePossibleForType
            else                     -> throw IllegalArgumentException()
        }
    }
}

data class Grant (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val flags: List<GrantFlag>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val inherited: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: GrantType
)

enum class GrantFlag(val value: String) {
    Public("public");

    companion object {
        fun fromValue(value: String): GrantFlag = when (value) {
            "public" -> Public
            else     -> throw IllegalArgumentException()
        }
    }
}

enum class GrantType(val value: String) {
    Viewer("viewer");

    companion object {
        fun fromValue(value: String): GrantType = when (value) {
            "viewer" -> Viewer
            else     -> throw IllegalArgumentException()
        }
    }
}

data class TopLevelMetadata (
    val availableDisplayTypes: List<DisplayType>? = null,

    @get:JsonProperty("custom_fields")@field:JsonProperty("custom_fields")
    val customFields: CustomFields? = null,

    val jsonQuery: JSONQuery? = null,
    val rdfClass: String? = null,
    val rdfSubject: String? = null,
    val renderTypeConfig: MetadataRenderTypeConfig? = null,
    val richRendererConfigs: RichRendererConfigs? = null,
    val rowIdentifier: String? = null,
    val rowLabel: String? = null,

    @get:JsonProperty("v1_archived_properties")@field:JsonProperty("v1_archived_properties")
    val v1ArchivedProperties: V1ArchivedProperties? = null
)

data class CustomFields (
    @get:JsonProperty("TEST", required=true)@field:JsonProperty("TEST", required=true)
    val test: Test
)

data class Test (
    @get:JsonProperty("CFPB1", required=true)@field:JsonProperty("CFPB1", required=true)
    val cfpb1: String
)

data class JSONQuery (
    val group: List<Group>? = null,
    val order: List<Order>? = null,
    val select: List<Select>? = null,
    val where: Where? = null
)

data class Group (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val columnFieldName: String
)

data class Order (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val ascending: Boolean,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val columnFieldName: OrderColumnFieldName
)

enum class OrderColumnFieldName(val value: String) {
    DateReceived("date_received"),
    AgreementDate("agreement_date"),
    InEffectAsOf1_1_2012("in_effect_as_of_1_1_2012");

    companion object {
        fun fromValue(value: String): OrderColumnFieldName = when (value) {
            "date_received"            -> DateReceived
            "agreement_date"           -> AgreementDate
            "in_effect_as_of_1_1_2012" -> InEffectAsOf1_1_2012
            else                       -> throw IllegalArgumentException()
        }
    }
}

data class Select (
    val aggregate: String? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val columnFieldName: String
)

data class Where (
    val children: List<Child>? = null,
    val columnFieldName: ChildColumnFieldName? = null,
    val metadata: ChildMetadata? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val operator: WhereOperator,

    val value: String? = null
)

data class Child (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val columnFieldName: ChildColumnFieldName,

    val metadata: ChildMetadata? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val operator: ChildOperator,

    val value: String? = null
)

enum class ChildColumnFieldName(val value: String) {
    Product("product"),
    ComplaintWhatHappened("complaint_what_happened"),
    SubProduct("sub_product"),
    Issue("issue");

    companion object {
        fun fromValue(value: String): ChildColumnFieldName = when (value) {
            "product"                 -> Product
            "complaint_what_happened" -> ComplaintWhatHappened
            "sub_product"             -> SubProduct
            "issue"                   -> Issue
            else                      -> throw IllegalArgumentException()
        }
    }
}

data class ChildMetadata (
    val customValues: List<String>? = null,
    val freeform: Boolean? = null,
    val includeAuto: Long? = null,
    val operator: MetadataOperator? = null,

    @get:JsonProperty("tableColumnId")@field:JsonProperty("tableColumnId")
    val tableColumnID: TableColumnID? = null,

    val unifiedVersion: Long? = null
)

enum class MetadataOperator(val value: String) {
    Equals("EQUALS"),
    Blank("blank?");

    companion object {
        fun fromValue(value: String): MetadataOperator = when (value) {
            "EQUALS" -> Equals
            "blank?" -> Blank
            else     -> throw IllegalArgumentException()
        }
    }
}

data class TableColumnID (
    @get:JsonProperty("2819740", required=true)@field:JsonProperty("2819740", required=true)
    val the2819740: Long
)

enum class ChildOperator(val value: String) {
    Equals("EQUALS"),
    IsNotBlank("IS_NOT_BLANK");

    companion object {
        fun fromValue(value: String): ChildOperator = when (value) {
            "EQUALS"       -> Equals
            "IS_NOT_BLANK" -> IsNotBlank
            else           -> throw IllegalArgumentException()
        }
    }
}

enum class WhereOperator(val value: String) {
    Equals("EQUALS"),
    And("AND");

    companion object {
        fun fromValue(value: String): WhereOperator = when (value) {
            "EQUALS" -> Equals
            "AND"    -> And
            else     -> throw IllegalArgumentException()
        }
    }
}

data class MetadataRenderTypeConfig (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val visible: PurpleVisible
)

data class PurpleVisible (
    val fatrow: Boolean? = null,
    val table: Boolean? = null
)

data class RichRendererConfigs (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val fatRow: FatRow
)

data class FatRow (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val columns: List<Column>
)

data class Column (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rows: List<Row>,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val styles: Styles
)

data class Row (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val fields: List<Field>
)

data class Field (
    @get:JsonProperty("tableColumnId", required=true)@field:JsonProperty("tableColumnId", required=true)
    val tableColumnID: Long,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val type: FieldType
)

enum class FieldType(val value: String) {
    ColumnLabel("columnLabel"),
    ColumnData("columnData");

    companion object {
        fun fromValue(value: String): FieldType = when (value) {
            "columnLabel" -> ColumnLabel
            "columnData"  -> ColumnData
            else          -> throw IllegalArgumentException()
        }
    }
}

data class Styles (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val width: Width
)

enum class Width(val value: String) {
    The27("27%"),
    The40("40%"),
    The30("30%"),
    The33("33%");

    companion object {
        fun fromValue(value: String): Width = when (value) {
            "27%" -> The27
            "40%" -> The40
            "30%" -> The30
            "33%" -> The33
            else  -> throw IllegalArgumentException()
        }
    }
}

data class V1ArchivedProperties (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val accessPoints: AccessPoints,

    @get:JsonProperty("blist_id", required=true)@field:JsonProperty("blist_id", required=true)
    val blistID: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val renderTypeConfig: V1ArchivedPropertiesRenderTypeConfig
)

data class AccessPoints (
    @get:JsonProperty("new_view", required=true)@field:JsonProperty("new_view", required=true)
    val newView: String
)

data class V1ArchivedPropertiesRenderTypeConfig (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val visible: FluffyVisible
)

data class FluffyVisible (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val href: Boolean
)

enum class ModifyingViewUid(val value: String) {
    S6EwH6Mp("s6ew-h6mp");

    companion object {
        fun fromValue(value: String): ModifyingViewUid = when (value) {
            "s6ew-h6mp" -> S6EwH6Mp
            else        -> throw IllegalArgumentException()
        }
    }
}

data class Owner (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val displayName: String,

    val flags: List<String>? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: String,

    val lastNotificationSeenAt: Long? = null,

    @get:JsonProperty("profileImageUrlLarge")@field:JsonProperty("profileImageUrlLarge")
    val profileImageURLLarge: String? = null,

    @get:JsonProperty("profileImageUrlMedium")@field:JsonProperty("profileImageUrlMedium")
    val profileImageURLMedium: String? = null,

    @get:JsonProperty("profileImageUrlSmall")@field:JsonProperty("profileImageUrlSmall")
    val profileImageURLSmall: String? = null,

    val rights: List<String>? = null,
    val roleName: RoleName? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val screenName: String
)

enum class RoleName(val value: String) {
    Administrator("administrator"),
    Publisher("publisher");

    companion object {
        fun fromValue(value: String): RoleName = when (value) {
            "administrator" -> Administrator
            "publisher"     -> Publisher
            else            -> throw IllegalArgumentException()
        }
    }
}

enum class Provenance(val value: String) {
    Official("official");

    companion object {
        fun fromValue(value: String): Provenance = when (value) {
            "official" -> Official
            else       -> throw IllegalArgumentException()
        }
    }
}

enum class PublicationStage(val value: String) {
    Published("published");

    companion object {
        fun fromValue(value: String): PublicationStage = when (value) {
            "published" -> Published
            else        -> throw IllegalArgumentException()
        }
    }
}

data class Ratings (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val rating: Long
)

enum class Right(val value: String) {
    Read("read");

    companion object {
        fun fromValue(value: String): Right = when (value) {
            "read" -> Read
            else   -> throw IllegalArgumentException()
        }
    }
}

enum class RowsUpdatedBy(val value: String) {
    PjxgVe4M("pjxg-ve4m"),
    The54A3Qyun("54a3-qyun"),
    The9E3M2843("9e3m-2843"),
    VvcaFr6G("vvca-fr6g");

    companion object {
        fun fromValue(value: String): RowsUpdatedBy = when (value) {
            "pjxg-ve4m" -> PjxgVe4M
            "54a3-qyun" -> The54A3Qyun
            "9e3m-2843" -> The9E3M2843
            "vvca-fr6g" -> VvcaFr6G
            else        -> throw IllegalArgumentException()
        }
    }
}

data class TableAuthor (
    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val displayName: String,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val id: String,

    val rights: List<String>? = null,
    val roleName: RoleName? = null,

    @get:JsonProperty(required=true)@field:JsonProperty(required=true)
    val screenName: String
)

enum class ViewType(val value: String) {
    Tabular("tabular");

    companion object {
        fun fromValue(value: String): ViewType = when (value) {
            "tabular" -> Tabular
            else      -> throw IllegalArgumentException()
        }
    }
}
