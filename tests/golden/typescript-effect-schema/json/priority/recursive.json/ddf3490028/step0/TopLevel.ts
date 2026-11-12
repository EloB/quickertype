import * as S from "effect/Schema";


export class Format extends S.Class<Format>("Format")({
    "formats": S.suspend(() => FormatsClass),
}) {}

export class Currency extends S.Class<Currency>("Currency")({
    "abbreviation": S.String,
}) {}

export class Xmlschematype extends S.Class<Xmlschematype>("Xmlschematype")({
    "localpart": S.String,
    "namespaceuri": S.String,
    "prefix": S.String,
}) {}

export class Eonandyear extends S.Class<Eonandyear>("Eonandyear")({
    "lowestsetbit": S.Int,
}) {}

export class DateClass extends S.Class<DateClass>("DateClass")({
    "day": S.Int,
    "eonandyear": Eonandyear,
    "hour": S.Int,
    "millisecond": S.Int,
    "minute": S.Int,
    "month": S.Int,
    "second": S.Int,
    "timezone": S.Int,
    "valid": S.Boolean,
    "xmlschematype": Xmlschematype,
    "year": S.Int,
}) {}

export class Specification extends S.Class<Specification>("Specification")({
    "links": S.Array(S.suspend(() => LinkElement)),
}) {}

export class Useraveragerating extends S.Class<Useraveragerating>("Useraveragerating")({
    "links": S.Array(S.suspend(() => LinkElement)),
    "numcomments": S.Int,
    "rating": S.String,
}) {}

export class Rating extends S.Class<Rating>("Rating")({
    "useraveragerating": Useraveragerating,
}) {}

export class Details extends S.Class<Details>("Details")({
    "applicationid": S.String,
    "applicationversion": S.String,
    "code": S.Int,
    "date": DateClass,
    "elapsedtime": S.Int,
    "message": S.String,
    "status": S.String,
}) {}

export class ProductProduct extends S.Class<ProductProduct>("ProductProduct")({
    "categoryid": S.Int,
    "currency": Currency,
    "eco": S.Boolean,
    "fulldescription": S.Boolean,
    "hasmetasearch": S.Boolean,
    "id": S.Int,
    "links": S.Array(S.suspend(() => LinkElement)),
    "numoffers": S.Int,
    "pricemax": S.String,
    "pricemin": S.String,
    "productname": S.String,
    "quantity": S.Int,
    "rating": Rating,
    "specification": Specification,
    "thumbnail": S.suspend(() => FormatsClass),
    "totalsellers": S.Int,
}) {}

export class ProductElement extends S.Class<ProductElement>("ProductElement")({
    "product": ProductProduct,
}) {}

export class CategoryThumbnail extends S.Class<CategoryThumbnail>("CategoryThumbnail")({
    "url": S.String,
}) {}

export class LinkLink extends S.Class<LinkLink>("LinkLink")({
    "type": S.String,
    "url": S.String,
}) {}

export class LinkElement extends S.Class<LinkElement>("LinkElement")({
    "link": LinkLink,
}) {}

export class Category extends S.Class<Category>("Category")({
    "concatenatecategoryname": S.Boolean,
    "hasoffer": S.Boolean,
    "id": S.Int,
    "isfinal": S.Boolean,
    "links": S.Array(LinkElement),
    "name": S.String,
    "parentcategoryid": S.Int,
    "thumbnail": CategoryThumbnail,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "category": Category,
    "details": Details,
    "match": S.String,
    "page": S.Int,
    "product": S.Array(ProductElement),
    "schk": S.Boolean,
    "totallooseoffers": S.Int,
    "totalpages": S.Int,
    "totalresultsavailable": S.Int,
    "totalresultsreturned": S.Int,
}) {}

export class FormatsClass extends S.Class<FormatsClass>("FormatsClass")({
    "formats": S.optional(S.Array(Format)),
    "height": S.Int,
    "url": S.String,
    "width": S.Int,
}) {}
