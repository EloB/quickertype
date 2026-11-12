// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final Query query;

    TopLevel({
        required this.query,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        query: Query.fromJson(json["query"]),
    );

    Map<String, dynamic> toJson() => {
        "query": query.toJson(),
    };
}

class Query {
    final int count;
    final DateTime created;
    final String lang;
    final Results results;

    Query({
        required this.count,
        required this.created,
        required this.lang,
        required this.results,
    });

    factory Query.fromJson(Map<String, dynamic> json) => Query(
        count: json["count"],
        created: DateTime.parse(json["created"]),
        lang: json["lang"],
        results: Results.fromJson(json["results"]),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "created": created.toIso8601String(),
        "lang": lang,
        "results": results.toJson(),
    };
}

class Results {
    final Channel channel;

    Results({
        required this.channel,
    });

    factory Results.fromJson(Map<String, dynamic> json) => Results(
        channel: Channel.fromJson(json["channel"]),
    );

    Map<String, dynamic> toJson() => {
        "channel": channel.toJson(),
    };
}

class Channel {
    final Astronomy astronomy;
    final Atmosphere atmosphere;
    final String description;
    final Image image;
    final Item item;
    final String language;
    final String lastBuildDate;
    final String link;
    final Location location;
    final String title;
    final String ttl;
    final Units units;
    final Wind wind;

    Channel({
        required this.astronomy,
        required this.atmosphere,
        required this.description,
        required this.image,
        required this.item,
        required this.language,
        required this.lastBuildDate,
        required this.link,
        required this.location,
        required this.title,
        required this.ttl,
        required this.units,
        required this.wind,
    });

    factory Channel.fromJson(Map<String, dynamic> json) => Channel(
        astronomy: Astronomy.fromJson(json["astronomy"]),
        atmosphere: Atmosphere.fromJson(json["atmosphere"]),
        description: json["description"],
        image: Image.fromJson(json["image"]),
        item: Item.fromJson(json["item"]),
        language: json["language"],
        lastBuildDate: json["lastBuildDate"],
        link: json["link"],
        location: Location.fromJson(json["location"]),
        title: json["title"],
        ttl: json["ttl"],
        units: Units.fromJson(json["units"]),
        wind: Wind.fromJson(json["wind"]),
    );

    Map<String, dynamic> toJson() => {
        "astronomy": astronomy.toJson(),
        "atmosphere": atmosphere.toJson(),
        "description": description,
        "image": image.toJson(),
        "item": item.toJson(),
        "language": language,
        "lastBuildDate": lastBuildDate,
        "link": link,
        "location": location.toJson(),
        "title": title,
        "ttl": ttl,
        "units": units.toJson(),
        "wind": wind.toJson(),
    };
}

class Astronomy {
    final String sunrise;
    final String sunset;

    Astronomy({
        required this.sunrise,
        required this.sunset,
    });

    factory Astronomy.fromJson(Map<String, dynamic> json) => Astronomy(
        sunrise: json["sunrise"],
        sunset: json["sunset"],
    );

    Map<String, dynamic> toJson() => {
        "sunrise": sunrise,
        "sunset": sunset,
    };
}

class Atmosphere {
    final String humidity;
    final String pressure;
    final String rising;
    final String visibility;

    Atmosphere({
        required this.humidity,
        required this.pressure,
        required this.rising,
        required this.visibility,
    });

    factory Atmosphere.fromJson(Map<String, dynamic> json) => Atmosphere(
        humidity: json["humidity"],
        pressure: json["pressure"],
        rising: json["rising"],
        visibility: json["visibility"],
    );

    Map<String, dynamic> toJson() => {
        "humidity": humidity,
        "pressure": pressure,
        "rising": rising,
        "visibility": visibility,
    };
}

class Image {
    final String height;
    final String link;
    final String title;
    final String url;
    final String width;

