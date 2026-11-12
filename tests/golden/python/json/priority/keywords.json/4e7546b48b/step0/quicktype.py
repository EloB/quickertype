import datetime
from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast, Callable
from enum import Enum
from uuid import UUID
import dateutil.parser


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


def from_datetime(x: Any) -> datetime.datetime:
    return dateutil.parser.parse(x)


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def from_none(x: Any) -> Any:
    assert x is None
    return x


@dataclass
class Abstract:
    abstract: int

    @staticmethod
    def from_dict(obj: Any) -> 'Abstract':
        assert isinstance(obj, dict)
        abstract = from_int(obj["abstract"])
        return Abstract(abstract)

    def to_dict(self) -> dict:
        result: dict = {}
        result["abstract"] = from_int(self.abstract)
        return result


@dataclass
class Alignas:
    alignas: int

    @staticmethod
    def from_dict(obj: Any) -> 'Alignas':
        assert isinstance(obj, dict)
        alignas = from_int(obj["alignas"])
        return Alignas(alignas)

    def to_dict(self) -> dict:
        result: dict = {}
        result["alignas"] = from_int(self.alignas)
        return result


@dataclass
class Alignof:
    alignof: int

    @staticmethod
    def from_dict(obj: Any) -> 'Alignof':
        assert isinstance(obj, dict)
        alignof = from_int(obj["alignof"])
        return Alignof(alignof)

    def to_dict(self) -> dict:
        result: dict = {}
        result["alignof"] = from_int(self.alignof)
        return result


@dataclass
class AndEq:
    and_eq: int

    @staticmethod
    def from_dict(obj: Any) -> 'AndEq':
        assert isinstance(obj, dict)
        and_eq = from_int(obj["and_eq"])
        return AndEq(and_eq)

    def to_dict(self) -> dict:
        result: dict = {}
        result["and_eq"] = from_int(self.and_eq)
        return result


@dataclass
class AnyClass:
    any: int

    @staticmethod
    def from_dict(obj: Any) -> 'AnyClass':
        assert isinstance(obj, dict)
        any = from_int(obj["Any"])
        return AnyClass(any)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Any"] = from_int(self.any)
        return result


@dataclass
class Array:
    array: int

    @staticmethod
    def from_dict(obj: Any) -> 'Array':
        assert isinstance(obj, dict)
        array = from_int(obj["array"])
        return Array(array)

    def to_dict(self) -> dict:
        result: dict = {}
        result["array"] = from_int(self.array)
        return result


@dataclass
class ArrayNode:
    array_node: int

    @staticmethod
    def from_dict(obj: Any) -> 'ArrayNode':
        assert isinstance(obj, dict)
        array_node = from_int(obj["ArrayNode"])
        return ArrayNode(array_node)

    def to_dict(self) -> dict:
        result: dict = {}
        result["ArrayNode"] = from_int(self.array_node)
        return result


@dataclass
class ASM:
    asm: int

    @staticmethod
    def from_dict(obj: Any) -> 'ASM':
        assert isinstance(obj, dict)
        asm = from_int(obj["asm"])
        return ASM(asm)

    def to_dict(self) -> dict:
        result: dict = {}
        result["asm"] = from_int(self.asm)
        return result


@dataclass
class Associatedtype:
    associatedtype: int

    @staticmethod
    def from_dict(obj: Any) -> 'Associatedtype':
        assert isinstance(obj, dict)
        associatedtype = from_int(obj["associatedtype"])
        return Associatedtype(associatedtype)

    def to_dict(self) -> dict:
        result: dict = {}
        result["associatedtype"] = from_int(self.associatedtype)
        return result


@dataclass
class Associativity:
    associativity: int

    @staticmethod
    def from_dict(obj: Any) -> 'Associativity':
        assert isinstance(obj, dict)
        associativity = from_int(obj["associativity"])
        return Associativity(associativity)

    def to_dict(self) -> dict:
        result: dict = {}
        result["associativity"] = from_int(self.associativity)
        return result


@dataclass
class Atomic:
    atomic: int

    @staticmethod
    def from_dict(obj: Any) -> 'Atomic':
        assert isinstance(obj, dict)
        atomic = from_int(obj["atomic"])
        return Atomic(atomic)

    def to_dict(self) -> dict:
        result: dict = {}
        result["atomic"] = from_int(self.atomic)
        return result


@dataclass
class AtomicCancel:
    atomic_cancel: int

    @staticmethod
    def from_dict(obj: Any) -> 'AtomicCancel':
        assert isinstance(obj, dict)
        atomic_cancel = from_int(obj["atomic_cancel"])
        return AtomicCancel(atomic_cancel)

    def to_dict(self) -> dict:
        result: dict = {}
        result["atomic_cancel"] = from_int(self.atomic_cancel)
        return result


@dataclass
class AtomicCommit:
    atomic_commit: int

    @staticmethod
    def from_dict(obj: Any) -> 'AtomicCommit':
        assert isinstance(obj, dict)
        atomic_commit = from_int(obj["atomic_commit"])
        return AtomicCommit(atomic_commit)

    def to_dict(self) -> dict:
        result: dict = {}
        result["atomic_commit"] = from_int(self.atomic_commit)
        return result


@dataclass
class AtomicNoexcept:
    atomic_noexcept: int

    @staticmethod
    def from_dict(obj: Any) -> 'AtomicNoexcept':
        assert isinstance(obj, dict)
        atomic_noexcept = from_int(obj["atomic_noexcept"])
        return AtomicNoexcept(atomic_noexcept)

    def to_dict(self) -> dict:
        result: dict = {}
        result["atomic_noexcept"] = from_int(self.atomic_noexcept)
        return result


@dataclass
class Auto:
    auto: int

    @staticmethod
    def from_dict(obj: Any) -> 'Auto':
        assert isinstance(obj, dict)
        auto = from_int(obj["auto"])
        return Auto(auto)

    def to_dict(self) -> dict:
        result: dict = {}
        result["auto"] = from_int(self.auto)
        return result


@dataclass
class Base:
    base: int

    @staticmethod
    def from_dict(obj: Any) -> 'Base':
        assert isinstance(obj, dict)
        base = from_int(obj["base"])
        return Base(base)

    def to_dict(self) -> dict:
        result: dict = {}
        result["base"] = from_int(self.base)
        return result


@dataclass
class Bitand:
    bitand: int

    @staticmethod
    def from_dict(obj: Any) -> 'Bitand':
        assert isinstance(obj, dict)
        bitand = from_int(obj["bitand"])
        return Bitand(bitand)

    def to_dict(self) -> dict:
        result: dict = {}
        result["bitand"] = from_int(self.bitand)
        return result


@dataclass
class Bitor:
    bitor: int

    @staticmethod
    def from_dict(obj: Any) -> 'Bitor':
        assert isinstance(obj, dict)
        bitor = from_int(obj["bitor"])
        return Bitor(bitor)

    def to_dict(self) -> dict:
        result: dict = {}
        result["bitor"] = from_int(self.bitor)
        return result


@dataclass
class Boolean:
    boolean: int

    @staticmethod
    def from_dict(obj: Any) -> 'Boolean':
        assert isinstance(obj, dict)
        boolean = from_int(obj["boolean"])
        return Boolean(boolean)

    def to_dict(self) -> dict:
        result: dict = {}
        result["boolean"] = from_int(self.boolean)
        return result


@dataclass
class BooleanNode:
    boolean_node: int

    @staticmethod
    def from_dict(obj: Any) -> 'BooleanNode':
        assert isinstance(obj, dict)
        boolean_node = from_int(obj["BooleanNode"])
        return BooleanNode(boolean_node)

    def to_dict(self) -> dict:
        result: dict = {}
        result["BooleanNode"] = from_int(self.boolean_node)
        return result


@dataclass
class Bycopy:
    bycopy: int

    @staticmethod
    def from_dict(obj: Any) -> 'Bycopy':
        assert isinstance(obj, dict)
        bycopy = from_int(obj["bycopy"])
        return Bycopy(bycopy)

    def to_dict(self) -> dict:
        result: dict = {}
        result["bycopy"] = from_int(self.bycopy)
        return result


@dataclass
class Byref:
    byref: int

    @staticmethod
    def from_dict(obj: Any) -> 'Byref':
        assert isinstance(obj, dict)
        byref = from_int(obj["byref"])
        return Byref(byref)

    def to_dict(self) -> dict:
        result: dict = {}
        result["byref"] = from_int(self.byref)
        return result


@dataclass
class Byte:
    byte: int

    @staticmethod
    def from_dict(obj: Any) -> 'Byte':
        assert isinstance(obj, dict)
        byte = from_int(obj["byte"])
        return Byte(byte)

    def to_dict(self) -> dict:
        result: dict = {}
        result["byte"] = from_int(self.byte)
        return result


@dataclass
class Calendar:
    calendar: int

    @staticmethod
    def from_dict(obj: Any) -> 'Calendar':
        assert isinstance(obj, dict)
        calendar = from_int(obj["Calendar"])
        return Calendar(calendar)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Calendar"] = from_int(self.calendar)
        return result


@dataclass
class Case:
    case: int

    @staticmethod
    def from_dict(obj: Any) -> 'Case':
        assert isinstance(obj, dict)
        case = from_int(obj["case"])
        return Case(case)

    def to_dict(self) -> dict:
        result: dict = {}
        result["case"] = from_int(self.case)
        return result


@dataclass
class Catch:
    catch: int

    @staticmethod
    def from_dict(obj: Any) -> 'Catch':
        assert isinstance(obj, dict)
        catch = from_int(obj["catch"])
        return Catch(catch)

    def to_dict(self) -> dict:
        result: dict = {}
        result["catch"] = from_int(self.catch)
        return result


@dataclass
class Chan:
    chan: int

    @staticmethod
    def from_dict(obj: Any) -> 'Chan':
        assert isinstance(obj, dict)
        chan = from_int(obj["chan"])
        return Chan(chan)

    def to_dict(self) -> dict:
        result: dict = {}
        result["chan"] = from_int(self.chan)
        return result


@dataclass
class Char:
    char: int

    @staticmethod
    def from_dict(obj: Any) -> 'Char':
        assert isinstance(obj, dict)
        char = from_int(obj["char"])
        return Char(char)

    def to_dict(self) -> dict:
        result: dict = {}
        result["char"] = from_int(self.char)
        return result


@dataclass
class Char16T:
    char16_t: int

    @staticmethod
    def from_dict(obj: Any) -> 'Char16T':
        assert isinstance(obj, dict)
        char16_t = from_int(obj["char16_t"])
        return Char16T(char16_t)

    def to_dict(self) -> dict:
        result: dict = {}
        result["char16_t"] = from_int(self.char16_t)
        return result


@dataclass
class Char32T:
    char32_t: int

    @staticmethod
    def from_dict(obj: Any) -> 'Char32T':
        assert isinstance(obj, dict)
        char32_t = from_int(obj["char32_t"])
        return Char32T(char32_t)

    def to_dict(self) -> dict:
        result: dict = {}
        result["char32_t"] = from_int(self.char32_t)
        return result


@dataclass
class Checked:
    checked: int

    @staticmethod
    def from_dict(obj: Any) -> 'Checked':
        assert isinstance(obj, dict)
        checked = from_int(obj["checked"])
        return Checked(checked)

    def to_dict(self) -> dict:
        result: dict = {}
        result["checked"] = from_int(self.checked)
        return result


@dataclass
class Clone:
    clone: int

    @staticmethod
    def from_dict(obj: Any) -> 'Clone':
        assert isinstance(obj, dict)
        clone = from_int(obj["clone"])
        return Clone(clone)

    def to_dict(self) -> dict:
        result: dict = {}
        result["clone"] = from_int(self.clone)
        return result


@dataclass
class CoAwait:
    co_await: int

    @staticmethod
    def from_dict(obj: Any) -> 'CoAwait':
        assert isinstance(obj, dict)
        co_await = from_int(obj["co_await"])
        return CoAwait(co_await)

    def to_dict(self) -> dict:
        result: dict = {}
        result["co_await"] = from_int(self.co_await)
        return result


@dataclass
class CoReturn:
    co_return: int

    @staticmethod
    def from_dict(obj: Any) -> 'CoReturn':
        assert isinstance(obj, dict)
        co_return = from_int(obj["co_return"])
        return CoReturn(co_return)

    def to_dict(self) -> dict:
        result: dict = {}
        result["co_return"] = from_int(self.co_return)
        return result


@dataclass
class CoYield:
    co_yield: int

    @staticmethod
    def from_dict(obj: Any) -> 'CoYield':
        assert isinstance(obj, dict)
        co_yield = from_int(obj["co_yield"])
        return CoYield(co_yield)

    def to_dict(self) -> dict:
        result: dict = {}
        result["co_yield"] = from_int(self.co_yield)
        return result


@dataclass
class Codable:
    codable: int

    @staticmethod
    def from_dict(obj: Any) -> 'Codable':
        assert isinstance(obj, dict)
        codable = from_int(obj["Codable"])
        return Codable(codable)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Codable"] = from_int(self.codable)
        return result


@dataclass
class CodingKey:
    coding_key: int

    @staticmethod
    def from_dict(obj: Any) -> 'CodingKey':
        assert isinstance(obj, dict)
        coding_key = from_int(obj["CodingKey"])
        return CodingKey(coding_key)

    def to_dict(self) -> dict:
        result: dict = {}
        result["CodingKey"] = from_int(self.coding_key)
        return result


@dataclass
class CodingKeys:
    coding_keys: int

    @staticmethod
    def from_dict(obj: Any) -> 'CodingKeys':
        assert isinstance(obj, dict)
        coding_keys = from_int(obj["CodingKeys"])
        return CodingKeys(coding_keys)

    def to_dict(self) -> dict:
        result: dict = {}
        result["CodingKeys"] = from_int(self.coding_keys)
        return result


@dataclass
class Compl:
    compl: int

    @staticmethod
    def from_dict(obj: Any) -> 'Compl':
        assert isinstance(obj, dict)
        compl = from_int(obj["compl"])
        return Compl(compl)

    def to_dict(self) -> dict:
        result: dict = {}
        result["compl"] = from_int(self.compl)
        return result


@dataclass
class Complex:
    complex: int

    @staticmethod
    def from_dict(obj: Any) -> 'Complex':
        assert isinstance(obj, dict)
        complex = from_int(obj["_Complex"])
        return Complex(complex)

    def to_dict(self) -> dict:
        result: dict = {}
        result["_Complex"] = from_int(self.complex)
        return result


@dataclass
class Concept:
    concept: int

    @staticmethod
    def from_dict(obj: Any) -> 'Concept':
        assert isinstance(obj, dict)
        concept = from_int(obj["concept"])
        return Concept(concept)

    def to_dict(self) -> dict:
        result: dict = {}
        result["concept"] = from_int(self.concept)
        return result


@dataclass
class Console:
    console: int

    @staticmethod
    def from_dict(obj: Any) -> 'Console':
        assert isinstance(obj, dict)
        console = from_int(obj["console"])
        return Console(console)

    def to_dict(self) -> dict:
        result: dict = {}
        result["console"] = from_int(self.console)
        return result


@dataclass
class Const:
    const: int

    @staticmethod
    def from_dict(obj: Any) -> 'Const':
        assert isinstance(obj, dict)
        const = from_int(obj["const"])
        return Const(const)

    def to_dict(self) -> dict:
        result: dict = {}
        result["const"] = from_int(self.const)
        return result


@dataclass
class ConstCast:
    const_cast: int

    @staticmethod
    def from_dict(obj: Any) -> 'ConstCast':
        assert isinstance(obj, dict)
        const_cast = from_int(obj["const_cast"])
        return ConstCast(const_cast)

    def to_dict(self) -> dict:
        result: dict = {}
        result["const_cast"] = from_int(self.const_cast)
        return result


@dataclass
class Constexpr:
    constexpr: int

    @staticmethod
    def from_dict(obj: Any) -> 'Constexpr':
        assert isinstance(obj, dict)
        constexpr = from_int(obj["constexpr"])
        return Constexpr(constexpr)

    def to_dict(self) -> dict:
        result: dict = {}
        result["constexpr"] = from_int(self.constexpr)
        return result


@dataclass
class Constructor:
    constructor: int

    @staticmethod
    def from_dict(obj: Any) -> 'Constructor':
        assert isinstance(obj, dict)
        constructor = from_int(obj["constructor"])
        return Constructor(constructor)

    def to_dict(self) -> dict:
        result: dict = {}
        result["constructor"] = from_int(self.constructor)
        return result


@dataclass
class Convenience:
    convenience: int

    @staticmethod
    def from_dict(obj: Any) -> 'Convenience':
        assert isinstance(obj, dict)
        convenience = from_int(obj["convenience"])
        return Convenience(convenience)

    def to_dict(self) -> dict:
        result: dict = {}
        result["convenience"] = from_int(self.convenience)
        return result


@dataclass
class Convert:
    convert: int

    @staticmethod
    def from_dict(obj: Any) -> 'Convert':
        assert isinstance(obj, dict)
        convert = from_int(obj["convert"])
        return Convert(convert)

    def to_dict(self) -> dict:
        result: dict = {}
        result["convert"] = from_int(self.convert)
        return result


@dataclass
class Converter:
    converter: int

    @staticmethod
    def from_dict(obj: Any) -> 'Converter':
        assert isinstance(obj, dict)
        converter = from_int(obj["converter"])
        return Converter(converter)

    def to_dict(self) -> dict:
        result: dict = {}
        result["converter"] = from_int(self.converter)
        return result


@dataclass
class Empty:
    empty: int

    @staticmethod
    def from_dict(obj: Any) -> 'Empty':
        assert isinstance(obj, dict)
        empty = from_int(obj["_"])
        return Empty(empty)

    def to_dict(self) -> dict:
        result: dict = {}
        result["_"] = from_int(self.empty)
        return result


@dataclass
class Obj1Bool:
    bool_bool: int

    @staticmethod
    def from_dict(obj: Any) -> 'Obj1Bool':
        assert isinstance(obj, dict)
        bool_bool = from_int(obj["bool"])
        return Obj1Bool(bool_bool)

    def to_dict(self) -> dict:
        result: dict = {}
        result["bool"] = from_int(self.bool_bool)
        return result


@dataclass
class Imaginery:
    imaginery: int

    @staticmethod
    def from_dict(obj: Any) -> 'Imaginery':
        assert isinstance(obj, dict)
        imaginery = from_int(obj["_Imaginery"])
        return Imaginery(imaginery)

    def to_dict(self) -> dict:
        result: dict = {}
        result["_Imaginery"] = from_int(self.imaginery)
        return result


@dataclass
class And:
    and_and: int

    @staticmethod
    def from_dict(obj: Any) -> 'And':
        assert isinstance(obj, dict)
        and_and = from_int(obj["and"])
        return And(and_and)

    def to_dict(self) -> dict:
        result: dict = {}
        result["and"] = from_int(self.and_and)
        return result


@dataclass
class Obj1Any:
    any: int

    @staticmethod
    def from_dict(obj: Any) -> 'Obj1Any':
        assert isinstance(obj, dict)
        any = from_int(obj["any"])
        return Obj1Any(any)

    def to_dict(self) -> dict:
        result: dict = {}
        result["any"] = from_int(self.any)
        return result


@dataclass
class As:
    as_as: int

    @staticmethod
    def from_dict(obj: Any) -> 'As':
        assert isinstance(obj, dict)
        as_as = from_int(obj["as"])
        return As(as_as)

    def to_dict(self) -> dict:
        result: dict = {}
        result["as"] = from_int(self.as_as)
        return result


@dataclass
class Assert:
    assert_assert: int

    @staticmethod
    def from_dict(obj: Any) -> 'Assert':
        assert isinstance(obj, dict)
        assert_assert = from_int(obj["assert"])
        return Assert(assert_assert)

    def to_dict(self) -> dict:
        result: dict = {}
        result["assert"] = from_int(self.assert_assert)
        return result


@dataclass
class Async:
    async_async: int

    @staticmethod
    def from_dict(obj: Any) -> 'Async':
        assert isinstance(obj, dict)
        async_async = from_int(obj["async"])
        return Async(async_async)

    def to_dict(self) -> dict:
        result: dict = {}
        result["async"] = from_int(self.async_async)
        return result


@dataclass
class Await:
    await_await: int

    @staticmethod
    def from_dict(obj: Any) -> 'Await':
        assert isinstance(obj, dict)
        await_await = from_int(obj["await"])
        return Await(await_await)

    def to_dict(self) -> dict:
        result: dict = {}
        result["await"] = from_int(self.await_await)
        return result


@dataclass
class Bool:
    bool_bool: int

    @staticmethod
    def from_dict(obj: Any) -> 'Bool':
        assert isinstance(obj, dict)
        bool_bool = from_int(obj["BOOL"])
        return Bool(bool_bool)

    def to_dict(self) -> dict:
        result: dict = {}
        result["BOOL"] = from_int(self.bool_bool)
        return result


@dataclass
class Break:
    break_break: int

    @staticmethod
    def from_dict(obj: Any) -> 'Break':
        assert isinstance(obj, dict)
        break_break = from_int(obj["break"])
        return Break(break_break)

    def to_dict(self) -> dict:
        result: dict = {}
        result["break"] = from_int(self.break_break)
        return result


@dataclass
class Class:
    class_class: int

    @staticmethod
    def from_dict(obj: Any) -> 'Class':
        assert isinstance(obj, dict)
        class_class = from_int(obj["Class"])
        return Class(class_class)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Class"] = from_int(self.class_class)
        return result


@dataclass
class Continue:
    continue_continue: int

    @staticmethod
    def from_dict(obj: Any) -> 'Continue':
        assert isinstance(obj, dict)
        continue_continue = from_int(obj["continue"])
        return Continue(continue_continue)

    def to_dict(self) -> dict:
        result: dict = {}
        result["continue"] = from_int(self.continue_continue)
        return result


@dataclass
class BoolClass:
    bool_bool: int

    @staticmethod
    def from_dict(obj: Any) -> 'BoolClass':
        assert isinstance(obj, dict)
        bool_bool = from_int(obj["_Bool"])
        return BoolClass(bool_bool)

    def to_dict(self) -> dict:
        result: dict = {}
        result["_Bool"] = from_int(self.bool_bool)
        return result


@dataclass
class ClassClass:
    class_class: int

    @staticmethod
    def from_dict(obj: Any) -> 'ClassClass':
        assert isinstance(obj, dict)
        class_class = from_int(obj["class"])
        return ClassClass(class_class)

    def to_dict(self) -> dict:
        result: dict = {}
        result["class"] = from_int(self.class_class)
        return result


