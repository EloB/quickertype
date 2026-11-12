require "json"

alias TopLevel = Array(TopLevelElement)

class TopLevelElement
  include JSON::Serializable

  @[JSON::Field(key: "averageRating")]
  property average_rating : Int64

  property category : String?

  @[JSON::Field(key: "createdAt")]
  property created_at : Int64

  property description : String?

  @[JSON::Field(key: "displayType")]
  property display_type : String?

  @[JSON::Field(key: "downloadCount")]
  property download_count : Int64

  property flags : Array(String)?

  property grants : Array(Grant)

  @[JSON::Field(key: "hideFromCatalog")]
  property hide_from_catalog : Bool

  @[JSON::Field(key: "hideFromDataJson")]
  property hide_from_data_json : Bool

  property id : String

  @[JSON::Field(key: "indexUpdatedAt")]
  property index_updated_at : Int64?

  property locale : String

  property metadata : TopLevelMetadata

  @[JSON::Field(key: "moderationStatus")]
  property moderation_status : Bool?

  @[JSON::Field(key: "modifyingViewUid")]
  property modifying_view_uid : String?

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
  property publication_date : Int64?

  @[JSON::Field(key: "publicationGroup")]
  property publication_group : Int64

  @[JSON::Field(key: "publicationStage")]
  property publication_stage : String

  property ratings : Ratings?

  @[JSON::Field(key: "resourceName")]
  property resource_name : String?

  property rights : Array(String)

  @[JSON::Field(key: "rowClass")]
  property row_class : String?

  @[JSON::Field(key: "rowIdentifierColumnId")]
  property row_identifier_column_id : Int64?

  @[JSON::Field(key: "rowsUpdatedAt")]
  property rows_updated_at : Int64?

  @[JSON::Field(key: "rowsUpdatedBy")]
  property rows_updated_by : String?

  @[JSON::Field(key: "tableAuthor")]
  property table_author : TableAuthor

  @[JSON::Field(key: "tableId")]
  property table_id : Int64

  property tags : Array(String)?

  @[JSON::Field(key: "totalTimesRated")]
  property total_times_rated : Int64

  @[JSON::Field(key: "viewCount")]
  property view_count : Int64

  @[JSON::Field(key: "viewLastModified")]
  property view_last_modified : Int64

  @[JSON::Field(key: "viewType")]
  property view_type : String
end

class Grant
  include JSON::Serializable

  property flags : Array(String)

  @[JSON::Field(key: "type")]
  property grant_type : String

  property inherited : Bool
end

class TopLevelMetadata
  include JSON::Serializable

  @[JSON::Field(key: "availableDisplayTypes")]
  property available_display_types : Array(String)?

  property custom_fields : CustomFields?

  @[JSON::Field(key: "jsonQuery")]
  property json_query : JsonQuery?

  @[JSON::Field(key: "rdfClass")]
  property rdf_class : String?

  @[JSON::Field(key: "rdfSubject")]
  property rdf_subject : String?

  @[JSON::Field(key: "renderTypeConfig")]
  property render_type_config : MetadataRenderTypeConfig?

  @[JSON::Field(key: "richRendererConfigs")]
  property rich_renderer_configs : RichRendererConfigs?

  @[JSON::Field(key: "rowIdentifier")]
  property row_identifier : String?

  @[JSON::Field(key: "rowLabel")]
  property row_label : String?

  property v1_archived_properties : V1ArchivedProperties?
end

class CustomFields
  include JSON::Serializable

  @[JSON::Field(key: "TEST")]
  property test : Test
end

class Test
  include JSON::Serializable

  @[JSON::Field(key: "CFPB1")]
  property cfpb1 : String
end

class JsonQuery
  include JSON::Serializable

  property group : Array(Group)?

  @[JSON::Field(key: "select")]
  property json_query_select : Array(Select)?

  property order : Array(Order)?

  property where : Where?
end

