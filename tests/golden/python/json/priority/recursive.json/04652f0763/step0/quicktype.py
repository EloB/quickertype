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


@dataclass
class LinkLink:
    type: str
    url: str

    @staticmethod
    def from_dict(obj: Any) -> 'LinkLink':
        assert isinstance(obj, dict)
        type = from_str(obj["type"])
        url = from_str(obj["url"])
        return LinkLink(type, url)

    def to_dict(self) -> dict:
        result: dict = {}
        result["type"] = from_str(self.type)
        result["url"] = from_str(self.url)
        return result


@dataclass
class LinkElement:
    link: LinkLink

    @staticmethod
    def from_dict(obj: Any) -> 'LinkElement':
        assert isinstance(obj, dict)
        link = LinkLink.from_dict(obj["link"])
        return LinkElement(link)

    def to_dict(self) -> dict:
        result: dict = {}
        result["link"] = to_class(LinkLink, self.link)
        return result


@dataclass
class CategoryThumbnail:
    url: str

    @staticmethod
    def from_dict(obj: Any) -> 'CategoryThumbnail':
        assert isinstance(obj, dict)
        url = from_str(obj["url"])
        return CategoryThumbnail(url)

    def to_dict(self) -> dict:
        result: dict = {}
        result["url"] = from_str(self.url)
        return result


@dataclass
class Category:
    concatenatecategoryname: bool
    hasoffer: bool
    id: int
    isfinal: bool
    links: list[LinkElement]
    name: str
    parentcategoryid: int
    thumbnail: CategoryThumbnail

    @staticmethod
    def from_dict(obj: Any) -> 'Category':
        assert isinstance(obj, dict)
        concatenatecategoryname = from_bool(obj["concatenatecategoryname"])
        hasoffer = from_bool(obj["hasoffer"])
        id = from_int(obj["id"])
        isfinal = from_bool(obj["isfinal"])
        links = from_list(LinkElement.from_dict, obj["links"])
        name = from_str(obj["name"])
        parentcategoryid = from_int(obj["parentcategoryid"])
        thumbnail = CategoryThumbnail.from_dict(obj["thumbnail"])
        return Category(concatenatecategoryname, hasoffer, id, isfinal, links, name, parentcategoryid, thumbnail)

    def to_dict(self) -> dict:
        result: dict = {}
        result["concatenatecategoryname"] = from_bool(self.concatenatecategoryname)
        result["hasoffer"] = from_bool(self.hasoffer)
        result["id"] = from_int(self.id)
        result["isfinal"] = from_bool(self.isfinal)
        result["links"] = from_list(lambda x: to_class(LinkElement, x), self.links)
        result["name"] = from_str(self.name)
        result["parentcategoryid"] = from_int(self.parentcategoryid)
        result["thumbnail"] = to_class(CategoryThumbnail, self.thumbnail)
        return result


@dataclass
class Eonandyear:
    lowestsetbit: int

    @staticmethod
    def from_dict(obj: Any) -> 'Eonandyear':
        assert isinstance(obj, dict)
        lowestsetbit = from_int(obj["lowestsetbit"])
        return Eonandyear(lowestsetbit)

    def to_dict(self) -> dict:
        result: dict = {}
        result["lowestsetbit"] = from_int(self.lowestsetbit)
        return result


@dataclass
class Xmlschematype:
    localpart: str
    namespaceuri: str
    prefix: str

    @staticmethod
    def from_dict(obj: Any) -> 'Xmlschematype':
        assert isinstance(obj, dict)
        localpart = from_str(obj["localpart"])
        namespaceuri = from_str(obj["namespaceuri"])
        prefix = from_str(obj["prefix"])
        return Xmlschematype(localpart, namespaceuri, prefix)

    def to_dict(self) -> dict:
        result: dict = {}
        result["localpart"] = from_str(self.localpart)
        result["namespaceuri"] = from_str(self.namespaceuri)
        result["prefix"] = from_str(self.prefix)
        return result


