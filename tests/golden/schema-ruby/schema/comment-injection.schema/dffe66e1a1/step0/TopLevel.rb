# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.trailing_backslash
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Hash   = Strict::Hash
  String = Strict::String
end

# Comment delimiters:
# */
# /*
# {-
# -}
# """
# </summary> & <br>
# }
# }
# }
# }
# }
class TopLevel < Dry::Struct

  # Ends with a backslash \
  attribute :trailing_backslash, Types::String.optional

  # Ends with a quote "
  attribute :trailing_quote, Types::String.optional

  # Ends with a triple quote """
  attribute :trailing_triple_quote, Types::String.optional

  # Property delimiters:
  # */
  # /*
  # {-
  # -}
  # """
  # </summary> & <br>
  # }
  # }
  # }
  # }
  # }
  attribute :value, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      trailing_backslash:    d.key?("trailingBackslash") ? Types::String[d["trailingBackslash"]] : nil,
      trailing_quote:        d.key?("trailingQuote") ? Types::String[d["trailingQuote"]] : nil,
      trailing_triple_quote: d.key?("trailingTripleQuote") ? Types::String[d["trailingTripleQuote"]] : nil,
      value:                 d.fetch("value"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "trailingBackslash"   => trailing_backslash,
      "trailingQuote"       => trailing_quote,
      "trailingTripleQuote" => trailing_triple_quote,
      "value"               => value,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