@dataclass
class Obj1:
    any: AnyClass
    array_node: ArrayNode
    obj1_bool: Bool
    boolean_node: BooleanNode
    calendar: Calendar
    obj1_class: Class
    codable: Codable
    coding_key: CodingKey
    coding_keys: CodingKeys
    empty: Empty
    purple_bool: BoolClass
    complex: Complex
    imaginery: Imaginery
    abstract: Abstract
    alignas: Alignas
    alignof: Alignof
    obj1_and: And
    and_eq: AndEq
    obj1_any: Obj1Any
    array: Array
    obj1_as: As
    asm: ASM
    obj1_assert: Assert
    associatedtype: Associatedtype
    associativity: Associativity
    obj1_async: Async
    atomic: Atomic
    atomic_cancel: AtomicCancel
    atomic_commit: AtomicCommit
    atomic_noexcept: AtomicNoexcept
    auto: Auto
    obj1_await: Await
    base: Base
    bitand: Bitand
    bitor: Bitor
    fluffy_bool: Obj1Bool
    boolean: Boolean
    obj1_break: Break
    bycopy: Bycopy
    byref: Byref
    byte: Byte
    case: Case
    catch: Catch
    chan: Chan
    char: Char
    char16_t: Char16T
    char32_t: Char32T
    checked: Checked
    purple_class: ClassClass
    clone: Clone
    co_await: CoAwait
    co_return: CoReturn
    co_yield: CoYield
    compl: Compl
    concept: Concept
    console: Console
    const: Const
    const_cast: ConstCast
    constexpr: Constexpr
    constructor: Constructor
    obj1_continue: Continue
    convenience: Convenience
    convert: Convert
    converter: Converter
    dummy: int

    @staticmethod
    def from_dict(obj: Any) -> 'Obj1':
        assert isinstance(obj, dict)
        any = AnyClass.from_dict(obj["Any"])
        array_node = ArrayNode.from_dict(obj["ArrayNode"])
        obj1_bool = Bool.from_dict(obj["BOOL"])
        boolean_node = BooleanNode.from_dict(obj["BooleanNode"])
        calendar = Calendar.from_dict(obj["Calendar"])
        obj1_class = Class.from_dict(obj["Class"])
        codable = Codable.from_dict(obj["Codable"])
        coding_key = CodingKey.from_dict(obj["CodingKey"])
        coding_keys = CodingKeys.from_dict(obj["CodingKeys"])
        empty = Empty.from_dict(obj["_"])
        purple_bool = BoolClass.from_dict(obj["_Bool"])
        complex = Complex.from_dict(obj["_Complex"])
        imaginery = Imaginery.from_dict(obj["_Imaginery"])
        abstract = Abstract.from_dict(obj["abstract"])
        alignas = Alignas.from_dict(obj["alignas"])
        alignof = Alignof.from_dict(obj["alignof"])
        obj1_and = And.from_dict(obj["and"])
        and_eq = AndEq.from_dict(obj["and_eq"])
        obj1_any = Obj1Any.from_dict(obj["any"])
        array = Array.from_dict(obj["array"])
        obj1_as = As.from_dict(obj["as"])
        asm = ASM.from_dict(obj["asm"])
        obj1_assert = Assert.from_dict(obj["assert"])
        associatedtype = Associatedtype.from_dict(obj["associatedtype"])
        associativity = Associativity.from_dict(obj["associativity"])
        obj1_async = Async.from_dict(obj["async"])
        atomic = Atomic.from_dict(obj["atomic"])
        atomic_cancel = AtomicCancel.from_dict(obj["atomic_cancel"])
        atomic_commit = AtomicCommit.from_dict(obj["atomic_commit"])
        atomic_noexcept = AtomicNoexcept.from_dict(obj["atomic_noexcept"])
        auto = Auto.from_dict(obj["auto"])
        obj1_await = Await.from_dict(obj["await"])
        base = Base.from_dict(obj["base"])
        bitand = Bitand.from_dict(obj["bitand"])
        bitor = Bitor.from_dict(obj["bitor"])
        fluffy_bool = Obj1Bool.from_dict(obj["bool"])
        boolean = Boolean.from_dict(obj["boolean"])
        obj1_break = Break.from_dict(obj["break"])
        bycopy = Bycopy.from_dict(obj["bycopy"])
        byref = Byref.from_dict(obj["byref"])
        byte = Byte.from_dict(obj["byte"])
        case = Case.from_dict(obj["case"])
        catch = Catch.from_dict(obj["catch"])
        chan = Chan.from_dict(obj["chan"])
        char = Char.from_dict(obj["char"])
        char16_t = Char16T.from_dict(obj["char16_t"])
        char32_t = Char32T.from_dict(obj["char32_t"])
        checked = Checked.from_dict(obj["checked"])
        purple_class = ClassClass.from_dict(obj["class"])
        clone = Clone.from_dict(obj["clone"])
        co_await = CoAwait.from_dict(obj["co_await"])
        co_return = CoReturn.from_dict(obj["co_return"])
        co_yield = CoYield.from_dict(obj["co_yield"])
        compl = Compl.from_dict(obj["compl"])
        concept = Concept.from_dict(obj["concept"])
        console = Console.from_dict(obj["console"])
        const = Const.from_dict(obj["const"])
        const_cast = ConstCast.from_dict(obj["const_cast"])
        constexpr = Constexpr.from_dict(obj["constexpr"])
        constructor = Constructor.from_dict(obj["constructor"])
        obj1_continue = Continue.from_dict(obj["continue"])
        convenience = Convenience.from_dict(obj["convenience"])
        convert = Convert.from_dict(obj["convert"])
        converter = Converter.from_dict(obj["converter"])
        dummy = from_int(obj["dummy"])
        return Obj1(any, array_node, obj1_bool, boolean_node, calendar, obj1_class, codable, coding_key, coding_keys, empty, purple_bool, complex, imaginery, abstract, alignas, alignof, obj1_and, and_eq, obj1_any, array, obj1_as, asm, obj1_assert, associatedtype, associativity, obj1_async, atomic, atomic_cancel, atomic_commit, atomic_noexcept, auto, obj1_await, base, bitand, bitor, fluffy_bool, boolean, obj1_break, bycopy, byref, byte, case, catch, chan, char, char16_t, char32_t, checked, purple_class, clone, co_await, co_return, co_yield, compl, concept, console, const, const_cast, constexpr, constructor, obj1_continue, convenience, convert, converter, dummy)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Any"] = to_class(AnyClass, self.any)
        result["ArrayNode"] = to_class(ArrayNode, self.array_node)
        result["BOOL"] = to_class(Bool, self.obj1_bool)
        result["BooleanNode"] = to_class(BooleanNode, self.boolean_node)
        result["Calendar"] = to_class(Calendar, self.calendar)
        result["Class"] = to_class(Class, self.obj1_class)
        result["Codable"] = to_class(Codable, self.codable)
        result["CodingKey"] = to_class(CodingKey, self.coding_key)
        result["CodingKeys"] = to_class(CodingKeys, self.coding_keys)
        result["_"] = to_class(Empty, self.empty)
        result["_Bool"] = to_class(BoolClass, self.purple_bool)
        result["_Complex"] = to_class(Complex, self.complex)
        result["_Imaginery"] = to_class(Imaginery, self.imaginery)
        result["abstract"] = to_class(Abstract, self.abstract)
        result["alignas"] = to_class(Alignas, self.alignas)
        result["alignof"] = to_class(Alignof, self.alignof)
        result["and"] = to_class(And, self.obj1_and)
        result["and_eq"] = to_class(AndEq, self.and_eq)
        result["any"] = to_class(Obj1Any, self.obj1_any)
        result["array"] = to_class(Array, self.array)
        result["as"] = to_class(As, self.obj1_as)
        result["asm"] = to_class(ASM, self.asm)
        result["assert"] = to_class(Assert, self.obj1_assert)
        result["associatedtype"] = to_class(Associatedtype, self.associatedtype)
        result["associativity"] = to_class(Associativity, self.associativity)
        result["async"] = to_class(Async, self.obj1_async)
        result["atomic"] = to_class(Atomic, self.atomic)
        result["atomic_cancel"] = to_class(AtomicCancel, self.atomic_cancel)
        result["atomic_commit"] = to_class(AtomicCommit, self.atomic_commit)
        result["atomic_noexcept"] = to_class(AtomicNoexcept, self.atomic_noexcept)
        result["auto"] = to_class(Auto, self.auto)
        result["await"] = to_class(Await, self.obj1_await)
        result["base"] = to_class(Base, self.base)
        result["bitand"] = to_class(Bitand, self.bitand)
        result["bitor"] = to_class(Bitor, self.bitor)
        result["bool"] = to_class(Obj1Bool, self.fluffy_bool)
        result["boolean"] = to_class(Boolean, self.boolean)
        result["break"] = to_class(Break, self.obj1_break)
        result["bycopy"] = to_class(Bycopy, self.bycopy)
        result["byref"] = to_class(Byref, self.byref)
        result["byte"] = to_class(Byte, self.byte)
        result["case"] = to_class(Case, self.case)
        result["catch"] = to_class(Catch, self.catch)
        result["chan"] = to_class(Chan, self.chan)
        result["char"] = to_class(Char, self.char)
        result["char16_t"] = to_class(Char16T, self.char16_t)
        result["char32_t"] = to_class(Char32T, self.char32_t)
        result["checked"] = to_class(Checked, self.checked)
        result["class"] = to_class(ClassClass, self.purple_class)
        result["clone"] = to_class(Clone, self.clone)
        result["co_await"] = to_class(CoAwait, self.co_await)
        result["co_return"] = to_class(CoReturn, self.co_return)
        result["co_yield"] = to_class(CoYield, self.co_yield)
        result["compl"] = to_class(Compl, self.compl)
        result["concept"] = to_class(Concept, self.concept)
        result["console"] = to_class(Console, self.console)
        result["const"] = to_class(Const, self.const)
        result["const_cast"] = to_class(ConstCast, self.const_cast)
        result["constexpr"] = to_class(Constexpr, self.constexpr)
        result["constructor"] = to_class(Constructor, self.constructor)
        result["continue"] = to_class(Continue, self.obj1_continue)
        result["convenience"] = to_class(Convenience, self.convenience)
        result["convert"] = to_class(Convert, self.convert)
        result["converter"] = to_class(Converter, self.converter)
        result["dummy"] = from_int(self.dummy)
        return result


@dataclass
class CultureInfo:
    culture_info: int

    @staticmethod
    def from_dict(obj: Any) -> 'CultureInfo':
        assert isinstance(obj, dict)
        culture_info = from_int(obj["CultureInfo"])
        return CultureInfo(culture_info)

    def to_dict(self) -> dict:
        result: dict = {}
        result["CultureInfo"] = from_int(self.culture_info)
        return result


@dataclass
class Date:
    date: int

    @staticmethod
    def from_dict(obj: Any) -> 'Date':
        assert isinstance(obj, dict)
        date = from_int(obj["date"])
        return Date(date)

    def to_dict(self) -> dict:
        result: dict = {}
        result["date"] = from_int(self.date)
        return result


@dataclass
class DateFormatter:
    date_formatter: int

    @staticmethod
    def from_dict(obj: Any) -> 'DateFormatter':
        assert isinstance(obj, dict)
        date_formatter = from_int(obj["DateFormatter"])
        return DateFormatter(date_formatter)

    def to_dict(self) -> dict:
        result: dict = {}
        result["DateFormatter"] = from_int(self.date_formatter)
        return result


@dataclass
class DateOnly:
    date_only: int

    @staticmethod
    def from_dict(obj: Any) -> 'DateOnly':
        assert isinstance(obj, dict)
        date_only = from_int(obj["DateOnly"])
        return DateOnly(date_only)

    def to_dict(self) -> dict:
        result: dict = {}
        result["DateOnly"] = from_int(self.date_only)
        return result


@dataclass
class DateOnlyConverter:
    date_only_converter: int

    @staticmethod
    def from_dict(obj: Any) -> 'DateOnlyConverter':
        assert isinstance(obj, dict)
        date_only_converter = from_int(obj["DateOnlyConverter"])
        return DateOnlyConverter(date_only_converter)

    def to_dict(self) -> dict:
        result: dict = {}
        result["DateOnlyConverter"] = from_int(self.date_only_converter)
        return result


@dataclass
class DateParseHandling:
    date_parse_handling: int

    @staticmethod
    def from_dict(obj: Any) -> 'DateParseHandling':
        assert isinstance(obj, dict)
        date_parse_handling = from_int(obj["date_parse_handling"])
        return DateParseHandling(date_parse_handling)

    def to_dict(self) -> dict:
        result: dict = {}
        result["date_parse_handling"] = from_int(self.date_parse_handling)
        return result


@dataclass
class DateTime:
    date_time: datetime.datetime

    @staticmethod
    def from_dict(obj: Any) -> 'DateTime':
        assert isinstance(obj, dict)
        date_time = from_datetime(obj["DateTime"])
        return DateTime(date_time)

    def to_dict(self) -> dict:
        result: dict = {}
        result["DateTime"] = self.date_time.isoformat()
        return result


@dataclass
class DateTimeStyles:
    date_time_styles: int

    @staticmethod
    def from_dict(obj: Any) -> 'DateTimeStyles':
        assert isinstance(obj, dict)
        date_time_styles = from_int(obj["DateTimeStyles"])
        return DateTimeStyles(date_time_styles)

    def to_dict(self) -> dict:
        result: dict = {}
        result["DateTimeStyles"] = from_int(self.date_time_styles)
        return result


@dataclass
class Debugger:
    debugger: int

    @staticmethod
    def from_dict(obj: Any) -> 'Debugger':
        assert isinstance(obj, dict)
        debugger = from_int(obj["debugger"])
        return Debugger(debugger)

    def to_dict(self) -> dict:
        result: dict = {}
        result["debugger"] = from_int(self.debugger)
        return result


@dataclass
class Decimal:
    decimal: int

    @staticmethod
    def from_dict(obj: Any) -> 'Decimal':
        assert isinstance(obj, dict)
        decimal = from_int(obj["decimal"])
        return Decimal(decimal)

    def to_dict(self) -> dict:
        result: dict = {}
        result["decimal"] = from_int(self.decimal)
        return result


@dataclass
class Declare:
    declare: int

    @staticmethod
    def from_dict(obj: Any) -> 'Declare':
        assert isinstance(obj, dict)
        declare = from_int(obj["declare"])
        return Declare(declare)

    def to_dict(self) -> dict:
        result: dict = {}
        result["declare"] = from_int(self.declare)
        return result


@dataclass
class Decltype:
    decltype: int

    @staticmethod
    def from_dict(obj: Any) -> 'Decltype':
        assert isinstance(obj, dict)
        decltype = from_int(obj["decltype"])
        return Decltype(decltype)

    def to_dict(self) -> dict:
        result: dict = {}
        result["decltype"] = from_int(self.decltype)
        return result


@dataclass
class DecodeString:
    decode_string: int

    @staticmethod
    def from_dict(obj: Any) -> 'DecodeString':
        assert isinstance(obj, dict)
        decode_string = from_int(obj["decode_string"])
        return DecodeString(decode_string)

    def to_dict(self) -> dict:
        result: dict = {}
        result["decode_string"] = from_int(self.decode_string)
        return result


@dataclass
class Decoder:
    decoder: int

    @staticmethod
    def from_dict(obj: Any) -> 'Decoder':
        assert isinstance(obj, dict)
        decoder = from_int(obj["Decoder"])
        return Decoder(decoder)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Decoder"] = from_int(self.decoder)
        return result


@dataclass
class DecodingError:
    decoding_error: int

    @staticmethod
    def from_dict(obj: Any) -> 'DecodingError':
        assert isinstance(obj, dict)
        decoding_error = from_int(obj["DecodingError"])
        return DecodingError(decoding_error)

    def to_dict(self) -> dict:
        result: dict = {}
        result["DecodingError"] = from_int(self.decoding_error)
        return result


@dataclass
class Default:
    default: int

    @staticmethod
    def from_dict(obj: Any) -> 'Default':
        assert isinstance(obj, dict)
        default = from_int(obj["default"])
        return Default(default)

    def to_dict(self) -> dict:
        result: dict = {}
        result["default"] = from_int(self.default)
        return result


@dataclass
class Defer:
    defer: int

    @staticmethod
    def from_dict(obj: Any) -> 'Defer':
        assert isinstance(obj, dict)
        defer = from_int(obj["defer"])
        return Defer(defer)

    def to_dict(self) -> dict:
        result: dict = {}
        result["defer"] = from_int(self.defer)
        return result


@dataclass
class Deinit:
    deinit: int

    @staticmethod
    def from_dict(obj: Any) -> 'Deinit':
        assert isinstance(obj, dict)
        deinit = from_int(obj["deinit"])
        return Deinit(deinit)

    def to_dict(self) -> dict:
        result: dict = {}
        result["deinit"] = from_int(self.deinit)
        return result


@dataclass
class Delegate:
    delegate: int

    @staticmethod
    def from_dict(obj: Any) -> 'Delegate':
        assert isinstance(obj, dict)
        delegate = from_int(obj["delegate"])
        return Delegate(delegate)

    def to_dict(self) -> dict:
        result: dict = {}
        result["delegate"] = from_int(self.delegate)
        return result


@dataclass
class Delete:
    delete: int

    @staticmethod
    def from_dict(obj: Any) -> 'Delete':
        assert isinstance(obj, dict)
        delete = from_int(obj["delete"])
        return Delete(delete)

    def to_dict(self) -> dict:
        result: dict = {}
        result["delete"] = from_int(self.delete)
        return result


@dataclass
class DeserializationFeature:
    deserialization_feature: int

    @staticmethod
    def from_dict(obj: Any) -> 'DeserializationFeature':
        assert isinstance(obj, dict)
        deserialization_feature = from_int(obj["DeserializationFeature"])
        return DeserializationFeature(deserialization_feature)

    def to_dict(self) -> dict:
        result: dict = {}
        result["DeserializationFeature"] = from_int(self.deserialization_feature)
        return result


@dataclass
class Dictionary:
    dictionary: int

    @staticmethod
    def from_dict(obj: Any) -> 'Dictionary':
        assert isinstance(obj, dict)
        dictionary = from_int(obj["dictionary"])
        return Dictionary(dictionary)

    def to_dict(self) -> dict:
        result: dict = {}
        result["dictionary"] = from_int(self.dictionary)
        return result


@dataclass
class DidSet:
    did_set: int

    @staticmethod
    def from_dict(obj: Any) -> 'DidSet':
        assert isinstance(obj, dict)
        did_set = from_int(obj["didSet"])
        return DidSet(did_set)

    def to_dict(self) -> dict:
        result: dict = {}
        result["didSet"] = from_int(self.did_set)
        return result


@dataclass
class Do:
    do: int

    @staticmethod
    def from_dict(obj: Any) -> 'Do':
        assert isinstance(obj, dict)
        do = from_int(obj["do"])
        return Do(do)

    def to_dict(self) -> dict:
        result: dict = {}
        result["do"] = from_int(self.do)
        return result


@dataclass
class Double:
    double: int

    @staticmethod
    def from_dict(obj: Any) -> 'Double':
        assert isinstance(obj, dict)
        double = from_int(obj["double"])
        return Double(double)

    def to_dict(self) -> dict:
        result: dict = {}
        result["double"] = from_int(self.double)
        return result


@dataclass
class DoubleNode:
    double_node: int

    @staticmethod
    def from_dict(obj: Any) -> 'DoubleNode':
        assert isinstance(obj, dict)
        double_node = from_int(obj["DoubleNode"])
        return DoubleNode(double_node)

    def to_dict(self) -> dict:
        result: dict = {}
        result["DoubleNode"] = from_int(self.double_node)
        return result


@dataclass
class Dynamic:
    dynamic: int

    @staticmethod
    def from_dict(obj: Any) -> 'Dynamic':
        assert isinstance(obj, dict)
        dynamic = from_int(obj["dynamic"])
        return Dynamic(dynamic)

    def to_dict(self) -> dict:
        result: dict = {}
        result["dynamic"] = from_int(self.dynamic)
        return result


@dataclass
class DynamicCast:
    dynamic_cast: int

    @staticmethod
    def from_dict(obj: Any) -> 'DynamicCast':
        assert isinstance(obj, dict)
        dynamic_cast = from_int(obj["dynamic_cast"])
        return DynamicCast(dynamic_cast)

    def to_dict(self) -> dict:
        result: dict = {}
        result["dynamic_cast"] = from_int(self.dynamic_cast)
        return result


