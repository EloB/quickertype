require "json"

class TopLevel
  include JSON::Serializable

  property git : Array(String)

  property github_services_sha : String

  property hooks : Array(String)

  property importer : Array(String)

  property pages : Array(String)

  property verifiable_password_authentication : Bool
end
