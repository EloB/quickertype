require "json"

class TopLevel
  include JSON::Serializable

  # Comment delimiters:
  # */
  # {-
  # -}
  # """
  # }
  # }
  property kind : String
end
