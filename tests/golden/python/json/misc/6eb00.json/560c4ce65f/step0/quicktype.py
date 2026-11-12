from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


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
class TopLevelElement:
    directorate_id: int
    id: int
    name: str

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevelElement':
        assert isinstance(obj, dict)
        directorate_id = from_int(obj["DirectorateID"])
        id = from_int(obj["Id"])
        name = from_str(obj["Name"])
        return TopLevelElement(directorate_id, id, name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["DirectorateID"] = from_int(self.directorate_id)
        result["Id"] = from_int(self.id)
        result["Name"] = from_str(self.name)
        return result


def top_level_from_dict(s: Any) -> list[TopLevelElement]:
    return from_list(TopLevelElement.from_dict, s)


def top_level_to_dict(x: list[TopLevelElement]) -> Any:
    return from_list(lambda x: to_class(TopLevelElement, x), x)
