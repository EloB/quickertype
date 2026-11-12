from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


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


def to_float(x: Any) -> float:
    assert isinstance(x, (int, float))
    return x


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


class Egg(Enum):
    THE_2_KM = "2 km"
    NOT_IN_EGGS = "Not in Eggs"
    THE_5_KM = "5 km"
    THE_10_KM = "10 km"
    OMANYTE_CANDY = "Omanyte Candy"


@dataclass
class Evolution:
    name: str
    num: str

    @staticmethod
    def from_dict(obj: Any) -> 'Evolution':
        assert isinstance(obj, dict)
        name = from_str(obj["name"])
        num = from_str(obj["num"])
        return Evolution(name, num)

    def to_dict(self) -> dict:
        result: dict = {}
        result["name"] = from_str(self.name)
        result["num"] = from_str(self.num)
        return result


class TypeElement(Enum):
    FIRE = "Fire"
    ICE = "Ice"
    FLYING = "Flying"
    PSYCHIC = "Psychic"
    WATER = "Water"
    GROUND = "Ground"
    ROCK = "Rock"
    ELECTRIC = "Electric"
    GRASS = "Grass"
    FIGHTING = "Fighting"
    POISON = "Poison"
    BUG = "Bug"
    FAIRY = "Fairy"
    GHOST = "Ghost"
    DARK = "Dark"
    STEEL = "Steel"
    DRAGON = "Dragon"
    NORMAL = "Normal"


@dataclass
class Pokemon:
    avg_spawns: float
    candy: str
    egg: Egg
    height: str
    id: int
    img: str
    name: str
    num: str
    spawn_chance: float
    spawn_time: str
    type: list[TypeElement]
    weaknesses: list[TypeElement]
    weight: str
    candy_count: int | None
    multipliers: list[float] | None
    next_evolution: list[Evolution] | None
    prev_evolution: list[Evolution] | None

    @staticmethod
    def from_dict(obj: Any) -> 'Pokemon':
        assert isinstance(obj, dict)
        avg_spawns = from_float(obj["avg_spawns"])
        candy = from_str(obj["candy"])
        egg = Egg(obj["egg"])
        height = from_str(obj["height"])
        id = from_int(obj["id"])
        img = from_str(obj["img"])
        name = from_str(obj["name"])
        num = from_str(obj["num"])
        spawn_chance = from_float(obj["spawn_chance"])
        spawn_time = from_str(obj["spawn_time"])
        type = from_list(TypeElement, obj["type"])
        weaknesses = from_list(TypeElement, obj["weaknesses"])
        weight = from_str(obj["weight"])
        candy_count = from_union([from_int, from_none], obj.get("candy_count"))
        multipliers = from_union([lambda x: from_list(from_float, x), from_none], obj["multipliers"])
        next_evolution = from_union([lambda x: from_list(Evolution.from_dict, x), from_none], obj.get("next_evolution"))
        prev_evolution = from_union([lambda x: from_list(Evolution.from_dict, x), from_none], obj.get("prev_evolution"))
        return Pokemon(avg_spawns, candy, egg, height, id, img, name, num, spawn_chance, spawn_time, type, weaknesses, weight, candy_count, multipliers, next_evolution, prev_evolution)

    def to_dict(self) -> dict:
        result: dict = {}
        result["avg_spawns"] = to_float(self.avg_spawns)
        result["candy"] = from_str(self.candy)
        result["egg"] = to_enum(Egg, self.egg)
        result["height"] = from_str(self.height)
        result["id"] = from_int(self.id)
        result["img"] = from_str(self.img)
        result["name"] = from_str(self.name)
        result["num"] = from_str(self.num)
        result["spawn_chance"] = to_float(self.spawn_chance)
        result["spawn_time"] = from_str(self.spawn_time)
        result["type"] = from_list(lambda x: to_enum(TypeElement, x), self.type)
        result["weaknesses"] = from_list(lambda x: to_enum(TypeElement, x), self.weaknesses)
        result["weight"] = from_str(self.weight)
        if self.candy_count is not None:
            result["candy_count"] = from_union([from_int, from_none], self.candy_count)
        result["multipliers"] = from_union([lambda x: from_list(to_float, x), from_none], self.multipliers)
        if self.next_evolution is not None:
            result["next_evolution"] = from_union([lambda x: from_list(lambda x: to_class(Evolution, x), x), from_none], self.next_evolution)
        if self.prev_evolution is not None:
            result["prev_evolution"] = from_union([lambda x: from_list(lambda x: to_class(Evolution, x), x), from_none], self.prev_evolution)
        return result


@dataclass
class TopLevel:
    pokemon: list[Pokemon]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        pokemon = from_list(Pokemon.from_dict, obj["pokemon"])
        return TopLevel(pokemon)

    def to_dict(self) -> dict:
        result: dict = {}
        result["pokemon"] = from_list(lambda x: to_class(Pokemon, x), self.pokemon)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
