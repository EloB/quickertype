import datetime
from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Type, Callable, cast
import dateutil.parser


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
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


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def from_datetime(x: Any) -> datetime.datetime:
    return dateutil.parser.parse(x)


def from_dict(f: Callable[[Any], T], x: Any) -> dict[str, T]:
    assert isinstance(x, dict)
    return { k: f(v) for (k, v) in x.items() }


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


class Language(Enum):
    MARKDOWN = "Markdown"


class TypeEnum(Enum):
    TEXT_PLAIN = "text/plain"


@dataclass
class File:
    filename: str
    raw_url: str
    size: int
    type: TypeEnum
    language: Language | None

    @staticmethod
    def from_dict(obj: Any) -> 'File':
        assert isinstance(obj, dict)
        filename = from_str(obj["filename"])
        raw_url = from_str(obj["raw_url"])
        size = from_int(obj["size"])
        type = TypeEnum(obj["type"])
        language = from_union([Language, from_none], obj["language"])
        return File(filename, raw_url, size, type, language)

    def to_dict(self) -> dict:
        result: dict = {}
        result["filename"] = from_str(self.filename)
        result["raw_url"] = from_str(self.raw_url)
        result["size"] = from_int(self.size)
        result["type"] = to_enum(TypeEnum, self.type)
        result["language"] = from_union([lambda x: to_enum(Language, x), from_none], self.language)
        return result


@dataclass
class TopLevelElement:
    comments: int
    comments_url: str
    commits_url: str
    created_at: datetime.datetime
    files: dict[str, File]
    forks_url: str
    git_pull_url: str
    git_push_url: str
    html_url: str
    id: str
    public: bool
    truncated: bool
    updated_at: datetime.datetime
    url: str
    description: str | None
    user: None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevelElement':
        assert isinstance(obj, dict)
        comments = from_int(obj["comments"])
        comments_url = from_str(obj["comments_url"])
        commits_url = from_str(obj["commits_url"])
        created_at = from_datetime(obj["created_at"])
        files = from_dict(File.from_dict, obj["files"])
        forks_url = from_str(obj["forks_url"])
        git_pull_url = from_str(obj["git_pull_url"])
        git_push_url = from_str(obj["git_push_url"])
        html_url = from_str(obj["html_url"])
        id = from_str(obj["id"])
        public = from_bool(obj["public"])
        truncated = from_bool(obj["truncated"])
        updated_at = from_datetime(obj["updated_at"])
        url = from_str(obj["url"])
        description = from_union([from_none, from_str], obj["description"])
        user = from_none(obj["user"])
        return TopLevelElement(comments, comments_url, commits_url, created_at, files, forks_url, git_pull_url, git_push_url, html_url, id, public, truncated, updated_at, url, description, user)

    def to_dict(self) -> dict:
        result: dict = {}
        result["comments"] = from_int(self.comments)
        result["comments_url"] = from_str(self.comments_url)
        result["commits_url"] = from_str(self.commits_url)
        result["created_at"] = self.created_at.isoformat()
        result["files"] = from_dict(lambda x: to_class(File, x), self.files)
        result["forks_url"] = from_str(self.forks_url)
        result["git_pull_url"] = from_str(self.git_pull_url)
        result["git_push_url"] = from_str(self.git_push_url)
        result["html_url"] = from_str(self.html_url)
        result["id"] = from_str(self.id)
        result["public"] = from_bool(self.public)
        result["truncated"] = from_bool(self.truncated)
        result["updated_at"] = self.updated_at.isoformat()
        result["url"] = from_str(self.url)
        result["description"] = from_union([from_none, from_str], self.description)
        result["user"] = from_none(self.user)
        return result


def top_level_from_dict(s: Any) -> list[TopLevelElement]:
    return from_list(TopLevelElement.from_dict, s)


def top_level_to_dict(x: list[TopLevelElement]) -> Any:
    return from_list(lambda x: to_class(TopLevelElement, x), x)
