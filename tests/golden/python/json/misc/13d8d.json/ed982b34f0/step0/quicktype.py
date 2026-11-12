from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast, Callable


T = TypeVar("T")


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


@dataclass
class Street:
    id: int
    name: str

    @staticmethod
    def from_dict(obj: Any) -> 'Street':
        assert isinstance(obj, dict)
        id = from_int(obj["id"])
        name = from_str(obj["name"])
        return Street(id, name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["id"] = from_int(self.id)
        result["name"] = from_str(self.name)
        return result


@dataclass
class Location:
    latitude: str
    longitude: str
    street: Street

    @staticmethod
    def from_dict(obj: Any) -> 'Location':
        assert isinstance(obj, dict)
        latitude = from_str(obj["latitude"])
        longitude = from_str(obj["longitude"])
        street = Street.from_dict(obj["street"])
        return Location(latitude, longitude, street)

    def to_dict(self) -> dict:
        result: dict = {}
        result["latitude"] = from_str(self.latitude)
        result["longitude"] = from_str(self.longitude)
        result["street"] = to_class(Street, self.street)
        return result


@dataclass
class OutcomeStatus:
    category: str
    date: str

    @staticmethod
    def from_dict(obj: Any) -> 'OutcomeStatus':
        assert isinstance(obj, dict)
        category = from_str(obj["category"])
        date = from_str(obj["date"])
        return OutcomeStatus(category, date)

    def to_dict(self) -> dict:
        result: dict = {}
        result["category"] = from_str(self.category)
        result["date"] = from_str(self.date)
        return result


@dataclass
class TopLevelElement:
    category: str
    context: str
    id: int
    location: Location
    location_subtype: str
    location_type: str
    month: str
    outcome_status: OutcomeStatus
    persistent_id: str

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevelElement':
        assert isinstance(obj, dict)
        category = from_str(obj["category"])
        context = from_str(obj["context"])
        id = from_int(obj["id"])
        location = Location.from_dict(obj["location"])
        location_subtype = from_str(obj["location_subtype"])
        location_type = from_str(obj["location_type"])
        month = from_str(obj["month"])
        outcome_status = OutcomeStatus.from_dict(obj["outcome_status"])
        persistent_id = from_str(obj["persistent_id"])
        return TopLevelElement(category, context, id, location, location_subtype, location_type, month, outcome_status, persistent_id)

    def to_dict(self) -> dict:
        result: dict = {}
        result["category"] = from_str(self.category)
        result["context"] = from_str(self.context)
        result["id"] = from_int(self.id)
        result["location"] = to_class(Location, self.location)
        result["location_subtype"] = from_str(self.location_subtype)
        result["location_type"] = from_str(self.location_type)
        result["month"] = from_str(self.month)
        result["outcome_status"] = to_class(OutcomeStatus, self.outcome_status)
        result["persistent_id"] = from_str(self.persistent_id)
        return result


def top_level_from_dict(s: Any) -> list[TopLevelElement]:
    return from_list(TopLevelElement.from_dict, s)


def top_level_to_dict(x: list[TopLevelElement]) -> Any:
    return from_list(lambda x: to_class(TopLevelElement, x), x)
