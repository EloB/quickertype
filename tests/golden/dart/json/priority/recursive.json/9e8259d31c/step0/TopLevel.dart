// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final Category category;
    final Details details;
    final String match;
    final int page;
    final List<ProductElement> product;
    final bool schk;
    final int totallooseoffers;
    final int totalpages;
    final int totalresultsavailable;
    final int totalresultsreturned;

    TopLevel({
        required this.category,
        required this.details,
        required this.match,
        required this.page,
        required this.product,
        required this.schk,
        required this.totallooseoffers,
        required this.totalpages,
        required this.totalresultsavailable,
        required this.totalresultsreturned,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        category: Category.fromJson(json["category"]),
        details: Details.fromJson(json["details"]),
        match: json["match"],
        page: json["page"],
        product: List<ProductElement>.from(json["product"].map((x) => ProductElement.fromJson(x))),
        schk: json["schk"],
        totallooseoffers: json["totallooseoffers"],
        totalpages: json["totalpages"],
        totalresultsavailable: json["totalresultsavailable"],
        totalresultsreturned: json["totalresultsreturned"],
    );

    Map<String, dynamic> toJson() => {
        "category": category.toJson(),
        "details": details.toJson(),
        "match": match,
        "page": page,
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
        "schk": schk,
        "totallooseoffers": totallooseoffers,
        "totalpages": totalpages,
        "totalresultsavailable": totalresultsavailable,
        "totalresultsreturned": totalresultsreturned,
    };
}

class Category {
    final bool concatenatecategoryname;
    final bool hasoffer;
    final int id;
    final bool isfinal;
    final List<LinkElement> links;
    final String name;
    final int parentcategoryid;
    final CategoryThumbnail thumbnail;

    Category({
        required this.concatenatecategoryname,
        required this.hasoffer,
        required this.id,
        required this.isfinal,
        required this.links,
        required this.name,
        required this.parentcategoryid,
        required this.thumbnail,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        concatenatecategoryname: json["concatenatecategoryname"],
        hasoffer: json["hasoffer"],
        id: json["id"],
        isfinal: json["isfinal"],
        links: List<LinkElement>.from(json["links"].map((x) => LinkElement.fromJson(x))),
        name: json["name"],
        parentcategoryid: json["parentcategoryid"],
        thumbnail: CategoryThumbnail.fromJson(json["thumbnail"]),
    );

    Map<String, dynamic> toJson() => {
        "concatenatecategoryname": concatenatecategoryname,
        "hasoffer": hasoffer,
        "id": id,
        "isfinal": isfinal,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "name": name,
        "parentcategoryid": parentcategoryid,
        "thumbnail": thumbnail.toJson(),
    };
}

class LinkElement {
    final LinkLink link;

    LinkElement({
        required this.link,
    });

    factory LinkElement.fromJson(Map<String, dynamic> json) => LinkElement(
        link: LinkLink.fromJson(json["link"]),
    );

    Map<String, dynamic> toJson() => {
        "link": link.toJson(),
    };
}

class LinkLink {
    final String type;
    final String url;

    LinkLink({
        required this.type,
        required this.url,
    });

    factory LinkLink.fromJson(Map<String, dynamic> json) => LinkLink(
        type: json["type"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "url": url,
    };
}

class CategoryThumbnail {
    final String url;

    CategoryThumbnail({
        required this.url,
    });

    factory CategoryThumbnail.fromJson(Map<String, dynamic> json) => CategoryThumbnail(
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
    };
}

class Details {
    final String applicationid;
    final String applicationversion;
    final int code;
    final Date date;
    final int elapsedtime;
    final String message;
    final String status;

    Details({
        required this.applicationid,
        required this.applicationversion,
        required this.code,
        required this.date,
        required this.elapsedtime,
        required this.message,
        required this.status,
    });

    factory Details.fromJson(Map<String, dynamic> json) => Details(
        applicationid: json["applicationid"],
        applicationversion: json["applicationversion"],
        code: json["code"],
        date: Date.fromJson(json["date"]),
        elapsedtime: json["elapsedtime"],
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "applicationid": applicationid,
        "applicationversion": applicationversion,
        "code": code,
        "date": date.toJson(),
        "elapsedtime": elapsedtime,
        "message": message,
        "status": status,
    };
}

class Date {
    final int day;
    final Eonandyear eonandyear;
    final int hour;
    final int millisecond;
    final int minute;
    final int month;
    final int second;
    final int timezone;
    final bool valid;
    final Xmlschematype xmlschematype;
    final int year;

    Date({
        required this.day,
        required this.eonandyear,
        required this.hour,
        required this.millisecond,
        required this.minute,
        required this.month,
        required this.second,
        required this.timezone,
        required this.valid,
        required this.xmlschematype,
        required this.year,
    });

    factory Date.fromJson(Map<String, dynamic> json) => Date(
        day: json["day"],
        eonandyear: Eonandyear.fromJson(json["eonandyear"]),
        hour: json["hour"],
        millisecond: json["millisecond"],
        minute: json["minute"],
        month: json["month"],
        second: json["second"],
        timezone: json["timezone"],
        valid: json["valid"],
        xmlschematype: Xmlschematype.fromJson(json["xmlschematype"]),
        year: json["year"],
    );

    Map<String, dynamic> toJson() => {
        "day": day,
        "eonandyear": eonandyear.toJson(),
        "hour": hour,
        "millisecond": millisecond,
        "minute": minute,
        "month": month,
        "second": second,
        "timezone": timezone,
        "valid": valid,
        "xmlschematype": xmlschematype.toJson(),
        "year": year,
    };
}

class Eonandyear {
    final int lowestsetbit;

    Eonandyear({
        required this.lowestsetbit,
    });

