from typing import Any, TypeVar, Callable


T = TypeVar("T")


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def top_level_from_dict(s: Any) -> list[int]:
    return from_list(from_int, s)


def top_level_to_dict(x: list[int]) -> Any:
    return from_list(from_int, x)
