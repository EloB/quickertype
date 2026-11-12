# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.top_level_meta.view.tags.first
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer = Strict::Integer
  Nil     = Strict::Nil
  Bool    = Strict::Bool
  Hash    = Strict::Hash
  String  = Strict::String
end

class Datum < Dry::Struct
  attribute :integer, Types::Integer.optional
  attribute :null,    Types::Nil.optional
  attribute :string,  Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, null: nil, string: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, integer: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, integer: nil, null: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if integer != nil
      integer
    elsif string != nil
      string
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Top < Dry::Struct
  attribute :count, Types::Integer
  attribute :item,  Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      count: d.fetch("count"),
      item:  d.fetch("item"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "count" => count,
      "item"  => item,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class CachedContents < Dry::Struct
  attribute :average,  Types::String.optional
  attribute :largest,  Types::String
  attribute :non_null, Types::Integer
  attribute :null,     Types::Integer
  attribute :smallest, Types::String
  attribute :sum,      Types::String.optional
  attribute :top,      Types.Array(Top)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      average:  d.key?("average") ? Types::String[d["average"]] : nil,
      largest:  d.fetch("largest"),
      non_null: d.fetch("non_null"),
      null:     d.fetch("null"),
      smallest: d.fetch("smallest"),
      sum:      d.key?("sum") ? Types::String[d["sum"]] : nil,
      top:      d.fetch("top").map { |x| Top.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "average"  => average,
      "largest"  => largest,
      "non_null" => non_null,
      "null"     => null,
      "smallest" => smallest,
      "sum"      => sum,
      "top"      => top.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Format < Dry::Struct
  attribute :align,           Types::String.optional
  attribute :no_commas,       Types::String.optional
  attribute :precision_style, Types::String.optional
  attribute :view,            Types::String.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      align:           d.key?("align") ? Types::String[d["align"]] : nil,
      no_commas:       d.key?("noCommas") ? Types::String[d["noCommas"]] : nil,
      precision_style: d.key?("precisionStyle") ? Types::String[d["precisionStyle"]] : nil,
      view:            d.key?("view") ? Types::String[d["view"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "align"          => align,
      "noCommas"       => no_commas,
      "precisionStyle" => precision_style,
      "view"           => view,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Column < Dry::Struct
  attribute :cached_contents,  CachedContents.optional
  attribute :column_format,    Format
  attribute :column_name,      Types::String
  attribute :data_type_name,   Types::String
  attribute :field_name,       Types::String
  attribute :flags,            Types.Array(Types::String).optional
  attribute :id,               Types::Integer
  attribute :position,         Types::Integer
  attribute :render_type_name, Types::String
  attribute :table_column_id,  Types::Integer.optional
  attribute :width,            Types::Integer.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      cached_contents:  d.key?("cachedContents") ? CachedContents.from_dynamic!(d["cachedContents"]) : nil,
      column_format:    Format.from_dynamic!(d.fetch("format")),
      column_name:      d.fetch("name"),
      data_type_name:   d.fetch("dataTypeName"),
      field_name:       d.fetch("fieldName"),
      flags:            d.key?("flags") ? d["flags"].map { |x| Types::String[x] } : nil,
      id:               d.fetch("id"),
      position:         d.fetch("position"),
      render_type_name: d.fetch("renderTypeName"),
      table_column_id:  d.key?("tableColumnId") ? Types::Integer[d["tableColumnId"]] : nil,
      width:            d.key?("width") ? Types::Integer[d["width"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "cachedContents" => cached_contents&.to_dynamic,
      "format"         => column_format.to_dynamic,
      "name"           => column_name,
      "dataTypeName"   => data_type_name,
      "fieldName"      => field_name,
      "flags"          => flags,
      "id"             => id,
      "position"       => position,
      "renderTypeName" => render_type_name,
      "tableColumnId"  => table_column_id,
      "width"          => width,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Grant < Dry::Struct
  attribute :flags,      Types.Array(Types::String)
  attribute :grant_type, Types::String
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

class Attachment < Dry::Struct
  attribute :asset_id,        Types::String
  attribute :attachment_name, Types::String
  attribute :blob_id,         Types::String
  attribute :filename,        Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      asset_id:        d.fetch("assetId"),
      attachment_name: d.fetch("name"),
      blob_id:         d.fetch("blobId"),
      filename:        d.fetch("filename"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "assetId"  => asset_id,
      "name"     => attachment_name,
      "blobId"   => blob_id,
      "filename" => filename,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class AdditionalResources < Dry::Struct
  attribute :additional_resources_see_also, Types::String
  attribute :see_also,                      Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      additional_resources_see_also: d.fetch("See Also "),
      see_also:                      d.fetch("See Also"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "See Also " => additional_resources_see_also,
      "See Also"  => see_also,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class CommonCore < Dry::Struct
  attribute :contact_email, Types::String
  attribute :contact_name,  Types::String
  attribute :publisher,     Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      contact_email: d.fetch("Contact Email"),
      contact_name:  d.fetch("Contact Name"),
      publisher:     d.fetch("Publisher"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Contact Email" => contact_email,
      "Contact Name"  => contact_name,
      "Publisher"     => publisher,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DatasetInformation < Dry::Struct
  attribute :agency, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      agency: d.fetch("Agency"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Agency" => agency,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DatasetSummary < Dry::Struct
  attribute :contact_information, Types::String
  attribute :coverage,            Types::String
  attribute :data_frequency,      Types::String
  attribute :dataset_owner,       Types::String
  attribute :granularity,         Types::String
  attribute :organization,        Types::String
  attribute :posting_frequency,   Types::String
  attribute :time_period,         Types::String
  attribute :units,               Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      contact_information: d.fetch("Contact Information"),
      coverage:            d.fetch("Coverage"),
      data_frequency:      d.fetch("Data Frequency"),
      dataset_owner:       d.fetch("Dataset Owner"),
      granularity:         d.fetch("Granularity"),
      organization:        d.fetch("Organization"),
      posting_frequency:   d.fetch("Posting Frequency"),
      time_period:         d.fetch("Time Period"),
      units:               d.fetch("Units"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Contact Information" => contact_information,
      "Coverage"            => coverage,
      "Data Frequency"      => data_frequency,
      "Dataset Owner"       => dataset_owner,
      "Granularity"         => granularity,
      "Organization"        => organization,
      "Posting Frequency"   => posting_frequency,
      "Time Period"         => time_period,
      "Units"               => units,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Notes < Dry::Struct
  attribute :notes, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      notes: d.fetch("Notes"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Notes" => notes,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class CustomFields < Dry::Struct
  attribute :additional_resources, AdditionalResources
  attribute :common_core,          CommonCore
  attribute :dataset_information,  DatasetInformation
  attribute :dataset_summary,      DatasetSummary
  attribute :notes,                Notes

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      additional_resources: AdditionalResources.from_dynamic!(d.fetch("Additional Resources")),
      common_core:          CommonCore.from_dynamic!(d.fetch("Common Core")),
      dataset_information:  DatasetInformation.from_dynamic!(d.fetch("Dataset Information")),
      dataset_summary:      DatasetSummary.from_dynamic!(d.fetch("Dataset Summary")),
      notes:                Notes.from_dynamic!(d.fetch("Notes")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Additional Resources" => additional_resources.to_dynamic,
      "Common Core"          => common_core.to_dynamic,
      "Dataset Information"  => dataset_information.to_dynamic,
      "Dataset Summary"      => dataset_summary.to_dynamic,
      "Notes"                => notes.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Order < Dry::Struct
  attribute :ascending,         Types::Bool
  attribute :column_field_name, Types::String

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

class JSONQuery < Dry::Struct
  attribute :order, Types.Array(Order)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      order: d.fetch("order").map { |x| Order.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "order" => order.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Visible < Dry::Struct
  attribute :table, Types::Bool

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      table: d.fetch("table"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "table" => table,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class RenderTypeConfig < Dry::Struct
  attribute :visible, Visible

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      visible: Visible.from_dynamic!(d.fetch("visible")),
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

class Metadata < Dry::Struct
  attribute :attachments,             Types.Array(Attachment)
  attribute :available_display_types, Types.Array(Types::String)
  attribute :custom_fields,           CustomFields
  attribute :json_query,              JSONQuery
  attribute :rdf_subject,             Types::String
  attribute :render_type_config,      RenderTypeConfig

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      attachments:             d.fetch("attachments").map { |x| Attachment.from_dynamic!(x) },
      available_display_types: d.fetch("availableDisplayTypes"),
      custom_fields:           CustomFields.from_dynamic!(d.fetch("custom_fields")),
      json_query:              JSONQuery.from_dynamic!(d.fetch("jsonQuery")),
      rdf_subject:             d.fetch("rdfSubject"),
      render_type_config:      RenderTypeConfig.from_dynamic!(d.fetch("renderTypeConfig")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "attachments"           => attachments.map { |x| x.to_dynamic },
      "availableDisplayTypes" => available_display_types,
      "custom_fields"         => custom_fields.to_dynamic,
      "jsonQuery"             => json_query.to_dynamic,
      "rdfSubject"            => rdf_subject,
      "renderTypeConfig"      => render_type_config.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Owner < Dry::Struct
  attribute :display_name,             Types::String
  attribute :id,                       Types::String
  attribute :profile_image_url_large,  Types::String
  attribute :profile_image_url_medium, Types::String
  attribute :profile_image_url_small,  Types::String
  attribute :rights,                   Types.Array(Types::String)
  attribute :role_name,                Types::String
  attribute :screen_name,              Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      display_name:             d.fetch("displayName"),
      id:                       d.fetch("id"),
      profile_image_url_large:  d.fetch("profileImageUrlLarge"),
      profile_image_url_medium: d.fetch("profileImageUrlMedium"),
      profile_image_url_small:  d.fetch("profileImageUrlSmall"),
      rights:                   d.fetch("rights"),
      role_name:                d.fetch("roleName"),
      screen_name:              d.fetch("screenName"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "displayName"           => display_name,
      "id"                    => id,
      "profileImageUrlLarge"  => profile_image_url_large,
      "profileImageUrlMedium" => profile_image_url_medium,
      "profileImageUrlSmall"  => profile_image_url_small,
      "rights"                => rights,
      "roleName"              => role_name,
      "screenName"            => screen_name,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Expression < Dry::Struct
  attribute :column_id,       Types::Integer
  attribute :expression_type, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      column_id:       d.fetch("columnId"),
      expression_type: d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "columnId" => column_id,
      "type"     => expression_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class OrderBy < Dry::Struct
  attribute :ascending,  Types::Bool
  attribute :expression, Expression

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      ascending:  d.fetch("ascending"),
      expression: Expression.from_dynamic!(d.fetch("expression")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "ascending"  => ascending,
      "expression" => expression.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Query < Dry::Struct
  attribute :order_bys, Types.Array(OrderBy)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      order_bys: d.fetch("orderBys").map { |x| OrderBy.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "orderBys" => order_bys.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class View < Dry::Struct
  attribute :attribution,                Types::String
  attribute :attribution_link,           Types::String
  attribute :average_rating,             Types::Integer
  attribute :category,                   Types::String
  attribute :columns,                    Types.Array(Column)
  attribute :created_at,                 Types::Integer
  attribute :description,                Types::String
  attribute :display_type,               Types::String
  attribute :download_count,             Types::Integer
  attribute :flags,                      Types.Array(Types::String)
  attribute :grants,                     Types.Array(Grant)
  attribute :hide_from_catalog,          Types::Bool
  attribute :hide_from_data_json,        Types::Bool
  attribute :id,                         Types::String
  attribute :index_updated_at,           Types::Integer
  attribute :locale,                     Types::String
  attribute :metadata,                   Metadata
  attribute :new_backend,                Types::Bool
  attribute :number_of_comments,         Types::Integer
  attribute :oid,                        Types::Integer
  attribute :owner,                      Owner
  attribute :provenance,                 Types::String
  attribute :publication_append_enabled, Types::Bool
  attribute :publication_date,           Types::Integer
  attribute :publication_group,          Types::Integer
  attribute :publication_stage,          Types::String
  attribute :query,                      Query
  attribute :rights,                     Types.Array(Types::String)
  attribute :rows_updated_at,            Types::Integer
  attribute :rows_updated_by,            Types::String
  attribute :table_author,               Owner
  attribute :table_id,                   Types::Integer
  attribute :tags,                       Types.Array(Types::String)
  attribute :total_times_rated,          Types::Integer
  attribute :view_count,                 Types::Integer
  attribute :view_last_modified,         Types::Integer
  attribute :view_name,                  Types::String
  attribute :view_type,                  Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      attribution:                d.fetch("attribution"),
      attribution_link:           d.fetch("attributionLink"),
      average_rating:             d.fetch("averageRating"),
      category:                   d.fetch("category"),
      columns:                    d.fetch("columns").map { |x| Column.from_dynamic!(x) },
      created_at:                 d.fetch("createdAt"),
      description:                d.fetch("description"),
      display_type:               d.fetch("displayType"),
      download_count:             d.fetch("downloadCount"),
      flags:                      d.fetch("flags"),
      grants:                     d.fetch("grants").map { |x| Grant.from_dynamic!(x) },
      hide_from_catalog:          d.fetch("hideFromCatalog"),
      hide_from_data_json:        d.fetch("hideFromDataJson"),
      id:                         d.fetch("id"),
      index_updated_at:           d.fetch("indexUpdatedAt"),
      locale:                     d.fetch("locale"),
      metadata:                   Metadata.from_dynamic!(d.fetch("metadata")),
      new_backend:                d.fetch("newBackend"),
      number_of_comments:         d.fetch("numberOfComments"),
      oid:                        d.fetch("oid"),
      owner:                      Owner.from_dynamic!(d.fetch("owner")),
      provenance:                 d.fetch("provenance"),
      publication_append_enabled: d.fetch("publicationAppendEnabled"),
      publication_date:           d.fetch("publicationDate"),
      publication_group:          d.fetch("publicationGroup"),
      publication_stage:          d.fetch("publicationStage"),
      query:                      Query.from_dynamic!(d.fetch("query")),
      rights:                     d.fetch("rights"),
      rows_updated_at:            d.fetch("rowsUpdatedAt"),
      rows_updated_by:            d.fetch("rowsUpdatedBy"),
      table_author:               Owner.from_dynamic!(d.fetch("tableAuthor")),
      table_id:                   d.fetch("tableId"),
      tags:                       d.fetch("tags"),
      total_times_rated:          d.fetch("totalTimesRated"),
      view_count:                 d.fetch("viewCount"),
      view_last_modified:         d.fetch("viewLastModified"),
      view_name:                  d.fetch("name"),
      view_type:                  d.fetch("viewType"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "attribution"              => attribution,
      "attributionLink"          => attribution_link,
      "averageRating"            => average_rating,
      "category"                 => category,
      "columns"                  => columns.map { |x| x.to_dynamic },
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
      "newBackend"               => new_backend,
      "numberOfComments"         => number_of_comments,
      "oid"                      => oid,
      "owner"                    => owner.to_dynamic,
      "provenance"               => provenance,
      "publicationAppendEnabled" => publication_append_enabled,
      "publicationDate"          => publication_date,
      "publicationGroup"         => publication_group,
      "publicationStage"         => publication_stage,
      "query"                    => query.to_dynamic,
      "rights"                   => rights,
      "rowsUpdatedAt"            => rows_updated_at,
      "rowsUpdatedBy"            => rows_updated_by,
      "tableAuthor"              => table_author.to_dynamic,
      "tableId"                  => table_id,
      "tags"                     => tags,
      "totalTimesRated"          => total_times_rated,
      "viewCount"                => view_count,
      "viewLastModified"         => view_last_modified,
      "name"                     => view_name,
      "viewType"                 => view_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Meta < Dry::Struct
  attribute :view, View

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      view: View.from_dynamic!(d.fetch("view")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "view" => view.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :data,           Types.Array(Types.Array(Types.Instance(Datum)))
  attribute :top_level_meta, Meta

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      data:           d.fetch("data").map { |x| x.map { |x| Datum.from_dynamic!(x) } },
      top_level_meta: Meta.from_dynamic!(d.fetch("meta")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "data" => data.map { |x| x.map { |x| x.to_dynamic } },
      "meta" => top_level_meta.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