@dataclass
class EncodeQuickType:
    encode_quick_type: int

    @staticmethod
    def from_dict(obj: Any) -> 'EncodeQuickType':
        assert isinstance(obj, dict)
        encode_quick_type = from_int(obj["encode_quick_type"])
        return EncodeQuickType(encode_quick_type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["encode_quick_type"] = from_int(self.encode_quick_type)
        return result


@dataclass
class Encoder:
    encoder: int

    @staticmethod
    def from_dict(obj: Any) -> 'Encoder':
        assert isinstance(obj, dict)
        encoder = from_int(obj["Encoder"])
        return Encoder(encoder)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Encoder"] = from_int(self.encoder)
        return result


@dataclass
class EnumClass:
    enum: int

    @staticmethod
    def from_dict(obj: Any) -> 'EnumClass':
        assert isinstance(obj, dict)
        enum = from_int(obj["enum"])
        return EnumClass(enum)

    def to_dict(self) -> dict:
        result: dict = {}
        result["enum"] = from_int(self.enum)
        return result


class EnumValue(Enum):
    READY = "ready"
    DONE = "done"


@dataclass
class EnumValues:
    enum_values: list[EnumValue]

    @staticmethod
    def from_dict(obj: Any) -> 'EnumValues':
        assert isinstance(obj, dict)
        enum_values = from_list(EnumValue, obj["EnumValues"])
        return EnumValues(enum_values)

    def to_dict(self) -> dict:
        result: dict = {}
        result["EnumValues"] = from_list(lambda x: to_enum(EnumValue, x), self.enum_values)
        return result


@dataclass
class EqualityContract:
    equality_contract: int

    @staticmethod
    def from_dict(obj: Any) -> 'EqualityContract':
        assert isinstance(obj, dict)
        equality_contract = from_int(obj["equalityContract"])
        return EqualityContract(equality_contract)

    def to_dict(self) -> dict:
        result: dict = {}
        result["equalityContract"] = from_int(self.equality_contract)
        return result


@dataclass
class Equatable:
    equatable: int

    @staticmethod
    def from_dict(obj: Any) -> 'Equatable':
        assert isinstance(obj, dict)
        equatable = from_int(obj["Equatable"])
        return Equatable(equatable)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Equatable"] = from_int(self.equatable)
        return result


@dataclass
class Event:
    event: int

    @staticmethod
    def from_dict(obj: Any) -> 'Event':
        assert isinstance(obj, dict)
        event = from_int(obj["event"])
        return Event(event)

    def to_dict(self) -> dict:
        result: dict = {}
        result["event"] = from_int(self.event)
        return result


@dataclass
class Exception:
    exception: int

    @staticmethod
    def from_dict(obj: Any) -> 'Exception':
        assert isinstance(obj, dict)
        exception = from_int(obj["exception"])
        return Exception(exception)

    def to_dict(self) -> dict:
        result: dict = {}
        result["exception"] = from_int(self.exception)
        return result


@dataclass
class Explicit:
    explicit: int

    @staticmethod
    def from_dict(obj: Any) -> 'Explicit':
        assert isinstance(obj, dict)
        explicit = from_int(obj["explicit"])
        return Explicit(explicit)

    def to_dict(self) -> dict:
        result: dict = {}
        result["explicit"] = from_int(self.explicit)
        return result


@dataclass
class Export:
    export: int

    @staticmethod
    def from_dict(obj: Any) -> 'Export':
        assert isinstance(obj, dict)
        export = from_int(obj["export"])
        return Export(export)

    def to_dict(self) -> dict:
        result: dict = {}
        result["export"] = from_int(self.export)
        return result


@dataclass
class Exposing:
    exposing: int

    @staticmethod
    def from_dict(obj: Any) -> 'Exposing':
        assert isinstance(obj, dict)
        exposing = from_int(obj["exposing"])
        return Exposing(exposing)

    def to_dict(self) -> dict:
        result: dict = {}
        result["exposing"] = from_int(self.exposing)
        return result


@dataclass
class Extends:
    extends: int

    @staticmethod
    def from_dict(obj: Any) -> 'Extends':
        assert isinstance(obj, dict)
        extends = from_int(obj["extends"])
        return Extends(extends)

    def to_dict(self) -> dict:
        result: dict = {}
        result["extends"] = from_int(self.extends)
        return result


@dataclass
class Extension:
    extension: int

    @staticmethod
    def from_dict(obj: Any) -> 'Extension':
        assert isinstance(obj, dict)
        extension = from_int(obj["extension"])
        return Extension(extension)

    def to_dict(self) -> dict:
        result: dict = {}
        result["extension"] = from_int(self.extension)
        return result


@dataclass
class Extern:
    extern: int

    @staticmethod
    def from_dict(obj: Any) -> 'Extern':
        assert isinstance(obj, dict)
        extern = from_int(obj["extern"])
        return Extern(extern)

    def to_dict(self) -> dict:
        result: dict = {}
        result["extern"] = from_int(self.extern)
        return result


@dataclass
class Fallthrough:
    fallthrough: int

    @staticmethod
    def from_dict(obj: Any) -> 'Fallthrough':
        assert isinstance(obj, dict)
        fallthrough = from_int(obj["fallthrough"])
        return Fallthrough(fallthrough)

    def to_dict(self) -> dict:
        result: dict = {}
        result["fallthrough"] = from_int(self.fallthrough)
        return result


@dataclass
class FalseClass:
    false: int

    @staticmethod
    def from_dict(obj: Any) -> 'FalseClass':
        assert isinstance(obj, dict)
        false = from_int(obj["False"])
        return FalseClass(false)

    def to_dict(self) -> dict:
        result: dict = {}
        result["False"] = from_int(self.false)
        return result


@dataclass
class Fileprivate:
    fileprivate: int

    @staticmethod
    def from_dict(obj: Any) -> 'Fileprivate':
        assert isinstance(obj, dict)
        fileprivate = from_int(obj["fileprivate"])
        return Fileprivate(fileprivate)

    def to_dict(self) -> dict:
        result: dict = {}
        result["fileprivate"] = from_int(self.fileprivate)
        return result


@dataclass
class Final:
    final: int

    @staticmethod
    def from_dict(obj: Any) -> 'Final':
        assert isinstance(obj, dict)
        final = from_int(obj["final"])
        return Final(final)

    def to_dict(self) -> dict:
        result: dict = {}
        result["final"] = from_int(self.final)
        return result


@dataclass
class Fixed:
    fixed: int

    @staticmethod
    def from_dict(obj: Any) -> 'Fixed':
        assert isinstance(obj, dict)
        fixed = from_int(obj["fixed"])
        return Fixed(fixed)

    def to_dict(self) -> dict:
        result: dict = {}
        result["fixed"] = from_int(self.fixed)
        return result


@dataclass
class Foreach:
    foreach: int

    @staticmethod
    def from_dict(obj: Any) -> 'Foreach':
        assert isinstance(obj, dict)
        foreach = from_int(obj["foreach"])
        return Foreach(foreach)

    def to_dict(self) -> dict:
        result: dict = {}
        result["foreach"] = from_int(self.foreach)
        return result


@dataclass
class FormatException:
    format_exception: int

    @staticmethod
    def from_dict(obj: Any) -> 'FormatException':
        assert isinstance(obj, dict)
        format_exception = from_int(obj["FormatException"])
        return FormatException(format_exception)

    def to_dict(self) -> dict:
        result: dict = {}
        result["FormatException"] = from_int(self.format_exception)
        return result


@dataclass
class Friend:
    friend: int

    @staticmethod
    def from_dict(obj: Any) -> 'Friend':
        assert isinstance(obj, dict)
        friend = from_int(obj["friend"])
        return Friend(friend)

    def to_dict(self) -> dict:
        result: dict = {}
        result["friend"] = from_int(self.friend)
        return result


@dataclass
class FromJSON:
    from_json: int

    @staticmethod
    def from_dict(obj: Any) -> 'FromJSON':
        assert isinstance(obj, dict)
        from_json = from_int(obj["from_json"])
        return FromJSON(from_json)

    def to_dict(self) -> dict:
        result: dict = {}
        result["from_json"] = from_int(self.from_json)
        return result


@dataclass
class Func:
    func: int

    @staticmethod
    def from_dict(obj: Any) -> 'Func':
        assert isinstance(obj, dict)
        func = from_int(obj["func"])
        return Func(func)

    def to_dict(self) -> dict:
        result: dict = {}
        result["func"] = from_int(self.func)
        return result


@dataclass
class Def:
    def_def: int

    @staticmethod
    def from_dict(obj: Any) -> 'Def':
        assert isinstance(obj, dict)
        def_def = from_int(obj["def"])
        return Def(def_def)

    def to_dict(self) -> dict:
        result: dict = {}
        result["def"] = from_int(self.def_def)
        return result


@dataclass
class Del:
    del_del: int

    @staticmethod
    def from_dict(obj: Any) -> 'Del':
        assert isinstance(obj, dict)
        del_del = from_int(obj["del"])
        return Del(del_del)

    def to_dict(self) -> dict:
        result: dict = {}
        result["del"] = from_int(self.del_del)
        return result


@dataclass
class DictClass:
    dict_dict: int

    @staticmethod
    def from_dict(obj: Any) -> 'DictClass':
        assert isinstance(obj, dict)
        dict_dict = from_int(obj["dict"])
        return DictClass(dict_dict)

    def to_dict(self) -> dict:
        result: dict = {}
        result["dict"] = from_int(self.dict_dict)
        return result


@dataclass
class Elif:
    elif_elif: int

    @staticmethod
    def from_dict(obj: Any) -> 'Elif':
        assert isinstance(obj, dict)
        elif_elif = from_int(obj["elif"])
        return Elif(elif_elif)

    def to_dict(self) -> dict:
        result: dict = {}
        result["elif"] = from_int(self.elif_elif)
        return result


@dataclass
class Else:
    else_else: int

    @staticmethod
    def from_dict(obj: Any) -> 'Else':
        assert isinstance(obj, dict)
        else_else = from_int(obj["else"])
        return Else(else_else)

    def to_dict(self) -> dict:
        result: dict = {}
        result["else"] = from_int(self.else_else)
        return result


@dataclass
class Except:
    except_except: int

    @staticmethod
    def from_dict(obj: Any) -> 'Except':
        assert isinstance(obj, dict)
        except_except = from_int(obj["except"])
        return Except(except_except)

    def to_dict(self) -> dict:
        result: dict = {}
        result["except"] = from_int(self.except_except)
        return result


@dataclass
class Obj2False:
    false: int

    @staticmethod
    def from_dict(obj: Any) -> 'Obj2False':
        assert isinstance(obj, dict)
        false = from_int(obj["false"])
        return Obj2False(false)

    def to_dict(self) -> dict:
        result: dict = {}
        result["false"] = from_int(self.false)
        return result


@dataclass
class Finally:
    finally_finally: int

    @staticmethod
    def from_dict(obj: Any) -> 'Finally':
        assert isinstance(obj, dict)
        finally_finally = from_int(obj["finally"])
        return Finally(finally_finally)

    def to_dict(self) -> dict:
        result: dict = {}
        result["finally"] = from_int(self.finally_finally)
        return result


@dataclass
class Float:
    float_float: int

    @staticmethod
    def from_dict(obj: Any) -> 'Float':
        assert isinstance(obj, dict)
        float_float = from_int(obj["float"])
        return Float(float_float)

    def to_dict(self) -> dict:
        result: dict = {}
        result["float"] = from_int(self.float_float)
        return result


@dataclass
class For:
    for_for: int

    @staticmethod
    def from_dict(obj: Any) -> 'For':
        assert isinstance(obj, dict)
        for_for = from_int(obj["for"])
        return For(for_for)

    def to_dict(self) -> dict:
        result: dict = {}
        result["for"] = from_int(self.for_for)
        return result


@dataclass
class From:
    from_from: int

    @staticmethod
    def from_dict(obj: Any) -> 'From':
        assert isinstance(obj, dict)
        from_from = from_int(obj["from"])
        return From(from_from)

    def to_dict(self) -> dict:
        result: dict = {}
        result["from"] = from_int(self.from_from)
        return result


@dataclass
class FromDict:
    from_dict_from_dict: int

    @staticmethod
    def from_dict(obj: Any) -> 'FromDict':
        assert isinstance(obj, dict)
        from_dict_from_dict = from_int(obj["from_dict"])
        return FromDict(from_dict_from_dict)

    def to_dict(self) -> dict:
        result: dict = {}
        result["from_dict"] = from_int(self.from_dict_from_dict)
        return result


@dataclass
class Obj2:
    culture_info: CultureInfo
    date_formatter: DateFormatter
    date_only: DateOnly
    date_only_converter: DateOnlyConverter
    date_time: DateTime
    date_time_styles: DateTimeStyles
    decoder: Decoder
    decoding_error: DecodingError
    deserialization_feature: DeserializationFeature
    double_node: DoubleNode
    encoder: Encoder
    enum_values: EnumValues
    equatable: Equatable
    false: FalseClass
    format_exception: FormatException
    date: Date
    date_parse_handling: DateParseHandling
    debugger: Debugger
    decimal: Decimal
    declare: Declare
    decltype: Decltype
    decode_string: DecodeString
    obj2_def: Def
    default: Default
    defer: Defer
    deinit: Deinit
    obj2_del: Del
    delegate: Delegate
    delete: Delete
    obj2_dict: DictClass
    dictionary: Dictionary
    did_set: DidSet
    do: Do
    double: Double
    dummy: int
    dynamic: Dynamic
    dynamic_cast: DynamicCast
    obj2_elif: Elif
    obj2_else: Else
    encode_quick_type: EncodeQuickType
    enum: EnumClass
    equality_contract: EqualityContract
    event: Event
    obj2_except: Except
    exception: Exception
    explicit: Explicit
    export: Export
    exposing: Exposing
    extends: Extends
    extension: Extension
    extern: Extern
    fallthrough: Fallthrough
    obj2_false: Obj2False
    fileprivate: Fileprivate
    final: Final
    obj2_finally: Finally
    fixed: Fixed
    obj2_float: Float
    obj2_for: For
    foreach: Foreach
    friend: Friend
    obj2_from: From
    obj2_from_dict: FromDict
    from_json: FromJSON
    func: Func

    @staticmethod
    def from_dict(obj: Any) -> 'Obj2':
        assert isinstance(obj, dict)
        culture_info = CultureInfo.from_dict(obj["CultureInfo"])
        date_formatter = DateFormatter.from_dict(obj["DateFormatter"])
        date_only = DateOnly.from_dict(obj["DateOnly"])
        date_only_converter = DateOnlyConverter.from_dict(obj["DateOnlyConverter"])
        date_time = DateTime.from_dict(obj["DateTime"])
        date_time_styles = DateTimeStyles.from_dict(obj["DateTimeStyles"])
        decoder = Decoder.from_dict(obj["Decoder"])
        decoding_error = DecodingError.from_dict(obj["DecodingError"])
        deserialization_feature = DeserializationFeature.from_dict(obj["DeserializationFeature"])
        double_node = DoubleNode.from_dict(obj["DoubleNode"])
        encoder = Encoder.from_dict(obj["Encoder"])
        enum_values = EnumValues.from_dict(obj["EnumValues"])
        equatable = Equatable.from_dict(obj["Equatable"])
        false = FalseClass.from_dict(obj["False"])
        format_exception = FormatException.from_dict(obj["FormatException"])
        date = Date.from_dict(obj["date"])
        date_parse_handling = DateParseHandling.from_dict(obj["date_parse_handling"])
        debugger = Debugger.from_dict(obj["debugger"])
        decimal = Decimal.from_dict(obj["decimal"])
        declare = Declare.from_dict(obj["declare"])
        decltype = Decltype.from_dict(obj["decltype"])
        decode_string = DecodeString.from_dict(obj["decode_string"])
        obj2_def = Def.from_dict(obj["def"])
        default = Default.from_dict(obj["default"])
        defer = Defer.from_dict(obj["defer"])
        deinit = Deinit.from_dict(obj["deinit"])
        obj2_del = Del.from_dict(obj["del"])
        delegate = Delegate.from_dict(obj["delegate"])
        delete = Delete.from_dict(obj["delete"])
        obj2_dict = DictClass.from_dict(obj["dict"])
        dictionary = Dictionary.from_dict(obj["dictionary"])
        did_set = DidSet.from_dict(obj["didSet"])
        do = Do.from_dict(obj["do"])
        double = Double.from_dict(obj["double"])
        dummy = from_int(obj["dummy"])
        dynamic = Dynamic.from_dict(obj["dynamic"])
        dynamic_cast = DynamicCast.from_dict(obj["dynamic_cast"])
        obj2_elif = Elif.from_dict(obj["elif"])
        obj2_else = Else.from_dict(obj["else"])
        encode_quick_type = EncodeQuickType.from_dict(obj["encode_quick_type"])
        enum = EnumClass.from_dict(obj["enum"])
        equality_contract = EqualityContract.from_dict(obj["equalityContract"])
        event = Event.from_dict(obj["event"])
        obj2_except = Except.from_dict(obj["except"])
        exception = Exception.from_dict(obj["exception"])
        explicit = Explicit.from_dict(obj["explicit"])
        export = Export.from_dict(obj["export"])
        exposing = Exposing.from_dict(obj["exposing"])
        extends = Extends.from_dict(obj["extends"])
        extension = Extension.from_dict(obj["extension"])
        extern = Extern.from_dict(obj["extern"])
        fallthrough = Fallthrough.from_dict(obj["fallthrough"])
        obj2_false = Obj2False.from_dict(obj["false"])
        fileprivate = Fileprivate.from_dict(obj["fileprivate"])
        final = Final.from_dict(obj["final"])
        obj2_finally = Finally.from_dict(obj["finally"])
        fixed = Fixed.from_dict(obj["fixed"])
        obj2_float = Float.from_dict(obj["float"])
        obj2_for = For.from_dict(obj["for"])
        foreach = Foreach.from_dict(obj["foreach"])
        friend = Friend.from_dict(obj["friend"])
        obj2_from = From.from_dict(obj["from"])
        obj2_from_dict = FromDict.from_dict(obj["from_dict"])
        from_json = FromJSON.from_dict(obj["from_json"])
        func = Func.from_dict(obj["func"])
        return Obj2(culture_info, date_formatter, date_only, date_only_converter, date_time, date_time_styles, decoder, decoding_error, deserialization_feature, double_node, encoder, enum_values, equatable, false, format_exception, date, date_parse_handling, debugger, decimal, declare, decltype, decode_string, obj2_def, default, defer, deinit, obj2_del, delegate, delete, obj2_dict, dictionary, did_set, do, double, dummy, dynamic, dynamic_cast, obj2_elif, obj2_else, encode_quick_type, enum, equality_contract, event, obj2_except, exception, explicit, export, exposing, extends, extension, extern, fallthrough, obj2_false, fileprivate, final, obj2_finally, fixed, obj2_float, obj2_for, foreach, friend, obj2_from, obj2_from_dict, from_json, func)

    def to_dict(self) -> dict:
        result: dict = {}
        result["CultureInfo"] = to_class(CultureInfo, self.culture_info)
        result["DateFormatter"] = to_class(DateFormatter, self.date_formatter)
        result["DateOnly"] = to_class(DateOnly, self.date_only)
        result["DateOnlyConverter"] = to_class(DateOnlyConverter, self.date_only_converter)
        result["DateTime"] = to_class(DateTime, self.date_time)
        result["DateTimeStyles"] = to_class(DateTimeStyles, self.date_time_styles)
        result["Decoder"] = to_class(Decoder, self.decoder)
        result["DecodingError"] = to_class(DecodingError, self.decoding_error)
        result["DeserializationFeature"] = to_class(DeserializationFeature, self.deserialization_feature)
        result["DoubleNode"] = to_class(DoubleNode, self.double_node)
        result["Encoder"] = to_class(Encoder, self.encoder)
        result["EnumValues"] = to_class(EnumValues, self.enum_values)
        result["Equatable"] = to_class(Equatable, self.equatable)
        result["False"] = to_class(FalseClass, self.false)
        result["FormatException"] = to_class(FormatException, self.format_exception)
        result["date"] = to_class(Date, self.date)
        result["date_parse_handling"] = to_class(DateParseHandling, self.date_parse_handling)
        result["debugger"] = to_class(Debugger, self.debugger)
        result["decimal"] = to_class(Decimal, self.decimal)
        result["declare"] = to_class(Declare, self.declare)
        result["decltype"] = to_class(Decltype, self.decltype)
        result["decode_string"] = to_class(DecodeString, self.decode_string)
        result["def"] = to_class(Def, self.obj2_def)
        result["default"] = to_class(Default, self.default)
        result["defer"] = to_class(Defer, self.defer)
        result["deinit"] = to_class(Deinit, self.deinit)
        result["del"] = to_class(Del, self.obj2_del)
        result["delegate"] = to_class(Delegate, self.delegate)
        result["delete"] = to_class(Delete, self.delete)
        result["dict"] = to_class(DictClass, self.obj2_dict)
        result["dictionary"] = to_class(Dictionary, self.dictionary)
        result["didSet"] = to_class(DidSet, self.did_set)
        result["do"] = to_class(Do, self.do)
        result["double"] = to_class(Double, self.double)
        result["dummy"] = from_int(self.dummy)
        result["dynamic"] = to_class(Dynamic, self.dynamic)
        result["dynamic_cast"] = to_class(DynamicCast, self.dynamic_cast)
        result["elif"] = to_class(Elif, self.obj2_elif)
        result["else"] = to_class(Else, self.obj2_else)
        result["encode_quick_type"] = to_class(EncodeQuickType, self.encode_quick_type)
        result["enum"] = to_class(EnumClass, self.enum)
        result["equalityContract"] = to_class(EqualityContract, self.equality_contract)
        result["event"] = to_class(Event, self.event)
        result["except"] = to_class(Except, self.obj2_except)
        result["exception"] = to_class(Exception, self.exception)
        result["explicit"] = to_class(Explicit, self.explicit)
        result["export"] = to_class(Export, self.export)
        result["exposing"] = to_class(Exposing, self.exposing)
        result["extends"] = to_class(Extends, self.extends)
        result["extension"] = to_class(Extension, self.extension)
        result["extern"] = to_class(Extern, self.extern)
        result["fallthrough"] = to_class(Fallthrough, self.fallthrough)
        result["false"] = to_class(Obj2False, self.obj2_false)
        result["fileprivate"] = to_class(Fileprivate, self.fileprivate)
        result["final"] = to_class(Final, self.final)
        result["finally"] = to_class(Finally, self.obj2_finally)
        result["fixed"] = to_class(Fixed, self.fixed)
        result["float"] = to_class(Float, self.obj2_float)
        result["for"] = to_class(For, self.obj2_for)
        result["foreach"] = to_class(Foreach, self.foreach)
        result["friend"] = to_class(Friend, self.friend)
        result["from"] = to_class(From, self.obj2_from)
        result["from_dict"] = to_class(FromDict, self.obj2_from_dict)
        result["from_json"] = to_class(FromJSON, self.from_json)
        result["func"] = to_class(Func, self.func)
        return result


@dataclass
class Function:
    function: int

    @staticmethod
    def from_dict(obj: Any) -> 'Function':
        assert isinstance(obj, dict)
        function = from_int(obj["function"])
        return Function(function)

    def to_dict(self) -> dict:
        result: dict = {}
        result["function"] = from_int(self.function)
        return result


@dataclass
class Get:
    get: int

    @staticmethod
    def from_dict(obj: Any) -> 'Get':
        assert isinstance(obj, dict)
        get = from_int(obj["get"])
        return Get(get)

    def to_dict(self) -> dict:
        result: dict = {}
        result["get"] = from_int(self.get)
        return result


@dataclass
class Go:
    go: int

    @staticmethod
    def from_dict(obj: Any) -> 'Go':
        assert isinstance(obj, dict)
        go = from_int(obj["go"])
        return Go(go)

    def to_dict(self) -> dict:
        result: dict = {}
        result["go"] = from_int(self.go)
        return result


@dataclass
class Goto:
    goto: int

    @staticmethod
    def from_dict(obj: Any) -> 'Goto':
        assert isinstance(obj, dict)
        goto = from_int(obj["goto"])
        return Goto(goto)

    def to_dict(self) -> dict:
        result: dict = {}
        result["goto"] = from_int(self.goto)
        return result


@dataclass
class Guard:
    guard: int

    @staticmethod
    def from_dict(obj: Any) -> 'Guard':
        assert isinstance(obj, dict)
        guard = from_int(obj["guard"])
        return Guard(guard)

    def to_dict(self) -> dict:
        result: dict = {}
        result["guard"] = from_int(self.guard)
        return result


@dataclass
class HasOwnProperty:
    has_own_property: int

    @staticmethod
    def from_dict(obj: Any) -> 'HasOwnProperty':
        assert isinstance(obj, dict)
        has_own_property = from_int(obj["hasOwnProperty"])
        return HasOwnProperty(has_own_property)

    def to_dict(self) -> dict:
        result: dict = {}
        result["hasOwnProperty"] = from_int(self.has_own_property)
        return result


@dataclass
class HashCode:
    hash_code: int

    @staticmethod
    def from_dict(obj: Any) -> 'HashCode':
        assert isinstance(obj, dict)
        hash_code = from_int(obj["hashCode"])
        return HashCode(hash_code)

    def to_dict(self) -> dict:
        result: dict = {}
        result["hashCode"] = from_int(self.hash_code)
        return result


@dataclass
class Hashable:
    hashable: int

    @staticmethod
    def from_dict(obj: Any) -> 'Hashable':
        assert isinstance(obj, dict)
        hashable = from_int(obj["Hashable"])
        return Hashable(hashable)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Hashable"] = from_int(self.hashable)
        return result


@dataclass
class Hasher:
    hasher: int

    @staticmethod
    def from_dict(obj: Any) -> 'Hasher':
        assert isinstance(obj, dict)
        hasher = from_int(obj["Hasher"])
        return Hasher(hasher)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Hasher"] = from_int(self.hasher)
        return result


@dataclass
class ID:
    id: int

    @staticmethod
    def from_dict(obj: Any) -> 'ID':
        assert isinstance(obj, dict)
        id = from_int(obj["id"])
        return ID(id)

    def to_dict(self) -> dict:
        result: dict = {}
        result["id"] = from_int(self.id)
        return result


@dataclass
class Imp:
    imp: int

    @staticmethod
    def from_dict(obj: Any) -> 'Imp':
        assert isinstance(obj, dict)
        imp = from_int(obj["IMP"])
        return Imp(imp)

    def to_dict(self) -> dict:
        result: dict = {}
        result["IMP"] = from_int(self.imp)
        return result


@dataclass
class Implements:
    implements: int

    @staticmethod
    def from_dict(obj: Any) -> 'Implements':
        assert isinstance(obj, dict)
        implements = from_int(obj["implements"])
        return Implements(implements)

    def to_dict(self) -> dict:
        result: dict = {}
        result["implements"] = from_int(self.implements)
        return result


@dataclass
class Implicit:
    implicit: int

    @staticmethod
    def from_dict(obj: Any) -> 'Implicit':
        assert isinstance(obj, dict)
        implicit = from_int(obj["implicit"])
        return Implicit(implicit)

    def to_dict(self) -> dict:
        result: dict = {}
        result["implicit"] = from_int(self.implicit)
        return result


@dataclass
class Indirect:
    indirect: int

    @staticmethod
    def from_dict(obj: Any) -> 'Indirect':
        assert isinstance(obj, dict)
        indirect = from_int(obj["indirect"])
        return Indirect(indirect)

    def to_dict(self) -> dict:
        result: dict = {}
        result["indirect"] = from_int(self.indirect)
        return result


@dataclass
class Infix:
    infix: int

    @staticmethod
    def from_dict(obj: Any) -> 'Infix':
        assert isinstance(obj, dict)
        infix = from_int(obj["infix"])
        return Infix(infix)

    def to_dict(self) -> dict:
        result: dict = {}
        result["infix"] = from_int(self.infix)
        return result


@dataclass
class Init:
    init: int

    @staticmethod
    def from_dict(obj: Any) -> 'Init':
        assert isinstance(obj, dict)
        init = from_int(obj["init"])
        return Init(init)

    def to_dict(self) -> dict:
        result: dict = {}
        result["init"] = from_int(self.init)
        return result


@dataclass
class Inline:
    inline: int

    @staticmethod
    def from_dict(obj: Any) -> 'Inline':
        assert isinstance(obj, dict)
        inline = from_int(obj["inline"])
        return Inline(inline)

    def to_dict(self) -> dict:
        result: dict = {}
        result["inline"] = from_int(self.inline)
        return result


@dataclass
class Inout:
    inout: int

    @staticmethod
    def from_dict(obj: Any) -> 'Inout':
        assert isinstance(obj, dict)
        inout = from_int(obj["inout"])
        return Inout(inout)

    def to_dict(self) -> dict:
        result: dict = {}
        result["inout"] = from_int(self.inout)
        return result


@dataclass
class Instanceof:
    instanceof: int

    @staticmethod
    def from_dict(obj: Any) -> 'Instanceof':
        assert isinstance(obj, dict)
        instanceof = from_int(obj["instanceof"])
        return Instanceof(instanceof)

    def to_dict(self) -> dict:
        result: dict = {}
        result["instanceof"] = from_int(self.instanceof)
        return result


@dataclass
class IntNode:
    int_node: int

    @staticmethod
    def from_dict(obj: Any) -> 'IntNode':
        assert isinstance(obj, dict)
        int_node = from_int(obj["IntNode"])
        return IntNode(int_node)

    def to_dict(self) -> dict:
        result: dict = {}
        result["IntNode"] = from_int(self.int_node)
        return result


@dataclass
class Interface:
    interface: int

    @staticmethod
    def from_dict(obj: Any) -> 'Interface':
        assert isinstance(obj, dict)
        interface = from_int(obj["interface"])
        return Interface(interface)

    def to_dict(self) -> dict:
        result: dict = {}
        result["interface"] = from_int(self.interface)
        return result


@dataclass
class Internal:
    internal: int

    @staticmethod
    def from_dict(obj: Any) -> 'Internal':
        assert isinstance(obj, dict)
        internal = from_int(obj["internal"])
        return Internal(internal)

    def to_dict(self) -> dict:
        result: dict = {}
        result["internal"] = from_int(self.internal)
        return result


@dataclass
class ISODateTimeOffsetConverter:
    iso_date_time_offset_converter: int

    @staticmethod
    def from_dict(obj: Any) -> 'ISODateTimeOffsetConverter':
        assert isinstance(obj, dict)
        iso_date_time_offset_converter = from_int(obj["IsoDateTimeOffsetConverter"])
        return ISODateTimeOffsetConverter(iso_date_time_offset_converter)

    def to_dict(self) -> dict:
        result: dict = {}
        result["IsoDateTimeOffsetConverter"] = from_int(self.iso_date_time_offset_converter)
        return result


@dataclass
class IterableClass:
    iterable: int

    @staticmethod
    def from_dict(obj: Any) -> 'IterableClass':
        assert isinstance(obj, dict)
        iterable = from_int(obj["iterable"])
        return IterableClass(iterable)

    def to_dict(self) -> dict:
        result: dict = {}
        result["iterable"] = from_int(self.iterable)
        return result


@dataclass
class Jdec:
    jdec: int

    @staticmethod
    def from_dict(obj: Any) -> 'Jdec':
        assert isinstance(obj, dict)
        jdec = from_int(obj["jdec"])
        return Jdec(jdec)

    def to_dict(self) -> dict:
        result: dict = {}
        result["jdec"] = from_int(self.jdec)
        return result


@dataclass
class Jenc:
    jenc: int

    @staticmethod
    def from_dict(obj: Any) -> 'Jenc':
        assert isinstance(obj, dict)
        jenc = from_int(obj["jenc"])
        return Jenc(jenc)

    def to_dict(self) -> dict:
        result: dict = {}
        result["jenc"] = from_int(self.jenc)
        return result


@dataclass
class Jpipe:
    jpipe: int

    @staticmethod
    def from_dict(obj: Any) -> 'Jpipe':
        assert isinstance(obj, dict)
        jpipe = from_int(obj["jpipe"])
        return Jpipe(jpipe)

    def to_dict(self) -> dict:
        result: dict = {}
        result["jpipe"] = from_int(self.jpipe)
        return result


@dataclass
class JSON:
    json: int

    @staticmethod
    def from_dict(obj: Any) -> 'JSON':
        assert isinstance(obj, dict)
        json = from_int(obj["json"])
        return JSON(json)

    def to_dict(self) -> dict:
        result: dict = {}
        result["json"] = from_int(self.json)
        return result


@dataclass
class JSONAny:
    json_any: None

    @staticmethod
    def from_dict(obj: Any) -> 'JSONAny':
        assert isinstance(obj, dict)
        json_any = from_none(obj["JSONAny"])
        return JSONAny(json_any)

    def to_dict(self) -> dict:
        result: dict = {}
        result["JSONAny"] = from_none(self.json_any)
        return result


@dataclass
class JSONCodingKey:
    json_coding_key: int

    @staticmethod
    def from_dict(obj: Any) -> 'JSONCodingKey':
        assert isinstance(obj, dict)
        json_coding_key = from_int(obj["JSONCodingKey"])
        return JSONCodingKey(json_coding_key)

    def to_dict(self) -> dict:
        result: dict = {}
        result["JSONCodingKey"] = from_int(self.json_coding_key)
        return result


@dataclass
class JSONConverter:
    json_converter: int

    @staticmethod
    def from_dict(obj: Any) -> 'JSONConverter':
        assert isinstance(obj, dict)
        json_converter = from_int(obj["json_converter"])
        return JSONConverter(json_converter)

    def to_dict(self) -> dict:
        result: dict = {}
        result["json_converter"] = from_int(self.json_converter)
        return result


@dataclass
class JSONDecoder:
    json_decoder: int

    @staticmethod
    def from_dict(obj: Any) -> 'JSONDecoder':
        assert isinstance(obj, dict)
        json_decoder = from_int(obj["JSONDecoder"])
        return JSONDecoder(json_decoder)

    def to_dict(self) -> dict:
        result: dict = {}
        result["JSONDecoder"] = from_int(self.json_decoder)
        return result


@dataclass
class JSONEncoder:
    json_encoder: int

    @staticmethod
    def from_dict(obj: Any) -> 'JSONEncoder':
        assert isinstance(obj, dict)
        json_encoder = from_int(obj["JSONEncoder"])
        return JSONEncoder(json_encoder)

    def to_dict(self) -> dict:
        result: dict = {}
        result["JSONEncoder"] = from_int(self.json_encoder)
        return result


@dataclass
class JSONException:
    json_exception: int

    @staticmethod
    def from_dict(obj: Any) -> 'JSONException':
        assert isinstance(obj, dict)
        json_exception = from_int(obj["JsonException"])
        return JSONException(json_exception)

    def to_dict(self) -> dict:
        result: dict = {}
        result["JsonException"] = from_int(self.json_exception)
        return result


@dataclass
class JSONGenerator:
    json_generator: int

    @staticmethod
    def from_dict(obj: Any) -> 'JSONGenerator':
        assert isinstance(obj, dict)
        json_generator = from_int(obj["JsonGenerator"])
        return JSONGenerator(json_generator)

    def to_dict(self) -> dict:
        result: dict = {}
        result["JsonGenerator"] = from_int(self.json_generator)
        return result


@dataclass
class JSONNode:
    json_node: int

    @staticmethod
    def from_dict(obj: Any) -> 'JSONNode':
        assert isinstance(obj, dict)
        json_node = from_int(obj["JsonNode"])
        return JSONNode(json_node)

    def to_dict(self) -> dict:
        result: dict = {}
        result["JsonNode"] = from_int(self.json_node)
        return result


@dataclass
class JSONNull:
    json_null: int

    @staticmethod
    def from_dict(obj: Any) -> 'JSONNull':
        assert isinstance(obj, dict)
        json_null = from_int(obj["JSONNull"])
        return JSONNull(json_null)

    def to_dict(self) -> dict:
        result: dict = {}
        result["JSONNull"] = from_int(self.json_null)
        return result


@dataclass
class JSONParser:
    json_parser: int

    @staticmethod
    def from_dict(obj: Any) -> 'JSONParser':
        assert isinstance(obj, dict)
        json_parser = from_int(obj["JsonParser"])
        return JSONParser(json_parser)

    def to_dict(self) -> dict:
        result: dict = {}
        result["JsonParser"] = from_int(self.json_parser)
        return result


@dataclass
class JSONReader:
    json_reader: int

    @staticmethod
    def from_dict(obj: Any) -> 'JSONReader':
        assert isinstance(obj, dict)
        json_reader = from_int(obj["JsonReader"])
        return JSONReader(json_reader)

    def to_dict(self) -> dict:
        result: dict = {}
        result["JsonReader"] = from_int(self.json_reader)
        return result


@dataclass
class JSONSerializer:
    json_serializer: int

    @staticmethod
    def from_dict(obj: Any) -> 'JSONSerializer':
        assert isinstance(obj, dict)
        json_serializer = from_int(obj["json_serializer"])
        return JSONSerializer(json_serializer)

    def to_dict(self) -> dict:
        result: dict = {}
        result["json_serializer"] = from_int(self.json_serializer)
        return result


@dataclass
class JSONToken:
    json_token: int

    @staticmethod
    def from_dict(obj: Any) -> 'JSONToken':
        assert isinstance(obj, dict)
        json_token = from_int(obj["json_token"])
        return JSONToken(json_token)

    def to_dict(self) -> dict:
        result: dict = {}
        result["json_token"] = from_int(self.json_token)
        return result


@dataclass
class JSONTokenType:
    json_token_type: int

    @staticmethod
    def from_dict(obj: Any) -> 'JSONTokenType':
        assert isinstance(obj, dict)
        json_token_type = from_int(obj["JsonTokenType"])
        return JSONTokenType(json_token_type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["JsonTokenType"] = from_int(self.json_token_type)
        return result


@dataclass
class JSONWriter:
    json_writer: int

    @staticmethod
    def from_dict(obj: Any) -> 'JSONWriter':
        assert isinstance(obj, dict)
        json_writer = from_int(obj["json_writer"])
        return JSONWriter(json_writer)

    def to_dict(self) -> dict:
        result: dict = {}
        result["json_writer"] = from_int(self.json_writer)
        return result


@dataclass
class Lazy:
    lazy: int

    @staticmethod
    def from_dict(obj: Any) -> 'Lazy':
        assert isinstance(obj, dict)
        lazy = from_int(obj["lazy"])
        return Lazy(lazy)

    def to_dict(self) -> dict:
        result: dict = {}
        result["lazy"] = from_int(self.lazy)
        return result


@dataclass
class Left:
    left: int

    @staticmethod
    def from_dict(obj: Any) -> 'Left':
        assert isinstance(obj, dict)
        left = from_int(obj["left"])
        return Left(left)

    def to_dict(self) -> dict:
        result: dict = {}
        result["left"] = from_int(self.left)
        return result


@dataclass
class Let:
    let: int

    @staticmethod
    def from_dict(obj: Any) -> 'Let':
        assert isinstance(obj, dict)
        let = from_int(obj["let"])
        return Let(let)

    def to_dict(self) -> dict:
        result: dict = {}
        result["let"] = from_int(self.let)
        return result


@dataclass
class ListClass:
    list: int

    @staticmethod
    def from_dict(obj: Any) -> 'ListClass':
        assert isinstance(obj, dict)
        list = from_int(obj["list"])
        return ListClass(list)

    def to_dict(self) -> dict:
        result: dict = {}
        result["list"] = from_int(self.list)
        return result


@dataclass
class LocalDate:
    local_date: int

    @staticmethod
    def from_dict(obj: Any) -> 'LocalDate':
        assert isinstance(obj, dict)
        local_date = from_int(obj["LocalDate"])
        return LocalDate(local_date)

    def to_dict(self) -> dict:
        result: dict = {}
        result["LocalDate"] = from_int(self.local_date)
        return result


@dataclass
class Locale:
    locale: int

    @staticmethod
    def from_dict(obj: Any) -> 'Locale':
        assert isinstance(obj, dict)
        locale = from_int(obj["Locale"])
        return Locale(locale)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Locale"] = from_int(self.locale)
        return result


@dataclass
class Lock:
    lock: int

    @staticmethod
    def from_dict(obj: Any) -> 'Lock':
        assert isinstance(obj, dict)
        lock = from_int(obj["lock"])
        return Lock(lock)

    def to_dict(self) -> dict:
        result: dict = {}
        result["lock"] = from_int(self.lock)
        return result


@dataclass
class Long:
    long: int

    @staticmethod
    def from_dict(obj: Any) -> 'Long':
        assert isinstance(obj, dict)
        long = from_int(obj["long"])
        return Long(long)

    def to_dict(self) -> dict:
        result: dict = {}
        result["long"] = from_int(self.long)
        return result


@dataclass
class LongNode:
    long_node: int

    @staticmethod
    def from_dict(obj: Any) -> 'LongNode':
        assert isinstance(obj, dict)
        long_node = from_int(obj["LongNode"])
        return LongNode(long_node)

    def to_dict(self) -> dict:
        result: dict = {}
        result["LongNode"] = from_int(self.long_node)
        return result


@dataclass
class Map:
    map: int

    @staticmethod
    def from_dict(obj: Any) -> 'Map':
        assert isinstance(obj, dict)
        map = from_int(obj["map"])
        return Map(map)

    def to_dict(self) -> dict:
        result: dict = {}
        result["map"] = from_int(self.map)
        return result


@dataclass
class MapEntry:
    map_entry: int

    @staticmethod
    def from_dict(obj: Any) -> 'MapEntry':
        assert isinstance(obj, dict)
        map_entry = from_int(obj["MapEntry"])
        return MapEntry(map_entry)

    def to_dict(self) -> dict:
        result: dict = {}
        result["MapEntry"] = from_int(self.map_entry)
        return result


@dataclass
class MarshalJSON:
    marshal_json: int

    @staticmethod
    def from_dict(obj: Any) -> 'MarshalJSON':
        assert isinstance(obj, dict)
        marshal_json = from_int(obj["MarshalJSON"])
        return MarshalJSON(marshal_json)

    def to_dict(self) -> dict:
        result: dict = {}
        result["MarshalJSON"] = from_int(self.marshal_json)
        return result


@dataclass
class MetadataPropertyHandling:
    metadata_property_handling: int

    @staticmethod
    def from_dict(obj: Any) -> 'MetadataPropertyHandling':
        assert isinstance(obj, dict)
        metadata_property_handling = from_int(obj["metadata_property_handling"])
        return MetadataPropertyHandling(metadata_property_handling)

    def to_dict(self) -> dict:
        result: dict = {}
        result["metadata_property_handling"] = from_int(self.metadata_property_handling)
        return result


@dataclass
class Module:
    module: int

    @staticmethod
    def from_dict(obj: Any) -> 'Module':
        assert isinstance(obj, dict)
        module = from_int(obj["module"])
        return Module(module)

    def to_dict(self) -> dict:
        result: dict = {}
        result["module"] = from_int(self.module)
        return result


@dataclass
class Global:
    global_global: int

    @staticmethod
    def from_dict(obj: Any) -> 'Global':
        assert isinstance(obj, dict)
        global_global = from_int(obj["global"])
        return Global(global_global)

    def to_dict(self) -> dict:
        result: dict = {}
        result["global"] = from_int(self.global_global)
        return result


@dataclass
class If:
    if_if: int

    @staticmethod
    def from_dict(obj: Any) -> 'If':
        assert isinstance(obj, dict)
        if_if = from_int(obj["if"])
        return If(if_if)

    def to_dict(self) -> dict:
        result: dict = {}
        result["if"] = from_int(self.if_if)
        return result


@dataclass
class Import:
    import_import: int

    @staticmethod
    def from_dict(obj: Any) -> 'Import':
        assert isinstance(obj, dict)
        import_import = from_int(obj["import"])
        return Import(import_import)

    def to_dict(self) -> dict:
        result: dict = {}
        result["import"] = from_int(self.import_import)
        return result


@dataclass
class In:
    in_in: int

    @staticmethod
    def from_dict(obj: Any) -> 'In':
        assert isinstance(obj, dict)
        in_in = from_int(obj["in"])
        return In(in_in)

    def to_dict(self) -> dict:
        result: dict = {}
        result["in"] = from_int(self.in_in)
        return result


@dataclass
class Int:
    int_int: int

    @staticmethod
    def from_dict(obj: Any) -> 'Int':
        assert isinstance(obj, dict)
        int_int = from_int(obj["int"])
        return Int(int_int)

    def to_dict(self) -> dict:
        result: dict = {}
        result["int"] = from_int(self.int_int)
        return result


@dataclass
class Is:
    is_is: int

    @staticmethod
    def from_dict(obj: Any) -> 'Is':
        assert isinstance(obj, dict)
        is_is = from_int(obj["is"])
        return Is(is_is)

    def to_dict(self) -> dict:
        result: dict = {}
        result["is"] = from_int(self.is_is)
        return result


@dataclass
class Lambda:
    lambda_lambda: int

    @staticmethod
    def from_dict(obj: Any) -> 'Lambda':
        assert isinstance(obj, dict)
        lambda_lambda = from_int(obj["lambda"])
        return Lambda(lambda_lambda)

    def to_dict(self) -> dict:
        result: dict = {}
        result["lambda"] = from_int(self.lambda_lambda)
        return result


@dataclass
class Obj3:
    hashable: Hashable
    hasher: Hasher
    imp: Imp
    int_node: IntNode
    iso_date_time_offset_converter: ISODateTimeOffsetConverter
    json_any: JSONAny
    json_coding_key: JSONCodingKey
    json_decoder: JSONDecoder
    json_encoder: JSONEncoder
    json_null: JSONNull
    json_exception: JSONException
    json_generator: JSONGenerator
    json_node: JSONNode
    json_parser: JSONParser
    json_reader: JSONReader
    json_token_type: JSONTokenType
    local_date: LocalDate
    locale: Locale
    long_node: LongNode
    map_entry: MapEntry
    marshal_json: MarshalJSON
    dummy: int
    function: Function
    get: Get
    obj3_global: Global
    go: Go
    goto: Goto
    guard: Guard
    has_own_property: HasOwnProperty
    hash_code: HashCode
    id: ID
    obj3_if: If
    implements: Implements
    implicit: Implicit
    obj3_import: Import
    obj3_in: In
    indirect: Indirect
    infix: Infix
    init: Init
    inline: Inline
    inout: Inout
    instanceof: Instanceof
    obj3_int: Int
    interface: Interface
    internal: Internal
    obj3_is: Is
    iterable: IterableClass
    jdec: Jdec
    jenc: Jenc
    jpipe: Jpipe
    json: JSON
    json_converter: JSONConverter
    json_serializer: JSONSerializer
    json_token: JSONToken
    json_writer: JSONWriter
    obj3_lambda: Lambda
    lazy: Lazy
    left: Left
    let: Let
    list: ListClass
    lock: Lock
    long: Long
    map: Map
    metadata_property_handling: MetadataPropertyHandling
    module: Module

    @staticmethod
    def from_dict(obj: Any) -> 'Obj3':
        assert isinstance(obj, dict)
        hashable = Hashable.from_dict(obj["Hashable"])
        hasher = Hasher.from_dict(obj["Hasher"])
        imp = Imp.from_dict(obj["IMP"])
        int_node = IntNode.from_dict(obj["IntNode"])
        iso_date_time_offset_converter = ISODateTimeOffsetConverter.from_dict(obj["IsoDateTimeOffsetConverter"])
        json_any = JSONAny.from_dict(obj["JSONAny"])
        json_coding_key = JSONCodingKey.from_dict(obj["JSONCodingKey"])
        json_decoder = JSONDecoder.from_dict(obj["JSONDecoder"])
        json_encoder = JSONEncoder.from_dict(obj["JSONEncoder"])
        json_null = JSONNull.from_dict(obj["JSONNull"])
        json_exception = JSONException.from_dict(obj["JsonException"])
        json_generator = JSONGenerator.from_dict(obj["JsonGenerator"])
        json_node = JSONNode.from_dict(obj["JsonNode"])
        json_parser = JSONParser.from_dict(obj["JsonParser"])
        json_reader = JSONReader.from_dict(obj["JsonReader"])
        json_token_type = JSONTokenType.from_dict(obj["JsonTokenType"])
        local_date = LocalDate.from_dict(obj["LocalDate"])
        locale = Locale.from_dict(obj["Locale"])
        long_node = LongNode.from_dict(obj["LongNode"])
        map_entry = MapEntry.from_dict(obj["MapEntry"])
        marshal_json = MarshalJSON.from_dict(obj["MarshalJSON"])
        dummy = from_int(obj["dummy"])
        function = Function.from_dict(obj["function"])
        get = Get.from_dict(obj["get"])
        obj3_global = Global.from_dict(obj["global"])
        go = Go.from_dict(obj["go"])
        goto = Goto.from_dict(obj["goto"])
        guard = Guard.from_dict(obj["guard"])
        has_own_property = HasOwnProperty.from_dict(obj["hasOwnProperty"])
        hash_code = HashCode.from_dict(obj["hashCode"])
        id = ID.from_dict(obj["id"])
        obj3_if = If.from_dict(obj["if"])
        implements = Implements.from_dict(obj["implements"])
        implicit = Implicit.from_dict(obj["implicit"])
        obj3_import = Import.from_dict(obj["import"])
        obj3_in = In.from_dict(obj["in"])
        indirect = Indirect.from_dict(obj["indirect"])
        infix = Infix.from_dict(obj["infix"])
        init = Init.from_dict(obj["init"])
        inline = Inline.from_dict(obj["inline"])
        inout = Inout.from_dict(obj["inout"])
        instanceof = Instanceof.from_dict(obj["instanceof"])
        obj3_int = Int.from_dict(obj["int"])
        interface = Interface.from_dict(obj["interface"])
        internal = Internal.from_dict(obj["internal"])
        obj3_is = Is.from_dict(obj["is"])
        iterable = IterableClass.from_dict(obj["iterable"])
        jdec = Jdec.from_dict(obj["jdec"])
        jenc = Jenc.from_dict(obj["jenc"])
        jpipe = Jpipe.from_dict(obj["jpipe"])
        json = JSON.from_dict(obj["json"])
        json_converter = JSONConverter.from_dict(obj["json_converter"])
        json_serializer = JSONSerializer.from_dict(obj["json_serializer"])
        json_token = JSONToken.from_dict(obj["json_token"])
        json_writer = JSONWriter.from_dict(obj["json_writer"])
        obj3_lambda = Lambda.from_dict(obj["lambda"])
        lazy = Lazy.from_dict(obj["lazy"])
        left = Left.from_dict(obj["left"])
        let = Let.from_dict(obj["let"])
        list = ListClass.from_dict(obj["list"])
        lock = Lock.from_dict(obj["lock"])
        long = Long.from_dict(obj["long"])
        map = Map.from_dict(obj["map"])
        metadata_property_handling = MetadataPropertyHandling.from_dict(obj["metadata_property_handling"])
        module = Module.from_dict(obj["module"])
        return Obj3(hashable, hasher, imp, int_node, iso_date_time_offset_converter, json_any, json_coding_key, json_decoder, json_encoder, json_null, json_exception, json_generator, json_node, json_parser, json_reader, json_token_type, local_date, locale, long_node, map_entry, marshal_json, dummy, function, get, obj3_global, go, goto, guard, has_own_property, hash_code, id, obj3_if, implements, implicit, obj3_import, obj3_in, indirect, infix, init, inline, inout, instanceof, obj3_int, interface, internal, obj3_is, iterable, jdec, jenc, jpipe, json, json_converter, json_serializer, json_token, json_writer, obj3_lambda, lazy, left, let, list, lock, long, map, metadata_property_handling, module)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Hashable"] = to_class(Hashable, self.hashable)
        result["Hasher"] = to_class(Hasher, self.hasher)
        result["IMP"] = to_class(Imp, self.imp)
        result["IntNode"] = to_class(IntNode, self.int_node)
        result["IsoDateTimeOffsetConverter"] = to_class(ISODateTimeOffsetConverter, self.iso_date_time_offset_converter)
        result["JSONAny"] = to_class(JSONAny, self.json_any)
        result["JSONCodingKey"] = to_class(JSONCodingKey, self.json_coding_key)
        result["JSONDecoder"] = to_class(JSONDecoder, self.json_decoder)
        result["JSONEncoder"] = to_class(JSONEncoder, self.json_encoder)
        result["JSONNull"] = to_class(JSONNull, self.json_null)
        result["JsonException"] = to_class(JSONException, self.json_exception)
        result["JsonGenerator"] = to_class(JSONGenerator, self.json_generator)
        result["JsonNode"] = to_class(JSONNode, self.json_node)
        result["JsonParser"] = to_class(JSONParser, self.json_parser)
        result["JsonReader"] = to_class(JSONReader, self.json_reader)
        result["JsonTokenType"] = to_class(JSONTokenType, self.json_token_type)
        result["LocalDate"] = to_class(LocalDate, self.local_date)
        result["Locale"] = to_class(Locale, self.locale)
        result["LongNode"] = to_class(LongNode, self.long_node)
        result["MapEntry"] = to_class(MapEntry, self.map_entry)
        result["MarshalJSON"] = to_class(MarshalJSON, self.marshal_json)
        result["dummy"] = from_int(self.dummy)
        result["function"] = to_class(Function, self.function)
        result["get"] = to_class(Get, self.get)
        result["global"] = to_class(Global, self.obj3_global)
        result["go"] = to_class(Go, self.go)
        result["goto"] = to_class(Goto, self.goto)
        result["guard"] = to_class(Guard, self.guard)
        result["hasOwnProperty"] = to_class(HasOwnProperty, self.has_own_property)
        result["hashCode"] = to_class(HashCode, self.hash_code)
        result["id"] = to_class(ID, self.id)
        result["if"] = to_class(If, self.obj3_if)
        result["implements"] = to_class(Implements, self.implements)
        result["implicit"] = to_class(Implicit, self.implicit)
        result["import"] = to_class(Import, self.obj3_import)
        result["in"] = to_class(In, self.obj3_in)
        result["indirect"] = to_class(Indirect, self.indirect)
        result["infix"] = to_class(Infix, self.infix)
        result["init"] = to_class(Init, self.init)
        result["inline"] = to_class(Inline, self.inline)
        result["inout"] = to_class(Inout, self.inout)
        result["instanceof"] = to_class(Instanceof, self.instanceof)
        result["int"] = to_class(Int, self.obj3_int)
        result["interface"] = to_class(Interface, self.interface)
        result["internal"] = to_class(Internal, self.internal)
        result["is"] = to_class(Is, self.obj3_is)
        result["iterable"] = to_class(IterableClass, self.iterable)
        result["jdec"] = to_class(Jdec, self.jdec)
        result["jenc"] = to_class(Jenc, self.jenc)
        result["jpipe"] = to_class(Jpipe, self.jpipe)
        result["json"] = to_class(JSON, self.json)
        result["json_converter"] = to_class(JSONConverter, self.json_converter)
        result["json_serializer"] = to_class(JSONSerializer, self.json_serializer)
        result["json_token"] = to_class(JSONToken, self.json_token)
        result["json_writer"] = to_class(JSONWriter, self.json_writer)
        result["lambda"] = to_class(Lambda, self.obj3_lambda)
        result["lazy"] = to_class(Lazy, self.lazy)
        result["left"] = to_class(Left, self.left)
        result["let"] = to_class(Let, self.let)
        result["list"] = to_class(ListClass, self.list)
        result["lock"] = to_class(Lock, self.lock)
        result["long"] = to_class(Long, self.long)
        result["map"] = to_class(Map, self.map)
        result["metadata_property_handling"] = to_class(MetadataPropertyHandling, self.metadata_property_handling)
        result["module"] = to_class(Module, self.module)
        return result


@dataclass
class Mutable:
    mutable: int

    @staticmethod
    def from_dict(obj: Any) -> 'Mutable':
        assert isinstance(obj, dict)
        mutable = from_int(obj["mutable"])
        return Mutable(mutable)

    def to_dict(self) -> dict:
        result: dict = {}
        result["mutable"] = from_int(self.mutable)
        return result


@dataclass
class Mutating:
    mutating: int

    @staticmethod
    def from_dict(obj: Any) -> 'Mutating':
        assert isinstance(obj, dict)
        mutating = from_int(obj["mutating"])
        return Mutating(mutating)

    def to_dict(self) -> dict:
        result: dict = {}
        result["mutating"] = from_int(self.mutating)
        return result


@dataclass
class Namespace:
    namespace: int

    @staticmethod
    def from_dict(obj: Any) -> 'Namespace':
        assert isinstance(obj, dict)
        namespace = from_int(obj["namespace"])
        return Namespace(namespace)

    def to_dict(self) -> dict:
        result: dict = {}
        result["namespace"] = from_int(self.namespace)
        return result


@dataclass
class Native:
    native: int

    @staticmethod
    def from_dict(obj: Any) -> 'Native':
        assert isinstance(obj, dict)
        native = from_int(obj["native"])
        return Native(native)

    def to_dict(self) -> dict:
        result: dict = {}
        result["native"] = from_int(self.native)
        return result


@dataclass
class New:
    new: int

    @staticmethod
    def from_dict(obj: Any) -> 'New':
        assert isinstance(obj, dict)
        new = from_int(obj["new"])
        return New(new)

    def to_dict(self) -> dict:
        result: dict = {}
        result["new"] = from_int(self.new)
        return result


@dataclass
class Newtonsoft:
    newtonsoft: int

    @staticmethod
    def from_dict(obj: Any) -> 'Newtonsoft':
        assert isinstance(obj, dict)
        newtonsoft = from_int(obj["newtonsoft"])
        return Newtonsoft(newtonsoft)

    def to_dict(self) -> dict:
        result: dict = {}
        result["newtonsoft"] = from_int(self.newtonsoft)
        return result


@dataclass
class Nil:
    nil: int

    @staticmethod
    def from_dict(obj: Any) -> 'Nil':
        assert isinstance(obj, dict)
        nil = from_int(obj["nil"])
        return Nil(nil)

    def to_dict(self) -> dict:
        result: dict = {}
        result["nil"] = from_int(self.nil)
        return result


@dataclass
class No:
    no: int

    @staticmethod
    def from_dict(obj: Any) -> 'No':
        assert isinstance(obj, dict)
        no = from_int(obj["NO"])
        return No(no)

    def to_dict(self) -> dict:
        result: dict = {}
        result["NO"] = from_int(self.no)
        return result


@dataclass
class NoSuchMethod:
    no_such_method: int

    @staticmethod
    def from_dict(obj: Any) -> 'NoSuchMethod':
        assert isinstance(obj, dict)
        no_such_method = from_int(obj["noSuchMethod"])
        return NoSuchMethod(no_such_method)

    def to_dict(self) -> dict:
        result: dict = {}
        result["noSuchMethod"] = from_int(self.no_such_method)
        return result


@dataclass
class Noexcept:
    noexcept: int

    @staticmethod
    def from_dict(obj: Any) -> 'Noexcept':
        assert isinstance(obj, dict)
        noexcept = from_int(obj["noexcept"])
        return Noexcept(noexcept)

    def to_dict(self) -> dict:
        result: dict = {}
        result["noexcept"] = from_int(self.noexcept)
        return result


@dataclass
class Nonatomic:
    nonatomic: int

    @staticmethod
    def from_dict(obj: Any) -> 'Nonatomic':
        assert isinstance(obj, dict)
        nonatomic = from_int(obj["nonatomic"])
        return Nonatomic(nonatomic)

    def to_dict(self) -> dict:
        result: dict = {}
        result["nonatomic"] = from_int(self.nonatomic)
        return result


@dataclass
class NoneClass:
    none: int

    @staticmethod
    def from_dict(obj: Any) -> 'NoneClass':
        assert isinstance(obj, dict)
        none = from_int(obj["None"])
        return NoneClass(none)

    def to_dict(self) -> dict:
        result: dict = {}
        result["None"] = from_int(self.none)
        return result


@dataclass
class Nonmutating:
    nonmutating: int

    @staticmethod
    def from_dict(obj: Any) -> 'Nonmutating':
        assert isinstance(obj, dict)
        nonmutating = from_int(obj["nonmutating"])
        return Nonmutating(nonmutating)

    def to_dict(self) -> dict:
        result: dict = {}
        result["nonmutating"] = from_int(self.nonmutating)
        return result


@dataclass
class NotEq:
    not_eq: int

    @staticmethod
    def from_dict(obj: Any) -> 'NotEq':
        assert isinstance(obj, dict)
        not_eq = from_int(obj["not_eq"])
        return NotEq(not_eq)

    def to_dict(self) -> dict:
        result: dict = {}
        result["not_eq"] = from_int(self.not_eq)
        return result


@dataclass
class NSError:
    ns_error: int

    @staticmethod
    def from_dict(obj: Any) -> 'NSError':
        assert isinstance(obj, dict)
        ns_error = from_int(obj["NSError"])
        return NSError(ns_error)

    def to_dict(self) -> dict:
        result: dict = {}
        result["NSError"] = from_int(self.ns_error)
        return result


@dataclass
class NSObject:
    ns_object: int

    @staticmethod
    def from_dict(obj: Any) -> 'NSObject':
        assert isinstance(obj, dict)
        ns_object = from_int(obj["NSObject"])
        return NSObject(ns_object)

    def to_dict(self) -> dict:
        result: dict = {}
        result["NSObject"] = from_int(self.ns_object)
        return result


@dataclass
class NSString:
    ns_string: int

    @staticmethod
    def from_dict(obj: Any) -> 'NSString':
        assert isinstance(obj, dict)
        ns_string = from_int(obj["NSString"])
        return NSString(ns_string)

    def to_dict(self) -> dict:
        result: dict = {}
        result["NSString"] = from_int(self.ns_string)
        return result


@dataclass
class Null:
    null: int

    @staticmethod
    def from_dict(obj: Any) -> 'Null':
        assert isinstance(obj, dict)
        null = from_int(obj["NULL"])
        return Null(null)

    def to_dict(self) -> dict:
        result: dict = {}
        result["NULL"] = from_int(self.null)
        return result


@dataclass
class NullNode:
    null_node: int

    @staticmethod
    def from_dict(obj: Any) -> 'NullNode':
        assert isinstance(obj, dict)
        null_node = from_int(obj["NullNode"])
        return NullNode(null_node)

    def to_dict(self) -> dict:
        result: dict = {}
        result["NullNode"] = from_int(self.null_node)
        return result


@dataclass
class Nullptr:
    nullptr: int

    @staticmethod
    def from_dict(obj: Any) -> 'Nullptr':
        assert isinstance(obj, dict)
        nullptr = from_int(obj["nullptr"])
        return Nullptr(nullptr)

    def to_dict(self) -> dict:
        result: dict = {}
        result["nullptr"] = from_int(self.nullptr)
        return result


@dataclass
class Number:
    number: int

    @staticmethod
    def from_dict(obj: Any) -> 'Number':
        assert isinstance(obj, dict)
        number = from_int(obj["number"])
        return Number(number)

    def to_dict(self) -> dict:
        result: dict = {}
        result["number"] = from_int(self.number)
        return result


@dataclass
class Obj4None:
    none: int

    @staticmethod
    def from_dict(obj: Any) -> 'Obj4None':
        assert isinstance(obj, dict)
        none = from_int(obj["none"])
        return Obj4None(none)

    def to_dict(self) -> dict:
        result: dict = {}
        result["none"] = from_int(self.none)
        return result


@dataclass
class Nonlocal:
    nonlocal_nonlocal: int

    @staticmethod
    def from_dict(obj: Any) -> 'Nonlocal':
        assert isinstance(obj, dict)
        nonlocal_nonlocal = from_int(obj["nonlocal"])
        return Nonlocal(nonlocal_nonlocal)

    def to_dict(self) -> dict:
        result: dict = {}
        result["nonlocal"] = from_int(self.nonlocal_nonlocal)
        return result


@dataclass
class Not:
    not_not: int

    @staticmethod
    def from_dict(obj: Any) -> 'Not':
        assert isinstance(obj, dict)
        not_not = from_int(obj["not"])
        return Not(not_not)

    def to_dict(self) -> dict:
        result: dict = {}
        result["not"] = from_int(self.not_not)
        return result


@dataclass
class NullClass:
    null: int

    @staticmethod
    def from_dict(obj: Any) -> 'NullClass':
        assert isinstance(obj, dict)
        null = from_int(obj["null"])
        return NullClass(null)

    def to_dict(self) -> dict:
        result: dict = {}
        result["null"] = from_int(self.null)
        return result


@dataclass
class Or:
    or_or: int

    @staticmethod
    def from_dict(obj: Any) -> 'Or':
        assert isinstance(obj, dict)
        or_or = from_int(obj["or"])
        return Or(or_or)

    def to_dict(self) -> dict:
        result: dict = {}
        result["or"] = from_int(self.or_or)
        return result


@dataclass
class Pass:
    pass_pass: int

    @staticmethod
    def from_dict(obj: Any) -> 'Pass':
        assert isinstance(obj, dict)
        pass_pass = from_int(obj["pass"])
        return Pass(pass_pass)

    def to_dict(self) -> dict:
        result: dict = {}
        result["pass"] = from_int(self.pass_pass)
        return result


@dataclass
class Print:
    print_print: int

    @staticmethod
    def from_dict(obj: Any) -> 'Print':
        assert isinstance(obj, dict)
        print_print = from_int(obj["print"])
        return Print(print_print)

    def to_dict(self) -> dict:
        result: dict = {}
        result["print"] = from_int(self.print_print)
        return result


@dataclass
class ProtocolClass:
    protocol: int

    @staticmethod
    def from_dict(obj: Any) -> 'ProtocolClass':
        assert isinstance(obj, dict)
        protocol = from_int(obj["protocol"])
        return ProtocolClass(protocol)

    def to_dict(self) -> dict:
        result: dict = {}
        result["protocol"] = from_int(self.protocol)
        return result


@dataclass
class Raise:
    raise_raise: int

    @staticmethod
    def from_dict(obj: Any) -> 'Raise':
        assert isinstance(obj, dict)
        raise_raise = from_int(obj["raise"])
        return Raise(raise_raise)

    def to_dict(self) -> dict:
        result: dict = {}
        result["raise"] = from_int(self.raise_raise)
        return result


@dataclass
class Object:
    object: int

    @staticmethod
    def from_dict(obj: Any) -> 'Object':
        assert isinstance(obj, dict)
        object = from_int(obj["object"])
        return Object(object)

    def to_dict(self) -> dict:
        result: dict = {}
        result["object"] = from_int(self.object)
        return result


@dataclass
class ObjectMapper:
    object_mapper: int

    @staticmethod
    def from_dict(obj: Any) -> 'ObjectMapper':
        assert isinstance(obj, dict)
        object_mapper = from_int(obj["ObjectMapper"])
        return ObjectMapper(object_mapper)

    def to_dict(self) -> dict:
        result: dict = {}
        result["ObjectMapper"] = from_int(self.object_mapper)
        return result


@dataclass
class ObjectNode:
    object_node: int

    @staticmethod
    def from_dict(obj: Any) -> 'ObjectNode':
        assert isinstance(obj, dict)
        object_node = from_int(obj["ObjectNode"])
        return ObjectNode(object_node)

    def to_dict(self) -> dict:
        result: dict = {}
        result["ObjectNode"] = from_int(self.object_node)
        return result


@dataclass
class ObjectReader:
    object_reader: int

    @staticmethod
    def from_dict(obj: Any) -> 'ObjectReader':
        assert isinstance(obj, dict)
        object_reader = from_int(obj["ObjectReader"])
        return ObjectReader(object_reader)

    def to_dict(self) -> dict:
        result: dict = {}
        result["ObjectReader"] = from_int(self.object_reader)
        return result


@dataclass
class ObjectWriter:
    object_writer: int

    @staticmethod
    def from_dict(obj: Any) -> 'ObjectWriter':
        assert isinstance(obj, dict)
        object_writer = from_int(obj["ObjectWriter"])
        return ObjectWriter(object_writer)

    def to_dict(self) -> dict:
        result: dict = {}
        result["ObjectWriter"] = from_int(self.object_writer)
        return result


@dataclass
class Of:
    of: int

    @staticmethod
    def from_dict(obj: Any) -> 'Of':
        assert isinstance(obj, dict)
        of = from_int(obj["of"])
        return Of(of)

    def to_dict(self) -> dict:
        result: dict = {}
        result["of"] = from_int(self.of)
        return result


@dataclass
class OffsetDateTime:
    offset_date_time: int

    @staticmethod
    def from_dict(obj: Any) -> 'OffsetDateTime':
        assert isinstance(obj, dict)
        offset_date_time = from_int(obj["OffsetDateTime"])
        return OffsetDateTime(offset_date_time)

    def to_dict(self) -> dict:
        result: dict = {}
        result["OffsetDateTime"] = from_int(self.offset_date_time)
        return result


@dataclass
class OffsetTime:
    offset_time: int

    @staticmethod
    def from_dict(obj: Any) -> 'OffsetTime':
        assert isinstance(obj, dict)
        offset_time = from_int(obj["OffsetTime"])
        return OffsetTime(offset_time)

    def to_dict(self) -> dict:
        result: dict = {}
        result["OffsetTime"] = from_int(self.offset_time)
        return result


@dataclass
class Oneway:
    oneway: int

    @staticmethod
    def from_dict(obj: Any) -> 'Oneway':
        assert isinstance(obj, dict)
        oneway = from_int(obj["oneway"])
        return Oneway(oneway)

    def to_dict(self) -> dict:
        result: dict = {}
        result["oneway"] = from_int(self.oneway)
        return result


@dataclass
class Open:
    open: int

    @staticmethod
    def from_dict(obj: Any) -> 'Open':
        assert isinstance(obj, dict)
        open = from_int(obj["open"])
        return Open(open)

    def to_dict(self) -> dict:
        result: dict = {}
        result["open"] = from_int(self.open)
        return result


@dataclass
class Operator:
    operator: int

    @staticmethod
    def from_dict(obj: Any) -> 'Operator':
        assert isinstance(obj, dict)
        operator = from_int(obj["operator"])
        return Operator(operator)

    def to_dict(self) -> dict:
        result: dict = {}
        result["operator"] = from_int(self.operator)
        return result


@dataclass
class OptionalClass:
    optional: int

    @staticmethod
    def from_dict(obj: Any) -> 'OptionalClass':
        assert isinstance(obj, dict)
        optional = from_int(obj["optional"])
        return OptionalClass(optional)

    def to_dict(self) -> dict:
        result: dict = {}
        result["optional"] = from_int(self.optional)
        return result


@dataclass
class OrEq:
    or_eq: int

    @staticmethod
    def from_dict(obj: Any) -> 'OrEq':
        assert isinstance(obj, dict)
        or_eq = from_int(obj["or_eq"])
        return OrEq(or_eq)

    def to_dict(self) -> dict:
        result: dict = {}
        result["or_eq"] = from_int(self.or_eq)
        return result


@dataclass
class Out:
    out: int

    @staticmethod
    def from_dict(obj: Any) -> 'Out':
        assert isinstance(obj, dict)
        out = from_int(obj["out"])
        return Out(out)

    def to_dict(self) -> dict:
        result: dict = {}
        result["out"] = from_int(self.out)
        return result


@dataclass
class Override:
    override: int

    @staticmethod
    def from_dict(obj: Any) -> 'Override':
        assert isinstance(obj, dict)
        override = from_int(obj["override"])
        return Override(override)

    def to_dict(self) -> dict:
        result: dict = {}
        result["override"] = from_int(self.override)
        return result


@dataclass
class Package:
    package: int

    @staticmethod
    def from_dict(obj: Any) -> 'Package':
        assert isinstance(obj, dict)
        package = from_int(obj["package"])
        return Package(package)

    def to_dict(self) -> dict:
        result: dict = {}
        result["package"] = from_int(self.package)
        return result


@dataclass
class Params:
    params: int

    @staticmethod
    def from_dict(obj: Any) -> 'Params':
        assert isinstance(obj, dict)
        params = from_int(obj["params"])
        return Params(params)

    def to_dict(self) -> dict:
        result: dict = {}
        result["params"] = from_int(self.params)
        return result


@dataclass
class Port:
    port: int

    @staticmethod
    def from_dict(obj: Any) -> 'Port':
        assert isinstance(obj, dict)
        port = from_int(obj["port"])
        return Port(port)

    def to_dict(self) -> dict:
        result: dict = {}
        result["port"] = from_int(self.port)
        return result


@dataclass
class Postfix:
    postfix: int

    @staticmethod
    def from_dict(obj: Any) -> 'Postfix':
        assert isinstance(obj, dict)
        postfix = from_int(obj["postfix"])
        return Postfix(postfix)

    def to_dict(self) -> dict:
        result: dict = {}
        result["postfix"] = from_int(self.postfix)
        return result


@dataclass
class Precedence:
    precedence: int

    @staticmethod
    def from_dict(obj: Any) -> 'Precedence':
        assert isinstance(obj, dict)
        precedence = from_int(obj["precedence"])
        return Precedence(precedence)

    def to_dict(self) -> dict:
        result: dict = {}
        result["precedence"] = from_int(self.precedence)
        return result


@dataclass
class Prefix:
    prefix: int

    @staticmethod
    def from_dict(obj: Any) -> 'Prefix':
        assert isinstance(obj, dict)
        prefix = from_int(obj["prefix"])
        return Prefix(prefix)

    def to_dict(self) -> dict:
        result: dict = {}
        result["prefix"] = from_int(self.prefix)
        return result


@dataclass
class PrintMembers:
    print_members: int

    @staticmethod
    def from_dict(obj: Any) -> 'PrintMembers':
        assert isinstance(obj, dict)
        print_members = from_int(obj["printMembers"])
        return PrintMembers(print_members)

    def to_dict(self) -> dict:
        result: dict = {}
        result["printMembers"] = from_int(self.print_members)
        return result


@dataclass
class Printf:
    printf: int

    @staticmethod
    def from_dict(obj: Any) -> 'Printf':
        assert isinstance(obj, dict)
        printf = from_int(obj["printf"])
        return Printf(printf)

    def to_dict(self) -> dict:
        result: dict = {}
        result["printf"] = from_int(self.printf)
        return result


@dataclass
class Private:
    private: int

    @staticmethod
    def from_dict(obj: Any) -> 'Private':
        assert isinstance(obj, dict)
        private = from_int(obj["private"])
        return Private(private)

    def to_dict(self) -> dict:
        result: dict = {}
        result["private"] = from_int(self.private)
        return result


@dataclass
class Protected:
    protected: int

    @staticmethod
    def from_dict(obj: Any) -> 'Protected':
        assert isinstance(obj, dict)
        protected = from_int(obj["protected"])
        return Protected(protected)

    def to_dict(self) -> dict:
        result: dict = {}
        result["protected"] = from_int(self.protected)
        return result


@dataclass
class Protocol:
    protocol: int

    @staticmethod
    def from_dict(obj: Any) -> 'Protocol':
        assert isinstance(obj, dict)
        protocol = from_int(obj["Protocol"])
        return Protocol(protocol)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Protocol"] = from_int(self.protocol)
        return result


@dataclass
class Public:
    public: int

    @staticmethod
    def from_dict(obj: Any) -> 'Public':
        assert isinstance(obj, dict)
        public = from_int(obj["public"])
        return Public(public)

    def to_dict(self) -> dict:
        result: dict = {}
        result["public"] = from_int(self.public)
        return result


@dataclass
class Quicktype:
    quicktype: int

    @staticmethod
    def from_dict(obj: Any) -> 'Quicktype':
        assert isinstance(obj, dict)
        quicktype = from_int(obj["quicktype"])
        return Quicktype(quicktype)

    def to_dict(self) -> dict:
        result: dict = {}
        result["quicktype"] = from_int(self.quicktype)
        return result


@dataclass
class Range:
    range: int

    @staticmethod
    def from_dict(obj: Any) -> 'Range':
        assert isinstance(obj, dict)
        range = from_int(obj["range"])
        return Range(range)

    def to_dict(self) -> dict:
        result: dict = {}
        result["range"] = from_int(self.range)
        return result


@dataclass
class Readonly:
    readonly: int

    @staticmethod
    def from_dict(obj: Any) -> 'Readonly':
        assert isinstance(obj, dict)
        readonly = from_int(obj["readonly"])
        return Readonly(readonly)

    def to_dict(self) -> dict:
        result: dict = {}
        result["readonly"] = from_int(self.readonly)
        return result


@dataclass
class Ref:
    ref: int

    @staticmethod
    def from_dict(obj: Any) -> 'Ref':
        assert isinstance(obj, dict)
        ref = from_int(obj["ref"])
        return Ref(ref)

    def to_dict(self) -> dict:
        result: dict = {}
        result["ref"] = from_int(self.ref)
        return result


@dataclass
class RegExp:
    reg_exp: UUID

    @staticmethod
    def from_dict(obj: Any) -> 'RegExp':
        assert isinstance(obj, dict)
        reg_exp = UUID(obj["RegExp"])
        return RegExp(reg_exp)

    def to_dict(self) -> dict:
        result: dict = {}
        result["RegExp"] = str(self.reg_exp)
        return result


@dataclass
class Register:
    register: int

    @staticmethod
    def from_dict(obj: Any) -> 'Register':
        assert isinstance(obj, dict)
        register = from_int(obj["register"])
        return Register(register)

    def to_dict(self) -> dict:
        result: dict = {}
        result["register"] = from_int(self.register)
        return result


@dataclass
class ReinterpretCast:
    reinterpret_cast: int

    @staticmethod
    def from_dict(obj: Any) -> 'ReinterpretCast':
        assert isinstance(obj, dict)
        reinterpret_cast = from_int(obj["reinterpret_cast"])
        return ReinterpretCast(reinterpret_cast)

    def to_dict(self) -> dict:
        result: dict = {}
        result["reinterpret_cast"] = from_int(self.reinterpret_cast)
        return result


@dataclass
class Obj4:
    no: No
    ns_error: NSError
    ns_object: NSObject
    ns_string: NSString
    null: Null
    none: NoneClass
    null_node: NullNode
    object_mapper: ObjectMapper
    object_node: ObjectNode
    object_reader: ObjectReader
    object_writer: ObjectWriter
    offset_date_time: OffsetDateTime
    offset_time: OffsetTime
    protocol: Protocol
    reg_exp: RegExp
    dummy: int
    mutable: Mutable
    mutating: Mutating
    namespace: Namespace
    native: Native
    new: New
    newtonsoft: Newtonsoft
    nil: Nil
    no_such_method: NoSuchMethod
    noexcept: Noexcept
    nonatomic: Nonatomic
    obj4_none: Obj4None
    obj4_nonlocal: Nonlocal
    nonmutating: Nonmutating
    obj4_not: Not
    not_eq: NotEq
    obj4_null: NullClass
    nullptr: Nullptr
    number: Number
    object: Object
    of: Of
    oneway: Oneway
    open: Open
    operator: Operator
    optional: OptionalClass
    obj4_or: Or
    or_eq: OrEq
    out: Out
    override: Override
    package: Package
    params: Params
    obj4_pass: Pass
    port: Port
    postfix: Postfix
    precedence: Precedence
    prefix: Prefix
    obj4_print: Print
    print_members: PrintMembers
    printf: Printf
    private: Private
    protected: Protected
    obj4_protocol: ProtocolClass
    public: Public
    quicktype: Quicktype
    obj4_raise: Raise
    range: Range
    readonly: Readonly
    ref: Ref
    register: Register
    reinterpret_cast: ReinterpretCast

    @staticmethod
    def from_dict(obj: Any) -> 'Obj4':
        assert isinstance(obj, dict)
        no = No.from_dict(obj["NO"])
        ns_error = NSError.from_dict(obj["NSError"])
        ns_object = NSObject.from_dict(obj["NSObject"])
        ns_string = NSString.from_dict(obj["NSString"])
        null = Null.from_dict(obj["NULL"])
        none = NoneClass.from_dict(obj["None"])
        null_node = NullNode.from_dict(obj["NullNode"])
        object_mapper = ObjectMapper.from_dict(obj["ObjectMapper"])
        object_node = ObjectNode.from_dict(obj["ObjectNode"])
        object_reader = ObjectReader.from_dict(obj["ObjectReader"])
        object_writer = ObjectWriter.from_dict(obj["ObjectWriter"])
        offset_date_time = OffsetDateTime.from_dict(obj["OffsetDateTime"])
        offset_time = OffsetTime.from_dict(obj["OffsetTime"])
        protocol = Protocol.from_dict(obj["Protocol"])
        reg_exp = RegExp.from_dict(obj["RegExp"])
        dummy = from_int(obj["dummy"])
        mutable = Mutable.from_dict(obj["mutable"])
        mutating = Mutating.from_dict(obj["mutating"])
        namespace = Namespace.from_dict(obj["namespace"])
        native = Native.from_dict(obj["native"])
        new = New.from_dict(obj["new"])
        newtonsoft = Newtonsoft.from_dict(obj["newtonsoft"])
        nil = Nil.from_dict(obj["nil"])
        no_such_method = NoSuchMethod.from_dict(obj["noSuchMethod"])
        noexcept = Noexcept.from_dict(obj["noexcept"])
        nonatomic = Nonatomic.from_dict(obj["nonatomic"])
        obj4_none = Obj4None.from_dict(obj["none"])
        obj4_nonlocal = Nonlocal.from_dict(obj["nonlocal"])
        nonmutating = Nonmutating.from_dict(obj["nonmutating"])
        obj4_not = Not.from_dict(obj["not"])
        not_eq = NotEq.from_dict(obj["not_eq"])
        obj4_null = NullClass.from_dict(obj["null"])
        nullptr = Nullptr.from_dict(obj["nullptr"])
        number = Number.from_dict(obj["number"])
        object = Object.from_dict(obj["object"])
        of = Of.from_dict(obj["of"])
        oneway = Oneway.from_dict(obj["oneway"])
        open = Open.from_dict(obj["open"])
        operator = Operator.from_dict(obj["operator"])
        optional = OptionalClass.from_dict(obj["optional"])
        obj4_or = Or.from_dict(obj["or"])
        or_eq = OrEq.from_dict(obj["or_eq"])
        out = Out.from_dict(obj["out"])
        override = Override.from_dict(obj["override"])
        package = Package.from_dict(obj["package"])
        params = Params.from_dict(obj["params"])
        obj4_pass = Pass.from_dict(obj["pass"])
        port = Port.from_dict(obj["port"])
        postfix = Postfix.from_dict(obj["postfix"])
        precedence = Precedence.from_dict(obj["precedence"])
        prefix = Prefix.from_dict(obj["prefix"])
        obj4_print = Print.from_dict(obj["print"])
        print_members = PrintMembers.from_dict(obj["printMembers"])
        printf = Printf.from_dict(obj["printf"])
        private = Private.from_dict(obj["private"])
        protected = Protected.from_dict(obj["protected"])
        obj4_protocol = ProtocolClass.from_dict(obj["protocol"])
        public = Public.from_dict(obj["public"])
        quicktype = Quicktype.from_dict(obj["quicktype"])
        obj4_raise = Raise.from_dict(obj["raise"])
        range = Range.from_dict(obj["range"])
        readonly = Readonly.from_dict(obj["readonly"])
        ref = Ref.from_dict(obj["ref"])
        register = Register.from_dict(obj["register"])
        reinterpret_cast = ReinterpretCast.from_dict(obj["reinterpret_cast"])
        return Obj4(no, ns_error, ns_object, ns_string, null, none, null_node, object_mapper, object_node, object_reader, object_writer, offset_date_time, offset_time, protocol, reg_exp, dummy, mutable, mutating, namespace, native, new, newtonsoft, nil, no_such_method, noexcept, nonatomic, obj4_none, obj4_nonlocal, nonmutating, obj4_not, not_eq, obj4_null, nullptr, number, object, of, oneway, open, operator, optional, obj4_or, or_eq, out, override, package, params, obj4_pass, port, postfix, precedence, prefix, obj4_print, print_members, printf, private, protected, obj4_protocol, public, quicktype, obj4_raise, range, readonly, ref, register, reinterpret_cast)

    def to_dict(self) -> dict:
        result: dict = {}
        result["NO"] = to_class(No, self.no)
        result["NSError"] = to_class(NSError, self.ns_error)
        result["NSObject"] = to_class(NSObject, self.ns_object)
        result["NSString"] = to_class(NSString, self.ns_string)
        result["NULL"] = to_class(Null, self.null)
        result["None"] = to_class(NoneClass, self.none)
        result["NullNode"] = to_class(NullNode, self.null_node)
        result["ObjectMapper"] = to_class(ObjectMapper, self.object_mapper)
        result["ObjectNode"] = to_class(ObjectNode, self.object_node)
        result["ObjectReader"] = to_class(ObjectReader, self.object_reader)
        result["ObjectWriter"] = to_class(ObjectWriter, self.object_writer)
        result["OffsetDateTime"] = to_class(OffsetDateTime, self.offset_date_time)
        result["OffsetTime"] = to_class(OffsetTime, self.offset_time)
        result["Protocol"] = to_class(Protocol, self.protocol)
        result["RegExp"] = to_class(RegExp, self.reg_exp)
        result["dummy"] = from_int(self.dummy)
        result["mutable"] = to_class(Mutable, self.mutable)
        result["mutating"] = to_class(Mutating, self.mutating)
        result["namespace"] = to_class(Namespace, self.namespace)
        result["native"] = to_class(Native, self.native)
        result["new"] = to_class(New, self.new)
        result["newtonsoft"] = to_class(Newtonsoft, self.newtonsoft)
        result["nil"] = to_class(Nil, self.nil)
        result["noSuchMethod"] = to_class(NoSuchMethod, self.no_such_method)
        result["noexcept"] = to_class(Noexcept, self.noexcept)
        result["nonatomic"] = to_class(Nonatomic, self.nonatomic)
        result["none"] = to_class(Obj4None, self.obj4_none)
        result["nonlocal"] = to_class(Nonlocal, self.obj4_nonlocal)
        result["nonmutating"] = to_class(Nonmutating, self.nonmutating)
        result["not"] = to_class(Not, self.obj4_not)
        result["not_eq"] = to_class(NotEq, self.not_eq)
        result["null"] = to_class(NullClass, self.obj4_null)
        result["nullptr"] = to_class(Nullptr, self.nullptr)
        result["number"] = to_class(Number, self.number)
        result["object"] = to_class(Object, self.object)
        result["of"] = to_class(Of, self.of)
        result["oneway"] = to_class(Oneway, self.oneway)
        result["open"] = to_class(Open, self.open)
        result["operator"] = to_class(Operator, self.operator)
        result["optional"] = to_class(OptionalClass, self.optional)
        result["or"] = to_class(Or, self.obj4_or)
        result["or_eq"] = to_class(OrEq, self.or_eq)
        result["out"] = to_class(Out, self.out)
        result["override"] = to_class(Override, self.override)
        result["package"] = to_class(Package, self.package)
        result["params"] = to_class(Params, self.params)
        result["pass"] = to_class(Pass, self.obj4_pass)
        result["port"] = to_class(Port, self.port)
        result["postfix"] = to_class(Postfix, self.postfix)
        result["precedence"] = to_class(Precedence, self.precedence)
        result["prefix"] = to_class(Prefix, self.prefix)
        result["print"] = to_class(Print, self.obj4_print)
        result["printMembers"] = to_class(PrintMembers, self.print_members)
        result["printf"] = to_class(Printf, self.printf)
        result["private"] = to_class(Private, self.private)
        result["protected"] = to_class(Protected, self.protected)
        result["protocol"] = to_class(ProtocolClass, self.obj4_protocol)
        result["public"] = to_class(Public, self.public)
        result["quicktype"] = to_class(Quicktype, self.quicktype)
        result["raise"] = to_class(Raise, self.obj4_raise)
        result["range"] = to_class(Range, self.range)
        result["readonly"] = to_class(Readonly, self.readonly)
        result["ref"] = to_class(Ref, self.ref)
        result["register"] = to_class(Register, self.register)
        result["reinterpret_cast"] = to_class(ReinterpretCast, self.reinterpret_cast)
        return result


@dataclass
class KSerializer:
    k_serializer: int

    @staticmethod
    def from_dict(obj: Any) -> 'KSerializer':
        assert isinstance(obj, dict)
        k_serializer = from_int(obj["KSerializer"])
        return KSerializer(k_serializer)

    def to_dict(self) -> dict:
        result: dict = {}
        result["KSerializer"] = from_int(self.k_serializer)
        return result


@dataclass
class Return:
    return_return: int

    @staticmethod
    def from_dict(obj: Any) -> 'Return':
        assert isinstance(obj, dict)
        return_return = from_int(obj["return"])
        return Return(return_return)

    def to_dict(self) -> dict:
        result: dict = {}
        result["return"] = from_int(self.return_return)
        return result


@dataclass
class Self:
    self_self: int

    @staticmethod
    def from_dict(obj: Any) -> 'Self':
        assert isinstance(obj, dict)
        self_self = from_int(obj["Self"])
        return Self(self_self)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Self"] = from_int(self.self_self)
        return result


@dataclass
class ToDict:
    to_dict_to_dict: int

    @staticmethod
    def from_dict(obj: Any) -> 'ToDict':
        assert isinstance(obj, dict)
        to_dict_to_dict = from_int(obj["to_dict"])
        return ToDict(to_dict_to_dict)

    def to_dict(self) -> dict:
        result: dict = {}
        result["to_dict"] = from_int(self.to_dict_to_dict)
        return result


@dataclass
class Obj5True:
    true: int

    @staticmethod
    def from_dict(obj: Any) -> 'Obj5True':
        assert isinstance(obj, dict)
        true = from_int(obj["true"])
        return Obj5True(true)

    def to_dict(self) -> dict:
        result: dict = {}
        result["true"] = from_int(self.true)
        return result


@dataclass
class PrimitiveKind:
    primitive_kind: int

    @staticmethod
    def from_dict(obj: Any) -> 'PrimitiveKind':
        assert isinstance(obj, dict)
        primitive_kind = from_int(obj["PrimitiveKind"])
        return PrimitiveKind(primitive_kind)

    def to_dict(self) -> dict:
        result: dict = {}
        result["PrimitiveKind"] = from_int(self.primitive_kind)
        return result


@dataclass
class SelfClass:
    self_self: int

    @staticmethod
    def from_dict(obj: Any) -> 'SelfClass':
        assert isinstance(obj, dict)
        self_self = from_int(obj["self"])
        return SelfClass(self_self)

    def to_dict(self) -> dict:
        result: dict = {}
        result["self"] = from_int(self.self_self)
        return result


@dataclass
class Repeat:
    repeat: int

    @staticmethod
    def from_dict(obj: Any) -> 'Repeat':
        assert isinstance(obj, dict)
        repeat = from_int(obj["repeat"])
        return Repeat(repeat)

    def to_dict(self) -> dict:
        result: dict = {}
        result["repeat"] = from_int(self.repeat)
        return result


@dataclass
class Require:
    require: int

    @staticmethod
    def from_dict(obj: Any) -> 'Require':
        assert isinstance(obj, dict)
        require = from_int(obj["require"])
        return Require(require)

    def to_dict(self) -> dict:
        result: dict = {}
        result["require"] = from_int(self.require)
        return result


@dataclass
class Required:
    required: int

    @staticmethod
    def from_dict(obj: Any) -> 'Required':
        assert isinstance(obj, dict)
        required = from_int(obj["required"])
        return Required(required)

    def to_dict(self) -> dict:
        result: dict = {}
        result["required"] = from_int(self.required)
        return result


@dataclass
class Requires:
    requires: int

    @staticmethod
    def from_dict(obj: Any) -> 'Requires':
        assert isinstance(obj, dict)
        requires = from_int(obj["requires"])
        return Requires(requires)

    def to_dict(self) -> dict:
        result: dict = {}
        result["requires"] = from_int(self.requires)
        return result


@dataclass
class Restrict:
    restrict: int

    @staticmethod
    def from_dict(obj: Any) -> 'Restrict':
        assert isinstance(obj, dict)
        restrict = from_int(obj["restrict"])
        return Restrict(restrict)

    def to_dict(self) -> dict:
        result: dict = {}
        result["restrict"] = from_int(self.restrict)
        return result


@dataclass
class Retain:
    retain: int

    @staticmethod
    def from_dict(obj: Any) -> 'Retain':
        assert isinstance(obj, dict)
        retain = from_int(obj["retain"])
        return Retain(retain)

    def to_dict(self) -> dict:
        result: dict = {}
        result["retain"] = from_int(self.retain)
        return result


@dataclass
class Rethrows:
    rethrows: int

    @staticmethod
    def from_dict(obj: Any) -> 'Rethrows':
        assert isinstance(obj, dict)
        rethrows = from_int(obj["rethrows"])
        return Rethrows(rethrows)

    def to_dict(self) -> dict:
        result: dict = {}
        result["rethrows"] = from_int(self.rethrows)
        return result


@dataclass
class Right:
    right: int

    @staticmethod
    def from_dict(obj: Any) -> 'Right':
        assert isinstance(obj, dict)
        right = from_int(obj["right"])
        return Right(right)

    def to_dict(self) -> dict:
        result: dict = {}
        result["right"] = from_int(self.right)
        return result


@dataclass
class RuntimeType:
    runtime_type: int

    @staticmethod
    def from_dict(obj: Any) -> 'RuntimeType':
        assert isinstance(obj, dict)
        runtime_type = from_int(obj["runtimeType"])
        return RuntimeType(runtime_type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["runtimeType"] = from_int(self.runtime_type)
        return result


@dataclass
class S:
    s: int

    @staticmethod
    def from_dict(obj: Any) -> 'S':
        assert isinstance(obj, dict)
        s = from_int(obj["s"])
        return S(s)

    def to_dict(self) -> dict:
        result: dict = {}
        result["s"] = from_int(self.s)
        return result


@dataclass
class Sbyte:
    sbyte: int

    @staticmethod
    def from_dict(obj: Any) -> 'Sbyte':
        assert isinstance(obj, dict)
        sbyte = from_int(obj["sbyte"])
        return Sbyte(sbyte)

    def to_dict(self) -> dict:
        result: dict = {}
        result["sbyte"] = from_int(self.sbyte)
        return result


@dataclass
class Sealed:
    sealed: int

    @staticmethod
    def from_dict(obj: Any) -> 'Sealed':
        assert isinstance(obj, dict)
        sealed = from_int(obj["sealed"])
        return Sealed(sealed)

    def to_dict(self) -> dict:
        result: dict = {}
        result["sealed"] = from_int(self.sealed)
        return result


@dataclass
class Sel:
    sel: int

    @staticmethod
    def from_dict(obj: Any) -> 'Sel':
        assert isinstance(obj, dict)
        sel = from_int(obj["SEL"])
        return Sel(sel)

    def to_dict(self) -> dict:
        result: dict = {}
        result["SEL"] = from_int(self.sel)
        return result


@dataclass
class Select:
    select: int

    @staticmethod
    def from_dict(obj: Any) -> 'Select':
        assert isinstance(obj, dict)
        select = from_int(obj["select"])
        return Select(select)

    def to_dict(self) -> dict:
        result: dict = {}
        result["select"] = from_int(self.select)
        return result


@dataclass
class Sendable:
    sendable: int

    @staticmethod
    def from_dict(obj: Any) -> 'Sendable':
        assert isinstance(obj, dict)
        sendable = from_int(obj["Sendable"])
        return Sendable(sendable)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Sendable"] = from_int(self.sendable)
        return result


@dataclass
class SerialDescriptor:
    serial_descriptor: int

    @staticmethod
    def from_dict(obj: Any) -> 'SerialDescriptor':
        assert isinstance(obj, dict)
        serial_descriptor = from_int(obj["SerialDescriptor"])
        return SerialDescriptor(serial_descriptor)

    def to_dict(self) -> dict:
        result: dict = {}
        result["SerialDescriptor"] = from_int(self.serial_descriptor)
        return result


@dataclass
class SerialName:
    serial_name: int

    @staticmethod
    def from_dict(obj: Any) -> 'SerialName':
        assert isinstance(obj, dict)
        serial_name = from_int(obj["SerialName"])
        return SerialName(serial_name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["SerialName"] = from_int(self.serial_name)
        return result


@dataclass
class Serializable:
    serializable: int

    @staticmethod
    def from_dict(obj: Any) -> 'Serializable':
        assert isinstance(obj, dict)
        serializable = from_int(obj["Serializable"])
        return Serializable(serializable)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Serializable"] = from_int(self.serializable)
        return result


@dataclass
class SerializationFeature:
    serialization_feature: int

    @staticmethod
    def from_dict(obj: Any) -> 'SerializationFeature':
        assert isinstance(obj, dict)
        serialization_feature = from_int(obj["SerializationFeature"])
        return SerializationFeature(serialization_feature)

    def to_dict(self) -> dict:
        result: dict = {}
        result["SerializationFeature"] = from_int(self.serialization_feature)
        return result


@dataclass
class Serialize:
    serialize: int

    @staticmethod
    def from_dict(obj: Any) -> 'Serialize':
        assert isinstance(obj, dict)
        serialize = from_int(obj["serialize"])
        return Serialize(serialize)

    def to_dict(self) -> dict:
        result: dict = {}
        result["serialize"] = from_int(self.serialize)
        return result


@dataclass
class SerializerProvider:
    serializer_provider: int

    @staticmethod
    def from_dict(obj: Any) -> 'SerializerProvider':
        assert isinstance(obj, dict)
        serializer_provider = from_int(obj["SerializerProvider"])
        return SerializerProvider(serializer_provider)

    def to_dict(self) -> dict:
        result: dict = {}
        result["SerializerProvider"] = from_int(self.serializer_provider)
        return result


@dataclass
class Set:
    set: int

    @staticmethod
    def from_dict(obj: Any) -> 'Set':
        assert isinstance(obj, dict)
        set = from_int(obj["set"])
        return Set(set)

    def to_dict(self) -> dict:
        result: dict = {}
        result["set"] = from_int(self.set)
        return result


@dataclass
class Short:
    short: int

    @staticmethod
    def from_dict(obj: Any) -> 'Short':
        assert isinstance(obj, dict)
        short = from_int(obj["short"])
        return Short(short)

    def to_dict(self) -> dict:
        result: dict = {}
        result["short"] = from_int(self.short)
        return result


@dataclass
class Signed:
    signed: int

    @staticmethod
    def from_dict(obj: Any) -> 'Signed':
        assert isinstance(obj, dict)
        signed = from_int(obj["signed"])
        return Signed(signed)

    def to_dict(self) -> dict:
        result: dict = {}
        result["signed"] = from_int(self.signed)
        return result


@dataclass
class SimpleModule:
    simple_module: int

    @staticmethod
    def from_dict(obj: Any) -> 'SimpleModule':
        assert isinstance(obj, dict)
        simple_module = from_int(obj["SimpleModule"])
        return SimpleModule(simple_module)

    def to_dict(self) -> dict:
        result: dict = {}
        result["SimpleModule"] = from_int(self.simple_module)
        return result


@dataclass
class Sizeof:
    sizeof: int

    @staticmethod
    def from_dict(obj: Any) -> 'Sizeof':
        assert isinstance(obj, dict)
        sizeof = from_int(obj["sizeof"])
        return Sizeof(sizeof)

    def to_dict(self) -> dict:
        result: dict = {}
        result["sizeof"] = from_int(self.sizeof)
        return result


@dataclass
class Stackalloc:
    stackalloc: int

    @staticmethod
    def from_dict(obj: Any) -> 'Stackalloc':
        assert isinstance(obj, dict)
        stackalloc = from_int(obj["stackalloc"])
        return Stackalloc(stackalloc)

    def to_dict(self) -> dict:
        result: dict = {}
        result["stackalloc"] = from_int(self.stackalloc)
        return result


@dataclass
class Standards:
    standards: int

    @staticmethod
    def from_dict(obj: Any) -> 'Standards':
        assert isinstance(obj, dict)
        standards = from_int(obj["Standards"])
        return Standards(standards)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Standards"] = from_int(self.standards)
        return result


@dataclass
class Static:
    static: int

    @staticmethod
    def from_dict(obj: Any) -> 'Static':
        assert isinstance(obj, dict)
        static = from_int(obj["static"])
        return Static(static)

    def to_dict(self) -> dict:
        result: dict = {}
        result["static"] = from_int(self.static)
        return result


@dataclass
class StaticAssert:
    static_assert: int

    @staticmethod
    def from_dict(obj: Any) -> 'StaticAssert':
        assert isinstance(obj, dict)
        static_assert = from_int(obj["static_assert"])
        return StaticAssert(static_assert)

    def to_dict(self) -> dict:
        result: dict = {}
        result["static_assert"] = from_int(self.static_assert)
        return result


@dataclass
class StaticCast:
    static_cast: int

    @staticmethod
    def from_dict(obj: Any) -> 'StaticCast':
        assert isinstance(obj, dict)
        static_cast = from_int(obj["static_cast"])
        return StaticCast(static_cast)

    def to_dict(self) -> dict:
        result: dict = {}
        result["static_cast"] = from_int(self.static_cast)
        return result


@dataclass
class StdDeserializer:
    std_deserializer: int

    @staticmethod
    def from_dict(obj: Any) -> 'StdDeserializer':
        assert isinstance(obj, dict)
        std_deserializer = from_int(obj["StdDeserializer"])
        return StdDeserializer(std_deserializer)

    def to_dict(self) -> dict:
        result: dict = {}
        result["StdDeserializer"] = from_int(self.std_deserializer)
        return result


@dataclass
class StdSerializer:
    std_serializer: int

    @staticmethod
    def from_dict(obj: Any) -> 'StdSerializer':
        assert isinstance(obj, dict)
        std_serializer = from_int(obj["StdSerializer"])
        return StdSerializer(std_serializer)

    def to_dict(self) -> dict:
        result: dict = {}
        result["StdSerializer"] = from_int(self.std_serializer)
        return result


@dataclass
class Strictfp:
    strictfp: int

    @staticmethod
    def from_dict(obj: Any) -> 'Strictfp':
        assert isinstance(obj, dict)
        strictfp = from_int(obj["strictfp"])
        return Strictfp(strictfp)

    def to_dict(self) -> dict:
        result: dict = {}
        result["strictfp"] = from_int(self.strictfp)
        return result


@dataclass
class String:
    string: int

    @staticmethod
    def from_dict(obj: Any) -> 'String':
        assert isinstance(obj, dict)
        string = from_int(obj["string"])
        return String(string)

    def to_dict(self) -> dict:
        result: dict = {}
        result["string"] = from_int(self.string)
        return result


@dataclass
class Struct:
    struct: int

    @staticmethod
    def from_dict(obj: Any) -> 'Struct':
        assert isinstance(obj, dict)
        struct = from_int(obj["struct"])
        return Struct(struct)

    def to_dict(self) -> dict:
        result: dict = {}
        result["struct"] = from_int(self.struct)
        return result


@dataclass
class Subscript:
    subscript: int

    @staticmethod
    def from_dict(obj: Any) -> 'Subscript':
        assert isinstance(obj, dict)
        subscript = from_int(obj["subscript"])
        return Subscript(subscript)

    def to_dict(self) -> dict:
        result: dict = {}
        result["subscript"] = from_int(self.subscript)
        return result


@dataclass
class Super:
    super: int

    @staticmethod
    def from_dict(obj: Any) -> 'Super':
        assert isinstance(obj, dict)
        super = from_int(obj["super"])
        return Super(super)

    def to_dict(self) -> dict:
        result: dict = {}
        result["super"] = from_int(self.super)
        return result


@dataclass
class Switch:
    switch: int

    @staticmethod
    def from_dict(obj: Any) -> 'Switch':
        assert isinstance(obj, dict)
        switch = from_int(obj["switch"])
        return Switch(switch)

    def to_dict(self) -> dict:
        result: dict = {}
        result["switch"] = from_int(self.switch)
        return result


@dataclass
class Symbol:
    symbol: int

    @staticmethod
    def from_dict(obj: Any) -> 'Symbol':
        assert isinstance(obj, dict)
        symbol = from_int(obj["symbol"])
        return Symbol(symbol)

    def to_dict(self) -> dict:
        result: dict = {}
        result["symbol"] = from_int(self.symbol)
        return result


@dataclass
class Synchronized:
    synchronized: int

    @staticmethod
    def from_dict(obj: Any) -> 'Synchronized':
        assert isinstance(obj, dict)
        synchronized = from_int(obj["synchronized"])
        return Synchronized(synchronized)

    def to_dict(self) -> dict:
        result: dict = {}
        result["synchronized"] = from_int(self.synchronized)
        return result


@dataclass
class System:
    system: int

    @staticmethod
    def from_dict(obj: Any) -> 'System':
        assert isinstance(obj, dict)
        system = from_int(obj["system"])
        return System(system)

    def to_dict(self) -> dict:
        result: dict = {}
        result["system"] = from_int(self.system)
        return result


@dataclass
class Template:
    template: int

    @staticmethod
    def from_dict(obj: Any) -> 'Template':
        assert isinstance(obj, dict)
        template = from_int(obj["template"])
        return Template(template)

    def to_dict(self) -> dict:
        result: dict = {}
        result["template"] = from_int(self.template)
        return result


@dataclass
class TextNode:
    text_node: int

    @staticmethod
    def from_dict(obj: Any) -> 'TextNode':
        assert isinstance(obj, dict)
        text_node = from_int(obj["TextNode"])
        return TextNode(text_node)

    def to_dict(self) -> dict:
        result: dict = {}
        result["TextNode"] = from_int(self.text_node)
        return result


@dataclass
class Then:
    then: int

    @staticmethod
    def from_dict(obj: Any) -> 'Then':
        assert isinstance(obj, dict)
        then = from_int(obj["then"])
        return Then(then)

    def to_dict(self) -> dict:
        result: dict = {}
        result["then"] = from_int(self.then)
        return result


@dataclass
class This:
    this: int

    @staticmethod
    def from_dict(obj: Any) -> 'This':
        assert isinstance(obj, dict)
        this = from_int(obj["this"])
        return This(this)

    def to_dict(self) -> dict:
        result: dict = {}
        result["this"] = from_int(self.this)
        return result


@dataclass
class ThreadLocal:
    thread_local: int

    @staticmethod
    def from_dict(obj: Any) -> 'ThreadLocal':
        assert isinstance(obj, dict)
        thread_local = from_int(obj["thread_local"])
        return ThreadLocal(thread_local)

    def to_dict(self) -> dict:
        result: dict = {}
        result["thread_local"] = from_int(self.thread_local)
        return result


@dataclass
class Throw:
    throw: int

    @staticmethod
    def from_dict(obj: Any) -> 'Throw':
        assert isinstance(obj, dict)
        throw = from_int(obj["throw"])
        return Throw(throw)

    def to_dict(self) -> dict:
        result: dict = {}
        result["throw"] = from_int(self.throw)
        return result


@dataclass
class Throws:
    throws: int

    @staticmethod
    def from_dict(obj: Any) -> 'Throws':
        assert isinstance(obj, dict)
        throws = from_int(obj["throws"])
        return Throws(throws)

    def to_dict(self) -> dict:
        result: dict = {}
        result["throws"] = from_int(self.throws)
        return result


@dataclass
class TimeOnly:
    time_only: int

    @staticmethod
    def from_dict(obj: Any) -> 'TimeOnly':
        assert isinstance(obj, dict)
        time_only = from_int(obj["TimeOnly"])
        return TimeOnly(time_only)

    def to_dict(self) -> dict:
        result: dict = {}
        result["TimeOnly"] = from_int(self.time_only)
        return result


@dataclass
class TimeOnlyConverter:
    time_only_converter: int

    @staticmethod
    def from_dict(obj: Any) -> 'TimeOnlyConverter':
        assert isinstance(obj, dict)
        time_only_converter = from_int(obj["TimeOnlyConverter"])
        return TimeOnlyConverter(time_only_converter)

    def to_dict(self) -> dict:
        result: dict = {}
        result["TimeOnlyConverter"] = from_int(self.time_only_converter)
        return result


@dataclass
class TimeZone:
    time_zone: int

    @staticmethod
    def from_dict(obj: Any) -> 'TimeZone':
        assert isinstance(obj, dict)
        time_zone = from_int(obj["TimeZone"])
        return TimeZone(time_zone)

    def to_dict(self) -> dict:
        result: dict = {}
        result["TimeZone"] = from_int(self.time_zone)
        return result


@dataclass
class ToJSON:
    to_json: int

    @staticmethod
    def from_dict(obj: Any) -> 'ToJSON':
        assert isinstance(obj, dict)
        to_json = from_int(obj["to_json"])
        return ToJSON(to_json)

    def to_dict(self) -> dict:
        result: dict = {}
        result["to_json"] = from_int(self.to_json)
        return result


@dataclass
class ToString:
    to_string: int

    @staticmethod
    def from_dict(obj: Any) -> 'ToString':
        assert isinstance(obj, dict)
        to_string = from_int(obj["toString"])
        return ToString(to_string)

    def to_dict(self) -> dict:
        result: dict = {}
        result["toString"] = from_int(self.to_string)
        return result


@dataclass
class TopLevelClass:
    top_level: int

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevelClass':
        assert isinstance(obj, dict)
        top_level = from_int(obj["top_level"])
        return TopLevelClass(top_level)

    def to_dict(self) -> dict:
        result: dict = {}
        result["top_level"] = from_int(self.top_level)
        return result


@dataclass
class Transient:
    transient: int

    @staticmethod
    def from_dict(obj: Any) -> 'Transient':
        assert isinstance(obj, dict)
        transient = from_int(obj["transient"])
        return Transient(transient)

    def to_dict(self) -> dict:
        result: dict = {}
        result["transient"] = from_int(self.transient)
        return result


@dataclass
class TrueClass:
    true: int

    @staticmethod
    def from_dict(obj: Any) -> 'TrueClass':
        assert isinstance(obj, dict)
        true = from_int(obj["True"])
        return TrueClass(true)

    def to_dict(self) -> dict:
        result: dict = {}
        result["True"] = from_int(self.true)
        return result


@dataclass
class Obj5:
    k_serializer: KSerializer
    primitive_kind: PrimitiveKind
    sel: Sel
    obj5_self: Self
    sendable: Sendable
    serial_descriptor: SerialDescriptor
    serial_name: SerialName
    serializable: Serializable
    serialization_feature: SerializationFeature
    serializer_provider: SerializerProvider
    simple_module: SimpleModule
    standards: Standards
    std_deserializer: StdDeserializer
    std_serializer: StdSerializer
    text_node: TextNode
    time_only: TimeOnly
    time_only_converter: TimeOnlyConverter
    time_zone: TimeZone
    true: TrueClass
    dummy: int
    repeat: Repeat
    require: Require
    required: Required
    requires: Requires
    restrict: Restrict
    retain: Retain
    rethrows: Rethrows
    obj5_return: Return
    right: Right
    runtime_type: RuntimeType
    s: S
    sbyte: Sbyte
    sealed: Sealed
    select: Select
    purple_self: SelfClass
    serialize: Serialize
    set: Set
    short: Short
    signed: Signed
    sizeof: Sizeof
    stackalloc: Stackalloc
    static: Static
    static_assert: StaticAssert
    static_cast: StaticCast
    strictfp: Strictfp
    string: String
    struct: Struct
    subscript: Subscript
    super: Super
    switch: Switch
    symbol: Symbol
    synchronized: Synchronized
    system: System
    template: Template
    then: Then
    this: This
    thread_local: ThreadLocal
    throw: Throw
    throws: Throws
    to_string: ToString
    obj5_to_dict: ToDict
    to_json: ToJSON
    top_level: TopLevelClass
    transient: Transient
    obj5_true: Obj5True

    @staticmethod
    def from_dict(obj: Any) -> 'Obj5':
        assert isinstance(obj, dict)
        k_serializer = KSerializer.from_dict(obj["KSerializer"])
        primitive_kind = PrimitiveKind.from_dict(obj["PrimitiveKind"])
        sel = Sel.from_dict(obj["SEL"])
        obj5_self = Self.from_dict(obj["Self"])
        sendable = Sendable.from_dict(obj["Sendable"])
        serial_descriptor = SerialDescriptor.from_dict(obj["SerialDescriptor"])
        serial_name = SerialName.from_dict(obj["SerialName"])
        serializable = Serializable.from_dict(obj["Serializable"])
        serialization_feature = SerializationFeature.from_dict(obj["SerializationFeature"])
        serializer_provider = SerializerProvider.from_dict(obj["SerializerProvider"])
        simple_module = SimpleModule.from_dict(obj["SimpleModule"])
        standards = Standards.from_dict(obj["Standards"])
        std_deserializer = StdDeserializer.from_dict(obj["StdDeserializer"])
        std_serializer = StdSerializer.from_dict(obj["StdSerializer"])
        text_node = TextNode.from_dict(obj["TextNode"])
        time_only = TimeOnly.from_dict(obj["TimeOnly"])
        time_only_converter = TimeOnlyConverter.from_dict(obj["TimeOnlyConverter"])
        time_zone = TimeZone.from_dict(obj["TimeZone"])
        true = TrueClass.from_dict(obj["True"])
        dummy = from_int(obj["dummy"])
        repeat = Repeat.from_dict(obj["repeat"])
        require = Require.from_dict(obj["require"])
        required = Required.from_dict(obj["required"])
        requires = Requires.from_dict(obj["requires"])
        restrict = Restrict.from_dict(obj["restrict"])
        retain = Retain.from_dict(obj["retain"])
        rethrows = Rethrows.from_dict(obj["rethrows"])
        obj5_return = Return.from_dict(obj["return"])
        right = Right.from_dict(obj["right"])
        runtime_type = RuntimeType.from_dict(obj["runtimeType"])
        s = S.from_dict(obj["s"])
        sbyte = Sbyte.from_dict(obj["sbyte"])
        sealed = Sealed.from_dict(obj["sealed"])
        select = Select.from_dict(obj["select"])
        purple_self = SelfClass.from_dict(obj["self"])
        serialize = Serialize.from_dict(obj["serialize"])
        set = Set.from_dict(obj["set"])
        short = Short.from_dict(obj["short"])
        signed = Signed.from_dict(obj["signed"])
        sizeof = Sizeof.from_dict(obj["sizeof"])
        stackalloc = Stackalloc.from_dict(obj["stackalloc"])
        static = Static.from_dict(obj["static"])
        static_assert = StaticAssert.from_dict(obj["static_assert"])
        static_cast = StaticCast.from_dict(obj["static_cast"])
        strictfp = Strictfp.from_dict(obj["strictfp"])
        string = String.from_dict(obj["string"])
        struct = Struct.from_dict(obj["struct"])
        subscript = Subscript.from_dict(obj["subscript"])
        super = Super.from_dict(obj["super"])
        switch = Switch.from_dict(obj["switch"])
        symbol = Symbol.from_dict(obj["symbol"])
        synchronized = Synchronized.from_dict(obj["synchronized"])
        system = System.from_dict(obj["system"])
        template = Template.from_dict(obj["template"])
        then = Then.from_dict(obj["then"])
        this = This.from_dict(obj["this"])
        thread_local = ThreadLocal.from_dict(obj["thread_local"])
        throw = Throw.from_dict(obj["throw"])
        throws = Throws.from_dict(obj["throws"])
        to_string = ToString.from_dict(obj["toString"])
        obj5_to_dict = ToDict.from_dict(obj["to_dict"])
        to_json = ToJSON.from_dict(obj["to_json"])
        top_level = TopLevelClass.from_dict(obj["top_level"])
        transient = Transient.from_dict(obj["transient"])
        obj5_true = Obj5True.from_dict(obj["true"])
        return Obj5(k_serializer, primitive_kind, sel, obj5_self, sendable, serial_descriptor, serial_name, serializable, serialization_feature, serializer_provider, simple_module, standards, std_deserializer, std_serializer, text_node, time_only, time_only_converter, time_zone, true, dummy, repeat, require, required, requires, restrict, retain, rethrows, obj5_return, right, runtime_type, s, sbyte, sealed, select, purple_self, serialize, set, short, signed, sizeof, stackalloc, static, static_assert, static_cast, strictfp, string, struct, subscript, super, switch, symbol, synchronized, system, template, then, this, thread_local, throw, throws, to_string, obj5_to_dict, to_json, top_level, transient, obj5_true)

    def to_dict(self) -> dict:
        result: dict = {}
        result["KSerializer"] = to_class(KSerializer, self.k_serializer)
        result["PrimitiveKind"] = to_class(PrimitiveKind, self.primitive_kind)
        result["SEL"] = to_class(Sel, self.sel)
        result["Self"] = to_class(Self, self.obj5_self)
        result["Sendable"] = to_class(Sendable, self.sendable)
        result["SerialDescriptor"] = to_class(SerialDescriptor, self.serial_descriptor)
        result["SerialName"] = to_class(SerialName, self.serial_name)
        result["Serializable"] = to_class(Serializable, self.serializable)
        result["SerializationFeature"] = to_class(SerializationFeature, self.serialization_feature)
        result["SerializerProvider"] = to_class(SerializerProvider, self.serializer_provider)
        result["SimpleModule"] = to_class(SimpleModule, self.simple_module)
        result["Standards"] = to_class(Standards, self.standards)
        result["StdDeserializer"] = to_class(StdDeserializer, self.std_deserializer)
        result["StdSerializer"] = to_class(StdSerializer, self.std_serializer)
        result["TextNode"] = to_class(TextNode, self.text_node)
        result["TimeOnly"] = to_class(TimeOnly, self.time_only)
        result["TimeOnlyConverter"] = to_class(TimeOnlyConverter, self.time_only_converter)
        result["TimeZone"] = to_class(TimeZone, self.time_zone)
        result["True"] = to_class(TrueClass, self.true)
        result["dummy"] = from_int(self.dummy)
        result["repeat"] = to_class(Repeat, self.repeat)
        result["require"] = to_class(Require, self.require)
        result["required"] = to_class(Required, self.required)
        result["requires"] = to_class(Requires, self.requires)
        result["restrict"] = to_class(Restrict, self.restrict)
        result["retain"] = to_class(Retain, self.retain)
        result["rethrows"] = to_class(Rethrows, self.rethrows)
        result["return"] = to_class(Return, self.obj5_return)
        result["right"] = to_class(Right, self.right)
        result["runtimeType"] = to_class(RuntimeType, self.runtime_type)
        result["s"] = to_class(S, self.s)
        result["sbyte"] = to_class(Sbyte, self.sbyte)
        result["sealed"] = to_class(Sealed, self.sealed)
        result["select"] = to_class(Select, self.select)
        result["self"] = to_class(SelfClass, self.purple_self)
        result["serialize"] = to_class(Serialize, self.serialize)
        result["set"] = to_class(Set, self.set)
        result["short"] = to_class(Short, self.short)
        result["signed"] = to_class(Signed, self.signed)
        result["sizeof"] = to_class(Sizeof, self.sizeof)
        result["stackalloc"] = to_class(Stackalloc, self.stackalloc)
        result["static"] = to_class(Static, self.static)
        result["static_assert"] = to_class(StaticAssert, self.static_assert)
        result["static_cast"] = to_class(StaticCast, self.static_cast)
        result["strictfp"] = to_class(Strictfp, self.strictfp)
        result["string"] = to_class(String, self.string)
        result["struct"] = to_class(Struct, self.struct)
        result["subscript"] = to_class(Subscript, self.subscript)
        result["super"] = to_class(Super, self.super)
        result["switch"] = to_class(Switch, self.switch)
        result["symbol"] = to_class(Symbol, self.symbol)
        result["synchronized"] = to_class(Synchronized, self.synchronized)
        result["system"] = to_class(System, self.system)
        result["template"] = to_class(Template, self.template)
        result["then"] = to_class(Then, self.then)
        result["this"] = to_class(This, self.this)
        result["thread_local"] = to_class(ThreadLocal, self.thread_local)
        result["throw"] = to_class(Throw, self.throw)
        result["throws"] = to_class(Throws, self.throws)
        result["toString"] = to_class(ToString, self.to_string)
        result["to_dict"] = to_class(ToDict, self.obj5_to_dict)
        result["to_json"] = to_class(ToJSON, self.to_json)
        result["top_level"] = to_class(TopLevelClass, self.top_level)
        result["transient"] = to_class(Transient, self.transient)
        result["true"] = to_class(Obj5True, self.obj5_true)
        return result


@dataclass
class Try:
    try_try: int

    @staticmethod
    def from_dict(obj: Any) -> 'Try':
        assert isinstance(obj, dict)
        try_try = from_int(obj["try"])
        return Try(try_try)

    def to_dict(self) -> dict:
        result: dict = {}
        result["try"] = from_int(self.try_try)
        return result


@dataclass
class Obj6Type:
    type: int

    @staticmethod
    def from_dict(obj: Any) -> 'Obj6Type':
        assert isinstance(obj, dict)
        type = from_int(obj["type"])
        return Obj6Type(type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["type"] = from_int(self.type)
        return result


@dataclass
class While:
    while_while: int

    @staticmethod
    def from_dict(obj: Any) -> 'While':
        assert isinstance(obj, dict)
        while_while = from_int(obj["while"])
        return While(while_while)

    def to_dict(self) -> dict:
        result: dict = {}
        result["while"] = from_int(self.while_while)
        return result


@dataclass
class With:
    with_with: int

    @staticmethod
    def from_dict(obj: Any) -> 'With':
        assert isinstance(obj, dict)
        with_with = from_int(obj["with"])
        return With(with_with)

    def to_dict(self) -> dict:
        result: dict = {}
        result["with"] = from_int(self.with_with)
        return result


@dataclass
class Yield:
    yield_yield: int

    @staticmethod
    def from_dict(obj: Any) -> 'Yield':
        assert isinstance(obj, dict)
        yield_yield = from_int(obj["yield"])
        return Yield(yield_yield)

    def to_dict(self) -> dict:
        result: dict = {}
        result["yield"] = from_int(self.yield_yield)
        return result


@dataclass
class TypeClass:
    type: int

    @staticmethod
    def from_dict(obj: Any) -> 'TypeClass':
        assert isinstance(obj, dict)
        type = from_int(obj["Type"])
        return TypeClass(type)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Type"] = from_int(self.type)
        return result


@dataclass
class Typealias:
    typealias: int

    @staticmethod
    def from_dict(obj: Any) -> 'Typealias':
        assert isinstance(obj, dict)
        typealias = from_int(obj["typealias"])
        return Typealias(typealias)

    def to_dict(self) -> dict:
        result: dict = {}
        result["typealias"] = from_int(self.typealias)
        return result


@dataclass
class Typedef:
    typedef: int

    @staticmethod
    def from_dict(obj: Any) -> 'Typedef':
        assert isinstance(obj, dict)
        typedef = from_int(obj["typedef"])
        return Typedef(typedef)

    def to_dict(self) -> dict:
        result: dict = {}
        result["typedef"] = from_int(self.typedef)
        return result


@dataclass
class Typeid:
    typeid: int

    @staticmethod
    def from_dict(obj: Any) -> 'Typeid':
        assert isinstance(obj, dict)
        typeid = from_int(obj["typeid"])
        return Typeid(typeid)

    def to_dict(self) -> dict:
        result: dict = {}
        result["typeid"] = from_int(self.typeid)
        return result


@dataclass
class Typename:
    typename: int

    @staticmethod
    def from_dict(obj: Any) -> 'Typename':
        assert isinstance(obj, dict)
        typename = from_int(obj["typename"])
        return Typename(typename)

    def to_dict(self) -> dict:
        result: dict = {}
        result["typename"] = from_int(self.typename)
        return result


@dataclass
class Typeof:
    typeof: int

    @staticmethod
    def from_dict(obj: Any) -> 'Typeof':
        assert isinstance(obj, dict)
        typeof = from_int(obj["typeof"])
        return Typeof(typeof)

    def to_dict(self) -> dict:
        result: dict = {}
        result["typeof"] = from_int(self.typeof)
        return result


@dataclass
class Uint:
    uint: int

    @staticmethod
    def from_dict(obj: Any) -> 'Uint':
        assert isinstance(obj, dict)
        uint = from_int(obj["uint"])
        return Uint(uint)

    def to_dict(self) -> dict:
        result: dict = {}
        result["uint"] = from_int(self.uint)
        return result


@dataclass
class Ulong:
    ulong: int

    @staticmethod
    def from_dict(obj: Any) -> 'Ulong':
        assert isinstance(obj, dict)
        ulong = from_int(obj["ulong"])
        return Ulong(ulong)

    def to_dict(self) -> dict:
        result: dict = {}
        result["ulong"] = from_int(self.ulong)
        return result


@dataclass
class Unchecked:
    unchecked: int

    @staticmethod
    def from_dict(obj: Any) -> 'Unchecked':
        assert isinstance(obj, dict)
        unchecked = from_int(obj["unchecked"])
        return Unchecked(unchecked)

    def to_dict(self) -> dict:
        result: dict = {}
        result["unchecked"] = from_int(self.unchecked)
        return result


@dataclass
class Undefined:
    undefined: int

    @staticmethod
    def from_dict(obj: Any) -> 'Undefined':
        assert isinstance(obj, dict)
        undefined = from_int(obj["undefined"])
        return Undefined(undefined)

    def to_dict(self) -> dict:
        result: dict = {}
        result["undefined"] = from_int(self.undefined)
        return result


@dataclass
class UnionClass:
    union: int

    @staticmethod
    def from_dict(obj: Any) -> 'UnionClass':
        assert isinstance(obj, dict)
        union = from_int(obj["union"])
        return UnionClass(union)

    def to_dict(self) -> dict:
        result: dict = {}
        result["union"] = from_int(self.union)
        return result


@dataclass
class UnmarshalJSON:
    unmarshal_json: int

    @staticmethod
    def from_dict(obj: Any) -> 'UnmarshalJSON':
        assert isinstance(obj, dict)
        unmarshal_json = from_int(obj["UnmarshalJSON"])
        return UnmarshalJSON(unmarshal_json)

    def to_dict(self) -> dict:
        result: dict = {}
        result["UnmarshalJSON"] = from_int(self.unmarshal_json)
        return result


@dataclass
class Unowned:
    unowned: int

    @staticmethod
    def from_dict(obj: Any) -> 'Unowned':
        assert isinstance(obj, dict)
        unowned = from_int(obj["unowned"])
        return Unowned(unowned)

    def to_dict(self) -> dict:
        result: dict = {}
        result["unowned"] = from_int(self.unowned)
        return result


@dataclass
class Unsafe:
    unsafe: int

    @staticmethod
    def from_dict(obj: Any) -> 'Unsafe':
        assert isinstance(obj, dict)
        unsafe = from_int(obj["unsafe"])
        return Unsafe(unsafe)

    def to_dict(self) -> dict:
        result: dict = {}
        result["unsafe"] = from_int(self.unsafe)
        return result


@dataclass
class Unsigned:
    unsigned: int

    @staticmethod
    def from_dict(obj: Any) -> 'Unsigned':
        assert isinstance(obj, dict)
        unsigned = from_int(obj["unsigned"])
        return Unsigned(unsigned)

    def to_dict(self) -> dict:
        result: dict = {}
        result["unsigned"] = from_int(self.unsigned)
        return result


@dataclass
class UseSerializers:
    use_serializers: int

    @staticmethod
    def from_dict(obj: Any) -> 'UseSerializers':
        assert isinstance(obj, dict)
        use_serializers = from_int(obj["UseSerializers"])
        return UseSerializers(use_serializers)

    def to_dict(self) -> dict:
        result: dict = {}
        result["UseSerializers"] = from_int(self.use_serializers)
        return result


@dataclass
class Ushort:
    ushort: int

    @staticmethod
    def from_dict(obj: Any) -> 'Ushort':
        assert isinstance(obj, dict)
        ushort = from_int(obj["ushort"])
        return Ushort(ushort)

    def to_dict(self) -> dict:
        result: dict = {}
        result["ushort"] = from_int(self.ushort)
        return result


@dataclass
class Using:
    using: int

    @staticmethod
    def from_dict(obj: Any) -> 'Using':
        assert isinstance(obj, dict)
        using = from_int(obj["using"])
        return Using(using)

    def to_dict(self) -> dict:
        result: dict = {}
        result["using"] = from_int(self.using)
        return result


@dataclass
class Utf8JSONReader:
    utf8_json_reader: int

    @staticmethod
    def from_dict(obj: Any) -> 'Utf8JSONReader':
        assert isinstance(obj, dict)
        utf8_json_reader = from_int(obj["Utf8JsonReader"])
        return Utf8JSONReader(utf8_json_reader)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Utf8JsonReader"] = from_int(self.utf8_json_reader)
        return result


@dataclass
class Utf8JSONWriter:
    utf8_json_writer: int

    @staticmethod
    def from_dict(obj: Any) -> 'Utf8JSONWriter':
        assert isinstance(obj, dict)
        utf8_json_writer = from_int(obj["Utf8JsonWriter"])
        return Utf8JSONWriter(utf8_json_writer)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Utf8JsonWriter"] = from_int(self.utf8_json_writer)
        return result


@dataclass
class UUIDClass:
    uuid: int

    @staticmethod
    def from_dict(obj: Any) -> 'UUIDClass':
        assert isinstance(obj, dict)
        uuid = from_int(obj["UUID"])
        return UUIDClass(uuid)

    def to_dict(self) -> dict:
        result: dict = {}
        result["UUID"] = from_int(self.uuid)
        return result


@dataclass
class Var:
    var: int

    @staticmethod
    def from_dict(obj: Any) -> 'Var':
        assert isinstance(obj, dict)
        var = from_int(obj["var"])
        return Var(var)

    def to_dict(self) -> dict:
        result: dict = {}
        result["var"] = from_int(self.var)
        return result


@dataclass
class Virtual:
    virtual: int

    @staticmethod
    def from_dict(obj: Any) -> 'Virtual':
        assert isinstance(obj, dict)
        virtual = from_int(obj["virtual"])
        return Virtual(virtual)

    def to_dict(self) -> dict:
        result: dict = {}
        result["virtual"] = from_int(self.virtual)
        return result


@dataclass
class Void:
    void: int

    @staticmethod
    def from_dict(obj: Any) -> 'Void':
        assert isinstance(obj, dict)
        void = from_int(obj["void"])
        return Void(void)

    def to_dict(self) -> dict:
        result: dict = {}
        result["void"] = from_int(self.void)
        return result


@dataclass
class Volatile:
    volatile: int

    @staticmethod
    def from_dict(obj: Any) -> 'Volatile':
        assert isinstance(obj, dict)
        volatile = from_int(obj["volatile"])
        return Volatile(volatile)

    def to_dict(self) -> dict:
        result: dict = {}
        result["volatile"] = from_int(self.volatile)
        return result


@dataclass
class WcharT:
    wchar_t: int

    @staticmethod
    def from_dict(obj: Any) -> 'WcharT':
        assert isinstance(obj, dict)
        wchar_t = from_int(obj["wchar_t"])
        return WcharT(wchar_t)

    def to_dict(self) -> dict:
        result: dict = {}
        result["wchar_t"] = from_int(self.wchar_t)
        return result


@dataclass
class Weak:
    weak: int

    @staticmethod
    def from_dict(obj: Any) -> 'Weak':
        assert isinstance(obj, dict)
        weak = from_int(obj["weak"])
        return Weak(weak)

    def to_dict(self) -> dict:
        result: dict = {}
        result["weak"] = from_int(self.weak)
        return result


@dataclass
class Where:
    where: int

    @staticmethod
    def from_dict(obj: Any) -> 'Where':
        assert isinstance(obj, dict)
        where = from_int(obj["where"])
        return Where(where)

    def to_dict(self) -> dict:
        result: dict = {}
        result["where"] = from_int(self.where)
        return result


@dataclass
class WillSet:
    will_set: int

    @staticmethod
    def from_dict(obj: Any) -> 'WillSet':
        assert isinstance(obj, dict)
        will_set = from_int(obj["willSet"])
        return WillSet(will_set)

    def to_dict(self) -> dict:
        result: dict = {}
        result["willSet"] = from_int(self.will_set)
        return result


@dataclass
class Xor:
    xor: int

    @staticmethod
    def from_dict(obj: Any) -> 'Xor':
        assert isinstance(obj, dict)
        xor = from_int(obj["xor"])
        return Xor(xor)

    def to_dict(self) -> dict:
        result: dict = {}
        result["xor"] = from_int(self.xor)
        return result


@dataclass
class XorEq:
    xor_eq: int

    @staticmethod
    def from_dict(obj: Any) -> 'XorEq':
        assert isinstance(obj, dict)
        xor_eq = from_int(obj["xor_eq"])
        return XorEq(xor_eq)

    def to_dict(self) -> dict:
        result: dict = {}
        result["xor_eq"] = from_int(self.xor_eq)
        return result


@dataclass
class Yes:
    yes: int

    @staticmethod
    def from_dict(obj: Any) -> 'Yes':
        assert isinstance(obj, dict)
        yes = from_int(obj["YES"])
        return Yes(yes)

    def to_dict(self) -> dict:
        result: dict = {}
        result["YES"] = from_int(self.yes)
        return result


@dataclass
class Obj6:
    type: TypeClass
    uuid: UUIDClass
    unmarshal_json: UnmarshalJSON
    use_serializers: UseSerializers
    utf8_json_reader: Utf8JSONReader
    utf8_json_writer: Utf8JSONWriter
    yes: Yes
    dummy: int
    obj6_try: Try
    obj6_type: Obj6Type
    typealias: Typealias
    typedef: Typedef
    typeid: Typeid
    typename: Typename
    typeof: Typeof
    uint: Uint
    ulong: Ulong
    unchecked: Unchecked
    undefined: Undefined
    union: UnionClass
    unowned: Unowned
    unsafe: Unsafe
    unsigned: Unsigned
    ushort: Ushort
    using: Using
    var: Var
    virtual: Virtual
    void: Void
    volatile: Volatile
    wchar_t: WcharT
    weak: Weak
    where: Where
    obj6_while: While
    will_set: WillSet
    obj6_with: With
    xor: Xor
    xor_eq: XorEq
    obj6_yield: Yield

    @staticmethod
    def from_dict(obj: Any) -> 'Obj6':
        assert isinstance(obj, dict)
        type = TypeClass.from_dict(obj["Type"])
        uuid = UUIDClass.from_dict(obj["UUID"])
        unmarshal_json = UnmarshalJSON.from_dict(obj["UnmarshalJSON"])
        use_serializers = UseSerializers.from_dict(obj["UseSerializers"])
        utf8_json_reader = Utf8JSONReader.from_dict(obj["Utf8JsonReader"])
        utf8_json_writer = Utf8JSONWriter.from_dict(obj["Utf8JsonWriter"])
        yes = Yes.from_dict(obj["YES"])
        dummy = from_int(obj["dummy"])
        obj6_try = Try.from_dict(obj["try"])
        obj6_type = Obj6Type.from_dict(obj["type"])
        typealias = Typealias.from_dict(obj["typealias"])
        typedef = Typedef.from_dict(obj["typedef"])
        typeid = Typeid.from_dict(obj["typeid"])
        typename = Typename.from_dict(obj["typename"])
        typeof = Typeof.from_dict(obj["typeof"])
        uint = Uint.from_dict(obj["uint"])
        ulong = Ulong.from_dict(obj["ulong"])
        unchecked = Unchecked.from_dict(obj["unchecked"])
        undefined = Undefined.from_dict(obj["undefined"])
        union = UnionClass.from_dict(obj["union"])
        unowned = Unowned.from_dict(obj["unowned"])
        unsafe = Unsafe.from_dict(obj["unsafe"])
        unsigned = Unsigned.from_dict(obj["unsigned"])
        ushort = Ushort.from_dict(obj["ushort"])
        using = Using.from_dict(obj["using"])
        var = Var.from_dict(obj["var"])
        virtual = Virtual.from_dict(obj["virtual"])
        void = Void.from_dict(obj["void"])
        volatile = Volatile.from_dict(obj["volatile"])
        wchar_t = WcharT.from_dict(obj["wchar_t"])
        weak = Weak.from_dict(obj["weak"])
        where = Where.from_dict(obj["where"])
        obj6_while = While.from_dict(obj["while"])
        will_set = WillSet.from_dict(obj["willSet"])
        obj6_with = With.from_dict(obj["with"])
        xor = Xor.from_dict(obj["xor"])
        xor_eq = XorEq.from_dict(obj["xor_eq"])
        obj6_yield = Yield.from_dict(obj["yield"])
        return Obj6(type, uuid, unmarshal_json, use_serializers, utf8_json_reader, utf8_json_writer, yes, dummy, obj6_try, obj6_type, typealias, typedef, typeid, typename, typeof, uint, ulong, unchecked, undefined, union, unowned, unsafe, unsigned, ushort, using, var, virtual, void, volatile, wchar_t, weak, where, obj6_while, will_set, obj6_with, xor, xor_eq, obj6_yield)

    def to_dict(self) -> dict:
        result: dict = {}
        result["Type"] = to_class(TypeClass, self.type)
        result["UUID"] = to_class(UUIDClass, self.uuid)
        result["UnmarshalJSON"] = to_class(UnmarshalJSON, self.unmarshal_json)
        result["UseSerializers"] = to_class(UseSerializers, self.use_serializers)
        result["Utf8JsonReader"] = to_class(Utf8JSONReader, self.utf8_json_reader)
        result["Utf8JsonWriter"] = to_class(Utf8JSONWriter, self.utf8_json_writer)
        result["YES"] = to_class(Yes, self.yes)
        result["dummy"] = from_int(self.dummy)
        result["try"] = to_class(Try, self.obj6_try)
        result["type"] = to_class(Obj6Type, self.obj6_type)
        result["typealias"] = to_class(Typealias, self.typealias)
        result["typedef"] = to_class(Typedef, self.typedef)
        result["typeid"] = to_class(Typeid, self.typeid)
        result["typename"] = to_class(Typename, self.typename)
        result["typeof"] = to_class(Typeof, self.typeof)
        result["uint"] = to_class(Uint, self.uint)
        result["ulong"] = to_class(Ulong, self.ulong)
        result["unchecked"] = to_class(Unchecked, self.unchecked)
        result["undefined"] = to_class(Undefined, self.undefined)
        result["union"] = to_class(UnionClass, self.union)
        result["unowned"] = to_class(Unowned, self.unowned)
        result["unsafe"] = to_class(Unsafe, self.unsafe)
        result["unsigned"] = to_class(Unsigned, self.unsigned)
        result["ushort"] = to_class(Ushort, self.ushort)
        result["using"] = to_class(Using, self.using)
        result["var"] = to_class(Var, self.var)
        result["virtual"] = to_class(Virtual, self.virtual)
        result["void"] = to_class(Void, self.void)
        result["volatile"] = to_class(Volatile, self.volatile)
        result["wchar_t"] = to_class(WcharT, self.wchar_t)
        result["weak"] = to_class(Weak, self.weak)
        result["where"] = to_class(Where, self.where)
        result["while"] = to_class(While, self.obj6_while)
        result["willSet"] = to_class(WillSet, self.will_set)
        result["with"] = to_class(With, self.obj6_with)
        result["xor"] = to_class(Xor, self.xor)
        result["xor_eq"] = to_class(XorEq, self.xor_eq)
        result["yield"] = to_class(Yield, self.obj6_yield)
        return result


@dataclass
class TopLevel:
    dummy: int
    obj1: Obj1
    obj2: Obj2
    obj3: Obj3
    obj4: Obj4
    obj5: Obj5
    obj6: Obj6

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        dummy = from_int(obj["dummy"])
        obj1 = Obj1.from_dict(obj["obj1"])
        obj2 = Obj2.from_dict(obj["obj2"])
        obj3 = Obj3.from_dict(obj["obj3"])
        obj4 = Obj4.from_dict(obj["obj4"])
        obj5 = Obj5.from_dict(obj["obj5"])
        obj6 = Obj6.from_dict(obj["obj6"])
        return TopLevel(dummy, obj1, obj2, obj3, obj4, obj5, obj6)

    def to_dict(self) -> dict:
        result: dict = {}
        result["dummy"] = from_int(self.dummy)
        result["obj1"] = to_class(Obj1, self.obj1)
        result["obj2"] = to_class(Obj2, self.obj2)
        result["obj3"] = to_class(Obj3, self.obj3)
        result["obj4"] = to_class(Obj4, self.obj4)
        result["obj5"] = to_class(Obj5, self.obj5)
        result["obj6"] = to_class(Obj6, self.obj6)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