    factory Eonandyear.fromJson(Map<String, dynamic> json) => Eonandyear(
        lowestsetbit: json["lowestsetbit"],
    );

    Map<String, dynamic> toJson() => {
        "lowestsetbit": lowestsetbit,
    };
}

class Xmlschematype {
    final String localpart;
    final String namespaceuri;
    final String prefix;

    Xmlschematype({
        required this.localpart,
        required this.namespaceuri,
        required this.prefix,
    });

    factory Xmlschematype.fromJson(Map<String, dynamic> json) => Xmlschematype(
        localpart: json["localpart"],
        namespaceuri: json["namespaceuri"],
        prefix: json["prefix"],
    );

    Map<String, dynamic> toJson() => {
        "localpart": localpart,
        "namespaceuri": namespaceuri,
        "prefix": prefix,
    };
}

class ProductElement {
    final ProductProduct product;

    ProductElement({
        required this.product,
    });

    factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
        product: ProductProduct.fromJson(json["product"]),
    );

    Map<String, dynamic> toJson() => {
        "product": product.toJson(),
    };
}

class ProductProduct {
    final int categoryid;
    final Currency currency;
    final bool eco;
    final bool fulldescription;
    final bool hasmetasearch;
    final int id;
    final List<LinkElement> links;
    final int numoffers;
    final String pricemax;
    final String pricemin;
    final String productname;
    final int quantity;
    final Rating rating;
    final Specification specification;
    final FormatsClass thumbnail;
    final int totalsellers;

    ProductProduct({
        required this.categoryid,
        required this.currency,
        required this.eco,
        required this.fulldescription,
        required this.hasmetasearch,
        required this.id,
        required this.links,
        required this.numoffers,
        required this.pricemax,
        required this.pricemin,
        required this.productname,
        required this.quantity,
        required this.rating,
        required this.specification,
        required this.thumbnail,
        required this.totalsellers,
    });

    factory ProductProduct.fromJson(Map<String, dynamic> json) => ProductProduct(
        categoryid: json["categoryid"],
        currency: Currency.fromJson(json["currency"]),
        eco: json["eco"],
        fulldescription: json["fulldescription"],
        hasmetasearch: json["hasmetasearch"],
        id: json["id"],
        links: List<LinkElement>.from(json["links"].map((x) => LinkElement.fromJson(x))),
        numoffers: json["numoffers"],
        pricemax: json["pricemax"],
        pricemin: json["pricemin"],
        productname: json["productname"],
        quantity: json["quantity"],
        rating: Rating.fromJson(json["rating"]),
        specification: Specification.fromJson(json["specification"]),
        thumbnail: FormatsClass.fromJson(json["thumbnail"]),
        totalsellers: json["totalsellers"],
    );

    Map<String, dynamic> toJson() => {
        "categoryid": categoryid,
        "currency": currency.toJson(),
        "eco": eco,
        "fulldescription": fulldescription,
        "hasmetasearch": hasmetasearch,
        "id": id,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "numoffers": numoffers,
        "pricemax": pricemax,
        "pricemin": pricemin,
        "productname": productname,
        "quantity": quantity,
        "rating": rating.toJson(),
        "specification": specification.toJson(),
        "thumbnail": thumbnail.toJson(),
        "totalsellers": totalsellers,
    };
}

class Currency {
    final String abbreviation;

    Currency({
        required this.abbreviation,
    });

    factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        abbreviation: json["abbreviation"],
    );

    Map<String, dynamic> toJson() => {
        "abbreviation": abbreviation,
    };
}

class Rating {
    final Useraveragerating useraveragerating;

    Rating({
        required this.useraveragerating,
    });

    factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        useraveragerating: Useraveragerating.fromJson(json["useraveragerating"]),
    );

    Map<String, dynamic> toJson() => {
        "useraveragerating": useraveragerating.toJson(),
    };
}

class Useraveragerating {
    final List<LinkElement> links;
    final int numcomments;
    final String rating;

    Useraveragerating({
        required this.links,
        required this.numcomments,
        required this.rating,
    });

    factory Useraveragerating.fromJson(Map<String, dynamic> json) => Useraveragerating(
        links: List<LinkElement>.from(json["links"].map((x) => LinkElement.fromJson(x))),
        numcomments: json["numcomments"],
        rating: json["rating"],
    );

    Map<String, dynamic> toJson() => {
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "numcomments": numcomments,
        "rating": rating,
    };
}

class Specification {
    final List<LinkElement> links;

    Specification({
        required this.links,
    });

    factory Specification.fromJson(Map<String, dynamic> json) => Specification(
        links: List<LinkElement>.from(json["links"].map((x) => LinkElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
    };
}

class Format {
    final FormatsClass formats;

    Format({
        required this.formats,
    });

    factory Format.fromJson(Map<String, dynamic> json) => Format(
        formats: FormatsClass.fromJson(json["formats"]),
    );

    Map<String, dynamic> toJson() => {
        "formats": formats.toJson(),
    };
}

class FormatsClass {
    final List<Format>? formats;
    final int height;
    final String url;
    final int width;

    FormatsClass({
        this.formats,
        required this.height,
        required this.url,
        required this.width,
    });

    factory FormatsClass.fromJson(Map<String, dynamic> json) => FormatsClass(
        formats: json["formats"] == null ? null : List<Format>.from(json["formats"]!.map((x) => Format.fromJson(x))),
        height: json["height"],
        url: json["url"],
        width: json["width"],
    );

    Map<String, dynamic> toJson() => {
        "formats": formats == null ? null : List<dynamic>.from(formats!.map((x) => x.toJson())),
        "height": height,
        "url": url,
        "width": width,
    };
}
