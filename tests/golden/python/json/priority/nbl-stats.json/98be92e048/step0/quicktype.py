from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast, Callable


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


def from_none(x: Any) -> Any:
    assert x is None
    return x


def from_union(fs, x):
    for f in fs:
        try:
            return f(x)
        except:
            pass
    assert False


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_dict(f: Callable[[Any], T], x: Any) -> dict[str, T]:
    assert isinstance(x, dict)
    return { k: f(v) for (k, v) in x.items() }


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


def to_float(x: Any) -> float:
    assert isinstance(x, (int, float))
    return x


class LeaddatumEnum(Enum):
    EMPTY = ""
    P1 = "P1"
    P2 = "P2"
    P3 = "P3"
    P4 = "P4"


class PerType(Enum):
    REGULAR = "REGULAR"


@dataclass
class Team:
    team_code: str
    team_code_international: str
    team_name: str
    team_name_international: str

    @staticmethod
    def from_dict(obj: Any) -> 'Team':
        assert isinstance(obj, dict)
        team_code = from_str(obj["teamCode"])
        team_code_international = from_str(obj["teamCodeInternational"])
        team_name = from_str(obj["teamName"])
        team_name_international = from_str(obj["teamNameInternational"])
        return Team(team_code, team_code_international, team_name, team_name_international)

    def to_dict(self) -> dict:
        result: dict = {}
        result["teamCode"] = from_str(self.team_code)
        result["teamCodeInternational"] = from_str(self.team_code_international)
        result["teamName"] = from_str(self.team_name)
        result["teamNameInternational"] = from_str(self.team_name_international)
        return result


@dataclass
class Othermatch:
    clock: str
    competition_name: str
    id: int
    period: int
    period_type: PerType
    team1: Team
    team1_name: str
    team1_score: int
    team2: Team
    team2_name: str
    team2_score: int

    @staticmethod
    def from_dict(obj: Any) -> 'Othermatch':
        assert isinstance(obj, dict)
        clock = from_str(obj["clock"])
        competition_name = from_str(obj["competitionName"])
        id = int(from_str(obj["id"]))
        period = from_int(obj["period"])
        period_type = PerType(obj["periodType"])
        team1 = Team.from_dict(obj["team1"])
        team1_name = from_str(obj["team1Name"])
        team1_score = from_int(obj["team1Score"])
        team2 = Team.from_dict(obj["team2"])
        team2_name = from_str(obj["team2Name"])
        team2_score = from_int(obj["team2Score"])
        return Othermatch(clock, competition_name, id, period, period_type, team1, team1_name, team1_score, team2, team2_name, team2_score)

    def to_dict(self) -> dict:
        result: dict = {}
        result["clock"] = from_str(self.clock)
        result["competitionName"] = from_str(self.competition_name)
        result["id"] = from_str(str(self.id))
        result["period"] = from_int(self.period)
        result["periodType"] = to_enum(PerType, self.period_type)
        result["team1"] = to_class(Team, self.team1)
        result["team1Name"] = from_str(self.team1_name)
        result["team1Score"] = from_int(self.team1_score)
        result["team2"] = to_class(Team, self.team2)
        result["team2Name"] = from_str(self.team2_name)
        result["team2Score"] = from_int(self.team2_score)
        return result


class ActionType(Enum):
    GAME = "game"
    PERIOD = "period"
    THE_3_PT = "3pt"
    THE_2_PT = "2pt"
    REBOUND = "rebound"
    TIMEOUT = "timeout"
    FOULON = "foulon"
    FOUL = "foul"
    ASSIST = "assist"
    SUBSTITUTION = "substitution"
    FREETHROW = "freethrow"
    STEAL = "steal"
    TURNOVER = "turnover"
    BLOCK = "block"
    JUMPBALL = "jumpball"


class FamilyNameInitial(Enum):
    R = "R"
    M = "M"
    S = "s"
    C = "C"
    O = "O"
    W = "W"
    A = "A"
    P = "P"
    V = "V"
    I = "I"
    J = "J"
    FAMILY_NAME_INITIAL_S = "S"
    H = "H"
    B = "B"


class FirstNameInitial(Enum):
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


class ScoreboardName(Enum):
    EMPTY = ""
    T_S = "T. s"
    R_IHATA = "R. Ihata"
    D_JONES = "D. Jones"
    B_VALENTINE = "B. Valentine"


