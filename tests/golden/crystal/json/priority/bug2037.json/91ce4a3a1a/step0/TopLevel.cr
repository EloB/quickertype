require "json"

class TopLevel
  include JSON::Serializable

  property mission_specs : Hash(String, MissionSpec)
end

class MissionSpec
  include JSON::Serializable

  property objectives : Hash(String, Objective)
end

class Objective
  include JSON::Serializable

  property rewards : Hash(String, Reward)
end

class Reward
  include JSON::Serializable

end
