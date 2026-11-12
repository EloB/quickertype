# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "…"
#   puts top_level == TopLevel::One
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  String   = Strict::String
  TopLevel = Strict::String.enum("one", "three", "two")
end

module TopLevel
  One   = "one"
  Three = "three"
  Two   = "two"
end
