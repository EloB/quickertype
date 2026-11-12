require "json"

class Bar
  include JSON::Serializable

  property foo : Foo
end

class TopLevel
  include JSON::Serializable

  property bar : Bar?
end

alias Foo = TopLevel | Array(TopLevel)
