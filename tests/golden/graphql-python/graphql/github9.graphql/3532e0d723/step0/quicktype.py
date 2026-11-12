from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Type, Callable, cast


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
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


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


class ReactionContent(Enum):
    THUMBS_UP = "THUMBS_UP"
    THUMBS_DOWN = "THUMBS_DOWN"
    LAUGH = "LAUGH"
    HOORAY = "HOORAY"
    CONFUSED = "CONFUSED"
    HEART = "HEART"


@dataclass
class Reaction:
    content: ReactionContent

    @staticmethod
    def from_dict(obj: Any) -> 'Reaction':
        assert isinstance(obj, dict)
        content = ReactionContent(obj["content"])
        return Reaction(content)

    def to_dict(self) -> dict:
        result: dict = {}
        result["content"] = to_enum(ReactionContent, self.content)
        return result


@dataclass
class Reactable:
    viewer_can_react: bool
    reaction_groups: list[Reaction] | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'Reactable':
        assert isinstance(obj, dict)
        viewer_can_react = from_bool(obj["viewerCanReact"])
        reaction_groups = from_union([lambda x: from_list(Reaction.from_dict, x), from_none], obj["reactionGroups"])
        return Reactable(viewer_can_react, reaction_groups)

    def to_dict(self) -> dict:
        result: dict = {}
        result["viewerCanReact"] = from_bool(self.viewer_can_react)
        result["reactionGroups"] = from_union([lambda x: from_list(lambda x: to_class(Reaction, x), x), from_none], self.reaction_groups)
        return result


@dataclass
class AddReactionPayload:
    reaction: Reaction
    subject: Reactable
    client_mutation_id: str | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'AddReactionPayload':
        assert isinstance(obj, dict)
        reaction = Reaction.from_dict(obj["reaction"])
        subject = Reactable.from_dict(obj["subject"])
        client_mutation_id = from_union([from_str, from_none], obj["clientMutationId"])
        return AddReactionPayload(reaction, subject, client_mutation_id)

    def to_dict(self) -> dict:
        result: dict = {}
        result["reaction"] = to_class(Reaction, self.reaction)
        result["subject"] = to_class(Reactable, self.subject)
        result["clientMutationId"] = from_union([from_str, from_none], self.client_mutation_id)
        return result


@dataclass
class Data:
    add_reaction: AddReactionPayload | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'Data':
        assert isinstance(obj, dict)
        add_reaction = from_union([AddReactionPayload.from_dict, from_none], obj["addReaction"])
        return Data(add_reaction)

    def to_dict(self) -> dict:
        result: dict = {}
        result["addReaction"] = from_union([lambda x: to_class(AddReactionPayload, x), from_none], self.add_reaction)
        return result


@dataclass
class Error:
    message: str

    @staticmethod
    def from_dict(obj: Any) -> 'Error':
        assert isinstance(obj, dict)
        message = from_str(obj["message"])
        return Error(message)

    def to_dict(self) -> dict:
        result: dict = {}
        result["message"] = from_str(self.message)
        return result


@dataclass
class TopLevel:
    data: Data | None = None
    errors: list[Error] | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        data = from_union([Data.from_dict, from_none], obj["data"])
        errors = from_union([lambda x: from_list(Error.from_dict, x), from_none], obj.get("errors"))
        return TopLevel(data, errors)

    def to_dict(self) -> dict:
        result: dict = {}
        result["data"] = from_union([lambda x: to_class(Data, x), from_none], self.data)
        if self.errors is not None:
            result["errors"] = from_union([lambda x: from_list(lambda x: to_class(Error, x), x), from_none], self.errors)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
