import datetime
from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast
import dateutil.parser


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


def to_float(x: Any) -> float:
    assert isinstance(x, (int, float))
    return x


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


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


def from_datetime(x: Any) -> datetime.datetime:
    return dateutil.parser.parse(x)


def is_type(t: Type[T], x: Any) -> T:
    assert isinstance(x, t)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


class Fall(Enum):
    FELL = "Fell"
    FOUND = "Found"


class TypeEnum(Enum):
    POINT = "Point"


@dataclass
class Geolocation:
    coordinates: list[float]
    type: TypeEnum

    @staticmethod
    def from_dict(obj: Any) -> 'Geolocation':
        assert isinstance(obj, dict)
        coordinates = from_list(from_float, obj["coordinates"])
        type = TypeEnum(obj["type"])
        return Geolocation(coordinates, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["coordinates"] = from_list(to_float, self.coordinates)
        result["type"] = to_enum(TypeEnum, self.type)
        return result


class Nametype(Enum):
    VALID = "Valid"


@dataclass
class TopLevelElement:
    fall: Fall
    id: int
    name: str
    nametype: Nametype
    recclass: str
    computed_region_cbhk_fwbd: int | None
    computed_region_nnqa_25_f4: int | None
    geolocation: Geolocation | None
    mass: str | None
    reclat: str | None
    reclong: str | None
    year: datetime.datetime | None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevelElement':
        assert isinstance(obj, dict)
        fall = Fall(obj["fall"])
        id = int(from_str(obj["id"]))
        name = from_str(obj["name"])
        nametype = Nametype(obj["nametype"])
        recclass = from_str(obj["recclass"])
        computed_region_cbhk_fwbd = from_union([from_none, lambda x: int(from_str(x))], obj.get(":@computed_region_cbhk_fwbd"))
        computed_region_nnqa_25_f4 = from_union([from_none, lambda x: int(from_str(x))], obj.get(":@computed_region_nnqa_25f4"))
        geolocation = from_union([Geolocation.from_dict, from_none], obj.get("geolocation"))
        mass = from_union([from_none, from_str], obj.get("mass"))
        reclat = from_union([from_none, from_str], obj.get("reclat"))
        reclong = from_union([from_none, from_str], obj.get("reclong"))
        year = from_union([from_datetime, from_none], obj.get("year"))
        return TopLevelElement(fall, id, name, nametype, recclass, computed_region_cbhk_fwbd, computed_region_nnqa_25_f4, geolocation, mass, reclat, reclong, year)

    def to_dict(self) -> dict:
        result: dict = {}
        result["fall"] = to_enum(Fall, self.fall)
        result["id"] = from_str(str(self.id))
        result["name"] = from_str(self.name)
        result["nametype"] = to_enum(Nametype, self.nametype)
        result["recclass"] = from_str(self.recclass)
        if self.computed_region_cbhk_fwbd is not None:
            result[":@computed_region_cbhk_fwbd"] = from_union([lambda x: from_none((lambda x: is_type(type(None), x))(x)), lambda x: from_str((lambda x: str((lambda x: is_type(int, x))(x)))(x))], self.computed_region_cbhk_fwbd)
        if self.computed_region_nnqa_25_f4 is not None:
            result[":@computed_region_nnqa_25f4"] = from_union([lambda x: from_none((lambda x: is_type(type(None), x))(x)), lambda x: from_str((lambda x: str((lambda x: is_type(int, x))(x)))(x))], self.computed_region_nnqa_25_f4)
        if self.geolocation is not None:
            result["geolocation"] = from_union([lambda x: to_class(Geolocation, x), from_none], self.geolocation)
        if self.mass is not None:
            result["mass"] = from_union([from_none, from_str], self.mass)
        if self.reclat is not None:
            result["reclat"] = from_union([from_none, from_str], self.reclat)
        if self.reclong is not None:
            result["reclong"] = from_union([from_none, from_str], self.reclong)
        if self.year is not None:
            result["year"] = from_union([lambda x: x.isoformat(), from_none], self.year)
        return result


def top_level_from_dict(s: Any) -> list[TopLevelElement]:
    return from_list(TopLevelElement.from_dict, s)


def top_level_to_dict(x: list[TopLevelElement]) -> Any:
    return from_list(lambda x: to_class(TopLevelElement, x), x)
