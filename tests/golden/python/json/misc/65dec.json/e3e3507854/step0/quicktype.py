import datetime
import re
from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Type, Callable, cast
import dateutil.parser


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def from_date(x: Any) -> datetime.date:
    assert isinstance(x, str) and re.match(r"^\d{4}-\d{2}-\d{2}$", x)
    return dateutil.parser.parse(x).date()


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


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


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


def is_type(t: Type[T], x: Any) -> T:
    assert isinstance(x, t)
    return x


class ColorIdentity(Enum):
    W = "W"
    R = "R"
    B = "B"
    G = "G"
    U = "U"


class Watermark(Enum):
    WHITE = "White"
    RED = "Red"
    BLACK = "Black"
    GREEN = "Green"
    BLUE = "Blue"


class Layout(Enum):
    NORMAL = "normal"


class LegalityEnum(Enum):
    LEGAL = "Legal"
    BANNED = "Banned"
    RESTRICTED = "Restricted"


@dataclass
class LegalityElement:
    format: str
    legality: LegalityEnum

    @staticmethod
    def from_dict(obj: Any) -> 'LegalityElement':
        assert isinstance(obj, dict)
        format = from_str(obj["format"])
        legality = LegalityEnum(obj["legality"])
        return LegalityElement(format, legality)

    def to_dict(self) -> dict:
        result: dict = {}
        result["format"] = from_str(self.format)
        result["legality"] = to_enum(LegalityEnum, self.legality)
        return result


class Rarity(Enum):
    UNCOMMON = "Uncommon"
    RARE = "Rare"
    COMMON = "Common"
    BASIC_LAND = "Basic Land"


@dataclass
class Ruling:
    date: datetime.date
    text: str

    @staticmethod
    def from_dict(obj: Any) -> 'Ruling':
        assert isinstance(obj, dict)
        date = from_date(obj["date"])
        text = from_str(obj["text"])
        return Ruling(date, text)

    def to_dict(self) -> dict:
        result: dict = {}
        result["date"] = self.date.isoformat()
        result["text"] = from_str(self.text)
        return result


class TypeElement(Enum):
    CREATURE = "Creature"
    ARTIFACT = "Artifact"
    INSTANT = "Instant"
    LAND = "Land"
    ENCHANTMENT = "Enchantment"
    SORCERY = "Sorcery"


