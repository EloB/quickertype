import datetime
import re
from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast
from enum import Enum
import dateutil.parser


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def from_date(x: Any) -> datetime.date:
    assert isinstance(x, str) and re.match(r"^\d{4}-\d{2}-\d{2}$", x)
    return dateutil.parser.parse(x).date()


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


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class Collection:
    id: int
    movies: list[int]
    name: str
    slug: str

    @staticmethod
    def from_dict(obj: Any) -> 'Collection':
        assert isinstance(obj, dict)
        id = from_int(obj["id"])
        movies = from_list(from_int, obj["movies"])
        name = from_str(obj["name"])
        slug = from_str(obj["slug"])
        return Collection(id, movies, name, slug)

    def to_dict(self) -> dict:
        result: dict = {}
        result["id"] = from_int(self.id)
        result["movies"] = from_list(from_int, self.movies)
        result["name"] = from_str(self.name)
        result["slug"] = from_str(self.slug)
        return result


class DetailLanguage(Enum):
    EN = "en"
    TH = "th"


@dataclass
class Detail:
    cast: str
    director: str
    id: int
    language: DetailLanguage
    storyline: str
    tagline: str
    title: str

    @staticmethod
    def from_dict(obj: Any) -> 'Detail':
        assert isinstance(obj, dict)
        cast = from_str(obj["cast"])
        director = from_str(obj["director"])
        id = from_int(obj["id"])
        language = DetailLanguage(obj["language"])
        storyline = from_str(obj["storyline"])
        tagline = from_str(obj["tagline"])
        title = from_str(obj["title"])
        return Detail(cast, director, id, language, storyline, tagline, title)

    def to_dict(self) -> dict:
        result: dict = {}
        result["cast"] = from_str(self.cast)
        result["director"] = from_str(self.director)
        result["id"] = from_int(self.id)
        result["language"] = to_enum(DetailLanguage, self.language)
        result["storyline"] = from_str(self.storyline)
        result["tagline"] = from_str(self.tagline)
        result["title"] = from_str(self.title)
        return result


@dataclass
class FavMovie:
    follow: bool
    star: bool
    watched: bool

    @staticmethod
    def from_dict(obj: Any) -> 'FavMovie':
        assert isinstance(obj, dict)
        follow = from_bool(obj["follow"])
        star = from_bool(obj["star"])
        watched = from_bool(obj["watched"])
        return FavMovie(follow, star, watched)

    def to_dict(self) -> dict:
        result: dict = {}
        result["follow"] = from_bool(self.follow)
        result["star"] = from_bool(self.star)
        result["watched"] = from_bool(self.watched)
        return result


class TypeEnum(Enum):
    POSTER = "Poster"
    BACKDROP = "Backdrop"


@dataclass
class Image:
    favs: int
    id: int
    thumbnail: str
    type: TypeEnum
    url: str

    @staticmethod
    def from_dict(obj: Any) -> 'Image':
        assert isinstance(obj, dict)
        favs = from_int(obj["favs"])
        id = from_int(obj["id"])
        thumbnail = from_str(obj["thumbnail"])
        type = TypeEnum(obj["type"])
        url = from_str(obj["url"])
        return Image(favs, id, thumbnail, type, url)

    def to_dict(self) -> dict:
        result: dict = {}
        result["favs"] = from_int(self.favs)
        result["id"] = from_int(self.id)
        result["thumbnail"] = from_str(self.thumbnail)
        result["type"] = to_enum(TypeEnum, self.type)
        result["url"] = from_str(self.url)
        return result


class ResultLanguage(Enum):
    EN = "en"
    EMPTY = "-"


