from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast


T = TypeVar("T")


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class TopLevelBla:
    bar: int

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevelBla':
        assert isinstance(obj, dict)
        bar = from_int(obj["bar"])
        return TopLevelBla(bar)

    def to_dict(self) -> dict:
        result: dict = {}
        result["bar"] = from_int(self.bar)
        return result


@dataclass
class Empty:
    x: int

    @staticmethod
    def from_dict(obj: Any) -> 'Empty':
        assert isinstance(obj, dict)
        x = from_int(obj["x"])
        return Empty(x)

    def to_dict(self) -> dict:
        result: dict = {}
        result["x"] = from_int(self.x)
        return result


@dataclass
class FooBla:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'FooBla':
        assert isinstance(obj, dict)
        return FooBla()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Foo:
    empty: int
    foo: int
    bla: FooBla

    @staticmethod
    def from_dict(obj: Any) -> 'Foo':
        assert isinstance(obj, dict)
        empty = from_int(obj["_"])
        foo = from_int(obj["__"])
        bla = FooBla.from_dict(obj["bla"])
        return Foo(empty, foo, bla)

    def to_dict(self) -> dict:
        result: dict = {}
        result["_"] = from_int(self.empty)
        result["__"] = from_int(self.foo)
        result["bla"] = to_class(FooBla, self.bla)
        return result


@dataclass
class ThisIsAToughOne:
    empty: int
    this_is_a_tough_one: int

    @staticmethod
    def from_dict(obj: Any) -> 'ThisIsAToughOne':
        assert isinstance(obj, dict)
        empty = from_int(obj["\n\n\n"])
        this_is_a_tough_one = from_int(obj["\""])
        return ThisIsAToughOne(empty, this_is_a_tough_one)

    def to_dict(self) -> dict:
        result: dict = {}
        result["\n\n\n"] = from_int(self.empty)
        result["\""] = from_int(self.this_is_a_tough_one)
        return result


@dataclass
class EmptyClass:
    y: int

    @staticmethod
    def from_dict(obj: Any) -> 'EmptyClass':
        assert isinstance(obj, dict)
        y = from_int(obj["y"])
        return EmptyClass(y)

    def to_dict(self) -> dict:
        result: dict = {}
        result["y"] = from_int(self.y)
        return result


@dataclass
class TopLevel:
    empty: Empty
    top_level: int
    top_level_empty: EmptyClass
    this_is_a_tough_one: ThisIsAToughOne
    bla: TopLevelBla
    foo: Foo

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        empty = Empty.from_dict(obj[""])
        top_level = from_int(obj["!"])
        top_level_empty = EmptyClass.from_dict(obj["Empty"])
        this_is_a_tough_one = ThisIsAToughOne.from_dict(obj["ThisIsA\U0001f61cTough\"\n\nOne"])
        bla = TopLevelBla.from_dict(obj["bla"])
        foo = Foo.from_dict(obj["foo"])
        return TopLevel(empty, top_level, top_level_empty, this_is_a_tough_one, bla, foo)

    def to_dict(self) -> dict:
        result: dict = {}
        result[""] = to_class(Empty, self.empty)
        result["!"] = from_int(self.top_level)
        result["Empty"] = to_class(EmptyClass, self.top_level_empty)
        result["ThisIsA\U0001f61cTough\"\n\nOne"] = to_class(ThisIsAToughOne, self.this_is_a_tough_one)
        result["bla"] = to_class(TopLevelBla, self.bla)
        result["foo"] = to_class(Foo, self.foo)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
