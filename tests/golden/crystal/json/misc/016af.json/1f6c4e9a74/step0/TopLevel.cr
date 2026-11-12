require "json"

class TopLevel
  include JSON::Serializable

  property total_population : Array(TotalPopulation)
end

class TotalPopulation
  include JSON::Serializable

  property date : String

  property population : Int64
end
