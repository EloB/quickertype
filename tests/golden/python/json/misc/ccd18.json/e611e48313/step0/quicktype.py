from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


def to_float(x: Any) -> float:
    assert isinstance(x, (int, float))
    return x


def from_stringified_bool(x: str) -> bool:
    if x == "true":
        return True
    if x == "false":
        return False
    assert False


@dataclass
class Status:
    avg_delay: str
    closure_begin: str
    closure_end: str
    end_time: str
    max_delay: str
    min_delay: str
    reason: str
    trend: str
    type: str

    @staticmethod
    def from_dict(obj: Any) -> 'Status':
        assert isinstance(obj, dict)
        avg_delay = from_str(obj["avgDelay"])
        closure_begin = from_str(obj["closureBegin"])
        closure_end = from_str(obj["closureEnd"])
        end_time = from_str(obj["endTime"])
        max_delay = from_str(obj["maxDelay"])
        min_delay = from_str(obj["minDelay"])
        reason = from_str(obj["reason"])
        trend = from_str(obj["trend"])
        type = from_str(obj["type"])
        return Status(avg_delay, closure_begin, closure_end, end_time, max_delay, min_delay, reason, trend, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["avgDelay"] = from_str(self.avg_delay)
        result["closureBegin"] = from_str(self.closure_begin)
        result["closureEnd"] = from_str(self.closure_end)
        result["endTime"] = from_str(self.end_time)
        result["maxDelay"] = from_str(self.max_delay)
        result["minDelay"] = from_str(self.min_delay)
        result["reason"] = from_str(self.reason)
        result["trend"] = from_str(self.trend)
        result["type"] = from_str(self.type)
        return result


@dataclass
class Meta:
    credit: str
    updated: str
    url: str

    @staticmethod
    def from_dict(obj: Any) -> 'Meta':
        assert isinstance(obj, dict)
        credit = from_str(obj["credit"])
        updated = from_str(obj["updated"])
        url = from_str(obj["url"])
        return Meta(credit, updated, url)

    def to_dict(self) -> dict:
        result: dict = {}
        result["credit"] = from_str(self.credit)
        result["updated"] = from_str(self.updated)
        result["url"] = from_str(self.url)
        return result


@dataclass
class Weather:
    meta: Meta
    temp: str
    visibility: float
    weather: str
    wind: str

    @staticmethod
    def from_dict(obj: Any) -> 'Weather':
        assert isinstance(obj, dict)
        meta = Meta.from_dict(obj["meta"])
        temp = from_str(obj["temp"])
        visibility = from_float(obj["visibility"])
        weather = from_str(obj["weather"])
        wind = from_str(obj["wind"])
        return Weather(meta, temp, visibility, weather, wind)

    def to_dict(self) -> dict:
        result: dict = {}
        result["meta"] = to_class(Meta, self.meta)
        result["temp"] = from_str(self.temp)
        result["visibility"] = to_float(self.visibility)
        result["weather"] = from_str(self.weather)
        result["wind"] = from_str(self.wind)
        return result


@dataclass
class TopLevel:
    iata: str
    icao: str
    city: str
    delay: bool
    name: str
    state: str
    status: Status
    weather: Weather

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        iata = from_str(obj["IATA"])
        icao = from_str(obj["ICAO"])
        city = from_str(obj["city"])
        delay = from_stringified_bool(from_str(obj["delay"]))
        name = from_str(obj["name"])
        state = from_str(obj["state"])
        status = Status.from_dict(obj["status"])
        weather = Weather.from_dict(obj["weather"])
        return TopLevel(iata, icao, city, delay, name, state, status, weather)

    def to_dict(self) -> dict:
        result: dict = {}
        result["IATA"] = from_str(self.iata)
        result["ICAO"] = from_str(self.icao)
        result["city"] = from_str(self.city)
        result["delay"] = from_str(str(self.delay).lower())
        result["name"] = from_str(self.name)
        result["state"] = from_str(self.state)
        result["status"] = to_class(Status, self.status)
        result["weather"] = to_class(Weather, self.weather)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
