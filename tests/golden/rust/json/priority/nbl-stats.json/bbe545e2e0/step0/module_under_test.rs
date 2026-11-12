// Example code that deserializes and serializes the model.
// extern crate serde;
// #[macro_use]
// extern crate serde_derive;
// extern crate serde_json;
//
// use generated_module::TopLevel;
//
// fn main() {
//     let json = r#"{"answer": 42}"#;
//     let model: TopLevel = serde_json::from_str(&json).unwrap();
// }

use serde::{Serialize, Deserialize};
use std::collections::HashMap;

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct TopLevel {
    pub attendance: i64,

    pub clock: String,

    pub disable_match: i64,

    #[serde(rename = "inOT")]
    pub in_ot: i64,

    pub leaddata: Vec<Vec<LeaddatumElement>>,

    #[serde(rename = "officials_referee1")]
    pub officials_referee1: String,

    #[serde(rename = "officials_referee2")]
    pub officials_referee2: String,

    #[serde(rename = "officials_referee3")]
    pub officials_referee3: String,

    pub othermatches: Vec<Othermatch>,

    pub pbp: Vec<Pbp>,

    pub period: i64,

    #[serde(rename = "periodLengthOVERTIME")]
    pub period_length_overtime: i64,

    #[serde(rename = "periodLengthREGULAR")]
    pub period_length_regular: i64,

    pub period_type: PerType,

    pub periods_max: i64,

    pub scorers: HashMap<String, Vec<Scorer>>,

    pub timeline: Vec<Option<serde_json::Value>>,

    pub tm: HashMap<String, Tm>,

    pub total_time_added: i64,

    pub totallds: Totallds,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum LeaddatumElement {
    Enum(LeaddatumEnum),

    Integer(i64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum LeaddatumEnum {
    #[serde(rename = "")]
    Empty,

    P1,

    P2,

    P3,

    P4,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Othermatch {
    pub clock: String,

    pub competition_name: String,

    pub id: String,

    pub period: i64,

    pub period_type: PerType,

    pub team1: Team,

    pub team1_name: String,

    pub team1_score: i64,

    pub team2: Team,

    pub team2_name: String,

    pub team2_score: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum PerType {
    #[serde(rename = "REGULAR")]
    Regular,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Team {
    pub team_code: String,

    pub team_code_international: String,

    pub team_name: String,

    pub team_name_international: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Pbp {
    pub action_type: ActionType,

    pub family_name: Option<String>,

    pub family_name_initial: Option<FamilyNameInitial>,

    pub first_name: Option<String>,

    pub first_name_initial: Option<FirstNameInitial>,

    pub gt: String,

    pub international_family_name: Option<String>,

    pub international_family_name_initial: Option<FamilyNameInitial>,

    pub international_first_name: Option<String>,

    pub international_first_name_initial: Option<FirstNameInitial>,

    pub lead: i64,

    pub period: i64,

    pub period_type: PerType,

    pub player: String,

    pub pno: i64,

    pub qualifier: String,

    pub s1: i64,

    pub s2: i64,

    pub scoreboard_name: Option<ScoreboardName>,

    pub scoring: i64,

    pub shirt_number: String,

    pub sub_type: String,

    pub success: i64,

    pub tno: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum ActionType {
    Game,

    Period,

    #[serde(rename = "3pt")]
    The3Pt,

    #[serde(rename = "2pt")]
    The2Pt,

    Rebound,

    Timeout,

    Foulon,

    Foul,

    Assist,

    Substitution,

    Freethrow,

    Steal,

    Turnover,

    Block,

    Jumpball,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum FamilyNameInitial {
    R,

    M,

    #[serde(rename = "s")]
    S,

    C,

    O,

    W,

    A,

    P,

    V,

    I,

    J,

    #[serde(rename = "S")]
    FamilyNameInitialS,

    H,

    B,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum FirstNameInitial {
    D,

    J,

    T,

    C,

    O,

    H,

    L,

    A,

    K,

    R,

    B,

    N,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum ScoreboardName {
    #[serde(rename = "")]
    Empty,

    #[serde(rename = "T. s")]
    TS,

    #[serde(rename = "R. Ihata")]
    RIhata,

    #[serde(rename = "D. Jones")]
    DJones,

    #[serde(rename = "B. Valentine")]
    BValentine,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Scorer {
    pub family_name: Option<String>,

    pub family_name_initial: Option<FamilyNameInitial>,

    pub first_name: Option<String>,

    pub first_name_initial: Option<FirstNameInitial>,

    pub gt: Option<String>,

    pub international_family_name: Option<String>,

    pub international_family_name_initial: Option<FamilyNameInitial>,

    pub international_first_name: Option<String>,

    pub international_first_name_initial: Option<FirstNameInitial>,

    pub name: Option<String>,

    pub per: Option<i64>,

    pub per_type: Option<PerType>,

    pub player: Option<String>,

    pub pno: i64,

    pub scoreboard_name: Option<ScoreboardName>,

    pub shirt_number: String,

    pub summary: Option<String>,

    pub times: Option<Vec<Time>>,

    pub tno: i64,

    pub tot: Option<i64>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Time {
    pub gt: String,

    pub per: i64,

    pub per_type: PerType,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Tm {
    pub code: String,

    #[serde(rename = "codeInternational")]
    pub code_international: String,

    pub fouls: i64,

    pub full_score: i64,

    pub lds: Lds,

    pub logo: String,

    pub name: String,

    #[serde(rename = "nameInternational")]
    pub name_international: String,

    pub p1_score: i64,

    pub p2_score: i64,

    pub p3_score: i64,

    pub p4_score: i64,

    pub pl: HashMap<String, Pl>,

    pub score: i64,

    pub scoring: Vec<Scorer>,

    #[serde(rename = "shortName")]
    pub short_name: String,

    #[serde(rename = "shortNameInternational")]
    pub short_name_international: String,

    pub shot: Vec<Shot>,

    pub timeouts: i64,

    pub tot_eff_1: i64,

    pub tot_eff_2: i64,

    pub tot_eff_3: f64,

    pub tot_eff_4: i64,

    pub tot_eff_5: i64,

    pub tot_eff_6: i64,

    pub tot_eff_7: i64,

    #[serde(rename = "tot_sAssists")]
    pub tot_s_assists: i64,

    #[serde(rename = "tot_sBenchPoints")]
    pub tot_s_bench_points: i64,

    #[serde(rename = "tot_sBiggestLead")]
    pub tot_s_biggest_lead: i64,

    #[serde(rename = "tot_sBiggestScoringRun")]
    pub tot_s_biggest_scoring_run: i64,

    #[serde(rename = "tot_sBlocks")]
    pub tot_s_blocks: i64,

    #[serde(rename = "tot_sBlocksReceived")]
    pub tot_s_blocks_received: i64,

    #[serde(rename = "tot_sFieldGoalsAttempted")]
    pub tot_s_field_goals_attempted: i64,

    #[serde(rename = "tot_sFieldGoalsMade")]
    pub tot_s_field_goals_made: i64,

    #[serde(rename = "tot_sFieldGoalsPercentage")]
    pub tot_s_field_goals_percentage: i64,

    #[serde(rename = "tot_sFoulsOn")]
    pub tot_s_fouls_on: i64,

    #[serde(rename = "tot_sFoulsPersonal")]
    pub tot_s_fouls_personal: i64,

    #[serde(rename = "tot_sFoulsTeam")]
    pub tot_s_fouls_team: i64,

    #[serde(rename = "tot_sFreeThrowsAttempted")]
    pub tot_s_free_throws_attempted: i64,

    #[serde(rename = "tot_sFreeThrowsMade")]
    pub tot_s_free_throws_made: i64,

    #[serde(rename = "tot_sFreeThrowsPercentage")]
    pub tot_s_free_throws_percentage: i64,

    #[serde(rename = "tot_sLeadChanges")]
    pub tot_s_lead_changes: i64,

    #[serde(rename = "tot_sMinutes")]
    pub tot_s_minutes: i64,

    #[serde(rename = "tot_sPoints")]
    pub tot_s_points: i64,

    #[serde(rename = "tot_sPointsFastBreak")]
    pub tot_s_points_fast_break: i64,

    #[serde(rename = "tot_sPointsFromTurnovers")]
    pub tot_s_points_from_turnovers: i64,

    #[serde(rename = "tot_sPointsInThePaint")]
    pub tot_s_points_in_the_paint: i64,

    #[serde(rename = "tot_sPointsSecondChance")]
    pub tot_s_points_second_chance: i64,

    #[serde(rename = "tot_sReboundsDefensive")]
    pub tot_s_rebounds_defensive: i64,

    #[serde(rename = "tot_sReboundsOffensive")]
    pub tot_s_rebounds_offensive: i64,

    #[serde(rename = "tot_sReboundsTeam")]
    pub tot_s_rebounds_team: i64,

    #[serde(rename = "tot_sReboundsTeamDefensive")]
    pub tot_s_rebounds_team_defensive: i64,

    #[serde(rename = "tot_sReboundsTeamOffensive")]
    pub tot_s_rebounds_team_offensive: i64,

    #[serde(rename = "tot_sReboundsTotal")]
    pub tot_s_rebounds_total: i64,

    #[serde(rename = "tot_sSteals")]
    pub tot_s_steals: i64,

    #[serde(rename = "tot_sThreePointersAttempted")]
    pub tot_s_three_pointers_attempted: i64,

    #[serde(rename = "tot_sThreePointersMade")]
    pub tot_s_three_pointers_made: i64,

    #[serde(rename = "tot_sThreePointersPercentage")]
    pub tot_s_three_pointers_percentage: i64,

    #[serde(rename = "tot_sTimeLeading")]
    pub tot_s_time_leading: f64,

    #[serde(rename = "tot_sTimesScoresLevel")]
    pub tot_s_times_scores_level: i64,

    #[serde(rename = "tot_sTurnovers")]
    pub tot_s_turnovers: i64,

    #[serde(rename = "tot_sTurnoversTeam")]
    pub tot_s_turnovers_team: i64,

    #[serde(rename = "tot_sTwoPointersAttempted")]
    pub tot_s_two_pointers_attempted: i64,

    #[serde(rename = "tot_sTwoPointersMade")]
    pub tot_s_two_pointers_made: i64,

    #[serde(rename = "tot_sTwoPointersPercentage")]
    pub tot_s_two_pointers_percentage: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Lds {
    pub s_assists: HashMap<String, Scorer>,

    pub s_blocks: SBlocks,

    pub s_points: HashMap<String, Scorer>,

    pub s_rebounds_total: HashMap<String, Scorer>,

    pub s_steals: HashMap<String, Scorer>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SBlocks {
    #[serde(rename = "1")]
    pub the_1: Scorer,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Pl {
    pub active: i64,

    pub captain: Option<i64>,

    pub comp: Option<Comp>,

    #[serde(rename = "eff_1")]
    pub eff_1: i64,

    #[serde(rename = "eff_2")]
    pub eff_2: i64,

    #[serde(rename = "eff_3")]
    pub eff_3: f64,

    #[serde(rename = "eff_4")]
    pub eff_4: f64,

    #[serde(rename = "eff_5")]
    pub eff_5: i64,

    #[serde(rename = "eff_6")]
    pub eff_6: i64,

    #[serde(rename = "eff_7")]
    pub eff_7: i64,

    pub family_name: String,

    pub family_name_initial: FamilyNameInitial,

    pub first_name: String,

    pub first_name_initial: FirstNameInitial,

    pub international_family_name: String,

    pub international_family_name_initial: FamilyNameInitial,

    pub international_first_name: String,

    pub international_first_name_initial: FirstNameInitial,

    pub name: String,

    pub playing_position: String,

    pub s_assists: i64,

    pub s_blocks: i64,

    pub s_blocks_received: i64,

    pub s_field_goals_attempted: i64,

    pub s_field_goals_made: i64,

    pub s_field_goals_percentage: i64,

    pub s_fouls_on: i64,

    pub s_fouls_personal: i64,

    pub s_free_throws_attempted: i64,

    pub s_free_throws_made: i64,

    pub s_free_throws_percentage: i64,

    pub s_minutes: SMinutes,

    pub s_plus_minus_points: i64,

    pub s_points: i64,

    pub s_points_fast_break: i64,

    pub s_points_in_the_paint: i64,

    pub s_points_second_chance: i64,

    pub s_rebounds_defensive: i64,

    pub s_rebounds_offensive: i64,

    pub s_rebounds_total: i64,

    pub s_steals: i64,

    pub s_three_pointers_attempted: i64,

    pub s_three_pointers_made: i64,

    pub s_three_pointers_percentage: i64,

    pub s_turnovers: i64,

    pub s_two_pointers_attempted: i64,

    pub s_two_pointers_made: i64,

    pub s_two_pointers_percentage: i64,

    pub shirt_number: String,

    pub starter: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Comp {
    pub s_assists_average: f64,

    pub s_minutes_average: String,

    pub s_points_average: f64,

    pub s_rebounds_total_average: f64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum SMinutes {
    Integer(i64),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Shot {
    pub action_type: ActionType,

    pub p: i64,

    pub per: i64,

    pub per_type: PerType,

    pub player: String,

    pub pno: i64,

    pub r: i64,

    pub shirt_number: String,

    pub sub_type: SubType,

    pub tno: i64,

    pub x: i64,

    pub y: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum SubType {
    Jumpshot,

    Layup,

    Dunk,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Totallds {
    pub s_assists: HashMap<String, Scorer>,

    pub s_blocks: HashMap<String, Scorer>,

    pub s_points: HashMap<String, Scorer>,

    pub s_rebounds_total: HashMap<String, Scorer>,

    pub s_steals: HashMap<String, Scorer>,
}
