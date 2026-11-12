from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_none(x: Any) -> Any:
    assert x is None
    return x


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_dict(f: Callable[[Any], T], x: Any) -> dict[str, T]:
    assert isinstance(x, dict)
    return { k: f(v) for (k, v) in x.items() }


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


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class ArrayNode:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'ArrayNode':
        assert isinstance(obj, dict)
        return ArrayNode()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class BooleanNode:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'BooleanNode':
        assert isinstance(obj, dict)
        return BooleanNode()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class DoubleNode:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'DoubleNode':
        assert isinstance(obj, dict)
        return DoubleNode()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class IntNode:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'IntNode':
        assert isinstance(obj, dict)
        return IntNode()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class LongNode:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'LongNode':
        assert isinstance(obj, dict)
        return LongNode()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class NullNode:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'NullNode':
        assert isinstance(obj, dict)
        return NullNode()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class ObjectNode:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'ObjectNode':
        assert isinstance(obj, dict)
        return ObjectNode()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Thing:
    optional: float | int | bool | str | list[Any] | dict[str, Any] | None = None
    required: float | int | bool | str | list[Any] | dict[str, Any] | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'Thing':
        assert isinstance(obj, dict)
        optional = from_union([from_none, from_int, from_float, from_bool, from_str, lambda x: from_list(lambda x: x, x), lambda x: from_dict(lambda x: x, x)], obj.get("optional"))
        required = from_union([from_none, from_int, from_float, from_bool, from_str, lambda x: from_list(lambda x: x, x), lambda x: from_dict(lambda x: x, x)], obj["required"])
        return Thing(optional, required)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.optional is not None:
            result["optional"] = from_union([from_none, from_int, to_float, from_bool, from_str, lambda x: from_list(lambda x: x, x), lambda x: from_dict(lambda x: x, x)], self.optional)
        result["required"] = from_union([from_none, from_int, to_float, from_bool, from_str, lambda x: from_list(lambda x: x, x), lambda x: from_dict(lambda x: x, x)], self.required)
        return result


@dataclass
class TextNode:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'TextNode':
        assert isinstance(obj, dict)
        return TextNode()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class TopLevel:
    stuff: dict[str, Thing]
    array_node: ArrayNode | None = None
    boolean_node: BooleanNode | None = None
    double_node: DoubleNode | None = None
    int_node: IntNode | None = None
    long_node: LongNode | None = None
    null_node: NullNode | None = None
    object_node: ObjectNode | None = None
    text_node: TextNode | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        stuff = from_dict(Thing.from_dict, obj["stuff"])
        array_node = from_union([ArrayNode.from_dict, from_none], obj.get("arrayNode"))
        boolean_node = from_union([BooleanNode.from_dict, from_none], obj.get("booleanNode"))
        double_node = from_union([DoubleNode.from_dict, from_none], obj.get("doubleNode"))
        int_node = from_union([IntNode.from_dict, from_none], obj.get("intNode"))
        long_node = from_union([LongNode.from_dict, from_none], obj.get("longNode"))
        null_node = from_union([NullNode.from_dict, from_none], obj.get("nullNode"))
        object_node = from_union([ObjectNode.from_dict, from_none], obj.get("objectNode"))
        text_node = from_union([TextNode.from_dict, from_none], obj.get("textNode"))
        return TopLevel(stuff, array_node, boolean_node, double_node, int_node, long_node, null_node, object_node, text_node)

    def to_dict(self) -> dict:
        result: dict = {}
        result["stuff"] = from_dict(lambda x: to_class(Thing, x), self.stuff)
        if self.array_node is not None:
            result["arrayNode"] = from_union([lambda x: to_class(ArrayNode, x), from_none], self.array_node)
        if self.boolean_node is not None:
            result["booleanNode"] = from_union([lambda x: to_class(BooleanNode, x), from_none], self.boolean_node)
        if self.double_node is not None:
            result["doubleNode"] = from_union([lambda x: to_class(DoubleNode, x), from_none], self.double_node)
        if self.int_node is not None:
            result["intNode"] = from_union([lambda x: to_class(IntNode, x), from_none], self.int_node)
        if self.long_node is not None:
            result["longNode"] = from_union([lambda x: to_class(LongNode, x), from_none], self.long_node)
        if self.null_node is not None:
            result["nullNode"] = from_union([lambda x: to_class(NullNode, x), from_none], self.null_node)
        if self.object_node is not None:
            result["objectNode"] = from_union([lambda x: to_class(ObjectNode, x), from_none], self.object_node)
        if self.text_node is not None:
            result["textNode"] = from_union([lambda x: to_class(TextNode, x), from_none], self.text_node)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
