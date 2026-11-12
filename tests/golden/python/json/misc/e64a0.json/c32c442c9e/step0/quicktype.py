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
class Args:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Args':
        assert isinstance(obj, dict)
        return Args()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


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
    args: Args
    headers: Headers
    origin: str
    url: str

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        args = Args.from_dict(obj["args"])
        headers = Headers.from_dict(obj["headers"])
        origin = from_str(obj["origin"])
        url = from_str(obj["url"])
        return TopLevel(args, headers, origin, url)

    def to_dict(self) -> dict:
        result: dict = {}
        result["args"] = to_class(Args, self.args)
        result["headers"] = to_class(Headers, self.headers)
        result["origin"] = from_str(self.origin)
        result["url"] = from_str(self.url)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
