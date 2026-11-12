import datetime
from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast
import dateutil.parser


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_stringified_bool(x: str) -> bool:
    if x == "true":
        return True
    if x == "false":
        return False
    assert False


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_datetime(x: Any) -> datetime.datetime:
    return dateutil.parser.parse(x)


@dataclass
class Astronomy:
    sunrise: str
    sunset: str

    @staticmethod
    def from_dict(obj: Any) -> 'Astronomy':
        assert isinstance(obj, dict)
        sunrise = from_str(obj["sunrise"])
        sunset = from_str(obj["sunset"])
        return Astronomy(sunrise, sunset)

    def to_dict(self) -> dict:
        result: dict = {}
        result["sunrise"] = from_str(self.sunrise)
        result["sunset"] = from_str(self.sunset)
        return result


@dataclass
class Atmosphere:
    humidity: int
    pressure: str
    rising: int
    visibility: str

    @staticmethod
    def from_dict(obj: Any) -> 'Atmosphere':
        assert isinstance(obj, dict)
        humidity = int(from_str(obj["humidity"]))
        pressure = from_str(obj["pressure"])
        rising = int(from_str(obj["rising"]))
        visibility = from_str(obj["visibility"])
        return Atmosphere(humidity, pressure, rising, visibility)

    def to_dict(self) -> dict:
        result: dict = {}
        result["humidity"] = from_str(str(self.humidity))
        result["pressure"] = from_str(self.pressure)
        result["rising"] = from_str(str(self.rising))
        result["visibility"] = from_str(self.visibility)
        return result


@dataclass
class Image:
    height: int
    link: str
    title: str
    url: str
    width: int

    @staticmethod
    def from_dict(obj: Any) -> 'Image':
        assert isinstance(obj, dict)
        height = int(from_str(obj["height"]))
        link = from_str(obj["link"])
        title = from_str(obj["title"])
        url = from_str(obj["url"])
        width = int(from_str(obj["width"]))
        return Image(height, link, title, url, width)

    def to_dict(self) -> dict:
        result: dict = {}
        result["height"] = from_str(str(self.height))
        result["link"] = from_str(self.link)
        result["title"] = from_str(self.title)
        result["url"] = from_str(self.url)
        result["width"] = from_str(str(self.width))
        return result


@dataclass
class Condition:
    code: int
    date: str
    temp: int
    text: str

    @staticmethod
    def from_dict(obj: Any) -> 'Condition':
        assert isinstance(obj, dict)
        code = int(from_str(obj["code"]))
        date = from_str(obj["date"])
        temp = int(from_str(obj["temp"]))
        text = from_str(obj["text"])
        return Condition(code, date, temp, text)

    def to_dict(self) -> dict:
        result: dict = {}
        result["code"] = from_str(str(self.code))
        result["date"] = from_str(self.date)
        result["temp"] = from_str(str(self.temp))
        result["text"] = from_str(self.text)
        return result


@dataclass
class Forecast:
    code: int
    date: str
    day: str
    high: int
    low: int
    text: str

    @staticmethod
    def from_dict(obj: Any) -> 'Forecast':
        assert isinstance(obj, dict)
        code = int(from_str(obj["code"]))
        date = from_str(obj["date"])
        day = from_str(obj["day"])
        high = int(from_str(obj["high"]))
        low = int(from_str(obj["low"]))
        text = from_str(obj["text"])
        return Forecast(code, date, day, high, low, text)

    def to_dict(self) -> dict:
        result: dict = {}
        result["code"] = from_str(str(self.code))
        result["date"] = from_str(self.date)
        result["day"] = from_str(self.day)
        result["high"] = from_str(str(self.high))
        result["low"] = from_str(str(self.low))
        result["text"] = from_str(self.text)
        return result


@dataclass
class GUID:
    is_perma_link: bool

    @staticmethod
    def from_dict(obj: Any) -> 'GUID':
        assert isinstance(obj, dict)
        is_perma_link = from_stringified_bool(from_str(obj["isPermaLink"]))
        return GUID(is_perma_link)

    def to_dict(self) -> dict:
        result: dict = {}
        result["isPermaLink"] = from_str(str(self.is_perma_link).lower())
        return result


@dataclass
class Item:
    condition: Condition
    description: str
    forecast: list[Forecast]
    guid: GUID
    lat: str
    link: str
    long: str
    pub_date: str
    title: str

    @staticmethod
    def from_dict(obj: Any) -> 'Item':
        assert isinstance(obj, dict)
        condition = Condition.from_dict(obj["condition"])
        description = from_str(obj["description"])
        forecast = from_list(Forecast.from_dict, obj["forecast"])
        guid = GUID.from_dict(obj["guid"])
        lat = from_str(obj["lat"])
        link = from_str(obj["link"])
        long = from_str(obj["long"])
        pub_date = from_str(obj["pubDate"])
        title = from_str(obj["title"])
        return Item(condition, description, forecast, guid, lat, link, long, pub_date, title)

    def to_dict(self) -> dict:
        result: dict = {}
        result["condition"] = to_class(Condition, self.condition)
        result["description"] = from_str(self.description)
        result["forecast"] = from_list(lambda x: to_class(Forecast, x), self.forecast)
        result["guid"] = to_class(GUID, self.guid)
        result["lat"] = from_str(self.lat)
        result["link"] = from_str(self.link)
        result["long"] = from_str(self.long)
        result["pubDate"] = from_str(self.pub_date)
        result["title"] = from_str(self.title)
        return result


