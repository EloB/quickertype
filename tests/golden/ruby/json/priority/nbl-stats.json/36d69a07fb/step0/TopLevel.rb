# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.totallds.s_steals["…"].times&.first.gt
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer           = Strict::Integer
  Hash              = Strict::Hash
  String            = Strict::String
  Double            = Strict::Float | Strict::Integer
  LeaddatumEnum     = Strict::String.enum("", "P1", "P2", "P3", "P4")
  PerType           = Strict::String.enum("REGULAR")
  ActionType        = Strict::String.enum("game", "period", "3pt", "2pt", "rebound", "timeout", "foulon", "foul", "assist", "substitution", "freethrow", "steal", "turnover", "block", "jumpball")
  FamilyNameInitial = Strict::String.enum("R", "M", "s", "C", "O", "W", "A", "P", "V", "I", "J", "S", "H", "B")
  FirstNameInitial  = Strict::String.enum("D", "J", "T", "C", "O", "H", "L", "A", "K", "R", "B", "N")
  ScoreboardName    = Strict::String.enum("", "T. s", "R. Ihata", "D. Jones", "B. Valentine")
  SubType           = Strict::String.enum("jumpshot", "layup", "dunk")
end

module LeaddatumEnum
  Empty = ""
  P1    = "P1"
  P2    = "P2"
  P3    = "P3"
  P4    = "P4"
end

class LeaddatumElement < Dry::Struct
  attribute :enum_1,  Types::LeaddatumEnum.optional
  attribute :integer, Types::Integer.optional

  def self.from_dynamic!(d)
    if schema.key(:enum_1).type.right.valid? d
      return new(enum_1: d, integer: nil)
    end
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, enum_1: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if enum_1 != nil
      enum_1
    elsif integer != nil
      integer
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module PerType
  Regular = "REGULAR"
end