@dataclass
class Video:
    kind: str
    language: ResultLanguage
    source: str
    url: str

    @staticmethod
    def from_dict(obj: Any) -> 'Video':
        assert isinstance(obj, dict)
        kind = from_str(obj["kind"])
        language = ResultLanguage(obj["language"])
        source = from_str(obj["source"])
        url = from_str(obj["url"])
        return Video(kind, language, source, url)

    def to_dict(self) -> dict:
        result: dict = {}
        result["kind"] = from_str(self.kind)
        result["language"] = to_enum(ResultLanguage, self.language)
        result["source"] = from_str(self.source)
        result["url"] = from_str(self.url)
        return result


@dataclass
class VoteScore:
    avg: int
    score: int
    total: int

    @staticmethod
    def from_dict(obj: Any) -> 'VoteScore':
        assert isinstance(obj, dict)
        avg = from_int(obj["avg"])
        score = from_int(obj["score"])
        total = from_int(obj["total"])
        return VoteScore(avg, score, total)

    def to_dict(self) -> dict:
        result: dict = {}
        result["avg"] = from_int(self.avg)
        result["score"] = from_int(self.score)
        result["total"] = from_int(self.total)
        return result


@dataclass
class Result:
    active_screens: int
    collections: list[Collection]
    details: list[Detail]
    duration: int
    fav_movie: FavMovie
    id: int
    images: list[Image]
    language: ResultLanguage
    release_date: datetime.date
    stars: int
    title: str
    videos: list[Video]
    vote_score: VoteScore
    watches: int
    tags: list[Any] | None

    @staticmethod
    def from_dict(obj: Any) -> 'Result':
        assert isinstance(obj, dict)
        active_screens = from_int(obj["active_screens"])
        collections = from_list(Collection.from_dict, obj["collections"])
        details = from_list(Detail.from_dict, obj["details"])
        duration = from_int(obj["duration"])
        fav_movie = FavMovie.from_dict(obj["fav_movie"])
        id = from_int(obj["id"])
        images = from_list(Image.from_dict, obj["images"])
        language = ResultLanguage(obj["language"])
        release_date = from_date(obj["release_date"])
        stars = from_int(obj["stars"])
        title = from_str(obj["title"])
        videos = from_list(Video.from_dict, obj["videos"])
        vote_score = VoteScore.from_dict(obj["vote_score"])
        watches = from_int(obj["watches"])
        tags = from_union([lambda x: from_list(lambda x: x, x), from_none], obj["tags"])
        return Result(active_screens, collections, details, duration, fav_movie, id, images, language, release_date, stars, title, videos, vote_score, watches, tags)

    def to_dict(self) -> dict:
        result: dict = {}
        result["active_screens"] = from_int(self.active_screens)
        result["collections"] = from_list(lambda x: to_class(Collection, x), self.collections)
        result["details"] = from_list(lambda x: to_class(Detail, x), self.details)
        result["duration"] = from_int(self.duration)
        result["fav_movie"] = to_class(FavMovie, self.fav_movie)
        result["id"] = from_int(self.id)
        result["images"] = from_list(lambda x: to_class(Image, x), self.images)
        result["language"] = to_enum(ResultLanguage, self.language)
        result["release_date"] = self.release_date.isoformat()
        result["stars"] = from_int(self.stars)
        result["title"] = from_str(self.title)
        result["videos"] = from_list(lambda x: to_class(Video, x), self.videos)
        result["vote_score"] = to_class(VoteScore, self.vote_score)
        result["watches"] = from_int(self.watches)
        result["tags"] = from_union([lambda x: from_list(lambda x: x, x), from_none], self.tags)
        return result


@dataclass
class TopLevel:
    count: int
    next: str
    results: list[Result]
    previous: None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        count = from_int(obj["count"])
        next = from_str(obj["next"])
        results = from_list(Result.from_dict, obj["results"])
        previous = from_none(obj["previous"])
        return TopLevel(count, next, results, previous)

    def to_dict(self) -> dict:
        result: dict = {}
        result["count"] = from_int(self.count)
        result["next"] = from_str(self.next)
        result["results"] = from_list(lambda x: to_class(Result, x), self.results)
        result["previous"] = from_none(self.previous)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