@dataclass
class Card:
    artist: str
    cmc: int
    id: str
    image_name: str
    layout: Layout
    legalities: list[LegalityElement]
    multiverseid: int
    name: str
    original_text: str
    original_type: str
    printings: list[str]
    rarity: Rarity
    type: str
    types: list[TypeElement]
    color_identity: list[ColorIdentity] | None
    colors: list[Watermark] | None
    flavor: str | None
    mana_cost: str | None
    mci_number: int | None
    power: int | None
    reserved: bool | None
    rulings: list[Ruling] | None
    subtypes: list[str] | None
    supertypes: list[str] | None
    text: str | None
    toughness: int | None
    variations: list[int] | None
    watermark: Watermark | None

    @staticmethod
    def from_dict(obj: Any) -> 'Card':
        assert isinstance(obj, dict)
        artist = from_str(obj["artist"])
        cmc = from_int(obj["cmc"])
        id = from_str(obj["id"])
        image_name = from_str(obj["imageName"])
        layout = Layout(obj["layout"])
        legalities = from_list(LegalityElement.from_dict, obj["legalities"])
        multiverseid = from_int(obj["multiverseid"])
        name = from_str(obj["name"])
        original_text = from_str(obj["originalText"])
        original_type = from_str(obj["originalType"])
        printings = from_list(from_str, obj["printings"])
        rarity = Rarity(obj["rarity"])
        type = from_str(obj["type"])
        types = from_list(TypeElement, obj["types"])
        color_identity = from_union([lambda x: from_list(ColorIdentity, x), from_none], obj.get("colorIdentity"))
        colors = from_union([lambda x: from_list(Watermark, x), from_none], obj.get("colors"))
        flavor = from_union([from_none, from_str], obj.get("flavor"))
        mana_cost = from_union([from_none, from_str], obj.get("manaCost"))
        mci_number = from_union([from_none, lambda x: int(from_str(x))], obj.get("mciNumber"))
        power = from_union([from_none, lambda x: int(from_str(x))], obj.get("power"))
        reserved = from_union([from_bool, from_none], obj.get("reserved"))
        rulings = from_union([lambda x: from_list(Ruling.from_dict, x), from_none], obj.get("rulings"))
        subtypes = from_union([lambda x: from_list(from_str, x), from_none], obj.get("subtypes"))
        supertypes = from_union([lambda x: from_list(from_str, x), from_none], obj.get("supertypes"))
        text = from_union([from_none, from_str], obj.get("text"))
        toughness = from_union([from_none, lambda x: int(from_str(x))], obj.get("toughness"))
        variations = from_union([lambda x: from_list(from_int, x), from_none], obj.get("variations"))
        watermark = from_union([Watermark, from_none], obj.get("watermark"))
        return Card(artist, cmc, id, image_name, layout, legalities, multiverseid, name, original_text, original_type, printings, rarity, type, types, color_identity, colors, flavor, mana_cost, mci_number, power, reserved, rulings, subtypes, supertypes, text, toughness, variations, watermark)

    def to_dict(self) -> dict:
        result: dict = {}
        result["artist"] = from_str(self.artist)
        result["cmc"] = from_int(self.cmc)
        result["id"] = from_str(self.id)
        result["imageName"] = from_str(self.image_name)
        result["layout"] = to_enum(Layout, self.layout)
        result["legalities"] = from_list(lambda x: to_class(LegalityElement, x), self.legalities)
        result["multiverseid"] = from_int(self.multiverseid)
        result["name"] = from_str(self.name)
        result["originalText"] = from_str(self.original_text)
        result["originalType"] = from_str(self.original_type)
        result["printings"] = from_list(from_str, self.printings)
        result["rarity"] = to_enum(Rarity, self.rarity)
        result["type"] = from_str(self.type)
        result["types"] = from_list(lambda x: to_enum(TypeElement, x), self.types)
        if self.color_identity is not None:
            result["colorIdentity"] = from_union([lambda x: from_list(lambda x: to_enum(ColorIdentity, x), x), from_none], self.color_identity)
        if self.colors is not None:
            result["colors"] = from_union([lambda x: from_list(lambda x: to_enum(Watermark, x), x), from_none], self.colors)
        if self.flavor is not None:
            result["flavor"] = from_union([from_none, from_str], self.flavor)
        if self.mana_cost is not None:
            result["manaCost"] = from_union([from_none, from_str], self.mana_cost)
        if self.mci_number is not None:
            result["mciNumber"] = from_union([lambda x: from_none((lambda x: is_type(type(None), x))(x)), lambda x: from_str((lambda x: str((lambda x: is_type(int, x))(x)))(x))], self.mci_number)
        if self.power is not None:
            result["power"] = from_union([lambda x: from_none((lambda x: is_type(type(None), x))(x)), lambda x: from_str((lambda x: str((lambda x: is_type(int, x))(x)))(x))], self.power)
        if self.reserved is not None:
            result["reserved"] = from_union([from_bool, from_none], self.reserved)
        if self.rulings is not None:
            result["rulings"] = from_union([lambda x: from_list(lambda x: to_class(Ruling, x), x), from_none], self.rulings)
        if self.subtypes is not None:
            result["subtypes"] = from_union([lambda x: from_list(from_str, x), from_none], self.subtypes)
        if self.supertypes is not None:
            result["supertypes"] = from_union([lambda x: from_list(from_str, x), from_none], self.supertypes)
        if self.text is not None:
            result["text"] = from_union([from_none, from_str], self.text)
        if self.toughness is not None:
            result["toughness"] = from_union([lambda x: from_none((lambda x: is_type(type(None), x))(x)), lambda x: from_str((lambda x: str((lambda x: is_type(int, x))(x)))(x))], self.toughness)
        if self.variations is not None:
            result["variations"] = from_union([lambda x: from_list(from_int, x), from_none], self.variations)
        if self.watermark is not None:
            result["watermark"] = from_union([lambda x: to_enum(Watermark, x), from_none], self.watermark)
        return result


@dataclass
class TopLevel:
    booster: list[str]
    border: str
    cards: list[Card]
    code: str
    gatherer_code: str
    magic_cards_info_code: str
    mkm_id: int
    mkm_name: str
    name: str
    release_date: datetime.date
    type: str

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        booster = from_list(from_str, obj["booster"])
        border = from_str(obj["border"])
        cards = from_list(Card.from_dict, obj["cards"])
        code = from_str(obj["code"])
        gatherer_code = from_str(obj["gathererCode"])
        magic_cards_info_code = from_str(obj["magicCardsInfoCode"])
        mkm_id = from_int(obj["mkm_id"])
        mkm_name = from_str(obj["mkm_name"])
        name = from_str(obj["name"])
        release_date = from_date(obj["releaseDate"])
        type = from_str(obj["type"])
        return TopLevel(booster, border, cards, code, gatherer_code, magic_cards_info_code, mkm_id, mkm_name, name, release_date, type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["booster"] = from_list(from_str, self.booster)
        result["border"] = from_str(self.border)
        result["cards"] = from_list(lambda x: to_class(Card, x), self.cards)
        result["code"] = from_str(self.code)
        result["gathererCode"] = from_str(self.gatherer_code)
        result["magicCardsInfoCode"] = from_str(self.magic_cards_info_code)
        result["mkm_id"] = from_int(self.mkm_id)
        result["mkm_name"] = from_str(self.mkm_name)
        result["name"] = from_str(self.name)
        result["releaseDate"] = self.release_date.isoformat()
        result["type"] = from_str(self.type)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
