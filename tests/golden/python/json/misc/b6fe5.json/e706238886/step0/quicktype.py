from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class TopLevel:
    group: str
    movie: str
    movie_image: str
    theater: str

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        group = from_str(obj["group"])
        movie = from_str(obj["movie"])
        movie_image = from_str(obj["movie-image"])
        theater = from_str(obj["theater"])
        return TopLevel(group, movie, movie_image, theater)

    def to_dict(self) -> dict:
        result: dict = {}
        result["group"] = from_str(self.group)
        result["movie"] = from_str(self.movie)
        result["movie-image"] = from_str(self.movie_image)
        result["theater"] = from_str(self.theater)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
