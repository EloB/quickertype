from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class Headers:
    accept_encoding: str
    connection: str
    host: str
    user_agent: str

    @staticmethod
    def from_dict(obj: Any) -> 'Headers':
        assert isinstance(obj, dict)
        accept_encoding = from_str(obj["Accept-Encoding"])
        connection = from_str(obj["Connection"])
        host = from_str(obj["Host"])
        user_agent = from_str(obj["User-Agent"])
        return Headers(accept_encoding, connection, host, user_agent)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Accept-Encoding"] = from_str(self.accept_encoding)
        result["Connection"] = from_str(self.connection)
        result["Host"] = from_str(self.host)
        result["User-Agent"] = from_str(self.user_agent)
        return result


@dataclass
class TopLevel:
    headers: Headers

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        headers = Headers.from_dict(obj["headers"])
        return TopLevel(headers)

    def to_dict(self) -> dict:
        result: dict = {}
        result["headers"] = to_class(Headers, self.headers)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
