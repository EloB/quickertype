# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "[…]"
#   puts top_level.first.files["…"].file_type == Type::TextPlain
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer  = Strict::Integer
  Nil      = Strict::Nil
  Bool     = Strict::Bool
  Hash     = Strict::Hash
  String   = Strict::String
  Type     = Strict::String.enum("text/plain")
  Language = Strict::String.enum("Markdown")
end

module Type
  TextPlain = "text/plain"
end

module Language
  Markdown = "Markdown"
end

class FileValue < Dry::Struct
  attribute :file_type, Types::Type
  attribute :filename,  Types::String
  attribute :language,  Types::Language.optional
  attribute :raw_url,   Types::String
  attribute :size,      Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      file_type: d.fetch("type"),
      filename:  d.fetch("filename"),
      language:  d.fetch("language"),
      raw_url:   d.fetch("raw_url"),
      size:      d.fetch("size"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "type"     => file_type,
      "filename" => filename,
      "language" => language,
      "raw_url"  => raw_url,
      "size"     => size,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevelElement < Dry::Struct
  attribute :comments,     Types::Integer
  attribute :comments_url, Types::String
  attribute :commits_url,  Types::String
  attribute :created_at,   Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i)
  attribute :description,  Types::String.optional
  attribute :files,        Types::Hash.meta(of: FileValue)
  attribute :forks_url,    Types::String
  attribute :git_pull_url, Types::String
  attribute :git_push_url, Types::String
  attribute :html_url,     Types::String
  attribute :id,           Types::String
  attribute :public,       Types::Bool
  attribute :truncated,    Types::Bool
  attribute :updated_at,   Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i)
  attribute :url,          Types::String
  attribute :user,         Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      comments:     d.fetch("comments"),
      comments_url: d.fetch("comments_url"),
      commits_url:  d.fetch("commits_url"),
      created_at:   d.fetch("created_at"),
      description:  d.fetch("description"),
      files:        Types::Hash[d.fetch("files")].map { |k, v| [k, FileValue.from_dynamic!(v)] }.to_h,
      forks_url:    d.fetch("forks_url"),
      git_pull_url: d.fetch("git_pull_url"),
      git_push_url: d.fetch("git_push_url"),
      html_url:     d.fetch("html_url"),
      id:           d.fetch("id"),
      public:       d.fetch("public"),
      truncated:    d.fetch("truncated"),
      updated_at:   d.fetch("updated_at"),
      url:          d.fetch("url"),
      user:         d.fetch("user"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "comments"     => comments,
      "comments_url" => comments_url,
      "commits_url"  => commits_url,
      "created_at"   => created_at,
      "description"  => description,
      "files"        => files.map { |k, v| [k, v.to_dynamic] }.to_h,
      "forks_url"    => forks_url,
      "git_pull_url" => git_pull_url,
      "git_push_url" => git_push_url,
      "html_url"     => html_url,
      "id"           => id,
      "public"       => public,
      "truncated"    => truncated,
      "updated_at"   => updated_at,
      "url"          => url,
      "user"         => user,
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
