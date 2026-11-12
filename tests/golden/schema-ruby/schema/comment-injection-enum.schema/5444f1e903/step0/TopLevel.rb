# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.kind == Kind::Ok
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Hash   = Strict::Hash
  String = Strict::String
  Kind   = Strict::String.enum("ok")
end

# Comment delimiters:
# */
# {-
# -}
# """
# }
# }
module Kind
  Ok = "ok"
end

class TopLevel < Dry::Struct

  # Comment delimiters:
  # */
  # {-
  # -}
  # """
  # }
  # }
  attribute :kind, Types::Kind

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      kind: d.fetch("kind"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "kind" => kind,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
