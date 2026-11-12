from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_none(x: Any) -> Any:
    assert x is None
    return x


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_union(fs, x):
    for f in fs:
        try:
            return f(x)
        except:
            pass
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


@dataclass
class Footnote:
    code: str | None
    text: str | None

    @staticmethod
    def from_dict(obj: Any) -> 'Footnote':
        assert isinstance(obj, dict)
        code = from_union([from_none, from_str], obj.get("code"))
        text = from_union([from_none, from_str], obj.get("text"))
        return Footnote(code, text)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.code is not None:
            result["code"] = from_union([from_none, from_str], self.code)
        if self.text is not None:
            result["text"] = from_union([from_none, from_str], self.text)
        return result


@dataclass
class Datum:
    footnotes: list[Footnote]
    period: str
    period_name: str
    value: str
    year: int

    @staticmethod
    def from_dict(obj: Any) -> 'Datum':
        assert isinstance(obj, dict)
        footnotes = from_list(Footnote.from_dict, obj["footnotes"])
        period = from_str(obj["period"])
        period_name = from_str(obj["periodName"])
        value = from_str(obj["value"])
        year = int(from_str(obj["year"]))
        return Datum(footnotes, period, period_name, value, year)

    def to_dict(self) -> dict:
        result: dict = {}
        result["footnotes"] = from_list(lambda x: to_class(Footnote, x), self.footnotes)
        result["period"] = from_str(self.period)
        result["periodName"] = from_str(self.period_name)
        result["value"] = from_str(self.value)
        result["year"] = from_str(str(self.year))
        return result


@dataclass
class Series:
    data: list[Datum]
    series_id: str

    @staticmethod
    def from_dict(obj: Any) -> 'Series':
        assert isinstance(obj, dict)
        data = from_list(Datum.from_dict, obj["data"])
        series_id = from_str(obj["seriesID"])
        return Series(data, series_id)

    def to_dict(self) -> dict:
        result: dict = {}
        result["data"] = from_list(lambda x: to_class(Datum, x), self.data)
        result["seriesID"] = from_str(self.series_id)
        return result


@dataclass
class Results:
    series: list[Series]

    @staticmethod
    def from_dict(obj: Any) -> 'Results':
        assert isinstance(obj, dict)
        series = from_list(Series.from_dict, obj["series"])
        return Results(series)

    def to_dict(self) -> dict:
        result: dict = {}
        result["series"] = from_list(lambda x: to_class(Series, x), self.series)
        return result


@dataclass
class TopLevel:
    results: Results
    message: list[Any]
    response_time: int
    status: str

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        results = Results.from_dict(obj["Results"])
        message = from_list(lambda x: x, obj["message"])
        response_time = from_int(obj["responseTime"])
        status = from_str(obj["status"])
        return TopLevel(results, message, response_time, status)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Results"] = to_class(Results, self.results)
        result["message"] = from_list(lambda x: x, self.message)
        result["responseTime"] = from_int(self.response_time)
        result["status"] = from_str(self.status)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
