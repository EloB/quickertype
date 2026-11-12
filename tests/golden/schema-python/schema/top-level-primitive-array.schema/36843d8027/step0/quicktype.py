from typing import Any, TypeVar, Callable


T = TypeVar("T")


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def top_level_from_dict(s: Any) -> list[str]:
    return from_list(from_str, s)


def top_level_to_dict(x: list[str]) -> Any:
    return from_list(from_str, x)
