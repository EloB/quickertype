from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Type, Callable, cast


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


def to_float(x: Any) -> float:
    assert isinstance(x, (int, float))
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_union(fs, x):
    for f in fs:
        try:
            return f(x)
        except:
            pass
    assert False


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


class Breed(Enum):
    ATROX = "Atrox"
    SOLITUS = "Solitus"
    OPIFEX = "Opifex"
    NANO = "Nano"


class Firstname(Enum):
    EMPTY = ""
    CHI = "Chi"


class Lastname(Enum):
    EMPTY = ""
    WASHKO = "Washko"


class Pvptitle(Enum):
    FRESHMAN = "Freshman"


class RankTitle(Enum):
    PRESIDENT = "President"
    ADVISOR = "Advisor"
    VETERAN = "Veteran"
    APPLICANT = "Applicant"


class Sex(Enum):
    NEUTER = "Neuter"
    MALE = "Male"
    FEMALE = "Female"


@dataclass
class PurpleTopLevel:
    alienlevel: int
    breed: Breed
    char_dimension: int
    char_instance: int
    defender_rank_title: str
    firstname: Firstname
    headid: int
    lastname: Lastname
    levelx: int
    name: str
    prof: str
    prof_title: str
    pvprating: int
    pvptitle: Pvptitle
    rank: int
    rank_title: RankTitle
    sex: Sex

    @staticmethod
    def from_dict(obj: Any) -> 'PurpleTopLevel':
        assert isinstance(obj, dict)
        alienlevel = from_int(obj["ALIENLEVEL"])
        breed = Breed(obj["BREED"])
        char_dimension = from_int(obj["CHAR_DIMENSION"])
        char_instance = from_int(obj["CHAR_INSTANCE"])
        defender_rank_title = from_str(obj["DEFENDER_RANK_TITLE"])
        firstname = Firstname(obj["FIRSTNAME"])
        headid = from_int(obj["HEADID"])
        lastname = Lastname(obj["LASTNAME"])
        levelx = from_int(obj["LEVELX"])
        name = from_str(obj["NAME"])
        prof = from_str(obj["PROF"])
        prof_title = from_str(obj["PROF_TITLE"])
        pvprating = from_int(obj["PVPRATING"])
        pvptitle = Pvptitle(obj["PVPTITLE"])
        rank = from_int(obj["RANK"])
        rank_title = RankTitle(obj["RANK_TITLE"])
        sex = Sex(obj["SEX"])
        return PurpleTopLevel(alienlevel, breed, char_dimension, char_instance, defender_rank_title, firstname, headid, lastname, levelx, name, prof, prof_title, pvprating, pvptitle, rank, rank_title, sex)

    def to_dict(self) -> dict:
        result: dict = {}
        result["ALIENLEVEL"] = from_int(self.alienlevel)
        result["BREED"] = to_enum(Breed, self.breed)
        result["CHAR_DIMENSION"] = from_int(self.char_dimension)
        result["CHAR_INSTANCE"] = from_int(self.char_instance)
        result["DEFENDER_RANK_TITLE"] = from_str(self.defender_rank_title)
        result["FIRSTNAME"] = to_enum(Firstname, self.firstname)
        result["HEADID"] = from_int(self.headid)
        result["LASTNAME"] = to_enum(Lastname, self.lastname)
        result["LEVELX"] = from_int(self.levelx)
        result["NAME"] = from_str(self.name)
        result["PROF"] = from_str(self.prof)
        result["PROF_TITLE"] = from_str(self.prof_title)
        result["PVPRATING"] = from_int(self.pvprating)
        result["PVPTITLE"] = to_enum(Pvptitle, self.pvptitle)
        result["RANK"] = from_int(self.rank)
        result["RANK_TITLE"] = to_enum(RankTitle, self.rank_title)
        result["SEX"] = to_enum(Sex, self.sex)
        return result


