from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class IssPosition:
    latitude: str
    longitude: str

    @staticmethod
    def from_dict(obj: Any) -> 'IssPosition':
        assert isinstance(obj, dict)
        latitude = from_str(obj["latitude"])
        longitude = from_str(obj["longitude"])
        return IssPosition(latitude, longitude)

    def to_dict(self) -> dict:
        result: dict = {}
        result["latitude"] = from_str(self.latitude)
        result["longitude"] = from_str(self.longitude)
        return result


@dataclass
class TopLevel:
    iss_position: IssPosition
    message: str
    timestamp: int

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        iss_position = IssPosition.from_dict(obj["iss_position"])
        message = from_str(obj["message"])
        timestamp = from_int(obj["timestamp"])
        return TopLevel(iss_position, message, timestamp)

    def to_dict(self) -> dict:
        result: dict = {}
        result["iss_position"] = to_class(IssPosition, self.iss_position)
        result["message"] = from_str(self.message)
        result["timestamp"] = from_int(self.timestamp)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
