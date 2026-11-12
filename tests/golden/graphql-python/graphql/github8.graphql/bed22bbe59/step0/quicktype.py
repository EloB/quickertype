from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast, Callable


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


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


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


class IssueState(Enum):
    OPEN = "OPEN"
    CLOSED = "CLOSED"


@dataclass
class IssueOrPullRequest:
    title: str | None = None
    state: IssueState | None = None
    merged: bool | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'IssueOrPullRequest':
        assert isinstance(obj, dict)
        title = from_union([from_str, from_none], obj.get("title"))
        state = from_union([IssueState, from_none], obj.get("state"))
        merged = from_union([from_bool, from_none], obj.get("merged"))
        return IssueOrPullRequest(title, state, merged)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.title is not None:
            result["title"] = from_union([from_str, from_none], self.title)
        if self.state is not None:
            result["state"] = from_union([lambda x: to_enum(IssueState, x), from_none], self.state)
        if self.merged is not None:
            result["merged"] = from_union([from_bool, from_none], self.merged)
        return result


@dataclass
class Repository:
    name_with_owner: str
    n303: IssueOrPullRequest | None = None
    n307: IssueOrPullRequest | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'Repository':
        assert isinstance(obj, dict)
        name_with_owner = from_str(obj["nameWithOwner"])
        n303 = from_union([IssueOrPullRequest.from_dict, from_none], obj["n303"])
        n307 = from_union([IssueOrPullRequest.from_dict, from_none], obj["n307"])
        return Repository(name_with_owner, n303, n307)

    def to_dict(self) -> dict:
        result: dict = {}
        result["nameWithOwner"] = from_str(self.name_with_owner)
        result["n303"] = from_union([lambda x: to_class(IssueOrPullRequest, x), from_none], self.n303)
        result["n307"] = from_union([lambda x: to_class(IssueOrPullRequest, x), from_none], self.n307)
        return result


@dataclass
class Data:
    repository: Repository | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'Data':
        assert isinstance(obj, dict)
        repository = from_union([Repository.from_dict, from_none], obj["repository"])
        return Data(repository)

    def to_dict(self) -> dict:
        result: dict = {}
        result["repository"] = from_union([lambda x: to_class(Repository, x), from_none], self.repository)
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
