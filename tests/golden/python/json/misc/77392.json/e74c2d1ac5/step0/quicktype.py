import datetime
from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Type, Callable, cast
import dateutil.parser


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_datetime(x: Any) -> datetime.datetime:
    return dateutil.parser.parse(x)


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


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


class OrbitClass(Enum):
    APOLLO = "Apollo"
    AMOR = "Amor"
    ATEN = "Aten"
    COMET = "Comet"
    JUPITER_FAMILY_COMET = "Jupiter-family Comet"
    HALLEY_TYPE_COMET = "Halley-type Comet*"
    PARABOLIC_COMET = "Parabolic Comet"
    ORBIT_CLASS_JUPITER_FAMILY_COMET = "Jupiter-family Comet*"
    ENCKE_TYPE_COMET = "Encke-type Comet"


class Pha(Enum):
    Y = "Y"
    N = "N"
    N_A = "n/a"


@dataclass
class TopLevelElement:
    designation: str
    discovery_date: datetime.datetime
    i_deg: str
    moid_au: str
    orbit_class: OrbitClass
    pha: Pha
    q_au_1: str
    h_mag: str | None
    period_yr: str | None
    q_au_2: str | None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevelElement':
        assert isinstance(obj, dict)
        designation = from_str(obj["designation"])
        discovery_date = from_datetime(obj["discovery_date"])
        i_deg = from_str(obj["i_deg"])
        moid_au = from_str(obj["moid_au"])
        orbit_class = OrbitClass(obj["orbit_class"])
        pha = Pha(obj["pha"])
        q_au_1 = from_str(obj["q_au_1"])
        h_mag = from_union([from_none, from_str], obj.get("h_mag"))
        period_yr = from_union([from_none, from_str], obj.get("period_yr"))
        q_au_2 = from_union([from_none, from_str], obj.get("q_au_2"))
        return TopLevelElement(designation, discovery_date, i_deg, moid_au, orbit_class, pha, q_au_1, h_mag, period_yr, q_au_2)

    def to_dict(self) -> dict:
        result: dict = {}
        result["designation"] = from_str(self.designation)
        result["discovery_date"] = self.discovery_date.isoformat()
        result["i_deg"] = from_str(self.i_deg)
        result["moid_au"] = from_str(self.moid_au)
        result["orbit_class"] = to_enum(OrbitClass, self.orbit_class)
        result["pha"] = to_enum(Pha, self.pha)
        result["q_au_1"] = from_str(self.q_au_1)
        if self.h_mag is not None:
            result["h_mag"] = from_union([from_none, from_str], self.h_mag)
        if self.period_yr is not None:
            result["period_yr"] = from_union([from_none, from_str], self.period_yr)
        if self.q_au_2 is not None:
            result["q_au_2"] = from_union([from_none, from_str], self.q_au_2)
        return result


def top_level_from_dict(s: Any) -> list[TopLevelElement]:
    return from_list(TopLevelElement.from_dict, s)


def top_level_to_dict(x: list[TopLevelElement]) -> Any:
    return from_list(lambda x: to_class(TopLevelElement, x), x)
