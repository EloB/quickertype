from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast
from enum import Enum


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_none(x: Any) -> Any:
    assert x is None
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


@dataclass
class Identifier:
    identifier: str
    scheme: str

    @staticmethod
    def from_dict(obj: Any) -> 'Identifier':
        assert isinstance(obj, dict)
        identifier = from_str(obj["identifier"])
        scheme = from_str(obj["scheme"])
        return Identifier(identifier, scheme)

    def to_dict(self) -> dict:
        result: dict = {}
        result["identifier"] = from_str(self.identifier)
        result["scheme"] = from_str(self.scheme)
        return result


class Keyword(Enum):
    DISCOURAGED = "discouraged"
    RETIRED = "retired"
    OSI_APPROVED = "osi-approved"


@dataclass
class Link:
    note: str
    url: str

    @staticmethod
    def from_dict(obj: Any) -> 'Link':
        assert isinstance(obj, dict)
        note = from_str(obj["note"])
        url = from_str(obj["url"])
        return Link(note, url)

    def to_dict(self) -> dict:
        result: dict = {}
        result["note"] = from_str(self.note)
        result["url"] = from_str(self.url)
        return result


@dataclass
class Text:
    media_type: str
    title: str
    url: str

    @staticmethod
    def from_dict(obj: Any) -> 'Text':
        assert isinstance(obj, dict)
        media_type = from_str(obj["media_type"])
        title = from_str(obj["title"])
        url = from_str(obj["url"])
        return Text(media_type, title, url)

    def to_dict(self) -> dict:
        result: dict = {}
        result["media_type"] = from_str(self.media_type)
        result["title"] = from_str(self.title)
        result["url"] = from_str(self.url)
        return result


@dataclass
class TopLevelElement:
    id: str
    identifiers: list[Identifier]
    keywords: list[Keyword]
    links: list[Link]
    name: str
    other_names: list[Any]
    text: list[Text]
    superseded_by: None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevelElement':
        assert isinstance(obj, dict)
        id = from_str(obj["id"])
        identifiers = from_list(Identifier.from_dict, obj["identifiers"])
        keywords = from_list(Keyword, obj["keywords"])
        links = from_list(Link.from_dict, obj["links"])
        name = from_str(obj["name"])
        other_names = from_list(lambda x: x, obj["other_names"])
        text = from_list(Text.from_dict, obj["text"])
        superseded_by = from_none(obj["superseded_by"])
        return TopLevelElement(id, identifiers, keywords, links, name, other_names, text, superseded_by)

    def to_dict(self) -> dict:
        result: dict = {}
        result["id"] = from_str(self.id)
        result["identifiers"] = from_list(lambda x: to_class(Identifier, x), self.identifiers)
        result["keywords"] = from_list(lambda x: to_enum(Keyword, x), self.keywords)
        result["links"] = from_list(lambda x: to_class(Link, x), self.links)
        result["name"] = from_str(self.name)
        result["other_names"] = from_list(lambda x: x, self.other_names)
        result["text"] = from_list(lambda x: to_class(Text, x), self.text)
        result["superseded_by"] = from_none(self.superseded_by)
        return result


def top_level_from_dict(s: Any) -> list[TopLevelElement]:
    return from_list(TopLevelElement.from_dict, s)


def top_level_to_dict(x: list[TopLevelElement]) -> Any:
    return from_list(lambda x: to_class(TopLevelElement, x), x)
