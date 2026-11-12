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
    .convert(DisplayType::class,          { DisplayType.fromValue(it.string!!) },          { Klaxon().toJsonString(it.value) })
    .convert(TopLevelFlag::class,         { TopLevelFlag.fromValue(it.string!!) },         { Klaxon().toJsonString(it.value) })
    .convert(GrantFlag::class,            { GrantFlag.fromValue(it.string!!) },            { Klaxon().toJsonString(it.value) })
    .convert(GrantType::class,            { GrantType.fromValue(it.string!!) },            { Klaxon().toJsonString(it.value) })
    .convert(OrderColumnFieldName::class, { OrderColumnFieldName.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(ChildColumnFieldName::class, { ChildColumnFieldName.fromValue(it.string!!) }, { Klaxon().toJsonString(it.value) })
    .convert(MetadataOperator::class,     { MetadataOperator.fromValue(it.string!!) },     { Klaxon().toJsonString(it.value) })
    .convert(ChildOperator::class,        { ChildOperator.fromValue(it.string!!) },        { Klaxon().toJsonString(it.value) })
    .convert(WhereOperator::class,        { WhereOperator.fromValue(it.string!!) },        { Klaxon().toJsonString(it.value) })
    .convert(FieldType::class,            { FieldType.fromValue(it.string!!) },            { Klaxon().toJsonString(it.value) })
    .convert(Width::class,                { Width.fromValue(it.string!!) },                { Klaxon().toJsonString(it.value) })
    .convert(ModifyingViewUid::class,     { ModifyingViewUid.fromValue(it.string!!) },     { Klaxon().toJsonString(it.value) })
    .convert(RoleName::class,             { RoleName.fromValue(it.string!!) },             { Klaxon().toJsonString(it.value) })
    .convert(Provenance::class,           { Provenance.fromValue(it.string!!) },           { Klaxon().toJsonString(it.value) })
    .convert(PublicationStage::class,     { PublicationStage.fromValue(it.string!!) },     { Klaxon().toJsonString(it.value) })
    .convert(Right::class,                { Right.fromValue(it.string!!) },                { Klaxon().toJsonString(it.value) })
    .convert(RowsUpdatedBy::class,        { RowsUpdatedBy.fromValue(it.string!!) },        { Klaxon().toJsonString(it.value) })
    .convert(ViewType::class,             { ViewType.fromValue(it.string!!) },             { Klaxon().toJsonString(it.value) })

class TopLevel(elements: Collection<TopLevelElement>) : ArrayList<TopLevelElement>(elements) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = TopLevel(klaxon.parseArray<TopLevelElement>(json)!!)
    }
}

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

    @Json(name = "hideFromDataJson")
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

    @Json(name = "rowIdentifierColumnId")
    val rowIdentifierColumnID: Long? = null,

    val rowsUpdatedAt: Long? = null,
    val rowsUpdatedBy: RowsUpdatedBy? = null,
    val tableAuthor: TableAuthor,

    @Json(name = "tableId")
    val tableID: Long,

    val tags: List<String>? = null,
    val totalTimesRated: Long,
    val viewCount: Long,
    val viewLastModified: Long,
    val viewType: ViewType
)

enum class DisplayType(val value: String) {
    Table("table"),
    DataLens("data_lens"),
    Fatrow("fatrow"),
    Page("page");

    companion object {
        public fun fromValue(value: String): DisplayType = when (value) {
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
        public fun fromValue(value: String): TopLevelFlag = when (value) {
            "default"                -> Default
            "restorable"             -> Restorable
            "restorePossibleForType" -> RestorePossibleForType
            else                     -> throw IllegalArgumentException()
        }
    }
}

data class Grant (
    val flags: List<GrantFlag>,
    val inherited: Boolean,
    val type: GrantType
)

enum class GrantFlag(val value: String) {
    Public("public");

