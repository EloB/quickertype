require "json"

class TopLevel
  include JSON::Serializable

  @[JSON::Field(key: "anEasyOne")]
  property an_easy_one : Int64

  @[JSON::Field(key: "isMNISTLetter")]
  property is_mnist_letter : Bool

  @[JSON::Field(key: "JSONString")]
  property json_string : String

  @[JSON::Field(key: "PrettyEasyToo")]
  property pretty_easy_too : Bool

  property should_know_that_id_is_an_initialism : String

  @[JSON::Field(key: "   spaces are separators  too  ")]
  property spaces_are_separators_too : Bool

  @[JSON::Field(key: "ZSR_HH_DEMO3_DELMATNR")]
  property zsr_hh_demo3_delmatnr : Bool
end
