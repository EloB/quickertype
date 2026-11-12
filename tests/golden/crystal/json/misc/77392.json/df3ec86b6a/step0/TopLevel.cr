require "json"

alias TopLevel = Array(TopLevelElement)

class TopLevelElement
  include JSON::Serializable

  property designation : String

  property discovery_date : String

  property h_mag : String?

  property i_deg : String

  property moid_au : String

  property orbit_class : String

  property period_yr : String?

  property pha : String

  property q_au_1 : String

  property q_au_2 : String?
end