@dataclass
class Pbp:
    action_type: ActionType
    gt: str
    lead: int
    period: int
    period_type: PerType
    player: str
    pno: int
    qualifier: str
    s1: int
    s2: int
    scoring: int
    shirt_number: str
    sub_type: str
    success: int
    tno: int
    family_name: str | None
    family_name_initial: FamilyNameInitial | None
    first_name: str | None
    first_name_initial: FirstNameInitial | None
    international_family_name: str | None
    international_family_name_initial: FamilyNameInitial | None
    international_first_name: str | None
    international_first_name_initial: FirstNameInitial | None
    scoreboard_name: ScoreboardName | None

    @staticmethod
    def from_dict(obj: Any) -> 'Pbp':
        assert isinstance(obj, dict)
        action_type = ActionType(obj["actionType"])
        gt = from_str(obj["gt"])
        lead = from_int(obj["lead"])
        period = from_int(obj["period"])
        period_type = PerType(obj["periodType"])
        player = from_str(obj["player"])
        pno = from_int(obj["pno"])
        qualifier = from_str(obj["qualifier"])
        s1 = from_int(obj["s1"])
        s2 = from_int(obj["s2"])
        scoring = from_int(obj["scoring"])
        shirt_number = from_str(obj["shirtNumber"])
        sub_type = from_str(obj["subType"])
        success = from_int(obj["success"])
        tno = from_int(obj["tno"])
        family_name = from_union([from_none, from_str], obj.get("familyName"))
        family_name_initial = from_union([FamilyNameInitial, from_none], obj.get("familyNameInitial"))
        first_name = from_union([from_none, from_str], obj.get("firstName"))
        first_name_initial = from_union([FirstNameInitial, from_none], obj.get("firstNameInitial"))
        international_family_name = from_union([from_none, from_str], obj.get("internationalFamilyName"))
        international_family_name_initial = from_union([FamilyNameInitial, from_none], obj.get("internationalFamilyNameInitial"))
        international_first_name = from_union([from_none, from_str], obj.get("internationalFirstName"))
        international_first_name_initial = from_union([FirstNameInitial, from_none], obj.get("internationalFirstNameInitial"))
        scoreboard_name = from_union([ScoreboardName, from_none], obj.get("scoreboardName"))
        return Pbp(action_type, gt, lead, period, period_type, player, pno, qualifier, s1, s2, scoring, shirt_number, sub_type, success, tno, family_name, family_name_initial, first_name, first_name_initial, international_family_name, international_family_name_initial, international_first_name, international_first_name_initial, scoreboard_name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["actionType"] = to_enum(ActionType, self.action_type)
        result["gt"] = from_str(self.gt)
        result["lead"] = from_int(self.lead)
        result["period"] = from_int(self.period)
        result["periodType"] = to_enum(PerType, self.period_type)
        result["player"] = from_str(self.player)
        result["pno"] = from_int(self.pno)
        result["qualifier"] = from_str(self.qualifier)
        result["s1"] = from_int(self.s1)
        result["s2"] = from_int(self.s2)
        result["scoring"] = from_int(self.scoring)
        result["shirtNumber"] = from_str(self.shirt_number)
        result["subType"] = from_str(self.sub_type)
        result["success"] = from_int(self.success)
        result["tno"] = from_int(self.tno)
        if self.family_name is not None:
            result["familyName"] = from_union([from_none, from_str], self.family_name)
        if self.family_name_initial is not None:
            result["familyNameInitial"] = from_union([lambda x: to_enum(FamilyNameInitial, x), from_none], self.family_name_initial)
        if self.first_name is not None:
            result["firstName"] = from_union([from_none, from_str], self.first_name)
        if self.first_name_initial is not None:
            result["firstNameInitial"] = from_union([lambda x: to_enum(FirstNameInitial, x), from_none], self.first_name_initial)
        if self.international_family_name is not None:
            result["internationalFamilyName"] = from_union([from_none, from_str], self.international_family_name)
        if self.international_family_name_initial is not None:
            result["internationalFamilyNameInitial"] = from_union([lambda x: to_enum(FamilyNameInitial, x), from_none], self.international_family_name_initial)
        if self.international_first_name is not None:
            result["internationalFirstName"] = from_union([from_none, from_str], self.international_first_name)
        if self.international_first_name_initial is not None:
            result["internationalFirstNameInitial"] = from_union([lambda x: to_enum(FirstNameInitial, x), from_none], self.international_first_name_initial)
        if self.scoreboard_name is not None:
            result["scoreboardName"] = from_union([lambda x: to_enum(ScoreboardName, x), from_none], self.scoreboard_name)
        return result


@dataclass
class Time:
    gt: str
    per: int
    per_type: PerType

    @staticmethod
    def from_dict(obj: Any) -> 'Time':
        assert isinstance(obj, dict)
        gt = from_str(obj["gt"])
        per = from_int(obj["per"])
        per_type = PerType(obj["perType"])
        return Time(gt, per, per_type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["gt"] = from_str(self.gt)
        result["per"] = from_int(self.per)
        result["perType"] = to_enum(PerType, self.per_type)
        return result


@dataclass
class Scorer:
    pno: int
    shirt_number: str
    tno: int
    family_name: str | None
    family_name_initial: FamilyNameInitial | None
    first_name: str | None
    first_name_initial: FirstNameInitial | None
    gt: str | None
    international_family_name: str | None
    international_family_name_initial: FamilyNameInitial | None
    international_first_name: str | None
    international_first_name_initial: FirstNameInitial | None
    name: str | None
    per: int | None
    per_type: PerType | None
    player: str | None
    scoreboard_name: ScoreboardName | None
    summary: str | None
    times: list[Time] | None
    tot: int | None

    @staticmethod
    def from_dict(obj: Any) -> 'Scorer':
        assert isinstance(obj, dict)
        pno = from_int(obj["pno"])
        shirt_number = from_str(obj["shirtNumber"])
        tno = from_int(obj["tno"])
        family_name = from_union([from_none, from_str], obj.get("familyName"))
        family_name_initial = from_union([FamilyNameInitial, from_none], obj.get("familyNameInitial"))
        first_name = from_union([from_none, from_str], obj.get("firstName"))
        first_name_initial = from_union([FirstNameInitial, from_none], obj.get("firstNameInitial"))
        gt = from_union([from_none, from_str], obj.get("gt"))
        international_family_name = from_union([from_none, from_str], obj.get("internationalFamilyName"))
        international_family_name_initial = from_union([FamilyNameInitial, from_none], obj.get("internationalFamilyNameInitial"))
        international_first_name = from_union([from_none, from_str], obj.get("internationalFirstName"))
        international_first_name_initial = from_union([FirstNameInitial, from_none], obj.get("internationalFirstNameInitial"))
        name = from_union([from_none, from_str], obj.get("name"))
        per = from_union([from_int, from_none], obj.get("per"))
        per_type = from_union([PerType, from_none], obj.get("perType"))
        player = from_union([from_none, from_str], obj.get("player"))
        scoreboard_name = from_union([ScoreboardName, from_none], obj.get("scoreboardName"))
        summary = from_union([from_none, from_str], obj.get("summary"))
        times = from_union([lambda x: from_list(Time.from_dict, x), from_none], obj.get("times"))
        tot = from_union([from_int, from_none], obj.get("tot"))
        return Scorer(pno, shirt_number, tno, family_name, family_name_initial, first_name, first_name_initial, gt, international_family_name, international_family_name_initial, international_first_name, international_first_name_initial, name, per, per_type, player, scoreboard_name, summary, times, tot)

    def to_dict(self) -> dict:
        result: dict = {}
        result["pno"] = from_int(self.pno)
        result["shirtNumber"] = from_str(self.shirt_number)
        result["tno"] = from_int(self.tno)
        if self.family_name is not None:
            result["familyName"] = from_union([from_none, from_str], self.family_name)
        if self.family_name_initial is not None:
            result["familyNameInitial"] = from_union([lambda x: to_enum(FamilyNameInitial, x), from_none], self.family_name_initial)
        if self.first_name is not None:
            result["firstName"] = from_union([from_none, from_str], self.first_name)
        if self.first_name_initial is not None:
            result["firstNameInitial"] = from_union([lambda x: to_enum(FirstNameInitial, x), from_none], self.first_name_initial)
        if self.gt is not None:
            result["gt"] = from_union([from_none, from_str], self.gt)
        if self.international_family_name is not None:
            result["internationalFamilyName"] = from_union([from_none, from_str], self.international_family_name)
        if self.international_family_name_initial is not None:
            result["internationalFamilyNameInitial"] = from_union([lambda x: to_enum(FamilyNameInitial, x), from_none], self.international_family_name_initial)
        if self.international_first_name is not None:
            result["internationalFirstName"] = from_union([from_none, from_str], self.international_first_name)
        if self.international_first_name_initial is not None:
            result["internationalFirstNameInitial"] = from_union([lambda x: to_enum(FirstNameInitial, x), from_none], self.international_first_name_initial)
        if self.name is not None:
            result["name"] = from_union([from_none, from_str], self.name)
        if self.per is not None:
            result["per"] = from_union([from_int, from_none], self.per)
        if self.per_type is not None:
            result["perType"] = from_union([lambda x: to_enum(PerType, x), from_none], self.per_type)
        if self.player is not None:
            result["player"] = from_union([from_none, from_str], self.player)
        if self.scoreboard_name is not None:
            result["scoreboardName"] = from_union([lambda x: to_enum(ScoreboardName, x), from_none], self.scoreboard_name)
        if self.summary is not None:
            result["summary"] = from_union([from_none, from_str], self.summary)
        if self.times is not None:
            result["times"] = from_union([lambda x: from_list(lambda x: to_class(Time, x), x), from_none], self.times)
        if self.tot is not None:
            result["tot"] = from_union([from_int, from_none], self.tot)
        return result


@dataclass
class SBlocks:
    the_1: Scorer

    @staticmethod
    def from_dict(obj: Any) -> 'SBlocks':
        assert isinstance(obj, dict)
        the_1 = Scorer.from_dict(obj["1"])
        return SBlocks(the_1)

    def to_dict(self) -> dict:
        result: dict = {}
        result["1"] = to_class(Scorer, self.the_1)
        return result


@dataclass
class Lds:
    s_assists: dict[str, Scorer]
    s_blocks: SBlocks
    s_points: dict[str, Scorer]
    s_rebounds_total: dict[str, Scorer]
    s_steals: dict[str, Scorer]

    @staticmethod
    def from_dict(obj: Any) -> 'Lds':
        assert isinstance(obj, dict)
        s_assists = from_dict(Scorer.from_dict, obj["sAssists"])
        s_blocks = SBlocks.from_dict(obj["sBlocks"])
        s_points = from_dict(Scorer.from_dict, obj["sPoints"])
        s_rebounds_total = from_dict(Scorer.from_dict, obj["sReboundsTotal"])
        s_steals = from_dict(Scorer.from_dict, obj["sSteals"])
        return Lds(s_assists, s_blocks, s_points, s_rebounds_total, s_steals)

    def to_dict(self) -> dict:
        result: dict = {}
        result["sAssists"] = from_dict(lambda x: to_class(Scorer, x), self.s_assists)
        result["sBlocks"] = to_class(SBlocks, self.s_blocks)
        result["sPoints"] = from_dict(lambda x: to_class(Scorer, x), self.s_points)
        result["sReboundsTotal"] = from_dict(lambda x: to_class(Scorer, x), self.s_rebounds_total)
        result["sSteals"] = from_dict(lambda x: to_class(Scorer, x), self.s_steals)
        return result


@dataclass
class Comp:
    s_assists_average: float
    s_minutes_average: str
    s_points_average: float
    s_rebounds_total_average: float

    @staticmethod
    def from_dict(obj: Any) -> 'Comp':
        assert isinstance(obj, dict)
        s_assists_average = from_float(obj["sAssistsAverage"])
        s_minutes_average = from_str(obj["sMinutesAverage"])
        s_points_average = from_float(obj["sPointsAverage"])
        s_rebounds_total_average = from_float(obj["sReboundsTotalAverage"])
        return Comp(s_assists_average, s_minutes_average, s_points_average, s_rebounds_total_average)

    def to_dict(self) -> dict:
        result: dict = {}
        result["sAssistsAverage"] = to_float(self.s_assists_average)
        result["sMinutesAverage"] = from_str(self.s_minutes_average)
        result["sPointsAverage"] = to_float(self.s_points_average)
        result["sReboundsTotalAverage"] = to_float(self.s_rebounds_total_average)
        return result


@dataclass
class Pl:
    active: int
    eff_1: int
    eff_2: int
    eff_3: float
    eff_4: float
    eff_5: int
    eff_6: int
    eff_7: int
    family_name: str
    family_name_initial: FamilyNameInitial
    first_name: str
    first_name_initial: FirstNameInitial
    international_family_name: str
    international_family_name_initial: FamilyNameInitial
    international_first_name: str
    international_first_name_initial: FirstNameInitial
    name: str
    playing_position: str
    s_assists: int
    s_blocks: int
    s_blocks_received: int
    s_field_goals_attempted: int
    s_field_goals_made: int
    s_field_goals_percentage: int
    s_fouls_on: int
    s_fouls_personal: int
    s_free_throws_attempted: int
    s_free_throws_made: int
    s_free_throws_percentage: int
    s_minutes: int | str
    s_plus_minus_points: int
    s_points: int
    s_points_fast_break: int
    s_points_in_the_paint: int
    s_points_second_chance: int
    s_rebounds_defensive: int
    s_rebounds_offensive: int
    s_rebounds_total: int
    s_steals: int
    s_three_pointers_attempted: int
    s_three_pointers_made: int
    s_three_pointers_percentage: int
    s_turnovers: int
    s_two_pointers_attempted: int
    s_two_pointers_made: int
    s_two_pointers_percentage: int
    shirt_number: int
    starter: int
    captain: int | None
    comp: Comp | None

    @staticmethod
    def from_dict(obj: Any) -> 'Pl':
        assert isinstance(obj, dict)
        active = from_int(obj["active"])
        eff_1 = from_int(obj["eff_1"])
        eff_2 = from_int(obj["eff_2"])
        eff_3 = from_float(obj["eff_3"])
        eff_4 = from_float(obj["eff_4"])
        eff_5 = from_int(obj["eff_5"])
        eff_6 = from_int(obj["eff_6"])
        eff_7 = from_int(obj["eff_7"])
        family_name = from_str(obj["familyName"])
        family_name_initial = FamilyNameInitial(obj["familyNameInitial"])
        first_name = from_str(obj["firstName"])
        first_name_initial = FirstNameInitial(obj["firstNameInitial"])
        international_family_name = from_str(obj["internationalFamilyName"])
        international_family_name_initial = FamilyNameInitial(obj["internationalFamilyNameInitial"])
        international_first_name = from_str(obj["internationalFirstName"])
        international_first_name_initial = FirstNameInitial(obj["internationalFirstNameInitial"])
        name = from_str(obj["name"])
        playing_position = from_str(obj["playingPosition"])
        s_assists = from_int(obj["sAssists"])
        s_blocks = from_int(obj["sBlocks"])
        s_blocks_received = from_int(obj["sBlocksReceived"])
        s_field_goals_attempted = from_int(obj["sFieldGoalsAttempted"])
        s_field_goals_made = from_int(obj["sFieldGoalsMade"])
        s_field_goals_percentage = from_int(obj["sFieldGoalsPercentage"])
        s_fouls_on = from_int(obj["sFoulsOn"])
        s_fouls_personal = from_int(obj["sFoulsPersonal"])
        s_free_throws_attempted = from_int(obj["sFreeThrowsAttempted"])
        s_free_throws_made = from_int(obj["sFreeThrowsMade"])
        s_free_throws_percentage = from_int(obj["sFreeThrowsPercentage"])
        s_minutes = from_union([from_int, from_str], obj["sMinutes"])
        s_plus_minus_points = from_int(obj["sPlusMinusPoints"])
        s_points = from_int(obj["sPoints"])
        s_points_fast_break = from_int(obj["sPointsFastBreak"])
        s_points_in_the_paint = from_int(obj["sPointsInThePaint"])
        s_points_second_chance = from_int(obj["sPointsSecondChance"])
        s_rebounds_defensive = from_int(obj["sReboundsDefensive"])
        s_rebounds_offensive = from_int(obj["sReboundsOffensive"])
        s_rebounds_total = from_int(obj["sReboundsTotal"])
        s_steals = from_int(obj["sSteals"])
        s_three_pointers_attempted = from_int(obj["sThreePointersAttempted"])
        s_three_pointers_made = from_int(obj["sThreePointersMade"])
        s_three_pointers_percentage = from_int(obj["sThreePointersPercentage"])
        s_turnovers = from_int(obj["sTurnovers"])
        s_two_pointers_attempted = from_int(obj["sTwoPointersAttempted"])
        s_two_pointers_made = from_int(obj["sTwoPointersMade"])
        s_two_pointers_percentage = from_int(obj["sTwoPointersPercentage"])
        shirt_number = int(from_str(obj["shirtNumber"]))
        starter = from_int(obj["starter"])
        captain = from_union([from_int, from_none], obj.get("captain"))
        comp = from_union([Comp.from_dict, from_none], obj.get("comp"))
        return Pl(active, eff_1, eff_2, eff_3, eff_4, eff_5, eff_6, eff_7, family_name, family_name_initial, first_name, first_name_initial, international_family_name, international_family_name_initial, international_first_name, international_first_name_initial, name, playing_position, s_assists, s_blocks, s_blocks_received, s_field_goals_attempted, s_field_goals_made, s_field_goals_percentage, s_fouls_on, s_fouls_personal, s_free_throws_attempted, s_free_throws_made, s_free_throws_percentage, s_minutes, s_plus_minus_points, s_points, s_points_fast_break, s_points_in_the_paint, s_points_second_chance, s_rebounds_defensive, s_rebounds_offensive, s_rebounds_total, s_steals, s_three_pointers_attempted, s_three_pointers_made, s_three_pointers_percentage, s_turnovers, s_two_pointers_attempted, s_two_pointers_made, s_two_pointers_percentage, shirt_number, starter, captain, comp)

    def to_dict(self) -> dict:
        result: dict = {}
        result["active"] = from_int(self.active)
        result["eff_1"] = from_int(self.eff_1)
        result["eff_2"] = from_int(self.eff_2)
        result["eff_3"] = to_float(self.eff_3)
        result["eff_4"] = to_float(self.eff_4)
        result["eff_5"] = from_int(self.eff_5)
        result["eff_6"] = from_int(self.eff_6)
        result["eff_7"] = from_int(self.eff_7)
        result["familyName"] = from_str(self.family_name)
        result["familyNameInitial"] = to_enum(FamilyNameInitial, self.family_name_initial)
        result["firstName"] = from_str(self.first_name)
        result["firstNameInitial"] = to_enum(FirstNameInitial, self.first_name_initial)
        result["internationalFamilyName"] = from_str(self.international_family_name)
        result["internationalFamilyNameInitial"] = to_enum(FamilyNameInitial, self.international_family_name_initial)
        result["internationalFirstName"] = from_str(self.international_first_name)
        result["internationalFirstNameInitial"] = to_enum(FirstNameInitial, self.international_first_name_initial)
        result["name"] = from_str(self.name)
        result["playingPosition"] = from_str(self.playing_position)
        result["sAssists"] = from_int(self.s_assists)
        result["sBlocks"] = from_int(self.s_blocks)
        result["sBlocksReceived"] = from_int(self.s_blocks_received)
        result["sFieldGoalsAttempted"] = from_int(self.s_field_goals_attempted)
        result["sFieldGoalsMade"] = from_int(self.s_field_goals_made)
        result["sFieldGoalsPercentage"] = from_int(self.s_field_goals_percentage)
        result["sFoulsOn"] = from_int(self.s_fouls_on)
        result["sFoulsPersonal"] = from_int(self.s_fouls_personal)
        result["sFreeThrowsAttempted"] = from_int(self.s_free_throws_attempted)
        result["sFreeThrowsMade"] = from_int(self.s_free_throws_made)
        result["sFreeThrowsPercentage"] = from_int(self.s_free_throws_percentage)
        result["sMinutes"] = from_union([from_int, from_str], self.s_minutes)
        result["sPlusMinusPoints"] = from_int(self.s_plus_minus_points)
        result["sPoints"] = from_int(self.s_points)
        result["sPointsFastBreak"] = from_int(self.s_points_fast_break)
        result["sPointsInThePaint"] = from_int(self.s_points_in_the_paint)
        result["sPointsSecondChance"] = from_int(self.s_points_second_chance)
        result["sReboundsDefensive"] = from_int(self.s_rebounds_defensive)
        result["sReboundsOffensive"] = from_int(self.s_rebounds_offensive)
        result["sReboundsTotal"] = from_int(self.s_rebounds_total)
        result["sSteals"] = from_int(self.s_steals)
        result["sThreePointersAttempted"] = from_int(self.s_three_pointers_attempted)
        result["sThreePointersMade"] = from_int(self.s_three_pointers_made)
        result["sThreePointersPercentage"] = from_int(self.s_three_pointers_percentage)
        result["sTurnovers"] = from_int(self.s_turnovers)
        result["sTwoPointersAttempted"] = from_int(self.s_two_pointers_attempted)
        result["sTwoPointersMade"] = from_int(self.s_two_pointers_made)
        result["sTwoPointersPercentage"] = from_int(self.s_two_pointers_percentage)
        result["shirtNumber"] = from_str(str(self.shirt_number))
        result["starter"] = from_int(self.starter)
        if self.captain is not None:
            result["captain"] = from_union([from_int, from_none], self.captain)
        if self.comp is not None:
            result["comp"] = from_union([lambda x: to_class(Comp, x), from_none], self.comp)
        return result


class SubType(Enum):
    JUMPSHOT = "jumpshot"
    LAYUP = "layup"
    DUNK = "dunk"


@dataclass
class Shot:
    action_type: ActionType
    p: int
    per: int
    per_type: PerType
    player: str
    pno: int
    r: int
    shirt_number: str
    sub_type: SubType
    tno: int
    x: int
    y: int

    @staticmethod
    def from_dict(obj: Any) -> 'Shot':
        assert isinstance(obj, dict)
        action_type = ActionType(obj["actionType"])
        p = from_int(obj["p"])
        per = from_int(obj["per"])
        per_type = PerType(obj["perType"])
        player = from_str(obj["player"])
        pno = from_int(obj["pno"])
        r = from_int(obj["r"])
        shirt_number = from_str(obj["shirtNumber"])
        sub_type = SubType(obj["subType"])
        tno = from_int(obj["tno"])
        x = from_int(obj["x"])
        y = from_int(obj["y"])
        return Shot(action_type, p, per, per_type, player, pno, r, shirt_number, sub_type, tno, x, y)

    def to_dict(self) -> dict:
        result: dict = {}
        result["actionType"] = to_enum(ActionType, self.action_type)
        result["p"] = from_int(self.p)
        result["per"] = from_int(self.per)
        result["perType"] = to_enum(PerType, self.per_type)
        result["player"] = from_str(self.player)
        result["pno"] = from_int(self.pno)
        result["r"] = from_int(self.r)
        result["shirtNumber"] = from_str(self.shirt_number)
        result["subType"] = to_enum(SubType, self.sub_type)
        result["tno"] = from_int(self.tno)
        result["x"] = from_int(self.x)
        result["y"] = from_int(self.y)
        return result


@dataclass
class Tm:
    code: str
    code_international: str
    fouls: int
    full_score: int
    lds: Lds
    logo: str
    name: str
    name_international: str
    p1_score: int
    p2_score: int
    p3_score: int
    p4_score: int
    pl: dict[str, Pl]
    score: int
    scoring: list[Scorer]
    short_name: str
    short_name_international: str
    shot: list[Shot]
    timeouts: int
    tot_eff_1: int
    tot_eff_2: int
    tot_eff_3: float
    tot_eff_4: int
    tot_eff_5: int
    tot_eff_6: int
    tot_eff_7: int
    tot_s_assists: int
    tot_s_bench_points: int
    tot_s_biggest_lead: int
    tot_s_biggest_scoring_run: int
    tot_s_blocks: int
    tot_s_blocks_received: int
    tot_s_field_goals_attempted: int
    tot_s_field_goals_made: int
    tot_s_field_goals_percentage: int
    tot_s_fouls_on: int
    tot_s_fouls_personal: int
    tot_s_fouls_team: int
    tot_s_free_throws_attempted: int
    tot_s_free_throws_made: int
    tot_s_free_throws_percentage: int
    tot_s_lead_changes: int
    tot_s_minutes: int
    tot_s_points: int
    tot_s_points_fast_break: int
    tot_s_points_from_turnovers: int
    tot_s_points_in_the_paint: int
    tot_s_points_second_chance: int
    tot_s_rebounds_defensive: int
    tot_s_rebounds_offensive: int
    tot_s_rebounds_team: int
    tot_s_rebounds_team_defensive: int
    tot_s_rebounds_team_offensive: int
    tot_s_rebounds_total: int
    tot_s_steals: int
    tot_s_three_pointers_attempted: int
    tot_s_three_pointers_made: int
    tot_s_three_pointers_percentage: int
    tot_s_time_leading: float
    tot_s_times_scores_level: int
    tot_s_turnovers: int
    tot_s_turnovers_team: int
    tot_s_two_pointers_attempted: int
    tot_s_two_pointers_made: int
    tot_s_two_pointers_percentage: int

    @staticmethod
    def from_dict(obj: Any) -> 'Tm':
        assert isinstance(obj, dict)
        code = from_str(obj["code"])
        code_international = from_str(obj["codeInternational"])
        fouls = from_int(obj["fouls"])
        full_score = from_int(obj["full_score"])
        lds = Lds.from_dict(obj["lds"])
        logo = from_str(obj["logo"])
        name = from_str(obj["name"])
        name_international = from_str(obj["nameInternational"])
        p1_score = from_int(obj["p1_score"])
        p2_score = from_int(obj["p2_score"])
        p3_score = from_int(obj["p3_score"])
        p4_score = from_int(obj["p4_score"])
        pl = from_dict(Pl.from_dict, obj["pl"])
        score = from_int(obj["score"])
        scoring = from_list(Scorer.from_dict, obj["scoring"])
        short_name = from_str(obj["shortName"])
        short_name_international = from_str(obj["shortNameInternational"])
        shot = from_list(Shot.from_dict, obj["shot"])
        timeouts = from_int(obj["timeouts"])
        tot_eff_1 = from_int(obj["tot_eff_1"])
        tot_eff_2 = from_int(obj["tot_eff_2"])
        tot_eff_3 = from_float(obj["tot_eff_3"])
        tot_eff_4 = from_int(obj["tot_eff_4"])
        tot_eff_5 = from_int(obj["tot_eff_5"])
        tot_eff_6 = from_int(obj["tot_eff_6"])
        tot_eff_7 = from_int(obj["tot_eff_7"])
        tot_s_assists = from_int(obj["tot_sAssists"])
        tot_s_bench_points = from_int(obj["tot_sBenchPoints"])
        tot_s_biggest_lead = from_int(obj["tot_sBiggestLead"])
        tot_s_biggest_scoring_run = from_int(obj["tot_sBiggestScoringRun"])
        tot_s_blocks = from_int(obj["tot_sBlocks"])
        tot_s_blocks_received = from_int(obj["tot_sBlocksReceived"])
        tot_s_field_goals_attempted = from_int(obj["tot_sFieldGoalsAttempted"])
        tot_s_field_goals_made = from_int(obj["tot_sFieldGoalsMade"])
        tot_s_field_goals_percentage = from_int(obj["tot_sFieldGoalsPercentage"])
        tot_s_fouls_on = from_int(obj["tot_sFoulsOn"])
        tot_s_fouls_personal = from_int(obj["tot_sFoulsPersonal"])
        tot_s_fouls_team = from_int(obj["tot_sFoulsTeam"])
        tot_s_free_throws_attempted = from_int(obj["tot_sFreeThrowsAttempted"])
        tot_s_free_throws_made = from_int(obj["tot_sFreeThrowsMade"])
        tot_s_free_throws_percentage = from_int(obj["tot_sFreeThrowsPercentage"])
        tot_s_lead_changes = from_int(obj["tot_sLeadChanges"])
        tot_s_minutes = from_int(obj["tot_sMinutes"])
        tot_s_points = from_int(obj["tot_sPoints"])
        tot_s_points_fast_break = from_int(obj["tot_sPointsFastBreak"])
        tot_s_points_from_turnovers = from_int(obj["tot_sPointsFromTurnovers"])
        tot_s_points_in_the_paint = from_int(obj["tot_sPointsInThePaint"])
        tot_s_points_second_chance = from_int(obj["tot_sPointsSecondChance"])
        tot_s_rebounds_defensive = from_int(obj["tot_sReboundsDefensive"])
        tot_s_rebounds_offensive = from_int(obj["tot_sReboundsOffensive"])
        tot_s_rebounds_team = from_int(obj["tot_sReboundsTeam"])
        tot_s_rebounds_team_defensive = from_int(obj["tot_sReboundsTeamDefensive"])
        tot_s_rebounds_team_offensive = from_int(obj["tot_sReboundsTeamOffensive"])
        tot_s_rebounds_total = from_int(obj["tot_sReboundsTotal"])
        tot_s_steals = from_int(obj["tot_sSteals"])
        tot_s_three_pointers_attempted = from_int(obj["tot_sThreePointersAttempted"])
        tot_s_three_pointers_made = from_int(obj["tot_sThreePointersMade"])
        tot_s_three_pointers_percentage = from_int(obj["tot_sThreePointersPercentage"])
        tot_s_time_leading = from_float(obj["tot_sTimeLeading"])
        tot_s_times_scores_level = from_int(obj["tot_sTimesScoresLevel"])
        tot_s_turnovers = from_int(obj["tot_sTurnovers"])
        tot_s_turnovers_team = from_int(obj["tot_sTurnoversTeam"])
        tot_s_two_pointers_attempted = from_int(obj["tot_sTwoPointersAttempted"])
        tot_s_two_pointers_made = from_int(obj["tot_sTwoPointersMade"])
        tot_s_two_pointers_percentage = from_int(obj["tot_sTwoPointersPercentage"])
        return Tm(code, code_international, fouls, full_score, lds, logo, name, name_international, p1_score, p2_score, p3_score, p4_score, pl, score, scoring, short_name, short_name_international, shot, timeouts, tot_eff_1, tot_eff_2, tot_eff_3, tot_eff_4, tot_eff_5, tot_eff_6, tot_eff_7, tot_s_assists, tot_s_bench_points, tot_s_biggest_lead, tot_s_biggest_scoring_run, tot_s_blocks, tot_s_blocks_received, tot_s_field_goals_attempted, tot_s_field_goals_made, tot_s_field_goals_percentage, tot_s_fouls_on, tot_s_fouls_personal, tot_s_fouls_team, tot_s_free_throws_attempted, tot_s_free_throws_made, tot_s_free_throws_percentage, tot_s_lead_changes, tot_s_minutes, tot_s_points, tot_s_points_fast_break, tot_s_points_from_turnovers, tot_s_points_in_the_paint, tot_s_points_second_chance, tot_s_rebounds_defensive, tot_s_rebounds_offensive, tot_s_rebounds_team, tot_s_rebounds_team_defensive, tot_s_rebounds_team_offensive, tot_s_rebounds_total, tot_s_steals, tot_s_three_pointers_attempted, tot_s_three_pointers_made, tot_s_three_pointers_percentage, tot_s_time_leading, tot_s_times_scores_level, tot_s_turnovers, tot_s_turnovers_team, tot_s_two_pointers_attempted, tot_s_two_pointers_made, tot_s_two_pointers_percentage)

    def to_dict(self) -> dict:
        result: dict = {}
        result["code"] = from_str(self.code)
        result["codeInternational"] = from_str(self.code_international)
        result["fouls"] = from_int(self.fouls)
        result["full_score"] = from_int(self.full_score)
        result["lds"] = to_class(Lds, self.lds)
        result["logo"] = from_str(self.logo)
        result["name"] = from_str(self.name)
        result["nameInternational"] = from_str(self.name_international)
        result["p1_score"] = from_int(self.p1_score)
        result["p2_score"] = from_int(self.p2_score)
        result["p3_score"] = from_int(self.p3_score)
        result["p4_score"] = from_int(self.p4_score)
        result["pl"] = from_dict(lambda x: to_class(Pl, x), self.pl)
        result["score"] = from_int(self.score)
        result["scoring"] = from_list(lambda x: to_class(Scorer, x), self.scoring)
        result["shortName"] = from_str(self.short_name)
        result["shortNameInternational"] = from_str(self.short_name_international)
        result["shot"] = from_list(lambda x: to_class(Shot, x), self.shot)
        result["timeouts"] = from_int(self.timeouts)
        result["tot_eff_1"] = from_int(self.tot_eff_1)
        result["tot_eff_2"] = from_int(self.tot_eff_2)
        result["tot_eff_3"] = to_float(self.tot_eff_3)
        result["tot_eff_4"] = from_int(self.tot_eff_4)
        result["tot_eff_5"] = from_int(self.tot_eff_5)
        result["tot_eff_6"] = from_int(self.tot_eff_6)
        result["tot_eff_7"] = from_int(self.tot_eff_7)
        result["tot_sAssists"] = from_int(self.tot_s_assists)
        result["tot_sBenchPoints"] = from_int(self.tot_s_bench_points)
        result["tot_sBiggestLead"] = from_int(self.tot_s_biggest_lead)
        result["tot_sBiggestScoringRun"] = from_int(self.tot_s_biggest_scoring_run)
        result["tot_sBlocks"] = from_int(self.tot_s_blocks)
        result["tot_sBlocksReceived"] = from_int(self.tot_s_blocks_received)
        result["tot_sFieldGoalsAttempted"] = from_int(self.tot_s_field_goals_attempted)
        result["tot_sFieldGoalsMade"] = from_int(self.tot_s_field_goals_made)
        result["tot_sFieldGoalsPercentage"] = from_int(self.tot_s_field_goals_percentage)
        result["tot_sFoulsOn"] = from_int(self.tot_s_fouls_on)
        result["tot_sFoulsPersonal"] = from_int(self.tot_s_fouls_personal)
        result["tot_sFoulsTeam"] = from_int(self.tot_s_fouls_team)
        result["tot_sFreeThrowsAttempted"] = from_int(self.tot_s_free_throws_attempted)
        result["tot_sFreeThrowsMade"] = from_int(self.tot_s_free_throws_made)
        result["tot_sFreeThrowsPercentage"] = from_int(self.tot_s_free_throws_percentage)
        result["tot_sLeadChanges"] = from_int(self.tot_s_lead_changes)
        result["tot_sMinutes"] = from_int(self.tot_s_minutes)
        result["tot_sPoints"] = from_int(self.tot_s_points)
        result["tot_sPointsFastBreak"] = from_int(self.tot_s_points_fast_break)
        result["tot_sPointsFromTurnovers"] = from_int(self.tot_s_points_from_turnovers)
        result["tot_sPointsInThePaint"] = from_int(self.tot_s_points_in_the_paint)
        result["tot_sPointsSecondChance"] = from_int(self.tot_s_points_second_chance)
        result["tot_sReboundsDefensive"] = from_int(self.tot_s_rebounds_defensive)
        result["tot_sReboundsOffensive"] = from_int(self.tot_s_rebounds_offensive)
        result["tot_sReboundsTeam"] = from_int(self.tot_s_rebounds_team)
        result["tot_sReboundsTeamDefensive"] = from_int(self.tot_s_rebounds_team_defensive)
        result["tot_sReboundsTeamOffensive"] = from_int(self.tot_s_rebounds_team_offensive)
        result["tot_sReboundsTotal"] = from_int(self.tot_s_rebounds_total)
        result["tot_sSteals"] = from_int(self.tot_s_steals)
        result["tot_sThreePointersAttempted"] = from_int(self.tot_s_three_pointers_attempted)
        result["tot_sThreePointersMade"] = from_int(self.tot_s_three_pointers_made)
        result["tot_sThreePointersPercentage"] = from_int(self.tot_s_three_pointers_percentage)
        result["tot_sTimeLeading"] = to_float(self.tot_s_time_leading)
        result["tot_sTimesScoresLevel"] = from_int(self.tot_s_times_scores_level)
        result["tot_sTurnovers"] = from_int(self.tot_s_turnovers)
        result["tot_sTurnoversTeam"] = from_int(self.tot_s_turnovers_team)
        result["tot_sTwoPointersAttempted"] = from_int(self.tot_s_two_pointers_attempted)
        result["tot_sTwoPointersMade"] = from_int(self.tot_s_two_pointers_made)
        result["tot_sTwoPointersPercentage"] = from_int(self.tot_s_two_pointers_percentage)
        return result


@dataclass
class Totallds:
    s_assists: dict[str, Scorer]
    s_blocks: dict[str, Scorer]
    s_points: dict[str, Scorer]
    s_rebounds_total: dict[str, Scorer]
    s_steals: dict[str, Scorer]

    @staticmethod
    def from_dict(obj: Any) -> 'Totallds':
        assert isinstance(obj, dict)
        s_assists = from_dict(Scorer.from_dict, obj["sAssists"])
        s_blocks = from_dict(Scorer.from_dict, obj["sBlocks"])
        s_points = from_dict(Scorer.from_dict, obj["sPoints"])
        s_rebounds_total = from_dict(Scorer.from_dict, obj["sReboundsTotal"])
        s_steals = from_dict(Scorer.from_dict, obj["sSteals"])
        return Totallds(s_assists, s_blocks, s_points, s_rebounds_total, s_steals)

    def to_dict(self) -> dict:
        result: dict = {}
        result["sAssists"] = from_dict(lambda x: to_class(Scorer, x), self.s_assists)
        result["sBlocks"] = from_dict(lambda x: to_class(Scorer, x), self.s_blocks)
        result["sPoints"] = from_dict(lambda x: to_class(Scorer, x), self.s_points)
        result["sReboundsTotal"] = from_dict(lambda x: to_class(Scorer, x), self.s_rebounds_total)
        result["sSteals"] = from_dict(lambda x: to_class(Scorer, x), self.s_steals)
        return result


@dataclass
class TopLevel:
    attendance: int
    clock: str
    disable_match: int
    in_ot: int
    leaddata: list[list[LeaddatumEnum | int]]
    officials_referee1: str
    officials_referee2: str
    officials_referee3: str
    othermatches: list[Othermatch]
    pbp: list[Pbp]
    period: int
    period_length_overtime: int
    period_length_regular: int
    period_type: PerType
    periods_max: int
    scorers: dict[str, list[Scorer]]
    timeline: list[Any]
    tm: dict[str, Tm]
    total_time_added: int
    totallds: Totallds

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        attendance = from_int(obj["attendance"])
        clock = from_str(obj["clock"])
        disable_match = from_int(obj["disableMatch"])
        in_ot = from_int(obj["inOT"])
        leaddata = from_list(lambda x: from_list(lambda x: from_union([LeaddatumEnum, from_int], x), x), obj["leaddata"])
        officials_referee1 = from_str(obj["officials_referee1"])
        officials_referee2 = from_str(obj["officials_referee2"])
        officials_referee3 = from_str(obj["officials_referee3"])
        othermatches = from_list(Othermatch.from_dict, obj["othermatches"])
        pbp = from_list(Pbp.from_dict, obj["pbp"])
        period = from_int(obj["period"])
        period_length_overtime = from_int(obj["periodLengthOVERTIME"])
        period_length_regular = from_int(obj["periodLengthREGULAR"])
        period_type = PerType(obj["periodType"])
        periods_max = from_int(obj["periodsMax"])
        scorers = from_dict(lambda x: from_list(Scorer.from_dict, x), obj["scorers"])
        timeline = from_list(lambda x: x, obj["timeline"])
        tm = from_dict(Tm.from_dict, obj["tm"])
        total_time_added = from_int(obj["totalTimeAdded"])
        totallds = Totallds.from_dict(obj["totallds"])
        return TopLevel(attendance, clock, disable_match, in_ot, leaddata, officials_referee1, officials_referee2, officials_referee3, othermatches, pbp, period, period_length_overtime, period_length_regular, period_type, periods_max, scorers, timeline, tm, total_time_added, totallds)

    def to_dict(self) -> dict:
        result: dict = {}
        result["attendance"] = from_int(self.attendance)
        result["clock"] = from_str(self.clock)
        result["disableMatch"] = from_int(self.disable_match)
        result["inOT"] = from_int(self.in_ot)
        result["leaddata"] = from_list(lambda x: from_list(lambda x: from_union([lambda x: to_enum(LeaddatumEnum, x), from_int], x), x), self.leaddata)
        result["officials_referee1"] = from_str(self.officials_referee1)
        result["officials_referee2"] = from_str(self.officials_referee2)
        result["officials_referee3"] = from_str(self.officials_referee3)
        result["othermatches"] = from_list(lambda x: to_class(Othermatch, x), self.othermatches)
        result["pbp"] = from_list(lambda x: to_class(Pbp, x), self.pbp)
        result["period"] = from_int(self.period)
        result["periodLengthOVERTIME"] = from_int(self.period_length_overtime)
        result["periodLengthREGULAR"] = from_int(self.period_length_regular)
        result["periodType"] = to_enum(PerType, self.period_type)
        result["periodsMax"] = from_int(self.periods_max)
        result["scorers"] = from_dict(lambda x: from_list(lambda x: to_class(Scorer, x), x), self.scorers)
        result["timeline"] = from_list(lambda x: x, self.timeline)
        result["tm"] = from_dict(lambda x: to_class(Tm, x), self.tm)
        result["totalTimeAdded"] = from_int(self.total_time_added)
        result["totallds"] = to_class(Totallds, self.totallds)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
