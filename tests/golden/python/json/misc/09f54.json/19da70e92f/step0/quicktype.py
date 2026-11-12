from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_dict(f: Callable[[Any], T], x: Any) -> dict[str, T]:
    assert isinstance(x, dict)
    return { k: f(v) for (k, v) in x.items() }


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class Datum:
    anomaly: str
    value: str

    @staticmethod
    def from_dict(obj: Any) -> 'Datum':
        assert isinstance(obj, dict)
        anomaly = from_str(obj["anomaly"])
        value = from_str(obj["value"])
        return Datum(anomaly, value)

    def to_dict(self) -> dict:
        result: dict = {}
        result["anomaly"] = from_str(self.anomaly)
        result["value"] = from_str(self.value)
        return result


@dataclass
class Description:
    base_period: str
    missing: int
    title: str
    units: str

    @staticmethod
    def from_dict(obj: Any) -> 'Description':
        assert isinstance(obj, dict)
        base_period = from_str(obj["base_period"])
        missing = from_int(obj["missing"])
        title = from_str(obj["title"])
        units = from_str(obj["units"])
        return Description(base_period, missing, title, units)

    def to_dict(self) -> dict:
        result: dict = {}
        result["base_period"] = from_str(self.base_period)
        result["missing"] = from_int(self.missing)
        result["title"] = from_str(self.title)
        result["units"] = from_str(self.units)
        return result


@dataclass
class TopLevel:
    data: dict[str, Datum]
    description: Description

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        data = from_dict(Datum.from_dict, obj["data"])
        description = Description.from_dict(obj["description"])
        return TopLevel(data, description)

    def to_dict(self) -> dict:
        result: dict = {}
        result["data"] = from_dict(lambda x: to_class(Datum, x), self.data)
        result["description"] = to_class(Description, self.description)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
