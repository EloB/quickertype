from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Type, Callable, cast


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def from_dict(f: Callable[[Any], T], x: Any) -> dict[str, T]:
    assert isinstance(x, dict)
    return { k: f(v) for (k, v) in x.items() }


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


class FormatEnum(Enum):
    STRING = "string"


@dataclass
class Property:
    description: str
    type: FormatEnum

    @staticmethod
    def from_dict(obj: Any) -> 'Property':
        assert isinstance(obj, dict)
        description = from_str(obj["description"])
        type = FormatEnum(obj["type"])
        return Property(description, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["description"] = from_str(self.description)
        result["type"] = to_enum(FormatEnum, self.type)
        return result


@dataclass
class Article:
    properties: dict[str, Property]

    @staticmethod
    def from_dict(obj: Any) -> 'Article':
        assert isinstance(obj, dict)
        properties = from_dict(Property.from_dict, obj["properties"])
        return Article(properties)

    def to_dict(self) -> dict:
        result: dict = {}
        result["properties"] = from_dict(lambda x: to_class(Property, x), self.properties)
        return result


@dataclass
class DeMinimisProperties:
    countries: Property
    country: Property
    de_minimis_currency: Property
    de_minimis_value: Property
    notes: Property
    vat_amount: Property
    vat_currency: Property

    @staticmethod
    def from_dict(obj: Any) -> 'DeMinimisProperties':
        assert isinstance(obj, dict)
        countries = Property.from_dict(obj["countries"])
        country = Property.from_dict(obj["country"])
        de_minimis_currency = Property.from_dict(obj["de_minimis_currency"])
        de_minimis_value = Property.from_dict(obj["de_minimis_value"])
        notes = Property.from_dict(obj["notes"])
        vat_amount = Property.from_dict(obj["vat_amount"])
        vat_currency = Property.from_dict(obj["vat_currency"])
        return DeMinimisProperties(countries, country, de_minimis_currency, de_minimis_value, notes, vat_amount, vat_currency)

    def to_dict(self) -> dict:
        result: dict = {}
        result["countries"] = to_class(Property, self.countries)
        result["country"] = to_class(Property, self.country)
        result["de_minimis_currency"] = to_class(Property, self.de_minimis_currency)
        result["de_minimis_value"] = to_class(Property, self.de_minimis_value)
        result["notes"] = to_class(Property, self.notes)
        result["vat_amount"] = to_class(Property, self.vat_amount)
        result["vat_currency"] = to_class(Property, self.vat_currency)
        return result


@dataclass
class DeMinimis:
    properties: DeMinimisProperties

    @staticmethod
    def from_dict(obj: Any) -> 'DeMinimis':
        assert isinstance(obj, dict)
        properties = DeMinimisProperties.from_dict(obj["properties"])
        return DeMinimis(properties)

    def to_dict(self) -> dict:
        result: dict = {}
        result["properties"] = to_class(DeMinimisProperties, self.properties)
        return result


@dataclass
class FAQProperties:
    answer: Property
    countries: Property
    first_published_date: Property
    id: Property
    industries: Property
    last_published_date: Property
    question: Property
    topics: Property
    trade_regions: Property
    url: Property
    world_regions: Property

    @staticmethod
    def from_dict(obj: Any) -> 'FAQProperties':
        assert isinstance(obj, dict)
        answer = Property.from_dict(obj["answer"])
        countries = Property.from_dict(obj["countries"])
        first_published_date = Property.from_dict(obj["first_published_date"])
        id = Property.from_dict(obj["id"])
        industries = Property.from_dict(obj["industries"])
        last_published_date = Property.from_dict(obj["last_published_date"])
        question = Property.from_dict(obj["question"])
        topics = Property.from_dict(obj["topics"])
        trade_regions = Property.from_dict(obj["trade_regions"])
        url = Property.from_dict(obj["url"])
        world_regions = Property.from_dict(obj["world_regions"])
        return FAQProperties(answer, countries, first_published_date, id, industries, last_published_date, question, topics, trade_regions, url, world_regions)

    def to_dict(self) -> dict:
        result: dict = {}
        result["answer"] = to_class(Property, self.answer)
        result["countries"] = to_class(Property, self.countries)
        result["first_published_date"] = to_class(Property, self.first_published_date)
        result["id"] = to_class(Property, self.id)
        result["industries"] = to_class(Property, self.industries)
        result["last_published_date"] = to_class(Property, self.last_published_date)
        result["question"] = to_class(Property, self.question)
        result["topics"] = to_class(Property, self.topics)
        result["trade_regions"] = to_class(Property, self.trade_regions)
        result["url"] = to_class(Property, self.url)
        result["world_regions"] = to_class(Property, self.world_regions)
        return result


@dataclass
class FAQ:
    properties: FAQProperties

    @staticmethod
    def from_dict(obj: Any) -> 'FAQ':
        assert isinstance(obj, dict)
        properties = FAQProperties.from_dict(obj["properties"])
        return FAQ(properties)

    def to_dict(self) -> dict:
        result: dict = {}
        result["properties"] = to_class(FAQProperties, self.properties)
        return result


@dataclass
class ReportProperties:
    countries: Property
    description: Property
    expiration_date: Property
    id: Property
    industries: Property
    ita_industries: Property
    report_type: Property
    title: Property
    url: Property

    @staticmethod
    def from_dict(obj: Any) -> 'ReportProperties':
        assert isinstance(obj, dict)
        countries = Property.from_dict(obj["countries"])
        description = Property.from_dict(obj["description"])
        expiration_date = Property.from_dict(obj["expiration_date"])
        id = Property.from_dict(obj["id"])
        industries = Property.from_dict(obj["industries"])
        ita_industries = Property.from_dict(obj["ita_industries"])
        report_type = Property.from_dict(obj["report_type"])
        title = Property.from_dict(obj["title"])
        url = Property.from_dict(obj["url"])
        return ReportProperties(countries, description, expiration_date, id, industries, ita_industries, report_type, title, url)

    def to_dict(self) -> dict:
        result: dict = {}
        result["countries"] = to_class(Property, self.countries)
        result["description"] = to_class(Property, self.description)
        result["expiration_date"] = to_class(Property, self.expiration_date)
        result["id"] = to_class(Property, self.id)
        result["industries"] = to_class(Property, self.industries)
        result["ita_industries"] = to_class(Property, self.ita_industries)
        result["report_type"] = to_class(Property, self.report_type)
        result["title"] = to_class(Property, self.title)
        result["url"] = to_class(Property, self.url)
        return result


@dataclass
class Report:
    properties: ReportProperties

    @staticmethod
    def from_dict(obj: Any) -> 'Report':
        assert isinstance(obj, dict)
        properties = ReportProperties.from_dict(obj["properties"])
        return Report(properties)

    def to_dict(self) -> dict:
        result: dict = {}
        result["properties"] = to_class(ReportProperties, self.properties)
        return result


@dataclass
class TaxonomyProperties:
    annotations: Property
    datatype_properties: Property
    id: Property
    label: Property
    sub_class_of: Property
    type: Property

    @staticmethod
    def from_dict(obj: Any) -> 'TaxonomyProperties':
        assert isinstance(obj, dict)
        annotations = Property.from_dict(obj["annotations"])
        datatype_properties = Property.from_dict(obj["datatype_properties"])
        id = Property.from_dict(obj["id"])
        label = Property.from_dict(obj["label"])
        sub_class_of = Property.from_dict(obj["sub_class_of"])
        type = Property.from_dict(obj["type"])
        return TaxonomyProperties(annotations, datatype_properties, id, label, sub_class_of, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["annotations"] = to_class(Property, self.annotations)
        result["datatype_properties"] = to_class(Property, self.datatype_properties)
        result["id"] = to_class(Property, self.id)
        result["label"] = to_class(Property, self.label)
        result["sub_class_of"] = to_class(Property, self.sub_class_of)
        result["type"] = to_class(Property, self.type)
        return result


@dataclass
class Taxonomy:
    properties: TaxonomyProperties

    @staticmethod
    def from_dict(obj: Any) -> 'Taxonomy':
        assert isinstance(obj, dict)
        properties = TaxonomyProperties.from_dict(obj["properties"])
        return Taxonomy(properties)

    def to_dict(self) -> dict:
        result: dict = {}
        result["properties"] = to_class(TaxonomyProperties, self.properties)
        return result


@dataclass
class Definitions:
    article: Article
    center: Article
    de_minimis: DeMinimis
    event: Article
    faq: FAQ
    lead: Article
    list: Article
    market_intelligence: Article
    office: Article
    provider: Article
    rate: Article
    report: Report
    taxonomy: Taxonomy

    @staticmethod
    def from_dict(obj: Any) -> 'Definitions':
        assert isinstance(obj, dict)
        article = Article.from_dict(obj["Article"])
        center = Article.from_dict(obj["Center"])
        de_minimis = DeMinimis.from_dict(obj["DeMinimis"])
        event = Article.from_dict(obj["Event"])
        faq = FAQ.from_dict(obj["FAQ"])
        lead = Article.from_dict(obj["Lead"])
        list = Article.from_dict(obj["List"])
        market_intelligence = Article.from_dict(obj["MarketIntelligence"])
        office = Article.from_dict(obj["Office"])
        provider = Article.from_dict(obj["Provider"])
        rate = Article.from_dict(obj["Rate"])
        report = Report.from_dict(obj["Report"])
        taxonomy = Taxonomy.from_dict(obj["Taxonomy"])
        return Definitions(article, center, de_minimis, event, faq, lead, list, market_intelligence, office, provider, rate, report, taxonomy)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Article"] = to_class(Article, self.article)
        result["Center"] = to_class(Article, self.center)
        result["DeMinimis"] = to_class(DeMinimis, self.de_minimis)
        result["Event"] = to_class(Article, self.event)
        result["FAQ"] = to_class(FAQ, self.faq)
        result["Lead"] = to_class(Article, self.lead)
        result["List"] = to_class(Article, self.list)
        result["MarketIntelligence"] = to_class(Article, self.market_intelligence)
        result["Office"] = to_class(Article, self.office)
        result["Provider"] = to_class(Article, self.provider)
        result["Rate"] = to_class(Article, self.rate)
        result["Report"] = to_class(Report, self.report)
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


class In(Enum):
    QUERY = "query"


@dataclass
class Parameter:
    description: str
    format: FormatEnum
    parameter_in: In
    name: str
    required: bool
    type: FormatEnum

    @staticmethod
    def from_dict(obj: Any) -> 'Parameter':
        assert isinstance(obj, dict)
        description = from_str(obj["description"])
        format = FormatEnum(obj["format"])
        parameter_in = In(obj["in"])
        name = from_str(obj["name"])
        required = from_bool(obj["required"])
        type = FormatEnum(obj["type"])
        return Parameter(description, format, parameter_in, name, required, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["description"] = from_str(self.description)
        result["format"] = to_enum(FormatEnum, self.format)
        result["in"] = to_enum(In, self.parameter_in)
        result["name"] = from_str(self.name)
        result["required"] = from_bool(self.required)
        result["type"] = to_enum(FormatEnum, self.type)
        return result


@dataclass
class ItemsClass:
    ref: str

    @staticmethod
    def from_dict(obj: Any) -> 'ItemsClass':
        assert isinstance(obj, dict)
        ref = from_str(obj["$ref"])
        return ItemsClass(ref)

    def to_dict(self) -> dict:
        result: dict = {}
        result["$ref"] = from_str(self.ref)
        return result


@dataclass
class Purple200:
    description: str
    schema: ItemsClass

    @staticmethod
    def from_dict(obj: Any) -> 'Purple200':
        assert isinstance(obj, dict)
        description = from_str(obj["description"])
        schema = ItemsClass.from_dict(obj["schema"])
        return Purple200(description, schema)

    def to_dict(self) -> dict:
        result: dict = {}
        result["description"] = from_str(self.description)
        result["schema"] = to_class(ItemsClass, self.schema)
        return result


@dataclass
class PurpleResponses:
    the_200: Purple200

    @staticmethod
    def from_dict(obj: Any) -> 'PurpleResponses':
        assert isinstance(obj, dict)
        the_200 = Purple200.from_dict(obj["200"])
        return PurpleResponses(the_200)

    def to_dict(self) -> dict:
        result: dict = {}
        result["200"] = to_class(Purple200, self.the_200)
        return result


@dataclass
class BusinessServiceProvidersSearchGet:
    description: str
    parameters: list[Parameter]
    responses: PurpleResponses
    summary: str
    tags: list[str]

    @staticmethod
    def from_dict(obj: Any) -> 'BusinessServiceProvidersSearchGet':
        assert isinstance(obj, dict)
        description = from_str(obj["description"])
        parameters = from_list(Parameter.from_dict, obj["parameters"])
        responses = PurpleResponses.from_dict(obj["responses"])
        summary = from_str(obj["summary"])
        tags = from_list(from_str, obj["tags"])
        return BusinessServiceProvidersSearchGet(description, parameters, responses, summary, tags)

    def to_dict(self) -> dict:
        result: dict = {}
        result["description"] = from_str(self.description)
        result["parameters"] = from_list(lambda x: to_class(Parameter, x), self.parameters)
        result["responses"] = to_class(PurpleResponses, self.responses)
        result["summary"] = from_str(self.summary)
        result["tags"] = from_list(from_str, self.tags)
        return result


@dataclass
class BusinessServiceProvidersSearchClass:
    get: BusinessServiceProvidersSearchGet

    @staticmethod
    def from_dict(obj: Any) -> 'BusinessServiceProvidersSearchClass':
        assert isinstance(obj, dict)
        get = BusinessServiceProvidersSearchGet.from_dict(obj["get"])
        return BusinessServiceProvidersSearchClass(get)

    def to_dict(self) -> dict:
        result: dict = {}
        result["get"] = to_class(BusinessServiceProvidersSearchGet, self.get)
        return result


class SchemaType(Enum):
    ARRAY = "array"


@dataclass
class PurpleSchema:
    items: ItemsClass
    type: SchemaType

    @staticmethod
    def from_dict(obj: Any) -> 'PurpleSchema':
        assert isinstance(obj, dict)
        items = ItemsClass.from_dict(obj["items"])
        type = SchemaType(obj["type"])
        return PurpleSchema(items, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["items"] = to_class(ItemsClass, self.items)
        result["type"] = to_enum(SchemaType, self.type)
        return result


@dataclass
class Fluffy200:
    description: str
    schema: PurpleSchema

    @staticmethod
    def from_dict(obj: Any) -> 'Fluffy200':
        assert isinstance(obj, dict)
        description = from_str(obj["description"])
        schema = PurpleSchema.from_dict(obj["schema"])
        return Fluffy200(description, schema)

    def to_dict(self) -> dict:
        result: dict = {}
        result["description"] = from_str(self.description)
        result["schema"] = to_class(PurpleSchema, self.schema)
        return result


@dataclass
class FluffyResponses:
    the_200: Fluffy200

    @staticmethod
    def from_dict(obj: Any) -> 'FluffyResponses':
        assert isinstance(obj, dict)
        the_200 = Fluffy200.from_dict(obj["200"])
        return FluffyResponses(the_200)

    def to_dict(self) -> dict:
        result: dict = {}
        result["200"] = to_class(Fluffy200, self.the_200)
        return result


@dataclass
class ConsolidatedScreeningListSearchGet:
    description: str
    parameters: list[Parameter]
    responses: FluffyResponses
    summary: str
    tags: list[str]

    @staticmethod
    def from_dict(obj: Any) -> 'ConsolidatedScreeningListSearchGet':
        assert isinstance(obj, dict)
        description = from_str(obj["description"])
        parameters = from_list(Parameter.from_dict, obj["parameters"])
        responses = FluffyResponses.from_dict(obj["responses"])
        summary = from_str(obj["summary"])
        tags = from_list(from_str, obj["tags"])
        return ConsolidatedScreeningListSearchGet(description, parameters, responses, summary, tags)

    def to_dict(self) -> dict:
        result: dict = {}
        result["description"] = from_str(self.description)
        result["parameters"] = from_list(lambda x: to_class(Parameter, x), self.parameters)
        result["responses"] = to_class(FluffyResponses, self.responses)
        result["summary"] = from_str(self.summary)
        result["tags"] = from_list(from_str, self.tags)
        return result


@dataclass
class ConsolidatedScreeningListSearchClass:
    get: ConsolidatedScreeningListSearchGet

    @staticmethod
    def from_dict(obj: Any) -> 'ConsolidatedScreeningListSearchClass':
        assert isinstance(obj, dict)
        get = ConsolidatedScreeningListSearchGet.from_dict(obj["get"])
        return ConsolidatedScreeningListSearchClass(get)

    def to_dict(self) -> dict:
        result: dict = {}
        result["get"] = to_class(ConsolidatedScreeningListSearchGet, self.get)
        return result


@dataclass
class Paths:
    business_service_providers_search: BusinessServiceProvidersSearchClass
    consolidated_screening_list_search: ConsolidatedScreeningListSearchClass
    de_minimis_search: ConsolidatedScreeningListSearchClass
    ita_faqs_search: ConsolidatedScreeningListSearchClass
    ita_office_locations_search: ConsolidatedScreeningListSearchClass
    ita_taxonomies_search: BusinessServiceProvidersSearchClass
    ita_zipcode_to_post_search: BusinessServiceProvidersSearchClass
    market_intelligence_search: ConsolidatedScreeningListSearchClass
    market_research_library_search: ConsolidatedScreeningListSearchClass
    tariff_rates_search: ConsolidatedScreeningListSearchClass
    trade_articles_search: ConsolidatedScreeningListSearchClass
    trade_events_search: ConsolidatedScreeningListSearchClass
    trade_leads_search: ConsolidatedScreeningListSearchClass

    @staticmethod
    def from_dict(obj: Any) -> 'Paths':
        assert isinstance(obj, dict)
        business_service_providers_search = BusinessServiceProvidersSearchClass.from_dict(obj["/business_service_providers/search"])
        consolidated_screening_list_search = ConsolidatedScreeningListSearchClass.from_dict(obj["/consolidated_screening_list/search"])
        de_minimis_search = ConsolidatedScreeningListSearchClass.from_dict(obj["/de_minimis/search"])
        ita_faqs_search = ConsolidatedScreeningListSearchClass.from_dict(obj["/ita_faqs/search"])
        ita_office_locations_search = ConsolidatedScreeningListSearchClass.from_dict(obj["/ita_office_locations/search"])
        ita_taxonomies_search = BusinessServiceProvidersSearchClass.from_dict(obj["/ita_taxonomies/search"])
        ita_zipcode_to_post_search = BusinessServiceProvidersSearchClass.from_dict(obj["/ita_zipcode_to_post/search"])
        market_intelligence_search = ConsolidatedScreeningListSearchClass.from_dict(obj["/market_intelligence/search"])
        market_research_library_search = ConsolidatedScreeningListSearchClass.from_dict(obj["/market_research_library/search"])
        tariff_rates_search = ConsolidatedScreeningListSearchClass.from_dict(obj["/tariff_rates/search"])
        trade_articles_search = ConsolidatedScreeningListSearchClass.from_dict(obj["/trade_articles/search"])
        trade_events_search = ConsolidatedScreeningListSearchClass.from_dict(obj["/trade_events/search"])
        trade_leads_search = ConsolidatedScreeningListSearchClass.from_dict(obj["/trade_leads/search"])
        return Paths(business_service_providers_search, consolidated_screening_list_search, de_minimis_search, ita_faqs_search, ita_office_locations_search, ita_taxonomies_search, ita_zipcode_to_post_search, market_intelligence_search, market_research_library_search, tariff_rates_search, trade_articles_search, trade_events_search, trade_leads_search)

    def to_dict(self) -> dict:
        result: dict = {}
        result["/business_service_providers/search"] = to_class(BusinessServiceProvidersSearchClass, self.business_service_providers_search)
        result["/consolidated_screening_list/search"] = to_class(ConsolidatedScreeningListSearchClass, self.consolidated_screening_list_search)
        result["/de_minimis/search"] = to_class(ConsolidatedScreeningListSearchClass, self.de_minimis_search)
        result["/ita_faqs/search"] = to_class(ConsolidatedScreeningListSearchClass, self.ita_faqs_search)
        result["/ita_office_locations/search"] = to_class(ConsolidatedScreeningListSearchClass, self.ita_office_locations_search)
        result["/ita_taxonomies/search"] = to_class(BusinessServiceProvidersSearchClass, self.ita_taxonomies_search)
        result["/ita_zipcode_to_post/search"] = to_class(BusinessServiceProvidersSearchClass, self.ita_zipcode_to_post_search)
        result["/market_intelligence/search"] = to_class(ConsolidatedScreeningListSearchClass, self.market_intelligence_search)
        result["/market_research_library/search"] = to_class(ConsolidatedScreeningListSearchClass, self.market_research_library_search)
        result["/tariff_rates/search"] = to_class(ConsolidatedScreeningListSearchClass, self.tariff_rates_search)
        result["/trade_articles/search"] = to_class(ConsolidatedScreeningListSearchClass, self.trade_articles_search)
        result["/trade_events/search"] = to_class(ConsolidatedScreeningListSearchClass, self.trade_events_search)
        result["/trade_leads/search"] = to_class(ConsolidatedScreeningListSearchClass, self.trade_leads_search)
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
