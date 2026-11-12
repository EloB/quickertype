# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "[…]"
#   puts top_level.first.tags&.first
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer              = Strict::Integer
  Bool                 = Strict::Bool
  Hash                 = Strict::Hash
  String               = Strict::String
  DisplayType          = Strict::String.enum("table", "data_lens", "fatrow", "page")
  TopLevelFlag         = Strict::String.enum("default", "restorable", "restorePossibleForType")
  GrantFlag            = Strict::String.enum("public")
  GrantType            = Strict::String.enum("viewer")
  OrderColumnFieldName = Strict::String.enum("date_received", "agreement_date", "in_effect_as_of_1_1_2012")
  ChildColumnFieldName = Strict::String.enum("product", "complaint_what_happened", "sub_product", "issue")
  MetadataOperator     = Strict::String.enum("EQUALS", "blank?")
  ChildOperator        = Strict::String.enum("EQUALS", "IS_NOT_BLANK")
  WhereOperator        = Strict::String.enum("EQUALS", "AND")
  FieldType            = Strict::String.enum("columnLabel", "columnData")
  Width                = Strict::String.enum("27%", "40%", "30%", "33%")
  ModifyingViewUid     = Strict::String.enum("s6ew-h6mp")
  RoleName             = Strict::String.enum("administrator", "publisher")
  Provenance           = Strict::String.enum("official")
  PublicationStage     = Strict::String.enum("published")
  Right                = Strict::String.enum("read")
  RowsUpdatedBy        = Strict::String.enum("pjxg-ve4m", "54a3-qyun", "9e3m-2843", "vvca-fr6g")
  ViewType             = Strict::String.enum("tabular")
end

module DisplayType
  Table    = "table"
  DataLens = "data_lens"
  Fatrow   = "fatrow"
  Page     = "page"
end

module TopLevelFlag
  Default                = "default"
  Restorable             = "restorable"
  RestorePossibleForType = "restorePossibleForType"
end

module GrantFlag
  Public = "public"
end

module GrantType
  Viewer = "viewer"
end