class Group
  include JSON::Serializable

  @[JSON::Field(key: "columnFieldName")]
  property column_field_name : String
end

class Select
  include JSON::Serializable

  property aggregate : String?

  @[JSON::Field(key: "columnFieldName")]
  property column_field_name : String
end

class Order
  include JSON::Serializable

  property ascending : Bool

  @[JSON::Field(key: "columnFieldName")]
  property column_field_name : String
end

class Where
  include JSON::Serializable

  property children : Array(Child)?

  @[JSON::Field(key: "columnFieldName")]
  property column_field_name : String?

  property metadata : ChildMetadata?

  property operator : String

  property value : String?
end

class Child
  include JSON::Serializable

  @[JSON::Field(key: "columnFieldName")]
  property column_field_name : String

  property metadata : ChildMetadata?

  property operator : String

  property value : String?
end

class ChildMetadata
  include JSON::Serializable

  @[JSON::Field(key: "customValues")]
  property custom_values : Array(String)?

  property freeform : Bool?

  @[JSON::Field(key: "includeAuto")]
  property include_auto : Int64?

  property operator : String?

  @[JSON::Field(key: "tableColumnId")]
  property table_column_id : TableColumnId?

  @[JSON::Field(key: "unifiedVersion")]
  property unified_version : Int64?
end

class TableColumnId
  include JSON::Serializable

  @[JSON::Field(key: "2819740")]
  property the_2819740 : Int64
end

class MetadataRenderTypeConfig
  include JSON::Serializable

  property visible : PurpleVisible
end

class PurpleVisible
  include JSON::Serializable

  property fatrow : Bool?

  property table : Bool?
end

class RichRendererConfigs
  include JSON::Serializable

  @[JSON::Field(key: "fatRow")]
  property fat_row : FatRow
end

class FatRow
  include JSON::Serializable

  property columns : Array(Column)
end

class Column
  include JSON::Serializable

  property rows : Array(Row)

  property styles : Styles
end

class Row
  include JSON::Serializable

  property fields : Array(Field)
end

class Field
  include JSON::Serializable

  @[JSON::Field(key: "type")]
  property field_type : String

  @[JSON::Field(key: "tableColumnId")]
  property table_column_id : Int64
end

class Styles
  include JSON::Serializable

  property width : String
end

class V1ArchivedProperties
  include JSON::Serializable

  @[JSON::Field(key: "accessPoints")]
  property access_points : AccessPoints

  property blist_id : String

  @[JSON::Field(key: "renderTypeConfig")]
  property render_type_config : V1ArchivedPropertiesRenderTypeConfig
end

class AccessPoints
  include JSON::Serializable

  property new_view : String
end

class V1ArchivedPropertiesRenderTypeConfig
  include JSON::Serializable

  property visible : FluffyVisible
end

class FluffyVisible
  include JSON::Serializable

  property href : Bool
end

class Owner
  include JSON::Serializable

  @[JSON::Field(key: "displayName")]
  property display_name : String

  property flags : Array(String)?

  property id : String

  @[JSON::Field(key: "lastNotificationSeenAt")]
  property last_notification_seen_at : Int64?

  @[JSON::Field(key: "profileImageUrlLarge")]
  property profile_image_url_large : String?

  @[JSON::Field(key: "profileImageUrlMedium")]
  property profile_image_url_medium : String?

  @[JSON::Field(key: "profileImageUrlSmall")]
  property profile_image_url_small : String?

  property rights : Array(String)?

  @[JSON::Field(key: "roleName")]
  property role_name : String?

  @[JSON::Field(key: "screenName")]
  property screen_name : String
end

class Ratings
  include JSON::Serializable

  property rating : Int64
end

class TableAuthor
  include JSON::Serializable

  @[JSON::Field(key: "displayName")]
  property display_name : String

  property id : String

  property rights : Array(String)?

  @[JSON::Field(key: "roleName")]
  property role_name : String?

  @[JSON::Field(key: "screenName")]
  property screen_name : String
end
