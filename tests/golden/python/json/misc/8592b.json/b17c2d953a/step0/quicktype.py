from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast
from enum import Enum


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


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


def to_float(x: Any) -> float:
    assert isinstance(x, (int, float))
    return x


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


@dataclass
class MediaEmbed:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'MediaEmbed':
        assert isinstance(obj, dict)
        return MediaEmbed()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


class PostHint(Enum):
    LINK = "link"


@dataclass
class Source:
    height: int
    url: str
    width: int

    @staticmethod
    def from_dict(obj: Any) -> 'Source':
        assert isinstance(obj, dict)
        height = from_int(obj["height"])
        url = from_str(obj["url"])
        width = from_int(obj["width"])
        return Source(height, url, width)

    def to_dict(self) -> dict:
        result: dict = {}
        result["height"] = from_int(self.height)
        result["url"] = from_str(self.url)
        result["width"] = from_int(self.width)
        return result


@dataclass
class Image:
    id: str
    resolutions: list[Source]
    source: Source
    variants: MediaEmbed

    @staticmethod
    def from_dict(obj: Any) -> 'Image':
        assert isinstance(obj, dict)
        id = from_str(obj["id"])
        resolutions = from_list(Source.from_dict, obj["resolutions"])
        source = Source.from_dict(obj["source"])
        variants = MediaEmbed.from_dict(obj["variants"])
        return Image(id, resolutions, source, variants)

    def to_dict(self) -> dict:
        result: dict = {}
        result["id"] = from_str(self.id)
        result["resolutions"] = from_list(lambda x: to_class(Source, x), self.resolutions)
        result["source"] = to_class(Source, self.source)
        result["variants"] = to_class(MediaEmbed, self.variants)
        return result


@dataclass
class Preview:
    enabled: bool
    images: list[Image]

    @staticmethod
    def from_dict(obj: Any) -> 'Preview':
        assert isinstance(obj, dict)
        enabled = from_bool(obj["enabled"])
        images = from_list(Image.from_dict, obj["images"])
        return Preview(enabled, images)

    def to_dict(self) -> dict:
        result: dict = {}
        result["enabled"] = from_bool(self.enabled)
        result["images"] = from_list(lambda x: to_class(Image, x), self.images)
        return result


class Subreddit(Enum):
    SCIENCE = "science"


class SubredditID(Enum):
    T5_MOUW = "t5_mouw"


class SubredditNamePrefixed(Enum):
    R_SCIENCE = "r/science"


class SubredditType(Enum):
    PUBLIC = "public"


class SuggestedSort(Enum):
    CONFIDENCE = "confidence"
    QA = "qa"