class Grant < Dry::Struct
  attribute :flags,      Types.Array(Types::GrantFlag)
  attribute :grant_type, Types::GrantType
  attribute :inherited,  Types::Bool

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      flags:      d.fetch("flags"),
      grant_type: d.fetch("type"),
      inherited:  d.fetch("inherited"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "flags"     => flags,
      "type"      => grant_type,
      "inherited" => inherited,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Test < Dry::Struct
  attribute :cfpb1, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      cfpb1: d.fetch("CFPB1"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "CFPB1" => cfpb1,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class CustomFields < Dry::Struct
  attribute :custom_fields_test, Test

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      custom_fields_test: Test.from_dynamic!(d.fetch("TEST")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "TEST" => custom_fields_test.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Group < Dry::Struct
  attribute :column_field_name, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      column_field_name: d.fetch("columnFieldName"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "columnFieldName" => column_field_name,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Select < Dry::Struct
  attribute :aggregate,         Types::String.optional
  attribute :column_field_name, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      aggregate:         d.key?("aggregate") ? Types::String[d["aggregate"]] : nil,
      column_field_name: d.fetch("columnFieldName"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "aggregate"       => aggregate,
      "columnFieldName" => column_field_name,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module OrderColumnFieldName
  DateReceived         = "date_received"
  AgreementDate        = "agreement_date"
  InEffectAsOf1_1_2012 = "in_effect_as_of_1_1_2012"
end

class Order < Dry::Struct
  attribute :ascending,         Types::Bool
  attribute :column_field_name, Types::OrderColumnFieldName

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      ascending:         d.fetch("ascending"),
      column_field_name: d.fetch("columnFieldName"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "ascending"       => ascending,
      "columnFieldName" => column_field_name,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module ChildColumnFieldName
  Product               = "product"
  ComplaintWhatHappened = "complaint_what_happened"
  SubProduct            = "sub_product"
  Issue                 = "issue"
end

module MetadataOperator
  Equals = "EQUALS"
  Blank  = "blank?"
end

class TableColumnID < Dry::Struct
  attribute :the_2819740, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      the_2819740: d.fetch("2819740"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "2819740" => the_2819740,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ChildMetadata < Dry::Struct
  attribute :custom_values,   Types.Array(Types::String).optional
  attribute :freeform,        Types::Bool.optional
  attribute :include_auto,    Types::Integer.optional
  attribute :operator,        Types::MetadataOperator.optional
  attribute :table_column_id, TableColumnID.optional
  attribute :unified_version, Types::Integer.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      custom_values:   d.key?("customValues") ? d["customValues"].map { |x| Types::String[x] } : nil,
      freeform:        d.key?("freeform") ? Types::Bool[d["freeform"]] : nil,
      include_auto:    d.key?("includeAuto") ? Types::Integer[d["includeAuto"]] : nil,
      operator:        d.key?("operator") ? Types::MetadataOperator[d["operator"]] : nil,
      table_column_id: d.key?("tableColumnId") ? TableColumnID.from_dynamic!(d["tableColumnId"]) : nil,
      unified_version: d.key?("unifiedVersion") ? Types::Integer[d["unifiedVersion"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "customValues"   => custom_values,
      "freeform"       => freeform,
      "includeAuto"    => include_auto,
      "operator"       => operator,
      "tableColumnId"  => table_column_id&.to_dynamic,
      "unifiedVersion" => unified_version,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module ChildOperator
  Equals     = "EQUALS"
  IsNotBlank = "IS_NOT_BLANK"
end

class Child < Dry::Struct
  attribute :column_field_name, Types::ChildColumnFieldName
  attribute :metadata,          ChildMetadata.optional
  attribute :operator,          Types::ChildOperator
  attribute :value,             Types::String.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      column_field_name: d.fetch("columnFieldName"),
      metadata:          d.key?("metadata") ? ChildMetadata.from_dynamic!(d["metadata"]) : nil,
      operator:          d.fetch("operator"),
      value:             d.key?("value") ? Types::String[d["value"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "columnFieldName" => column_field_name,
      "metadata"        => metadata&.to_dynamic,
      "operator"        => operator,
      "value"           => value,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module WhereOperator
  Equals = "EQUALS"
  And    = "AND"
end

class Where < Dry::Struct
  attribute :children,          Types.Array(Child).optional
  attribute :column_field_name, Types::ChildColumnFieldName.optional
  attribute :metadata,          ChildMetadata.optional
  attribute :operator,          Types::WhereOperator
  attribute :value,             Types::String.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      children:          d.key?("children") ? d["children"].map { |x| Child.from_dynamic!(x) } : nil,
      column_field_name: d.key?("columnFieldName") ? Types::ChildColumnFieldName[d["columnFieldName"]] : nil,
      metadata:          d.key?("metadata") ? ChildMetadata.from_dynamic!(d["metadata"]) : nil,
      operator:          d.fetch("operator"),
      value:             d.key?("value") ? Types::String[d["value"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "children"        => children&.map { |x| x.to_dynamic },
      "columnFieldName" => column_field_name,
      "metadata"        => metadata&.to_dynamic,
      "operator"        => operator,
      "value"           => value,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JSONQuery < Dry::Struct
  attribute :group,             Types.Array(Group).optional
  attribute :json_query_select, Types.Array(Select).optional
  attribute :order,             Types.Array(Order).optional
  attribute :where,             Where.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      group:             d.key?("group") ? d["group"].map { |x| Group.from_dynamic!(x) } : nil,
      json_query_select: d.key?("select") ? d["select"].map { |x| Select.from_dynamic!(x) } : nil,
      order:             d.key?("order") ? d["order"].map { |x| Order.from_dynamic!(x) } : nil,
      where:             d.key?("where") ? Where.from_dynamic!(d["where"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "group"  => group&.map { |x| x.to_dynamic },
      "select" => json_query_select&.map { |x| x.to_dynamic },
      "order"  => order&.map { |x| x.to_dynamic },
      "where"  => where&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Visible1 < Dry::Struct
  attribute :fatrow, Types::Bool.optional
  attribute :table,  Types::Bool.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      fatrow: d.key?("fatrow") ? Types::Bool[d["fatrow"]] : nil,
      table:  d.key?("table") ? Types::Bool[d["table"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "fatrow" => fatrow,
      "table"  => table,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class MetadataRenderTypeConfig < Dry::Struct
  attribute :visible, Visible1

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      visible: Visible1.from_dynamic!(d.fetch("visible")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "visible" => visible.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module FieldType
  ColumnLabel = "columnLabel"
  ColumnData  = "columnData"
end

class Field < Dry::Struct
  attribute :field_type,      Types::FieldType
  attribute :table_column_id, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      field_type:      d.fetch("type"),
      table_column_id: d.fetch("tableColumnId"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "type"          => field_type,
      "tableColumnId" => table_column_id,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Row < Dry::Struct
  attribute :fields, Types.Array(Field)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      fields: d.fetch("fields").map { |x| Field.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "fields" => fields.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module Width
  The27 = "27%"
  The40 = "40%"
  The30 = "30%"
  The33 = "33%"
end

class Styles < Dry::Struct
  attribute :width, Types::Width

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      width: d.fetch("width"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "width" => width,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Column < Dry::Struct
  attribute :rows,   Types.Array(Row)
  attribute :styles, Styles

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      rows:   d.fetch("rows").map { |x| Row.from_dynamic!(x) },
      styles: Styles.from_dynamic!(d.fetch("styles")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "rows"   => rows.map { |x| x.to_dynamic },
      "styles" => styles.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class FatRow < Dry::Struct
  attribute :columns, Types.Array(Column)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      columns: d.fetch("columns").map { |x| Column.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "columns" => columns.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class RichRendererConfigs < Dry::Struct
  attribute :fat_row, FatRow

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      fat_row: FatRow.from_dynamic!(d.fetch("fatRow")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "fatRow" => fat_row.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class AccessPoints < Dry::Struct
  attribute :new_view, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      new_view: d.fetch("new_view"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "new_view" => new_view,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Visible2 < Dry::Struct
  attribute :href, Types::Bool

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      href: d.fetch("href"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "href" => href,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class V1ArchivedPropertiesRenderTypeConfig < Dry::Struct
  attribute :visible, Visible2

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      visible: Visible2.from_dynamic!(d.fetch("visible")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "visible" => visible.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class V1ArchivedProperties < Dry::Struct
  attribute :access_points,      AccessPoints
  attribute :blist_id,           Types::String
  attribute :render_type_config, V1ArchivedPropertiesRenderTypeConfig

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      access_points:      AccessPoints.from_dynamic!(d.fetch("accessPoints")),
      blist_id:           d.fetch("blist_id"),
      render_type_config: V1ArchivedPropertiesRenderTypeConfig.from_dynamic!(d.fetch("renderTypeConfig")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "accessPoints"     => access_points.to_dynamic,
      "blist_id"         => blist_id,
      "renderTypeConfig" => render_type_config.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevelMetadata < Dry::Struct
  attribute :available_display_types, Types.Array(Types::DisplayType).optional
  attribute :custom_fields,           CustomFields.optional
  attribute :json_query,              JSONQuery.optional
  attribute :rdf_class,               Types::String.optional
  attribute :rdf_subject,             Types::String.optional
  attribute :render_type_config,      MetadataRenderTypeConfig.optional
  attribute :rich_renderer_configs,   RichRendererConfigs.optional
  attribute :row_identifier,          Types::String.optional
  attribute :row_label,               Types::String.optional
  attribute :v1_archived_properties,  V1ArchivedProperties.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      available_display_types: d.key?("availableDisplayTypes") ? d["availableDisplayTypes"].map { |x| Types::DisplayType[x] } : nil,
      custom_fields:           d.key?("custom_fields") ? CustomFields.from_dynamic!(d["custom_fields"]) : nil,
      json_query:              d.key?("jsonQuery") ? JSONQuery.from_dynamic!(d["jsonQuery"]) : nil,
      rdf_class:               d.key?("rdfClass") ? Types::String[d["rdfClass"]] : nil,
      rdf_subject:             d.key?("rdfSubject") ? Types::String[d["rdfSubject"]] : nil,
      render_type_config:      d.key?("renderTypeConfig") ? MetadataRenderTypeConfig.from_dynamic!(d["renderTypeConfig"]) : nil,
      rich_renderer_configs:   d.key?("richRendererConfigs") ? RichRendererConfigs.from_dynamic!(d["richRendererConfigs"]) : nil,
      row_identifier:          d.key?("rowIdentifier") ? Types::String[d["rowIdentifier"]] : nil,
      row_label:               d.key?("rowLabel") ? Types::String[d["rowLabel"]] : nil,
      v1_archived_properties:  d.key?("v1_archived_properties") ? V1ArchivedProperties.from_dynamic!(d["v1_archived_properties"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "availableDisplayTypes"  => available_display_types,
      "custom_fields"          => custom_fields&.to_dynamic,
      "jsonQuery"              => json_query&.to_dynamic,
      "rdfClass"               => rdf_class,
      "rdfSubject"             => rdf_subject,
      "renderTypeConfig"       => render_type_config&.to_dynamic,
      "richRendererConfigs"    => rich_renderer_configs&.to_dynamic,
      "rowIdentifier"          => row_identifier,
      "rowLabel"               => row_label,
      "v1_archived_properties" => v1_archived_properties&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module ModifyingViewUid
  S6EwH6Mp = "s6ew-h6mp"
end

module RoleName
  Administrator = "administrator"
  Publisher     = "publisher"
end

class Owner < Dry::Struct
  attribute :display_name,              Types::String
  attribute :flags,                     Types.Array(Types::String).optional
  attribute :id,                        Types::String
  attribute :last_notification_seen_at, Types::Integer.optional
  attribute :profile_image_url_large,   Types::String.optional
  attribute :profile_image_url_medium,  Types::String.optional
  attribute :profile_image_url_small,   Types::String.optional
  attribute :rights,                    Types.Array(Types::String).optional
  attribute :role_name,                 Types::RoleName.optional
  attribute :screen_name,               Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      display_name:              d.fetch("displayName"),
      flags:                     d.key?("flags") ? d["flags"].map { |x| Types::String[x] } : nil,
      id:                        d.fetch("id"),
      last_notification_seen_at: d.key?("lastNotificationSeenAt") ? Types::Integer[d["lastNotificationSeenAt"]] : nil,
      profile_image_url_large:   d.key?("profileImageUrlLarge") ? Types::String[d["profileImageUrlLarge"]] : nil,
      profile_image_url_medium:  d.key?("profileImageUrlMedium") ? Types::String[d["profileImageUrlMedium"]] : nil,
      profile_image_url_small:   d.key?("profileImageUrlSmall") ? Types::String[d["profileImageUrlSmall"]] : nil,
      rights:                    d.key?("rights") ? d["rights"].map { |x| Types::String[x] } : nil,
      role_name:                 d.key?("roleName") ? Types::RoleName[d["roleName"]] : nil,
      screen_name:               d.fetch("screenName"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "displayName"            => display_name,
      "flags"                  => flags,
      "id"                     => id,
      "lastNotificationSeenAt" => last_notification_seen_at,
      "profileImageUrlLarge"   => profile_image_url_large,
      "profileImageUrlMedium"  => profile_image_url_medium,
      "profileImageUrlSmall"   => profile_image_url_small,
      "rights"                 => rights,
      "roleName"               => role_name,
      "screenName"             => screen_name,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module Provenance
  Official = "official"
end

module PublicationStage
  Published = "published"
end

class Ratings < Dry::Struct
  attribute :rating, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      rating: d.fetch("rating"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "rating" => rating,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module Right
  Read = "read"
end

module RowsUpdatedBy
  PjxgVe4M    = "pjxg-ve4m"
  The54A3Qyun = "54a3-qyun"
  The9E3M2843 = "9e3m-2843"
  VvcaFr6G    = "vvca-fr6g"
end

class TableAuthor < Dry::Struct
  attribute :display_name, Types::String
  attribute :id,           Types::String
  attribute :rights,       Types.Array(Types::String).optional
  attribute :role_name,    Types::RoleName.optional
  attribute :screen_name,  Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      display_name: d.fetch("displayName"),
      id:           d.fetch("id"),
      rights:       d.key?("rights") ? d["rights"].map { |x| Types::String[x] } : nil,
      role_name:    d.key?("roleName") ? Types::RoleName[d["roleName"]] : nil,
      screen_name:  d.fetch("screenName"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "displayName" => display_name,
      "id"          => id,
      "rights"      => rights,
      "roleName"    => role_name,
      "screenName"  => screen_name,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module ViewType
  Tabular = "tabular"
end

class TopLevelElement < Dry::Struct
  attribute :average_rating,             Types::Integer
  attribute :category,                   Types::String.optional
  attribute :created_at,                 Types::Integer
  attribute :description,                Types::String.optional
  attribute :display_type,               Types::DisplayType.optional
  attribute :download_count,             Types::Integer
  attribute :flags,                      Types.Array(Types::TopLevelFlag).optional
  attribute :grants,                     Types.Array(Grant)
  attribute :hide_from_catalog,          Types::Bool
  attribute :hide_from_data_json,        Types::Bool
  attribute :id,                         Types::String
  attribute :index_updated_at,           Types::Integer.optional
  attribute :locale,                     Types::String
  attribute :metadata,                   TopLevelMetadata
  attribute :moderation_status,          Types::Bool.optional
  attribute :modifying_view_uid,         Types::ModifyingViewUid.optional
  attribute :new_backend,                Types::Bool
  attribute :number_of_comments,         Types::Integer
  attribute :oid,                        Types::Integer
  attribute :owner,                      Owner
  attribute :provenance,                 Types::Provenance
  attribute :publication_append_enabled, Types::Bool
  attribute :publication_date,           Types::Integer.optional
  attribute :publication_group,          Types::Integer
  attribute :publication_stage,          Types::PublicationStage
  attribute :ratings,                    Ratings.optional
  attribute :resource_name,              Types::String.optional
  attribute :rights,                     Types.Array(Types::Right)
  attribute :row_class,                  Types::String.optional
  attribute :row_identifier_column_id,   Types::Integer.optional
  attribute :rows_updated_at,            Types::Integer.optional
  attribute :rows_updated_by,            Types::RowsUpdatedBy.optional
  attribute :table_author,               TableAuthor
  attribute :table_id,                   Types::Integer
  attribute :tags,                       Types.Array(Types::String).optional
  attribute :top_level_name,             Types::String
  attribute :total_times_rated,          Types::Integer
  attribute :view_count,                 Types::Integer
  attribute :view_last_modified,         Types::Integer
  attribute :view_type,                  Types::ViewType

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      average_rating:             d.fetch("averageRating"),
      category:                   d.key?("category") ? Types::String[d["category"]] : nil,
      created_at:                 d.fetch("createdAt"),
      description:                d.key?("description") ? Types::String[d["description"]] : nil,
      display_type:               d.key?("displayType") ? Types::DisplayType[d["displayType"]] : nil,
      download_count:             d.fetch("downloadCount"),
      flags:                      d.key?("flags") ? d["flags"].map { |x| Types::TopLevelFlag[x] } : nil,
      grants:                     d.fetch("grants").map { |x| Grant.from_dynamic!(x) },
      hide_from_catalog:          d.fetch("hideFromCatalog"),
      hide_from_data_json:        d.fetch("hideFromDataJson"),
      id:                         d.fetch("id"),
      index_updated_at:           d.key?("indexUpdatedAt") ? Types::Integer[d["indexUpdatedAt"]] : nil,
      locale:                     d.fetch("locale"),
      metadata:                   TopLevelMetadata.from_dynamic!(d.fetch("metadata")),
      moderation_status:          d.key?("moderationStatus") ? Types::Bool[d["moderationStatus"]] : nil,
      modifying_view_uid:         d.key?("modifyingViewUid") ? Types::ModifyingViewUid[d["modifyingViewUid"]] : nil,
      new_backend:                d.fetch("newBackend"),
      number_of_comments:         d.fetch("numberOfComments"),
      oid:                        d.fetch("oid"),
      owner:                      Owner.from_dynamic!(d.fetch("owner")),
      provenance:                 d.fetch("provenance"),
      publication_append_enabled: d.fetch("publicationAppendEnabled"),
      publication_date:           d.key?("publicationDate") ? Types::Integer[d["publicationDate"]] : nil,
      publication_group:          d.fetch("publicationGroup"),
      publication_stage:          d.fetch("publicationStage"),
      ratings:                    d.key?("ratings") ? Ratings.from_dynamic!(d["ratings"]) : nil,
      resource_name:              d.key?("resourceName") ? Types::String[d["resourceName"]] : nil,
      rights:                     d.fetch("rights"),
      row_class:                  d.key?("rowClass") ? Types::String[d["rowClass"]] : nil,
      row_identifier_column_id:   d.key?("rowIdentifierColumnId") ? Types::Integer[d["rowIdentifierColumnId"]] : nil,
      rows_updated_at:            d.key?("rowsUpdatedAt") ? Types::Integer[d["rowsUpdatedAt"]] : nil,
      rows_updated_by:            d.key?("rowsUpdatedBy") ? Types::RowsUpdatedBy[d["rowsUpdatedBy"]] : nil,
      table_author:               TableAuthor.from_dynamic!(d.fetch("tableAuthor")),
      table_id:                   d.fetch("tableId"),
      tags:                       d.key?("tags") ? d["tags"].map { |x| Types::String[x] } : nil,
      top_level_name:             d.fetch("name"),
      total_times_rated:          d.fetch("totalTimesRated"),
      view_count:                 d.fetch("viewCount"),
      view_last_modified:         d.fetch("viewLastModified"),
      view_type:                  d.fetch("viewType"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "averageRating"            => average_rating,
      "category"                 => category,
      "createdAt"                => created_at,
      "description"              => description,
      "displayType"              => display_type,
      "downloadCount"            => download_count,
      "flags"                    => flags,
      "grants"                   => grants.map { |x| x.to_dynamic },
      "hideFromCatalog"          => hide_from_catalog,
      "hideFromDataJson"         => hide_from_data_json,
      "id"                       => id,
      "indexUpdatedAt"           => index_updated_at,
      "locale"                   => locale,
      "metadata"                 => metadata.to_dynamic,
      "moderationStatus"         => moderation_status,
      "modifyingViewUid"         => modifying_view_uid,
      "newBackend"               => new_backend,
      "numberOfComments"         => number_of_comments,
      "oid"                      => oid,
      "owner"                    => owner.to_dynamic,
      "provenance"               => provenance,
      "publicationAppendEnabled" => publication_append_enabled,
      "publicationDate"          => publication_date,
      "publicationGroup"         => publication_group,
      "publicationStage"         => publication_stage,
      "ratings"                  => ratings&.to_dynamic,
      "resourceName"             => resource_name,
      "rights"                   => rights,
      "rowClass"                 => row_class,
      "rowIdentifierColumnId"    => row_identifier_column_id,
      "rowsUpdatedAt"            => rows_updated_at,
      "rowsUpdatedBy"            => rows_updated_by,
      "tableAuthor"              => table_author.to_dynamic,
      "tableId"                  => table_id,
      "tags"                     => tags,
      "name"                     => top_level_name,
      "totalTimesRated"          => total_times_rated,
      "viewCount"                => view_count,
      "viewLastModified"         => view_last_modified,
      "viewType"                 => view_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel
  def self.from_json!(json)
    top_level = JSON.parse(json, quirks_mode: true).map { |x| TopLevelElement.from_dynamic!(x) }
    top_level.define_singleton_method(:to_json) do
      JSON.generate(self.map { |x| x.to_dynamic })
    end
    top_level
  end
end