    Image({
        required this.height,
        required this.link,
        required this.title,
        required this.url,
        required this.width,
    });

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        height: json["height"],
        link: json["link"],
        title: json["title"],
        url: json["url"],
        width: json["width"],
    );

    Map<String, dynamic> toJson() => {
        "height": height,
        "link": link,
        "title": title,
        "url": url,
        "width": width,
    };
}

class Item {
    final Condition condition;
    final String description;
    final List<Forecast> forecast;
    final Guid guid;
    final String lat;
    final String link;
    final String long;
    final String pubDate;
    final String title;

    Item({
        required this.condition,
        required this.description,
        required this.forecast,
        required this.guid,
        required this.lat,
        required this.link,
        required this.long,
        required this.pubDate,
        required this.title,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        condition: Condition.fromJson(json["condition"]),
        description: json["description"],
        forecast: List<Forecast>.from(json["forecast"].map((x) => Forecast.fromJson(x))),
        guid: Guid.fromJson(json["guid"]),
        lat: json["lat"],
        link: json["link"],
        long: json["long"],
        pubDate: json["pubDate"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "condition": condition.toJson(),
        "description": description,
        "forecast": List<dynamic>.from(forecast.map((x) => x.toJson())),
        "guid": guid.toJson(),
        "lat": lat,
        "link": link,
        "long": long,
        "pubDate": pubDate,
        "title": title,
    };
}

class Condition {
    final String code;
    final String date;
    final String temp;
    final Text text;

    Condition({
        required this.code,
        required this.date,
        required this.temp,
        required this.text,
    });

    factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        code: json["code"],
        date: json["date"],
        temp: json["temp"],
        text: textValues.map[json["text"]]!,
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "date": date,
        "temp": temp,
        "text": textValues.reverse[text],
    };
}

enum Text {
    MOSTLY_CLOUDY,
    RAIN,
    PARTLY_CLOUDY
}

final textValues = EnumValues({
    "Mostly Cloudy": Text.MOSTLY_CLOUDY,
    "Rain": Text.RAIN,
    "Partly Cloudy": Text.PARTLY_CLOUDY
});

class Forecast {
    final String code;
    final String date;
    final String day;
    final String high;
    final String low;
    final Text text;

    Forecast({
        required this.code,
        required this.date,
        required this.day,
        required this.high,
        required this.low,
        required this.text,
    });

    factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
        code: json["code"],
        date: json["date"],
        day: json["day"],
        high: json["high"],
        low: json["low"],
        text: textValues.map[json["text"]]!,
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "date": date,
        "day": day,
        "high": high,
        "low": low,
        "text": textValues.reverse[text],
    };
}

class Guid {
    final String isPermaLink;

    Guid({
        required this.isPermaLink,
    });

    factory Guid.fromJson(Map<String, dynamic> json) => Guid(
        isPermaLink: json["isPermaLink"],
    );

    Map<String, dynamic> toJson() => {
        "isPermaLink": isPermaLink,
    };
}

class Location {
    final String city;
    final String country;
    final String region;

    Location({
        required this.city,
        required this.country,
        required this.region,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        city: json["city"],
        country: json["country"],
        region: json["region"],
    );

    Map<String, dynamic> toJson() => {
        "city": city,
        "country": country,
        "region": region,
    };
}

class Units {
    final String distance;
    final String pressure;
    final String speed;
    final String temperature;

    Units({
        required this.distance,
        required this.pressure,
        required this.speed,
        required this.temperature,
    });

    factory Units.fromJson(Map<String, dynamic> json) => Units(
        distance: json["distance"],
        pressure: json["pressure"],
        speed: json["speed"],
        temperature: json["temperature"],
    );

    Map<String, dynamic> toJson() => {
        "distance": distance,
        "pressure": pressure,
        "speed": speed,
        "temperature": temperature,
    };
}

class Wind {
    final String chill;
    final String direction;
    final String speed;

    Wind({
        required this.chill,
        required this.direction,
        required this.speed,
    });

    factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        chill: json["chill"],
        direction: json["direction"],
        speed: json["speed"],
    );

    Map<String, dynamic> toJson() => {
        "chill": chill,
        "direction": direction,
        "speed": speed,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
