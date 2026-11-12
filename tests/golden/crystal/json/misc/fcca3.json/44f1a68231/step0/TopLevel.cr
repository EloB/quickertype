require "json"

class TopLevel
  include JSON::Serializable

  property data : Array(Array(Datum?))

  property meta : Meta
end

class Meta
  include JSON::Serializable

  property view : View
end

class View
  include JSON::Serializable

  property attribution : String

  @[JSON::Field(key: "averageRating")]
  property average_rating : Int64

  property category : String

  property columns : Array(Column)

  @[JSON::Field(key: "createdAt")]
  property created_at : Int64

  property description : String

  @[JSON::Field(key: "displayType")]
  property display_type : String

  @[JSON::Field(key: "downloadCount")]
  property download_count : Int64

  property flags : Array(String)

  property grants : Array(Grant)

  @[JSON::Field(key: "hideFromCatalog")]
  property hide_from_catalog : Bool

  @[JSON::Field(key: "hideFromDataJson")]
  property hide_from_data_json : Bool

  property id : String

  @[JSON::Field(key: "indexUpdatedAt")]
  property index_updated_at : Int64

  property locale : String

  property metadata : ViewMetadata

  property name : String

  @[JSON::Field(key: "newBackend")]
  property new_backend : Bool

  @[JSON::Field(key: "numberOfComments")]
  property number_of_comments : Int64

  property oid : Int64

  property owner : Owner

  property provenance : String

  @[JSON::Field(key: "publicationAppendEnabled")]
  property publication_append_enabled : Bool

  @[JSON::Field(key: "publicationDate")]
  property publication_date : Int64

  @[JSON::Field(key: "publicationGroup")]
  property publication_group : Int64

  @[JSON::Field(key: "publicationStage")]
  property publication_stage : String

  property query : Query

  property rights : Array(String)

  @[JSON::Field(key: "rowsUpdatedAt")]
  property rows_updated_at : Int64

  @[JSON::Field(key: "rowsUpdatedBy")]
  property rows_updated_by : String

  @[JSON::Field(key: "tableAuthor")]
  property table_author : Owner

  @[JSON::Field(key: "tableId")]
  property table_id : Int64

  property tags : Array(String)

  @[JSON::Field(key: "totalTimesRated")]
  property total_times_rated : Int64

  @[JSON::Field(key: "viewCount")]
  property view_count : Int64

  @[JSON::Field(key: "viewLastModified")]
  property view_last_modified : Int64

  @[JSON::Field(key: "viewType")]
  property view_type : String
end

class Column
  include JSON::Serializable

  @[JSON::Field(key: "cachedContents")]
  property cached_contents : CachedContents?

  @[JSON::Field(key: "dataTypeName")]
  property data_type_name : String

  property description : String?

  @[JSON::Field(key: "fieldName")]
  property field_name : String

  property flags : Array(String)?

  property format : Format

  property id : Int64

  property name : String

  property position : Int64

  @[JSON::Field(key: "renderTypeName")]
  property render_type_name : String

  @[JSON::Field(key: "tableColumnId")]
  property table_column_id : Int64?

  property width : Int64?
end

class CachedContents
  include JSON::Serializable

  property average : String?

  property largest : String

  property non_null : Int64

  property null : Int64

  property smallest : String

  property sum : String?

  property top : Array(Top)
end

class Top
  include JSON::Serializable

  property count : Int64

  property item : String
end

class Format
  include JSON::Serializable

  property align : String?

  @[JSON::Field(key: "noCommas")]
  property no_commas : String?

  @[JSON::Field(key: "precisionStyle")]
  property precision_style : String?
end

class Grant
  include JSON::Serializable

  property flags : Array(String)

  @[JSON::Field(key: "type")]
  property grant_type : String

  property inherited : Bool
end

class ViewMetadata
  include JSON::Serializable

  property attachments : Array(Attachment)

  @[JSON::Field(key: "availableDisplayTypes")]
  property available_display_types : Array(String)

  property custom_fields : CustomFields

  @[JSON::Field(key: "filterCondition")]
  property filter_condition : FilterCondition

  @[JSON::Field(key: "jsonQuery")]
  property json_query : JsonQuery

  @[JSON::Field(key: "rdfSubject")]
  property rdf_subject : String

  @[JSON::Field(key: "renderTypeConfig")]
  property render_type_config : RenderTypeConfig

  @[JSON::Field(key: "rowLabel")]
  property row_label : String
