from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast, Callable
from enum import Enum


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


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


def is_type(t: Type[T], x: Any) -> T:
    assert isinstance(x, t)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


@dataclass
class Downsized:
    height: int
    url: str
    width: int
    size: int | None

    @staticmethod
    def from_dict(obj: Any) -> 'Downsized':
        assert isinstance(obj, dict)
        height = int(from_str(obj["height"]))
        url = from_str(obj["url"])
        width = int(from_str(obj["width"]))
        size = from_union([from_none, lambda x: int(from_str(x))], obj.get("size"))
        return Downsized(height, url, width, size)

    def to_dict(self) -> dict:
        result: dict = {}
        result["height"] = from_str(str(self.height))
        result["url"] = from_str(self.url)
        result["width"] = from_str(str(self.width))
        if self.size is not None:
            result["size"] = from_union([lambda x: from_none((lambda x: is_type(type(None), x))(x)), lambda x: from_str((lambda x: str((lambda x: is_type(int, x))(x)))(x))], self.size)
        return result


@dataclass
class DownsizedSmall:
    height: int
    mp4: str
    mp4_size: int
    width: int

    @staticmethod
    def from_dict(obj: Any) -> 'DownsizedSmall':
        assert isinstance(obj, dict)
        height = int(from_str(obj["height"]))
        mp4 = from_str(obj["mp4"])
        mp4_size = int(from_str(obj["mp4_size"]))
        width = int(from_str(obj["width"]))
        return DownsizedSmall(height, mp4, mp4_size, width)

    def to_dict(self) -> dict:
        result: dict = {}
        result["height"] = from_str(str(self.height))
        result["mp4"] = from_str(self.mp4)
        result["mp4_size"] = from_str(str(self.mp4_size))
        result["width"] = from_str(str(self.width))
        return result


@dataclass
class FixedHeight:
    height: int
    size: int
    url: str
    webp: str
    webp_size: int
    width: int
    frames: int | None
    hash: str | None
    mp4: str | None
    mp4_size: int | None

    @staticmethod
    def from_dict(obj: Any) -> 'FixedHeight':
        assert isinstance(obj, dict)
        height = int(from_str(obj["height"]))
        size = int(from_str(obj["size"]))
        url = from_str(obj["url"])
        webp = from_str(obj["webp"])
        webp_size = int(from_str(obj["webp_size"]))
        width = int(from_str(obj["width"]))
        frames = from_union([from_none, lambda x: int(from_str(x))], obj.get("frames"))
        hash = from_union([from_none, from_str], obj.get("hash"))
        mp4 = from_union([from_none, from_str], obj.get("mp4"))
        mp4_size = from_union([from_none, lambda x: int(from_str(x))], obj.get("mp4_size"))
        return FixedHeight(height, size, url, webp, webp_size, width, frames, hash, mp4, mp4_size)

    def to_dict(self) -> dict:
        result: dict = {}
        result["height"] = from_str(str(self.height))
        result["size"] = from_str(str(self.size))
        result["url"] = from_str(self.url)
        result["webp"] = from_str(self.webp)
        result["webp_size"] = from_str(str(self.webp_size))
        result["width"] = from_str(str(self.width))
        if self.frames is not None:
            result["frames"] = from_union([lambda x: from_none((lambda x: is_type(type(None), x))(x)), lambda x: from_str((lambda x: str((lambda x: is_type(int, x))(x)))(x))], self.frames)
        if self.hash is not None:
            result["hash"] = from_union([from_none, from_str], self.hash)
        if self.mp4 is not None:
            result["mp4"] = from_union([from_none, from_str], self.mp4)
        if self.mp4_size is not None:
            result["mp4_size"] = from_union([lambda x: from_none((lambda x: is_type(type(None), x))(x)), lambda x: from_str((lambda x: str((lambda x: is_type(int, x))(x)))(x))], self.mp4_size)
        return result


@dataclass
class Looping:
    mp4: str
    mp4_size: int

    @staticmethod
    def from_dict(obj: Any) -> 'Looping':
        assert isinstance(obj, dict)
        mp4 = from_str(obj["mp4"])
        mp4_size = int(from_str(obj["mp4_size"]))
        return Looping(mp4, mp4_size)

    def to_dict(self) -> dict:
        result: dict = {}
        result["mp4"] = from_str(self.mp4)
        result["mp4_size"] = from_str(str(self.mp4_size))
        return result


