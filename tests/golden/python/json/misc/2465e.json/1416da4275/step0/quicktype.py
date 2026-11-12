from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast, Callable


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


@dataclass
class Annotations:
    description: str
    type: str

    @staticmethod
    def from_dict(obj: Any) -> 'Annotations':
        assert isinstance(obj, dict)
        description = from_str(obj["description"])
        type = from_str(obj["type"])
        return Annotations(description, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["description"] = from_str(self.description)
        result["type"] = from_str(self.type)
        return result


@dataclass
class Properties:
    annotations: Annotations
    datatype_properties: Annotations
    id: Annotations
    label: Annotations
    sub_class_of: Annotations
    type: Annotations

    @staticmethod
    def from_dict(obj: Any) -> 'Properties':
        assert isinstance(obj, dict)
        annotations = Annotations.from_dict(obj["annotations"])
        datatype_properties = Annotations.from_dict(obj["datatype_properties"])
        id = Annotations.from_dict(obj["id"])
        label = Annotations.from_dict(obj["label"])
        sub_class_of = Annotations.from_dict(obj["sub_class_of"])
        type = Annotations.from_dict(obj["type"])
        return Properties(annotations, datatype_properties, id, label, sub_class_of, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["annotations"] = to_class(Annotations, self.annotations)
        result["datatype_properties"] = to_class(Annotations, self.datatype_properties)
        result["id"] = to_class(Annotations, self.id)
        result["label"] = to_class(Annotations, self.label)
        result["sub_class_of"] = to_class(Annotations, self.sub_class_of)
        result["type"] = to_class(Annotations, self.type)
        return result


@dataclass
class Taxonomy:
    properties: Properties

    @staticmethod
    def from_dict(obj: Any) -> 'Taxonomy':
        assert isinstance(obj, dict)
        properties = Properties.from_dict(obj["properties"])
        return Taxonomy(properties)

    def to_dict(self) -> dict:
        result: dict = {}
        result["properties"] = to_class(Properties, self.properties)
        return result


@dataclass
class Definitions:
    taxonomy: Taxonomy

    @staticmethod
    def from_dict(obj: Any) -> 'Definitions':
        assert isinstance(obj, dict)
        taxonomy = Taxonomy.from_dict(obj["Taxonomy"])
        return Definitions(taxonomy)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Taxonomy"] = to_class(Taxonomy, self.taxonomy)
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
    format: str
    parameter_in: str
    name: str
    required: bool
    type: str

    @staticmethod
    def from_dict(obj: Any) -> 'Parameter':
        assert isinstance(obj, dict)
        description = from_str(obj["description"])
        format = from_str(obj["format"])
        parameter_in = from_str(obj["in"])
        name = from_str(obj["name"])
        required = from_bool(obj["required"])
        type = from_str(obj["type"])
        return Parameter(description, format, parameter_in, name, required, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["description"] = from_str(self.description)
        result["format"] = from_str(self.format)
        result["in"] = from_str(self.parameter_in)
        result["name"] = from_str(self.name)
        result["required"] = from_bool(self.required)
        result["type"] = from_str(self.type)
        return result


@dataclass
class Schema:
    ref: str

    @staticmethod
    def from_dict(obj: Any) -> 'Schema':
        assert isinstance(obj, dict)
        ref = from_str(obj["$ref"])
        return Schema(ref)

    def to_dict(self) -> dict:
        result: dict = {}
        result["$ref"] = from_str(self.ref)
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
class ItaTaxonomiesSearch:
    get: Get

    @staticmethod
    def from_dict(obj: Any) -> 'ItaTaxonomiesSearch':
        assert isinstance(obj, dict)
        get = Get.from_dict(obj["get"])
        return ItaTaxonomiesSearch(get)

    def to_dict(self) -> dict:
        result: dict = {}
        result["get"] = to_class(Get, self.get)
        return result


@dataclass
class Paths:
    ita_taxonomies_search: ItaTaxonomiesSearch

    @staticmethod
    def from_dict(obj: Any) -> 'Paths':
        assert isinstance(obj, dict)
        ita_taxonomies_search = ItaTaxonomiesSearch.from_dict(obj["/ita_taxonomies/search"])
        return Paths(ita_taxonomies_search)

    def to_dict(self) -> dict:
        result: dict = {}
        result["/ita_taxonomies/search"] = to_class(ItaTaxonomiesSearch, self.ita_taxonomies_search)
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