    companion object {
        public fun fromValue(value: String): GrantFlag = when (value) {
            "public" -> Public
            else     -> throw IllegalArgumentException()
        }
    }
}

enum class GrantType(val value: String) {
    Viewer("viewer");

    companion object {
        public fun fromValue(value: String): GrantType = when (value) {
            "viewer" -> Viewer
            else     -> throw IllegalArgumentException()
        }
    }
}

data class TopLevelMetadata (
    val availableDisplayTypes: List<DisplayType>? = null,

    @Json(name = "custom_fields")
    val customFields: CustomFields? = null,

    val jsonQuery: JSONQuery? = null,
    val rdfClass: String? = null,
    val rdfSubject: String? = null,
    val renderTypeConfig: MetadataRenderTypeConfig? = null,
    val richRendererConfigs: RichRendererConfigs? = null,
    val rowIdentifier: String? = null,
    val rowLabel: String? = null,

    @Json(name = "v1_archived_properties")
    val v1ArchivedProperties: V1ArchivedProperties? = null
)

data class CustomFields (
    @Json(name = "TEST")
    val test: Test
)

data class Test (
    @Json(name = "CFPB1")
    val cfpb1: String
)

data class JSONQuery (
    val group: List<Group>? = null,
    val order: List<Order>? = null,
    val select: List<Select>? = null,
    val where: Where? = null
)

data class Group (
    val columnFieldName: String
)

data class Order (
    val ascending: Boolean,
    val columnFieldName: OrderColumnFieldName
)

enum class OrderColumnFieldName(val value: String) {
    DateReceived("date_received"),
    AgreementDate("agreement_date"),
    InEffectAsOf1_1_2012("in_effect_as_of_1_1_2012");

    companion object {
        public fun fromValue(value: String): OrderColumnFieldName = when (value) {
            "date_received"            -> DateReceived
            "agreement_date"           -> AgreementDate
            "in_effect_as_of_1_1_2012" -> InEffectAsOf1_1_2012
            else                       -> throw IllegalArgumentException()
        }
    }
}

data class Select (
    val aggregate: String? = null,
    val columnFieldName: String
)

data class Where (
    val children: List<Child>? = null,
    val columnFieldName: ChildColumnFieldName? = null,
    val metadata: ChildMetadata? = null,
    val operator: WhereOperator,
    val value: String? = null
)

data class Child (
    val columnFieldName: ChildColumnFieldName,
    val metadata: ChildMetadata? = null,
    val operator: ChildOperator,
    val value: String? = null
)

enum class ChildColumnFieldName(val value: String) {
    Product("product"),
    ComplaintWhatHappened("complaint_what_happened"),
    SubProduct("sub_product"),
    Issue("issue");

