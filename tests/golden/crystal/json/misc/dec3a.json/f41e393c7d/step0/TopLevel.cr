require "json"

class TopLevel
  include JSON::Serializable

  property metadata : Metadata

  property results : Array(Result)
end

class Metadata
  include JSON::Serializable

  @[JSON::Field(key: "executionTime")]
  property execution_time : Float64

  @[JSON::Field(key: "responseInfo")]
  property response_info : ResponseInfo

  property resultset : Resultset
end

class ResponseInfo
  include JSON::Serializable

  @[JSON::Field(key: "developerMessage")]
  property developer_message : String

  property status : Int64
end

class Resultset
  include JSON::Serializable

  property count : Int64

  property page : Int64

  property pagesize : Int64
end

class Result
  include JSON::Serializable

  property about_office : String

  property application_process : String

  property body : String

  property changed : String

  property created : String

  property deadline : Nil

  property hiring_office : Nil

  property hiring_org : HiringOrg

  property job_id : Nil

  property language : String

  property location : Location

  property num_positions : String

  property position : String

  property practice_area : String

  property qualifications : String

  property relocation_expenses : Nil

  property salary : String

  property title : String

  property travel : String

  property url : String

  property uuid : String

  property vuuid : String
end

class HiringOrg
  include JSON::Serializable

  property name : String

  property uuid : String
end

class Location
  include JSON::Serializable

  property administrative_area : String

  property country : String

  property fax_number : String

  property locality : String

  property mobile_number : String

  property phone_number : String

  property phone_number_extension : String

  property postal_code : String

  property sub_premise : Nil

  property thoroughfare : String
end
