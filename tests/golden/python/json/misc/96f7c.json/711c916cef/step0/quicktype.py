from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class TopLevel:
    git: list[str]
    github_services_sha: str
    hooks: list[str]
    importer: list[str]
    pages: list[str]
    verifiable_password_authentication: bool

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        git = from_list(from_str, obj["git"])
        github_services_sha = from_str(obj["github_services_sha"])
        hooks = from_list(from_str, obj["hooks"])
        importer = from_list(from_str, obj["importer"])
        pages = from_list(from_str, obj["pages"])
        verifiable_password_authentication = from_bool(obj["verifiable_password_authentication"])
        return TopLevel(git, github_services_sha, hooks, importer, pages, verifiable_password_authentication)

    def to_dict(self) -> dict:
        result: dict = {}
        result["git"] = from_list(from_str, self.git)
        result["github_services_sha"] = from_str(self.github_services_sha)
        result["hooks"] = from_list(from_str, self.hooks)
        result["importer"] = from_list(from_str, self.importer)
        result["pages"] = from_list(from_str, self.pages)
        result["verifiable_password_authentication"] = from_bool(self.verifiable_password_authentication)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