@dataclass
class Images:
    downsized: Downsized
    downsized_large: Downsized
    downsized_medium: Downsized
    downsized_small: DownsizedSmall
    downsized_still: Downsized
    fixed_height: FixedHeight
    fixed_height_downsampled: FixedHeight
    fixed_height_small: FixedHeight
    fixed_height_small_still: Downsized
    fixed_height_still: Downsized
    fixed_width: FixedHeight
    fixed_width_downsampled: FixedHeight
    fixed_width_small: FixedHeight
    fixed_width_small_still: Downsized
    fixed_width_still: Downsized
    looping: Looping
    original: FixedHeight
    original_mp4: DownsizedSmall
    original_still: Downsized
    preview: DownsizedSmall
    preview_gif: Downsized
    preview_webp: Downsized
    the_480_w_still: Downsized | None

    @staticmethod
    def from_dict(obj: Any) -> 'Images':
        assert isinstance(obj, dict)
        downsized = Downsized.from_dict(obj["downsized"])
        downsized_large = Downsized.from_dict(obj["downsized_large"])
        downsized_medium = Downsized.from_dict(obj["downsized_medium"])
        downsized_small = DownsizedSmall.from_dict(obj["downsized_small"])
        downsized_still = Downsized.from_dict(obj["downsized_still"])
        fixed_height = FixedHeight.from_dict(obj["fixed_height"])
        fixed_height_downsampled = FixedHeight.from_dict(obj["fixed_height_downsampled"])
        fixed_height_small = FixedHeight.from_dict(obj["fixed_height_small"])
        fixed_height_small_still = Downsized.from_dict(obj["fixed_height_small_still"])
        fixed_height_still = Downsized.from_dict(obj["fixed_height_still"])
        fixed_width = FixedHeight.from_dict(obj["fixed_width"])
        fixed_width_downsampled = FixedHeight.from_dict(obj["fixed_width_downsampled"])
        fixed_width_small = FixedHeight.from_dict(obj["fixed_width_small"])
        fixed_width_small_still = Downsized.from_dict(obj["fixed_width_small_still"])
        fixed_width_still = Downsized.from_dict(obj["fixed_width_still"])
        looping = Looping.from_dict(obj["looping"])
        original = FixedHeight.from_dict(obj["original"])
        original_mp4 = DownsizedSmall.from_dict(obj["original_mp4"])
        original_still = Downsized.from_dict(obj["original_still"])
        preview = DownsizedSmall.from_dict(obj["preview"])
        preview_gif = Downsized.from_dict(obj["preview_gif"])
        preview_webp = Downsized.from_dict(obj["preview_webp"])
        the_480_w_still = from_union([Downsized.from_dict, from_none], obj.get("480w_still"))
        return Images(downsized, downsized_large, downsized_medium, downsized_small, downsized_still, fixed_height, fixed_height_downsampled, fixed_height_small, fixed_height_small_still, fixed_height_still, fixed_width, fixed_width_downsampled, fixed_width_small, fixed_width_small_still, fixed_width_still, looping, original, original_mp4, original_still, preview, preview_gif, preview_webp, the_480_w_still)

    def to_dict(self) -> dict:
        result: dict = {}
        result["downsized"] = to_class(Downsized, self.downsized)
        result["downsized_large"] = to_class(Downsized, self.downsized_large)
        result["downsized_medium"] = to_class(Downsized, self.downsized_medium)
        result["downsized_small"] = to_class(DownsizedSmall, self.downsized_small)
        result["downsized_still"] = to_class(Downsized, self.downsized_still)
        result["fixed_height"] = to_class(FixedHeight, self.fixed_height)
        result["fixed_height_downsampled"] = to_class(FixedHeight, self.fixed_height_downsampled)
        result["fixed_height_small"] = to_class(FixedHeight, self.fixed_height_small)
        result["fixed_height_small_still"] = to_class(Downsized, self.fixed_height_small_still)
        result["fixed_height_still"] = to_class(Downsized, self.fixed_height_still)
        result["fixed_width"] = to_class(FixedHeight, self.fixed_width)
        result["fixed_width_downsampled"] = to_class(FixedHeight, self.fixed_width_downsampled)
        result["fixed_width_small"] = to_class(FixedHeight, self.fixed_width_small)
        result["fixed_width_small_still"] = to_class(Downsized, self.fixed_width_small_still)
        result["fixed_width_still"] = to_class(Downsized, self.fixed_width_still)
        result["looping"] = to_class(Looping, self.looping)
        result["original"] = to_class(FixedHeight, self.original)
        result["original_mp4"] = to_class(DownsizedSmall, self.original_mp4)
        result["original_still"] = to_class(Downsized, self.original_still)
        result["preview"] = to_class(DownsizedSmall, self.preview)
        result["preview_gif"] = to_class(Downsized, self.preview_gif)
        result["preview_webp"] = to_class(Downsized, self.preview_webp)
        if self.the_480_w_still is not None:
            result["480w_still"] = from_union([lambda x: to_class(Downsized, x), from_none], self.the_480_w_still)
        return result


class Rating(Enum):
    G = "g"
    Y = "y"
    PG = "pg"
    PG_13 = "pg-13"


class TypeEnum(Enum):
    GIF = "gif"


class Username(Enum):
    EMPTY = ""
    PRODUCTHUNT = "producthunt"
    MEETAIKO = "meetaiko"
    CHEEZBURGER = "cheezburger"


