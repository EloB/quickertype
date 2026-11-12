from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_dict(f: Callable[[Any], T], x: Any) -> dict[str, T]:
    assert isinstance(x, dict)
    return { k: f(v) for (k, v) in x.items() }


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class Description:
    base_period: str
    missing: str
    title: str
    units: str

    @staticmethod
    def from_dict(obj: Any) -> 'Description':
        assert isinstance(obj, dict)
        base_period = from_str(obj["base_period"])
        missing = from_str(obj["missing"])
        title = from_str(obj["title"])
        units = from_str(obj["units"])
        return Description(base_period, missing, title, units)

    def to_dict(self) -> dict:
        result: dict = {}
        result["base_period"] = from_str(self.base_period)
        result["missing"] = from_str(self.missing)
        result["title"] = from_str(self.title)
        result["units"] = from_str(self.units)
        return result


@dataclass
class TopLevel:
    data: dict[str, str]
    description: Description

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        data = from_dict(from_str, obj["data"])
        description = Description.from_dict(obj["description"])
        return TopLevel(data, description)

    def to_dict(self) -> dict:
        result: dict = {}
        result["data"] = from_dict(from_str, self.data)
        result["description"] = to_class(Description, self.description)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
