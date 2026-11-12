require "json"

class TopLevel
  include JSON::Serializable

  @[JSON::Field(key: "arrayNode")]
  property array_node : ArrayNode?

  @[JSON::Field(key: "booleanNode")]
  property boolean_node : BooleanNode?

  @[JSON::Field(key: "doubleNode")]
  property double_node : DoubleNode?

  @[JSON::Field(key: "intNode")]
  property int_node : IntNode?

  @[JSON::Field(key: "longNode")]
  property long_node : LongNode?

  @[JSON::Field(key: "nullNode")]
  property null_node : NullNode?

  @[JSON::Field(key: "objectNode")]
  property object_node : ObjectNode?

  property stuff : Hash(String, Thing)

  @[JSON::Field(key: "textNode")]
  property text_node : TextNode?
end

class ArrayNode
  include JSON::Serializable

end

class BooleanNode
  include JSON::Serializable

end

class DoubleNode
  include JSON::Serializable

end

class IntNode
  include JSON::Serializable

end

class LongNode
  include JSON::Serializable

end

class NullNode
  include JSON::Serializable

end

class ObjectNode
  include JSON::Serializable

end

class Thing
  include JSON::Serializable

  property optional : Anything?

  property required : Anything?
end

class TextNode
  include JSON::Serializable

end

alias Anything = Array(JSON::Any?) | Hash(String, JSON::Any?) | Float64 | Int64 | Bool | String
