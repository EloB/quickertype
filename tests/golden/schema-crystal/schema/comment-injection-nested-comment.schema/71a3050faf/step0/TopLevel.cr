require "json"

# Nested block comment openers:
# {-
# /*
# This text must remain inside the generated documentation comment.
class TopLevel
  include JSON::Serializable

  # Nested property block comment openers:
  # {-
  # /*
  # This text must remain inside the generated property documentation comment.
  property value : String
end
