require "json"

class TopLevel
  include JSON::Serializable

  property attendance : Int64

  property clock : String

  @[JSON::Field(key: "disableMatch")]
  property disable_match : Int64

  @[JSON::Field(key: "inOT")]
  property in_ot : Int64

  property leaddata : Array(Array(LeaddatumElement))

  property officials_referee1 : String

  property officials_referee2 : String

  property officials_referee3 : String

  property othermatches : Array(Othermatch)

  property pbp : Array(Pbp)

  property period : Int64

  @[JSON::Field(key: "periodLengthOVERTIME")]
  property period_length_overtime : Int64

  @[JSON::Field(key: "periodLengthREGULAR")]
  property period_length_regular : Int64

  @[JSON::Field(key: "periodType")]
  property period_type : String

  @[JSON::Field(key: "periodsMax")]
  property periods_max : Int64

  property scorers : Hash(String, Array(Scorer))

  property timeline : Array(JSON::Any?)

  property tm : Hash(String, Tm)

  @[JSON::Field(key: "totalTimeAdded")]
  property total_time_added : Int64

  property totallds : Totallds
end

class Othermatch
  include JSON::Serializable

  property clock : String

  @[JSON::Field(key: "competitionName")]
  property competition_name : String

  property id : String

  property period : Int64

  @[JSON::Field(key: "periodType")]
  property period_type : String

  property team1 : Team

  @[JSON::Field(key: "team1Name")]
  property team1_name : String

  @[JSON::Field(key: "team1Score")]
  property team1_score : Int64

  property team2 : Team

  @[JSON::Field(key: "team2Name")]
  property team2_name : String

  @[JSON::Field(key: "team2Score")]
  property team2_score : Int64
end

class Team
  include JSON::Serializable

  @[JSON::Field(key: "teamCode")]
  property team_code : String

  @[JSON::Field(key: "teamCodeInternational")]
  property team_code_international : String

  @[JSON::Field(key: "teamName")]
  property team_name : String

  @[JSON::Field(key: "teamNameInternational")]
  property team_name_international : String
end

class Pbp
  include JSON::Serializable

  @[JSON::Field(key: "actionType")]
  property action_type : String

  @[JSON::Field(key: "familyName")]
  property family_name : String?

  @[JSON::Field(key: "familyNameInitial")]
  property family_name_initial : String?

  @[JSON::Field(key: "firstName")]
  property first_name : String?

  @[JSON::Field(key: "firstNameInitial")]
  property first_name_initial : String?

  property gt : String

  @[JSON::Field(key: "internationalFamilyName")]
  property international_family_name : String?

  @[JSON::Field(key: "internationalFamilyNameInitial")]
  property international_family_name_initial : String?

  @[JSON::Field(key: "internationalFirstName")]
  property international_first_name : String?

  @[JSON::Field(key: "internationalFirstNameInitial")]
  property international_first_name_initial : String?

  property lead : Int64

  property period : Int64

  @[JSON::Field(key: "periodType")]
  property period_type : String

  property player : String

  property pno : Int64

  property qualifier : String

  property s1 : Int64

  property s2 : Int64

  @[JSON::Field(key: "scoreboardName")]
  property scoreboard_name : String?

  property scoring : Int64

  @[JSON::Field(key: "shirtNumber")]
  property shirt_number : String

  @[JSON::Field(key: "subType")]
  property sub_type : String

  property success : Int64

  property tno : Int64
end

class Scorer
  include JSON::Serializable

  @[JSON::Field(key: "familyName")]
  property family_name : String?

  @[JSON::Field(key: "familyNameInitial")]
  property family_name_initial : String?

  @[JSON::Field(key: "firstName")]
  property first_name : String?

  @[JSON::Field(key: "firstNameInitial")]
  property first_name_initial : String?

  property gt : String?

  @[JSON::Field(key: "internationalFamilyName")]
  property international_family_name : String?

  @[JSON::Field(key: "internationalFamilyNameInitial")]
  property international_family_name_initial : String?

  @[JSON::Field(key: "internationalFirstName")]
  property international_first_name : String?

  @[JSON::Field(key: "internationalFirstNameInitial")]
  property international_first_name_initial : String?

  property name : String?

  property per : Int64?

  @[JSON::Field(key: "perType")]
  property per_type : String?

  property player : String?

  property pno : Int64

  @[JSON::Field(key: "scoreboardName")]
  property scoreboard_name : String?

  @[JSON::Field(key: "shirtNumber")]
  property shirt_number : String

  property summary : String?

  property times : Array(TimeElement)?

  property tno : Int64

  property tot : Int64?