@dataclass
class User:
    avatar_url: str
    banner_url: str
    display_name: str
    profile_url: str
    twitter: str
    username: Username

    @staticmethod
    def from_dict(obj: Any) -> 'User':
        assert isinstance(obj, dict)
        avatar_url = from_str(obj["avatar_url"])
        banner_url = from_str(obj["banner_url"])
        display_name = from_str(obj["display_name"])
        profile_url = from_str(obj["profile_url"])
        twitter = from_str(obj["twitter"])
        username = Username(obj["username"])
        return User(avatar_url, banner_url, display_name, profile_url, twitter, username)

    def to_dict(self) -> dict:
        result: dict = {}
        result["avatar_url"] = from_str(self.avatar_url)
        result["banner_url"] = from_str(self.banner_url)
        result["display_name"] = from_str(self.display_name)
        result["profile_url"] = from_str(self.profile_url)
        result["twitter"] = from_str(self.twitter)
        result["username"] = to_enum(Username, self.username)
        return result


@dataclass
class Datum:
    bitly_gif_url: str
    bitly_url: str
    content_url: str
    embed_url: str
    id: str
    images: Images
    import_datetime: str
    is_indexable: int
    rating: Rating
    slug: str
    source: str
    source_post_url: str
    source_tld: str
    trending_datetime: str
    type: TypeEnum
    url: str
    username: Username
    user: User | None

    @staticmethod
    def from_dict(obj: Any) -> 'Datum':
        assert isinstance(obj, dict)
        bitly_gif_url = from_str(obj["bitly_gif_url"])
        bitly_url = from_str(obj["bitly_url"])
        content_url = from_str(obj["content_url"])
        embed_url = from_str(obj["embed_url"])
        id = from_str(obj["id"])
        images = Images.from_dict(obj["images"])
        import_datetime = from_str(obj["import_datetime"])
        is_indexable = from_int(obj["is_indexable"])
        rating = Rating(obj["rating"])
        slug = from_str(obj["slug"])
        source = from_str(obj["source"])
        source_post_url = from_str(obj["source_post_url"])
        source_tld = from_str(obj["source_tld"])
        trending_datetime = from_str(obj["trending_datetime"])
        type = TypeEnum(obj["type"])
        url = from_str(obj["url"])
        username = Username(obj["username"])
        user = from_union([User.from_dict, from_none], obj.get("user"))
        return Datum(bitly_gif_url, bitly_url, content_url, embed_url, id, images, import_datetime, is_indexable, rating, slug, source, source_post_url, source_tld, trending_datetime, type, url, username, user)

    def to_dict(self) -> dict:
        result: dict = {}
        result["bitly_gif_url"] = from_str(self.bitly_gif_url)
        result["bitly_url"] = from_str(self.bitly_url)
        result["content_url"] = from_str(self.content_url)
        result["embed_url"] = from_str(self.embed_url)
        result["id"] = from_str(self.id)
        result["images"] = to_class(Images, self.images)
        result["import_datetime"] = from_str(self.import_datetime)
        result["is_indexable"] = from_int(self.is_indexable)
        result["rating"] = to_enum(Rating, self.rating)
        result["slug"] = from_str(self.slug)
        result["source"] = from_str(self.source)
        result["source_post_url"] = from_str(self.source_post_url)
        result["source_tld"] = from_str(self.source_tld)
        result["trending_datetime"] = from_str(self.trending_datetime)
        result["type"] = to_enum(TypeEnum, self.type)
        result["url"] = from_str(self.url)
        result["username"] = to_enum(Username, self.username)
        if self.user is not None:
            result["user"] = from_union([lambda x: to_class(User, x), from_none], self.user)
        return result


@dataclass
class Meta:
    msg: str
    response_id: str
    status: int

    @staticmethod
    def from_dict(obj: Any) -> 'Meta':
        assert isinstance(obj, dict)
        msg = from_str(obj["msg"])
        response_id = from_str(obj["response_id"])
        status = from_int(obj["status"])
        return Meta(msg, response_id, status)

    def to_dict(self) -> dict:
        result: dict = {}
        result["msg"] = from_str(self.msg)
        result["response_id"] = from_str(self.response_id)
        result["status"] = from_int(self.status)
        return result


@dataclass
class Pagination:
    count: int
    offset: int
    total_count: int

    @staticmethod
    def from_dict(obj: Any) -> 'Pagination':
        assert isinstance(obj, dict)
        count = from_int(obj["count"])
        offset = from_int(obj["offset"])
        total_count = from_int(obj["total_count"])
        return Pagination(count, offset, total_count)

    def to_dict(self) -> dict:
        result: dict = {}
        result["count"] = from_int(self.count)
        result["offset"] = from_int(self.offset)
        result["total_count"] = from_int(self.total_count)
        return result


@dataclass
class TopLevel:
    data: list[Datum]
    meta: Meta
    pagination: Pagination

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        data = from_list(Datum.from_dict, obj["data"])
        meta = Meta.from_dict(obj["meta"])
        pagination = Pagination.from_dict(obj["pagination"])
        return TopLevel(data, meta, pagination)

    def to_dict(self) -> dict:
        result: dict = {}
        result["data"] = from_list(lambda x: to_class(Datum, x), self.data)
        result["meta"] = to_class(Meta, self.meta)
        result["pagination"] = to_class(Pagination, self.pagination)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
