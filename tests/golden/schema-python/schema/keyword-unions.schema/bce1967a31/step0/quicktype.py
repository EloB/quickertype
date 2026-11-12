from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast


T = TypeVar("T")


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


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class Abstract:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Abstract':
        assert isinstance(obj, dict)
        return Abstract()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Alignas:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Alignas':
        assert isinstance(obj, dict)
        return Alignas()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Alignof:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Alignof':
        assert isinstance(obj, dict)
        return Alignof()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class AndEq:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'AndEq':
        assert isinstance(obj, dict)
        return AndEq()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class AnyClass:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'AnyClass':
        assert isinstance(obj, dict)
        return AnyClass()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Array:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Array':
        assert isinstance(obj, dict)
        return Array()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


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
class ASM:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'ASM':
        assert isinstance(obj, dict)
        return ASM()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Associatedtype:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Associatedtype':
        assert isinstance(obj, dict)
        return Associatedtype()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Associativity:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Associativity':
        assert isinstance(obj, dict)
        return Associativity()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Atomic:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Atomic':
        assert isinstance(obj, dict)
        return Atomic()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class AtomicCancel:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'AtomicCancel':
        assert isinstance(obj, dict)
        return AtomicCancel()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class AtomicCommit:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'AtomicCommit':
        assert isinstance(obj, dict)
        return AtomicCommit()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class AtomicNoexcept:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'AtomicNoexcept':
        assert isinstance(obj, dict)
        return AtomicNoexcept()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Auto:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Auto':
        assert isinstance(obj, dict)
        return Auto()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Base:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Base':
        assert isinstance(obj, dict)
        return Base()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Bitand:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Bitand':
        assert isinstance(obj, dict)
        return Bitand()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Bitor:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Bitor':
        assert isinstance(obj, dict)
        return Bitor()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Boolean:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Boolean':
        assert isinstance(obj, dict)
        return Boolean()

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
class Bycopy:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Bycopy':
        assert isinstance(obj, dict)
        return Bycopy()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Byref:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Byref':
        assert isinstance(obj, dict)
        return Byref()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Byte:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Byte':
        assert isinstance(obj, dict)
        return Byte()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Calendar:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Calendar':
        assert isinstance(obj, dict)
        return Calendar()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Case:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Case':
        assert isinstance(obj, dict)
        return Case()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Catch:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Catch':
        assert isinstance(obj, dict)
        return Catch()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Chan:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Chan':
        assert isinstance(obj, dict)
        return Chan()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Char:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Char':
        assert isinstance(obj, dict)
        return Char()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Char16T:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Char16T':
        assert isinstance(obj, dict)
        return Char16T()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Char32T:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Char32T':
        assert isinstance(obj, dict)
        return Char32T()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Checked:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Checked':
        assert isinstance(obj, dict)
        return Checked()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Clone:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Clone':
        assert isinstance(obj, dict)
        return Clone()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class CoAwait:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'CoAwait':
        assert isinstance(obj, dict)
        return CoAwait()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class CoReturn:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'CoReturn':
        assert isinstance(obj, dict)
        return CoReturn()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class CoYield:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'CoYield':
        assert isinstance(obj, dict)
        return CoYield()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Codable:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Codable':
        assert isinstance(obj, dict)
        return Codable()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class CodingKey:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'CodingKey':
        assert isinstance(obj, dict)
        return CodingKey()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class CodingKeys:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'CodingKeys':
        assert isinstance(obj, dict)
        return CodingKeys()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Compl:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Compl':
        assert isinstance(obj, dict)
        return Compl()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Complex:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Complex':
        assert isinstance(obj, dict)
        return Complex()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Concept:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Concept':
        assert isinstance(obj, dict)
        return Concept()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Console:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Console':
        assert isinstance(obj, dict)
        return Console()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Const:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Const':
        assert isinstance(obj, dict)
        return Const()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class ConstCast:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'ConstCast':
        assert isinstance(obj, dict)
        return ConstCast()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Constexpr:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Constexpr':
        assert isinstance(obj, dict)
        return Constexpr()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Constructor:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Constructor':
        assert isinstance(obj, dict)
        return Constructor()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Convenience:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Convenience':
        assert isinstance(obj, dict)
        return Convenience()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Convert:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Convert':
        assert isinstance(obj, dict)
        return Convert()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Converter:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Converter':
        assert isinstance(obj, dict)
        return Converter()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class CultureInfo:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'CultureInfo':
        assert isinstance(obj, dict)
        return CultureInfo()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Date:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Date':
        assert isinstance(obj, dict)
        return Date()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class DateFormatter:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'DateFormatter':
        assert isinstance(obj, dict)
        return DateFormatter()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class DateOnly:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'DateOnly':
        assert isinstance(obj, dict)
        return DateOnly()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class DateOnlyConverter:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'DateOnlyConverter':
        assert isinstance(obj, dict)
        return DateOnlyConverter()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class DateParseHandling:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'DateParseHandling':
        assert isinstance(obj, dict)
        return DateParseHandling()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class DateTime:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'DateTime':
        assert isinstance(obj, dict)
        return DateTime()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class DateTimeStyles:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'DateTimeStyles':
        assert isinstance(obj, dict)
        return DateTimeStyles()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Debugger:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Debugger':
        assert isinstance(obj, dict)
        return Debugger()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Decimal:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Decimal':
        assert isinstance(obj, dict)
        return Decimal()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Declare:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Declare':
        assert isinstance(obj, dict)
        return Declare()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Decltype:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Decltype':
        assert isinstance(obj, dict)
        return Decltype()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class DecodeString:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'DecodeString':
        assert isinstance(obj, dict)
        return DecodeString()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Decoder:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Decoder':
        assert isinstance(obj, dict)
        return Decoder()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class DecodingError:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'DecodingError':
        assert isinstance(obj, dict)
        return DecodingError()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Default:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Default':
        assert isinstance(obj, dict)
        return Default()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Defer:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Defer':
        assert isinstance(obj, dict)
        return Defer()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Deinit:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Deinit':
        assert isinstance(obj, dict)
        return Deinit()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Delegate:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Delegate':
        assert isinstance(obj, dict)
        return Delegate()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Delete:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Delete':
        assert isinstance(obj, dict)
        return Delete()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class DeserializationFeature:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'DeserializationFeature':
        assert isinstance(obj, dict)
        return DeserializationFeature()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Dictionary:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Dictionary':
        assert isinstance(obj, dict)
        return Dictionary()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class DidSet:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'DidSet':
        assert isinstance(obj, dict)
        return DidSet()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Do:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Do':
        assert isinstance(obj, dict)
        return Do()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Double:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Double':
        assert isinstance(obj, dict)
        return Double()

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
class Dynamic:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Dynamic':
        assert isinstance(obj, dict)
        return Dynamic()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class DynamicCast:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'DynamicCast':
        assert isinstance(obj, dict)
        return DynamicCast()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Empty:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Empty':
        assert isinstance(obj, dict)
        return Empty()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class EncodeQuickType:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'EncodeQuickType':
        assert isinstance(obj, dict)
        return EncodeQuickType()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Encoder:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Encoder':
        assert isinstance(obj, dict)
        return Encoder()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class EnumClass:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'EnumClass':
        assert isinstance(obj, dict)
        return EnumClass()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class EnumValues:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'EnumValues':
        assert isinstance(obj, dict)
        return EnumValues()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class EqualityContract:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'EqualityContract':
        assert isinstance(obj, dict)
        return EqualityContract()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Equatable:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Equatable':
        assert isinstance(obj, dict)
        return Equatable()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Event:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Event':
        assert isinstance(obj, dict)
        return Event()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Exception:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Exception':
        assert isinstance(obj, dict)
        return Exception()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Explicit:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Explicit':
        assert isinstance(obj, dict)
        return Explicit()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Export:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Export':
        assert isinstance(obj, dict)
        return Export()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Exposing:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Exposing':
        assert isinstance(obj, dict)
        return Exposing()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Extends:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Extends':
        assert isinstance(obj, dict)
        return Extends()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Extension:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Extension':
        assert isinstance(obj, dict)
        return Extension()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Extern:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Extern':
        assert isinstance(obj, dict)
        return Extern()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Fallthrough:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Fallthrough':
        assert isinstance(obj, dict)
        return Fallthrough()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class FalseClass:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'FalseClass':
        assert isinstance(obj, dict)
        return FalseClass()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Fileprivate:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Fileprivate':
        assert isinstance(obj, dict)
        return Fileprivate()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Final:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Final':
        assert isinstance(obj, dict)
        return Final()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Fixed:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Fixed':
        assert isinstance(obj, dict)
        return Fixed()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class UnionBoolBool:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'UnionBoolBool':
        assert isinstance(obj, dict)
        return UnionBoolBool()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Foreach:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Foreach':
        assert isinstance(obj, dict)
        return Foreach()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class FormatException:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'FormatException':
        assert isinstance(obj, dict)
        return FormatException()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Friend:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Friend':
        assert isinstance(obj, dict)
        return Friend()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class FromJSON:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'FromJSON':
        assert isinstance(obj, dict)
        return FromJSON()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Func:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Func':
        assert isinstance(obj, dict)
        return Func()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Function:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Function':
        assert isinstance(obj, dict)
        return Function()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Get:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Get':
        assert isinstance(obj, dict)
        return Get()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Go:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Go':
        assert isinstance(obj, dict)
        return Go()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Goto:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Goto':
        assert isinstance(obj, dict)
        return Goto()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Guard:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Guard':
        assert isinstance(obj, dict)
        return Guard()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class HasOwnProperty:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'HasOwnProperty':
        assert isinstance(obj, dict)
        return HasOwnProperty()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class HashCode:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'HashCode':
        assert isinstance(obj, dict)
        return HashCode()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Hashable:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Hashable':
        assert isinstance(obj, dict)
        return Hashable()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Hasher:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Hasher':
        assert isinstance(obj, dict)
        return Hasher()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class ID:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'ID':
        assert isinstance(obj, dict)
        return ID()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Imaginery:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Imaginery':
        assert isinstance(obj, dict)
        return Imaginery()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Imp:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Imp':
        assert isinstance(obj, dict)
        return Imp()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Implements:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Implements':
        assert isinstance(obj, dict)
        return Implements()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Implicit:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Implicit':
        assert isinstance(obj, dict)
        return Implicit()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Indirect:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Indirect':
        assert isinstance(obj, dict)
        return Indirect()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Infix:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Infix':
        assert isinstance(obj, dict)
        return Infix()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Init:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Init':
        assert isinstance(obj, dict)
        return Init()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Inline:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Inline':
        assert isinstance(obj, dict)
        return Inline()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Inout:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Inout':
        assert isinstance(obj, dict)
        return Inout()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Instanceof:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Instanceof':
        assert isinstance(obj, dict)
        return Instanceof()

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
class Interface:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Interface':
        assert isinstance(obj, dict)
        return Interface()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Internal:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Internal':
        assert isinstance(obj, dict)
        return Internal()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class ISODateTimeOffsetConverter:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'ISODateTimeOffsetConverter':
        assert isinstance(obj, dict)
        return ISODateTimeOffsetConverter()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class IterableClass:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'IterableClass':
        assert isinstance(obj, dict)
        return IterableClass()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Jdec:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Jdec':
        assert isinstance(obj, dict)
        return Jdec()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Jenc:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Jenc':
        assert isinstance(obj, dict)
        return Jenc()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Jpipe:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Jpipe':
        assert isinstance(obj, dict)
        return Jpipe()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class JSON:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'JSON':
        assert isinstance(obj, dict)
        return JSON()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class JSONAny:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'JSONAny':
        assert isinstance(obj, dict)
        return JSONAny()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class JSONCodingKey:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'JSONCodingKey':
        assert isinstance(obj, dict)
        return JSONCodingKey()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class JSONConverter:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'JSONConverter':
        assert isinstance(obj, dict)
        return JSONConverter()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class JSONDecoder:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'JSONDecoder':
        assert isinstance(obj, dict)
        return JSONDecoder()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class JSONEncoder:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'JSONEncoder':
        assert isinstance(obj, dict)
        return JSONEncoder()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class JSONException:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'JSONException':
        assert isinstance(obj, dict)
        return JSONException()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class JSONGenerator:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'JSONGenerator':
        assert isinstance(obj, dict)
        return JSONGenerator()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class JSONNode:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'JSONNode':
        assert isinstance(obj, dict)
        return JSONNode()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class JSONNull:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'JSONNull':
        assert isinstance(obj, dict)
        return JSONNull()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class JSONParser:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'JSONParser':
        assert isinstance(obj, dict)
        return JSONParser()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class JSONReader:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'JSONReader':
        assert isinstance(obj, dict)
        return JSONReader()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class JSONSerializer:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'JSONSerializer':
        assert isinstance(obj, dict)
        return JSONSerializer()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class JSONToken:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'JSONToken':
        assert isinstance(obj, dict)
        return JSONToken()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class JSONTokenType:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'JSONTokenType':
        assert isinstance(obj, dict)
        return JSONTokenType()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class JSONWriter:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'JSONWriter':
        assert isinstance(obj, dict)
        return JSONWriter()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class KSerializer:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'KSerializer':
        assert isinstance(obj, dict)
        return KSerializer()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Lazy:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Lazy':
        assert isinstance(obj, dict)
        return Lazy()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Left:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Left':
        assert isinstance(obj, dict)
        return Left()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Let:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Let':
        assert isinstance(obj, dict)
        return Let()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class ListClass:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'ListClass':
        assert isinstance(obj, dict)
        return ListClass()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class LocalDate:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'LocalDate':
        assert isinstance(obj, dict)
        return LocalDate()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Locale:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Locale':
        assert isinstance(obj, dict)
        return Locale()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Lock:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Lock':
        assert isinstance(obj, dict)
        return Lock()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Long:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Long':
        assert isinstance(obj, dict)
        return Long()

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
class Map:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Map':
        assert isinstance(obj, dict)
        return Map()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class MapEntry:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'MapEntry':
        assert isinstance(obj, dict)
        return MapEntry()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class MarshalJSON:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'MarshalJSON':
        assert isinstance(obj, dict)
        return MarshalJSON()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class MetadataPropertyHandling:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'MetadataPropertyHandling':
        assert isinstance(obj, dict)
        return MetadataPropertyHandling()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Module:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Module':
        assert isinstance(obj, dict)
        return Module()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Mutable:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Mutable':
        assert isinstance(obj, dict)
        return Mutable()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Mutating:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Mutating':
        assert isinstance(obj, dict)
        return Mutating()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Namespace:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Namespace':
        assert isinstance(obj, dict)
        return Namespace()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Native:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Native':
        assert isinstance(obj, dict)
        return Native()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class New:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'New':
        assert isinstance(obj, dict)
        return New()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Newtonsoft:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Newtonsoft':
        assert isinstance(obj, dict)
        return Newtonsoft()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Nil:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Nil':
        assert isinstance(obj, dict)
        return Nil()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class No:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'No':
        assert isinstance(obj, dict)
        return No()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class NoSuchMethod:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'NoSuchMethod':
        assert isinstance(obj, dict)
        return NoSuchMethod()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Noexcept:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Noexcept':
        assert isinstance(obj, dict)
        return Noexcept()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Nonatomic:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Nonatomic':
        assert isinstance(obj, dict)
        return Nonatomic()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class NoneClass:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'NoneClass':
        assert isinstance(obj, dict)
        return NoneClass()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Nonmutating:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Nonmutating':
        assert isinstance(obj, dict)
        return Nonmutating()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class NotEq:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'NotEq':
        assert isinstance(obj, dict)
        return NotEq()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class NSError:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'NSError':
        assert isinstance(obj, dict)
        return NSError()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class NSObject:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'NSObject':
        assert isinstance(obj, dict)
        return NSObject()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class NSString:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'NSString':
        assert isinstance(obj, dict)
        return NSString()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Null:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Null':
        assert isinstance(obj, dict)
        return Null()

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
class Nullptr:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Nullptr':
        assert isinstance(obj, dict)
        return Nullptr()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Number:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Number':
        assert isinstance(obj, dict)
        return Number()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Object:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Object':
        assert isinstance(obj, dict)
        return Object()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class ObjectMapper:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'ObjectMapper':
        assert isinstance(obj, dict)
        return ObjectMapper()

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
class ObjectReader:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'ObjectReader':
        assert isinstance(obj, dict)
        return ObjectReader()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class ObjectWriter:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'ObjectWriter':
        assert isinstance(obj, dict)
        return ObjectWriter()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Of:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Of':
        assert isinstance(obj, dict)
        return Of()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class OffsetDateTime:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'OffsetDateTime':
        assert isinstance(obj, dict)
        return OffsetDateTime()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class OffsetTime:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'OffsetTime':
        assert isinstance(obj, dict)
        return OffsetTime()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Oneway:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Oneway':
        assert isinstance(obj, dict)
        return Oneway()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Open:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Open':
        assert isinstance(obj, dict)
        return Open()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Operator:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Operator':
        assert isinstance(obj, dict)
        return Operator()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class OptionalClass:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'OptionalClass':
        assert isinstance(obj, dict)
        return OptionalClass()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class OrEq:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'OrEq':
        assert isinstance(obj, dict)
        return OrEq()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Out:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Out':
        assert isinstance(obj, dict)
        return Out()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Override:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Override':
        assert isinstance(obj, dict)
        return Override()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Package:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Package':
        assert isinstance(obj, dict)
        return Package()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Params:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Params':
        assert isinstance(obj, dict)
        return Params()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Port:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Port':
        assert isinstance(obj, dict)
        return Port()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Postfix:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Postfix':
        assert isinstance(obj, dict)
        return Postfix()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Precedence:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Precedence':
        assert isinstance(obj, dict)
        return Precedence()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Prefix:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Prefix':
        assert isinstance(obj, dict)
        return Prefix()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class PrimitiveKind:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'PrimitiveKind':
        assert isinstance(obj, dict)
        return PrimitiveKind()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class PrintMembers:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'PrintMembers':
        assert isinstance(obj, dict)
        return PrintMembers()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Printf:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Printf':
        assert isinstance(obj, dict)
        return Printf()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Private:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Private':
        assert isinstance(obj, dict)
        return Private()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Protected:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Protected':
        assert isinstance(obj, dict)
        return Protected()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Protocol:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Protocol':
        assert isinstance(obj, dict)
        return Protocol()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Public:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Public':
        assert isinstance(obj, dict)
        return Public()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class BoolClass:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'BoolClass':
        assert isinstance(obj, dict)
        return BoolClass()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class ClassClass:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'ClassClass':
        assert isinstance(obj, dict)
        return ClassClass()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class SelfClass:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'SelfClass':
        assert isinstance(obj, dict)
        return SelfClass()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Quicktype:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Quicktype':
        assert isinstance(obj, dict)
        return Quicktype()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Range:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Range':
        assert isinstance(obj, dict)
        return Range()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Readonly:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Readonly':
        assert isinstance(obj, dict)
        return Readonly()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Ref:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Ref':
        assert isinstance(obj, dict)
        return Ref()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class RegExp:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'RegExp':
        assert isinstance(obj, dict)
        return RegExp()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Register:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Register':
        assert isinstance(obj, dict)
        return Register()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class ReinterpretCast:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'ReinterpretCast':
        assert isinstance(obj, dict)
        return ReinterpretCast()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Repeat:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Repeat':
        assert isinstance(obj, dict)
        return Repeat()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Require:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Require':
        assert isinstance(obj, dict)
        return Require()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Required:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Required':
        assert isinstance(obj, dict)
        return Required()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Requires:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Requires':
        assert isinstance(obj, dict)
        return Requires()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Restrict:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Restrict':
        assert isinstance(obj, dict)
        return Restrict()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Retain:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Retain':
        assert isinstance(obj, dict)
        return Retain()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Rethrows:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Rethrows':
        assert isinstance(obj, dict)
        return Rethrows()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Right:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Right':
        assert isinstance(obj, dict)
        return Right()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class RuntimeType:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'RuntimeType':
        assert isinstance(obj, dict)
        return RuntimeType()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class S:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'S':
        assert isinstance(obj, dict)
        return S()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Sbyte:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Sbyte':
        assert isinstance(obj, dict)
        return Sbyte()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Sealed:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Sealed':
        assert isinstance(obj, dict)
        return Sealed()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Sel:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Sel':
        assert isinstance(obj, dict)
        return Sel()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Select:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Select':
        assert isinstance(obj, dict)
        return Select()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Sendable:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Sendable':
        assert isinstance(obj, dict)
        return Sendable()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class SerialDescriptor:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'SerialDescriptor':
        assert isinstance(obj, dict)
        return SerialDescriptor()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class SerialName:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'SerialName':
        assert isinstance(obj, dict)
        return SerialName()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Serializable:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Serializable':
        assert isinstance(obj, dict)
        return Serializable()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class SerializationFeature:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'SerializationFeature':
        assert isinstance(obj, dict)
        return SerializationFeature()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Serialize:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Serialize':
        assert isinstance(obj, dict)
        return Serialize()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class SerializerProvider:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'SerializerProvider':
        assert isinstance(obj, dict)
        return SerializerProvider()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Set:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Set':
        assert isinstance(obj, dict)
        return Set()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Short:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Short':
        assert isinstance(obj, dict)
        return Short()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Signed:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Signed':
        assert isinstance(obj, dict)
        return Signed()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class SimpleModule:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'SimpleModule':
        assert isinstance(obj, dict)
        return SimpleModule()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Sizeof:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Sizeof':
        assert isinstance(obj, dict)
        return Sizeof()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Stackalloc:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Stackalloc':
        assert isinstance(obj, dict)
        return Stackalloc()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Standards:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Standards':
        assert isinstance(obj, dict)
        return Standards()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Static:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Static':
        assert isinstance(obj, dict)
        return Static()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class StaticAssert:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'StaticAssert':
        assert isinstance(obj, dict)
        return StaticAssert()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class StaticCast:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'StaticCast':
        assert isinstance(obj, dict)
        return StaticCast()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class StdDeserializer:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'StdDeserializer':
        assert isinstance(obj, dict)
        return StdDeserializer()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class StdSerializer:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'StdSerializer':
        assert isinstance(obj, dict)
        return StdSerializer()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Strictfp:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Strictfp':
        assert isinstance(obj, dict)
        return Strictfp()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class String:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'String':
        assert isinstance(obj, dict)
        return String()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Struct:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Struct':
        assert isinstance(obj, dict)
        return Struct()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Subscript:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Subscript':
        assert isinstance(obj, dict)
        return Subscript()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Super:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Super':
        assert isinstance(obj, dict)
        return Super()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Switch:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Switch':
        assert isinstance(obj, dict)
        return Switch()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Symbol:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Symbol':
        assert isinstance(obj, dict)
        return Symbol()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Synchronized:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Synchronized':
        assert isinstance(obj, dict)
        return Synchronized()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class System:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'System':
        assert isinstance(obj, dict)
        return System()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Template:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Template':
        assert isinstance(obj, dict)
        return Template()

    def to_dict(self) -> dict:
        result: dict = {}
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
class Then:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Then':
        assert isinstance(obj, dict)
        return Then()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class This:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'This':
        assert isinstance(obj, dict)
        return This()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class ThreadLocal:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'ThreadLocal':
        assert isinstance(obj, dict)
        return ThreadLocal()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Throw:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Throw':
        assert isinstance(obj, dict)
        return Throw()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Throws:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Throws':
        assert isinstance(obj, dict)
        return Throws()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class TimeOnly:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'TimeOnly':
        assert isinstance(obj, dict)
        return TimeOnly()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class TimeOnlyConverter:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'TimeOnlyConverter':
        assert isinstance(obj, dict)
        return TimeOnlyConverter()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class TimeZone:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'TimeZone':
        assert isinstance(obj, dict)
        return TimeZone()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class ToJSON:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'ToJSON':
        assert isinstance(obj, dict)
        return ToJSON()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class ToString:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'ToString':
        assert isinstance(obj, dict)
        return ToString()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class TopLevelClass:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevelClass':
        assert isinstance(obj, dict)
        return TopLevelClass()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class And:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'And':
        assert isinstance(obj, dict)
        return And()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class UnionAnyAny:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'UnionAnyAny':
        assert isinstance(obj, dict)
        return UnionAnyAny()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class As:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'As':
        assert isinstance(obj, dict)
        return As()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Assert:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Assert':
        assert isinstance(obj, dict)
        return Assert()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Async:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Async':
        assert isinstance(obj, dict)
        return Async()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Await:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Await':
        assert isinstance(obj, dict)
        return Await()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Bool:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Bool':
        assert isinstance(obj, dict)
        return Bool()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Break:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Break':
        assert isinstance(obj, dict)
        return Break()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Class:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Class':
        assert isinstance(obj, dict)
        return Class()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Continue:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Continue':
        assert isinstance(obj, dict)
        return Continue()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Def:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Def':
        assert isinstance(obj, dict)
        return Def()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Del:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Del':
        assert isinstance(obj, dict)
        return Del()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class DictClass:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'DictClass':
        assert isinstance(obj, dict)
        return DictClass()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Elif:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Elif':
        assert isinstance(obj, dict)
        return Elif()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Else:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Else':
        assert isinstance(obj, dict)
        return Else()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Except:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Except':
        assert isinstance(obj, dict)
        return Except()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class UnionFalseFalse:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'UnionFalseFalse':
        assert isinstance(obj, dict)
        return UnionFalseFalse()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Finally:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Finally':
        assert isinstance(obj, dict)
        return Finally()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Float:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Float':
        assert isinstance(obj, dict)
        return Float()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class For:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'For':
        assert isinstance(obj, dict)
        return For()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class From:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'From':
        assert isinstance(obj, dict)
        return From()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class FromDict:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'FromDict':
        assert isinstance(obj, dict)
        return FromDict()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Global:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Global':
        assert isinstance(obj, dict)
        return Global()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class If:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'If':
        assert isinstance(obj, dict)
        return If()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Import:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Import':
        assert isinstance(obj, dict)
        return Import()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class In:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'In':
        assert isinstance(obj, dict)
        return In()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Int:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Int':
        assert isinstance(obj, dict)
        return Int()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Is:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Is':
        assert isinstance(obj, dict)
        return Is()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Lambda:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Lambda':
        assert isinstance(obj, dict)
        return Lambda()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class UnionNoneNone:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'UnionNoneNone':
        assert isinstance(obj, dict)
        return UnionNoneNone()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Nonlocal:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Nonlocal':
        assert isinstance(obj, dict)
        return Nonlocal()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Not:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Not':
        assert isinstance(obj, dict)
        return Not()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class NullClass:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'NullClass':
        assert isinstance(obj, dict)
        return NullClass()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Or:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Or':
        assert isinstance(obj, dict)
        return Or()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Pass:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Pass':
        assert isinstance(obj, dict)
        return Pass()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Print:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Print':
        assert isinstance(obj, dict)
        return Print()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class ProtocolClass:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'ProtocolClass':
        assert isinstance(obj, dict)
        return ProtocolClass()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Raise:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Raise':
        assert isinstance(obj, dict)
        return Raise()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Return:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Return':
        assert isinstance(obj, dict)
        return Return()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Self:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Self':
        assert isinstance(obj, dict)
        return Self()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class ToDict:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'ToDict':
        assert isinstance(obj, dict)
        return ToDict()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class UnionTrueTrue:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'UnionTrueTrue':
        assert isinstance(obj, dict)
        return UnionTrueTrue()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Try:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Try':
        assert isinstance(obj, dict)
        return Try()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class UnionTypeType:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'UnionTypeType':
        assert isinstance(obj, dict)
        return UnionTypeType()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class While:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'While':
        assert isinstance(obj, dict)
        return While()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class With:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'With':
        assert isinstance(obj, dict)
        return With()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Yield:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Yield':
        assert isinstance(obj, dict)
        return Yield()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Transient:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Transient':
        assert isinstance(obj, dict)
        return Transient()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class TrueClass:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'TrueClass':
        assert isinstance(obj, dict)
        return TrueClass()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class TypeClass:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'TypeClass':
        assert isinstance(obj, dict)
        return TypeClass()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Typealias:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Typealias':
        assert isinstance(obj, dict)
        return Typealias()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Typedef:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Typedef':
        assert isinstance(obj, dict)
        return Typedef()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Typeid:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Typeid':
        assert isinstance(obj, dict)
        return Typeid()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Typename:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Typename':
        assert isinstance(obj, dict)
        return Typename()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Typeof:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Typeof':
        assert isinstance(obj, dict)
        return Typeof()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Uint:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Uint':
        assert isinstance(obj, dict)
        return Uint()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Ulong:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Ulong':
        assert isinstance(obj, dict)
        return Ulong()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Unchecked:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Unchecked':
        assert isinstance(obj, dict)
        return Unchecked()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Undefined:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Undefined':
        assert isinstance(obj, dict)
        return Undefined()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class UnionClass:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'UnionClass':
        assert isinstance(obj, dict)
        return UnionClass()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class UnmarshalJSON:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'UnmarshalJSON':
        assert isinstance(obj, dict)
        return UnmarshalJSON()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Unowned:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Unowned':
        assert isinstance(obj, dict)
        return Unowned()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Unsafe:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Unsafe':
        assert isinstance(obj, dict)
        return Unsafe()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Unsigned:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Unsigned':
        assert isinstance(obj, dict)
        return Unsigned()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class UseSerializers:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'UseSerializers':
        assert isinstance(obj, dict)
        return UseSerializers()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Ushort:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Ushort':
        assert isinstance(obj, dict)
        return Ushort()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Using:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Using':
        assert isinstance(obj, dict)
        return Using()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Utf8JSONReader:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Utf8JSONReader':
        assert isinstance(obj, dict)
        return Utf8JSONReader()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Utf8JSONWriter:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Utf8JSONWriter':
        assert isinstance(obj, dict)
        return Utf8JSONWriter()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class UUIDClass:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'UUIDClass':
        assert isinstance(obj, dict)
        return UUIDClass()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Var:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Var':
        assert isinstance(obj, dict)
        return Var()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Virtual:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Virtual':
        assert isinstance(obj, dict)
        return Virtual()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Void:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Void':
        assert isinstance(obj, dict)
        return Void()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Volatile:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Volatile':
        assert isinstance(obj, dict)
        return Volatile()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class WcharT:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'WcharT':
        assert isinstance(obj, dict)
        return WcharT()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Weak:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Weak':
        assert isinstance(obj, dict)
        return Weak()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Where:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Where':
        assert isinstance(obj, dict)
        return Where()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class WillSet:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'WillSet':
        assert isinstance(obj, dict)
        return WillSet()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Xor:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Xor':
        assert isinstance(obj, dict)
        return Xor()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class XorEq:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'XorEq':
        assert isinstance(obj, dict)
        return XorEq()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class Yes:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Yes':
        assert isinstance(obj, dict)
        return Yes()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class TopLevel:
    empty: float | Empty | None = None
    purple_bool: float | BoolClass | None = None
    complex: float | Complex | None = None
    imaginery: float | Imaginery | None = None
    abstract: float | Abstract | None = None
    alignas: float | Alignas | None = None
    alignof: float | Alignof | None = None
    top_level_and: float | And | None = None
    and_eq: float | AndEq | None = None
    top_level_any: float | UnionAnyAny | None = None
    any: float | AnyClass | None = None
    array: float | Array | None = None
    array_node: float | ArrayNode | None = None
    top_level_as: float | As | None = None
    asm: float | ASM | None = None
    top_level_assert: float | Assert | None = None
    associatedtype: float | Associatedtype | None = None
    associativity: float | Associativity | None = None
    top_level_async: float | Async | None = None
    atomic: float | Atomic | None = None
    atomic_cancel: float | AtomicCancel | None = None
    atomic_commit: float | AtomicCommit | None = None
    atomic_noexcept: float | AtomicNoexcept | None = None
    auto: float | Auto | None = None
    top_level_await: float | Await | None = None
    base: float | Base | None = None
    bitand: float | Bitand | None = None
    bitor: float | Bitor | None = None
    top_level_bool: float | Bool | None = None
    fluffy_bool: float | UnionBoolBool | None = None
    boolean: float | Boolean | None = None
    boolean_node: float | BooleanNode | None = None
    top_level_break: float | Break | None = None
    bycopy: float | Bycopy | None = None
    byref: float | Byref | None = None
    byte: float | Byte | None = None
    calendar: float | Calendar | None = None
    case: float | Case | None = None
    catch: float | Catch | None = None
    chan: float | Chan | None = None
    char: float | Char | None = None
    char16_t: float | Char16T | None = None
    char32_t: float | Char32T | None = None
    checked: float | Checked | None = None
    purple_class: float | ClassClass | None = None
    top_level_class: float | Class | None = None
    clone: float | Clone | None = None
    co_await: float | CoAwait | None = None
    co_return: float | CoReturn | None = None
    co_yield: float | CoYield | None = None
    codable: float | Codable | None = None
    coding_key: float | CodingKey | None = None
    coding_keys: float | CodingKeys | None = None
    compl: float | Compl | None = None
    concept: float | Concept | None = None
    console: float | Console | None = None
    const: float | Const | None = None
    const_cast: float | ConstCast | None = None
    constexpr: float | Constexpr | None = None
    constructor: float | Constructor | None = None
    top_level_continue: float | Continue | None = None
    convenience: float | Convenience | None = None
    convert: float | Convert | None = None
    converter: float | Converter | None = None
    culture_info: float | CultureInfo | None = None
    date: float | Date | None = None
    date_parse_handling: float | DateParseHandling | None = None
    date_formatter: float | DateFormatter | None = None
    date_only: float | DateOnly | None = None
    date_only_converter: float | DateOnlyConverter | None = None
    date_time: float | DateTime | None = None
    date_time_styles: float | DateTimeStyles | None = None
    debugger: float | Debugger | None = None
    decimal: float | Decimal | None = None
    declare: float | Declare | None = None
    decltype: float | Decltype | None = None
    decode_string: float | DecodeString | None = None
    decoder: float | Decoder | None = None
    decoding_error: float | DecodingError | None = None
    top_level_def: float | Def | None = None
    default: float | Default | None = None
    defer: float | Defer | None = None
    deinit: float | Deinit | None = None
    top_level_del: float | Del | None = None
    delegate: float | Delegate | None = None
    delete: float | Delete | None = None
    deserialization_feature: float | DeserializationFeature | None = None
    top_level_dict: float | DictClass | None = None
    dictionary: float | Dictionary | None = None
    did_set: float | DidSet | None = None
    do: float | Do | None = None
    double: float | Double | None = None
    double_node: float | DoubleNode | None = None
    dummy: float | None = None
    dynamic: float | Dynamic | None = None
    dynamic_cast: float | DynamicCast | None = None
    top_level_elif: float | Elif | None = None
    top_level_else: float | Else | None = None
    encode_quick_type: float | EncodeQuickType | None = None
    encoder: float | Encoder | None = None
    enum: float | EnumClass | None = None
    enum_values: float | EnumValues | None = None
    equality_contract: float | EqualityContract | None = None
    equatable: float | Equatable | None = None
    event: float | Event | None = None
    top_level_except: float | Except | None = None
    exception: float | Exception | None = None
    explicit: float | Explicit | None = None
    export: float | Export | None = None
    exposing: float | Exposing | None = None
    extends: float | Extends | None = None
    extension: float | Extension | None = None
    extern: float | Extern | None = None
    fallthrough: float | Fallthrough | None = None
    top_level_false: float | UnionFalseFalse | None = None
    false: float | FalseClass | None = None
    fileprivate: float | Fileprivate | None = None
    final: float | Final | None = None
    top_level_finally: float | Finally | None = None
    fixed: float | Fixed | None = None
    top_level_float: float | Float | None = None
    top_level_for: float | For | None = None
    foreach: float | Foreach | None = None
    format_exception: float | FormatException | None = None
    friend: float | Friend | None = None
    top_level_from: float | From | None = None
    top_level_from_dict: float | FromDict | None = None
    from_json: float | FromJSON | None = None
    func: float | Func | None = None
    function: float | Function | None = None
    get: float | Get | None = None
    top_level_global: float | Global | None = None
    go: float | Go | None = None
    goto: float | Goto | None = None
    guard: float | Guard | None = None
    hashable: float | Hashable | None = None
    hash_code: float | HashCode | None = None
    hasher: float | Hasher | None = None
    has_own_property: float | HasOwnProperty | None = None
    id: float | ID | None = None
    top_level_if: float | If | None = None
    imp: float | Imp | None = None
    implements: float | Implements | None = None
    implicit: float | Implicit | None = None
    top_level_import: float | Import | None = None
    top_level_in: float | In | None = None
    indirect: float | Indirect | None = None
    infix: float | Infix | None = None
    init: float | Init | None = None
    inline: float | Inline | None = None
    inout: float | Inout | None = None
    instanceof: float | Instanceof | None = None
    top_level_int: float | Int | None = None
    interface: float | Interface | None = None
    internal: float | Internal | None = None
    int_node: float | IntNode | None = None
    top_level_is: float | Is | None = None
    iso_date_time_offset_converter: float | ISODateTimeOffsetConverter | None = None
    iterable: float | IterableClass | None = None
    jdec: float | Jdec | None = None
    jenc: float | Jenc | None = None
    jpipe: float | Jpipe | None = None
    json: float | JSON | None = None
    json_converter: float | JSONConverter | None = None
    json_serializer: float | JSONSerializer | None = None
    json_token: float | JSONToken | None = None
    json_writer: float | JSONWriter | None = None
    json_any: float | JSONAny | None = None
    json_coding_key: float | JSONCodingKey | None = None
    json_decoder: float | JSONDecoder | None = None
    json_encoder: float | JSONEncoder | None = None
    json_exception: float | JSONException | None = None
    json_generator: float | JSONGenerator | None = None
    json_node: float | JSONNode | None = None
    json_null: float | JSONNull | None = None
    json_parser: float | JSONParser | None = None
    json_reader: float | JSONReader | None = None
    json_token_type: float | JSONTokenType | None = None
    k_serializer: float | KSerializer | None = None
    top_level_lambda: float | Lambda | None = None
    lazy: float | Lazy | None = None
    left: float | Left | None = None
    let: float | Let | None = None
    list: float | ListClass | None = None
    local_date: float | LocalDate | None = None
    locale: float | Locale | None = None
    lock: float | Lock | None = None
    long: float | Long | None = None
    long_node: float | LongNode | None = None
    map: float | Map | None = None
    map_entry: float | MapEntry | None = None
    marshal_json: float | MarshalJSON | None = None
    metadata_property_handling: float | MetadataPropertyHandling | None = None
    module: float | Module | None = None
    mutable: float | Mutable | None = None
    mutating: float | Mutating | None = None
    namespace: float | Namespace | None = None
    native: float | Native | None = None
    new: float | New | None = None
    newtonsoft: float | Newtonsoft | None = None
    nil: float | Nil | None = None
    no: float | No | None = None
    noexcept: float | Noexcept | None = None
    nonatomic: float | Nonatomic | None = None
    top_level_none: float | UnionNoneNone | None = None
    none: float | NoneClass | None = None
    top_level_nonlocal: float | Nonlocal | None = None
    nonmutating: float | Nonmutating | None = None
    no_such_method: float | NoSuchMethod | None = None
    top_level_not: float | Not | None = None
    not_eq: float | NotEq | None = None
    ns_error: float | NSError | None = None
    ns_object: float | NSObject | None = None
    ns_string: float | NSString | None = None
    null: float | Null | None = None
    top_level_null: float | NullClass | None = None
    null_node: float | NullNode | None = None
    nullptr: float | Nullptr | None = None
    number: float | Number | None = None
    object: float | Object | None = None
    object_mapper: float | ObjectMapper | None = None
    object_node: float | ObjectNode | None = None
    object_reader: float | ObjectReader | None = None
    object_writer: float | ObjectWriter | None = None
    of: float | Of | None = None
    offset_date_time: float | OffsetDateTime | None = None
    offset_time: float | OffsetTime | None = None
    oneway: float | Oneway | None = None
    open: float | Open | None = None
    operator: float | Operator | None = None
    optional: float | OptionalClass | None = None
    top_level_or: float | Or | None = None
    or_eq: float | OrEq | None = None
    out: float | Out | None = None
    override: float | Override | None = None
    package: float | Package | None = None
    params: float | Params | None = None
    top_level_pass: float | Pass | None = None
    port: float | Port | None = None
    postfix: float | Postfix | None = None
    precedence: float | Precedence | None = None
    prefix: float | Prefix | None = None
    primitive_kind: float | PrimitiveKind | None = None
    top_level_print: float | Print | None = None
    printf: float | Printf | None = None
    print_members: float | PrintMembers | None = None
    private: float | Private | None = None
    protected: float | Protected | None = None
    protocol: float | Protocol | None = None
    top_level_protocol: float | ProtocolClass | None = None
    public: float | Public | None = None
    quicktype: float | Quicktype | None = None
    top_level_raise: float | Raise | None = None
    range: float | Range | None = None
    readonly: float | Readonly | None = None
    ref: float | Ref | None = None
    reg_exp: float | RegExp | None = None
    register: float | Register | None = None
    reinterpret_cast: float | ReinterpretCast | None = None
    repeat: float | Repeat | None = None
    require: float | Require | None = None
    required: float | Required | None = None
    requires: float | Requires | None = None
    restrict: float | Restrict | None = None
    retain: float | Retain | None = None
    rethrows: float | Rethrows | None = None
    top_level_return: float | Return | None = None
    right: float | Right | None = None
    runtime_type: float | RuntimeType | None = None
    s: float | S | None = None
    sbyte: float | Sbyte | None = None
    sealed: float | Sealed | None = None
    sel: float | Sel | None = None
    select: float | Select | None = None
    top_level_self: float | Self | None = None
    purple_self: float | SelfClass | None = None
    sendable: float | Sendable | None = None
    serial_descriptor: float | SerialDescriptor | None = None
    serializable: float | Serializable | None = None
    serialization_feature: float | SerializationFeature | None = None
    serialize: float | Serialize | None = None
    serializer_provider: float | SerializerProvider | None = None
    serial_name: float | SerialName | None = None
    set: float | Set | None = None
    short: float | Short | None = None
    signed: float | Signed | None = None
    simple_module: float | SimpleModule | None = None
    sizeof: float | Sizeof | None = None
    stackalloc: float | Stackalloc | None = None
    standards: float | Standards | None = None
    static: float | Static | None = None
    static_assert: float | StaticAssert | None = None
    static_cast: float | StaticCast | None = None
    std_deserializer: float | StdDeserializer | None = None
    std_serializer: float | StdSerializer | None = None
    strictfp: float | Strictfp | None = None
    string: float | String | None = None
    struct: float | Struct | None = None
    subscript: float | Subscript | None = None
    super: float | Super | None = None
    switch: float | Switch | None = None
    symbol: float | Symbol | None = None
    synchronized: float | Synchronized | None = None
    system: float | System | None = None
    template: float | Template | None = None
    text_node: float | TextNode | None = None
    then: float | Then | None = None
    this: float | This | None = None
    thread_local: float | ThreadLocal | None = None
    throw: float | Throw | None = None
    throws: float | Throws | None = None
    time_only: float | TimeOnly | None = None
    time_only_converter: float | TimeOnlyConverter | None = None
    time_zone: float | TimeZone | None = None
    top_level_to_dict: float | ToDict | None = None
    to_json: float | ToJSON | None = None
    top_level: float | TopLevelClass | None = None
    to_string: float | ToString | None = None
    transient: float | Transient | None = None
    true: float | TrueClass | None = None
    top_level_true: float | UnionTrueTrue | None = None
    top_level_try: float | Try | None = None
    type: float | TypeClass | None = None
    top_level_type: float | UnionTypeType | None = None
    typealias: float | Typealias | None = None
    typedef: float | Typedef | None = None
    typeid: float | Typeid | None = None
    typename: float | Typename | None = None
    typeof: float | Typeof | None = None
    uint: float | Uint | None = None
    ulong: float | Ulong | None = None
    unchecked: float | Unchecked | None = None
    undefined: float | Undefined | None = None
    union: float | UnionClass | None = None
    unmarshal_json: float | UnmarshalJSON | None = None
    unowned: float | Unowned | None = None
    unsafe: float | Unsafe | None = None
    unsigned: float | Unsigned | None = None
    use_serializers: float | UseSerializers | None = None
    ushort: float | Ushort | None = None
    using: float | Using | None = None
    utf8_json_reader: float | Utf8JSONReader | None = None
    utf8_json_writer: float | Utf8JSONWriter | None = None
    uuid: float | UUIDClass | None = None
    var: float | Var | None = None
    virtual: float | Virtual | None = None
    void: float | Void | None = None
    volatile: float | Volatile | None = None
    wchar_t: float | WcharT | None = None
    weak: float | Weak | None = None
    where: float | Where | None = None
    top_level_while: float | While | None = None
    will_set: float | WillSet | None = None
    top_level_with: float | With | None = None
    xor: float | Xor | None = None
    xor_eq: float | XorEq | None = None
    yes: float | Yes | None = None
    top_level_yield: float | Yield | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        empty = from_union([from_float, Empty.from_dict, from_none], obj.get("_"))
        purple_bool = from_union([from_float, BoolClass.from_dict, from_none], obj.get("_Bool"))
        complex = from_union([from_float, Complex.from_dict, from_none], obj.get("_Complex"))
        imaginery = from_union([from_float, Imaginery.from_dict, from_none], obj.get("_Imaginery"))
        abstract = from_union([from_float, Abstract.from_dict, from_none], obj.get("abstract"))
        alignas = from_union([from_float, Alignas.from_dict, from_none], obj.get("alignas"))
        alignof = from_union([from_float, Alignof.from_dict, from_none], obj.get("alignof"))
        top_level_and = from_union([from_float, And.from_dict, from_none], obj.get("and"))
        and_eq = from_union([from_float, AndEq.from_dict, from_none], obj.get("and_eq"))
        top_level_any = from_union([from_float, UnionAnyAny.from_dict, from_none], obj.get("any"))
        any = from_union([from_float, AnyClass.from_dict, from_none], obj.get("Any"))
        array = from_union([from_float, Array.from_dict, from_none], obj.get("array"))
        array_node = from_union([from_float, ArrayNode.from_dict, from_none], obj.get("ArrayNode"))
        top_level_as = from_union([from_float, As.from_dict, from_none], obj.get("as"))
        asm = from_union([from_float, ASM.from_dict, from_none], obj.get("asm"))
        top_level_assert = from_union([from_float, Assert.from_dict, from_none], obj.get("assert"))
        associatedtype = from_union([from_float, Associatedtype.from_dict, from_none], obj.get("associatedtype"))
        associativity = from_union([from_float, Associativity.from_dict, from_none], obj.get("associativity"))
        top_level_async = from_union([from_float, Async.from_dict, from_none], obj.get("async"))
        atomic = from_union([from_float, Atomic.from_dict, from_none], obj.get("atomic"))
        atomic_cancel = from_union([from_float, AtomicCancel.from_dict, from_none], obj.get("atomic_cancel"))
        atomic_commit = from_union([from_float, AtomicCommit.from_dict, from_none], obj.get("atomic_commit"))
        atomic_noexcept = from_union([from_float, AtomicNoexcept.from_dict, from_none], obj.get("atomic_noexcept"))
        auto = from_union([from_float, Auto.from_dict, from_none], obj.get("auto"))
        top_level_await = from_union([from_float, Await.from_dict, from_none], obj.get("await"))
        base = from_union([from_float, Base.from_dict, from_none], obj.get("base"))
        bitand = from_union([from_float, Bitand.from_dict, from_none], obj.get("bitand"))
        bitor = from_union([from_float, Bitor.from_dict, from_none], obj.get("bitor"))
        top_level_bool = from_union([from_float, Bool.from_dict, from_none], obj.get("BOOL"))
        fluffy_bool = from_union([from_float, UnionBoolBool.from_dict, from_none], obj.get("bool"))
        boolean = from_union([from_float, Boolean.from_dict, from_none], obj.get("boolean"))
        boolean_node = from_union([from_float, BooleanNode.from_dict, from_none], obj.get("BooleanNode"))
        top_level_break = from_union([from_float, Break.from_dict, from_none], obj.get("break"))
        bycopy = from_union([from_float, Bycopy.from_dict, from_none], obj.get("bycopy"))
        byref = from_union([from_float, Byref.from_dict, from_none], obj.get("byref"))
        byte = from_union([from_float, Byte.from_dict, from_none], obj.get("byte"))
        calendar = from_union([from_float, Calendar.from_dict, from_none], obj.get("Calendar"))
        case = from_union([from_float, Case.from_dict, from_none], obj.get("case"))
        catch = from_union([from_float, Catch.from_dict, from_none], obj.get("catch"))
        chan = from_union([from_float, Chan.from_dict, from_none], obj.get("chan"))
        char = from_union([from_float, Char.from_dict, from_none], obj.get("char"))
        char16_t = from_union([from_float, Char16T.from_dict, from_none], obj.get("char16_t"))
        char32_t = from_union([from_float, Char32T.from_dict, from_none], obj.get("char32_t"))
        checked = from_union([from_float, Checked.from_dict, from_none], obj.get("checked"))
        purple_class = from_union([from_float, ClassClass.from_dict, from_none], obj.get("class"))
        top_level_class = from_union([from_float, Class.from_dict, from_none], obj.get("Class"))
        clone = from_union([from_float, Clone.from_dict, from_none], obj.get("clone"))
        co_await = from_union([from_float, CoAwait.from_dict, from_none], obj.get("co_await"))
        co_return = from_union([from_float, CoReturn.from_dict, from_none], obj.get("co_return"))
        co_yield = from_union([from_float, CoYield.from_dict, from_none], obj.get("co_yield"))
        codable = from_union([from_float, Codable.from_dict, from_none], obj.get("Codable"))
        coding_key = from_union([from_float, CodingKey.from_dict, from_none], obj.get("CodingKey"))
        coding_keys = from_union([from_float, CodingKeys.from_dict, from_none], obj.get("CodingKeys"))
        compl = from_union([from_float, Compl.from_dict, from_none], obj.get("compl"))
        concept = from_union([from_float, Concept.from_dict, from_none], obj.get("concept"))
        console = from_union([from_float, Console.from_dict, from_none], obj.get("console"))
        const = from_union([from_float, Const.from_dict, from_none], obj.get("const"))
        const_cast = from_union([from_float, ConstCast.from_dict, from_none], obj.get("const_cast"))
        constexpr = from_union([from_float, Constexpr.from_dict, from_none], obj.get("constexpr"))
        constructor = from_union([from_float, Constructor.from_dict, from_none], obj.get("constructor"))
        top_level_continue = from_union([from_float, Continue.from_dict, from_none], obj.get("continue"))
        convenience = from_union([from_float, Convenience.from_dict, from_none], obj.get("convenience"))
        convert = from_union([from_float, Convert.from_dict, from_none], obj.get("convert"))
        converter = from_union([from_float, Converter.from_dict, from_none], obj.get("converter"))
        culture_info = from_union([from_float, CultureInfo.from_dict, from_none], obj.get("CultureInfo"))
        date = from_union([from_float, Date.from_dict, from_none], obj.get("date"))
        date_parse_handling = from_union([from_float, DateParseHandling.from_dict, from_none], obj.get("date_parse_handling"))
        date_formatter = from_union([from_float, DateFormatter.from_dict, from_none], obj.get("DateFormatter"))
        date_only = from_union([from_float, DateOnly.from_dict, from_none], obj.get("DateOnly"))
        date_only_converter = from_union([from_float, DateOnlyConverter.from_dict, from_none], obj.get("DateOnlyConverter"))
        date_time = from_union([from_float, DateTime.from_dict, from_none], obj.get("DateTime"))
        date_time_styles = from_union([from_float, DateTimeStyles.from_dict, from_none], obj.get("DateTimeStyles"))
        debugger = from_union([from_float, Debugger.from_dict, from_none], obj.get("debugger"))
        decimal = from_union([from_float, Decimal.from_dict, from_none], obj.get("decimal"))
        declare = from_union([from_float, Declare.from_dict, from_none], obj.get("declare"))
        decltype = from_union([from_float, Decltype.from_dict, from_none], obj.get("decltype"))
        decode_string = from_union([from_float, DecodeString.from_dict, from_none], obj.get("decode_string"))
        decoder = from_union([from_float, Decoder.from_dict, from_none], obj.get("Decoder"))
        decoding_error = from_union([from_float, DecodingError.from_dict, from_none], obj.get("DecodingError"))
        top_level_def = from_union([from_float, Def.from_dict, from_none], obj.get("def"))
        default = from_union([from_float, Default.from_dict, from_none], obj.get("default"))
        defer = from_union([from_float, Defer.from_dict, from_none], obj.get("defer"))
        deinit = from_union([from_float, Deinit.from_dict, from_none], obj.get("deinit"))
        top_level_del = from_union([from_float, Del.from_dict, from_none], obj.get("del"))
        delegate = from_union([from_float, Delegate.from_dict, from_none], obj.get("delegate"))
        delete = from_union([from_float, Delete.from_dict, from_none], obj.get("delete"))
        deserialization_feature = from_union([from_float, DeserializationFeature.from_dict, from_none], obj.get("DeserializationFeature"))
        top_level_dict = from_union([from_float, DictClass.from_dict, from_none], obj.get("dict"))
        dictionary = from_union([from_float, Dictionary.from_dict, from_none], obj.get("dictionary"))
        did_set = from_union([from_float, DidSet.from_dict, from_none], obj.get("didSet"))
        do = from_union([from_float, Do.from_dict, from_none], obj.get("do"))
        double = from_union([from_float, Double.from_dict, from_none], obj.get("double"))
        double_node = from_union([from_float, DoubleNode.from_dict, from_none], obj.get("DoubleNode"))
        dummy = from_union([from_float, from_none], obj.get("dummy"))
        dynamic = from_union([from_float, Dynamic.from_dict, from_none], obj.get("dynamic"))
        dynamic_cast = from_union([from_float, DynamicCast.from_dict, from_none], obj.get("dynamic_cast"))
        top_level_elif = from_union([from_float, Elif.from_dict, from_none], obj.get("elif"))
        top_level_else = from_union([from_float, Else.from_dict, from_none], obj.get("else"))
        encode_quick_type = from_union([from_float, EncodeQuickType.from_dict, from_none], obj.get("encode_quick_type"))
        encoder = from_union([from_float, Encoder.from_dict, from_none], obj.get("Encoder"))
        enum = from_union([from_float, EnumClass.from_dict, from_none], obj.get("enum"))
        enum_values = from_union([from_float, EnumValues.from_dict, from_none], obj.get("EnumValues"))
        equality_contract = from_union([from_float, EqualityContract.from_dict, from_none], obj.get("equalityContract"))
        equatable = from_union([from_float, Equatable.from_dict, from_none], obj.get("Equatable"))
        event = from_union([from_float, Event.from_dict, from_none], obj.get("event"))
        top_level_except = from_union([from_float, Except.from_dict, from_none], obj.get("except"))
        exception = from_union([from_float, Exception.from_dict, from_none], obj.get("exception"))
        explicit = from_union([from_float, Explicit.from_dict, from_none], obj.get("explicit"))
        export = from_union([from_float, Export.from_dict, from_none], obj.get("export"))
        exposing = from_union([from_float, Exposing.from_dict, from_none], obj.get("exposing"))
        extends = from_union([from_float, Extends.from_dict, from_none], obj.get("extends"))
        extension = from_union([from_float, Extension.from_dict, from_none], obj.get("extension"))
        extern = from_union([from_float, Extern.from_dict, from_none], obj.get("extern"))
        fallthrough = from_union([from_float, Fallthrough.from_dict, from_none], obj.get("fallthrough"))
        top_level_false = from_union([from_float, UnionFalseFalse.from_dict, from_none], obj.get("false"))
        false = from_union([from_float, FalseClass.from_dict, from_none], obj.get("False"))
        fileprivate = from_union([from_float, Fileprivate.from_dict, from_none], obj.get("fileprivate"))
        final = from_union([from_float, Final.from_dict, from_none], obj.get("final"))
        top_level_finally = from_union([from_float, Finally.from_dict, from_none], obj.get("finally"))
        fixed = from_union([from_float, Fixed.from_dict, from_none], obj.get("fixed"))
        top_level_float = from_union([from_float, Float.from_dict, from_none], obj.get("float"))
        top_level_for = from_union([from_float, For.from_dict, from_none], obj.get("for"))
        foreach = from_union([from_float, Foreach.from_dict, from_none], obj.get("foreach"))
        format_exception = from_union([from_float, FormatException.from_dict, from_none], obj.get("FormatException"))
        friend = from_union([from_float, Friend.from_dict, from_none], obj.get("friend"))
        top_level_from = from_union([from_float, From.from_dict, from_none], obj.get("from"))
        top_level_from_dict = from_union([from_float, FromDict.from_dict, from_none], obj.get("from_dict"))
        from_json = from_union([from_float, FromJSON.from_dict, from_none], obj.get("from_json"))
        func = from_union([from_float, Func.from_dict, from_none], obj.get("func"))
        function = from_union([from_float, Function.from_dict, from_none], obj.get("function"))
        get = from_union([from_float, Get.from_dict, from_none], obj.get("get"))
        top_level_global = from_union([from_float, Global.from_dict, from_none], obj.get("global"))
        go = from_union([from_float, Go.from_dict, from_none], obj.get("go"))
        goto = from_union([from_float, Goto.from_dict, from_none], obj.get("goto"))
        guard = from_union([from_float, Guard.from_dict, from_none], obj.get("guard"))
        hashable = from_union([from_float, Hashable.from_dict, from_none], obj.get("Hashable"))
        hash_code = from_union([from_float, HashCode.from_dict, from_none], obj.get("hashCode"))
        hasher = from_union([from_float, Hasher.from_dict, from_none], obj.get("Hasher"))
        has_own_property = from_union([from_float, HasOwnProperty.from_dict, from_none], obj.get("hasOwnProperty"))
        id = from_union([from_float, ID.from_dict, from_none], obj.get("id"))
        top_level_if = from_union([from_float, If.from_dict, from_none], obj.get("if"))
        imp = from_union([from_float, Imp.from_dict, from_none], obj.get("IMP"))
        implements = from_union([from_float, Implements.from_dict, from_none], obj.get("implements"))
        implicit = from_union([from_float, Implicit.from_dict, from_none], obj.get("implicit"))
        top_level_import = from_union([from_float, Import.from_dict, from_none], obj.get("import"))
        top_level_in = from_union([from_float, In.from_dict, from_none], obj.get("in"))
        indirect = from_union([from_float, Indirect.from_dict, from_none], obj.get("indirect"))
        infix = from_union([from_float, Infix.from_dict, from_none], obj.get("infix"))
        init = from_union([from_float, Init.from_dict, from_none], obj.get("init"))
        inline = from_union([from_float, Inline.from_dict, from_none], obj.get("inline"))
        inout = from_union([from_float, Inout.from_dict, from_none], obj.get("inout"))
        instanceof = from_union([from_float, Instanceof.from_dict, from_none], obj.get("instanceof"))
        top_level_int = from_union([from_float, Int.from_dict, from_none], obj.get("int"))
        interface = from_union([from_float, Interface.from_dict, from_none], obj.get("interface"))
        internal = from_union([from_float, Internal.from_dict, from_none], obj.get("internal"))
        int_node = from_union([from_float, IntNode.from_dict, from_none], obj.get("IntNode"))
        top_level_is = from_union([from_float, Is.from_dict, from_none], obj.get("is"))
        iso_date_time_offset_converter = from_union([from_float, ISODateTimeOffsetConverter.from_dict, from_none], obj.get("IsoDateTimeOffsetConverter"))
        iterable = from_union([from_float, IterableClass.from_dict, from_none], obj.get("iterable"))
        jdec = from_union([from_float, Jdec.from_dict, from_none], obj.get("jdec"))
        jenc = from_union([from_float, Jenc.from_dict, from_none], obj.get("jenc"))
        jpipe = from_union([from_float, Jpipe.from_dict, from_none], obj.get("jpipe"))
        json = from_union([from_float, JSON.from_dict, from_none], obj.get("json"))
        json_converter = from_union([from_float, JSONConverter.from_dict, from_none], obj.get("json_converter"))
        json_serializer = from_union([from_float, JSONSerializer.from_dict, from_none], obj.get("json_serializer"))
        json_token = from_union([from_float, JSONToken.from_dict, from_none], obj.get("json_token"))
        json_writer = from_union([from_float, JSONWriter.from_dict, from_none], obj.get("json_writer"))
        json_any = from_union([from_float, JSONAny.from_dict, from_none], obj.get("JSONAny"))
        json_coding_key = from_union([from_float, JSONCodingKey.from_dict, from_none], obj.get("JSONCodingKey"))
        json_decoder = from_union([from_float, JSONDecoder.from_dict, from_none], obj.get("JSONDecoder"))
        json_encoder = from_union([from_float, JSONEncoder.from_dict, from_none], obj.get("JSONEncoder"))
        json_exception = from_union([from_float, JSONException.from_dict, from_none], obj.get("JsonException"))
        json_generator = from_union([from_float, JSONGenerator.from_dict, from_none], obj.get("JsonGenerator"))
        json_node = from_union([from_float, JSONNode.from_dict, from_none], obj.get("JsonNode"))
        json_null = from_union([from_float, JSONNull.from_dict, from_none], obj.get("JSONNull"))
        json_parser = from_union([from_float, JSONParser.from_dict, from_none], obj.get("JsonParser"))
        json_reader = from_union([from_float, JSONReader.from_dict, from_none], obj.get("JsonReader"))
        json_token_type = from_union([from_float, JSONTokenType.from_dict, from_none], obj.get("JsonTokenType"))
        k_serializer = from_union([from_float, KSerializer.from_dict, from_none], obj.get("KSerializer"))
        top_level_lambda = from_union([from_float, Lambda.from_dict, from_none], obj.get("lambda"))
        lazy = from_union([from_float, Lazy.from_dict, from_none], obj.get("lazy"))
        left = from_union([from_float, Left.from_dict, from_none], obj.get("left"))
        let = from_union([from_float, Let.from_dict, from_none], obj.get("let"))
        list = from_union([from_float, ListClass.from_dict, from_none], obj.get("list"))
        local_date = from_union([from_float, LocalDate.from_dict, from_none], obj.get("LocalDate"))
        locale = from_union([from_float, Locale.from_dict, from_none], obj.get("Locale"))
        lock = from_union([from_float, Lock.from_dict, from_none], obj.get("lock"))
        long = from_union([from_float, Long.from_dict, from_none], obj.get("long"))
        long_node = from_union([from_float, LongNode.from_dict, from_none], obj.get("LongNode"))
        map = from_union([from_float, Map.from_dict, from_none], obj.get("map"))
        map_entry = from_union([from_float, MapEntry.from_dict, from_none], obj.get("MapEntry"))
        marshal_json = from_union([from_float, MarshalJSON.from_dict, from_none], obj.get("MarshalJSON"))
        metadata_property_handling = from_union([from_float, MetadataPropertyHandling.from_dict, from_none], obj.get("metadata_property_handling"))
        module = from_union([from_float, Module.from_dict, from_none], obj.get("module"))
        mutable = from_union([from_float, Mutable.from_dict, from_none], obj.get("mutable"))
        mutating = from_union([from_float, Mutating.from_dict, from_none], obj.get("mutating"))
        namespace = from_union([from_float, Namespace.from_dict, from_none], obj.get("namespace"))
        native = from_union([from_float, Native.from_dict, from_none], obj.get("native"))
        new = from_union([from_float, New.from_dict, from_none], obj.get("new"))
        newtonsoft = from_union([from_float, Newtonsoft.from_dict, from_none], obj.get("newtonsoft"))
        nil = from_union([from_float, Nil.from_dict, from_none], obj.get("nil"))
        no = from_union([from_float, No.from_dict, from_none], obj.get("NO"))
        noexcept = from_union([from_float, Noexcept.from_dict, from_none], obj.get("noexcept"))
        nonatomic = from_union([from_float, Nonatomic.from_dict, from_none], obj.get("nonatomic"))
        top_level_none = from_union([from_float, UnionNoneNone.from_dict, from_none], obj.get("none"))
        none = from_union([from_float, NoneClass.from_dict, from_none], obj.get("None"))
        top_level_nonlocal = from_union([from_float, Nonlocal.from_dict, from_none], obj.get("nonlocal"))
        nonmutating = from_union([from_float, Nonmutating.from_dict, from_none], obj.get("nonmutating"))
        no_such_method = from_union([from_float, NoSuchMethod.from_dict, from_none], obj.get("noSuchMethod"))
        top_level_not = from_union([from_float, Not.from_dict, from_none], obj.get("not"))
        not_eq = from_union([from_float, NotEq.from_dict, from_none], obj.get("not_eq"))
        ns_error = from_union([from_float, NSError.from_dict, from_none], obj.get("NSError"))
        ns_object = from_union([from_float, NSObject.from_dict, from_none], obj.get("NSObject"))
        ns_string = from_union([from_float, NSString.from_dict, from_none], obj.get("NSString"))
        null = from_union([from_float, Null.from_dict, from_none], obj.get("NULL"))
        top_level_null = from_union([from_float, NullClass.from_dict, from_none], obj.get("null"))
        null_node = from_union([from_float, NullNode.from_dict, from_none], obj.get("NullNode"))
        nullptr = from_union([from_float, Nullptr.from_dict, from_none], obj.get("nullptr"))
        number = from_union([from_float, Number.from_dict, from_none], obj.get("number"))
        object = from_union([from_float, Object.from_dict, from_none], obj.get("object"))
        object_mapper = from_union([from_float, ObjectMapper.from_dict, from_none], obj.get("ObjectMapper"))
        object_node = from_union([from_float, ObjectNode.from_dict, from_none], obj.get("ObjectNode"))
        object_reader = from_union([from_float, ObjectReader.from_dict, from_none], obj.get("ObjectReader"))
        object_writer = from_union([from_float, ObjectWriter.from_dict, from_none], obj.get("ObjectWriter"))
        of = from_union([from_float, Of.from_dict, from_none], obj.get("of"))
        offset_date_time = from_union([from_float, OffsetDateTime.from_dict, from_none], obj.get("OffsetDateTime"))
        offset_time = from_union([from_float, OffsetTime.from_dict, from_none], obj.get("OffsetTime"))
        oneway = from_union([from_float, Oneway.from_dict, from_none], obj.get("oneway"))
        open = from_union([from_float, Open.from_dict, from_none], obj.get("open"))
        operator = from_union([from_float, Operator.from_dict, from_none], obj.get("operator"))
        optional = from_union([from_float, OptionalClass.from_dict, from_none], obj.get("optional"))
        top_level_or = from_union([from_float, Or.from_dict, from_none], obj.get("or"))
        or_eq = from_union([from_float, OrEq.from_dict, from_none], obj.get("or_eq"))
        out = from_union([from_float, Out.from_dict, from_none], obj.get("out"))
        override = from_union([from_float, Override.from_dict, from_none], obj.get("override"))
        package = from_union([from_float, Package.from_dict, from_none], obj.get("package"))
        params = from_union([from_float, Params.from_dict, from_none], obj.get("params"))
        top_level_pass = from_union([from_float, Pass.from_dict, from_none], obj.get("pass"))
        port = from_union([from_float, Port.from_dict, from_none], obj.get("port"))
        postfix = from_union([from_float, Postfix.from_dict, from_none], obj.get("postfix"))
        precedence = from_union([from_float, Precedence.from_dict, from_none], obj.get("precedence"))
        prefix = from_union([from_float, Prefix.from_dict, from_none], obj.get("prefix"))
        primitive_kind = from_union([from_float, PrimitiveKind.from_dict, from_none], obj.get("PrimitiveKind"))
        top_level_print = from_union([from_float, Print.from_dict, from_none], obj.get("print"))
        printf = from_union([from_float, Printf.from_dict, from_none], obj.get("printf"))
        print_members = from_union([from_float, PrintMembers.from_dict, from_none], obj.get("printMembers"))
        private = from_union([from_float, Private.from_dict, from_none], obj.get("private"))
        protected = from_union([from_float, Protected.from_dict, from_none], obj.get("protected"))
        protocol = from_union([from_float, Protocol.from_dict, from_none], obj.get("Protocol"))
        top_level_protocol = from_union([from_float, ProtocolClass.from_dict, from_none], obj.get("protocol"))
        public = from_union([from_float, Public.from_dict, from_none], obj.get("public"))
        quicktype = from_union([from_float, Quicktype.from_dict, from_none], obj.get("quicktype"))
        top_level_raise = from_union([from_float, Raise.from_dict, from_none], obj.get("raise"))
        range = from_union([from_float, Range.from_dict, from_none], obj.get("range"))
        readonly = from_union([from_float, Readonly.from_dict, from_none], obj.get("readonly"))
        ref = from_union([from_float, Ref.from_dict, from_none], obj.get("ref"))
        reg_exp = from_union([from_float, RegExp.from_dict, from_none], obj.get("RegExp"))
        register = from_union([from_float, Register.from_dict, from_none], obj.get("register"))
        reinterpret_cast = from_union([from_float, ReinterpretCast.from_dict, from_none], obj.get("reinterpret_cast"))
        repeat = from_union([from_float, Repeat.from_dict, from_none], obj.get("repeat"))
        require = from_union([from_float, Require.from_dict, from_none], obj.get("require"))
        required = from_union([from_float, Required.from_dict, from_none], obj.get("required"))
        requires = from_union([from_float, Requires.from_dict, from_none], obj.get("requires"))
        restrict = from_union([from_float, Restrict.from_dict, from_none], obj.get("restrict"))
        retain = from_union([from_float, Retain.from_dict, from_none], obj.get("retain"))
        rethrows = from_union([from_float, Rethrows.from_dict, from_none], obj.get("rethrows"))
        top_level_return = from_union([from_float, Return.from_dict, from_none], obj.get("return"))
        right = from_union([from_float, Right.from_dict, from_none], obj.get("right"))
        runtime_type = from_union([from_float, RuntimeType.from_dict, from_none], obj.get("runtimeType"))
        s = from_union([from_float, S.from_dict, from_none], obj.get("s"))
        sbyte = from_union([from_float, Sbyte.from_dict, from_none], obj.get("sbyte"))
        sealed = from_union([from_float, Sealed.from_dict, from_none], obj.get("sealed"))
        sel = from_union([from_float, Sel.from_dict, from_none], obj.get("SEL"))
        select = from_union([from_float, Select.from_dict, from_none], obj.get("select"))
        top_level_self = from_union([from_float, Self.from_dict, from_none], obj.get("Self"))
        purple_self = from_union([from_float, SelfClass.from_dict, from_none], obj.get("self"))
        sendable = from_union([from_float, Sendable.from_dict, from_none], obj.get("Sendable"))
        serial_descriptor = from_union([from_float, SerialDescriptor.from_dict, from_none], obj.get("SerialDescriptor"))
        serializable = from_union([from_float, Serializable.from_dict, from_none], obj.get("Serializable"))
        serialization_feature = from_union([from_float, SerializationFeature.from_dict, from_none], obj.get("SerializationFeature"))
        serialize = from_union([from_float, Serialize.from_dict, from_none], obj.get("serialize"))
        serializer_provider = from_union([from_float, SerializerProvider.from_dict, from_none], obj.get("SerializerProvider"))
        serial_name = from_union([from_float, SerialName.from_dict, from_none], obj.get("SerialName"))
        set = from_union([from_float, Set.from_dict, from_none], obj.get("set"))
        short = from_union([from_float, Short.from_dict, from_none], obj.get("short"))
        signed = from_union([from_float, Signed.from_dict, from_none], obj.get("signed"))
        simple_module = from_union([from_float, SimpleModule.from_dict, from_none], obj.get("SimpleModule"))
        sizeof = from_union([from_float, Sizeof.from_dict, from_none], obj.get("sizeof"))
        stackalloc = from_union([from_float, Stackalloc.from_dict, from_none], obj.get("stackalloc"))
        standards = from_union([from_float, Standards.from_dict, from_none], obj.get("Standards"))
        static = from_union([from_float, Static.from_dict, from_none], obj.get("static"))
        static_assert = from_union([from_float, StaticAssert.from_dict, from_none], obj.get("static_assert"))
        static_cast = from_union([from_float, StaticCast.from_dict, from_none], obj.get("static_cast"))
        std_deserializer = from_union([from_float, StdDeserializer.from_dict, from_none], obj.get("StdDeserializer"))
        std_serializer = from_union([from_float, StdSerializer.from_dict, from_none], obj.get("StdSerializer"))
        strictfp = from_union([from_float, Strictfp.from_dict, from_none], obj.get("strictfp"))
        string = from_union([from_float, String.from_dict, from_none], obj.get("string"))
        struct = from_union([from_float, Struct.from_dict, from_none], obj.get("struct"))
        subscript = from_union([from_float, Subscript.from_dict, from_none], obj.get("subscript"))
        super = from_union([from_float, Super.from_dict, from_none], obj.get("super"))
        switch = from_union([from_float, Switch.from_dict, from_none], obj.get("switch"))
        symbol = from_union([from_float, Symbol.from_dict, from_none], obj.get("symbol"))
        synchronized = from_union([from_float, Synchronized.from_dict, from_none], obj.get("synchronized"))
        system = from_union([from_float, System.from_dict, from_none], obj.get("system"))
        template = from_union([from_float, Template.from_dict, from_none], obj.get("template"))
        text_node = from_union([from_float, TextNode.from_dict, from_none], obj.get("TextNode"))
        then = from_union([from_float, Then.from_dict, from_none], obj.get("then"))
        this = from_union([from_float, This.from_dict, from_none], obj.get("this"))
        thread_local = from_union([from_float, ThreadLocal.from_dict, from_none], obj.get("thread_local"))
        throw = from_union([from_float, Throw.from_dict, from_none], obj.get("throw"))
        throws = from_union([from_float, Throws.from_dict, from_none], obj.get("throws"))
        time_only = from_union([from_float, TimeOnly.from_dict, from_none], obj.get("TimeOnly"))
        time_only_converter = from_union([from_float, TimeOnlyConverter.from_dict, from_none], obj.get("TimeOnlyConverter"))
        time_zone = from_union([from_float, TimeZone.from_dict, from_none], obj.get("TimeZone"))
        top_level_to_dict = from_union([from_float, ToDict.from_dict, from_none], obj.get("to_dict"))
        to_json = from_union([from_float, ToJSON.from_dict, from_none], obj.get("to_json"))
        top_level = from_union([from_float, TopLevelClass.from_dict, from_none], obj.get("top_level"))
        to_string = from_union([from_float, ToString.from_dict, from_none], obj.get("toString"))
        transient = from_union([from_float, Transient.from_dict, from_none], obj.get("transient"))
        true = from_union([from_float, TrueClass.from_dict, from_none], obj.get("True"))
        top_level_true = from_union([from_float, UnionTrueTrue.from_dict, from_none], obj.get("true"))
        top_level_try = from_union([from_float, Try.from_dict, from_none], obj.get("try"))
        type = from_union([from_float, TypeClass.from_dict, from_none], obj.get("Type"))
        top_level_type = from_union([from_float, UnionTypeType.from_dict, from_none], obj.get("type"))
        typealias = from_union([from_float, Typealias.from_dict, from_none], obj.get("typealias"))
        typedef = from_union([from_float, Typedef.from_dict, from_none], obj.get("typedef"))
        typeid = from_union([from_float, Typeid.from_dict, from_none], obj.get("typeid"))
        typename = from_union([from_float, Typename.from_dict, from_none], obj.get("typename"))
        typeof = from_union([from_float, Typeof.from_dict, from_none], obj.get("typeof"))
        uint = from_union([from_float, Uint.from_dict, from_none], obj.get("uint"))
        ulong = from_union([from_float, Ulong.from_dict, from_none], obj.get("ulong"))
        unchecked = from_union([from_float, Unchecked.from_dict, from_none], obj.get("unchecked"))
        undefined = from_union([from_float, Undefined.from_dict, from_none], obj.get("undefined"))
        union = from_union([from_float, UnionClass.from_dict, from_none], obj.get("union"))
        unmarshal_json = from_union([from_float, UnmarshalJSON.from_dict, from_none], obj.get("UnmarshalJSON"))
        unowned = from_union([from_float, Unowned.from_dict, from_none], obj.get("unowned"))
        unsafe = from_union([from_float, Unsafe.from_dict, from_none], obj.get("unsafe"))
        unsigned = from_union([from_float, Unsigned.from_dict, from_none], obj.get("unsigned"))
        use_serializers = from_union([from_float, UseSerializers.from_dict, from_none], obj.get("UseSerializers"))
        ushort = from_union([from_float, Ushort.from_dict, from_none], obj.get("ushort"))
        using = from_union([from_float, Using.from_dict, from_none], obj.get("using"))
        utf8_json_reader = from_union([from_float, Utf8JSONReader.from_dict, from_none], obj.get("Utf8JsonReader"))
        utf8_json_writer = from_union([from_float, Utf8JSONWriter.from_dict, from_none], obj.get("Utf8JsonWriter"))
        uuid = from_union([from_float, UUIDClass.from_dict, from_none], obj.get("UUID"))
        var = from_union([from_float, Var.from_dict, from_none], obj.get("var"))
        virtual = from_union([from_float, Virtual.from_dict, from_none], obj.get("virtual"))
        void = from_union([from_float, Void.from_dict, from_none], obj.get("void"))
        volatile = from_union([from_float, Volatile.from_dict, from_none], obj.get("volatile"))
        wchar_t = from_union([from_float, WcharT.from_dict, from_none], obj.get("wchar_t"))
        weak = from_union([from_float, Weak.from_dict, from_none], obj.get("weak"))
        where = from_union([from_float, Where.from_dict, from_none], obj.get("where"))
        top_level_while = from_union([from_float, While.from_dict, from_none], obj.get("while"))
        will_set = from_union([from_float, WillSet.from_dict, from_none], obj.get("willSet"))
        top_level_with = from_union([from_float, With.from_dict, from_none], obj.get("with"))
        xor = from_union([from_float, Xor.from_dict, from_none], obj.get("xor"))
        xor_eq = from_union([from_float, XorEq.from_dict, from_none], obj.get("xor_eq"))
        yes = from_union([from_float, Yes.from_dict, from_none], obj.get("YES"))
        top_level_yield = from_union([from_float, Yield.from_dict, from_none], obj.get("yield"))
        return TopLevel(empty, purple_bool, complex, imaginery, abstract, alignas, alignof, top_level_and, and_eq, top_level_any, any, array, array_node, top_level_as, asm, top_level_assert, associatedtype, associativity, top_level_async, atomic, atomic_cancel, atomic_commit, atomic_noexcept, auto, top_level_await, base, bitand, bitor, top_level_bool, fluffy_bool, boolean, boolean_node, top_level_break, bycopy, byref, byte, calendar, case, catch, chan, char, char16_t, char32_t, checked, purple_class, top_level_class, clone, co_await, co_return, co_yield, codable, coding_key, coding_keys, compl, concept, console, const, const_cast, constexpr, constructor, top_level_continue, convenience, convert, converter, culture_info, date, date_parse_handling, date_formatter, date_only, date_only_converter, date_time, date_time_styles, debugger, decimal, declare, decltype, decode_string, decoder, decoding_error, top_level_def, default, defer, deinit, top_level_del, delegate, delete, deserialization_feature, top_level_dict, dictionary, did_set, do, double, double_node, dummy, dynamic, dynamic_cast, top_level_elif, top_level_else, encode_quick_type, encoder, enum, enum_values, equality_contract, equatable, event, top_level_except, exception, explicit, export, exposing, extends, extension, extern, fallthrough, top_level_false, false, fileprivate, final, top_level_finally, fixed, top_level_float, top_level_for, foreach, format_exception, friend, top_level_from, top_level_from_dict, from_json, func, function, get, top_level_global, go, goto, guard, hashable, hash_code, hasher, has_own_property, id, top_level_if, imp, implements, implicit, top_level_import, top_level_in, indirect, infix, init, inline, inout, instanceof, top_level_int, interface, internal, int_node, top_level_is, iso_date_time_offset_converter, iterable, jdec, jenc, jpipe, json, json_converter, json_serializer, json_token, json_writer, json_any, json_coding_key, json_decoder, json_encoder, json_exception, json_generator, json_node, json_null, json_parser, json_reader, json_token_type, k_serializer, top_level_lambda, lazy, left, let, list, local_date, locale, lock, long, long_node, map, map_entry, marshal_json, metadata_property_handling, module, mutable, mutating, namespace, native, new, newtonsoft, nil, no, noexcept, nonatomic, top_level_none, none, top_level_nonlocal, nonmutating, no_such_method, top_level_not, not_eq, ns_error, ns_object, ns_string, null, top_level_null, null_node, nullptr, number, object, object_mapper, object_node, object_reader, object_writer, of, offset_date_time, offset_time, oneway, open, operator, optional, top_level_or, or_eq, out, override, package, params, top_level_pass, port, postfix, precedence, prefix, primitive_kind, top_level_print, printf, print_members, private, protected, protocol, top_level_protocol, public, quicktype, top_level_raise, range, readonly, ref, reg_exp, register, reinterpret_cast, repeat, require, required, requires, restrict, retain, rethrows, top_level_return, right, runtime_type, s, sbyte, sealed, sel, select, top_level_self, purple_self, sendable, serial_descriptor, serializable, serialization_feature, serialize, serializer_provider, serial_name, set, short, signed, simple_module, sizeof, stackalloc, standards, static, static_assert, static_cast, std_deserializer, std_serializer, strictfp, string, struct, subscript, super, switch, symbol, synchronized, system, template, text_node, then, this, thread_local, throw, throws, time_only, time_only_converter, time_zone, top_level_to_dict, to_json, top_level, to_string, transient, true, top_level_true, top_level_try, type, top_level_type, typealias, typedef, typeid, typename, typeof, uint, ulong, unchecked, undefined, union, unmarshal_json, unowned, unsafe, unsigned, use_serializers, ushort, using, utf8_json_reader, utf8_json_writer, uuid, var, virtual, void, volatile, wchar_t, weak, where, top_level_while, will_set, top_level_with, xor, xor_eq, yes, top_level_yield)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.empty is not None:
            result["_"] = from_union([to_float, lambda x: to_class(Empty, x), from_none], self.empty)
        if self.purple_bool is not None:
            result["_Bool"] = from_union([to_float, lambda x: to_class(BoolClass, x), from_none], self.purple_bool)
        if self.complex is not None:
            result["_Complex"] = from_union([to_float, lambda x: to_class(Complex, x), from_none], self.complex)
        if self.imaginery is not None:
            result["_Imaginery"] = from_union([to_float, lambda x: to_class(Imaginery, x), from_none], self.imaginery)
        if self.abstract is not None:
            result["abstract"] = from_union([to_float, lambda x: to_class(Abstract, x), from_none], self.abstract)
        if self.alignas is not None:
            result["alignas"] = from_union([to_float, lambda x: to_class(Alignas, x), from_none], self.alignas)
        if self.alignof is not None:
            result["alignof"] = from_union([to_float, lambda x: to_class(Alignof, x), from_none], self.alignof)
        if self.top_level_and is not None:
            result["and"] = from_union([to_float, lambda x: to_class(And, x), from_none], self.top_level_and)
        if self.and_eq is not None:
            result["and_eq"] = from_union([to_float, lambda x: to_class(AndEq, x), from_none], self.and_eq)
        if self.top_level_any is not None:
            result["any"] = from_union([to_float, lambda x: to_class(UnionAnyAny, x), from_none], self.top_level_any)
        if self.any is not None:
            result["Any"] = from_union([to_float, lambda x: to_class(AnyClass, x), from_none], self.any)
        if self.array is not None:
            result["array"] = from_union([to_float, lambda x: to_class(Array, x), from_none], self.array)
        if self.array_node is not None:
            result["ArrayNode"] = from_union([to_float, lambda x: to_class(ArrayNode, x), from_none], self.array_node)
        if self.top_level_as is not None:
            result["as"] = from_union([to_float, lambda x: to_class(As, x), from_none], self.top_level_as)
        if self.asm is not None:
            result["asm"] = from_union([to_float, lambda x: to_class(ASM, x), from_none], self.asm)
        if self.top_level_assert is not None:
            result["assert"] = from_union([to_float, lambda x: to_class(Assert, x), from_none], self.top_level_assert)
        if self.associatedtype is not None:
            result["associatedtype"] = from_union([to_float, lambda x: to_class(Associatedtype, x), from_none], self.associatedtype)
        if self.associativity is not None:
            result["associativity"] = from_union([to_float, lambda x: to_class(Associativity, x), from_none], self.associativity)
        if self.top_level_async is not None:
            result["async"] = from_union([to_float, lambda x: to_class(Async, x), from_none], self.top_level_async)
        if self.atomic is not None:
            result["atomic"] = from_union([to_float, lambda x: to_class(Atomic, x), from_none], self.atomic)
        if self.atomic_cancel is not None:
            result["atomic_cancel"] = from_union([to_float, lambda x: to_class(AtomicCancel, x), from_none], self.atomic_cancel)
        if self.atomic_commit is not None:
            result["atomic_commit"] = from_union([to_float, lambda x: to_class(AtomicCommit, x), from_none], self.atomic_commit)
        if self.atomic_noexcept is not None:
            result["atomic_noexcept"] = from_union([to_float, lambda x: to_class(AtomicNoexcept, x), from_none], self.atomic_noexcept)
        if self.auto is not None:
            result["auto"] = from_union([to_float, lambda x: to_class(Auto, x), from_none], self.auto)
        if self.top_level_await is not None:
            result["await"] = from_union([to_float, lambda x: to_class(Await, x), from_none], self.top_level_await)
        if self.base is not None:
            result["base"] = from_union([to_float, lambda x: to_class(Base, x), from_none], self.base)
        if self.bitand is not None:
            result["bitand"] = from_union([to_float, lambda x: to_class(Bitand, x), from_none], self.bitand)
        if self.bitor is not None:
            result["bitor"] = from_union([to_float, lambda x: to_class(Bitor, x), from_none], self.bitor)
        if self.top_level_bool is not None:
            result["BOOL"] = from_union([to_float, lambda x: to_class(Bool, x), from_none], self.top_level_bool)
        if self.fluffy_bool is not None:
            result["bool"] = from_union([to_float, lambda x: to_class(UnionBoolBool, x), from_none], self.fluffy_bool)
        if self.boolean is not None:
            result["boolean"] = from_union([to_float, lambda x: to_class(Boolean, x), from_none], self.boolean)
        if self.boolean_node is not None:
            result["BooleanNode"] = from_union([to_float, lambda x: to_class(BooleanNode, x), from_none], self.boolean_node)
        if self.top_level_break is not None:
            result["break"] = from_union([to_float, lambda x: to_class(Break, x), from_none], self.top_level_break)
        if self.bycopy is not None:
            result["bycopy"] = from_union([to_float, lambda x: to_class(Bycopy, x), from_none], self.bycopy)
        if self.byref is not None:
            result["byref"] = from_union([to_float, lambda x: to_class(Byref, x), from_none], self.byref)
        if self.byte is not None:
            result["byte"] = from_union([to_float, lambda x: to_class(Byte, x), from_none], self.byte)
        if self.calendar is not None:
            result["Calendar"] = from_union([to_float, lambda x: to_class(Calendar, x), from_none], self.calendar)
        if self.case is not None:
            result["case"] = from_union([to_float, lambda x: to_class(Case, x), from_none], self.case)
        if self.catch is not None:
            result["catch"] = from_union([to_float, lambda x: to_class(Catch, x), from_none], self.catch)
        if self.chan is not None:
            result["chan"] = from_union([to_float, lambda x: to_class(Chan, x), from_none], self.chan)
        if self.char is not None:
            result["char"] = from_union([to_float, lambda x: to_class(Char, x), from_none], self.char)
        if self.char16_t is not None:
            result["char16_t"] = from_union([to_float, lambda x: to_class(Char16T, x), from_none], self.char16_t)
        if self.char32_t is not None:
            result["char32_t"] = from_union([to_float, lambda x: to_class(Char32T, x), from_none], self.char32_t)
        if self.checked is not None:
            result["checked"] = from_union([to_float, lambda x: to_class(Checked, x), from_none], self.checked)
        if self.purple_class is not None:
            result["class"] = from_union([to_float, lambda x: to_class(ClassClass, x), from_none], self.purple_class)
        if self.top_level_class is not None:
            result["Class"] = from_union([to_float, lambda x: to_class(Class, x), from_none], self.top_level_class)
        if self.clone is not None:
            result["clone"] = from_union([to_float, lambda x: to_class(Clone, x), from_none], self.clone)
        if self.co_await is not None:
            result["co_await"] = from_union([to_float, lambda x: to_class(CoAwait, x), from_none], self.co_await)
        if self.co_return is not None:
            result["co_return"] = from_union([to_float, lambda x: to_class(CoReturn, x), from_none], self.co_return)
        if self.co_yield is not None:
            result["co_yield"] = from_union([to_float, lambda x: to_class(CoYield, x), from_none], self.co_yield)
        if self.codable is not None:
            result["Codable"] = from_union([to_float, lambda x: to_class(Codable, x), from_none], self.codable)
        if self.coding_key is not None:
            result["CodingKey"] = from_union([to_float, lambda x: to_class(CodingKey, x), from_none], self.coding_key)
        if self.coding_keys is not None:
            result["CodingKeys"] = from_union([to_float, lambda x: to_class(CodingKeys, x), from_none], self.coding_keys)
        if self.compl is not None:
            result["compl"] = from_union([to_float, lambda x: to_class(Compl, x), from_none], self.compl)
        if self.concept is not None:
            result["concept"] = from_union([to_float, lambda x: to_class(Concept, x), from_none], self.concept)
        if self.console is not None:
            result["console"] = from_union([to_float, lambda x: to_class(Console, x), from_none], self.console)
        if self.const is not None:
            result["const"] = from_union([to_float, lambda x: to_class(Const, x), from_none], self.const)
        if self.const_cast is not None:
            result["const_cast"] = from_union([to_float, lambda x: to_class(ConstCast, x), from_none], self.const_cast)
        if self.constexpr is not None:
            result["constexpr"] = from_union([to_float, lambda x: to_class(Constexpr, x), from_none], self.constexpr)
        if self.constructor is not None:
            result["constructor"] = from_union([to_float, lambda x: to_class(Constructor, x), from_none], self.constructor)
        if self.top_level_continue is not None:
            result["continue"] = from_union([to_float, lambda x: to_class(Continue, x), from_none], self.top_level_continue)
        if self.convenience is not None:
            result["convenience"] = from_union([to_float, lambda x: to_class(Convenience, x), from_none], self.convenience)
        if self.convert is not None:
            result["convert"] = from_union([to_float, lambda x: to_class(Convert, x), from_none], self.convert)
        if self.converter is not None:
            result["converter"] = from_union([to_float, lambda x: to_class(Converter, x), from_none], self.converter)
        if self.culture_info is not None:
            result["CultureInfo"] = from_union([to_float, lambda x: to_class(CultureInfo, x), from_none], self.culture_info)
        if self.date is not None:
            result["date"] = from_union([to_float, lambda x: to_class(Date, x), from_none], self.date)
        if self.date_parse_handling is not None:
            result["date_parse_handling"] = from_union([to_float, lambda x: to_class(DateParseHandling, x), from_none], self.date_parse_handling)
        if self.date_formatter is not None:
            result["DateFormatter"] = from_union([to_float, lambda x: to_class(DateFormatter, x), from_none], self.date_formatter)
        if self.date_only is not None:
            result["DateOnly"] = from_union([to_float, lambda x: to_class(DateOnly, x), from_none], self.date_only)
        if self.date_only_converter is not None:
            result["DateOnlyConverter"] = from_union([to_float, lambda x: to_class(DateOnlyConverter, x), from_none], self.date_only_converter)
        if self.date_time is not None:
            result["DateTime"] = from_union([to_float, lambda x: to_class(DateTime, x), from_none], self.date_time)
        if self.date_time_styles is not None:
            result["DateTimeStyles"] = from_union([to_float, lambda x: to_class(DateTimeStyles, x), from_none], self.date_time_styles)
        if self.debugger is not None:
            result["debugger"] = from_union([to_float, lambda x: to_class(Debugger, x), from_none], self.debugger)
        if self.decimal is not None:
            result["decimal"] = from_union([to_float, lambda x: to_class(Decimal, x), from_none], self.decimal)
        if self.declare is not None:
            result["declare"] = from_union([to_float, lambda x: to_class(Declare, x), from_none], self.declare)
        if self.decltype is not None:
            result["decltype"] = from_union([to_float, lambda x: to_class(Decltype, x), from_none], self.decltype)
        if self.decode_string is not None:
            result["decode_string"] = from_union([to_float, lambda x: to_class(DecodeString, x), from_none], self.decode_string)
        if self.decoder is not None:
            result["Decoder"] = from_union([to_float, lambda x: to_class(Decoder, x), from_none], self.decoder)
        if self.decoding_error is not None:
            result["DecodingError"] = from_union([to_float, lambda x: to_class(DecodingError, x), from_none], self.decoding_error)
        if self.top_level_def is not None:
            result["def"] = from_union([to_float, lambda x: to_class(Def, x), from_none], self.top_level_def)
        if self.default is not None:
            result["default"] = from_union([to_float, lambda x: to_class(Default, x), from_none], self.default)
        if self.defer is not None:
            result["defer"] = from_union([to_float, lambda x: to_class(Defer, x), from_none], self.defer)
        if self.deinit is not None:
            result["deinit"] = from_union([to_float, lambda x: to_class(Deinit, x), from_none], self.deinit)
        if self.top_level_del is not None:
            result["del"] = from_union([to_float, lambda x: to_class(Del, x), from_none], self.top_level_del)
        if self.delegate is not None:
            result["delegate"] = from_union([to_float, lambda x: to_class(Delegate, x), from_none], self.delegate)
        if self.delete is not None:
            result["delete"] = from_union([to_float, lambda x: to_class(Delete, x), from_none], self.delete)
        if self.deserialization_feature is not None:
            result["DeserializationFeature"] = from_union([to_float, lambda x: to_class(DeserializationFeature, x), from_none], self.deserialization_feature)
        if self.top_level_dict is not None:
            result["dict"] = from_union([to_float, lambda x: to_class(DictClass, x), from_none], self.top_level_dict)
        if self.dictionary is not None:
            result["dictionary"] = from_union([to_float, lambda x: to_class(Dictionary, x), from_none], self.dictionary)
        if self.did_set is not None:
            result["didSet"] = from_union([to_float, lambda x: to_class(DidSet, x), from_none], self.did_set)
        if self.do is not None:
            result["do"] = from_union([to_float, lambda x: to_class(Do, x), from_none], self.do)
        if self.double is not None:
            result["double"] = from_union([to_float, lambda x: to_class(Double, x), from_none], self.double)
        if self.double_node is not None:
            result["DoubleNode"] = from_union([to_float, lambda x: to_class(DoubleNode, x), from_none], self.double_node)
        if self.dummy is not None:
            result["dummy"] = from_union([to_float, from_none], self.dummy)
        if self.dynamic is not None:
            result["dynamic"] = from_union([to_float, lambda x: to_class(Dynamic, x), from_none], self.dynamic)
        if self.dynamic_cast is not None:
            result["dynamic_cast"] = from_union([to_float, lambda x: to_class(DynamicCast, x), from_none], self.dynamic_cast)
        if self.top_level_elif is not None:
            result["elif"] = from_union([to_float, lambda x: to_class(Elif, x), from_none], self.top_level_elif)
        if self.top_level_else is not None:
            result["else"] = from_union([to_float, lambda x: to_class(Else, x), from_none], self.top_level_else)
        if self.encode_quick_type is not None:
            result["encode_quick_type"] = from_union([to_float, lambda x: to_class(EncodeQuickType, x), from_none], self.encode_quick_type)
        if self.encoder is not None:
            result["Encoder"] = from_union([to_float, lambda x: to_class(Encoder, x), from_none], self.encoder)
        if self.enum is not None:
            result["enum"] = from_union([to_float, lambda x: to_class(EnumClass, x), from_none], self.enum)
        if self.enum_values is not None:
            result["EnumValues"] = from_union([to_float, lambda x: to_class(EnumValues, x), from_none], self.enum_values)
        if self.equality_contract is not None:
            result["equalityContract"] = from_union([to_float, lambda x: to_class(EqualityContract, x), from_none], self.equality_contract)
        if self.equatable is not None:
            result["Equatable"] = from_union([to_float, lambda x: to_class(Equatable, x), from_none], self.equatable)
        if self.event is not None:
            result["event"] = from_union([to_float, lambda x: to_class(Event, x), from_none], self.event)
        if self.top_level_except is not None:
            result["except"] = from_union([to_float, lambda x: to_class(Except, x), from_none], self.top_level_except)
        if self.exception is not None:
            result["exception"] = from_union([to_float, lambda x: to_class(Exception, x), from_none], self.exception)
        if self.explicit is not None:
            result["explicit"] = from_union([to_float, lambda x: to_class(Explicit, x), from_none], self.explicit)
        if self.export is not None:
            result["export"] = from_union([to_float, lambda x: to_class(Export, x), from_none], self.export)
        if self.exposing is not None:
            result["exposing"] = from_union([to_float, lambda x: to_class(Exposing, x), from_none], self.exposing)
        if self.extends is not None:
            result["extends"] = from_union([to_float, lambda x: to_class(Extends, x), from_none], self.extends)
        if self.extension is not None:
            result["extension"] = from_union([to_float, lambda x: to_class(Extension, x), from_none], self.extension)
        if self.extern is not None:
            result["extern"] = from_union([to_float, lambda x: to_class(Extern, x), from_none], self.extern)
        if self.fallthrough is not None:
            result["fallthrough"] = from_union([to_float, lambda x: to_class(Fallthrough, x), from_none], self.fallthrough)
        if self.top_level_false is not None:
            result["false"] = from_union([to_float, lambda x: to_class(UnionFalseFalse, x), from_none], self.top_level_false)
        if self.false is not None:
            result["False"] = from_union([to_float, lambda x: to_class(FalseClass, x), from_none], self.false)
        if self.fileprivate is not None:
            result["fileprivate"] = from_union([to_float, lambda x: to_class(Fileprivate, x), from_none], self.fileprivate)
        if self.final is not None:
            result["final"] = from_union([to_float, lambda x: to_class(Final, x), from_none], self.final)
        if self.top_level_finally is not None:
            result["finally"] = from_union([to_float, lambda x: to_class(Finally, x), from_none], self.top_level_finally)
        if self.fixed is not None:
            result["fixed"] = from_union([to_float, lambda x: to_class(Fixed, x), from_none], self.fixed)
        if self.top_level_float is not None:
            result["float"] = from_union([to_float, lambda x: to_class(Float, x), from_none], self.top_level_float)
        if self.top_level_for is not None:
            result["for"] = from_union([to_float, lambda x: to_class(For, x), from_none], self.top_level_for)
        if self.foreach is not None:
            result["foreach"] = from_union([to_float, lambda x: to_class(Foreach, x), from_none], self.foreach)
        if self.format_exception is not None:
            result["FormatException"] = from_union([to_float, lambda x: to_class(FormatException, x), from_none], self.format_exception)
        if self.friend is not None:
            result["friend"] = from_union([to_float, lambda x: to_class(Friend, x), from_none], self.friend)
        if self.top_level_from is not None:
            result["from"] = from_union([to_float, lambda x: to_class(From, x), from_none], self.top_level_from)
        if self.top_level_from_dict is not None:
            result["from_dict"] = from_union([to_float, lambda x: to_class(FromDict, x), from_none], self.top_level_from_dict)
        if self.from_json is not None:
            result["from_json"] = from_union([to_float, lambda x: to_class(FromJSON, x), from_none], self.from_json)
        if self.func is not None:
            result["func"] = from_union([to_float, lambda x: to_class(Func, x), from_none], self.func)
        if self.function is not None:
            result["function"] = from_union([to_float, lambda x: to_class(Function, x), from_none], self.function)
        if self.get is not None:
            result["get"] = from_union([to_float, lambda x: to_class(Get, x), from_none], self.get)
        if self.top_level_global is not None:
            result["global"] = from_union([to_float, lambda x: to_class(Global, x), from_none], self.top_level_global)
        if self.go is not None:
            result["go"] = from_union([to_float, lambda x: to_class(Go, x), from_none], self.go)
        if self.goto is not None:
            result["goto"] = from_union([to_float, lambda x: to_class(Goto, x), from_none], self.goto)
        if self.guard is not None:
            result["guard"] = from_union([to_float, lambda x: to_class(Guard, x), from_none], self.guard)
        if self.hashable is not None:
            result["Hashable"] = from_union([to_float, lambda x: to_class(Hashable, x), from_none], self.hashable)
        if self.hash_code is not None:
            result["hashCode"] = from_union([to_float, lambda x: to_class(HashCode, x), from_none], self.hash_code)
        if self.hasher is not None:
            result["Hasher"] = from_union([to_float, lambda x: to_class(Hasher, x), from_none], self.hasher)
        if self.has_own_property is not None:
            result["hasOwnProperty"] = from_union([to_float, lambda x: to_class(HasOwnProperty, x), from_none], self.has_own_property)
        if self.id is not None:
            result["id"] = from_union([to_float, lambda x: to_class(ID, x), from_none], self.id)
        if self.top_level_if is not None:
            result["if"] = from_union([to_float, lambda x: to_class(If, x), from_none], self.top_level_if)
        if self.imp is not None:
            result["IMP"] = from_union([to_float, lambda x: to_class(Imp, x), from_none], self.imp)
        if self.implements is not None:
            result["implements"] = from_union([to_float, lambda x: to_class(Implements, x), from_none], self.implements)
        if self.implicit is not None:
            result["implicit"] = from_union([to_float, lambda x: to_class(Implicit, x), from_none], self.implicit)
        if self.top_level_import is not None:
            result["import"] = from_union([to_float, lambda x: to_class(Import, x), from_none], self.top_level_import)
        if self.top_level_in is not None:
            result["in"] = from_union([to_float, lambda x: to_class(In, x), from_none], self.top_level_in)
        if self.indirect is not None:
            result["indirect"] = from_union([to_float, lambda x: to_class(Indirect, x), from_none], self.indirect)
        if self.infix is not None:
            result["infix"] = from_union([to_float, lambda x: to_class(Infix, x), from_none], self.infix)
        if self.init is not None:
            result["init"] = from_union([to_float, lambda x: to_class(Init, x), from_none], self.init)
        if self.inline is not None:
            result["inline"] = from_union([to_float, lambda x: to_class(Inline, x), from_none], self.inline)
        if self.inout is not None:
            result["inout"] = from_union([to_float, lambda x: to_class(Inout, x), from_none], self.inout)
        if self.instanceof is not None:
            result["instanceof"] = from_union([to_float, lambda x: to_class(Instanceof, x), from_none], self.instanceof)
        if self.top_level_int is not None:
            result["int"] = from_union([to_float, lambda x: to_class(Int, x), from_none], self.top_level_int)
        if self.interface is not None:
            result["interface"] = from_union([to_float, lambda x: to_class(Interface, x), from_none], self.interface)
        if self.internal is not None:
            result["internal"] = from_union([to_float, lambda x: to_class(Internal, x), from_none], self.internal)
        if self.int_node is not None:
            result["IntNode"] = from_union([to_float, lambda x: to_class(IntNode, x), from_none], self.int_node)
        if self.top_level_is is not None:
            result["is"] = from_union([to_float, lambda x: to_class(Is, x), from_none], self.top_level_is)
        if self.iso_date_time_offset_converter is not None:
            result["IsoDateTimeOffsetConverter"] = from_union([to_float, lambda x: to_class(ISODateTimeOffsetConverter, x), from_none], self.iso_date_time_offset_converter)
        if self.iterable is not None:
            result["iterable"] = from_union([to_float, lambda x: to_class(IterableClass, x), from_none], self.iterable)
        if self.jdec is not None:
            result["jdec"] = from_union([to_float, lambda x: to_class(Jdec, x), from_none], self.jdec)
        if self.jenc is not None:
            result["jenc"] = from_union([to_float, lambda x: to_class(Jenc, x), from_none], self.jenc)
        if self.jpipe is not None:
            result["jpipe"] = from_union([to_float, lambda x: to_class(Jpipe, x), from_none], self.jpipe)
        if self.json is not None:
            result["json"] = from_union([to_float, lambda x: to_class(JSON, x), from_none], self.json)
        if self.json_converter is not None:
            result["json_converter"] = from_union([to_float, lambda x: to_class(JSONConverter, x), from_none], self.json_converter)
        if self.json_serializer is not None:
            result["json_serializer"] = from_union([to_float, lambda x: to_class(JSONSerializer, x), from_none], self.json_serializer)
        if self.json_token is not None:
            result["json_token"] = from_union([to_float, lambda x: to_class(JSONToken, x), from_none], self.json_token)
        if self.json_writer is not None:
            result["json_writer"] = from_union([to_float, lambda x: to_class(JSONWriter, x), from_none], self.json_writer)
        if self.json_any is not None:
            result["JSONAny"] = from_union([to_float, lambda x: to_class(JSONAny, x), from_none], self.json_any)
        if self.json_coding_key is not None:
            result["JSONCodingKey"] = from_union([to_float, lambda x: to_class(JSONCodingKey, x), from_none], self.json_coding_key)
        if self.json_decoder is not None:
            result["JSONDecoder"] = from_union([to_float, lambda x: to_class(JSONDecoder, x), from_none], self.json_decoder)
        if self.json_encoder is not None:
            result["JSONEncoder"] = from_union([to_float, lambda x: to_class(JSONEncoder, x), from_none], self.json_encoder)
        if self.json_exception is not None:
            result["JsonException"] = from_union([to_float, lambda x: to_class(JSONException, x), from_none], self.json_exception)
        if self.json_generator is not None:
            result["JsonGenerator"] = from_union([to_float, lambda x: to_class(JSONGenerator, x), from_none], self.json_generator)
        if self.json_node is not None:
            result["JsonNode"] = from_union([to_float, lambda x: to_class(JSONNode, x), from_none], self.json_node)
        if self.json_null is not None:
            result["JSONNull"] = from_union([to_float, lambda x: to_class(JSONNull, x), from_none], self.json_null)
        if self.json_parser is not None:
            result["JsonParser"] = from_union([to_float, lambda x: to_class(JSONParser, x), from_none], self.json_parser)
        if self.json_reader is not None:
            result["JsonReader"] = from_union([to_float, lambda x: to_class(JSONReader, x), from_none], self.json_reader)
        if self.json_token_type is not None:
            result["JsonTokenType"] = from_union([to_float, lambda x: to_class(JSONTokenType, x), from_none], self.json_token_type)
        if self.k_serializer is not None:
            result["KSerializer"] = from_union([to_float, lambda x: to_class(KSerializer, x), from_none], self.k_serializer)
        if self.top_level_lambda is not None:
            result["lambda"] = from_union([to_float, lambda x: to_class(Lambda, x), from_none], self.top_level_lambda)
        if self.lazy is not None:
            result["lazy"] = from_union([to_float, lambda x: to_class(Lazy, x), from_none], self.lazy)
        if self.left is not None:
            result["left"] = from_union([to_float, lambda x: to_class(Left, x), from_none], self.left)
        if self.let is not None:
            result["let"] = from_union([to_float, lambda x: to_class(Let, x), from_none], self.let)
        if self.list is not None:
            result["list"] = from_union([to_float, lambda x: to_class(ListClass, x), from_none], self.list)
        if self.local_date is not None:
            result["LocalDate"] = from_union([to_float, lambda x: to_class(LocalDate, x), from_none], self.local_date)
        if self.locale is not None:
            result["Locale"] = from_union([to_float, lambda x: to_class(Locale, x), from_none], self.locale)
        if self.lock is not None:
            result["lock"] = from_union([to_float, lambda x: to_class(Lock, x), from_none], self.lock)
        if self.long is not None:
            result["long"] = from_union([to_float, lambda x: to_class(Long, x), from_none], self.long)
        if self.long_node is not None:
            result["LongNode"] = from_union([to_float, lambda x: to_class(LongNode, x), from_none], self.long_node)
        if self.map is not None:
            result["map"] = from_union([to_float, lambda x: to_class(Map, x), from_none], self.map)
        if self.map_entry is not None:
            result["MapEntry"] = from_union([to_float, lambda x: to_class(MapEntry, x), from_none], self.map_entry)
        if self.marshal_json is not None:
            result["MarshalJSON"] = from_union([to_float, lambda x: to_class(MarshalJSON, x), from_none], self.marshal_json)
        if self.metadata_property_handling is not None:
            result["metadata_property_handling"] = from_union([to_float, lambda x: to_class(MetadataPropertyHandling, x), from_none], self.metadata_property_handling)
        if self.module is not None:
            result["module"] = from_union([to_float, lambda x: to_class(Module, x), from_none], self.module)
        if self.mutable is not None:
            result["mutable"] = from_union([to_float, lambda x: to_class(Mutable, x), from_none], self.mutable)
        if self.mutating is not None:
            result["mutating"] = from_union([to_float, lambda x: to_class(Mutating, x), from_none], self.mutating)
        if self.namespace is not None:
            result["namespace"] = from_union([to_float, lambda x: to_class(Namespace, x), from_none], self.namespace)
        if self.native is not None:
            result["native"] = from_union([to_float, lambda x: to_class(Native, x), from_none], self.native)
        if self.new is not None:
            result["new"] = from_union([to_float, lambda x: to_class(New, x), from_none], self.new)
        if self.newtonsoft is not None:
            result["newtonsoft"] = from_union([to_float, lambda x: to_class(Newtonsoft, x), from_none], self.newtonsoft)
        if self.nil is not None:
            result["nil"] = from_union([to_float, lambda x: to_class(Nil, x), from_none], self.nil)
        if self.no is not None:
            result["NO"] = from_union([to_float, lambda x: to_class(No, x), from_none], self.no)
        if self.noexcept is not None:
            result["noexcept"] = from_union([to_float, lambda x: to_class(Noexcept, x), from_none], self.noexcept)
        if self.nonatomic is not None:
            result["nonatomic"] = from_union([to_float, lambda x: to_class(Nonatomic, x), from_none], self.nonatomic)
        if self.top_level_none is not None:
            result["none"] = from_union([to_float, lambda x: to_class(UnionNoneNone, x), from_none], self.top_level_none)
        if self.none is not None:
            result["None"] = from_union([to_float, lambda x: to_class(NoneClass, x), from_none], self.none)
        if self.top_level_nonlocal is not None:
            result["nonlocal"] = from_union([to_float, lambda x: to_class(Nonlocal, x), from_none], self.top_level_nonlocal)
        if self.nonmutating is not None:
            result["nonmutating"] = from_union([to_float, lambda x: to_class(Nonmutating, x), from_none], self.nonmutating)
        if self.no_such_method is not None:
            result["noSuchMethod"] = from_union([to_float, lambda x: to_class(NoSuchMethod, x), from_none], self.no_such_method)
        if self.top_level_not is not None:
            result["not"] = from_union([to_float, lambda x: to_class(Not, x), from_none], self.top_level_not)
        if self.not_eq is not None:
            result["not_eq"] = from_union([to_float, lambda x: to_class(NotEq, x), from_none], self.not_eq)
        if self.ns_error is not None:
            result["NSError"] = from_union([to_float, lambda x: to_class(NSError, x), from_none], self.ns_error)
        if self.ns_object is not None:
            result["NSObject"] = from_union([to_float, lambda x: to_class(NSObject, x), from_none], self.ns_object)
        if self.ns_string is not None:
            result["NSString"] = from_union([to_float, lambda x: to_class(NSString, x), from_none], self.ns_string)
        if self.null is not None:
            result["NULL"] = from_union([to_float, lambda x: to_class(Null, x), from_none], self.null)
        if self.top_level_null is not None:
            result["null"] = from_union([to_float, lambda x: to_class(NullClass, x), from_none], self.top_level_null)
        if self.null_node is not None:
            result["NullNode"] = from_union([to_float, lambda x: to_class(NullNode, x), from_none], self.null_node)
        if self.nullptr is not None:
            result["nullptr"] = from_union([to_float, lambda x: to_class(Nullptr, x), from_none], self.nullptr)
        if self.number is not None:
            result["number"] = from_union([to_float, lambda x: to_class(Number, x), from_none], self.number)
        if self.object is not None:
            result["object"] = from_union([to_float, lambda x: to_class(Object, x), from_none], self.object)
        if self.object_mapper is not None:
            result["ObjectMapper"] = from_union([to_float, lambda x: to_class(ObjectMapper, x), from_none], self.object_mapper)
        if self.object_node is not None:
            result["ObjectNode"] = from_union([to_float, lambda x: to_class(ObjectNode, x), from_none], self.object_node)
        if self.object_reader is not None:
            result["ObjectReader"] = from_union([to_float, lambda x: to_class(ObjectReader, x), from_none], self.object_reader)
        if self.object_writer is not None:
            result["ObjectWriter"] = from_union([to_float, lambda x: to_class(ObjectWriter, x), from_none], self.object_writer)
        if self.of is not None:
            result["of"] = from_union([to_float, lambda x: to_class(Of, x), from_none], self.of)
        if self.offset_date_time is not None:
            result["OffsetDateTime"] = from_union([to_float, lambda x: to_class(OffsetDateTime, x), from_none], self.offset_date_time)
        if self.offset_time is not None:
            result["OffsetTime"] = from_union([to_float, lambda x: to_class(OffsetTime, x), from_none], self.offset_time)
        if self.oneway is not None:
            result["oneway"] = from_union([to_float, lambda x: to_class(Oneway, x), from_none], self.oneway)
        if self.open is not None:
            result["open"] = from_union([to_float, lambda x: to_class(Open, x), from_none], self.open)
        if self.operator is not None:
            result["operator"] = from_union([to_float, lambda x: to_class(Operator, x), from_none], self.operator)
        if self.optional is not None:
            result["optional"] = from_union([to_float, lambda x: to_class(OptionalClass, x), from_none], self.optional)
        if self.top_level_or is not None:
            result["or"] = from_union([to_float, lambda x: to_class(Or, x), from_none], self.top_level_or)
        if self.or_eq is not None:
            result["or_eq"] = from_union([to_float, lambda x: to_class(OrEq, x), from_none], self.or_eq)
        if self.out is not None:
            result["out"] = from_union([to_float, lambda x: to_class(Out, x), from_none], self.out)
        if self.override is not None:
            result["override"] = from_union([to_float, lambda x: to_class(Override, x), from_none], self.override)
        if self.package is not None:
            result["package"] = from_union([to_float, lambda x: to_class(Package, x), from_none], self.package)
        if self.params is not None:
            result["params"] = from_union([to_float, lambda x: to_class(Params, x), from_none], self.params)
        if self.top_level_pass is not None:
            result["pass"] = from_union([to_float, lambda x: to_class(Pass, x), from_none], self.top_level_pass)
        if self.port is not None:
            result["port"] = from_union([to_float, lambda x: to_class(Port, x), from_none], self.port)
        if self.postfix is not None:
            result["postfix"] = from_union([to_float, lambda x: to_class(Postfix, x), from_none], self.postfix)
        if self.precedence is not None:
            result["precedence"] = from_union([to_float, lambda x: to_class(Precedence, x), from_none], self.precedence)
        if self.prefix is not None:
            result["prefix"] = from_union([to_float, lambda x: to_class(Prefix, x), from_none], self.prefix)
        if self.primitive_kind is not None:
            result["PrimitiveKind"] = from_union([to_float, lambda x: to_class(PrimitiveKind, x), from_none], self.primitive_kind)
        if self.top_level_print is not None:
            result["print"] = from_union([to_float, lambda x: to_class(Print, x), from_none], self.top_level_print)
        if self.printf is not None:
            result["printf"] = from_union([to_float, lambda x: to_class(Printf, x), from_none], self.printf)
        if self.print_members is not None:
            result["printMembers"] = from_union([to_float, lambda x: to_class(PrintMembers, x), from_none], self.print_members)
        if self.private is not None:
            result["private"] = from_union([to_float, lambda x: to_class(Private, x), from_none], self.private)
        if self.protected is not None:
            result["protected"] = from_union([to_float, lambda x: to_class(Protected, x), from_none], self.protected)
        if self.protocol is not None:
            result["Protocol"] = from_union([to_float, lambda x: to_class(Protocol, x), from_none], self.protocol)
        if self.top_level_protocol is not None:
            result["protocol"] = from_union([to_float, lambda x: to_class(ProtocolClass, x), from_none], self.top_level_protocol)
        if self.public is not None:
            result["public"] = from_union([to_float, lambda x: to_class(Public, x), from_none], self.public)
        if self.quicktype is not None:
            result["quicktype"] = from_union([to_float, lambda x: to_class(Quicktype, x), from_none], self.quicktype)
        if self.top_level_raise is not None:
            result["raise"] = from_union([to_float, lambda x: to_class(Raise, x), from_none], self.top_level_raise)
        if self.range is not None:
            result["range"] = from_union([to_float, lambda x: to_class(Range, x), from_none], self.range)
        if self.readonly is not None:
            result["readonly"] = from_union([to_float, lambda x: to_class(Readonly, x), from_none], self.readonly)
        if self.ref is not None:
            result["ref"] = from_union([to_float, lambda x: to_class(Ref, x), from_none], self.ref)
        if self.reg_exp is not None:
            result["RegExp"] = from_union([to_float, lambda x: to_class(RegExp, x), from_none], self.reg_exp)
        if self.register is not None:
            result["register"] = from_union([to_float, lambda x: to_class(Register, x), from_none], self.register)
        if self.reinterpret_cast is not None:
            result["reinterpret_cast"] = from_union([to_float, lambda x: to_class(ReinterpretCast, x), from_none], self.reinterpret_cast)
        if self.repeat is not None:
            result["repeat"] = from_union([to_float, lambda x: to_class(Repeat, x), from_none], self.repeat)
        if self.require is not None:
            result["require"] = from_union([to_float, lambda x: to_class(Require, x), from_none], self.require)
        if self.required is not None:
            result["required"] = from_union([to_float, lambda x: to_class(Required, x), from_none], self.required)
        if self.requires is not None:
            result["requires"] = from_union([to_float, lambda x: to_class(Requires, x), from_none], self.requires)
        if self.restrict is not None:
            result["restrict"] = from_union([to_float, lambda x: to_class(Restrict, x), from_none], self.restrict)
        if self.retain is not None:
            result["retain"] = from_union([to_float, lambda x: to_class(Retain, x), from_none], self.retain)
        if self.rethrows is not None:
            result["rethrows"] = from_union([to_float, lambda x: to_class(Rethrows, x), from_none], self.rethrows)
        if self.top_level_return is not None:
            result["return"] = from_union([to_float, lambda x: to_class(Return, x), from_none], self.top_level_return)
        if self.right is not None:
            result["right"] = from_union([to_float, lambda x: to_class(Right, x), from_none], self.right)
        if self.runtime_type is not None:
            result["runtimeType"] = from_union([to_float, lambda x: to_class(RuntimeType, x), from_none], self.runtime_type)
        if self.s is not None:
            result["s"] = from_union([to_float, lambda x: to_class(S, x), from_none], self.s)
        if self.sbyte is not None:
            result["sbyte"] = from_union([to_float, lambda x: to_class(Sbyte, x), from_none], self.sbyte)
        if self.sealed is not None:
            result["sealed"] = from_union([to_float, lambda x: to_class(Sealed, x), from_none], self.sealed)
        if self.sel is not None:
            result["SEL"] = from_union([to_float, lambda x: to_class(Sel, x), from_none], self.sel)
        if self.select is not None:
            result["select"] = from_union([to_float, lambda x: to_class(Select, x), from_none], self.select)
        if self.top_level_self is not None:
            result["Self"] = from_union([to_float, lambda x: to_class(Self, x), from_none], self.top_level_self)
        if self.purple_self is not None:
            result["self"] = from_union([to_float, lambda x: to_class(SelfClass, x), from_none], self.purple_self)
        if self.sendable is not None:
            result["Sendable"] = from_union([to_float, lambda x: to_class(Sendable, x), from_none], self.sendable)
        if self.serial_descriptor is not None:
            result["SerialDescriptor"] = from_union([to_float, lambda x: to_class(SerialDescriptor, x), from_none], self.serial_descriptor)
        if self.serializable is not None:
            result["Serializable"] = from_union([to_float, lambda x: to_class(Serializable, x), from_none], self.serializable)
        if self.serialization_feature is not None:
            result["SerializationFeature"] = from_union([to_float, lambda x: to_class(SerializationFeature, x), from_none], self.serialization_feature)
        if self.serialize is not None:
            result["serialize"] = from_union([to_float, lambda x: to_class(Serialize, x), from_none], self.serialize)
        if self.serializer_provider is not None:
            result["SerializerProvider"] = from_union([to_float, lambda x: to_class(SerializerProvider, x), from_none], self.serializer_provider)
        if self.serial_name is not None:
            result["SerialName"] = from_union([to_float, lambda x: to_class(SerialName, x), from_none], self.serial_name)
        if self.set is not None:
            result["set"] = from_union([to_float, lambda x: to_class(Set, x), from_none], self.set)
        if self.short is not None:
            result["short"] = from_union([to_float, lambda x: to_class(Short, x), from_none], self.short)
        if self.signed is not None:
            result["signed"] = from_union([to_float, lambda x: to_class(Signed, x), from_none], self.signed)
        if self.simple_module is not None:
            result["SimpleModule"] = from_union([to_float, lambda x: to_class(SimpleModule, x), from_none], self.simple_module)
        if self.sizeof is not None:
            result["sizeof"] = from_union([to_float, lambda x: to_class(Sizeof, x), from_none], self.sizeof)
        if self.stackalloc is not None:
            result["stackalloc"] = from_union([to_float, lambda x: to_class(Stackalloc, x), from_none], self.stackalloc)
        if self.standards is not None:
            result["Standards"] = from_union([to_float, lambda x: to_class(Standards, x), from_none], self.standards)
        if self.static is not None:
            result["static"] = from_union([to_float, lambda x: to_class(Static, x), from_none], self.static)
        if self.static_assert is not None:
            result["static_assert"] = from_union([to_float, lambda x: to_class(StaticAssert, x), from_none], self.static_assert)
        if self.static_cast is not None:
            result["static_cast"] = from_union([to_float, lambda x: to_class(StaticCast, x), from_none], self.static_cast)
        if self.std_deserializer is not None:
            result["StdDeserializer"] = from_union([to_float, lambda x: to_class(StdDeserializer, x), from_none], self.std_deserializer)
        if self.std_serializer is not None:
            result["StdSerializer"] = from_union([to_float, lambda x: to_class(StdSerializer, x), from_none], self.std_serializer)
        if self.strictfp is not None:
            result["strictfp"] = from_union([to_float, lambda x: to_class(Strictfp, x), from_none], self.strictfp)
        if self.string is not None:
            result["string"] = from_union([to_float, lambda x: to_class(String, x), from_none], self.string)
        if self.struct is not None:
            result["struct"] = from_union([to_float, lambda x: to_class(Struct, x), from_none], self.struct)
        if self.subscript is not None:
            result["subscript"] = from_union([to_float, lambda x: to_class(Subscript, x), from_none], self.subscript)
        if self.super is not None:
            result["super"] = from_union([to_float, lambda x: to_class(Super, x), from_none], self.super)
        if self.switch is not None:
            result["switch"] = from_union([to_float, lambda x: to_class(Switch, x), from_none], self.switch)
        if self.symbol is not None:
            result["symbol"] = from_union([to_float, lambda x: to_class(Symbol, x), from_none], self.symbol)
        if self.synchronized is not None:
            result["synchronized"] = from_union([to_float, lambda x: to_class(Synchronized, x), from_none], self.synchronized)
        if self.system is not None:
            result["system"] = from_union([to_float, lambda x: to_class(System, x), from_none], self.system)
        if self.template is not None:
            result["template"] = from_union([to_float, lambda x: to_class(Template, x), from_none], self.template)
        if self.text_node is not None:
            result["TextNode"] = from_union([to_float, lambda x: to_class(TextNode, x), from_none], self.text_node)
        if self.then is not None:
            result["then"] = from_union([to_float, lambda x: to_class(Then, x), from_none], self.then)
        if self.this is not None:
            result["this"] = from_union([to_float, lambda x: to_class(This, x), from_none], self.this)
        if self.thread_local is not None:
            result["thread_local"] = from_union([to_float, lambda x: to_class(ThreadLocal, x), from_none], self.thread_local)
        if self.throw is not None:
            result["throw"] = from_union([to_float, lambda x: to_class(Throw, x), from_none], self.throw)
        if self.throws is not None:
            result["throws"] = from_union([to_float, lambda x: to_class(Throws, x), from_none], self.throws)
        if self.time_only is not None:
            result["TimeOnly"] = from_union([to_float, lambda x: to_class(TimeOnly, x), from_none], self.time_only)
        if self.time_only_converter is not None:
            result["TimeOnlyConverter"] = from_union([to_float, lambda x: to_class(TimeOnlyConverter, x), from_none], self.time_only_converter)
        if self.time_zone is not None:
            result["TimeZone"] = from_union([to_float, lambda x: to_class(TimeZone, x), from_none], self.time_zone)
        if self.top_level_to_dict is not None:
            result["to_dict"] = from_union([to_float, lambda x: to_class(ToDict, x), from_none], self.top_level_to_dict)
        if self.to_json is not None:
            result["to_json"] = from_union([to_float, lambda x: to_class(ToJSON, x), from_none], self.to_json)
        if self.top_level is not None:
            result["top_level"] = from_union([to_float, lambda x: to_class(TopLevelClass, x), from_none], self.top_level)
        if self.to_string is not None:
            result["toString"] = from_union([to_float, lambda x: to_class(ToString, x), from_none], self.to_string)
        if self.transient is not None:
            result["transient"] = from_union([to_float, lambda x: to_class(Transient, x), from_none], self.transient)
        if self.true is not None:
            result["True"] = from_union([to_float, lambda x: to_class(TrueClass, x), from_none], self.true)
        if self.top_level_true is not None:
            result["true"] = from_union([to_float, lambda x: to_class(UnionTrueTrue, x), from_none], self.top_level_true)
        if self.top_level_try is not None:
            result["try"] = from_union([to_float, lambda x: to_class(Try, x), from_none], self.top_level_try)
        if self.type is not None:
            result["Type"] = from_union([to_float, lambda x: to_class(TypeClass, x), from_none], self.type)
        if self.top_level_type is not None:
            result["type"] = from_union([to_float, lambda x: to_class(UnionTypeType, x), from_none], self.top_level_type)
        if self.typealias is not None:
            result["typealias"] = from_union([to_float, lambda x: to_class(Typealias, x), from_none], self.typealias)
        if self.typedef is not None:
            result["typedef"] = from_union([to_float, lambda x: to_class(Typedef, x), from_none], self.typedef)
        if self.typeid is not None:
            result["typeid"] = from_union([to_float, lambda x: to_class(Typeid, x), from_none], self.typeid)
        if self.typename is not None:
            result["typename"] = from_union([to_float, lambda x: to_class(Typename, x), from_none], self.typename)
        if self.typeof is not None:
            result["typeof"] = from_union([to_float, lambda x: to_class(Typeof, x), from_none], self.typeof)
        if self.uint is not None:
            result["uint"] = from_union([to_float, lambda x: to_class(Uint, x), from_none], self.uint)
        if self.ulong is not None:
            result["ulong"] = from_union([to_float, lambda x: to_class(Ulong, x), from_none], self.ulong)
        if self.unchecked is not None:
            result["unchecked"] = from_union([to_float, lambda x: to_class(Unchecked, x), from_none], self.unchecked)
        if self.undefined is not None:
            result["undefined"] = from_union([to_float, lambda x: to_class(Undefined, x), from_none], self.undefined)
        if self.union is not None:
            result["union"] = from_union([to_float, lambda x: to_class(UnionClass, x), from_none], self.union)
        if self.unmarshal_json is not None:
            result["UnmarshalJSON"] = from_union([to_float, lambda x: to_class(UnmarshalJSON, x), from_none], self.unmarshal_json)
        if self.unowned is not None:
            result["unowned"] = from_union([to_float, lambda x: to_class(Unowned, x), from_none], self.unowned)
        if self.unsafe is not None:
            result["unsafe"] = from_union([to_float, lambda x: to_class(Unsafe, x), from_none], self.unsafe)
        if self.unsigned is not None:
            result["unsigned"] = from_union([to_float, lambda x: to_class(Unsigned, x), from_none], self.unsigned)
        if self.use_serializers is not None:
            result["UseSerializers"] = from_union([to_float, lambda x: to_class(UseSerializers, x), from_none], self.use_serializers)
        if self.ushort is not None:
            result["ushort"] = from_union([to_float, lambda x: to_class(Ushort, x), from_none], self.ushort)
        if self.using is not None:
            result["using"] = from_union([to_float, lambda x: to_class(Using, x), from_none], self.using)
        if self.utf8_json_reader is not None:
            result["Utf8JsonReader"] = from_union([to_float, lambda x: to_class(Utf8JSONReader, x), from_none], self.utf8_json_reader)
        if self.utf8_json_writer is not None:
            result["Utf8JsonWriter"] = from_union([to_float, lambda x: to_class(Utf8JSONWriter, x), from_none], self.utf8_json_writer)
        if self.uuid is not None:
            result["UUID"] = from_union([to_float, lambda x: to_class(UUIDClass, x), from_none], self.uuid)
        if self.var is not None:
            result["var"] = from_union([to_float, lambda x: to_class(Var, x), from_none], self.var)
        if self.virtual is not None:
            result["virtual"] = from_union([to_float, lambda x: to_class(Virtual, x), from_none], self.virtual)
        if self.void is not None:
            result["void"] = from_union([to_float, lambda x: to_class(Void, x), from_none], self.void)
        if self.volatile is not None:
            result["volatile"] = from_union([to_float, lambda x: to_class(Volatile, x), from_none], self.volatile)
        if self.wchar_t is not None:
            result["wchar_t"] = from_union([to_float, lambda x: to_class(WcharT, x), from_none], self.wchar_t)
        if self.weak is not None:
            result["weak"] = from_union([to_float, lambda x: to_class(Weak, x), from_none], self.weak)
        if self.where is not None:
            result["where"] = from_union([to_float, lambda x: to_class(Where, x), from_none], self.where)
        if self.top_level_while is not None:
            result["while"] = from_union([to_float, lambda x: to_class(While, x), from_none], self.top_level_while)
        if self.will_set is not None:
            result["willSet"] = from_union([to_float, lambda x: to_class(WillSet, x), from_none], self.will_set)
        if self.top_level_with is not None:
            result["with"] = from_union([to_float, lambda x: to_class(With, x), from_none], self.top_level_with)
        if self.xor is not None:
            result["xor"] = from_union([to_float, lambda x: to_class(Xor, x), from_none], self.xor)
        if self.xor_eq is not None:
            result["xor_eq"] = from_union([to_float, lambda x: to_class(XorEq, x), from_none], self.xor_eq)
        if self.yes is not None:
            result["YES"] = from_union([to_float, lambda x: to_class(Yes, x), from_none], self.yes)
        if self.top_level_yield is not None:
            result["yield"] = from_union([to_float, lambda x: to_class(Yield, x), from_none], self.top_level_yield)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
