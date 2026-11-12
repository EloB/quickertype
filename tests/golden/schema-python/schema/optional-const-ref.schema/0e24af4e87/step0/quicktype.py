from dataclasses import dataclass
from typing import Any, cast, TypeVar, Callable, Type


T = TypeVar("T")


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


def to_float(x: Any) -> float:
    assert isinstance(x, (int, float))
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


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


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class Coordinate:
    latitude: float
    longitude: float

    @staticmethod
    def from_dict(obj: Any) -> 'Coordinate':
        assert isinstance(obj, dict)
        latitude = from_float(obj["latitude"])
        longitude = from_float(obj["longitude"])
        return Coordinate(latitude, longitude)

    def to_dict(self) -> dict:
        result: dict = {}
        result["latitude"] = to_float(self.latitude)
        result["longitude"] = to_float(self.longitude)
        return result


@dataclass
class TopLevel:
    required_coordinates: list[Coordinate]
    required_count: int
    required_label: str
    coordinates: list[Coordinate] | None = None
    count: int | None = None
    label: str | None = None
    weight: float | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        required_coordinates = from_list(Coordinate.from_dict, obj["requiredCoordinates"])
        required_count = from_int(obj["requiredCount"])
        assert required_count is None or 1 <= required_count
        assert required_count is None or required_count <= 100
        required_label = from_str(obj["requiredLabel"])
        assert required_label is None or 2 <= len(cast(str, obj["requiredLabel"]))
        assert required_label is None or len(cast(str, obj["requiredLabel"])) <= 16
        coordinates = from_union([lambda x: from_list(Coordinate.from_dict, x), from_none], obj.get("coordinates"))
        count = from_union([from_int, from_none], obj.get("count"))
        assert count is None or 1 <= count
        assert count is None or count <= 100
        label = from_union([from_str, from_none], obj.get("label"))
        assert label is None or 2 <= len(cast(str, obj.get("label")))
        assert label is None or len(cast(str, obj.get("label"))) <= 16
        weight = from_union([from_float, from_none], obj.get("weight"))
        assert weight is None or 0.5 <= weight
        assert weight is None or weight <= 99.5
        return TopLevel(required_coordinates, required_count, required_label, coordinates, count, label, weight)

    def to_dict(self) -> dict:
        result: dict = {}
        result["requiredCoordinates"] = from_list(lambda x: to_class(Coordinate, x), self.required_coordinates)
        result["requiredCount"] = from_int(self.required_count)
        result["requiredLabel"] = from_str(self.required_label)
        if self.coordinates is not None:
            result["coordinates"] = from_union([lambda x: from_list(lambda x: to_class(Coordinate, x), x), from_none], self.coordinates)
        if self.count is not None:
            result["count"] = from_union([from_int, from_none], self.count)
        if self.label is not None:
            result["label"] = from_union([from_str, from_none], self.label)
        if self.weight is not None:
            result["weight"] = from_union([to_float, from_none], self.weight)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
