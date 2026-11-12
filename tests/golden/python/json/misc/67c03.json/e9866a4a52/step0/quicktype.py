from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class Person:
    craft: str
    name: str

    @staticmethod
    def from_dict(obj: Any) -> 'Person':
        assert isinstance(obj, dict)
        craft = from_str(obj["craft"])
        name = from_str(obj["name"])
        return Person(craft, name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["craft"] = from_str(self.craft)
        result["name"] = from_str(self.name)
        return result


@dataclass
class TopLevel:
    message: str
    number: int
    people: list[Person]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        message = from_str(obj["message"])
        number = from_int(obj["number"])
        people = from_list(Person.from_dict, obj["people"])
        return TopLevel(message, number, people)

    def to_dict(self) -> dict:
        result: dict = {}
        result["message"] = from_str(self.message)
        result["number"] = from_int(self.number)
        result["people"] = from_list(lambda x: to_class(Person, x), self.people)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