end

class TimeElement
  include JSON::Serializable

  property gt : String

  property per : Int64

  @[JSON::Field(key: "perType")]
  property per_type : String
end

class Tm
  include JSON::Serializable

  property code : String

  @[JSON::Field(key: "codeInternational")]
  property code_international : String

  property fouls : Int64

  property full_score : Int64

  property lds : Lds

  property logo : String

  property name : String

  @[JSON::Field(key: "nameInternational")]
  property name_international : String

  property p1_score : Int64

  property p2_score : Int64

  property p3_score : Int64

  property p4_score : Int64

  property pl : Hash(String, Pl)

  property score : Int64

  property scoring : Array(Scorer)

  @[JSON::Field(key: "shortName")]
  property short_name : String

  @[JSON::Field(key: "shortNameInternational")]
  property short_name_international : String

  property shot : Array(Shot)

  property timeouts : Int64

  property tot_eff_1 : Int64

  property tot_eff_2 : Int64

  property tot_eff_3 : Float64

  property tot_eff_4 : Int64

  property tot_eff_5 : Int64

  property tot_eff_6 : Int64

  property tot_eff_7 : Int64

  @[JSON::Field(key: "tot_sAssists")]
  property tot_s_assists : Int64

  @[JSON::Field(key: "tot_sBenchPoints")]
  property tot_s_bench_points : Int64

  @[JSON::Field(key: "tot_sBiggestLead")]
  property tot_s_biggest_lead : Int64

  @[JSON::Field(key: "tot_sBiggestScoringRun")]
  property tot_s_biggest_scoring_run : Int64

  @[JSON::Field(key: "tot_sBlocks")]
  property tot_s_blocks : Int64

  @[JSON::Field(key: "tot_sBlocksReceived")]
  property tot_s_blocks_received : Int64

  @[JSON::Field(key: "tot_sFieldGoalsAttempted")]
  property tot_s_field_goals_attempted : Int64

  @[JSON::Field(key: "tot_sFieldGoalsMade")]
  property tot_s_field_goals_made : Int64

  @[JSON::Field(key: "tot_sFieldGoalsPercentage")]
  property tot_s_field_goals_percentage : Int64

  @[JSON::Field(key: "tot_sFoulsOn")]
  property tot_s_fouls_on : Int64

  @[JSON::Field(key: "tot_sFoulsPersonal")]
  property tot_s_fouls_personal : Int64

  @[JSON::Field(key: "tot_sFoulsTeam")]
  property tot_s_fouls_team : Int64

  @[JSON::Field(key: "tot_sFreeThrowsAttempted")]
  property tot_s_free_throws_attempted : Int64

  @[JSON::Field(key: "tot_sFreeThrowsMade")]
  property tot_s_free_throws_made : Int64

  @[JSON::Field(key: "tot_sFreeThrowsPercentage")]
  property tot_s_free_throws_percentage : Int64

  @[JSON::Field(key: "tot_sLeadChanges")]
  property tot_s_lead_changes : Int64

  @[JSON::Field(key: "tot_sMinutes")]
  property tot_s_minutes : Int64

  @[JSON::Field(key: "tot_sPoints")]
  property tot_s_points : Int64

  @[JSON::Field(key: "tot_sPointsFastBreak")]
  property tot_s_points_fast_break : Int64

  @[JSON::Field(key: "tot_sPointsFromTurnovers")]
  property tot_s_points_from_turnovers : Int64

  @[JSON::Field(key: "tot_sPointsInThePaint")]
  property tot_s_points_in_the_paint : Int64

  @[JSON::Field(key: "tot_sPointsSecondChance")]
  property tot_s_points_second_chance : Int64

  @[JSON::Field(key: "tot_sReboundsDefensive")]
  property tot_s_rebounds_defensive : Int64

  @[JSON::Field(key: "tot_sReboundsOffensive")]
  property tot_s_rebounds_offensive : Int64

  @[JSON::Field(key: "tot_sReboundsTeam")]
  property tot_s_rebounds_team : Int64

  @[JSON::Field(key: "tot_sReboundsTeamDefensive")]
  property tot_s_rebounds_team_defensive : Int64

  @[JSON::Field(key: "tot_sReboundsTeamOffensive")]
  property tot_s_rebounds_team_offensive : Int64

  @[JSON::Field(key: "tot_sReboundsTotal")]
  property tot_s_rebounds_total : Int64

  @[JSON::Field(key: "tot_sSteals")]
  property tot_s_steals : Int64

  @[JSON::Field(key: "tot_sThreePointersAttempted")]
  property tot_s_three_pointers_attempted : Int64

  @[JSON::Field(key: "tot_sThreePointersMade")]
  property tot_s_three_pointers_made : Int64

  @[JSON::Field(key: "tot_sThreePointersPercentage")]
  property tot_s_three_pointers_percentage : Int64

  @[JSON::Field(key: "tot_sTimeLeading")]
  property tot_s_time_leading : Float64

  @[JSON::Field(key: "tot_sTimesScoresLevel")]
  property tot_s_times_scores_level : Int64

  @[JSON::Field(key: "tot_sTurnovers")]
  property tot_s_turnovers : Int64

  @[JSON::Field(key: "tot_sTurnoversTeam")]
  property tot_s_turnovers_team : Int64

  @[JSON::Field(key: "tot_sTwoPointersAttempted")]
  property tot_s_two_pointers_attempted : Int64

  @[JSON::Field(key: "tot_sTwoPointersMade")]
  property tot_s_two_pointers_made : Int64

  @[JSON::Field(key: "tot_sTwoPointersPercentage")]
  property tot_s_two_pointers_percentage : Int64
