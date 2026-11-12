from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_union(fs, x):
    for f in fs:
        try:
            return f(x)
        except:
            pass
    assert False


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def from_none(x: Any) -> Any:
    assert x is None
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


def from_dict(f: Callable[[Any], T], x: Any) -> dict[str, T]:
    assert isinstance(x, dict)
    return { k: f(v) for (k, v) in x.items() }


def is_type(t: Type[T], x: Any) -> T:
    assert isinstance(x, t)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


def to_float(x: Any) -> float:
    assert isinstance(x, (int, float))
    return x


@dataclass
class DifferentThingClass:
    name: str

    @staticmethod
    def from_dict(obj: Any) -> 'DifferentThingClass':
        assert isinstance(obj, dict)
        name = from_str(obj["name"])
        return DifferentThingClass(name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["name"] = from_str(self.name)
        return result


@dataclass
class PersonElement:
    int_or_string: int
    name: str
    optional_value: bool | None

    @staticmethod
    def from_dict(obj: Any) -> 'PersonElement':
        assert isinstance(obj, dict)
        int_or_string = from_union([from_int, lambda x: int(from_str(x))], obj["intOrString"])
        name = from_str(obj["name"])
        optional_value = from_union([from_bool, from_none], obj.get("optionalValue"))
        return PersonElement(int_or_string, name, optional_value)

    def to_dict(self) -> dict:
        result: dict = {}
        result["intOrString"] = from_int(self.int_or_string)
        result["name"] = from_str(self.name)
        if self.optional_value is not None:
            result["optionalValue"] = from_union([from_bool, from_none], self.optional_value)
        return result


@dataclass
class PurplePerson:
    int_or_string: int
    name: str

    @staticmethod
    def from_dict(obj: Any) -> 'PurplePerson':
        assert isinstance(obj, dict)
        int_or_string = from_int(obj["intOrString"])
        name = from_str(obj["name"])
        return PurplePerson(int_or_string, name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["intOrString"] = from_int(self.int_or_string)
        result["name"] = from_str(self.name)
        return result


@dataclass
class TopLevel:
    boolean_value: bool
    date_value: str
    different_things: list[DifferentThingClass | int]
    double_value: float
    int_value: int
    map_value: dict[str, int | None]
    nullable_map_value: dict[str, int | None]
    people: list[PersonElement]
    person: PurplePerson
    string_value: str
    tuples: list[list[int | str]]
    uuid_value: str
    name_with_spaces: None
    null_value: None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        boolean_value = from_bool(obj["booleanValue"])
        date_value = from_str(obj["dateValue"])
        different_things = from_list(lambda x: from_union([from_int, lambda x: int(from_str(x)), DifferentThingClass.from_dict], x), obj["differentThings"])
        double_value = from_float(obj["doubleValue"])
        int_value = from_int(obj["intValue"])
        map_value = from_dict(lambda x: from_union([from_int, from_none], x), obj["mapValue"])
        nullable_map_value = from_dict(lambda x: from_union([from_int, from_none], x), obj["nullableMapValue"])
        people = from_list(PersonElement.from_dict, obj["people"])
        person = PurplePerson.from_dict(obj["person"])
        string_value = from_str(obj["stringValue"])
        tuples = from_list(lambda x: from_list(lambda x: from_union([from_int, from_str], x), x), obj["tuples"])
        uuid_value = from_str(obj["uuidValue"])
        name_with_spaces = from_none(obj["name with spaces"])
        null_value = from_none(obj["nullValue"])
        return TopLevel(boolean_value, date_value, different_things, double_value, int_value, map_value, nullable_map_value, people, person, string_value, tuples, uuid_value, name_with_spaces, null_value)

    def to_dict(self) -> dict:
        result: dict = {}
        result["booleanValue"] = from_bool(self.boolean_value)
        result["dateValue"] = from_str(self.date_value)
        result["differentThings"] = from_list(lambda x: from_union([lambda x: from_int((lambda x: is_type(int, x))(x)), lambda x: to_class(DifferentThingClass, (lambda x: is_type(DifferentThingClass, x))(x))], x), self.different_things)
        result["doubleValue"] = to_float(self.double_value)
        result["intValue"] = from_int(self.int_value)
        result["mapValue"] = from_dict(lambda x: from_union([from_int, from_none], x), self.map_value)
        result["nullableMapValue"] = from_dict(lambda x: from_union([from_int, from_none], x), self.nullable_map_value)
        result["people"] = from_list(lambda x: to_class(PersonElement, x), self.people)
        result["person"] = to_class(PurplePerson, self.person)
        result["stringValue"] = from_str(self.string_value)
        result["tuples"] = from_list(lambda x: from_list(lambda x: from_union([from_int, from_str], x), x), self.tuples)
        result["uuidValue"] = from_str(self.uuid_value)
        result["name with spaces"] = from_none(self.name_with_spaces)
        result["nullValue"] = from_none(self.null_value)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
