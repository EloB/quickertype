from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class Generated:
    greeting: str
    instructions: list[str]

    @staticmethod
    def from_dict(obj: Any) -> 'Generated':
        assert isinstance(obj, dict)
        greeting = from_str(obj["greeting"])
        instructions = from_list(from_str, obj["instructions"])
        return Generated(greeting, instructions)

    def to_dict(self) -> dict:
        result: dict = {}
        result["greeting"] = from_str(self.greeting)
        result["instructions"] = from_list(from_str, self.instructions)
        return result


def generated_from_dict(s: Any) -> Generated:
    return Generated.from_dict(s)


def generated_to_dict(x: Generated) -> Any:
    return to_class(Generated, x)