@dataclass
class ChildData:
    archived: bool
    author: str
    brand_safe: bool
    can_gild: bool
    can_mod_post: bool
    clicked: bool
    contest_mode: bool
    created: float
    created_utc: float
    domain: str
    downs: int
    edited: bool
    gilded: int
    hidden: bool
    hide_score: bool
    id: str
    is_self: bool
    is_video: bool
    link_flair_css_class: str
    link_flair_text: str
    locked: bool
    media_embed: MediaEmbed
    mod_reports: list[Any]
    name: str
    num_comments: int
    over_18: bool
    permalink: str
    quarantine: bool
    saved: bool
    score: int
    secure_media_embed: MediaEmbed
    selftext: str
    spoiler: bool
    stickied: bool
    subreddit: Subreddit
    subreddit_id: SubredditID
    subreddit_name_prefixed: SubredditNamePrefixed
    subreddit_type: SubredditType
    suggested_sort: SuggestedSort
    thumbnail: str
    title: str
    ups: int
    url: str
    user_reports: list[Any]
    visited: bool
    approved_at_utc: None
    approved_by: None
    author_flair_css_class: str | None
    author_flair_text: str | None
    banned_at_utc: None
    banned_by: None
    distinguished: None
    likes: None
    media: None
    num_reports: None
    post_hint: PostHint | None
    preview: Preview | None
    removal_reason: None
    report_reasons: None
    secure_media: None
    selftext_html: str | None
    thumbnail_height: int | None
    thumbnail_width: int | None
    view_count: None

    @staticmethod
    def from_dict(obj: Any) -> 'ChildData':
        assert isinstance(obj, dict)
        archived = from_bool(obj["archived"])
        author = from_str(obj["author"])
        brand_safe = from_bool(obj["brand_safe"])
        can_gild = from_bool(obj["can_gild"])
        can_mod_post = from_bool(obj["can_mod_post"])
        clicked = from_bool(obj["clicked"])
        contest_mode = from_bool(obj["contest_mode"])
        created = from_float(obj["created"])
        created_utc = from_float(obj["created_utc"])
        domain = from_str(obj["domain"])
        downs = from_int(obj["downs"])
        edited = from_bool(obj["edited"])
        gilded = from_int(obj["gilded"])
        hidden = from_bool(obj["hidden"])
        hide_score = from_bool(obj["hide_score"])
        id = from_str(obj["id"])
        is_self = from_bool(obj["is_self"])
        is_video = from_bool(obj["is_video"])
        link_flair_css_class = from_str(obj["link_flair_css_class"])
        link_flair_text = from_str(obj["link_flair_text"])
        locked = from_bool(obj["locked"])
        media_embed = MediaEmbed.from_dict(obj["media_embed"])
        mod_reports = from_list(lambda x: x, obj["mod_reports"])
        name = from_str(obj["name"])
        num_comments = from_int(obj["num_comments"])
        over_18 = from_bool(obj["over_18"])
        permalink = from_str(obj["permalink"])
        quarantine = from_bool(obj["quarantine"])
        saved = from_bool(obj["saved"])
        score = from_int(obj["score"])
        secure_media_embed = MediaEmbed.from_dict(obj["secure_media_embed"])
        selftext = from_str(obj["selftext"])
        spoiler = from_bool(obj["spoiler"])
        stickied = from_bool(obj["stickied"])
        subreddit = Subreddit(obj["subreddit"])
        subreddit_id = SubredditID(obj["subreddit_id"])
        subreddit_name_prefixed = SubredditNamePrefixed(obj["subreddit_name_prefixed"])
        subreddit_type = SubredditType(obj["subreddit_type"])
        suggested_sort = SuggestedSort(obj["suggested_sort"])
        thumbnail = from_str(obj["thumbnail"])
        title = from_str(obj["title"])
        ups = from_int(obj["ups"])
        url = from_str(obj["url"])
        user_reports = from_list(lambda x: x, obj["user_reports"])
        visited = from_bool(obj["visited"])
        approved_at_utc = from_none(obj["approved_at_utc"])
        approved_by = from_none(obj["approved_by"])
        author_flair_css_class = from_union([from_none, from_str], obj["author_flair_css_class"])
        author_flair_text = from_union([from_none, from_str], obj["author_flair_text"])
        banned_at_utc = from_none(obj["banned_at_utc"])
        banned_by = from_none(obj["banned_by"])
        distinguished = from_none(obj["distinguished"])
        likes = from_none(obj["likes"])
        media = from_none(obj["media"])
        num_reports = from_none(obj["num_reports"])
        post_hint = from_union([PostHint, from_none], obj.get("post_hint"))
        preview = from_union([Preview.from_dict, from_none], obj.get("preview"))
        removal_reason = from_none(obj["removal_reason"])
        report_reasons = from_none(obj["report_reasons"])
        secure_media = from_none(obj["secure_media"])
        selftext_html = from_union([from_none, from_str], obj["selftext_html"])
        thumbnail_height = from_union([from_int, from_none], obj["thumbnail_height"])
        thumbnail_width = from_union([from_int, from_none], obj["thumbnail_width"])
        view_count = from_none(obj["view_count"])
        return ChildData(archived, author, brand_safe, can_gild, can_mod_post, clicked, contest_mode, created, created_utc, domain, downs, edited, gilded, hidden, hide_score, id, is_self, is_video, link_flair_css_class, link_flair_text, locked, media_embed, mod_reports, name, num_comments, over_18, permalink, quarantine, saved, score, secure_media_embed, selftext, spoiler, stickied, subreddit, subreddit_id, subreddit_name_prefixed, subreddit_type, suggested_sort, thumbnail, title, ups, url, user_reports, visited, approved_at_utc, approved_by, author_flair_css_class, author_flair_text, banned_at_utc, banned_by, distinguished, likes, media, num_reports, post_hint, preview, removal_reason, report_reasons, secure_media, selftext_html, thumbnail_height, thumbnail_width, view_count)

    def to_dict(self) -> dict:
        result: dict = {}
        result["archived"] = from_bool(self.archived)
        result["author"] = from_str(self.author)
        result["brand_safe"] = from_bool(self.brand_safe)
        result["can_gild"] = from_bool(self.can_gild)
        result["can_mod_post"] = from_bool(self.can_mod_post)
        result["clicked"] = from_bool(self.clicked)
        result["contest_mode"] = from_bool(self.contest_mode)
        result["created"] = to_float(self.created)
        result["created_utc"] = to_float(self.created_utc)
        result["domain"] = from_str(self.domain)
        result["downs"] = from_int(self.downs)
        result["edited"] = from_bool(self.edited)
        result["gilded"] = from_int(self.gilded)
        result["hidden"] = from_bool(self.hidden)
        result["hide_score"] = from_bool(self.hide_score)
        result["id"] = from_str(self.id)
        result["is_self"] = from_bool(self.is_self)
        result["is_video"] = from_bool(self.is_video)
        result["link_flair_css_class"] = from_str(self.link_flair_css_class)
        result["link_flair_text"] = from_str(self.link_flair_text)
        result["locked"] = from_bool(self.locked)
        result["media_embed"] = to_class(MediaEmbed, self.media_embed)
        result["mod_reports"] = from_list(lambda x: x, self.mod_reports)
        result["name"] = from_str(self.name)
        result["num_comments"] = from_int(self.num_comments)
        result["over_18"] = from_bool(self.over_18)
        result["permalink"] = from_str(self.permalink)
        result["quarantine"] = from_bool(self.quarantine)
        result["saved"] = from_bool(self.saved)
        result["score"] = from_int(self.score)
        result["secure_media_embed"] = to_class(MediaEmbed, self.secure_media_embed)
        result["selftext"] = from_str(self.selftext)
        result["spoiler"] = from_bool(self.spoiler)
        result["stickied"] = from_bool(self.stickied)
        result["subreddit"] = to_enum(Subreddit, self.subreddit)
        result["subreddit_id"] = to_enum(SubredditID, self.subreddit_id)
        result["subreddit_name_prefixed"] = to_enum(SubredditNamePrefixed, self.subreddit_name_prefixed)
        result["subreddit_type"] = to_enum(SubredditType, self.subreddit_type)
        result["suggested_sort"] = to_enum(SuggestedSort, self.suggested_sort)
        result["thumbnail"] = from_str(self.thumbnail)
        result["title"] = from_str(self.title)
        result["ups"] = from_int(self.ups)
        result["url"] = from_str(self.url)
        result["user_reports"] = from_list(lambda x: x, self.user_reports)
        result["visited"] = from_bool(self.visited)
        result["approved_at_utc"] = from_none(self.approved_at_utc)
        result["approved_by"] = from_none(self.approved_by)
        result["author_flair_css_class"] = from_union([from_none, from_str], self.author_flair_css_class)
        result["author_flair_text"] = from_union([from_none, from_str], self.author_flair_text)
        result["banned_at_utc"] = from_none(self.banned_at_utc)
        result["banned_by"] = from_none(self.banned_by)
        result["distinguished"] = from_none(self.distinguished)
        result["likes"] = from_none(self.likes)
        result["media"] = from_none(self.media)
        result["num_reports"] = from_none(self.num_reports)
        if self.post_hint is not None:
            result["post_hint"] = from_union([lambda x: to_enum(PostHint, x), from_none], self.post_hint)
        if self.preview is not None:
            result["preview"] = from_union([lambda x: to_class(Preview, x), from_none], self.preview)
        result["removal_reason"] = from_none(self.removal_reason)
        result["report_reasons"] = from_none(self.report_reasons)
        result["secure_media"] = from_none(self.secure_media)
        result["selftext_html"] = from_union([from_none, from_str], self.selftext_html)
        result["thumbnail_height"] = from_union([from_int, from_none], self.thumbnail_height)
        result["thumbnail_width"] = from_union([from_int, from_none], self.thumbnail_width)
        result["view_count"] = from_none(self.view_count)
        return result