end

class Attachment
  include JSON::Serializable

  @[JSON::Field(key: "assetId")]
  property asset_id : String

  @[JSON::Field(key: "blobId")]
  property blob_id : String

  property filename : String

  property name : String
end

class CustomFields
  include JSON::Serializable

  @[JSON::Field(key: "Common Core")]
  property common_core : CommonCore

  @[JSON::Field(key: "Dataset Information")]
  property dataset_information : DatasetInformation

  @[JSON::Field(key: "Dataset Summary")]
  property dataset_summary : DatasetSummary

  @[JSON::Field(key: "Disclaimers")]
  property disclaimers : Disclaimers
end

class CommonCore
  include JSON::Serializable

  @[JSON::Field(key: "Contact Email")]
  property contact_email : String

  @[JSON::Field(key: "Contact Name")]
  property contact_name : String

  @[JSON::Field(key: "Publisher")]
  property publisher : String
end

class DatasetInformation
  include JSON::Serializable

  @[JSON::Field(key: "Agency")]
  property agency : String
end

class DatasetSummary
  include JSON::Serializable

  @[JSON::Field(key: "Contact Information")]
  property contact_information : String

  @[JSON::Field(key: "Coverage")]
  property coverage : String

  @[JSON::Field(key: "Granularity")]
  property granularity : String

  @[JSON::Field(key: "Organization")]
  property organization : String

  @[JSON::Field(key: "Posting Frequency")]
  property posting_frequency : String

  @[JSON::Field(key: "Time Period")]
  property time_period : String
end

class Disclaimers
  include JSON::Serializable

  @[JSON::Field(key: "Disclaimer")]
  property disclaimer : String

  @[JSON::Field(key: "Limitations")]
  property limitations : String
end

class FilterCondition
  include JSON::Serializable

  property children : Array(Child)

  @[JSON::Field(key: "type")]
  property filter_condition_type : String

  property metadata : FilterConditionMetadata

  property value : String
end

class Child
  include JSON::Serializable

  @[JSON::Field(key: "type")]
  property child_type : String

  property metadata : ChildMetadata

  property value : String
end

class ChildMetadata
  include JSON::Serializable

  @[JSON::Field(key: "customValues")]
  property custom_values : Array(Array(String))

  property operator : String

  @[JSON::Field(key: "tableColumnId")]
  property table_column_id : TableColumnId
end

class TableColumnId
  include JSON::Serializable

  @[JSON::Field(key: "703610")]
  property the_703610 : Int64
end

class FilterConditionMetadata
  include JSON::Serializable

  property advanced : Bool

  @[JSON::Field(key: "unifiedVersion")]
  property unified_version : Int64
end

class JsonQuery
  include JSON::Serializable

  property order : Array(Order)
end

class Order
  include JSON::Serializable

  property ascending : Bool

  @[JSON::Field(key: "columnFieldName")]
  property column_field_name : String
end

class RenderTypeConfig
  include JSON::Serializable

  property visible : Visible
end

class Visible
  include JSON::Serializable

  property table : Bool
end

class Owner
  include JSON::Serializable

  @[JSON::Field(key: "displayName")]
  property display_name : String

  property id : String

  @[JSON::Field(key: "profileImageUrlLarge")]
  property profile_image_url_large : String

  @[JSON::Field(key: "profileImageUrlMedium")]
  property profile_image_url_medium : String

  @[JSON::Field(key: "profileImageUrlSmall")]
  property profile_image_url_small : String

  property rights : Array(String)

  @[JSON::Field(key: "roleName")]
  property role_name : String

  @[JSON::Field(key: "screenName")]
  property screen_name : String
end

class Query
  include JSON::Serializable

  @[JSON::Field(key: "orderBys")]
  property order_bys : Array(OrderBy)
end

class OrderBy
  include JSON::Serializable

  property ascending : Bool

  property expression : Expression
end

class Expression
  include JSON::Serializable

  @[JSON::Field(key: "columnId")]
  property column_id : Int64

  @[JSON::Field(key: "type")]
  property expression_type : String
end

alias Datum = Int64 | String