@dataclass
class FluffyTopLevel:
    adventurercount: int
    agentcount: int
    atroxcount: int
    avglvl: float
    btcount: int
    description: str
    doctorcount: int
    enfcount: int
    engineeercount: int
    femalecount: int
    fixercount: int
    governingname: str
    history: str
    keepercount: int
    macount: int
    malecount: int
    maxlvl: int
    metacount: int
    minlvl: int
    monstercount: int
    name: str
    nanocount: int
    nanoracecount: int
    neutercount: int
    nummembers: int
    objective: str
    opifexcount: int
    org_dimension: int
    org_instance: int
    shadecount: int
    side: int
    side_name: str
    solidercount: int
    solituscount: int
    tradercount: int

    @staticmethod
    def from_dict(obj: Any) -> 'FluffyTopLevel':
        assert isinstance(obj, dict)
        adventurercount = from_int(obj["ADVENTURERCOUNT"])
        agentcount = from_int(obj["AGENTCOUNT"])
        atroxcount = from_int(obj["ATROXCOUNT"])
        avglvl = from_float(obj["AVGLVL"])
        btcount = from_int(obj["BTCOUNT"])
        description = from_str(obj["DESCRIPTION"])
        doctorcount = from_int(obj["DOCTORCOUNT"])
        enfcount = from_int(obj["ENFCOUNT"])
        engineeercount = from_int(obj["ENGINEEERCOUNT"])
        femalecount = from_int(obj["FEMALECOUNT"])
        fixercount = from_int(obj["FIXERCOUNT"])
        governingname = from_str(obj["GOVERNINGNAME"])
        history = from_str(obj["HISTORY"])
        keepercount = from_int(obj["KEEPERCOUNT"])
        macount = from_int(obj["MACOUNT"])
        malecount = from_int(obj["MALECOUNT"])
        maxlvl = from_int(obj["MAXLVL"])
        metacount = from_int(obj["METACOUNT"])
        minlvl = from_int(obj["MINLVL"])
        monstercount = from_int(obj["MONSTERCOUNT"])
        name = from_str(obj["NAME"])
        nanocount = from_int(obj["NANOCOUNT"])
        nanoracecount = from_int(obj["NANORACECOUNT"])
        neutercount = from_int(obj["NEUTERCOUNT"])
        nummembers = from_int(obj["NUMMEMBERS"])
        objective = from_str(obj["OBJECTIVE"])
        opifexcount = from_int(obj["OPIFEXCOUNT"])
        org_dimension = from_int(obj["ORG_DIMENSION"])
        org_instance = from_int(obj["ORG_INSTANCE"])
        shadecount = from_int(obj["SHADECOUNT"])
        side = from_int(obj["SIDE"])
        side_name = from_str(obj["SIDE_NAME"])
        solidercount = from_int(obj["SOLIDERCOUNT"])
        solituscount = from_int(obj["SOLITUSCOUNT"])
        tradercount = from_int(obj["TRADERCOUNT"])
        return FluffyTopLevel(adventurercount, agentcount, atroxcount, avglvl, btcount, description, doctorcount, enfcount, engineeercount, femalecount, fixercount, governingname, history, keepercount, macount, malecount, maxlvl, metacount, minlvl, monstercount, name, nanocount, nanoracecount, neutercount, nummembers, objective, opifexcount, org_dimension, org_instance, shadecount, side, side_name, solidercount, solituscount, tradercount)

    def to_dict(self) -> dict:
        result: dict = {}
        result["ADVENTURERCOUNT"] = from_int(self.adventurercount)
        result["AGENTCOUNT"] = from_int(self.agentcount)
        result["ATROXCOUNT"] = from_int(self.atroxcount)
        result["AVGLVL"] = to_float(self.avglvl)
        result["BTCOUNT"] = from_int(self.btcount)
        result["DESCRIPTION"] = from_str(self.description)
        result["DOCTORCOUNT"] = from_int(self.doctorcount)
        result["ENFCOUNT"] = from_int(self.enfcount)
        result["ENGINEEERCOUNT"] = from_int(self.engineeercount)
        result["FEMALECOUNT"] = from_int(self.femalecount)
        result["FIXERCOUNT"] = from_int(self.fixercount)
        result["GOVERNINGNAME"] = from_str(self.governingname)
        result["HISTORY"] = from_str(self.history)
        result["KEEPERCOUNT"] = from_int(self.keepercount)
        result["MACOUNT"] = from_int(self.macount)
        result["MALECOUNT"] = from_int(self.malecount)
        result["MAXLVL"] = from_int(self.maxlvl)
        result["METACOUNT"] = from_int(self.metacount)
        result["MINLVL"] = from_int(self.minlvl)
        result["MONSTERCOUNT"] = from_int(self.monstercount)
        result["NAME"] = from_str(self.name)
        result["NANOCOUNT"] = from_int(self.nanocount)
        result["NANORACECOUNT"] = from_int(self.nanoracecount)
        result["NEUTERCOUNT"] = from_int(self.neutercount)
        result["NUMMEMBERS"] = from_int(self.nummembers)
        result["OBJECTIVE"] = from_str(self.objective)
        result["OPIFEXCOUNT"] = from_int(self.opifexcount)
        result["ORG_DIMENSION"] = from_int(self.org_dimension)
        result["ORG_INSTANCE"] = from_int(self.org_instance)
        result["SHADECOUNT"] = from_int(self.shadecount)
        result["SIDE"] = from_int(self.side)
        result["SIDE_NAME"] = from_str(self.side_name)
        result["SOLIDERCOUNT"] = from_int(self.solidercount)
        result["SOLITUSCOUNT"] = from_int(self.solituscount)
        result["TRADERCOUNT"] = from_int(self.tradercount)
        return result


def top_level_from_dict(s: Any) -> list[list[PurpleTopLevel] | FluffyTopLevel | str]:
    return from_list(lambda x: from_union([lambda x: from_list(PurpleTopLevel.from_dict, x), FluffyTopLevel.from_dict, from_str], x), s)


def top_level_to_dict(x: list[list[PurpleTopLevel] | FluffyTopLevel | str]) -> Any:
    return from_list(lambda x: from_union([lambda x: from_list(lambda x: to_class(PurpleTopLevel, x), x), lambda x: to_class(FluffyTopLevel, x), from_str], x), x)