@dataclass
class Date:
    day: int
    eonandyear: Eonandyear
    hour: int
    millisecond: int
    minute: int
    month: int
    second: int
    timezone: int
    valid: bool
    xmlschematype: Xmlschematype
    year: int

    @staticmethod
    def from_dict(obj: Any) -> 'Date':
        assert isinstance(obj, dict)
        day = from_int(obj["day"])
        eonandyear = Eonandyear.from_dict(obj["eonandyear"])
        hour = from_int(obj["hour"])
        millisecond = from_int(obj["millisecond"])
        minute = from_int(obj["minute"])
        month = from_int(obj["month"])
        second = from_int(obj["second"])
        timezone = from_int(obj["timezone"])
        valid = from_bool(obj["valid"])
        xmlschematype = Xmlschematype.from_dict(obj["xmlschematype"])
        year = from_int(obj["year"])
        return Date(day, eonandyear, hour, millisecond, minute, month, second, timezone, valid, xmlschematype, year)

    def to_dict(self) -> dict:
        result: dict = {}
        result["day"] = from_int(self.day)
        result["eonandyear"] = to_class(Eonandyear, self.eonandyear)
        result["hour"] = from_int(self.hour)
        result["millisecond"] = from_int(self.millisecond)
        result["minute"] = from_int(self.minute)
        result["month"] = from_int(self.month)
        result["second"] = from_int(self.second)
        result["timezone"] = from_int(self.timezone)
        result["valid"] = from_bool(self.valid)
        result["xmlschematype"] = to_class(Xmlschematype, self.xmlschematype)
        result["year"] = from_int(self.year)
        return result


@dataclass
class Details:
    applicationid: str
    applicationversion: str
    code: int
    date: Date
    elapsedtime: int
    message: str
    status: str

    @staticmethod
    def from_dict(obj: Any) -> 'Details':
        assert isinstance(obj, dict)
        applicationid = from_str(obj["applicationid"])
        applicationversion = from_str(obj["applicationversion"])
        code = from_int(obj["code"])
        date = Date.from_dict(obj["date"])
        elapsedtime = from_int(obj["elapsedtime"])
        message = from_str(obj["message"])
        status = from_str(obj["status"])
        return Details(applicationid, applicationversion, code, date, elapsedtime, message, status)

    def to_dict(self) -> dict:
        result: dict = {}
        result["applicationid"] = from_str(self.applicationid)
        result["applicationversion"] = from_str(self.applicationversion)
        result["code"] = from_int(self.code)
        result["date"] = to_class(Date, self.date)
        result["elapsedtime"] = from_int(self.elapsedtime)
        result["message"] = from_str(self.message)
        result["status"] = from_str(self.status)
        return result


@dataclass
class Currency:
    abbreviation: str

    @staticmethod
    def from_dict(obj: Any) -> 'Currency':
        assert isinstance(obj, dict)
        abbreviation = from_str(obj["abbreviation"])
        return Currency(abbreviation)

    def to_dict(self) -> dict:
        result: dict = {}
        result["abbreviation"] = from_str(self.abbreviation)
        return result


@dataclass
class Useraveragerating:
    links: list[LinkElement]
    numcomments: int
    rating: str

    @staticmethod
    def from_dict(obj: Any) -> 'Useraveragerating':
        assert isinstance(obj, dict)
        links = from_list(LinkElement.from_dict, obj["links"])
        numcomments = from_int(obj["numcomments"])
        rating = from_str(obj["rating"])
        return Useraveragerating(links, numcomments, rating)

    def to_dict(self) -> dict:
        result: dict = {}
        result["links"] = from_list(lambda x: to_class(LinkElement, x), self.links)
        result["numcomments"] = from_int(self.numcomments)
        result["rating"] = from_str(self.rating)
        return result


@dataclass
class Rating:
    useraveragerating: Useraveragerating

    @staticmethod
    def from_dict(obj: Any) -> 'Rating':
        assert isinstance(obj, dict)
        useraveragerating = Useraveragerating.from_dict(obj["useraveragerating"])
        return Rating(useraveragerating)

    def to_dict(self) -> dict:
        result: dict = {}
        result["useraveragerating"] = to_class(Useraveragerating, self.useraveragerating)
        return result


@dataclass
class Specification:
    links: list[LinkElement]

    @staticmethod
    def from_dict(obj: Any) -> 'Specification':
        assert isinstance(obj, dict)
        links = from_list(LinkElement.from_dict, obj["links"])
        return Specification(links)

    def to_dict(self) -> dict:
        result: dict = {}
        result["links"] = from_list(lambda x: to_class(LinkElement, x), self.links)
        return result


@dataclass
class Format:
    formats: 'FormatsClass'

    @staticmethod
    def from_dict(obj: Any) -> 'Format':
        assert isinstance(obj, dict)
        formats = FormatsClass.from_dict(obj["formats"])
        return Format(formats)

    def to_dict(self) -> dict:
        result: dict = {}
        result["formats"] = to_class(FormatsClass, self.formats)
        return result


@dataclass
class FormatsClass:
    height: int
    url: str
    width: int
    formats: list[Format] | None

    @staticmethod
    def from_dict(obj: Any) -> 'FormatsClass':
        assert isinstance(obj, dict)
        height = from_int(obj["height"])
        url = from_str(obj["url"])
        width = from_int(obj["width"])
        formats = from_union([lambda x: from_list(Format.from_dict, x), from_none], obj.get("formats"))
        return FormatsClass(height, url, width, formats)

    def to_dict(self) -> dict:
        result: dict = {}
        result["height"] = from_int(self.height)
        result["url"] = from_str(self.url)
        result["width"] = from_int(self.width)
        if self.formats is not None:
            result["formats"] = from_union([lambda x: from_list(lambda x: to_class(Format, x), x), from_none], self.formats)
        return result


