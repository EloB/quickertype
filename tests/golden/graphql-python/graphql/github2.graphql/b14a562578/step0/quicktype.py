from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


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


@dataclass
class Repository:
    name: str

    @staticmethod
    def from_dict(obj: Any) -> 'Repository':
        assert isinstance(obj, dict)
        name = from_str(obj["name"])
        return Repository(name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["name"] = from_str(self.name)
        return result


@dataclass
class RepositoryConnection:
    total_count: int
    nodes: list[Repository | None] | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'RepositoryConnection':
        assert isinstance(obj, dict)
        total_count = from_int(obj["totalCount"])
        nodes = from_union([lambda x: from_list(lambda x: from_union([Repository.from_dict, from_none], x), x), from_none], obj["nodes"])
        return RepositoryConnection(total_count, nodes)

    def to_dict(self) -> dict:
        result: dict = {}
        result["totalCount"] = from_int(self.total_count)
        result["nodes"] = from_union([lambda x: from_list(lambda x: from_union([lambda x: to_class(Repository, x), from_none], x), x), from_none], self.nodes)
        return result


@dataclass
class User:
    login: str
    repositories: RepositoryConnection

    @staticmethod
    def from_dict(obj: Any) -> 'User':
        assert isinstance(obj, dict)
        login = from_str(obj["login"])
        repositories = RepositoryConnection.from_dict(obj["repositories"])
        return User(login, repositories)

    def to_dict(self) -> dict:
        result: dict = {}
        result["login"] = from_str(self.login)
        result["repositories"] = to_class(RepositoryConnection, self.repositories)
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