    companion object {
        public fun fromValue(value: String): ChildColumnFieldName = when (value) {
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

    @Json(name = "tableColumnId")
    val tableColumnID: TableColumnID? = null,

    val unifiedVersion: Long? = null
)

enum class MetadataOperator(val value: String) {
    Equals("EQUALS"),
    Blank("blank?");

    companion object {
        public fun fromValue(value: String): MetadataOperator = when (value) {
            "EQUALS" -> Equals
            "blank?" -> Blank
            else     -> throw IllegalArgumentException()
        }
    }
}

data class TableColumnID (
    @Json(name = "2819740")
    val the2819740: Long
)

enum class ChildOperator(val value: String) {
    Equals("EQUALS"),
    IsNotBlank("IS_NOT_BLANK");

    companion object {
        public fun fromValue(value: String): ChildOperator = when (value) {
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
        public fun fromValue(value: String): WhereOperator = when (value) {
            "EQUALS" -> Equals
            "AND"    -> And
            else     -> throw IllegalArgumentException()
        }
    }
}

data class MetadataRenderTypeConfig (
    val visible: PurpleVisible
)

data class PurpleVisible (
    val fatrow: Boolean? = null,
    val table: Boolean? = null
)

data class RichRendererConfigs (
    val fatRow: FatRow
)

data class FatRow (
    val columns: List<Column>
)

data class Column (
    val rows: List<Row>,
    val styles: Styles
)

data class Row (
    val fields: List<Field>
)

data class Field (
    @Json(name = "tableColumnId")
    val tableColumnID: Long,

    val type: FieldType
)

enum class FieldType(val value: String) {
    ColumnLabel("columnLabel"),
    ColumnData("columnData");

    companion object {
        public fun fromValue(value: String): FieldType = when (value) {
            "columnLabel" -> ColumnLabel
            "columnData"  -> ColumnData
            else          -> throw IllegalArgumentException()
        }
    }
}

data class Styles (
    val width: Width
)

enum class Width(val value: String) {
    The27("27%"),
    The40("40%"),
    The30("30%"),
    The33("33%");

    companion object {
        public fun fromValue(value: String): Width = when (value) {
            "27%" -> The27
            "40%" -> The40
            "30%" -> The30
            "33%" -> The33
            else  -> throw IllegalArgumentException()
        }
    }
}

data class V1ArchivedProperties (
    val accessPoints: AccessPoints,

    @Json(name = "blist_id")
    val blistID: String,

    val renderTypeConfig: V1ArchivedPropertiesRenderTypeConfig
)

data class AccessPoints (
    @Json(name = "new_view")
    val newView: String
)

data class V1ArchivedPropertiesRenderTypeConfig (
    val visible: FluffyVisible
)

data class FluffyVisible (
    val href: Boolean
)

enum class ModifyingViewUid(val value: String) {
    S6EwH6Mp("s6ew-h6mp");

    companion object {
        public fun fromValue(value: String): ModifyingViewUid = when (value) {
            "s6ew-h6mp" -> S6EwH6Mp
            else        -> throw IllegalArgumentException()
        }
    }
}

data class Owner (
    val displayName: String,
    val flags: List<String>? = null,
    val id: String,
    val lastNotificationSeenAt: Long? = null,

    @Json(name = "profileImageUrlLarge")
    val profileImageURLLarge: String? = null,

    @Json(name = "profileImageUrlMedium")
    val profileImageURLMedium: String? = null,

    @Json(name = "profileImageUrlSmall")
    val profileImageURLSmall: String? = null,

    val rights: List<String>? = null,
    val roleName: RoleName? = null,
    val screenName: String
)

enum class RoleName(val value: String) {
    Administrator("administrator"),
    Publisher("publisher");

    companion object {
        public fun fromValue(value: String): RoleName = when (value) {
            "administrator" -> Administrator
            "publisher"     -> Publisher
            else            -> throw IllegalArgumentException()
        }
    }
}

enum class Provenance(val value: String) {
    Official("official");

    companion object {
        public fun fromValue(value: String): Provenance = when (value) {
            "official" -> Official
            else       -> throw IllegalArgumentException()
        }
    }
}

enum class PublicationStage(val value: String) {
    Published("published");

    companion object {
        public fun fromValue(value: String): PublicationStage = when (value) {
            "published" -> Published
            else        -> throw IllegalArgumentException()
        }
    }
}

data class Ratings (
    val rating: Long
)

enum class Right(val value: String) {
    Read("read");

    companion object {
        public fun fromValue(value: String): Right = when (value) {
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
        public fun fromValue(value: String): RowsUpdatedBy = when (value) {
            "pjxg-ve4m" -> PjxgVe4M
            "54a3-qyun" -> The54A3Qyun
            "9e3m-2843" -> The9E3M2843
            "vvca-fr6g" -> VvcaFr6G
            else        -> throw IllegalArgumentException()
        }
    }
}

data class TableAuthor (
    val displayName: String,
    val id: String,
    val rights: List<String>? = null,
    val roleName: RoleName? = null,
    val screenName: String
)

enum class ViewType(val value: String) {
    Tabular("tabular");

    companion object {
        public fun fromValue(value: String): ViewType = when (value) {
            "tabular" -> Tabular
            else      -> throw IllegalArgumentException()
        }
    }
}