@dataclass
class ProductProduct:
    categoryid: int
    currency: Currency
    eco: bool
    fulldescription: bool
    hasmetasearch: bool
    id: int
    links: list[LinkElement]
    numoffers: int
    pricemax: str
    pricemin: str
    productname: str
    quantity: int
    rating: Rating
    specification: Specification
    thumbnail: FormatsClass
    totalsellers: int

    @staticmethod
    def from_dict(obj: Any) -> 'ProductProduct':
        assert isinstance(obj, dict)
        categoryid = from_int(obj["categoryid"])
        currency = Currency.from_dict(obj["currency"])
        eco = from_bool(obj["eco"])
        fulldescription = from_bool(obj["fulldescription"])
        hasmetasearch = from_bool(obj["hasmetasearch"])
        id = from_int(obj["id"])
        links = from_list(LinkElement.from_dict, obj["links"])
        numoffers = from_int(obj["numoffers"])
        pricemax = from_str(obj["pricemax"])
        pricemin = from_str(obj["pricemin"])
        productname = from_str(obj["productname"])
        quantity = from_int(obj["quantity"])
        rating = Rating.from_dict(obj["rating"])
        specification = Specification.from_dict(obj["specification"])
        thumbnail = FormatsClass.from_dict(obj["thumbnail"])
        totalsellers = from_int(obj["totalsellers"])
        return ProductProduct(categoryid, currency, eco, fulldescription, hasmetasearch, id, links, numoffers, pricemax, pricemin, productname, quantity, rating, specification, thumbnail, totalsellers)

    def to_dict(self) -> dict:
        result: dict = {}
        result["categoryid"] = from_int(self.categoryid)
        result["currency"] = to_class(Currency, self.currency)
        result["eco"] = from_bool(self.eco)
        result["fulldescription"] = from_bool(self.fulldescription)
        result["hasmetasearch"] = from_bool(self.hasmetasearch)
        result["id"] = from_int(self.id)
        result["links"] = from_list(lambda x: to_class(LinkElement, x), self.links)
        result["numoffers"] = from_int(self.numoffers)
        result["pricemax"] = from_str(self.pricemax)
        result["pricemin"] = from_str(self.pricemin)
        result["productname"] = from_str(self.productname)
        result["quantity"] = from_int(self.quantity)
        result["rating"] = to_class(Rating, self.rating)
        result["specification"] = to_class(Specification, self.specification)
        result["thumbnail"] = to_class(FormatsClass, self.thumbnail)
        result["totalsellers"] = from_int(self.totalsellers)
        return result


@dataclass
class ProductElement:
    product: ProductProduct

    @staticmethod
    def from_dict(obj: Any) -> 'ProductElement':
        assert isinstance(obj, dict)
        product = ProductProduct.from_dict(obj["product"])
        return ProductElement(product)

    def to_dict(self) -> dict:
        result: dict = {}
        result["product"] = to_class(ProductProduct, self.product)
        return result


@dataclass
class TopLevel:
    category: Category
    details: Details
    match: str
    page: int
    product: list[ProductElement]
    schk: bool
    totallooseoffers: int
    totalpages: int
    totalresultsavailable: int
    totalresultsreturned: int

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        category = Category.from_dict(obj["category"])
        details = Details.from_dict(obj["details"])
        match = from_str(obj["match"])
        page = from_int(obj["page"])
        product = from_list(ProductElement.from_dict, obj["product"])
        schk = from_bool(obj["schk"])
        totallooseoffers = from_int(obj["totallooseoffers"])
        totalpages = from_int(obj["totalpages"])
        totalresultsavailable = from_int(obj["totalresultsavailable"])
        totalresultsreturned = from_int(obj["totalresultsreturned"])
        return TopLevel(category, details, match, page, product, schk, totallooseoffers, totalpages, totalresultsavailable, totalresultsreturned)

    def to_dict(self) -> dict:
        result: dict = {}
        result["category"] = to_class(Category, self.category)
        result["details"] = to_class(Details, self.details)
        result["match"] = from_str(self.match)
        result["page"] = from_int(self.page)
        result["product"] = from_list(lambda x: to_class(ProductElement, x), self.product)
        result["schk"] = from_bool(self.schk)
        result["totallooseoffers"] = from_int(self.totallooseoffers)
        result["totalpages"] = from_int(self.totalpages)
        result["totalresultsavailable"] = from_int(self.totalresultsavailable)
        result["totalresultsreturned"] = from_int(self.totalresultsreturned)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
