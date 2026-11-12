from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


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


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


class Category(Enum):
    PHYSICS = "physics"
    CHEMISTRY = "chemistry"
    MEDICINE = "medicine"
    LITERATURE = "literature"
    PEACE = "peace"
    ECONOMICS = "economics"


@dataclass
class Laureate:
    firstname: str
    id: int
    share: int
    surname: str
    motivation: str | None

    @staticmethod
    def from_dict(obj: Any) -> 'Laureate':
        assert isinstance(obj, dict)
        firstname = from_str(obj["firstname"])
        id = int(from_str(obj["id"]))
        share = int(from_str(obj["share"]))
        surname = from_str(obj["surname"])
        motivation = from_union([from_none, from_str], obj.get("motivation"))
        return Laureate(firstname, id, share, surname, motivation)

    def to_dict(self) -> dict:
        result: dict = {}
        result["firstname"] = from_str(self.firstname)
        result["id"] = from_str(str(self.id))
        result["share"] = from_str(str(self.share))
        result["surname"] = from_str(self.surname)
        if self.motivation is not None:
            result["motivation"] = from_union([from_none, from_str], self.motivation)
        return result


@dataclass
class Prize:
    category: Category
    laureates: list[Laureate]
    year: int
    overall_motivation: str | None

    @staticmethod
    def from_dict(obj: Any) -> 'Prize':
        assert isinstance(obj, dict)
        category = Category(obj["category"])
        laureates = from_list(Laureate.from_dict, obj["laureates"])
        year = int(from_str(obj["year"]))
        overall_motivation = from_union([from_none, from_str], obj.get("overallMotivation"))
        return Prize(category, laureates, year, overall_motivation)

    def to_dict(self) -> dict:
        result: dict = {}
        result["category"] = to_enum(Category, self.category)
        result["laureates"] = from_list(lambda x: to_class(Laureate, x), self.laureates)
        result["year"] = from_str(str(self.year))
        if self.overall_motivation is not None:
            result["overallMotivation"] = from_union([from_none, from_str], self.overall_motivation)
        return result


@dataclass
class TopLevel:
    prizes: list[Prize]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        prizes = from_list(Prize.from_dict, obj["prizes"])
        return TopLevel(prizes)

    def to_dict(self) -> dict:
        result: dict = {}
        result["prizes"] = from_list(lambda x: to_class(Prize, x), self.prizes)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
