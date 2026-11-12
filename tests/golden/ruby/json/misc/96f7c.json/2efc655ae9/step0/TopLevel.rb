# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.pages.first
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Bool   = Strict::Bool
  Hash   = Strict::Hash
  String = Strict::String
end

class TopLevel < Dry::Struct
  attribute :git,                                Types.Array(Types::String)
  attribute :github_services_sha,                Types::String
  attribute :hooks,                              Types.Array(Types::String)
  attribute :importer,                           Types.Array(Types::String)
  attribute :pages,                              Types.Array(Types::String)
  attribute :verifiable_password_authentication, Types::Bool

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      git:                                d.fetch("git"),
      github_services_sha:                d.fetch("github_services_sha"),
      hooks:                              d.fetch("hooks"),
      importer:                           d.fetch("importer"),
      pages:                              d.fetch("pages"),
      verifiable_password_authentication: d.fetch("verifiable_password_authentication"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "git"                                => git,
      "github_services_sha"                => github_services_sha,
      "hooks"                              => hooks,
      "importer"                           => importer,
      "pages"                              => pages,
      "verifiable_password_authentication" => verifiable_password_authentication,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
