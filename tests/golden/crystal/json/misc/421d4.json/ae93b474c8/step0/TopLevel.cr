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

  property license : License

  @[JSON::Field(key: "licenseId")]
  property license_id : String

  property locale : String

  property metadata : Metadata

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

  @[JSON::Field(key: "rowClass")]
  property row_class : String

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

  @[JSON::Field(key: "fieldName")]
  property field_name : String

  property flags : Array(String)?

  property format : Query

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

  property largest : String?

  property non_null : Int64

  property null : Int64

  property smallest : String?

  property sum : String?

  property top : Array(Top)?
end

class Top
  include JSON::Serializable

  property count : Int64

  property item : String
end

class Query
  include JSON::Serializable

end

class Grant
  include JSON::Serializable

  property flags : Array(String)

  @[JSON::Field(key: "type")]
  property grant_type : String

  property inherited : Bool
end

class License
  include JSON::Serializable

  property name : String
end

class Metadata
  include JSON::Serializable

  @[JSON::Field(key: "availableDisplayTypes")]
  property available_display_types : Array(String)

  @[JSON::Field(key: "rdfClass")]
  property rdf_class : String

  @[JSON::Field(key: "rdfSubject")]
  property rdf_subject : String

  @[JSON::Field(key: "renderTypeConfig")]
  property render_type_config : RenderTypeConfig

  @[JSON::Field(key: "rowIdentifier")]
  property row_identifier : String
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

  @[JSON::Field(key: "screenName")]
  property screen_name : String
end

alias Datum = Int64 | String