end

class Lds
  include JSON::Serializable

  @[JSON::Field(key: "sAssists")]
  property s_assists : Hash(String, Scorer)

  @[JSON::Field(key: "sBlocks")]
  property s_blocks : SBlocks

  @[JSON::Field(key: "sPoints")]
  property s_points : Hash(String, Scorer)

  @[JSON::Field(key: "sReboundsTotal")]
  property s_rebounds_total : Hash(String, Scorer)

  @[JSON::Field(key: "sSteals")]
  property s_steals : Hash(String, Scorer)
end

class SBlocks
  include JSON::Serializable

  @[JSON::Field(key: "1")]
  property the_1 : Scorer
end

class Pl
  include JSON::Serializable

  property active : Int64

  property captain : Int64?

  property comp : Comp?

  property eff_1 : Int64

  property eff_2 : Int64

  property eff_3 : Float64

  property eff_4 : Float64

  property eff_5 : Int64

  property eff_6 : Int64

  property eff_7 : Int64

  @[JSON::Field(key: "familyName")]
  property family_name : String

  @[JSON::Field(key: "familyNameInitial")]
  property family_name_initial : String

  @[JSON::Field(key: "firstName")]
  property first_name : String

  @[JSON::Field(key: "firstNameInitial")]
  property first_name_initial : String

  @[JSON::Field(key: "internationalFamilyName")]
  property international_family_name : String

  @[JSON::Field(key: "internationalFamilyNameInitial")]
  property international_family_name_initial : String

  @[JSON::Field(key: "internationalFirstName")]
  property international_first_name : String

  @[JSON::Field(key: "internationalFirstNameInitial")]
  property international_first_name_initial : String

  property name : String

  @[JSON::Field(key: "playingPosition")]
  property playing_position : String

  @[JSON::Field(key: "sAssists")]
  property s_assists : Int64

  @[JSON::Field(key: "sBlocks")]
  property s_blocks : Int64

  @[JSON::Field(key: "sBlocksReceived")]
  property s_blocks_received : Int64

  @[JSON::Field(key: "sFieldGoalsAttempted")]
  property s_field_goals_attempted : Int64

  @[JSON::Field(key: "sFieldGoalsMade")]
  property s_field_goals_made : Int64

  @[JSON::Field(key: "sFieldGoalsPercentage")]
  property s_field_goals_percentage : Int64

  @[JSON::Field(key: "sFoulsOn")]
  property s_fouls_on : Int64

  @[JSON::Field(key: "sFoulsPersonal")]
  property s_fouls_personal : Int64

  @[JSON::Field(key: "sFreeThrowsAttempted")]
  property s_free_throws_attempted : Int64

  @[JSON::Field(key: "sFreeThrowsMade")]
  property s_free_throws_made : Int64

  @[JSON::Field(key: "sFreeThrowsPercentage")]
  property s_free_throws_percentage : Int64

  @[JSON::Field(key: "sMinutes")]
  property s_minutes : SMinutes

  @[JSON::Field(key: "sPlusMinusPoints")]
  property s_plus_minus_points : Int64

  @[JSON::Field(key: "sPoints")]
  property s_points : Int64

  @[JSON::Field(key: "sPointsFastBreak")]
  property s_points_fast_break : Int64

  @[JSON::Field(key: "sPointsInThePaint")]
  property s_points_in_the_paint : Int64

  @[JSON::Field(key: "sPointsSecondChance")]
  property s_points_second_chance : Int64

  @[JSON::Field(key: "sReboundsDefensive")]
  property s_rebounds_defensive : Int64

  @[JSON::Field(key: "sReboundsOffensive")]
  property s_rebounds_offensive : Int64

  @[JSON::Field(key: "sReboundsTotal")]
  property s_rebounds_total : Int64

  @[JSON::Field(key: "sSteals")]
  property s_steals : Int64

  @[JSON::Field(key: "sThreePointersAttempted")]
  property s_three_pointers_attempted : Int64

  @[JSON::Field(key: "sThreePointersMade")]
  property s_three_pointers_made : Int64

  @[JSON::Field(key: "sThreePointersPercentage")]
  property s_three_pointers_percentage : Int64

  @[JSON::Field(key: "sTurnovers")]
  property s_turnovers : Int64

  @[JSON::Field(key: "sTwoPointersAttempted")]
  property s_two_pointers_attempted : Int64

  @[JSON::Field(key: "sTwoPointersMade")]
  property s_two_pointers_made : Int64

  @[JSON::Field(key: "sTwoPointersPercentage")]
  property s_two_pointers_percentage : Int64

  @[JSON::Field(key: "shirtNumber")]
  property shirt_number : String

  property starter : Int64
