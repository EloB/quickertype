require "json"

class TopLevel
  include JSON::Serializable

  # Nested enum block comment openers:
  # {-
  # /*
  # This text must remain inside the generated enum documentation comment.
  property kind : String
end