class Kind(Enum):
    T3 = "t3"


@dataclass
class Child:
    data: ChildData
    kind: Kind

    @staticmethod
    def from_dict(obj: Any) -> 'Child':
        assert isinstance(obj, dict)
        data = ChildData.from_dict(obj["data"])
        kind = Kind(obj["kind"])
        return Child(data, kind)

    def to_dict(self) -> dict:
        result: dict = {}
        result["data"] = to_class(ChildData, self.data)
        result["kind"] = to_enum(Kind, self.kind)
        return result


@dataclass
class TopLevelData:
    after: str
    children: list[Child]
    modhash: str
    before: None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevelData':
        assert isinstance(obj, dict)
        after = from_str(obj["after"])
        children = from_list(Child.from_dict, obj["children"])
        modhash = from_str(obj["modhash"])
        before = from_none(obj["before"])
        return TopLevelData(after, children, modhash, before)

    def to_dict(self) -> dict:
        result: dict = {}
        result["after"] = from_str(self.after)
        result["children"] = from_list(lambda x: to_class(Child, x), self.children)
        result["modhash"] = from_str(self.modhash)
        result["before"] = from_none(self.before)
        return result


@dataclass
class TopLevel:
    data: TopLevelData
    kind: str

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        data = TopLevelData.from_dict(obj["data"])
        kind = from_str(obj["kind"])
        return TopLevel(data, kind)

    def to_dict(self) -> dict:
        result: dict = {}
        result["data"] = to_class(TopLevelData, self.data)
        result["kind"] = from_str(self.kind)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