class Team < Dry::Struct
  attribute :team_code,               Types::String
  attribute :team_code_international, Types::String
  attribute :team_name,               Types::String
  attribute :team_name_international, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      team_code:               d.fetch("teamCode"),
      team_code_international: d.fetch("teamCodeInternational"),
      team_name:               d.fetch("teamName"),
      team_name_international: d.fetch("teamNameInternational"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "teamCode"              => team_code,
      "teamCodeInternational" => team_code_international,
      "teamName"              => team_name,
      "teamNameInternational" => team_name_international,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Othermatch < Dry::Struct
  attribute :clock,            Types::String
  attribute :competition_name, Types::String
  attribute :id,               Types::String
  attribute :period,           Types::Integer
  attribute :period_type,      Types::PerType
  attribute :team1,            Team
  attribute :team1_name,       Types::String
  attribute :team1_score,      Types::Integer
  attribute :team2,            Team
  attribute :team2_name,       Types::String
  attribute :team2_score,      Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      clock:            d.fetch("clock"),
      competition_name: d.fetch("competitionName"),
      id:               d.fetch("id"),
      period:           d.fetch("period"),
      period_type:      d.fetch("periodType"),
      team1:            Team.from_dynamic!(d.fetch("team1")),
      team1_name:       d.fetch("team1Name"),
      team1_score:      d.fetch("team1Score"),
      team2:            Team.from_dynamic!(d.fetch("team2")),
      team2_name:       d.fetch("team2Name"),
      team2_score:      d.fetch("team2Score"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "clock"           => clock,
      "competitionName" => competition_name,
      "id"              => id,
      "period"          => period,
      "periodType"      => period_type,
      "team1"           => team1.to_dynamic,
      "team1Name"       => team1_name,
      "team1Score"      => team1_score,
      "team2"           => team2.to_dynamic,
      "team2Name"       => team2_name,
      "team2Score"      => team2_score,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module ActionType
  Game         = "game"
  Period       = "period"
  The3Pt       = "3pt"
  The2Pt       = "2pt"
  Rebound      = "rebound"
  Timeout      = "timeout"
  Foulon       = "foulon"
  Foul         = "foul"
  Assist       = "assist"
  Substitution = "substitution"
  Freethrow    = "freethrow"
  Steal        = "steal"
  Turnover     = "turnover"
  Block        = "block"
  Jumpball     = "jumpball"
end

module FamilyNameInitial
  R                  = "R"
  M                  = "M"
  S                  = "s"
  C                  = "C"
  O                  = "O"
  W                  = "W"
  A                  = "A"
  P                  = "P"
  V                  = "V"
  I                  = "I"
  J                  = "J"
  FamilyNameInitialS = "S"
  H                  = "H"
  B                  = "B"
end

module FirstNameInitial
  D = "D"
  J = "J"
  T = "T"
  C = "C"
  O = "O"
  H = "H"
  L = "L"
  A = "A"
  K = "K"
  R = "R"
  B = "B"
  N = "N"
end

module ScoreboardName
  Empty      = ""
  TS         = "T. s"
  RIhata     = "R. Ihata"
  DJones     = "D. Jones"
  BValentine = "B. Valentine"
end

class Pbp < Dry::Struct
  attribute :action_type,                       Types::ActionType
  attribute :family_name,                       Types::String.optional
  attribute :family_name_initial,               Types::FamilyNameInitial.optional
  attribute :first_name,                        Types::String.optional
  attribute :first_name_initial,                Types::FirstNameInitial.optional
  attribute :gt,                                Types::String
  attribute :international_family_name,         Types::String.optional
  attribute :international_family_name_initial, Types::FamilyNameInitial.optional
  attribute :international_first_name,          Types::String.optional
  attribute :international_first_name_initial,  Types::FirstNameInitial.optional
  attribute :lead,                              Types::Integer
  attribute :period,                            Types::Integer
  attribute :period_type,                       Types::PerType
  attribute :player,                            Types::String
  attribute :pno,                               Types::Integer
  attribute :qualifier,                         Types::String
  attribute :s1,                                Types::Integer
  attribute :s2,                                Types::Integer
  attribute :scoreboard_name,                   Types::ScoreboardName.optional
  attribute :scoring,                           Types::Integer
  attribute :shirt_number,                      Types::String
  attribute :sub_type,                          Types::String
  attribute :success,                           Types::Integer
  attribute :tno,                               Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      action_type:                       d.fetch("actionType"),
      family_name:                       d.key?("familyName") ? Types::String[d["familyName"]] : nil,
      family_name_initial:               d.key?("familyNameInitial") ? Types::FamilyNameInitial[d["familyNameInitial"]] : nil,
      first_name:                        d.key?("firstName") ? Types::String[d["firstName"]] : nil,
      first_name_initial:                d.key?("firstNameInitial") ? Types::FirstNameInitial[d["firstNameInitial"]] : nil,
      gt:                                d.fetch("gt"),
      international_family_name:         d.key?("internationalFamilyName") ? Types::String[d["internationalFamilyName"]] : nil,
      international_family_name_initial: d.key?("internationalFamilyNameInitial") ? Types::FamilyNameInitial[d["internationalFamilyNameInitial"]] : nil,
      international_first_name:          d.key?("internationalFirstName") ? Types::String[d["internationalFirstName"]] : nil,
      international_first_name_initial:  d.key?("internationalFirstNameInitial") ? Types::FirstNameInitial[d["internationalFirstNameInitial"]] : nil,
      lead:                              d.fetch("lead"),
      period:                            d.fetch("period"),
      period_type:                       d.fetch("periodType"),
      player:                            d.fetch("player"),
      pno:                               d.fetch("pno"),
      qualifier:                         d.fetch("qualifier"),
      s1:                                d.fetch("s1"),
      s2:                                d.fetch("s2"),
      scoreboard_name:                   d.key?("scoreboardName") ? Types::ScoreboardName[d["scoreboardName"]] : nil,
      scoring:                           d.fetch("scoring"),
      shirt_number:                      d.fetch("shirtNumber"),
      sub_type:                          d.fetch("subType"),
      success:                           d.fetch("success"),
      tno:                               d.fetch("tno"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "actionType"                     => action_type,
      "familyName"                     => family_name,
      "familyNameInitial"              => family_name_initial,
      "firstName"                      => first_name,
      "firstNameInitial"               => first_name_initial,
      "gt"                             => gt,
      "internationalFamilyName"        => international_family_name,
      "internationalFamilyNameInitial" => international_family_name_initial,
      "internationalFirstName"         => international_first_name,
      "internationalFirstNameInitial"  => international_first_name_initial,
      "lead"                           => lead,
      "period"                         => period,
      "periodType"                     => period_type,
      "player"                         => player,
      "pno"                            => pno,
      "qualifier"                      => qualifier,
      "s1"                             => s1,
      "s2"                             => s2,
      "scoreboardName"                 => scoreboard_name,
      "scoring"                        => scoring,
      "shirtNumber"                    => shirt_number,
      "subType"                        => sub_type,
      "success"                        => success,
      "tno"                            => tno,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TimeElement < Dry::Struct
  attribute :gt,       Types::String
  attribute :per,      Types::Integer
  attribute :per_type, Types::PerType

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      gt:       d.fetch("gt"),
      per:      d.fetch("per"),
      per_type: d.fetch("perType"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "gt"      => gt,
      "per"     => per,
      "perType" => per_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Scorer < Dry::Struct
  attribute :family_name,                       Types::String.optional
  attribute :family_name_initial,               Types::FamilyNameInitial.optional
  attribute :first_name,                        Types::String.optional
  attribute :first_name_initial,                Types::FirstNameInitial.optional
  attribute :gt,                                Types::String.optional
  attribute :international_family_name,         Types::String.optional
  attribute :international_family_name_initial, Types::FamilyNameInitial.optional
  attribute :international_first_name,          Types::String.optional
  attribute :international_first_name_initial,  Types::FirstNameInitial.optional
  attribute :per,                               Types::Integer.optional
  attribute :per_type,                          Types::PerType.optional
  attribute :player,                            Types::String.optional
  attribute :pno,                               Types::Integer
  attribute :scoreboard_name,                   Types::ScoreboardName.optional
  attribute :scorer_name,                       Types::String.optional
  attribute :shirt_number,                      Types::String
  attribute :summary,                           Types::String.optional
  attribute :times,                             Types.Array(TimeElement).optional
  attribute :tno,                               Types::Integer
  attribute :tot,                               Types::Integer.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      family_name:                       d.key?("familyName") ? Types::String[d["familyName"]] : nil,
      family_name_initial:               d.key?("familyNameInitial") ? Types::FamilyNameInitial[d["familyNameInitial"]] : nil,
      first_name:                        d.key?("firstName") ? Types::String[d["firstName"]] : nil,
      first_name_initial:                d.key?("firstNameInitial") ? Types::FirstNameInitial[d["firstNameInitial"]] : nil,
      gt:                                d.key?("gt") ? Types::String[d["gt"]] : nil,
      international_family_name:         d.key?("internationalFamilyName") ? Types::String[d["internationalFamilyName"]] : nil,
      international_family_name_initial: d.key?("internationalFamilyNameInitial") ? Types::FamilyNameInitial[d["internationalFamilyNameInitial"]] : nil,
      international_first_name:          d.key?("internationalFirstName") ? Types::String[d["internationalFirstName"]] : nil,
      international_first_name_initial:  d.key?("internationalFirstNameInitial") ? Types::FirstNameInitial[d["internationalFirstNameInitial"]] : nil,
      per:                               d.key?("per") ? Types::Integer[d["per"]] : nil,
      per_type:                          d.key?("perType") ? Types::PerType[d["perType"]] : nil,
      player:                            d.key?("player") ? Types::String[d["player"]] : nil,
      pno:                               d.fetch("pno"),
      scoreboard_name:                   d.key?("scoreboardName") ? Types::ScoreboardName[d["scoreboardName"]] : nil,
      scorer_name:                       d.key?("name") ? Types::String[d["name"]] : nil,
      shirt_number:                      d.fetch("shirtNumber"),
      summary:                           d.key?("summary") ? Types::String[d["summary"]] : nil,
      times:                             d.key?("times") ? d["times"].map { |x| TimeElement.from_dynamic!(x) } : nil,
      tno:                               d.fetch("tno"),
      tot:                               d.key?("tot") ? Types::Integer[d["tot"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "familyName"                     => family_name,
      "familyNameInitial"              => family_name_initial,
      "firstName"                      => first_name,
      "firstNameInitial"               => first_name_initial,
      "gt"                             => gt,
      "internationalFamilyName"        => international_family_name,
      "internationalFamilyNameInitial" => international_family_name_initial,
      "internationalFirstName"         => international_first_name,
      "internationalFirstNameInitial"  => international_first_name_initial,
      "per"                            => per,
      "perType"                        => per_type,
      "player"                         => player,
      "pno"                            => pno,
      "scoreboardName"                 => scoreboard_name,
      "name"                           => scorer_name,
      "shirtNumber"                    => shirt_number,
      "summary"                        => summary,
      "times"                          => times&.map { |x| x.to_dynamic },
      "tno"                            => tno,
      "tot"                            => tot,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class SBlocks < Dry::Struct
  attribute :the_1, Scorer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      the_1: Scorer.from_dynamic!(d.fetch("1")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "1" => the_1.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Lds < Dry::Struct
  attribute :s_assists,        Types::Hash.meta(of: Scorer)
  attribute :s_blocks,         SBlocks
  attribute :s_points,         Types::Hash.meta(of: Scorer)
  attribute :s_rebounds_total, Types::Hash.meta(of: Scorer)
  attribute :s_steals,         Types::Hash.meta(of: Scorer)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      s_assists:        Types::Hash[d.fetch("sAssists")].map { |k, v| [k, Scorer.from_dynamic!(v)] }.to_h,
      s_blocks:         SBlocks.from_dynamic!(d.fetch("sBlocks")),
      s_points:         Types::Hash[d.fetch("sPoints")].map { |k, v| [k, Scorer.from_dynamic!(v)] }.to_h,
      s_rebounds_total: Types::Hash[d.fetch("sReboundsTotal")].map { |k, v| [k, Scorer.from_dynamic!(v)] }.to_h,
      s_steals:         Types::Hash[d.fetch("sSteals")].map { |k, v| [k, Scorer.from_dynamic!(v)] }.to_h,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "sAssists"       => s_assists.map { |k, v| [k, v.to_dynamic] }.to_h,
      "sBlocks"        => s_blocks.to_dynamic,
      "sPoints"        => s_points.map { |k, v| [k, v.to_dynamic] }.to_h,
      "sReboundsTotal" => s_rebounds_total.map { |k, v| [k, v.to_dynamic] }.to_h,
      "sSteals"        => s_steals.map { |k, v| [k, v.to_dynamic] }.to_h,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Comp < Dry::Struct
  attribute :s_assists_average,        Types::Double
  attribute :s_minutes_average,        Types::String
  attribute :s_points_average,         Types::Double
  attribute :s_rebounds_total_average, Types::Double

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      s_assists_average:        d.fetch("sAssistsAverage"),
      s_minutes_average:        d.fetch("sMinutesAverage"),
      s_points_average:         d.fetch("sPointsAverage"),
      s_rebounds_total_average: d.fetch("sReboundsTotalAverage"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "sAssistsAverage"       => s_assists_average,
      "sMinutesAverage"       => s_minutes_average,
      "sPointsAverage"        => s_points_average,
      "sReboundsTotalAverage" => s_rebounds_total_average,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class SMinutes < Dry::Struct
  attribute :integer, Types::Integer.optional
  attribute :string,  Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, integer: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if integer != nil
      integer
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Pl < Dry::Struct
  attribute :active,                            Types::Integer
  attribute :captain,                           Types::Integer.optional
  attribute :comp,                              Comp.optional
  attribute :eff_1,                             Types::Integer
  attribute :eff_2,                             Types::Integer
  attribute :eff_3,                             Types::Double
  attribute :eff_4,                             Types::Double
  attribute :eff_5,                             Types::Integer
  attribute :eff_6,                             Types::Integer
  attribute :eff_7,                             Types::Integer
  attribute :family_name,                       Types::String
  attribute :family_name_initial,               Types::FamilyNameInitial
  attribute :first_name,                        Types::String
  attribute :first_name_initial,                Types::FirstNameInitial
  attribute :international_family_name,         Types::String
  attribute :international_family_name_initial, Types::FamilyNameInitial
  attribute :international_first_name,          Types::String
  attribute :international_first_name_initial,  Types::FirstNameInitial
  attribute :pl_name,                           Types::String
  attribute :playing_position,                  Types::String
  attribute :s_assists,                         Types::Integer
  attribute :s_blocks,                          Types::Integer
  attribute :s_blocks_received,                 Types::Integer
  attribute :s_field_goals_attempted,           Types::Integer
  attribute :s_field_goals_made,                Types::Integer
  attribute :s_field_goals_percentage,          Types::Integer
  attribute :s_fouls_on,                        Types::Integer
  attribute :s_fouls_personal,                  Types::Integer
  attribute :s_free_throws_attempted,           Types::Integer
  attribute :s_free_throws_made,                Types::Integer
  attribute :s_free_throws_percentage,          Types::Integer
  attribute :s_minutes,                         Types.Instance(SMinutes)
  attribute :s_plus_minus_points,               Types::Integer
  attribute :s_points,                          Types::Integer
  attribute :s_points_fast_break,               Types::Integer
  attribute :s_points_in_the_paint,             Types::Integer
  attribute :s_points_second_chance,            Types::Integer
  attribute :s_rebounds_defensive,              Types::Integer
  attribute :s_rebounds_offensive,              Types::Integer
  attribute :s_rebounds_total,                  Types::Integer
  attribute :s_steals,                          Types::Integer
  attribute :s_three_pointers_attempted,        Types::Integer
  attribute :s_three_pointers_made,             Types::Integer
  attribute :s_three_pointers_percentage,       Types::Integer
  attribute :s_turnovers,                       Types::Integer
  attribute :s_two_pointers_attempted,          Types::Integer
  attribute :s_two_pointers_made,               Types::Integer
  attribute :s_two_pointers_percentage,         Types::Integer
  attribute :shirt_number,                      Types::String
  attribute :starter,                           Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      active:                            d.fetch("active"),
      captain:                           d.key?("captain") ? Types::Integer[d["captain"]] : nil,
      comp:                              d.key?("comp") ? Comp.from_dynamic!(d["comp"]) : nil,
      eff_1:                             d.fetch("eff_1"),
      eff_2:                             d.fetch("eff_2"),
      eff_3:                             d.fetch("eff_3"),
      eff_4:                             d.fetch("eff_4"),
      eff_5:                             d.fetch("eff_5"),
      eff_6:                             d.fetch("eff_6"),
      eff_7:                             d.fetch("eff_7"),
      family_name:                       d.fetch("familyName"),
      family_name_initial:               d.fetch("familyNameInitial"),
      first_name:                        d.fetch("firstName"),
      first_name_initial:                d.fetch("firstNameInitial"),
      international_family_name:         d.fetch("internationalFamilyName"),
      international_family_name_initial: d.fetch("internationalFamilyNameInitial"),
      international_first_name:          d.fetch("internationalFirstName"),
      international_first_name_initial:  d.fetch("internationalFirstNameInitial"),
      pl_name:                           d.fetch("name"),
      playing_position:                  d.fetch("playingPosition"),
      s_assists:                         d.fetch("sAssists"),
      s_blocks:                          d.fetch("sBlocks"),
      s_blocks_received:                 d.fetch("sBlocksReceived"),
      s_field_goals_attempted:           d.fetch("sFieldGoalsAttempted"),
      s_field_goals_made:                d.fetch("sFieldGoalsMade"),
      s_field_goals_percentage:          d.fetch("sFieldGoalsPercentage"),
      s_fouls_on:                        d.fetch("sFoulsOn"),
      s_fouls_personal:                  d.fetch("sFoulsPersonal"),
      s_free_throws_attempted:           d.fetch("sFreeThrowsAttempted"),
      s_free_throws_made:                d.fetch("sFreeThrowsMade"),
      s_free_throws_percentage:          d.fetch("sFreeThrowsPercentage"),
      s_minutes:                         SMinutes.from_dynamic!(d.fetch("sMinutes")),
      s_plus_minus_points:               d.fetch("sPlusMinusPoints"),
      s_points:                          d.fetch("sPoints"),
      s_points_fast_break:               d.fetch("sPointsFastBreak"),
      s_points_in_the_paint:             d.fetch("sPointsInThePaint"),
      s_points_second_chance:            d.fetch("sPointsSecondChance"),
      s_rebounds_defensive:              d.fetch("sReboundsDefensive"),
      s_rebounds_offensive:              d.fetch("sReboundsOffensive"),
      s_rebounds_total:                  d.fetch("sReboundsTotal"),
      s_steals:                          d.fetch("sSteals"),
      s_three_pointers_attempted:        d.fetch("sThreePointersAttempted"),
      s_three_pointers_made:             d.fetch("sThreePointersMade"),
      s_three_pointers_percentage:       d.fetch("sThreePointersPercentage"),
      s_turnovers:                       d.fetch("sTurnovers"),
      s_two_pointers_attempted:          d.fetch("sTwoPointersAttempted"),
      s_two_pointers_made:               d.fetch("sTwoPointersMade"),
      s_two_pointers_percentage:         d.fetch("sTwoPointersPercentage"),
      shirt_number:                      d.fetch("shirtNumber"),
      starter:                           d.fetch("starter"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "active"                         => active,
      "captain"                        => captain,
      "comp"                           => comp&.to_dynamic,
      "eff_1"                          => eff_1,
      "eff_2"                          => eff_2,
      "eff_3"                          => eff_3,
      "eff_4"                          => eff_4,
      "eff_5"                          => eff_5,
      "eff_6"                          => eff_6,
      "eff_7"                          => eff_7,
      "familyName"                     => family_name,
      "familyNameInitial"              => family_name_initial,
      "firstName"                      => first_name,
      "firstNameInitial"               => first_name_initial,
      "internationalFamilyName"        => international_family_name,
      "internationalFamilyNameInitial" => international_family_name_initial,
      "internationalFirstName"         => international_first_name,
      "internationalFirstNameInitial"  => international_first_name_initial,
      "name"                           => pl_name,
      "playingPosition"                => playing_position,
      "sAssists"                       => s_assists,
      "sBlocks"                        => s_blocks,
      "sBlocksReceived"                => s_blocks_received,
      "sFieldGoalsAttempted"           => s_field_goals_attempted,
      "sFieldGoalsMade"                => s_field_goals_made,
      "sFieldGoalsPercentage"          => s_field_goals_percentage,
      "sFoulsOn"                       => s_fouls_on,
      "sFoulsPersonal"                 => s_fouls_personal,
      "sFreeThrowsAttempted"           => s_free_throws_attempted,
      "sFreeThrowsMade"                => s_free_throws_made,
      "sFreeThrowsPercentage"          => s_free_throws_percentage,
      "sMinutes"                       => s_minutes.to_dynamic,
      "sPlusMinusPoints"               => s_plus_minus_points,
      "sPoints"                        => s_points,
      "sPointsFastBreak"               => s_points_fast_break,
      "sPointsInThePaint"              => s_points_in_the_paint,
      "sPointsSecondChance"            => s_points_second_chance,
      "sReboundsDefensive"             => s_rebounds_defensive,
      "sReboundsOffensive"             => s_rebounds_offensive,
      "sReboundsTotal"                 => s_rebounds_total,
      "sSteals"                        => s_steals,
      "sThreePointersAttempted"        => s_three_pointers_attempted,
      "sThreePointersMade"             => s_three_pointers_made,
      "sThreePointersPercentage"       => s_three_pointers_percentage,
      "sTurnovers"                     => s_turnovers,
      "sTwoPointersAttempted"          => s_two_pointers_attempted,
      "sTwoPointersMade"               => s_two_pointers_made,
      "sTwoPointersPercentage"         => s_two_pointers_percentage,
      "shirtNumber"                    => shirt_number,
      "starter"                        => starter,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module SubType
  Jumpshot = "jumpshot"
  Layup    = "layup"
  Dunk     = "dunk"
end

class Shot < Dry::Struct
  attribute :action_type,  Types::ActionType
  attribute :per,          Types::Integer
  attribute :per_type,     Types::PerType
  attribute :player,       Types::String
  attribute :pno,          Types::Integer
  attribute :r,            Types::Integer
  attribute :shirt_number, Types::String
  attribute :shot_p,       Types::Integer
  attribute :sub_type,     Types::SubType
  attribute :tno,          Types::Integer
  attribute :x,            Types::Integer
  attribute :y,            Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      action_type:  d.fetch("actionType"),
      per:          d.fetch("per"),
      per_type:     d.fetch("perType"),
      player:       d.fetch("player"),
      pno:          d.fetch("pno"),
      r:            d.fetch("r"),
      shirt_number: d.fetch("shirtNumber"),
      shot_p:       d.fetch("p"),
      sub_type:     d.fetch("subType"),
      tno:          d.fetch("tno"),
      x:            d.fetch("x"),
      y:            d.fetch("y"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "actionType"  => action_type,
      "per"         => per,
      "perType"     => per_type,
      "player"      => player,
      "pno"         => pno,
      "r"           => r,
      "shirtNumber" => shirt_number,
      "p"           => shot_p,
      "subType"     => sub_type,
      "tno"         => tno,
      "x"           => x,
      "y"           => y,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Tm < Dry::Struct
  attribute :code,                            Types::String
  attribute :code_international,              Types::String
  attribute :fouls,                           Types::Integer
  attribute :full_score,                      Types::Integer
  attribute :lds,                             Lds
  attribute :logo,                            Types::String
  attribute :name_international,              Types::String
  attribute :p1_score,                        Types::Integer
  attribute :p2_score,                        Types::Integer
  attribute :p3_score,                        Types::Integer
  attribute :p4_score,                        Types::Integer
  attribute :pl,                              Types::Hash.meta(of: Pl)
  attribute :score,                           Types::Integer
  attribute :scoring,                         Types.Array(Scorer)
  attribute :short_name,                      Types::String
  attribute :short_name_international,        Types::String
  attribute :shot,                            Types.Array(Shot)
  attribute :timeouts,                        Types::Integer
  attribute :tm_name,                         Types::String
  attribute :tot_eff_1,                       Types::Integer
  attribute :tot_eff_2,                       Types::Integer
  attribute :tot_eff_3,                       Types::Double
  attribute :tot_eff_4,                       Types::Integer
  attribute :tot_eff_5,                       Types::Integer
  attribute :tot_eff_6,                       Types::Integer
  attribute :tot_eff_7,                       Types::Integer
  attribute :tot_s_assists,                   Types::Integer
  attribute :tot_s_bench_points,              Types::Integer
  attribute :tot_s_biggest_lead,              Types::Integer
  attribute :tot_s_biggest_scoring_run,       Types::Integer
  attribute :tot_s_blocks,                    Types::Integer
  attribute :tot_s_blocks_received,           Types::Integer
  attribute :tot_s_field_goals_attempted,     Types::Integer
  attribute :tot_s_field_goals_made,          Types::Integer
  attribute :tot_s_field_goals_percentage,    Types::Integer
  attribute :tot_s_fouls_on,                  Types::Integer
  attribute :tot_s_fouls_personal,            Types::Integer
  attribute :tot_s_fouls_team,                Types::Integer
  attribute :tot_s_free_throws_attempted,     Types::Integer
  attribute :tot_s_free_throws_made,          Types::Integer
  attribute :tot_s_free_throws_percentage,    Types::Integer
  attribute :tot_s_lead_changes,              Types::Integer
  attribute :tot_s_minutes,                   Types::Integer
  attribute :tot_s_points,                    Types::Integer
  attribute :tot_s_points_fast_break,         Types::Integer
  attribute :tot_s_points_from_turnovers,     Types::Integer
  attribute :tot_s_points_in_the_paint,       Types::Integer
  attribute :tot_s_points_second_chance,      Types::Integer
  attribute :tot_s_rebounds_defensive,        Types::Integer
  attribute :tot_s_rebounds_offensive,        Types::Integer
  attribute :tot_s_rebounds_team,             Types::Integer
  attribute :tot_s_rebounds_team_defensive,   Types::Integer
  attribute :tot_s_rebounds_team_offensive,   Types::Integer
  attribute :tot_s_rebounds_total,            Types::Integer
  attribute :tot_s_steals,                    Types::Integer
  attribute :tot_s_three_pointers_attempted,  Types::Integer
  attribute :tot_s_three_pointers_made,       Types::Integer
  attribute :tot_s_three_pointers_percentage, Types::Integer
  attribute :tot_s_time_leading,              Types::Double
  attribute :tot_s_times_scores_level,        Types::Integer
  attribute :tot_s_turnovers,                 Types::Integer
  attribute :tot_s_turnovers_team,            Types::Integer
  attribute :tot_s_two_pointers_attempted,    Types::Integer
  attribute :tot_s_two_pointers_made,         Types::Integer
  attribute :tot_s_two_pointers_percentage,   Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      code:                            d.fetch("code"),
      code_international:              d.fetch("codeInternational"),
      fouls:                           d.fetch("fouls"),
      full_score:                      d.fetch("full_score"),
      lds:                             Lds.from_dynamic!(d.fetch("lds")),
      logo:                            d.fetch("logo"),
      name_international:              d.fetch("nameInternational"),
      p1_score:                        d.fetch("p1_score"),
      p2_score:                        d.fetch("p2_score"),
      p3_score:                        d.fetch("p3_score"),
      p4_score:                        d.fetch("p4_score"),
      pl:                              Types::Hash[d.fetch("pl")].map { |k, v| [k, Pl.from_dynamic!(v)] }.to_h,
      score:                           d.fetch("score"),
      scoring:                         d.fetch("scoring").map { |x| Scorer.from_dynamic!(x) },
      short_name:                      d.fetch("shortName"),
      short_name_international:        d.fetch("shortNameInternational"),
      shot:                            d.fetch("shot").map { |x| Shot.from_dynamic!(x) },
      timeouts:                        d.fetch("timeouts"),
      tm_name:                         d.fetch("name"),
      tot_eff_1:                       d.fetch("tot_eff_1"),
      tot_eff_2:                       d.fetch("tot_eff_2"),
      tot_eff_3:                       d.fetch("tot_eff_3"),
      tot_eff_4:                       d.fetch("tot_eff_4"),
      tot_eff_5:                       d.fetch("tot_eff_5"),
      tot_eff_6:                       d.fetch("tot_eff_6"),
      tot_eff_7:                       d.fetch("tot_eff_7"),
      tot_s_assists:                   d.fetch("tot_sAssists"),
      tot_s_bench_points:              d.fetch("tot_sBenchPoints"),
      tot_s_biggest_lead:              d.fetch("tot_sBiggestLead"),
      tot_s_biggest_scoring_run:       d.fetch("tot_sBiggestScoringRun"),
      tot_s_blocks:                    d.fetch("tot_sBlocks"),
      tot_s_blocks_received:           d.fetch("tot_sBlocksReceived"),
      tot_s_field_goals_attempted:     d.fetch("tot_sFieldGoalsAttempted"),
      tot_s_field_goals_made:          d.fetch("tot_sFieldGoalsMade"),
      tot_s_field_goals_percentage:    d.fetch("tot_sFieldGoalsPercentage"),
      tot_s_fouls_on:                  d.fetch("tot_sFoulsOn"),
      tot_s_fouls_personal:            d.fetch("tot_sFoulsPersonal"),
      tot_s_fouls_team:                d.fetch("tot_sFoulsTeam"),
      tot_s_free_throws_attempted:     d.fetch("tot_sFreeThrowsAttempted"),
      tot_s_free_throws_made:          d.fetch("tot_sFreeThrowsMade"),
      tot_s_free_throws_percentage:    d.fetch("tot_sFreeThrowsPercentage"),
      tot_s_lead_changes:              d.fetch("tot_sLeadChanges"),
      tot_s_minutes:                   d.fetch("tot_sMinutes"),
      tot_s_points:                    d.fetch("tot_sPoints"),
      tot_s_points_fast_break:         d.fetch("tot_sPointsFastBreak"),
      tot_s_points_from_turnovers:     d.fetch("tot_sPointsFromTurnovers"),
      tot_s_points_in_the_paint:       d.fetch("tot_sPointsInThePaint"),
      tot_s_points_second_chance:      d.fetch("tot_sPointsSecondChance"),
      tot_s_rebounds_defensive:        d.fetch("tot_sReboundsDefensive"),
      tot_s_rebounds_offensive:        d.fetch("tot_sReboundsOffensive"),
      tot_s_rebounds_team:             d.fetch("tot_sReboundsTeam"),
      tot_s_rebounds_team_defensive:   d.fetch("tot_sReboundsTeamDefensive"),
      tot_s_rebounds_team_offensive:   d.fetch("tot_sReboundsTeamOffensive"),
      tot_s_rebounds_total:            d.fetch("tot_sReboundsTotal"),
      tot_s_steals:                    d.fetch("tot_sSteals"),
      tot_s_three_pointers_attempted:  d.fetch("tot_sThreePointersAttempted"),
      tot_s_three_pointers_made:       d.fetch("tot_sThreePointersMade"),
      tot_s_three_pointers_percentage: d.fetch("tot_sThreePointersPercentage"),
      tot_s_time_leading:              d.fetch("tot_sTimeLeading"),
      tot_s_times_scores_level:        d.fetch("tot_sTimesScoresLevel"),
      tot_s_turnovers:                 d.fetch("tot_sTurnovers"),
      tot_s_turnovers_team:            d.fetch("tot_sTurnoversTeam"),
      tot_s_two_pointers_attempted:    d.fetch("tot_sTwoPointersAttempted"),
      tot_s_two_pointers_made:         d.fetch("tot_sTwoPointersMade"),
      tot_s_two_pointers_percentage:   d.fetch("tot_sTwoPointersPercentage"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "code"                         => code,
      "codeInternational"            => code_international,
      "fouls"                        => fouls,
      "full_score"                   => full_score,
      "lds"                          => lds.to_dynamic,
      "logo"                         => logo,
      "nameInternational"            => name_international,
      "p1_score"                     => p1_score,
      "p2_score"                     => p2_score,
      "p3_score"                     => p3_score,
      "p4_score"                     => p4_score,
      "pl"                           => pl.map { |k, v| [k, v.to_dynamic] }.to_h,
      "score"                        => score,
      "scoring"                      => scoring.map { |x| x.to_dynamic },
      "shortName"                    => short_name,
      "shortNameInternational"       => short_name_international,
      "shot"                         => shot.map { |x| x.to_dynamic },
      "timeouts"                     => timeouts,
      "name"                         => tm_name,
      "tot_eff_1"                    => tot_eff_1,
      "tot_eff_2"                    => tot_eff_2,
      "tot_eff_3"                    => tot_eff_3,
      "tot_eff_4"                    => tot_eff_4,
      "tot_eff_5"                    => tot_eff_5,
      "tot_eff_6"                    => tot_eff_6,
      "tot_eff_7"                    => tot_eff_7,
      "tot_sAssists"                 => tot_s_assists,
      "tot_sBenchPoints"             => tot_s_bench_points,
      "tot_sBiggestLead"             => tot_s_biggest_lead,
      "tot_sBiggestScoringRun"       => tot_s_biggest_scoring_run,
      "tot_sBlocks"                  => tot_s_blocks,
      "tot_sBlocksReceived"          => tot_s_blocks_received,
      "tot_sFieldGoalsAttempted"     => tot_s_field_goals_attempted,
      "tot_sFieldGoalsMade"          => tot_s_field_goals_made,
      "tot_sFieldGoalsPercentage"    => tot_s_field_goals_percentage,
      "tot_sFoulsOn"                 => tot_s_fouls_on,
      "tot_sFoulsPersonal"           => tot_s_fouls_personal,
      "tot_sFoulsTeam"               => tot_s_fouls_team,
      "tot_sFreeThrowsAttempted"     => tot_s_free_throws_attempted,
      "tot_sFreeThrowsMade"          => tot_s_free_throws_made,
      "tot_sFreeThrowsPercentage"    => tot_s_free_throws_percentage,
      "tot_sLeadChanges"             => tot_s_lead_changes,
      "tot_sMinutes"                 => tot_s_minutes,
      "tot_sPoints"                  => tot_s_points,
      "tot_sPointsFastBreak"         => tot_s_points_fast_break,
      "tot_sPointsFromTurnovers"     => tot_s_points_from_turnovers,
      "tot_sPointsInThePaint"        => tot_s_points_in_the_paint,
      "tot_sPointsSecondChance"      => tot_s_points_second_chance,
      "tot_sReboundsDefensive"       => tot_s_rebounds_defensive,
      "tot_sReboundsOffensive"       => tot_s_rebounds_offensive,
      "tot_sReboundsTeam"            => tot_s_rebounds_team,
      "tot_sReboundsTeamDefensive"   => tot_s_rebounds_team_defensive,
      "tot_sReboundsTeamOffensive"   => tot_s_rebounds_team_offensive,
      "tot_sReboundsTotal"           => tot_s_rebounds_total,
      "tot_sSteals"                  => tot_s_steals,
      "tot_sThreePointersAttempted"  => tot_s_three_pointers_attempted,
      "tot_sThreePointersMade"       => tot_s_three_pointers_made,
      "tot_sThreePointersPercentage" => tot_s_three_pointers_percentage,
      "tot_sTimeLeading"             => tot_s_time_leading,
      "tot_sTimesScoresLevel"        => tot_s_times_scores_level,
      "tot_sTurnovers"               => tot_s_turnovers,
      "tot_sTurnoversTeam"           => tot_s_turnovers_team,
      "tot_sTwoPointersAttempted"    => tot_s_two_pointers_attempted,
      "tot_sTwoPointersMade"         => tot_s_two_pointers_made,
      "tot_sTwoPointersPercentage"   => tot_s_two_pointers_percentage,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Totallds < Dry::Struct
  attribute :s_assists,        Types::Hash.meta(of: Scorer)
  attribute :s_blocks,         Types::Hash.meta(of: Scorer)
  attribute :s_points,         Types::Hash.meta(of: Scorer)
  attribute :s_rebounds_total, Types::Hash.meta(of: Scorer)
  attribute :s_steals,         Types::Hash.meta(of: Scorer)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      s_assists:        Types::Hash[d.fetch("sAssists")].map { |k, v| [k, Scorer.from_dynamic!(v)] }.to_h,
      s_blocks:         Types::Hash[d.fetch("sBlocks")].map { |k, v| [k, Scorer.from_dynamic!(v)] }.to_h,
      s_points:         Types::Hash[d.fetch("sPoints")].map { |k, v| [k, Scorer.from_dynamic!(v)] }.to_h,
      s_rebounds_total: Types::Hash[d.fetch("sReboundsTotal")].map { |k, v| [k, Scorer.from_dynamic!(v)] }.to_h,
      s_steals:         Types::Hash[d.fetch("sSteals")].map { |k, v| [k, Scorer.from_dynamic!(v)] }.to_h,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "sAssists"       => s_assists.map { |k, v| [k, v.to_dynamic] }.to_h,
      "sBlocks"        => s_blocks.map { |k, v| [k, v.to_dynamic] }.to_h,
      "sPoints"        => s_points.map { |k, v| [k, v.to_dynamic] }.to_h,
      "sReboundsTotal" => s_rebounds_total.map { |k, v| [k, v.to_dynamic] }.to_h,
      "sSteals"        => s_steals.map { |k, v| [k, v.to_dynamic] }.to_h,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :attendance,             Types::Integer
  attribute :clock,                  Types::String
  attribute :disable_match,          Types::Integer
  attribute :in_ot,                  Types::Integer
  attribute :leaddata,               Types.Array(Types.Array(Types.Instance(LeaddatumElement)))
  attribute :officials_referee1,     Types::String
  attribute :officials_referee2,     Types::String
  attribute :officials_referee3,     Types::String
  attribute :othermatches,           Types.Array(Othermatch)
  attribute :pbp,                    Types.Array(Pbp)
  attribute :period,                 Types::Integer
  attribute :period_length_overtime, Types::Integer
  attribute :period_length_regular,  Types::Integer
  attribute :period_type,            Types::PerType
  attribute :periods_max,            Types::Integer
  attribute :scorers,                Types::Hash.meta(of: Types.Array(Scorer))
  attribute :timeline,               Types.Array(Types::Any)
  attribute :tm,                     Types::Hash.meta(of: Tm)
  attribute :total_time_added,       Types::Integer
  attribute :totallds,               Totallds

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      attendance:             d.fetch("attendance"),
      clock:                  d.fetch("clock"),
      disable_match:          d.fetch("disableMatch"),
      in_ot:                  d.fetch("inOT"),
      leaddata:               d.fetch("leaddata").map { |x| x.map { |x| LeaddatumElement.from_dynamic!(x) } },
      officials_referee1:     d.fetch("officials_referee1"),
      officials_referee2:     d.fetch("officials_referee2"),
      officials_referee3:     d.fetch("officials_referee3"),
      othermatches:           d.fetch("othermatches").map { |x| Othermatch.from_dynamic!(x) },
      pbp:                    d.fetch("pbp").map { |x| Pbp.from_dynamic!(x) },
      period:                 d.fetch("period"),
      period_length_overtime: d.fetch("periodLengthOVERTIME"),
      period_length_regular:  d.fetch("periodLengthREGULAR"),
      period_type:            d.fetch("periodType"),
      periods_max:            d.fetch("periodsMax"),
      scorers:                Types::Hash[d.fetch("scorers")].map { |k, v| [k, v.map { |x| Scorer.from_dynamic!(x) }] }.to_h,
      timeline:               d.fetch("timeline"),
      tm:                     Types::Hash[d.fetch("tm")].map { |k, v| [k, Tm.from_dynamic!(v)] }.to_h,
      total_time_added:       d.fetch("totalTimeAdded"),
      totallds:               Totallds.from_dynamic!(d.fetch("totallds")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "attendance"           => attendance,
      "clock"                => clock,
      "disableMatch"         => disable_match,
      "inOT"                 => in_ot,
      "leaddata"             => leaddata.map { |x| x.map { |x| x.to_dynamic } },
      "officials_referee1"   => officials_referee1,
      "officials_referee2"   => officials_referee2,
      "officials_referee3"   => officials_referee3,
      "othermatches"         => othermatches.map { |x| x.to_dynamic },
      "pbp"                  => pbp.map { |x| x.to_dynamic },
      "period"               => period,
      "periodLengthOVERTIME" => period_length_overtime,
      "periodLengthREGULAR"  => period_length_regular,
      "periodType"           => period_type,
      "periodsMax"           => periods_max,
      "scorers"              => scorers.map { |k, v| [k, v.map { |x| x.to_dynamic }] }.to_h,
      "timeline"             => timeline,
      "tm"                   => tm.map { |k, v| [k, v.to_dynamic] }.to_h,
      "totalTimeAdded"       => total_time_added,
      "totallds"             => totallds.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
