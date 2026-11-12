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
class Response:
    player_count: int
    result: int

    @staticmethod
    def from_dict(obj: Any) -> 'Response':
        assert isinstance(obj, dict)
        player_count = from_int(obj["player_count"])
        result = from_int(obj["result"])
        return Response(player_count, result)

    def to_dict(self) -> dict:
        result: dict = {}
        result["player_count"] = from_int(self.player_count)
        result["result"] = from_int(self.result)
        return result


@dataclass
class TopLevel:
    response: Response

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        response = Response.from_dict(obj["response"])
        return TopLevel(response)

    def to_dict(self) -> dict:
        result: dict = {}
        result["response"] = to_class(Response, self.response)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
