from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast, Callable


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


class TypeEnum(Enum):
    STRING = "string"


@dataclass
class ClickURL:
    description: str
    type: TypeEnum

    @staticmethod
    def from_dict(obj: Any) -> 'ClickURL':
        assert isinstance(obj, dict)
        description = from_str(obj["description"])
        type = TypeEnum(obj["type"])
        return ClickURL(description, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["description"] = from_str(self.description)
        result["type"] = to_enum(TypeEnum, self.type)
        return result


@dataclass
class Properties:
    click_url: ClickURL
    country: ClickURL
    description: ClickURL
    expiration_date: ClickURL
    id: ClickURL
    industry: ClickURL
    report_type: ClickURL
    source_industry: ClickURL
    title: ClickURL
    url: ClickURL

    @staticmethod
    def from_dict(obj: Any) -> 'Properties':
        assert isinstance(obj, dict)
        click_url = ClickURL.from_dict(obj["click_url"])
        country = ClickURL.from_dict(obj["country"])
        description = ClickURL.from_dict(obj["description"])
        expiration_date = ClickURL.from_dict(obj["expiration_date"])
        id = ClickURL.from_dict(obj["id"])
        industry = ClickURL.from_dict(obj["industry"])
        report_type = ClickURL.from_dict(obj["report_type"])
        source_industry = ClickURL.from_dict(obj["source_industry"])
        title = ClickURL.from_dict(obj["title"])
        url = ClickURL.from_dict(obj["url"])
        return Properties(click_url, country, description, expiration_date, id, industry, report_type, source_industry, title, url)

    def to_dict(self) -> dict:
        result: dict = {}
        result["click_url"] = to_class(ClickURL, self.click_url)
        result["country"] = to_class(ClickURL, self.country)
        result["description"] = to_class(ClickURL, self.description)
        result["expiration_date"] = to_class(ClickURL, self.expiration_date)
        result["id"] = to_class(ClickURL, self.id)
        result["industry"] = to_class(ClickURL, self.industry)
        result["report_type"] = to_class(ClickURL, self.report_type)
        result["source_industry"] = to_class(ClickURL, self.source_industry)
        result["title"] = to_class(ClickURL, self.title)
        result["url"] = to_class(ClickURL, self.url)
        return result


@dataclass
class Report:
    properties: Properties

    @staticmethod
    def from_dict(obj: Any) -> 'Report':
        assert isinstance(obj, dict)
        properties = Properties.from_dict(obj["properties"])
        return Report(properties)

    def to_dict(self) -> dict:
        result: dict = {}
        result["properties"] = to_class(Properties, self.properties)
        return result


@dataclass
class Definitions:
    report: Report

    @staticmethod
    def from_dict(obj: Any) -> 'Definitions':
        assert isinstance(obj, dict)
        report = Report.from_dict(obj["Report"])
        return Definitions(report)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Report"] = to_class(Report, self.report)
        return result


@dataclass
class Info:
    description: str
    title: str
    version: str

    @staticmethod
    def from_dict(obj: Any) -> 'Info':
        assert isinstance(obj, dict)
        description = from_str(obj["description"])
        title = from_str(obj["title"])
        version = from_str(obj["version"])
        return Info(description, title, version)

    def to_dict(self) -> dict:
        result: dict = {}
        result["description"] = from_str(self.description)
        result["title"] = from_str(self.title)
        result["version"] = from_str(self.version)
        return result


@dataclass
class Parameter:
    description: str
    format: TypeEnum
    parameter_in: str
    name: str
    required: bool
    type: TypeEnum

    @staticmethod
    def from_dict(obj: Any) -> 'Parameter':
        assert isinstance(obj, dict)
        description = from_str(obj["description"])
        format = TypeEnum(obj["format"])
        parameter_in = from_str(obj["in"])
        name = from_str(obj["name"])
        required = from_bool(obj["required"])
        type = TypeEnum(obj["type"])
        return Parameter(description, format, parameter_in, name, required, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["description"] = from_str(self.description)
        result["format"] = to_enum(TypeEnum, self.format)
        result["in"] = from_str(self.parameter_in)
        result["name"] = from_str(self.name)
        result["required"] = from_bool(self.required)
        result["type"] = to_enum(TypeEnum, self.type)
        return result


@dataclass
class Items:
    ref: str

    @staticmethod
    def from_dict(obj: Any) -> 'Items':
        assert isinstance(obj, dict)
        ref = from_str(obj["$ref"])
        return Items(ref)

    def to_dict(self) -> dict:
        result: dict = {}
        result["$ref"] = from_str(self.ref)
        return result


@dataclass
class Schema:
    items: Items
    type: str

    @staticmethod
    def from_dict(obj: Any) -> 'Schema':
        assert isinstance(obj, dict)
        items = Items.from_dict(obj["items"])
        type = from_str(obj["type"])
        return Schema(items, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["items"] = to_class(Items, self.items)
        result["type"] = from_str(self.type)
        return result


@dataclass
class The200:
    description: str
    schema: Schema

    @staticmethod
    def from_dict(obj: Any) -> 'The200':
        assert isinstance(obj, dict)
        description = from_str(obj["description"])
        schema = Schema.from_dict(obj["schema"])
        return The200(description, schema)

    def to_dict(self) -> dict:
        result: dict = {}
        result["description"] = from_str(self.description)
        result["schema"] = to_class(Schema, self.schema)
        return result


@dataclass
class Responses:
    the_200: The200

    @staticmethod
    def from_dict(obj: Any) -> 'Responses':
        assert isinstance(obj, dict)
        the_200 = The200.from_dict(obj["200"])
        return Responses(the_200)

    def to_dict(self) -> dict:
        result: dict = {}
        result["200"] = to_class(The200, self.the_200)
        return result


@dataclass
class Get:
    description: str
    parameters: list[Parameter]
    responses: Responses
    summary: str
    tags: list[str]

    @staticmethod
    def from_dict(obj: Any) -> 'Get':
        assert isinstance(obj, dict)
        description = from_str(obj["description"])
        parameters = from_list(Parameter.from_dict, obj["parameters"])
        responses = Responses.from_dict(obj["responses"])
        summary = from_str(obj["summary"])
        tags = from_list(from_str, obj["tags"])
        return Get(description, parameters, responses, summary, tags)

    def to_dict(self) -> dict:
        result: dict = {}
        result["description"] = from_str(self.description)
        result["parameters"] = from_list(lambda x: to_class(Parameter, x), self.parameters)
        result["responses"] = to_class(Responses, self.responses)
        result["summary"] = from_str(self.summary)
        result["tags"] = from_list(from_str, self.tags)
        return result


@dataclass
class MarketResearchLibrarySearch:
    get: Get

    @staticmethod
    def from_dict(obj: Any) -> 'MarketResearchLibrarySearch':
        assert isinstance(obj, dict)
        get = Get.from_dict(obj["get"])
        return MarketResearchLibrarySearch(get)

    def to_dict(self) -> dict:
        result: dict = {}
        result["get"] = to_class(Get, self.get)
        return result


@dataclass
class Paths:
    market_research_library_search: MarketResearchLibrarySearch

    @staticmethod
    def from_dict(obj: Any) -> 'Paths':
        assert isinstance(obj, dict)
        market_research_library_search = MarketResearchLibrarySearch.from_dict(obj["/market_research_library/search"])
        return Paths(market_research_library_search)

    def to_dict(self) -> dict:
        result: dict = {}
        result["/market_research_library/search"] = to_class(MarketResearchLibrarySearch, self.market_research_library_search)
        return result


@dataclass
class TopLevel:
    base_path: str
    definitions: Definitions
    host: str
    info: Info
    paths: Paths
    produces: list[str]
    schemes: list[str]
    swagger: str

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        base_path = from_str(obj["basePath"])
        definitions = Definitions.from_dict(obj["definitions"])
        host = from_str(obj["host"])
        info = Info.from_dict(obj["info"])
        paths = Paths.from_dict(obj["paths"])
        produces = from_list(from_str, obj["produces"])
        schemes = from_list(from_str, obj["schemes"])
        swagger = from_str(obj["swagger"])
        return TopLevel(base_path, definitions, host, info, paths, produces, schemes, swagger)

    def to_dict(self) -> dict:
        result: dict = {}
        result["basePath"] = from_str(self.base_path)
        result["definitions"] = to_class(Definitions, self.definitions)
        result["host"] = from_str(self.host)
        result["info"] = to_class(Info, self.info)
        result["paths"] = to_class(Paths, self.paths)
        result["produces"] = from_list(from_str, self.produces)
        result["schemes"] = from_list(from_str, self.schemes)
        result["swagger"] = from_str(self.swagger)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
