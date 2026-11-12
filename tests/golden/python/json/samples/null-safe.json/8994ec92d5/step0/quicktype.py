import datetime
from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast, Callable
import dateutil.parser


T = TypeVar("T")


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


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


@dataclass
class Address:
    city: str
    country: str
    street: str

    @staticmethod
    def from_dict(obj: Any) -> 'Address':
        assert isinstance(obj, dict)
        city = from_str(obj["city"])
        country = from_str(obj["country"])
        street = from_str(obj["street"])
        return Address(city, country, street)

    def to_dict(self) -> dict:
        result: dict = {}
        result["city"] = from_str(self.city)
        result["country"] = from_str(self.country)
        result["street"] = from_str(self.street)
        return result


@dataclass
class Item:
    name: str
    address: Address | None
    created_at: datetime.datetime | None
    sex: int | None

    @staticmethod
    def from_dict(obj: Any) -> 'Item':
        assert isinstance(obj, dict)
        name = from_str(obj["name"])
        address = from_union([Address.from_dict, from_none], obj.get("address"))
        created_at = from_union([from_datetime, from_none], obj.get("created_at"))
        sex = from_union([from_int, from_none], obj["sex"])
        return Item(name, address, created_at, sex)

    def to_dict(self) -> dict:
        result: dict = {}
        result["name"] = from_str(self.name)
        if self.address is not None:
            result["address"] = from_union([lambda x: to_class(Address, x), from_none], self.address)
        if self.created_at is not None:
            result["created_at"] = from_union([lambda x: x.isoformat(), from_none], self.created_at)
        result["sex"] = from_union([from_int, from_none], self.sex)
        return result


@dataclass
class TopLevel:
    item: list[Item]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        item = from_list(Item.from_dict, obj["item"])
        return TopLevel(item)

    def to_dict(self) -> dict:
        result: dict = {}
        result["item"] = from_list(lambda x: to_class(Item, x), self.item)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