end

class Comp
  include JSON::Serializable

  @[JSON::Field(key: "sAssistsAverage")]
  property s_assists_average : Float64

  @[JSON::Field(key: "sMinutesAverage")]
  property s_minutes_average : String

  @[JSON::Field(key: "sPointsAverage")]
  property s_points_average : Float64

  @[JSON::Field(key: "sReboundsTotalAverage")]
  property s_rebounds_total_average : Float64
end

class Shot
  include JSON::Serializable

  @[JSON::Field(key: "actionType")]
  property action_type : String

  property p : Int64

  property per : Int64

  @[JSON::Field(key: "perType")]
  property per_type : String

  property player : String

  property pno : Int64

  property r : Int64

  @[JSON::Field(key: "shirtNumber")]
  property shirt_number : String

  @[JSON::Field(key: "subType")]
  property sub_type : String

  property tno : Int64

  property x : Int64

  property y : Int64
end

class Totallds
  include JSON::Serializable

  @[JSON::Field(key: "sAssists")]
  property s_assists : Hash(String, Scorer)

  @[JSON::Field(key: "sBlocks")]
  property s_blocks : Hash(String, Scorer)

  @[JSON::Field(key: "sPoints")]
  property s_points : Hash(String, Scorer)

  @[JSON::Field(key: "sReboundsTotal")]
  property s_rebounds_total : Hash(String, Scorer)

  @[JSON::Field(key: "sSteals")]
  property s_steals : Hash(String, Scorer)
end

alias LeaddatumElement = Int64 | String

alias SMinutes = Int64 | String
