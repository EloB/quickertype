from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast, Callable


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_none(x: Any) -> Any:
    assert x is None
    return x


def from_union(fs, x):
    for f in fs:
        try:
            return f(x)
        except:
            pass
    assert False


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


@dataclass
class User:
    login: str
    real_name: str | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'User':
        assert isinstance(obj, dict)
        login = from_str(obj["login"])
        real_name = from_union([from_str, from_none], obj["realName"])
        return User(login, real_name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["login"] = from_str(self.login)
        result["realName"] = from_union([from_str, from_none], self.real_name)
        return result


@dataclass
class Data:
    viewer: User

    @staticmethod
    def from_dict(obj: Any) -> 'Data':
        assert isinstance(obj, dict)
        viewer = User.from_dict(obj["viewer"])
        return Data(viewer)

    def to_dict(self) -> dict:
        result: dict = {}
        result["viewer"] = to_class(User, self.viewer)
        return result


@dataclass
class Error:
    message: str

    @staticmethod
    def from_dict(obj: Any) -> 'Error':
        assert isinstance(obj, dict)
        message = from_str(obj["message"])
        return Error(message)

    def to_dict(self) -> dict:
        result: dict = {}
        result["message"] = from_str(self.message)
        return result


@dataclass
class TopLevel:
    data: Data | None = None
    errors: list[Error] | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        data = from_union([Data.from_dict, from_none], obj["data"])
        errors = from_union([lambda x: from_list(Error.from_dict, x), from_none], obj.get("errors"))
        return TopLevel(data, errors)

    def to_dict(self) -> dict:
        result: dict = {}
        result["data"] = from_union([lambda x: to_class(Data, x), from_none], self.data)
        if self.errors is not None:
            result["errors"] = from_union([lambda x: from_list(lambda x: to_class(Error, x), x), from_none], self.errors)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
