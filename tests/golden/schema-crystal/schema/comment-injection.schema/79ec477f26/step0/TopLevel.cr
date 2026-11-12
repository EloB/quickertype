require "json"

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
class TopLevel
  include JSON::Serializable

  # Ends with a backslash \
  @[JSON::Field(key: "trailingBackslash")]
  property trailing_backslash : String?

  # Ends with a quote "
  @[JSON::Field(key: "trailingQuote")]
  property trailing_quote : String?

  # Ends with a triple quote """
  @[JSON::Field(key: "trailingTripleQuote")]
  property trailing_triple_quote : String?

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
  property value : String
end
