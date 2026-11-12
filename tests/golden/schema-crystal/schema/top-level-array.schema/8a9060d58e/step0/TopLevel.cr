require "json"

alias TopLevel = Array(TextClassificationOutputElement)

class TextClassificationOutputElement
  include JSON::Serializable

  property label : String

  property score : Float64
end
