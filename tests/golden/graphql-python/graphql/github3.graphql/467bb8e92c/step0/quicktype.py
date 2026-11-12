from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Type, Callable, cast


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


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


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


class PullRequestState(Enum):
    OPEN = "OPEN"
    CLOSED = "CLOSED"
    MERGED = "MERGED"


@dataclass
class PullRequest:
    state: PullRequestState

    @staticmethod
    def from_dict(obj: Any) -> 'PullRequest':
        assert isinstance(obj, dict)
        state = PullRequestState(obj["state"])
        return PullRequest(state)

    def to_dict(self) -> dict:
        result: dict = {}
        result["state"] = to_enum(PullRequestState, self.state)
        return result


@dataclass
class PullRequestConnection:
    nodes: list[PullRequest | None] | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'PullRequestConnection':
        assert isinstance(obj, dict)
        nodes = from_union([lambda x: from_list(lambda x: from_union([PullRequest.from_dict, from_none], x), x), from_none], obj["nodes"])
        return PullRequestConnection(nodes)

    def to_dict(self) -> dict:
        result: dict = {}
        result["nodes"] = from_union([lambda x: from_list(lambda x: from_union([lambda x: to_class(PullRequest, x), from_none], x), x), from_none], self.nodes)
        return result


@dataclass
class Repository:
    pull_requests: PullRequestConnection

    @staticmethod
    def from_dict(obj: Any) -> 'Repository':
        assert isinstance(obj, dict)
        pull_requests = PullRequestConnection.from_dict(obj["pullRequests"])
        return Repository(pull_requests)

    def to_dict(self) -> dict:
        result: dict = {}
        result["pullRequests"] = to_class(PullRequestConnection, self.pull_requests)
        return result


@dataclass
class User:
    login: str
    repository: Repository | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'User':
        assert isinstance(obj, dict)
        login = from_str(obj["login"])
        repository = from_union([Repository.from_dict, from_none], obj["repository"])
        return User(login, repository)

    def to_dict(self) -> dict:
        result: dict = {}
        result["login"] = from_str(self.login)
        result["repository"] = from_union([lambda x: to_class(Repository, x), from_none], self.repository)
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