@dataclass
class Location:
    city: str
    country: str
    region: str

    @staticmethod
    def from_dict(obj: Any) -> 'Location':
        assert isinstance(obj, dict)
        city = from_str(obj["city"])
        country = from_str(obj["country"])
        region = from_str(obj["region"])
        return Location(city, country, region)

    def to_dict(self) -> dict:
        result: dict = {}
        result["city"] = from_str(self.city)
        result["country"] = from_str(self.country)
        result["region"] = from_str(self.region)
        return result


@dataclass
class Units:
    distance: str
    pressure: str
    speed: str
    temperature: str

    @staticmethod
    def from_dict(obj: Any) -> 'Units':
        assert isinstance(obj, dict)
        distance = from_str(obj["distance"])
        pressure = from_str(obj["pressure"])
        speed = from_str(obj["speed"])
        temperature = from_str(obj["temperature"])
        return Units(distance, pressure, speed, temperature)

    def to_dict(self) -> dict:
        result: dict = {}
        result["distance"] = from_str(self.distance)
        result["pressure"] = from_str(self.pressure)
        result["speed"] = from_str(self.speed)
        result["temperature"] = from_str(self.temperature)
        return result


@dataclass
class Wind:
    chill: int
    direction: int
    speed: int

    @staticmethod
    def from_dict(obj: Any) -> 'Wind':
        assert isinstance(obj, dict)
        chill = int(from_str(obj["chill"]))
        direction = int(from_str(obj["direction"]))
        speed = int(from_str(obj["speed"]))
        return Wind(chill, direction, speed)

    def to_dict(self) -> dict:
        result: dict = {}
        result["chill"] = from_str(str(self.chill))
        result["direction"] = from_str(str(self.direction))
        result["speed"] = from_str(str(self.speed))
        return result


@dataclass
class Channel:
    astronomy: Astronomy
    atmosphere: Atmosphere
    description: str
    image: Image
    item: Item
    language: str
    last_build_date: str
    link: str
    location: Location
    title: str
    ttl: int
    units: Units
    wind: Wind

    @staticmethod
    def from_dict(obj: Any) -> 'Channel':
        assert isinstance(obj, dict)
        astronomy = Astronomy.from_dict(obj["astronomy"])
        atmosphere = Atmosphere.from_dict(obj["atmosphere"])
        description = from_str(obj["description"])
        image = Image.from_dict(obj["image"])
        item = Item.from_dict(obj["item"])
        language = from_str(obj["language"])
        last_build_date = from_str(obj["lastBuildDate"])
        link = from_str(obj["link"])
        location = Location.from_dict(obj["location"])
        title = from_str(obj["title"])
        ttl = int(from_str(obj["ttl"]))
        units = Units.from_dict(obj["units"])
        wind = Wind.from_dict(obj["wind"])
        return Channel(astronomy, atmosphere, description, image, item, language, last_build_date, link, location, title, ttl, units, wind)

    def to_dict(self) -> dict:
        result: dict = {}
        result["astronomy"] = to_class(Astronomy, self.astronomy)
        result["atmosphere"] = to_class(Atmosphere, self.atmosphere)
        result["description"] = from_str(self.description)
        result["image"] = to_class(Image, self.image)
        result["item"] = to_class(Item, self.item)
        result["language"] = from_str(self.language)
        result["lastBuildDate"] = from_str(self.last_build_date)
        result["link"] = from_str(self.link)
        result["location"] = to_class(Location, self.location)
        result["title"] = from_str(self.title)
        result["ttl"] = from_str(str(self.ttl))
        result["units"] = to_class(Units, self.units)
        result["wind"] = to_class(Wind, self.wind)
        return result


@dataclass
class Results:
    channel: Channel

    @staticmethod
    def from_dict(obj: Any) -> 'Results':
        assert isinstance(obj, dict)
        channel = Channel.from_dict(obj["channel"])
        return Results(channel)

    def to_dict(self) -> dict:
        result: dict = {}
        result["channel"] = to_class(Channel, self.channel)
        return result


@dataclass
class Query:
    count: int
    created: datetime.datetime
    lang: str
    results: Results

    @staticmethod
    def from_dict(obj: Any) -> 'Query':
        assert isinstance(obj, dict)
        count = from_int(obj["count"])
        created = from_datetime(obj["created"])
        lang = from_str(obj["lang"])
        results = Results.from_dict(obj["results"])
        return Query(count, created, lang, results)

    def to_dict(self) -> dict:
        result: dict = {}
        result["count"] = from_int(self.count)
        result["created"] = self.created.isoformat()
        result["lang"] = from_str(self.lang)
        result["results"] = to_class(Results, self.results)
        return result


@dataclass
class TopLevel:
    query: Query

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        query = Query.from_dict(obj["query"])
        return TopLevel(query)

    def to_dict(self) -> dict:
        result: dict = {}
        result["query"] = to_class(Query, self.query)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
