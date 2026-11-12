// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
@objcMembers class TopLevel: NSObject, Codable {
    let dummy: Int
    let obj1: Obj1
    let obj2: Obj2
    let obj3: Obj3
    let obj4: Obj4
    let obj5: Obj5
    let obj6: Obj6

    enum CodingKeys: String, CodingKey {
        case dummy = "dummy"
        case obj1 = "obj1"
        case obj2 = "obj2"
        case obj3 = "obj3"
        case obj4 = "obj4"
        case obj5 = "obj5"
        case obj6 = "obj6"
    }

    init(dummy: Int, obj1: Obj1, obj2: Obj2, obj3: Obj3, obj4: Obj4, obj5: Obj5, obj6: Obj6) {
        self.dummy = dummy
        self.obj1 = obj1
        self.obj2 = obj2
        self.obj3 = obj3
        self.obj4 = obj4
        self.obj5 = obj5
        self.obj6 = obj6
    }
}

// MARK: TopLevel convenience initializers and mutators

extension TopLevel {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(TopLevel.self, from: data)
        self.init(dummy: me.dummy, obj1: me.obj1, obj2: me.obj2, obj3: me.obj3, obj4: me.obj4, obj5: me.obj5, obj6: me.obj6)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        dummy: Int? = nil,
        obj1: Obj1? = nil,
        obj2: Obj2? = nil,
        obj3: Obj3? = nil,
        obj4: Obj4? = nil,
        obj5: Obj5? = nil,
        obj6: Obj6? = nil
    ) -> TopLevel {
        return TopLevel(
            dummy: dummy ?? self.dummy,
            obj1: obj1 ?? self.obj1,
            obj2: obj2 ?? self.obj2,
            obj3: obj3 ?? self.obj3,
            obj4: obj4 ?? self.obj4,
            obj5: obj5 ?? self.obj5,
            obj6: obj6 ?? self.obj6
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Obj1
@objcMembers class Obj1: NSObject, Codable {
    let abstract: Abstract
    let alignas: Alignas
    let alignof: Alignof
    let and: And
    let andEq: AndEq
    let any: AnyClass
    let array: Array
    let arrayNode: ArrayNode
    let asm: ASM
    let assert: Assert
    let async: Async
    let atomic: Atomic
    let atomicCancel: AtomicCancel
    let atomicCommit: AtomicCommit
    let atomicNoexcept: AtomicNoexcept
    let auto: Auto
    let base: Base
    let bitand: Bitand
    let bitor: Bitor
    let bool: BOOLClass
    let boolean: Boolean
    let booleanNode: BooleanNode
    let bycopy: Bycopy
    let byref: Byref
    let byte: Byte
    let calendar: CalendarClass
    let chan: Chan
    let char: Char
    let char16T: Char16T
    let char32T: Char32T
    let checked: Checked
    let clone: Clone
    let coAwait: CoAwait
    let coReturn: CoReturn
    let coYield: CoYield
    let codable: CodableClass
    let codingKey: CodingKeyClass
    let codingKeys: CodingKeysClass
    let compl: Compl
    let complex: Complex
    let concept: Concept
    let console: Console
    let const: Const
    let constCast: ConstCast
    let constexpr: Constexpr
    let constructor: Constructor
    let convert: Convert
    let converter: Converter
    let dummy: Int
    let empty: Empty
    let imaginery: Imaginery
    let obj1Any: Obj1Any
    let obj1As: As
    let obj1Associatedtype: Associatedtype
    let obj1Associativity: Associativity
    let obj1Await: Await
    let obj1Bool: BoolClass
    let obj1Break: Break
    let obj1Case: Case
    let obj1Catch: Catch
    let obj1Class: Class
    let obj1Continue: Continue
    let obj1Convenience: Convenience
    let purpleBool: Obj1Bool
    let purpleClass: ClassClass

    enum CodingKeys: String, CodingKey {
        case abstract = "abstract"
        case alignas = "alignas"
        case alignof = "alignof"
        case and = "and"
        case andEq = "and_eq"
        case any = "Any"
        case array = "array"
        case arrayNode = "ArrayNode"
        case asm = "asm"
        case assert = "assert"
        case async = "async"
        case atomic = "atomic"
        case atomicCancel = "atomic_cancel"
        case atomicCommit = "atomic_commit"
        case atomicNoexcept = "atomic_noexcept"
        case auto = "auto"
        case base = "base"
        case bitand = "bitand"
        case bitor = "bitor"
        case bool = "BOOL"
        case boolean = "boolean"
        case booleanNode = "BooleanNode"
        case bycopy = "bycopy"
        case byref = "byref"
        case byte = "byte"
        case calendar = "Calendar"
        case chan = "chan"
        case char = "char"
        case char16T = "char16_t"
        case char32T = "char32_t"
        case checked = "checked"
        case clone = "clone"
        case coAwait = "co_await"
        case coReturn = "co_return"
        case coYield = "co_yield"
        case codable = "Codable"
        case codingKey = "CodingKey"
        case codingKeys = "CodingKeys"
        case compl = "compl"
        case complex = "_Complex"
        case concept = "concept"
        case console = "console"
        case const = "const"
        case constCast = "const_cast"
        case constexpr = "constexpr"
        case constructor = "constructor"
        case convert = "convert"
        case converter = "converter"
        case dummy = "dummy"
        case empty = "_"
        case imaginery = "_Imaginery"
        case obj1Any = "any"
        case obj1As = "as"
        case obj1Associatedtype = "associatedtype"
        case obj1Associativity = "associativity"
        case obj1Await = "await"
        case obj1Bool = "_Bool"
        case obj1Break = "break"
        case obj1Case = "case"
        case obj1Catch = "catch"
        case obj1Class = "Class"
        case obj1Continue = "continue"
        case obj1Convenience = "convenience"
        case purpleBool = "bool"
        case purpleClass = "class"
    }

    init(abstract: Abstract, alignas: Alignas, alignof: Alignof, and: And, andEq: AndEq, any: AnyClass, array: Array, arrayNode: ArrayNode, asm: ASM, assert: Assert, async: Async, atomic: Atomic, atomicCancel: AtomicCancel, atomicCommit: AtomicCommit, atomicNoexcept: AtomicNoexcept, auto: Auto, base: Base, bitand: Bitand, bitor: Bitor, bool: BOOLClass, boolean: Boolean, booleanNode: BooleanNode, bycopy: Bycopy, byref: Byref, byte: Byte, calendar: CalendarClass, chan: Chan, char: Char, char16T: Char16T, char32T: Char32T, checked: Checked, clone: Clone, coAwait: CoAwait, coReturn: CoReturn, coYield: CoYield, codable: CodableClass, codingKey: CodingKeyClass, codingKeys: CodingKeysClass, compl: Compl, complex: Complex, concept: Concept, console: Console, const: Const, constCast: ConstCast, constexpr: Constexpr, constructor: Constructor, convert: Convert, converter: Converter, dummy: Int, empty: Empty, imaginery: Imaginery, obj1Any: Obj1Any, obj1As: As, obj1Associatedtype: Associatedtype, obj1Associativity: Associativity, obj1Await: Await, obj1Bool: BoolClass, obj1Break: Break, obj1Case: Case, obj1Catch: Catch, obj1Class: Class, obj1Continue: Continue, obj1Convenience: Convenience, purpleBool: Obj1Bool, purpleClass: ClassClass) {
        self.abstract = abstract
        self.alignas = alignas
        self.alignof = alignof
        self.and = and
        self.andEq = andEq
        self.any = any
        self.array = array
        self.arrayNode = arrayNode
        self.asm = asm
        self.assert = assert
        self.async = async
        self.atomic = atomic
        self.atomicCancel = atomicCancel
        self.atomicCommit = atomicCommit
        self.atomicNoexcept = atomicNoexcept
        self.auto = auto
        self.base = base
        self.bitand = bitand
        self.bitor = bitor
        self.bool = bool
        self.boolean = boolean
        self.booleanNode = booleanNode
        self.bycopy = bycopy
        self.byref = byref
        self.byte = byte
        self.calendar = calendar
        self.chan = chan
        self.char = char
        self.char16T = char16T
        self.char32T = char32T
        self.checked = checked
        self.clone = clone
        self.coAwait = coAwait
        self.coReturn = coReturn
        self.coYield = coYield
        self.codable = codable
        self.codingKey = codingKey
        self.codingKeys = codingKeys
        self.compl = compl
        self.complex = complex
        self.concept = concept
        self.console = console
        self.const = const
        self.constCast = constCast
        self.constexpr = constexpr
        self.constructor = constructor
        self.convert = convert
        self.converter = converter
        self.dummy = dummy
        self.empty = empty
        self.imaginery = imaginery
        self.obj1Any = obj1Any
        self.obj1As = obj1As
        self.obj1Associatedtype = obj1Associatedtype
        self.obj1Associativity = obj1Associativity
        self.obj1Await = obj1Await
        self.obj1Bool = obj1Bool
        self.obj1Break = obj1Break
        self.obj1Case = obj1Case
        self.obj1Catch = obj1Catch
        self.obj1Class = obj1Class
        self.obj1Continue = obj1Continue
        self.obj1Convenience = obj1Convenience
        self.purpleBool = purpleBool
        self.purpleClass = purpleClass
    }
}

// MARK: Obj1 convenience initializers and mutators

extension Obj1 {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Obj1.self, from: data)
        self.init(abstract: me.abstract, alignas: me.alignas, alignof: me.alignof, and: me.and, andEq: me.andEq, any: me.any, array: me.array, arrayNode: me.arrayNode, asm: me.asm, assert: me.assert, async: me.async, atomic: me.atomic, atomicCancel: me.atomicCancel, atomicCommit: me.atomicCommit, atomicNoexcept: me.atomicNoexcept, auto: me.auto, base: me.base, bitand: me.bitand, bitor: me.bitor, bool: me.bool, boolean: me.boolean, booleanNode: me.booleanNode, bycopy: me.bycopy, byref: me.byref, byte: me.byte, calendar: me.calendar, chan: me.chan, char: me.char, char16T: me.char16T, char32T: me.char32T, checked: me.checked, clone: me.clone, coAwait: me.coAwait, coReturn: me.coReturn, coYield: me.coYield, codable: me.codable, codingKey: me.codingKey, codingKeys: me.codingKeys, compl: me.compl, complex: me.complex, concept: me.concept, console: me.console, const: me.const, constCast: me.constCast, constexpr: me.constexpr, constructor: me.constructor, convert: me.convert, converter: me.converter, dummy: me.dummy, empty: me.empty, imaginery: me.imaginery, obj1Any: me.obj1Any, obj1As: me.obj1As, obj1Associatedtype: me.obj1Associatedtype, obj1Associativity: me.obj1Associativity, obj1Await: me.obj1Await, obj1Bool: me.obj1Bool, obj1Break: me.obj1Break, obj1Case: me.obj1Case, obj1Catch: me.obj1Catch, obj1Class: me.obj1Class, obj1Continue: me.obj1Continue, obj1Convenience: me.obj1Convenience, purpleBool: me.purpleBool, purpleClass: me.purpleClass)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        abstract: Abstract? = nil,
        alignas: Alignas? = nil,
        alignof: Alignof? = nil,
        and: And? = nil,
        andEq: AndEq? = nil,
        any: AnyClass? = nil,
        array: Array? = nil,
        arrayNode: ArrayNode? = nil,
        asm: ASM? = nil,
        assert: Assert? = nil,
        async: Async? = nil,
        atomic: Atomic? = nil,
        atomicCancel: AtomicCancel? = nil,
        atomicCommit: AtomicCommit? = nil,
        atomicNoexcept: AtomicNoexcept? = nil,
        auto: Auto? = nil,
        base: Base? = nil,
        bitand: Bitand? = nil,
        bitor: Bitor? = nil,
        bool: BOOLClass? = nil,
        boolean: Boolean? = nil,
        booleanNode: BooleanNode? = nil,
        bycopy: Bycopy? = nil,
        byref: Byref? = nil,
        byte: Byte? = nil,
        calendar: CalendarClass? = nil,
        chan: Chan? = nil,
        char: Char? = nil,
        char16T: Char16T? = nil,
        char32T: Char32T? = nil,
        checked: Checked? = nil,
        clone: Clone? = nil,
        coAwait: CoAwait? = nil,
        coReturn: CoReturn? = nil,
        coYield: CoYield? = nil,
        codable: CodableClass? = nil,
        codingKey: CodingKeyClass? = nil,
        codingKeys: CodingKeysClass? = nil,
        compl: Compl? = nil,
        complex: Complex? = nil,
        concept: Concept? = nil,
        console: Console? = nil,
        const: Const? = nil,
        constCast: ConstCast? = nil,
        constexpr: Constexpr? = nil,
        constructor: Constructor? = nil,
        convert: Convert? = nil,
        converter: Converter? = nil,
        dummy: Int? = nil,
        empty: Empty? = nil,
        imaginery: Imaginery? = nil,
        obj1Any: Obj1Any? = nil,
        obj1As: As? = nil,
        obj1Associatedtype: Associatedtype? = nil,
        obj1Associativity: Associativity? = nil,
        obj1Await: Await? = nil,
        obj1Bool: BoolClass? = nil,
        obj1Break: Break? = nil,
        obj1Case: Case? = nil,
        obj1Catch: Catch? = nil,
        obj1Class: Class? = nil,
        obj1Continue: Continue? = nil,
        obj1Convenience: Convenience? = nil,
        purpleBool: Obj1Bool? = nil,
        purpleClass: ClassClass? = nil
    ) -> Obj1 {
        return Obj1(
            abstract: abstract ?? self.abstract,
            alignas: alignas ?? self.alignas,
            alignof: alignof ?? self.alignof,
            and: and ?? self.and,
            andEq: andEq ?? self.andEq,
            any: any ?? self.any,
            array: array ?? self.array,
            arrayNode: arrayNode ?? self.arrayNode,
            asm: asm ?? self.asm,
            assert: assert ?? self.assert,
            async: async ?? self.async,
            atomic: atomic ?? self.atomic,
            atomicCancel: atomicCancel ?? self.atomicCancel,
            atomicCommit: atomicCommit ?? self.atomicCommit,
            atomicNoexcept: atomicNoexcept ?? self.atomicNoexcept,
            auto: auto ?? self.auto,
            base: base ?? self.base,
            bitand: bitand ?? self.bitand,
            bitor: bitor ?? self.bitor,
            bool: bool ?? self.bool,
            boolean: boolean ?? self.boolean,
            booleanNode: booleanNode ?? self.booleanNode,
            bycopy: bycopy ?? self.bycopy,
            byref: byref ?? self.byref,
            byte: byte ?? self.byte,
            calendar: calendar ?? self.calendar,
            chan: chan ?? self.chan,
            char: char ?? self.char,
            char16T: char16T ?? self.char16T,
            char32T: char32T ?? self.char32T,
            checked: checked ?? self.checked,
            clone: clone ?? self.clone,
            coAwait: coAwait ?? self.coAwait,
            coReturn: coReturn ?? self.coReturn,
            coYield: coYield ?? self.coYield,
            codable: codable ?? self.codable,
            codingKey: codingKey ?? self.codingKey,
            codingKeys: codingKeys ?? self.codingKeys,
            compl: compl ?? self.compl,
            complex: complex ?? self.complex,
            concept: concept ?? self.concept,
            console: console ?? self.console,
            const: const ?? self.const,
            constCast: constCast ?? self.constCast,
            constexpr: constexpr ?? self.constexpr,
            constructor: constructor ?? self.constructor,
            convert: convert ?? self.convert,
            converter: converter ?? self.converter,
            dummy: dummy ?? self.dummy,
            empty: empty ?? self.empty,
            imaginery: imaginery ?? self.imaginery,
            obj1Any: obj1Any ?? self.obj1Any,
            obj1As: obj1As ?? self.obj1As,
            obj1Associatedtype: obj1Associatedtype ?? self.obj1Associatedtype,
            obj1Associativity: obj1Associativity ?? self.obj1Associativity,
            obj1Await: obj1Await ?? self.obj1Await,
            obj1Bool: obj1Bool ?? self.obj1Bool,
            obj1Break: obj1Break ?? self.obj1Break,
            obj1Case: obj1Case ?? self.obj1Case,
            obj1Catch: obj1Catch ?? self.obj1Catch,
            obj1Class: obj1Class ?? self.obj1Class,
            obj1Continue: obj1Continue ?? self.obj1Continue,
            obj1Convenience: obj1Convenience ?? self.obj1Convenience,
            purpleBool: purpleBool ?? self.purpleBool,
            purpleClass: purpleClass ?? self.purpleClass
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Abstract
@objcMembers class Abstract: NSObject, Codable {
    let abstract: Int

    enum CodingKeys: String, CodingKey {
        case abstract = "abstract"
    }

    init(abstract: Int) {
        self.abstract = abstract
    }
}

// MARK: Abstract convenience initializers and mutators

extension Abstract {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Abstract.self, from: data)
        self.init(abstract: me.abstract)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        abstract: Int? = nil
    ) -> Abstract {
        return Abstract(
            abstract: abstract ?? self.abstract
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Alignas
@objcMembers class Alignas: NSObject, Codable {
    let alignas: Int

    enum CodingKeys: String, CodingKey {
        case alignas = "alignas"
    }

    init(alignas: Int) {
        self.alignas = alignas
    }
}

// MARK: Alignas convenience initializers and mutators

extension Alignas {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Alignas.self, from: data)
        self.init(alignas: me.alignas)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        alignas: Int? = nil
    ) -> Alignas {
        return Alignas(
            alignas: alignas ?? self.alignas
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Alignof
@objcMembers class Alignof: NSObject, Codable {
    let alignof: Int

    enum CodingKeys: String, CodingKey {
        case alignof = "alignof"
    }

    init(alignof: Int) {
        self.alignof = alignof
    }
}

// MARK: Alignof convenience initializers and mutators

extension Alignof {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Alignof.self, from: data)
        self.init(alignof: me.alignof)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        alignof: Int? = nil
    ) -> Alignof {
        return Alignof(
            alignof: alignof ?? self.alignof
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - And
@objcMembers class And: NSObject, Codable {
    let and: Int

    enum CodingKeys: String, CodingKey {
        case and = "and"
    }

    init(and: Int) {
        self.and = and
    }
}

// MARK: And convenience initializers and mutators

extension And {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(And.self, from: data)
        self.init(and: me.and)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        and: Int? = nil
    ) -> And {
        return And(
            and: and ?? self.and
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - AndEq
@objcMembers class AndEq: NSObject, Codable {
    let andEq: Int

    enum CodingKeys: String, CodingKey {
        case andEq = "and_eq"
    }

    init(andEq: Int) {
        self.andEq = andEq
    }
}

// MARK: AndEq convenience initializers and mutators

extension AndEq {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(AndEq.self, from: data)
        self.init(andEq: me.andEq)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        andEq: Int? = nil
    ) -> AndEq {
        return AndEq(
            andEq: andEq ?? self.andEq
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - AnyClass
@objcMembers class AnyClass: NSObject, Codable {
    let any: Int

    enum CodingKeys: String, CodingKey {
        case any = "Any"
    }

    init(any: Int) {
        self.any = any
    }
}

// MARK: AnyClass convenience initializers and mutators

extension AnyClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(AnyClass.self, from: data)
        self.init(any: me.any)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        any: Int? = nil
    ) -> AnyClass {
        return AnyClass(
            any: any ?? self.any
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Array
@objcMembers class Array: NSObject, Codable {
    let array: Int

    enum CodingKeys: String, CodingKey {
        case array = "array"
    }

    init(array: Int) {
        self.array = array
    }
}

// MARK: Array convenience initializers and mutators

extension Array {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Array.self, from: data)
        self.init(array: me.array)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        array: Int? = nil
    ) -> Array {
        return Array(
            array: array ?? self.array
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ArrayNode
@objcMembers class ArrayNode: NSObject, Codable {
    let arrayNode: Int

    enum CodingKeys: String, CodingKey {
        case arrayNode = "ArrayNode"
    }

    init(arrayNode: Int) {
        self.arrayNode = arrayNode
    }
}

// MARK: ArrayNode convenience initializers and mutators

extension ArrayNode {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ArrayNode.self, from: data)
        self.init(arrayNode: me.arrayNode)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        arrayNode: Int? = nil
    ) -> ArrayNode {
        return ArrayNode(
            arrayNode: arrayNode ?? self.arrayNode
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ASM
@objcMembers class ASM: NSObject, Codable {
    let asm: Int

    enum CodingKeys: String, CodingKey {
        case asm = "asm"
    }

    init(asm: Int) {
        self.asm = asm
    }
}

// MARK: ASM convenience initializers and mutators

extension ASM {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ASM.self, from: data)
        self.init(asm: me.asm)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        asm: Int? = nil
    ) -> ASM {
        return ASM(
            asm: asm ?? self.asm
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Assert
@objcMembers class Assert: NSObject, Codable {
    let assert: Int

    enum CodingKeys: String, CodingKey {
        case assert = "assert"
    }

    init(assert: Int) {
        self.assert = assert
    }
}

// MARK: Assert convenience initializers and mutators

extension Assert {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Assert.self, from: data)
        self.init(assert: me.assert)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        assert: Int? = nil
    ) -> Assert {
        return Assert(
            assert: assert ?? self.assert
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Async
@objcMembers class Async: NSObject, Codable {
    let async: Int

    enum CodingKeys: String, CodingKey {
        case async = "async"
    }

    init(async: Int) {
        self.async = async
    }
}

// MARK: Async convenience initializers and mutators

extension Async {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Async.self, from: data)
        self.init(async: me.async)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        async: Int? = nil
    ) -> Async {
        return Async(
            async: async ?? self.async
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Atomic
@objcMembers class Atomic: NSObject, Codable {
    let atomic: Int

    enum CodingKeys: String, CodingKey {
        case atomic = "atomic"
    }

    init(atomic: Int) {
        self.atomic = atomic
    }
}

// MARK: Atomic convenience initializers and mutators

extension Atomic {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Atomic.self, from: data)
        self.init(atomic: me.atomic)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        atomic: Int? = nil
    ) -> Atomic {
        return Atomic(
            atomic: atomic ?? self.atomic
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - AtomicCancel
@objcMembers class AtomicCancel: NSObject, Codable {
    let atomicCancel: Int

    enum CodingKeys: String, CodingKey {
        case atomicCancel = "atomic_cancel"
    }

    init(atomicCancel: Int) {
        self.atomicCancel = atomicCancel
    }
}

// MARK: AtomicCancel convenience initializers and mutators

extension AtomicCancel {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(AtomicCancel.self, from: data)
        self.init(atomicCancel: me.atomicCancel)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        atomicCancel: Int? = nil
    ) -> AtomicCancel {
        return AtomicCancel(
            atomicCancel: atomicCancel ?? self.atomicCancel
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - AtomicCommit
@objcMembers class AtomicCommit: NSObject, Codable {
    let atomicCommit: Int

    enum CodingKeys: String, CodingKey {
        case atomicCommit = "atomic_commit"
    }

    init(atomicCommit: Int) {
        self.atomicCommit = atomicCommit
    }
}

// MARK: AtomicCommit convenience initializers and mutators

extension AtomicCommit {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(AtomicCommit.self, from: data)
        self.init(atomicCommit: me.atomicCommit)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        atomicCommit: Int? = nil
    ) -> AtomicCommit {
        return AtomicCommit(
            atomicCommit: atomicCommit ?? self.atomicCommit
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - AtomicNoexcept
@objcMembers class AtomicNoexcept: NSObject, Codable {
    let atomicNoexcept: Int

    enum CodingKeys: String, CodingKey {
        case atomicNoexcept = "atomic_noexcept"
    }

    init(atomicNoexcept: Int) {
        self.atomicNoexcept = atomicNoexcept
    }
}

// MARK: AtomicNoexcept convenience initializers and mutators

extension AtomicNoexcept {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(AtomicNoexcept.self, from: data)
        self.init(atomicNoexcept: me.atomicNoexcept)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        atomicNoexcept: Int? = nil
    ) -> AtomicNoexcept {
        return AtomicNoexcept(
            atomicNoexcept: atomicNoexcept ?? self.atomicNoexcept
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Auto
@objcMembers class Auto: NSObject, Codable {
    let auto: Int

    enum CodingKeys: String, CodingKey {
        case auto = "auto"
    }

    init(auto: Int) {
        self.auto = auto
    }
}

// MARK: Auto convenience initializers and mutators

extension Auto {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Auto.self, from: data)
        self.init(auto: me.auto)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        auto: Int? = nil
    ) -> Auto {
        return Auto(
            auto: auto ?? self.auto
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Base
@objcMembers class Base: NSObject, Codable {
    let base: Int

    enum CodingKeys: String, CodingKey {
        case base = "base"
    }

    init(base: Int) {
        self.base = base
    }
}

// MARK: Base convenience initializers and mutators

extension Base {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Base.self, from: data)
        self.init(base: me.base)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        base: Int? = nil
    ) -> Base {
        return Base(
            base: base ?? self.base
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Bitand
@objcMembers class Bitand: NSObject, Codable {
    let bitand: Int

    enum CodingKeys: String, CodingKey {
        case bitand = "bitand"
    }

    init(bitand: Int) {
        self.bitand = bitand
    }
}

// MARK: Bitand convenience initializers and mutators

extension Bitand {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Bitand.self, from: data)
        self.init(bitand: me.bitand)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        bitand: Int? = nil
    ) -> Bitand {
        return Bitand(
            bitand: bitand ?? self.bitand
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Bitor
@objcMembers class Bitor: NSObject, Codable {
    let bitor: Int

    enum CodingKeys: String, CodingKey {
        case bitor = "bitor"
    }

    init(bitor: Int) {
        self.bitor = bitor
    }
}

// MARK: Bitor convenience initializers and mutators

extension Bitor {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Bitor.self, from: data)
        self.init(bitor: me.bitor)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        bitor: Int? = nil
    ) -> Bitor {
        return Bitor(
            bitor: bitor ?? self.bitor
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - BOOLClass
@objcMembers class BOOLClass: NSObject, Codable {
    let bool: Int

    enum CodingKeys: String, CodingKey {
        case bool = "BOOL"
    }

    init(bool: Int) {
        self.bool = bool
    }
}

// MARK: BOOLClass convenience initializers and mutators

extension BOOLClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(BOOLClass.self, from: data)
        self.init(bool: me.bool)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        bool: Int? = nil
    ) -> BOOLClass {
        return BOOLClass(
            bool: bool ?? self.bool
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Boolean
@objcMembers class Boolean: NSObject, Codable {
    let boolean: Int

    enum CodingKeys: String, CodingKey {
        case boolean = "boolean"
    }

    init(boolean: Int) {
        self.boolean = boolean
    }
}

// MARK: Boolean convenience initializers and mutators

extension Boolean {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Boolean.self, from: data)
        self.init(boolean: me.boolean)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        boolean: Int? = nil
    ) -> Boolean {
        return Boolean(
            boolean: boolean ?? self.boolean
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - BooleanNode
@objcMembers class BooleanNode: NSObject, Codable {
    let booleanNode: Int

    enum CodingKeys: String, CodingKey {
        case booleanNode = "BooleanNode"
    }

    init(booleanNode: Int) {
        self.booleanNode = booleanNode
    }
}

// MARK: BooleanNode convenience initializers and mutators

extension BooleanNode {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(BooleanNode.self, from: data)
        self.init(booleanNode: me.booleanNode)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        booleanNode: Int? = nil
    ) -> BooleanNode {
        return BooleanNode(
            booleanNode: booleanNode ?? self.booleanNode
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Bycopy
@objcMembers class Bycopy: NSObject, Codable {
    let bycopy: Int

    enum CodingKeys: String, CodingKey {
        case bycopy = "bycopy"
    }

    init(bycopy: Int) {
        self.bycopy = bycopy
    }
}

// MARK: Bycopy convenience initializers and mutators

extension Bycopy {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Bycopy.self, from: data)
        self.init(bycopy: me.bycopy)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        bycopy: Int? = nil
    ) -> Bycopy {
        return Bycopy(
            bycopy: bycopy ?? self.bycopy
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Byref
@objcMembers class Byref: NSObject, Codable {
    let byref: Int

    enum CodingKeys: String, CodingKey {
        case byref = "byref"
    }

    init(byref: Int) {
        self.byref = byref
    }
}

// MARK: Byref convenience initializers and mutators

extension Byref {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Byref.self, from: data)
        self.init(byref: me.byref)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        byref: Int? = nil
    ) -> Byref {
        return Byref(
            byref: byref ?? self.byref
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Byte
@objcMembers class Byte: NSObject, Codable {
    let byte: Int

    enum CodingKeys: String, CodingKey {
        case byte = "byte"
    }

    init(byte: Int) {
        self.byte = byte
    }
}

// MARK: Byte convenience initializers and mutators

extension Byte {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Byte.self, from: data)
        self.init(byte: me.byte)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        byte: Int? = nil
    ) -> Byte {
        return Byte(
            byte: byte ?? self.byte
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - CalendarClass
@objcMembers class CalendarClass: NSObject, Codable {
    let calendar: Int

    enum CodingKeys: String, CodingKey {
        case calendar = "Calendar"
    }

    init(calendar: Int) {
        self.calendar = calendar
    }
}

// MARK: CalendarClass convenience initializers and mutators

extension CalendarClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(CalendarClass.self, from: data)
        self.init(calendar: me.calendar)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        calendar: Int? = nil
    ) -> CalendarClass {
        return CalendarClass(
            calendar: calendar ?? self.calendar
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Chan
@objcMembers class Chan: NSObject, Codable {
    let chan: Int

    enum CodingKeys: String, CodingKey {
        case chan = "chan"
    }

    init(chan: Int) {
        self.chan = chan
    }
}

// MARK: Chan convenience initializers and mutators

extension Chan {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Chan.self, from: data)
        self.init(chan: me.chan)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        chan: Int? = nil
    ) -> Chan {
        return Chan(
            chan: chan ?? self.chan
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Char
@objcMembers class Char: NSObject, Codable {
    let char: Int

    enum CodingKeys: String, CodingKey {
        case char = "char"
    }

    init(char: Int) {
        self.char = char
    }
}

// MARK: Char convenience initializers and mutators

extension Char {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Char.self, from: data)
        self.init(char: me.char)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        char: Int? = nil
    ) -> Char {
        return Char(
            char: char ?? self.char
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Char16T
@objcMembers class Char16T: NSObject, Codable {
    let char16T: Int

    enum CodingKeys: String, CodingKey {
        case char16T = "char16_t"
    }

    init(char16T: Int) {
        self.char16T = char16T
    }
}

// MARK: Char16T convenience initializers and mutators

extension Char16T {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Char16T.self, from: data)
        self.init(char16T: me.char16T)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        char16T: Int? = nil
    ) -> Char16T {
        return Char16T(
            char16T: char16T ?? self.char16T
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Char32T
@objcMembers class Char32T: NSObject, Codable {
    let char32T: Int

    enum CodingKeys: String, CodingKey {
        case char32T = "char32_t"
    }

    init(char32T: Int) {
        self.char32T = char32T
    }
}

// MARK: Char32T convenience initializers and mutators

extension Char32T {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Char32T.self, from: data)
        self.init(char32T: me.char32T)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        char32T: Int? = nil
    ) -> Char32T {
        return Char32T(
            char32T: char32T ?? self.char32T
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Checked
@objcMembers class Checked: NSObject, Codable {
    let checked: Int

    enum CodingKeys: String, CodingKey {
        case checked = "checked"
    }

    init(checked: Int) {
        self.checked = checked
    }
}

// MARK: Checked convenience initializers and mutators

extension Checked {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Checked.self, from: data)
        self.init(checked: me.checked)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        checked: Int? = nil
    ) -> Checked {
        return Checked(
            checked: checked ?? self.checked
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Clone
@objcMembers class Clone: NSObject, Codable {
    let clone: Int

    enum CodingKeys: String, CodingKey {
        case clone = "clone"
    }

    init(clone: Int) {
        self.clone = clone
    }
}

// MARK: Clone convenience initializers and mutators

extension Clone {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Clone.self, from: data)
        self.init(clone: me.clone)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        clone: Int? = nil
    ) -> Clone {
        return Clone(
            clone: clone ?? self.clone
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - CoAwait
@objcMembers class CoAwait: NSObject, Codable {
    let coAwait: Int

    enum CodingKeys: String, CodingKey {
        case coAwait = "co_await"
    }

    init(coAwait: Int) {
        self.coAwait = coAwait
    }
}

// MARK: CoAwait convenience initializers and mutators

extension CoAwait {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(CoAwait.self, from: data)
        self.init(coAwait: me.coAwait)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        coAwait: Int? = nil
    ) -> CoAwait {
        return CoAwait(
            coAwait: coAwait ?? self.coAwait
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - CoReturn
@objcMembers class CoReturn: NSObject, Codable {
    let coReturn: Int

    enum CodingKeys: String, CodingKey {
        case coReturn = "co_return"
    }

    init(coReturn: Int) {
        self.coReturn = coReturn
    }
}

// MARK: CoReturn convenience initializers and mutators

extension CoReturn {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(CoReturn.self, from: data)
        self.init(coReturn: me.coReturn)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        coReturn: Int? = nil
    ) -> CoReturn {
        return CoReturn(
            coReturn: coReturn ?? self.coReturn
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - CoYield
@objcMembers class CoYield: NSObject, Codable {
    let coYield: Int

    enum CodingKeys: String, CodingKey {
        case coYield = "co_yield"
    }

    init(coYield: Int) {
        self.coYield = coYield
    }
}

// MARK: CoYield convenience initializers and mutators

extension CoYield {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(CoYield.self, from: data)
        self.init(coYield: me.coYield)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        coYield: Int? = nil
    ) -> CoYield {
        return CoYield(
            coYield: coYield ?? self.coYield
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - CodableClass
@objcMembers class CodableClass: NSObject, Codable {
    let codable: Int

    enum CodingKeys: String, CodingKey {
        case codable = "Codable"
    }

    init(codable: Int) {
        self.codable = codable
    }
}

// MARK: CodableClass convenience initializers and mutators

extension CodableClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(CodableClass.self, from: data)
        self.init(codable: me.codable)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        codable: Int? = nil
    ) -> CodableClass {
        return CodableClass(
            codable: codable ?? self.codable
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - CodingKeyClass
@objcMembers class CodingKeyClass: NSObject, Codable {
    let codingKey: Int

    enum CodingKeys: String, CodingKey {
        case codingKey = "CodingKey"
    }

    init(codingKey: Int) {
        self.codingKey = codingKey
    }
}

// MARK: CodingKeyClass convenience initializers and mutators

extension CodingKeyClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(CodingKeyClass.self, from: data)
        self.init(codingKey: me.codingKey)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        codingKey: Int? = nil
    ) -> CodingKeyClass {
        return CodingKeyClass(
            codingKey: codingKey ?? self.codingKey
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - CodingKeysClass
@objcMembers class CodingKeysClass: NSObject, Codable {
    let codingKeys: Int

    enum CodingKeys: String, CodingKey {
        case codingKeys = "CodingKeys"
    }

    init(codingKeys: Int) {
        self.codingKeys = codingKeys
    }
}

// MARK: CodingKeysClass convenience initializers and mutators

extension CodingKeysClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(CodingKeysClass.self, from: data)
        self.init(codingKeys: me.codingKeys)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        codingKeys: Int? = nil
    ) -> CodingKeysClass {
        return CodingKeysClass(
            codingKeys: codingKeys ?? self.codingKeys
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Compl
@objcMembers class Compl: NSObject, Codable {
    let compl: Int

    enum CodingKeys: String, CodingKey {
        case compl = "compl"
    }

    init(compl: Int) {
        self.compl = compl
    }
}

// MARK: Compl convenience initializers and mutators

extension Compl {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Compl.self, from: data)
        self.init(compl: me.compl)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        compl: Int? = nil
    ) -> Compl {
        return Compl(
            compl: compl ?? self.compl
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Complex
@objcMembers class Complex: NSObject, Codable {
    let complex: Int

    enum CodingKeys: String, CodingKey {
        case complex = "_Complex"
    }

    init(complex: Int) {
        self.complex = complex
    }
}

// MARK: Complex convenience initializers and mutators

extension Complex {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Complex.self, from: data)
        self.init(complex: me.complex)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        complex: Int? = nil
    ) -> Complex {
        return Complex(
            complex: complex ?? self.complex
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Concept
@objcMembers class Concept: NSObject, Codable {
    let concept: Int

    enum CodingKeys: String, CodingKey {
        case concept = "concept"
    }

    init(concept: Int) {
        self.concept = concept
    }
}

// MARK: Concept convenience initializers and mutators

extension Concept {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Concept.self, from: data)
        self.init(concept: me.concept)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        concept: Int? = nil
    ) -> Concept {
        return Concept(
            concept: concept ?? self.concept
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Console
@objcMembers class Console: NSObject, Codable {
    let console: Int

    enum CodingKeys: String, CodingKey {
        case console = "console"
    }

    init(console: Int) {
        self.console = console
    }
}

// MARK: Console convenience initializers and mutators

extension Console {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Console.self, from: data)
        self.init(console: me.console)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        console: Int? = nil
    ) -> Console {
        return Console(
            console: console ?? self.console
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Const
@objcMembers class Const: NSObject, Codable {
    let const: Int

    enum CodingKeys: String, CodingKey {
        case const = "const"
    }

    init(const: Int) {
        self.const = const
    }
}

// MARK: Const convenience initializers and mutators

extension Const {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Const.self, from: data)
        self.init(const: me.const)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        const: Int? = nil
    ) -> Const {
        return Const(
            const: const ?? self.const
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ConstCast
@objcMembers class ConstCast: NSObject, Codable {
    let constCast: Int

    enum CodingKeys: String, CodingKey {
        case constCast = "const_cast"
    }

    init(constCast: Int) {
        self.constCast = constCast
    }
}

// MARK: ConstCast convenience initializers and mutators

extension ConstCast {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ConstCast.self, from: data)
        self.init(constCast: me.constCast)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        constCast: Int? = nil
    ) -> ConstCast {
        return ConstCast(
            constCast: constCast ?? self.constCast
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Constexpr
@objcMembers class Constexpr: NSObject, Codable {
    let constexpr: Int

    enum CodingKeys: String, CodingKey {
        case constexpr = "constexpr"
    }

    init(constexpr: Int) {
        self.constexpr = constexpr
    }
}

// MARK: Constexpr convenience initializers and mutators

extension Constexpr {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Constexpr.self, from: data)
        self.init(constexpr: me.constexpr)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        constexpr: Int? = nil
    ) -> Constexpr {
        return Constexpr(
            constexpr: constexpr ?? self.constexpr
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Constructor
@objcMembers class Constructor: NSObject, Codable {
    let constructor: Int

    enum CodingKeys: String, CodingKey {
        case constructor = "constructor"
    }

    init(constructor: Int) {
        self.constructor = constructor
    }
}

// MARK: Constructor convenience initializers and mutators

extension Constructor {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Constructor.self, from: data)
        self.init(constructor: me.constructor)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        constructor: Int? = nil
    ) -> Constructor {
        return Constructor(
            constructor: constructor ?? self.constructor
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Convert
@objcMembers class Convert: NSObject, Codable {
    let convert: Int

    enum CodingKeys: String, CodingKey {
        case convert = "convert"
    }

    init(convert: Int) {
        self.convert = convert
    }
}

// MARK: Convert convenience initializers and mutators

extension Convert {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Convert.self, from: data)
        self.init(convert: me.convert)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        convert: Int? = nil
    ) -> Convert {
        return Convert(
            convert: convert ?? self.convert
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Converter
@objcMembers class Converter: NSObject, Codable {
    let converter: Int

    enum CodingKeys: String, CodingKey {
        case converter = "converter"
    }

    init(converter: Int) {
        self.converter = converter
    }
}

// MARK: Converter convenience initializers and mutators

extension Converter {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Converter.self, from: data)
        self.init(converter: me.converter)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        converter: Int? = nil
    ) -> Converter {
        return Converter(
            converter: converter ?? self.converter
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Empty
@objcMembers class Empty: NSObject, Codable {
    let empty: Int

    enum CodingKeys: String, CodingKey {
        case empty = "_"
    }

    init(empty: Int) {
        self.empty = empty
    }
}

// MARK: Empty convenience initializers and mutators

extension Empty {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Empty.self, from: data)
        self.init(empty: me.empty)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        empty: Int? = nil
    ) -> Empty {
        return Empty(
            empty: empty ?? self.empty
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Imaginery
@objcMembers class Imaginery: NSObject, Codable {
    let imaginery: Int

    enum CodingKeys: String, CodingKey {
        case imaginery = "_Imaginery"
    }

    init(imaginery: Int) {
        self.imaginery = imaginery
    }
}

// MARK: Imaginery convenience initializers and mutators

extension Imaginery {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Imaginery.self, from: data)
        self.init(imaginery: me.imaginery)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        imaginery: Int? = nil
    ) -> Imaginery {
        return Imaginery(
            imaginery: imaginery ?? self.imaginery
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Obj1Any
@objcMembers class Obj1Any: NSObject, Codable {
    let any: Int

    enum CodingKeys: String, CodingKey {
        case any = "any"
    }

    init(any: Int) {
        self.any = any
    }
}

// MARK: Obj1Any convenience initializers and mutators

extension Obj1Any {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Obj1Any.self, from: data)
        self.init(any: me.any)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        any: Int? = nil
    ) -> Obj1Any {
        return Obj1Any(
            any: any ?? self.any
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - As
@objcMembers class As: NSObject, Codable {
    let asAs: Int

    enum CodingKeys: String, CodingKey {
        case asAs = "as"
    }

    init(asAs: Int) {
        self.asAs = asAs
    }
}

// MARK: As convenience initializers and mutators

extension As {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(As.self, from: data)
        self.init(asAs: me.asAs)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        asAs: Int? = nil
    ) -> As {
        return As(
            asAs: asAs ?? self.asAs
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Associatedtype
@objcMembers class Associatedtype: NSObject, Codable {
    let associatedtypeAssociatedtype: Int

    enum CodingKeys: String, CodingKey {
        case associatedtypeAssociatedtype = "associatedtype"
    }

    init(associatedtypeAssociatedtype: Int) {
        self.associatedtypeAssociatedtype = associatedtypeAssociatedtype
    }
}

// MARK: Associatedtype convenience initializers and mutators

extension Associatedtype {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Associatedtype.self, from: data)
        self.init(associatedtypeAssociatedtype: me.associatedtypeAssociatedtype)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        associatedtypeAssociatedtype: Int? = nil
    ) -> Associatedtype {
        return Associatedtype(
            associatedtypeAssociatedtype: associatedtypeAssociatedtype ?? self.associatedtypeAssociatedtype
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Associativity
@objcMembers class Associativity: NSObject, Codable {
    let associativityAssociativity: Int

    enum CodingKeys: String, CodingKey {
        case associativityAssociativity = "associativity"
    }

    init(associativityAssociativity: Int) {
        self.associativityAssociativity = associativityAssociativity
    }
}

// MARK: Associativity convenience initializers and mutators

extension Associativity {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Associativity.self, from: data)
        self.init(associativityAssociativity: me.associativityAssociativity)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        associativityAssociativity: Int? = nil
    ) -> Associativity {
        return Associativity(
            associativityAssociativity: associativityAssociativity ?? self.associativityAssociativity
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Await
@objcMembers class Await: NSObject, Codable {
    let awaitAwait: Int

    enum CodingKeys: String, CodingKey {
        case awaitAwait = "await"
    }

    init(awaitAwait: Int) {
        self.awaitAwait = awaitAwait
    }
}

// MARK: Await convenience initializers and mutators

extension Await {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Await.self, from: data)
        self.init(awaitAwait: me.awaitAwait)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        awaitAwait: Int? = nil
    ) -> Await {
        return Await(
            awaitAwait: awaitAwait ?? self.awaitAwait
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - BoolClass
@objcMembers class BoolClass: NSObject, Codable {
    let bool: Int

    enum CodingKeys: String, CodingKey {
        case bool = "_Bool"
    }

    init(bool: Int) {
        self.bool = bool
    }
}

// MARK: BoolClass convenience initializers and mutators

extension BoolClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(BoolClass.self, from: data)
        self.init(bool: me.bool)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        bool: Int? = nil
    ) -> BoolClass {
        return BoolClass(
            bool: bool ?? self.bool
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Break
@objcMembers class Break: NSObject, Codable {
    let breakBreak: Int

    enum CodingKeys: String, CodingKey {
        case breakBreak = "break"
    }

    init(breakBreak: Int) {
        self.breakBreak = breakBreak
    }
}

// MARK: Break convenience initializers and mutators

extension Break {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Break.self, from: data)
        self.init(breakBreak: me.breakBreak)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        breakBreak: Int? = nil
    ) -> Break {
        return Break(
            breakBreak: breakBreak ?? self.breakBreak
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Case
@objcMembers class Case: NSObject, Codable {
    let caseCase: Int

    enum CodingKeys: String, CodingKey {
        case caseCase = "case"
    }

    init(caseCase: Int) {
        self.caseCase = caseCase
    }
}

// MARK: Case convenience initializers and mutators

extension Case {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Case.self, from: data)
        self.init(caseCase: me.caseCase)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        caseCase: Int? = nil
    ) -> Case {
        return Case(
            caseCase: caseCase ?? self.caseCase
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Catch
@objcMembers class Catch: NSObject, Codable {
    let catchCatch: Int

    enum CodingKeys: String, CodingKey {
        case catchCatch = "catch"
    }

    init(catchCatch: Int) {
        self.catchCatch = catchCatch
    }
}

// MARK: Catch convenience initializers and mutators

extension Catch {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Catch.self, from: data)
        self.init(catchCatch: me.catchCatch)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        catchCatch: Int? = nil
    ) -> Catch {
        return Catch(
            catchCatch: catchCatch ?? self.catchCatch
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Class
@objcMembers class Class: NSObject, Codable {
    let classClass: Int

    enum CodingKeys: String, CodingKey {
        case classClass = "Class"
    }

    init(classClass: Int) {
        self.classClass = classClass
    }
}

// MARK: Class convenience initializers and mutators

extension Class {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Class.self, from: data)
        self.init(classClass: me.classClass)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        classClass: Int? = nil
    ) -> Class {
        return Class(
            classClass: classClass ?? self.classClass
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Continue
@objcMembers class Continue: NSObject, Codable {
    let continueContinue: Int

    enum CodingKeys: String, CodingKey {
        case continueContinue = "continue"
    }

    init(continueContinue: Int) {
        self.continueContinue = continueContinue
    }
}

// MARK: Continue convenience initializers and mutators

extension Continue {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Continue.self, from: data)
        self.init(continueContinue: me.continueContinue)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        continueContinue: Int? = nil
    ) -> Continue {
        return Continue(
            continueContinue: continueContinue ?? self.continueContinue
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Convenience
@objcMembers class Convenience: NSObject, Codable {
    let convenienceConvenience: Int

    enum CodingKeys: String, CodingKey {
        case convenienceConvenience = "convenience"
    }

    init(convenienceConvenience: Int) {
        self.convenienceConvenience = convenienceConvenience
    }
}

// MARK: Convenience convenience initializers and mutators

extension Convenience {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Convenience.self, from: data)
        self.init(convenienceConvenience: me.convenienceConvenience)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        convenienceConvenience: Int? = nil
    ) -> Convenience {
        return Convenience(
            convenienceConvenience: convenienceConvenience ?? self.convenienceConvenience
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Obj1Bool
@objcMembers class Obj1Bool: NSObject, Codable {
    let bool: Int

    enum CodingKeys: String, CodingKey {
        case bool = "bool"
    }

    init(bool: Int) {
        self.bool = bool
    }
}

// MARK: Obj1Bool convenience initializers and mutators

extension Obj1Bool {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Obj1Bool.self, from: data)
        self.init(bool: me.bool)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        bool: Int? = nil
    ) -> Obj1Bool {
        return Obj1Bool(
            bool: bool ?? self.bool
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ClassClass
@objcMembers class ClassClass: NSObject, Codable {
    let classClass: Int

    enum CodingKeys: String, CodingKey {
        case classClass = "class"
    }

    init(classClass: Int) {
        self.classClass = classClass
    }
}

// MARK: ClassClass convenience initializers and mutators

extension ClassClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ClassClass.self, from: data)
        self.init(classClass: me.classClass)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        classClass: Int? = nil
    ) -> ClassClass {
        return ClassClass(
            classClass: classClass ?? self.classClass
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Obj2
@objcMembers class Obj2: NSObject, Codable {
    let cultureInfo: CultureInfo
    let date: DateClass
    let dateFormatter: DateFormatterClass
    let dateOnly: DateOnly
    let dateOnlyConverter: DateOnlyConverter
    let dateParseHandling: DateParseHandling
    let dateTime: DateTime
    let dateTimeStyles: DateTimeStyles
    let debugger: Debugger
    let decimal: Decimal
    let declare: Declare
    let decltype: Decltype
    let decodeString: DecodeString
    let decoder: DecoderClass
    let decodingError: DecodingErrorClass
    let def: Def
    let del: Del
    let delegate: Delegate
    let delete: Delete
    let deserializationFeature: DeserializationFeature
    let dict: Dict
    let dictionary: Dictionary
    let double: DoubleClass
    let doubleNode: DoubleNode
    let dummy: Int
    let dynamicCast: DynamicCast
    let elif: Elif
    let encodeQuickType: EncodeQuickType
    let encoder: EncoderClass
    let enumValues: EnumValues
    let equalityContract: EqualityContract
    let equatable: Equatable
    let event: Event
    let except: Except
    let exception: Exception
    let explicit: Explicit
    let export: Export
    let exposing: Exposing
    let extends: Extends
    let extern: Extern
    let finally: Finally
    let fixed: Fixed
    let float: Float
    let foreach: Foreach
    let formatException: FormatException
    let friend: Friend
    let from: From
    let fromDict: FromDict
    let fromJSON: FromJSON
    let obj2Default: Default
    let obj2Defer: Defer
    let obj2Deinit: Deinit
    let obj2DidSet: DidSet
    let obj2Do: Do
    let obj2Dynamic: Dynamic
    let obj2Else: Else
    let obj2Enum: Enum
    let obj2Extension: Extension
    let obj2Fallthrough: Fallthrough
    let obj2False: False
    let obj2Fileprivate: Fileprivate
    let obj2Final: Final
    let obj2For: For
    let obj2Func: Func
    let purpleFalse: FalseClass

    enum CodingKeys: String, CodingKey {
        case cultureInfo = "CultureInfo"
        case date = "date"
        case dateFormatter = "DateFormatter"
        case dateOnly = "DateOnly"
        case dateOnlyConverter = "DateOnlyConverter"
        case dateParseHandling = "date_parse_handling"
        case dateTime = "DateTime"
        case dateTimeStyles = "DateTimeStyles"
        case debugger = "debugger"
        case decimal = "decimal"
        case declare = "declare"
        case decltype = "decltype"
        case decodeString = "decode_string"
        case decoder = "Decoder"
        case decodingError = "DecodingError"
        case def = "def"
        case del = "del"
        case delegate = "delegate"
        case delete = "delete"
        case deserializationFeature = "DeserializationFeature"
        case dict = "dict"
        case dictionary = "dictionary"
        case double = "double"
        case doubleNode = "DoubleNode"
        case dummy = "dummy"
        case dynamicCast = "dynamic_cast"
        case elif = "elif"
        case encodeQuickType = "encode_quick_type"
        case encoder = "Encoder"
        case enumValues = "EnumValues"
        case equalityContract = "equalityContract"
        case equatable = "Equatable"
        case event = "event"
        case except = "except"
        case exception = "exception"
        case explicit = "explicit"
        case export = "export"
        case exposing = "exposing"
        case extends = "extends"
        case extern = "extern"
        case finally = "finally"
        case fixed = "fixed"
        case float = "float"
        case foreach = "foreach"
        case formatException = "FormatException"
        case friend = "friend"
        case from = "from"
        case fromDict = "from_dict"
        case fromJSON = "from_json"
        case obj2Default = "default"
        case obj2Defer = "defer"
        case obj2Deinit = "deinit"
        case obj2DidSet = "didSet"
        case obj2Do = "do"
        case obj2Dynamic = "dynamic"
        case obj2Else = "else"
        case obj2Enum = "enum"
        case obj2Extension = "extension"
        case obj2Fallthrough = "fallthrough"
        case obj2False = "False"
        case obj2Fileprivate = "fileprivate"
        case obj2Final = "final"
        case obj2For = "for"
        case obj2Func = "func"
        case purpleFalse = "false"
    }

    init(cultureInfo: CultureInfo, date: DateClass, dateFormatter: DateFormatterClass, dateOnly: DateOnly, dateOnlyConverter: DateOnlyConverter, dateParseHandling: DateParseHandling, dateTime: DateTime, dateTimeStyles: DateTimeStyles, debugger: Debugger, decimal: Decimal, declare: Declare, decltype: Decltype, decodeString: DecodeString, decoder: DecoderClass, decodingError: DecodingErrorClass, def: Def, del: Del, delegate: Delegate, delete: Delete, deserializationFeature: DeserializationFeature, dict: Dict, dictionary: Dictionary, double: DoubleClass, doubleNode: DoubleNode, dummy: Int, dynamicCast: DynamicCast, elif: Elif, encodeQuickType: EncodeQuickType, encoder: EncoderClass, enumValues: EnumValues, equalityContract: EqualityContract, equatable: Equatable, event: Event, except: Except, exception: Exception, explicit: Explicit, export: Export, exposing: Exposing, extends: Extends, extern: Extern, finally: Finally, fixed: Fixed, float: Float, foreach: Foreach, formatException: FormatException, friend: Friend, from: From, fromDict: FromDict, fromJSON: FromJSON, obj2Default: Default, obj2Defer: Defer, obj2Deinit: Deinit, obj2DidSet: DidSet, obj2Do: Do, obj2Dynamic: Dynamic, obj2Else: Else, obj2Enum: Enum, obj2Extension: Extension, obj2Fallthrough: Fallthrough, obj2False: False, obj2Fileprivate: Fileprivate, obj2Final: Final, obj2For: For, obj2Func: Func, purpleFalse: FalseClass) {
        self.cultureInfo = cultureInfo
        self.date = date
        self.dateFormatter = dateFormatter
        self.dateOnly = dateOnly
        self.dateOnlyConverter = dateOnlyConverter
        self.dateParseHandling = dateParseHandling
        self.dateTime = dateTime
        self.dateTimeStyles = dateTimeStyles
        self.debugger = debugger
        self.decimal = decimal
        self.declare = declare
        self.decltype = decltype
        self.decodeString = decodeString
        self.decoder = decoder
        self.decodingError = decodingError
        self.def = def
        self.del = del
        self.delegate = delegate
        self.delete = delete
        self.deserializationFeature = deserializationFeature
        self.dict = dict
        self.dictionary = dictionary
        self.double = double
        self.doubleNode = doubleNode
        self.dummy = dummy
        self.dynamicCast = dynamicCast
        self.elif = elif
        self.encodeQuickType = encodeQuickType
        self.encoder = encoder
        self.enumValues = enumValues
        self.equalityContract = equalityContract
        self.equatable = equatable
        self.event = event
        self.except = except
        self.exception = exception
        self.explicit = explicit
        self.export = export
        self.exposing = exposing
        self.extends = extends
        self.extern = extern
        self.finally = finally
        self.fixed = fixed
        self.float = float
        self.foreach = foreach
        self.formatException = formatException
        self.friend = friend
        self.from = from
        self.fromDict = fromDict
        self.fromJSON = fromJSON
        self.obj2Default = obj2Default
        self.obj2Defer = obj2Defer
        self.obj2Deinit = obj2Deinit
        self.obj2DidSet = obj2DidSet
        self.obj2Do = obj2Do
        self.obj2Dynamic = obj2Dynamic
        self.obj2Else = obj2Else
        self.obj2Enum = obj2Enum
        self.obj2Extension = obj2Extension
        self.obj2Fallthrough = obj2Fallthrough
        self.obj2False = obj2False
        self.obj2Fileprivate = obj2Fileprivate
        self.obj2Final = obj2Final
        self.obj2For = obj2For
        self.obj2Func = obj2Func
        self.purpleFalse = purpleFalse
    }
}

// MARK: Obj2 convenience initializers and mutators

extension Obj2 {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Obj2.self, from: data)
        self.init(cultureInfo: me.cultureInfo, date: me.date, dateFormatter: me.dateFormatter, dateOnly: me.dateOnly, dateOnlyConverter: me.dateOnlyConverter, dateParseHandling: me.dateParseHandling, dateTime: me.dateTime, dateTimeStyles: me.dateTimeStyles, debugger: me.debugger, decimal: me.decimal, declare: me.declare, decltype: me.decltype, decodeString: me.decodeString, decoder: me.decoder, decodingError: me.decodingError, def: me.def, del: me.del, delegate: me.delegate, delete: me.delete, deserializationFeature: me.deserializationFeature, dict: me.dict, dictionary: me.dictionary, double: me.double, doubleNode: me.doubleNode, dummy: me.dummy, dynamicCast: me.dynamicCast, elif: me.elif, encodeQuickType: me.encodeQuickType, encoder: me.encoder, enumValues: me.enumValues, equalityContract: me.equalityContract, equatable: me.equatable, event: me.event, except: me.except, exception: me.exception, explicit: me.explicit, export: me.export, exposing: me.exposing, extends: me.extends, extern: me.extern, finally: me.finally, fixed: me.fixed, float: me.float, foreach: me.foreach, formatException: me.formatException, friend: me.friend, from: me.from, fromDict: me.fromDict, fromJSON: me.fromJSON, obj2Default: me.obj2Default, obj2Defer: me.obj2Defer, obj2Deinit: me.obj2Deinit, obj2DidSet: me.obj2DidSet, obj2Do: me.obj2Do, obj2Dynamic: me.obj2Dynamic, obj2Else: me.obj2Else, obj2Enum: me.obj2Enum, obj2Extension: me.obj2Extension, obj2Fallthrough: me.obj2Fallthrough, obj2False: me.obj2False, obj2Fileprivate: me.obj2Fileprivate, obj2Final: me.obj2Final, obj2For: me.obj2For, obj2Func: me.obj2Func, purpleFalse: me.purpleFalse)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        cultureInfo: CultureInfo? = nil,
        date: DateClass? = nil,
        dateFormatter: DateFormatterClass? = nil,
        dateOnly: DateOnly? = nil,
        dateOnlyConverter: DateOnlyConverter? = nil,
        dateParseHandling: DateParseHandling? = nil,
        dateTime: DateTime? = nil,
        dateTimeStyles: DateTimeStyles? = nil,
        debugger: Debugger? = nil,
        decimal: Decimal? = nil,
        declare: Declare? = nil,
        decltype: Decltype? = nil,
        decodeString: DecodeString? = nil,
        decoder: DecoderClass? = nil,
        decodingError: DecodingErrorClass? = nil,
        def: Def? = nil,
        del: Del? = nil,
        delegate: Delegate? = nil,
        delete: Delete? = nil,
        deserializationFeature: DeserializationFeature? = nil,
        dict: Dict? = nil,
        dictionary: Dictionary? = nil,
        double: DoubleClass? = nil,
        doubleNode: DoubleNode? = nil,
        dummy: Int? = nil,
        dynamicCast: DynamicCast? = nil,
        elif: Elif? = nil,
        encodeQuickType: EncodeQuickType? = nil,
        encoder: EncoderClass? = nil,
        enumValues: EnumValues? = nil,
        equalityContract: EqualityContract? = nil,
        equatable: Equatable? = nil,
        event: Event? = nil,
        except: Except? = nil,
        exception: Exception? = nil,
        explicit: Explicit? = nil,
        export: Export? = nil,
        exposing: Exposing? = nil,
        extends: Extends? = nil,
        extern: Extern? = nil,
        finally: Finally? = nil,
        fixed: Fixed? = nil,
        float: Float? = nil,
        foreach: Foreach? = nil,
        formatException: FormatException? = nil,
        friend: Friend? = nil,
        from: From? = nil,
        fromDict: FromDict? = nil,
        fromJSON: FromJSON? = nil,
        obj2Default: Default? = nil,
        obj2Defer: Defer? = nil,
        obj2Deinit: Deinit? = nil,
        obj2DidSet: DidSet? = nil,
        obj2Do: Do? = nil,
        obj2Dynamic: Dynamic? = nil,
        obj2Else: Else? = nil,
        obj2Enum: Enum? = nil,
        obj2Extension: Extension? = nil,
        obj2Fallthrough: Fallthrough? = nil,
        obj2False: False? = nil,
        obj2Fileprivate: Fileprivate? = nil,
        obj2Final: Final? = nil,
        obj2For: For? = nil,
        obj2Func: Func? = nil,
        purpleFalse: FalseClass? = nil
    ) -> Obj2 {
        return Obj2(
            cultureInfo: cultureInfo ?? self.cultureInfo,
            date: date ?? self.date,
            dateFormatter: dateFormatter ?? self.dateFormatter,
            dateOnly: dateOnly ?? self.dateOnly,
            dateOnlyConverter: dateOnlyConverter ?? self.dateOnlyConverter,
            dateParseHandling: dateParseHandling ?? self.dateParseHandling,
            dateTime: dateTime ?? self.dateTime,
            dateTimeStyles: dateTimeStyles ?? self.dateTimeStyles,
            debugger: debugger ?? self.debugger,
            decimal: decimal ?? self.decimal,
            declare: declare ?? self.declare,
            decltype: decltype ?? self.decltype,
            decodeString: decodeString ?? self.decodeString,
            decoder: decoder ?? self.decoder,
            decodingError: decodingError ?? self.decodingError,
            def: def ?? self.def,
            del: del ?? self.del,
            delegate: delegate ?? self.delegate,
            delete: delete ?? self.delete,
            deserializationFeature: deserializationFeature ?? self.deserializationFeature,
            dict: dict ?? self.dict,
            dictionary: dictionary ?? self.dictionary,
            double: double ?? self.double,
            doubleNode: doubleNode ?? self.doubleNode,
            dummy: dummy ?? self.dummy,
            dynamicCast: dynamicCast ?? self.dynamicCast,
            elif: elif ?? self.elif,
            encodeQuickType: encodeQuickType ?? self.encodeQuickType,
            encoder: encoder ?? self.encoder,
            enumValues: enumValues ?? self.enumValues,
            equalityContract: equalityContract ?? self.equalityContract,
            equatable: equatable ?? self.equatable,
            event: event ?? self.event,
            except: except ?? self.except,
            exception: exception ?? self.exception,
            explicit: explicit ?? self.explicit,
            export: export ?? self.export,
            exposing: exposing ?? self.exposing,
            extends: extends ?? self.extends,
            extern: extern ?? self.extern,
            finally: finally ?? self.finally,
            fixed: fixed ?? self.fixed,
            float: float ?? self.float,
            foreach: foreach ?? self.foreach,
            formatException: formatException ?? self.formatException,
            friend: friend ?? self.friend,
            from: from ?? self.from,
            fromDict: fromDict ?? self.fromDict,
            fromJSON: fromJSON ?? self.fromJSON,
            obj2Default: obj2Default ?? self.obj2Default,
            obj2Defer: obj2Defer ?? self.obj2Defer,
            obj2Deinit: obj2Deinit ?? self.obj2Deinit,
            obj2DidSet: obj2DidSet ?? self.obj2DidSet,
            obj2Do: obj2Do ?? self.obj2Do,
            obj2Dynamic: obj2Dynamic ?? self.obj2Dynamic,
            obj2Else: obj2Else ?? self.obj2Else,
            obj2Enum: obj2Enum ?? self.obj2Enum,
            obj2Extension: obj2Extension ?? self.obj2Extension,
            obj2Fallthrough: obj2Fallthrough ?? self.obj2Fallthrough,
            obj2False: obj2False ?? self.obj2False,
            obj2Fileprivate: obj2Fileprivate ?? self.obj2Fileprivate,
            obj2Final: obj2Final ?? self.obj2Final,
            obj2For: obj2For ?? self.obj2For,
            obj2Func: obj2Func ?? self.obj2Func,
            purpleFalse: purpleFalse ?? self.purpleFalse
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - CultureInfo
@objcMembers class CultureInfo: NSObject, Codable {
    let cultureInfo: Int

    enum CodingKeys: String, CodingKey {
        case cultureInfo = "CultureInfo"
    }

    init(cultureInfo: Int) {
        self.cultureInfo = cultureInfo
    }
}

// MARK: CultureInfo convenience initializers and mutators

extension CultureInfo {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(CultureInfo.self, from: data)
        self.init(cultureInfo: me.cultureInfo)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        cultureInfo: Int? = nil
    ) -> CultureInfo {
        return CultureInfo(
            cultureInfo: cultureInfo ?? self.cultureInfo
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - DateClass
@objcMembers class DateClass: NSObject, Codable {
    let date: Int

    enum CodingKeys: String, CodingKey {
        case date = "date"
    }

    init(date: Int) {
        self.date = date
    }
}

// MARK: DateClass convenience initializers and mutators

extension DateClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(DateClass.self, from: data)
        self.init(date: me.date)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        date: Int? = nil
    ) -> DateClass {
        return DateClass(
            date: date ?? self.date
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - DateFormatterClass
@objcMembers class DateFormatterClass: NSObject, Codable {
    let dateFormatter: Int

    enum CodingKeys: String, CodingKey {
        case dateFormatter = "DateFormatter"
    }

    init(dateFormatter: Int) {
        self.dateFormatter = dateFormatter
    }
}

// MARK: DateFormatterClass convenience initializers and mutators

extension DateFormatterClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(DateFormatterClass.self, from: data)
        self.init(dateFormatter: me.dateFormatter)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        dateFormatter: Int? = nil
    ) -> DateFormatterClass {
        return DateFormatterClass(
            dateFormatter: dateFormatter ?? self.dateFormatter
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - DateOnly
@objcMembers class DateOnly: NSObject, Codable {
    let dateOnly: Int

    enum CodingKeys: String, CodingKey {
        case dateOnly = "DateOnly"
    }

    init(dateOnly: Int) {
        self.dateOnly = dateOnly
    }
}

// MARK: DateOnly convenience initializers and mutators

extension DateOnly {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(DateOnly.self, from: data)
        self.init(dateOnly: me.dateOnly)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        dateOnly: Int? = nil
    ) -> DateOnly {
        return DateOnly(
            dateOnly: dateOnly ?? self.dateOnly
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - DateOnlyConverter
@objcMembers class DateOnlyConverter: NSObject, Codable {
    let dateOnlyConverter: Int

    enum CodingKeys: String, CodingKey {
        case dateOnlyConverter = "DateOnlyConverter"
    }

    init(dateOnlyConverter: Int) {
        self.dateOnlyConverter = dateOnlyConverter
    }
}

// MARK: DateOnlyConverter convenience initializers and mutators

extension DateOnlyConverter {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(DateOnlyConverter.self, from: data)
        self.init(dateOnlyConverter: me.dateOnlyConverter)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        dateOnlyConverter: Int? = nil
    ) -> DateOnlyConverter {
        return DateOnlyConverter(
            dateOnlyConverter: dateOnlyConverter ?? self.dateOnlyConverter
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - DateParseHandling
@objcMembers class DateParseHandling: NSObject, Codable {
    let dateParseHandling: Int

    enum CodingKeys: String, CodingKey {
        case dateParseHandling = "date_parse_handling"
    }

    init(dateParseHandling: Int) {
        self.dateParseHandling = dateParseHandling
    }
}

// MARK: DateParseHandling convenience initializers and mutators

extension DateParseHandling {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(DateParseHandling.self, from: data)
        self.init(dateParseHandling: me.dateParseHandling)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        dateParseHandling: Int? = nil
    ) -> DateParseHandling {
        return DateParseHandling(
            dateParseHandling: dateParseHandling ?? self.dateParseHandling
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - DateTime
@objcMembers class DateTime: NSObject, Codable {
    let dateTime: Date

    enum CodingKeys: String, CodingKey {
        case dateTime = "DateTime"
    }

    init(dateTime: Date) {
        self.dateTime = dateTime
    }
}

// MARK: DateTime convenience initializers and mutators

extension DateTime {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(DateTime.self, from: data)
        self.init(dateTime: me.dateTime)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        dateTime: Date? = nil
    ) -> DateTime {
        return DateTime(
            dateTime: dateTime ?? self.dateTime
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - DateTimeStyles
@objcMembers class DateTimeStyles: NSObject, Codable {
    let dateTimeStyles: Int

    enum CodingKeys: String, CodingKey {
        case dateTimeStyles = "DateTimeStyles"
    }

    init(dateTimeStyles: Int) {
        self.dateTimeStyles = dateTimeStyles
    }
}

// MARK: DateTimeStyles convenience initializers and mutators

extension DateTimeStyles {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(DateTimeStyles.self, from: data)
        self.init(dateTimeStyles: me.dateTimeStyles)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        dateTimeStyles: Int? = nil
    ) -> DateTimeStyles {
        return DateTimeStyles(
            dateTimeStyles: dateTimeStyles ?? self.dateTimeStyles
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Debugger
@objcMembers class Debugger: NSObject, Codable {
    let debugger: Int

    enum CodingKeys: String, CodingKey {
        case debugger = "debugger"
    }

    init(debugger: Int) {
        self.debugger = debugger
    }
}

// MARK: Debugger convenience initializers and mutators

extension Debugger {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Debugger.self, from: data)
        self.init(debugger: me.debugger)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        debugger: Int? = nil
    ) -> Debugger {
        return Debugger(
            debugger: debugger ?? self.debugger
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Decimal
@objcMembers class Decimal: NSObject, Codable {
    let decimal: Int

    enum CodingKeys: String, CodingKey {
        case decimal = "decimal"
    }

    init(decimal: Int) {
        self.decimal = decimal
    }
}

// MARK: Decimal convenience initializers and mutators

extension Decimal {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Decimal.self, from: data)
        self.init(decimal: me.decimal)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        decimal: Int? = nil
    ) -> Decimal {
        return Decimal(
            decimal: decimal ?? self.decimal
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Declare
@objcMembers class Declare: NSObject, Codable {
    let declare: Int

    enum CodingKeys: String, CodingKey {
        case declare = "declare"
    }

    init(declare: Int) {
        self.declare = declare
    }
}

// MARK: Declare convenience initializers and mutators

extension Declare {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Declare.self, from: data)
        self.init(declare: me.declare)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        declare: Int? = nil
    ) -> Declare {
        return Declare(
            declare: declare ?? self.declare
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Decltype
@objcMembers class Decltype: NSObject, Codable {
    let decltype: Int

    enum CodingKeys: String, CodingKey {
        case decltype = "decltype"
    }

    init(decltype: Int) {
        self.decltype = decltype
    }
}

// MARK: Decltype convenience initializers and mutators

extension Decltype {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Decltype.self, from: data)
        self.init(decltype: me.decltype)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        decltype: Int? = nil
    ) -> Decltype {
        return Decltype(
            decltype: decltype ?? self.decltype
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - DecodeString
@objcMembers class DecodeString: NSObject, Codable {
    let decodeString: Int

    enum CodingKeys: String, CodingKey {
        case decodeString = "decode_string"
    }

    init(decodeString: Int) {
        self.decodeString = decodeString
    }
}

// MARK: DecodeString convenience initializers and mutators

extension DecodeString {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(DecodeString.self, from: data)
        self.init(decodeString: me.decodeString)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        decodeString: Int? = nil
    ) -> DecodeString {
        return DecodeString(
            decodeString: decodeString ?? self.decodeString
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - DecoderClass
@objcMembers class DecoderClass: NSObject, Codable {
    let decoder: Int

    enum CodingKeys: String, CodingKey {
        case decoder = "Decoder"
    }

    init(decoder: Int) {
        self.decoder = decoder
    }
}

// MARK: DecoderClass convenience initializers and mutators

extension DecoderClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(DecoderClass.self, from: data)
        self.init(decoder: me.decoder)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        decoder: Int? = nil
    ) -> DecoderClass {
        return DecoderClass(
            decoder: decoder ?? self.decoder
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - DecodingErrorClass
@objcMembers class DecodingErrorClass: NSObject, Codable {
    let decodingError: Int

    enum CodingKeys: String, CodingKey {
        case decodingError = "DecodingError"
    }

    init(decodingError: Int) {
        self.decodingError = decodingError
    }
}

// MARK: DecodingErrorClass convenience initializers and mutators

extension DecodingErrorClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(DecodingErrorClass.self, from: data)
        self.init(decodingError: me.decodingError)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        decodingError: Int? = nil
    ) -> DecodingErrorClass {
        return DecodingErrorClass(
            decodingError: decodingError ?? self.decodingError
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Def
@objcMembers class Def: NSObject, Codable {
    let def: Int

    enum CodingKeys: String, CodingKey {
        case def = "def"
    }

    init(def: Int) {
        self.def = def
    }
}

// MARK: Def convenience initializers and mutators

extension Def {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Def.self, from: data)
        self.init(def: me.def)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        def: Int? = nil
    ) -> Def {
        return Def(
            def: def ?? self.def
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Del
@objcMembers class Del: NSObject, Codable {
    let del: Int

    enum CodingKeys: String, CodingKey {
        case del = "del"
    }

    init(del: Int) {
        self.del = del
    }
}

// MARK: Del convenience initializers and mutators

extension Del {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Del.self, from: data)
        self.init(del: me.del)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        del: Int? = nil
    ) -> Del {
        return Del(
            del: del ?? self.del
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Delegate
@objcMembers class Delegate: NSObject, Codable {
    let delegate: Int

    enum CodingKeys: String, CodingKey {
        case delegate = "delegate"
    }

    init(delegate: Int) {
        self.delegate = delegate
    }
}

// MARK: Delegate convenience initializers and mutators

extension Delegate {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Delegate.self, from: data)
        self.init(delegate: me.delegate)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        delegate: Int? = nil
    ) -> Delegate {
        return Delegate(
            delegate: delegate ?? self.delegate
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Delete
@objcMembers class Delete: NSObject, Codable {
    let delete: Int

    enum CodingKeys: String, CodingKey {
        case delete = "delete"
    }

    init(delete: Int) {
        self.delete = delete
    }
}

// MARK: Delete convenience initializers and mutators

extension Delete {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Delete.self, from: data)
        self.init(delete: me.delete)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        delete: Int? = nil
    ) -> Delete {
        return Delete(
            delete: delete ?? self.delete
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - DeserializationFeature
@objcMembers class DeserializationFeature: NSObject, Codable {
    let deserializationFeature: Int

    enum CodingKeys: String, CodingKey {
        case deserializationFeature = "DeserializationFeature"
    }

    init(deserializationFeature: Int) {
        self.deserializationFeature = deserializationFeature
    }
}

// MARK: DeserializationFeature convenience initializers and mutators

extension DeserializationFeature {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(DeserializationFeature.self, from: data)
        self.init(deserializationFeature: me.deserializationFeature)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        deserializationFeature: Int? = nil
    ) -> DeserializationFeature {
        return DeserializationFeature(
            deserializationFeature: deserializationFeature ?? self.deserializationFeature
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Dict
@objcMembers class Dict: NSObject, Codable {
    let dict: Int

    enum CodingKeys: String, CodingKey {
        case dict = "dict"
    }

    init(dict: Int) {
        self.dict = dict
    }
}

// MARK: Dict convenience initializers and mutators

extension Dict {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Dict.self, from: data)
        self.init(dict: me.dict)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        dict: Int? = nil
    ) -> Dict {
        return Dict(
            dict: dict ?? self.dict
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Dictionary
@objcMembers class Dictionary: NSObject, Codable {
    let dictionary: Int

    enum CodingKeys: String, CodingKey {
        case dictionary = "dictionary"
    }

    init(dictionary: Int) {
        self.dictionary = dictionary
    }
}

// MARK: Dictionary convenience initializers and mutators

extension Dictionary {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Dictionary.self, from: data)
        self.init(dictionary: me.dictionary)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        dictionary: Int? = nil
    ) -> Dictionary {
        return Dictionary(
            dictionary: dictionary ?? self.dictionary
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - DoubleClass
@objcMembers class DoubleClass: NSObject, Codable {
    let double: Int

    enum CodingKeys: String, CodingKey {
        case double = "double"
    }

    init(double: Int) {
        self.double = double
    }
}

// MARK: DoubleClass convenience initializers and mutators

extension DoubleClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(DoubleClass.self, from: data)
        self.init(double: me.double)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        double: Int? = nil
    ) -> DoubleClass {
        return DoubleClass(
            double: double ?? self.double
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - DoubleNode
@objcMembers class DoubleNode: NSObject, Codable {
    let doubleNode: Int

    enum CodingKeys: String, CodingKey {
        case doubleNode = "DoubleNode"
    }

    init(doubleNode: Int) {
        self.doubleNode = doubleNode
    }
}

// MARK: DoubleNode convenience initializers and mutators

extension DoubleNode {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(DoubleNode.self, from: data)
        self.init(doubleNode: me.doubleNode)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        doubleNode: Int? = nil
    ) -> DoubleNode {
        return DoubleNode(
            doubleNode: doubleNode ?? self.doubleNode
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - DynamicCast
@objcMembers class DynamicCast: NSObject, Codable {
    let dynamicCast: Int

    enum CodingKeys: String, CodingKey {
        case dynamicCast = "dynamic_cast"
    }

    init(dynamicCast: Int) {
        self.dynamicCast = dynamicCast
    }
}

// MARK: DynamicCast convenience initializers and mutators

extension DynamicCast {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(DynamicCast.self, from: data)
        self.init(dynamicCast: me.dynamicCast)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        dynamicCast: Int? = nil
    ) -> DynamicCast {
        return DynamicCast(
            dynamicCast: dynamicCast ?? self.dynamicCast
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Elif
@objcMembers class Elif: NSObject, Codable {
    let elif: Int

    enum CodingKeys: String, CodingKey {
        case elif = "elif"
    }

    init(elif: Int) {
        self.elif = elif
    }
}

// MARK: Elif convenience initializers and mutators

extension Elif {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Elif.self, from: data)
        self.init(elif: me.elif)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        elif: Int? = nil
    ) -> Elif {
        return Elif(
            elif: elif ?? self.elif
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - EncodeQuickType
@objcMembers class EncodeQuickType: NSObject, Codable {
    let encodeQuickType: Int

    enum CodingKeys: String, CodingKey {
        case encodeQuickType = "encode_quick_type"
    }

    init(encodeQuickType: Int) {
        self.encodeQuickType = encodeQuickType
    }
}

// MARK: EncodeQuickType convenience initializers and mutators

extension EncodeQuickType {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(EncodeQuickType.self, from: data)
        self.init(encodeQuickType: me.encodeQuickType)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        encodeQuickType: Int? = nil
    ) -> EncodeQuickType {
        return EncodeQuickType(
            encodeQuickType: encodeQuickType ?? self.encodeQuickType
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - EncoderClass
@objcMembers class EncoderClass: NSObject, Codable {
    let encoder: Int

    enum CodingKeys: String, CodingKey {
        case encoder = "Encoder"
    }

    init(encoder: Int) {
        self.encoder = encoder
    }
}

// MARK: EncoderClass convenience initializers and mutators

extension EncoderClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(EncoderClass.self, from: data)
        self.init(encoder: me.encoder)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        encoder: Int? = nil
    ) -> EncoderClass {
        return EncoderClass(
            encoder: encoder ?? self.encoder
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - EnumValues
@objcMembers class EnumValues: NSObject, Codable {
    let enumValues: [EnumValue]

    enum CodingKeys: String, CodingKey {
        case enumValues = "EnumValues"
    }

    init(enumValues: [EnumValue]) {
        self.enumValues = enumValues
    }
}

// MARK: EnumValues convenience initializers and mutators

extension EnumValues {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(EnumValues.self, from: data)
        self.init(enumValues: me.enumValues)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        enumValues: [EnumValue]? = nil
    ) -> EnumValues {
        return EnumValues(
            enumValues: enumValues ?? self.enumValues
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum EnumValue: String, Codable {
    case ready = "ready"
    case done = "done"
}

// MARK: - EqualityContract
@objcMembers class EqualityContract: NSObject, Codable {
    let equalityContract: Int

    enum CodingKeys: String, CodingKey {
        case equalityContract = "equalityContract"
    }

    init(equalityContract: Int) {
        self.equalityContract = equalityContract
    }
}

// MARK: EqualityContract convenience initializers and mutators

extension EqualityContract {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(EqualityContract.self, from: data)
        self.init(equalityContract: me.equalityContract)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        equalityContract: Int? = nil
    ) -> EqualityContract {
        return EqualityContract(
            equalityContract: equalityContract ?? self.equalityContract
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Equatable
@objcMembers class Equatable: NSObject, Codable {
    let equatable: Int

    enum CodingKeys: String, CodingKey {
        case equatable = "Equatable"
    }

    init(equatable: Int) {
        self.equatable = equatable
    }
}

// MARK: Equatable convenience initializers and mutators

extension Equatable {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Equatable.self, from: data)
        self.init(equatable: me.equatable)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        equatable: Int? = nil
    ) -> Equatable {
        return Equatable(
            equatable: equatable ?? self.equatable
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Event
@objcMembers class Event: NSObject, Codable {
    let event: Int

    enum CodingKeys: String, CodingKey {
        case event = "event"
    }

    init(event: Int) {
        self.event = event
    }
}

// MARK: Event convenience initializers and mutators

extension Event {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Event.self, from: data)
        self.init(event: me.event)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        event: Int? = nil
    ) -> Event {
        return Event(
            event: event ?? self.event
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Except
@objcMembers class Except: NSObject, Codable {
    let except: Int

    enum CodingKeys: String, CodingKey {
        case except = "except"
    }

    init(except: Int) {
        self.except = except
    }
}

// MARK: Except convenience initializers and mutators

extension Except {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Except.self, from: data)
        self.init(except: me.except)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        except: Int? = nil
    ) -> Except {
        return Except(
            except: except ?? self.except
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Exception
@objcMembers class Exception: NSObject, Codable {
    let exception: Int

    enum CodingKeys: String, CodingKey {
        case exception = "exception"
    }

    init(exception: Int) {
        self.exception = exception
    }
}

// MARK: Exception convenience initializers and mutators

extension Exception {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Exception.self, from: data)
        self.init(exception: me.exception)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        exception: Int? = nil
    ) -> Exception {
        return Exception(
            exception: exception ?? self.exception
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Explicit
@objcMembers class Explicit: NSObject, Codable {
    let explicit: Int

    enum CodingKeys: String, CodingKey {
        case explicit = "explicit"
    }

    init(explicit: Int) {
        self.explicit = explicit
    }
}

// MARK: Explicit convenience initializers and mutators

extension Explicit {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Explicit.self, from: data)
        self.init(explicit: me.explicit)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        explicit: Int? = nil
    ) -> Explicit {
        return Explicit(
            explicit: explicit ?? self.explicit
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Export
@objcMembers class Export: NSObject, Codable {
    let export: Int

    enum CodingKeys: String, CodingKey {
        case export = "export"
    }

    init(export: Int) {
        self.export = export
    }
}

// MARK: Export convenience initializers and mutators

extension Export {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Export.self, from: data)
        self.init(export: me.export)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        export: Int? = nil
    ) -> Export {
        return Export(
            export: export ?? self.export
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Exposing
@objcMembers class Exposing: NSObject, Codable {
    let exposing: Int

    enum CodingKeys: String, CodingKey {
        case exposing = "exposing"
    }

    init(exposing: Int) {
        self.exposing = exposing
    }
}

// MARK: Exposing convenience initializers and mutators

extension Exposing {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Exposing.self, from: data)
        self.init(exposing: me.exposing)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        exposing: Int? = nil
    ) -> Exposing {
        return Exposing(
            exposing: exposing ?? self.exposing
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Extends
@objcMembers class Extends: NSObject, Codable {
    let extends: Int

    enum CodingKeys: String, CodingKey {
        case extends = "extends"
    }

    init(extends: Int) {
        self.extends = extends
    }
}

// MARK: Extends convenience initializers and mutators

extension Extends {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Extends.self, from: data)
        self.init(extends: me.extends)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        extends: Int? = nil
    ) -> Extends {
        return Extends(
            extends: extends ?? self.extends
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Extern
@objcMembers class Extern: NSObject, Codable {
    let extern: Int

    enum CodingKeys: String, CodingKey {
        case extern = "extern"
    }

    init(extern: Int) {
        self.extern = extern
    }
}

// MARK: Extern convenience initializers and mutators

extension Extern {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Extern.self, from: data)
        self.init(extern: me.extern)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        extern: Int? = nil
    ) -> Extern {
        return Extern(
            extern: extern ?? self.extern
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Finally
@objcMembers class Finally: NSObject, Codable {
    let finally: Int

    enum CodingKeys: String, CodingKey {
        case finally = "finally"
    }

    init(finally: Int) {
        self.finally = finally
    }
}

// MARK: Finally convenience initializers and mutators

extension Finally {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Finally.self, from: data)
        self.init(finally: me.finally)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        finally: Int? = nil
    ) -> Finally {
        return Finally(
            finally: finally ?? self.finally
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Fixed
@objcMembers class Fixed: NSObject, Codable {
    let fixed: Int

    enum CodingKeys: String, CodingKey {
        case fixed = "fixed"
    }

    init(fixed: Int) {
        self.fixed = fixed
    }
}

// MARK: Fixed convenience initializers and mutators

extension Fixed {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Fixed.self, from: data)
        self.init(fixed: me.fixed)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        fixed: Int? = nil
    ) -> Fixed {
        return Fixed(
            fixed: fixed ?? self.fixed
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Float
@objcMembers class Float: NSObject, Codable {
    let float: Int

    enum CodingKeys: String, CodingKey {
        case float = "float"
    }

    init(float: Int) {
        self.float = float
    }
}

// MARK: Float convenience initializers and mutators

extension Float {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Float.self, from: data)
        self.init(float: me.float)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        float: Int? = nil
    ) -> Float {
        return Float(
            float: float ?? self.float
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Foreach
@objcMembers class Foreach: NSObject, Codable {
    let foreach: Int

    enum CodingKeys: String, CodingKey {
        case foreach = "foreach"
    }

    init(foreach: Int) {
        self.foreach = foreach
    }
}

// MARK: Foreach convenience initializers and mutators

extension Foreach {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Foreach.self, from: data)
        self.init(foreach: me.foreach)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        foreach: Int? = nil
    ) -> Foreach {
        return Foreach(
            foreach: foreach ?? self.foreach
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - FormatException
@objcMembers class FormatException: NSObject, Codable {
    let formatException: Int

    enum CodingKeys: String, CodingKey {
        case formatException = "FormatException"
    }

    init(formatException: Int) {
        self.formatException = formatException
    }
}

// MARK: FormatException convenience initializers and mutators

extension FormatException {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(FormatException.self, from: data)
        self.init(formatException: me.formatException)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        formatException: Int? = nil
    ) -> FormatException {
        return FormatException(
            formatException: formatException ?? self.formatException
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Friend
@objcMembers class Friend: NSObject, Codable {
    let friend: Int

    enum CodingKeys: String, CodingKey {
        case friend = "friend"
    }

    init(friend: Int) {
        self.friend = friend
    }
}

// MARK: Friend convenience initializers and mutators

extension Friend {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Friend.self, from: data)
        self.init(friend: me.friend)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        friend: Int? = nil
    ) -> Friend {
        return Friend(
            friend: friend ?? self.friend
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - From
@objcMembers class From: NSObject, Codable {
    let from: Int

    enum CodingKeys: String, CodingKey {
        case from = "from"
    }

    init(from: Int) {
        self.from = from
    }
}

// MARK: From convenience initializers and mutators

extension From {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(From.self, from: data)
        self.init(from: me.from)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        from: Int? = nil
    ) -> From {
        return From(
            from: from ?? self.from
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - FromDict
@objcMembers class FromDict: NSObject, Codable {
    let fromDict: Int

    enum CodingKeys: String, CodingKey {
        case fromDict = "from_dict"
    }

    init(fromDict: Int) {
        self.fromDict = fromDict
    }
}

// MARK: FromDict convenience initializers and mutators

extension FromDict {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(FromDict.self, from: data)
        self.init(fromDict: me.fromDict)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        fromDict: Int? = nil
    ) -> FromDict {
        return FromDict(
            fromDict: fromDict ?? self.fromDict
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - FromJSON
@objcMembers class FromJSON: NSObject, Codable {
    let fromJSON: Int

    enum CodingKeys: String, CodingKey {
        case fromJSON = "from_json"
    }

    init(fromJSON: Int) {
        self.fromJSON = fromJSON
    }
}

// MARK: FromJSON convenience initializers and mutators

extension FromJSON {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(FromJSON.self, from: data)
        self.init(fromJSON: me.fromJSON)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        fromJSON: Int? = nil
    ) -> FromJSON {
        return FromJSON(
            fromJSON: fromJSON ?? self.fromJSON
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Default
@objcMembers class Default: NSObject, Codable {
    let defaultDefault: Int

    enum CodingKeys: String, CodingKey {
        case defaultDefault = "default"
    }

    init(defaultDefault: Int) {
        self.defaultDefault = defaultDefault
    }
}

// MARK: Default convenience initializers and mutators

extension Default {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Default.self, from: data)
        self.init(defaultDefault: me.defaultDefault)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        defaultDefault: Int? = nil
    ) -> Default {
        return Default(
            defaultDefault: defaultDefault ?? self.defaultDefault
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Defer
@objcMembers class Defer: NSObject, Codable {
    let deferDefer: Int

    enum CodingKeys: String, CodingKey {
        case deferDefer = "defer"
    }

    init(deferDefer: Int) {
        self.deferDefer = deferDefer
    }
}

// MARK: Defer convenience initializers and mutators

extension Defer {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Defer.self, from: data)
        self.init(deferDefer: me.deferDefer)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        deferDefer: Int? = nil
    ) -> Defer {
        return Defer(
            deferDefer: deferDefer ?? self.deferDefer
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Deinit
@objcMembers class Deinit: NSObject, Codable {
    let deinitDeinit: Int

    enum CodingKeys: String, CodingKey {
        case deinitDeinit = "deinit"
    }

    init(deinitDeinit: Int) {
        self.deinitDeinit = deinitDeinit
    }
}

// MARK: Deinit convenience initializers and mutators

extension Deinit {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Deinit.self, from: data)
        self.init(deinitDeinit: me.deinitDeinit)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        deinitDeinit: Int? = nil
    ) -> Deinit {
        return Deinit(
            deinitDeinit: deinitDeinit ?? self.deinitDeinit
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - DidSet
@objcMembers class DidSet: NSObject, Codable {
    let didSetDidSet: Int

    enum CodingKeys: String, CodingKey {
        case didSetDidSet = "didSet"
    }

    init(didSetDidSet: Int) {
        self.didSetDidSet = didSetDidSet
    }
}

// MARK: DidSet convenience initializers and mutators

extension DidSet {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(DidSet.self, from: data)
        self.init(didSetDidSet: me.didSetDidSet)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        didSetDidSet: Int? = nil
    ) -> DidSet {
        return DidSet(
            didSetDidSet: didSetDidSet ?? self.didSetDidSet
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Do
@objcMembers class Do: NSObject, Codable {
    let doDo: Int

    enum CodingKeys: String, CodingKey {
        case doDo = "do"
    }

    init(doDo: Int) {
        self.doDo = doDo
    }
}

// MARK: Do convenience initializers and mutators

extension Do {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Do.self, from: data)
        self.init(doDo: me.doDo)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        doDo: Int? = nil
    ) -> Do {
        return Do(
            doDo: doDo ?? self.doDo
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Dynamic
@objcMembers class Dynamic: NSObject, Codable {
    let dynamicDynamic: Int

    enum CodingKeys: String, CodingKey {
        case dynamicDynamic = "dynamic"
    }

    init(dynamicDynamic: Int) {
        self.dynamicDynamic = dynamicDynamic
    }
}

// MARK: Dynamic convenience initializers and mutators

extension Dynamic {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Dynamic.self, from: data)
        self.init(dynamicDynamic: me.dynamicDynamic)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        dynamicDynamic: Int? = nil
    ) -> Dynamic {
        return Dynamic(
            dynamicDynamic: dynamicDynamic ?? self.dynamicDynamic
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Else
@objcMembers class Else: NSObject, Codable {
    let elseElse: Int

    enum CodingKeys: String, CodingKey {
        case elseElse = "else"
    }

    init(elseElse: Int) {
        self.elseElse = elseElse
    }
}

// MARK: Else convenience initializers and mutators

extension Else {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Else.self, from: data)
        self.init(elseElse: me.elseElse)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        elseElse: Int? = nil
    ) -> Else {
        return Else(
            elseElse: elseElse ?? self.elseElse
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Enum
@objcMembers class Enum: NSObject, Codable {
    let enumEnum: Int

    enum CodingKeys: String, CodingKey {
        case enumEnum = "enum"
    }

    init(enumEnum: Int) {
        self.enumEnum = enumEnum
    }
}

// MARK: Enum convenience initializers and mutators

extension Enum {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Enum.self, from: data)
        self.init(enumEnum: me.enumEnum)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        enumEnum: Int? = nil
    ) -> Enum {
        return Enum(
            enumEnum: enumEnum ?? self.enumEnum
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Extension
@objcMembers class Extension: NSObject, Codable {
    let extensionExtension: Int

    enum CodingKeys: String, CodingKey {
        case extensionExtension = "extension"
    }

    init(extensionExtension: Int) {
        self.extensionExtension = extensionExtension
    }
}

// MARK: Extension convenience initializers and mutators

extension Extension {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Extension.self, from: data)
        self.init(extensionExtension: me.extensionExtension)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        extensionExtension: Int? = nil
    ) -> Extension {
        return Extension(
            extensionExtension: extensionExtension ?? self.extensionExtension
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Fallthrough
@objcMembers class Fallthrough: NSObject, Codable {
    let fallthroughFallthrough: Int

    enum CodingKeys: String, CodingKey {
        case fallthroughFallthrough = "fallthrough"
    }

    init(fallthroughFallthrough: Int) {
        self.fallthroughFallthrough = fallthroughFallthrough
    }
}

// MARK: Fallthrough convenience initializers and mutators

extension Fallthrough {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Fallthrough.self, from: data)
        self.init(fallthroughFallthrough: me.fallthroughFallthrough)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        fallthroughFallthrough: Int? = nil
    ) -> Fallthrough {
        return Fallthrough(
            fallthroughFallthrough: fallthroughFallthrough ?? self.fallthroughFallthrough
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - False
@objcMembers class False: NSObject, Codable {
    let falseFalse: Int

    enum CodingKeys: String, CodingKey {
        case falseFalse = "False"
    }

    init(falseFalse: Int) {
        self.falseFalse = falseFalse
    }
}

// MARK: False convenience initializers and mutators

extension False {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(False.self, from: data)
        self.init(falseFalse: me.falseFalse)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        falseFalse: Int? = nil
    ) -> False {
        return False(
            falseFalse: falseFalse ?? self.falseFalse
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Fileprivate
@objcMembers class Fileprivate: NSObject, Codable {
    let fileprivateFileprivate: Int

    enum CodingKeys: String, CodingKey {
        case fileprivateFileprivate = "fileprivate"
    }

    init(fileprivateFileprivate: Int) {
        self.fileprivateFileprivate = fileprivateFileprivate
    }
}

// MARK: Fileprivate convenience initializers and mutators

extension Fileprivate {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Fileprivate.self, from: data)
        self.init(fileprivateFileprivate: me.fileprivateFileprivate)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        fileprivateFileprivate: Int? = nil
    ) -> Fileprivate {
        return Fileprivate(
            fileprivateFileprivate: fileprivateFileprivate ?? self.fileprivateFileprivate
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Final
@objcMembers class Final: NSObject, Codable {
    let finalFinal: Int

    enum CodingKeys: String, CodingKey {
        case finalFinal = "final"
    }

    init(finalFinal: Int) {
        self.finalFinal = finalFinal
    }
}

// MARK: Final convenience initializers and mutators

extension Final {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Final.self, from: data)
        self.init(finalFinal: me.finalFinal)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        finalFinal: Int? = nil
    ) -> Final {
        return Final(
            finalFinal: finalFinal ?? self.finalFinal
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - For
@objcMembers class For: NSObject, Codable {
    let forFor: Int

    enum CodingKeys: String, CodingKey {
        case forFor = "for"
    }

    init(forFor: Int) {
        self.forFor = forFor
    }
}

// MARK: For convenience initializers and mutators

extension For {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(For.self, from: data)
        self.init(forFor: me.forFor)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        forFor: Int? = nil
    ) -> For {
        return For(
            forFor: forFor ?? self.forFor
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Func
@objcMembers class Func: NSObject, Codable {
    let funcFunc: Int

    enum CodingKeys: String, CodingKey {
        case funcFunc = "func"
    }

    init(funcFunc: Int) {
        self.funcFunc = funcFunc
    }
}

// MARK: Func convenience initializers and mutators

extension Func {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Func.self, from: data)
        self.init(funcFunc: me.funcFunc)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        funcFunc: Int? = nil
    ) -> Func {
        return Func(
            funcFunc: funcFunc ?? self.funcFunc
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - FalseClass
@objcMembers class FalseClass: NSObject, Codable {
    let falseFalse: Int

    enum CodingKeys: String, CodingKey {
        case falseFalse = "false"
    }

    init(falseFalse: Int) {
        self.falseFalse = falseFalse
    }
}

// MARK: FalseClass convenience initializers and mutators

extension FalseClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(FalseClass.self, from: data)
        self.init(falseFalse: me.falseFalse)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        falseFalse: Int? = nil
    ) -> FalseClass {
        return FalseClass(
            falseFalse: falseFalse ?? self.falseFalse
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Obj3
@objcMembers class Obj3: NSObject, Codable {
    let dummy: Int
    let function: Function
    let global: Global
    let go: Go
    let goto: Goto
    let hasOwnProperty: HasOwnProperty
    let hashCode: HashCode
    let hashable: HashableClass
    let hasher: HasherClass
    let id: ID
    let imp: Imp
    let implements: Implements
    let implicit: Implicit
    let inline: Inline
    let instanceof: Instanceof
    let int: IntClass
    let intNode: IntNode
    let interface: Interface
    let isoDateTimeOffsetConverter: ISODateTimeOffsetConverter
    let iterable: Iterable
    let jdec: Jdec
    let jenc: Jenc
    let jpipe: Jpipe
    let jsonAny: JSONAnyClass
    let jsonCodingKey: JSONCodingKeyClass
    let jsonConverter: JSONConverter
    let jsonDecoder: JSONDecoderClass
    let jsonEncoder: JSONEncoderClass
    let jsonException: JSONException
    let jsonGenerator: JSONGenerator
    let jsonNode: JSONNode
    let jsonNull: JSONNullClass
    let jsonParser: JSONParser
    let jsonReader: JSONReader
    let jsonSerializer: JSONSerializer
    let jsonToken: JSONToken
    let jsonTokenType: JSONTokenType
    let jsonWriter: JSONWriter
    let lambda: Lambda
    let list: List
    let localDate: LocalDate
    let locale: LocaleClass
    let lock: Lock
    let long: Long
    let longNode: LongNode
    let map: Map
    let mapEntry: MapEntry
    let marshalJSON: MarshalJSON
    let metadataPropertyHandling: MetadataPropertyHandling
    let module: Module
    let obj3Get: Get
    let obj3Guard: Guard
    let obj3If: If
    let obj3Import: Import
    let obj3In: In
    let obj3Indirect: Indirect
    let obj3Infix: Infix
    let obj3Init: Init
    let obj3Inout: Inout
    let obj3Internal: Internal
    let obj3Is: Is
    let obj3JSON: JSON
    let obj3Lazy: Lazy
    let obj3Left: Left
    let obj3Let: Let

    enum CodingKeys: String, CodingKey {
        case dummy = "dummy"
        case function = "function"
        case global = "global"
        case go = "go"
        case goto = "goto"
        case hasOwnProperty = "hasOwnProperty"
        case hashCode = "hashCode"
        case hashable = "Hashable"
        case hasher = "Hasher"
        case id = "id"
        case imp = "IMP"
        case implements = "implements"
        case implicit = "implicit"
        case inline = "inline"
        case instanceof = "instanceof"
        case int = "int"
        case intNode = "IntNode"
        case interface = "interface"
        case isoDateTimeOffsetConverter = "IsoDateTimeOffsetConverter"
        case iterable = "iterable"
        case jdec = "jdec"
        case jenc = "jenc"
        case jpipe = "jpipe"
        case jsonAny = "JSONAny"
        case jsonCodingKey = "JSONCodingKey"
        case jsonConverter = "json_converter"
        case jsonDecoder = "JSONDecoder"
        case jsonEncoder = "JSONEncoder"
        case jsonException = "JsonException"
        case jsonGenerator = "JsonGenerator"
        case jsonNode = "JsonNode"
        case jsonNull = "JSONNull"
        case jsonParser = "JsonParser"
        case jsonReader = "JsonReader"
        case jsonSerializer = "json_serializer"
        case jsonToken = "json_token"
        case jsonTokenType = "JsonTokenType"
        case jsonWriter = "json_writer"
        case lambda = "lambda"
        case list = "list"
        case localDate = "LocalDate"
        case locale = "Locale"
        case lock = "lock"
        case long = "long"
        case longNode = "LongNode"
        case map = "map"
        case mapEntry = "MapEntry"
        case marshalJSON = "MarshalJSON"
        case metadataPropertyHandling = "metadata_property_handling"
        case module = "module"
        case obj3Get = "get"
        case obj3Guard = "guard"
        case obj3If = "if"
        case obj3Import = "import"
        case obj3In = "in"
        case obj3Indirect = "indirect"
        case obj3Infix = "infix"
        case obj3Init = "init"
        case obj3Inout = "inout"
        case obj3Internal = "internal"
        case obj3Is = "is"
        case obj3JSON = "json"
        case obj3Lazy = "lazy"
        case obj3Left = "left"
        case obj3Let = "let"
    }

    init(dummy: Int, function: Function, global: Global, go: Go, goto: Goto, hasOwnProperty: HasOwnProperty, hashCode: HashCode, hashable: HashableClass, hasher: HasherClass, id: ID, imp: Imp, implements: Implements, implicit: Implicit, inline: Inline, instanceof: Instanceof, int: IntClass, intNode: IntNode, interface: Interface, isoDateTimeOffsetConverter: ISODateTimeOffsetConverter, iterable: Iterable, jdec: Jdec, jenc: Jenc, jpipe: Jpipe, jsonAny: JSONAnyClass, jsonCodingKey: JSONCodingKeyClass, jsonConverter: JSONConverter, jsonDecoder: JSONDecoderClass, jsonEncoder: JSONEncoderClass, jsonException: JSONException, jsonGenerator: JSONGenerator, jsonNode: JSONNode, jsonNull: JSONNullClass, jsonParser: JSONParser, jsonReader: JSONReader, jsonSerializer: JSONSerializer, jsonToken: JSONToken, jsonTokenType: JSONTokenType, jsonWriter: JSONWriter, lambda: Lambda, list: List, localDate: LocalDate, locale: LocaleClass, lock: Lock, long: Long, longNode: LongNode, map: Map, mapEntry: MapEntry, marshalJSON: MarshalJSON, metadataPropertyHandling: MetadataPropertyHandling, module: Module, obj3Get: Get, obj3Guard: Guard, obj3If: If, obj3Import: Import, obj3In: In, obj3Indirect: Indirect, obj3Infix: Infix, obj3Init: Init, obj3Inout: Inout, obj3Internal: Internal, obj3Is: Is, obj3JSON: JSON, obj3Lazy: Lazy, obj3Left: Left, obj3Let: Let) {
        self.dummy = dummy
        self.function = function
        self.global = global
        self.go = go
        self.goto = goto
        self.hasOwnProperty = hasOwnProperty
        self.hashCode = hashCode
        self.hashable = hashable
        self.hasher = hasher
        self.id = id
        self.imp = imp
        self.implements = implements
        self.implicit = implicit
        self.inline = inline
        self.instanceof = instanceof
        self.int = int
        self.intNode = intNode
        self.interface = interface
        self.isoDateTimeOffsetConverter = isoDateTimeOffsetConverter
        self.iterable = iterable
        self.jdec = jdec
        self.jenc = jenc
        self.jpipe = jpipe
        self.jsonAny = jsonAny
        self.jsonCodingKey = jsonCodingKey
        self.jsonConverter = jsonConverter
        self.jsonDecoder = jsonDecoder
        self.jsonEncoder = jsonEncoder
        self.jsonException = jsonException
        self.jsonGenerator = jsonGenerator
        self.jsonNode = jsonNode
        self.jsonNull = jsonNull
        self.jsonParser = jsonParser
        self.jsonReader = jsonReader
        self.jsonSerializer = jsonSerializer
        self.jsonToken = jsonToken
        self.jsonTokenType = jsonTokenType
        self.jsonWriter = jsonWriter
        self.lambda = lambda
        self.list = list
        self.localDate = localDate
        self.locale = locale
        self.lock = lock
        self.long = long
        self.longNode = longNode
        self.map = map
        self.mapEntry = mapEntry
        self.marshalJSON = marshalJSON
        self.metadataPropertyHandling = metadataPropertyHandling
        self.module = module
        self.obj3Get = obj3Get
        self.obj3Guard = obj3Guard
        self.obj3If = obj3If
        self.obj3Import = obj3Import
        self.obj3In = obj3In
        self.obj3Indirect = obj3Indirect
        self.obj3Infix = obj3Infix
        self.obj3Init = obj3Init
        self.obj3Inout = obj3Inout
        self.obj3Internal = obj3Internal
        self.obj3Is = obj3Is
        self.obj3JSON = obj3JSON
        self.obj3Lazy = obj3Lazy
        self.obj3Left = obj3Left
        self.obj3Let = obj3Let
    }
}

// MARK: Obj3 convenience initializers and mutators

extension Obj3 {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Obj3.self, from: data)
        self.init(dummy: me.dummy, function: me.function, global: me.global, go: me.go, goto: me.goto, hasOwnProperty: me.hasOwnProperty, hashCode: me.hashCode, hashable: me.hashable, hasher: me.hasher, id: me.id, imp: me.imp, implements: me.implements, implicit: me.implicit, inline: me.inline, instanceof: me.instanceof, int: me.int, intNode: me.intNode, interface: me.interface, isoDateTimeOffsetConverter: me.isoDateTimeOffsetConverter, iterable: me.iterable, jdec: me.jdec, jenc: me.jenc, jpipe: me.jpipe, jsonAny: me.jsonAny, jsonCodingKey: me.jsonCodingKey, jsonConverter: me.jsonConverter, jsonDecoder: me.jsonDecoder, jsonEncoder: me.jsonEncoder, jsonException: me.jsonException, jsonGenerator: me.jsonGenerator, jsonNode: me.jsonNode, jsonNull: me.jsonNull, jsonParser: me.jsonParser, jsonReader: me.jsonReader, jsonSerializer: me.jsonSerializer, jsonToken: me.jsonToken, jsonTokenType: me.jsonTokenType, jsonWriter: me.jsonWriter, lambda: me.lambda, list: me.list, localDate: me.localDate, locale: me.locale, lock: me.lock, long: me.long, longNode: me.longNode, map: me.map, mapEntry: me.mapEntry, marshalJSON: me.marshalJSON, metadataPropertyHandling: me.metadataPropertyHandling, module: me.module, obj3Get: me.obj3Get, obj3Guard: me.obj3Guard, obj3If: me.obj3If, obj3Import: me.obj3Import, obj3In: me.obj3In, obj3Indirect: me.obj3Indirect, obj3Infix: me.obj3Infix, obj3Init: me.obj3Init, obj3Inout: me.obj3Inout, obj3Internal: me.obj3Internal, obj3Is: me.obj3Is, obj3JSON: me.obj3JSON, obj3Lazy: me.obj3Lazy, obj3Left: me.obj3Left, obj3Let: me.obj3Let)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        dummy: Int? = nil,
        function: Function? = nil,
        global: Global? = nil,
        go: Go? = nil,
        goto: Goto? = nil,
        hasOwnProperty: HasOwnProperty? = nil,
        hashCode: HashCode? = nil,
        hashable: HashableClass? = nil,
        hasher: HasherClass? = nil,
        id: ID? = nil,
        imp: Imp? = nil,
        implements: Implements? = nil,
        implicit: Implicit? = nil,
        inline: Inline? = nil,
        instanceof: Instanceof? = nil,
        int: IntClass? = nil,
        intNode: IntNode? = nil,
        interface: Interface? = nil,
        isoDateTimeOffsetConverter: ISODateTimeOffsetConverter? = nil,
        iterable: Iterable? = nil,
        jdec: Jdec? = nil,
        jenc: Jenc? = nil,
        jpipe: Jpipe? = nil,
        jsonAny: JSONAnyClass? = nil,
        jsonCodingKey: JSONCodingKeyClass? = nil,
        jsonConverter: JSONConverter? = nil,
        jsonDecoder: JSONDecoderClass? = nil,
        jsonEncoder: JSONEncoderClass? = nil,
        jsonException: JSONException? = nil,
        jsonGenerator: JSONGenerator? = nil,
        jsonNode: JSONNode? = nil,
        jsonNull: JSONNullClass? = nil,
        jsonParser: JSONParser? = nil,
        jsonReader: JSONReader? = nil,
        jsonSerializer: JSONSerializer? = nil,
        jsonToken: JSONToken? = nil,
        jsonTokenType: JSONTokenType? = nil,
        jsonWriter: JSONWriter? = nil,
        lambda: Lambda? = nil,
        list: List? = nil,
        localDate: LocalDate? = nil,
        locale: LocaleClass? = nil,
        lock: Lock? = nil,
        long: Long? = nil,
        longNode: LongNode? = nil,
        map: Map? = nil,
        mapEntry: MapEntry? = nil,
        marshalJSON: MarshalJSON? = nil,
        metadataPropertyHandling: MetadataPropertyHandling? = nil,
        module: Module? = nil,
        obj3Get: Get? = nil,
        obj3Guard: Guard? = nil,
        obj3If: If? = nil,
        obj3Import: Import? = nil,
        obj3In: In? = nil,
        obj3Indirect: Indirect? = nil,
        obj3Infix: Infix? = nil,
        obj3Init: Init? = nil,
        obj3Inout: Inout? = nil,
        obj3Internal: Internal? = nil,
        obj3Is: Is? = nil,
        obj3JSON: JSON? = nil,
        obj3Lazy: Lazy? = nil,
        obj3Left: Left? = nil,
        obj3Let: Let? = nil
    ) -> Obj3 {
        return Obj3(
            dummy: dummy ?? self.dummy,
            function: function ?? self.function,
            global: global ?? self.global,
            go: go ?? self.go,
            goto: goto ?? self.goto,
            hasOwnProperty: hasOwnProperty ?? self.hasOwnProperty,
            hashCode: hashCode ?? self.hashCode,
            hashable: hashable ?? self.hashable,
            hasher: hasher ?? self.hasher,
            id: id ?? self.id,
            imp: imp ?? self.imp,
            implements: implements ?? self.implements,
            implicit: implicit ?? self.implicit,
            inline: inline ?? self.inline,
            instanceof: instanceof ?? self.instanceof,
            int: int ?? self.int,
            intNode: intNode ?? self.intNode,
            interface: interface ?? self.interface,
            isoDateTimeOffsetConverter: isoDateTimeOffsetConverter ?? self.isoDateTimeOffsetConverter,
            iterable: iterable ?? self.iterable,
            jdec: jdec ?? self.jdec,
            jenc: jenc ?? self.jenc,
            jpipe: jpipe ?? self.jpipe,
            jsonAny: jsonAny ?? self.jsonAny,
            jsonCodingKey: jsonCodingKey ?? self.jsonCodingKey,
            jsonConverter: jsonConverter ?? self.jsonConverter,
            jsonDecoder: jsonDecoder ?? self.jsonDecoder,
            jsonEncoder: jsonEncoder ?? self.jsonEncoder,
            jsonException: jsonException ?? self.jsonException,
            jsonGenerator: jsonGenerator ?? self.jsonGenerator,
            jsonNode: jsonNode ?? self.jsonNode,
            jsonNull: jsonNull ?? self.jsonNull,
            jsonParser: jsonParser ?? self.jsonParser,
            jsonReader: jsonReader ?? self.jsonReader,
            jsonSerializer: jsonSerializer ?? self.jsonSerializer,
            jsonToken: jsonToken ?? self.jsonToken,
            jsonTokenType: jsonTokenType ?? self.jsonTokenType,
            jsonWriter: jsonWriter ?? self.jsonWriter,
            lambda: lambda ?? self.lambda,
            list: list ?? self.list,
            localDate: localDate ?? self.localDate,
            locale: locale ?? self.locale,
            lock: lock ?? self.lock,
            long: long ?? self.long,
            longNode: longNode ?? self.longNode,
            map: map ?? self.map,
            mapEntry: mapEntry ?? self.mapEntry,
            marshalJSON: marshalJSON ?? self.marshalJSON,
            metadataPropertyHandling: metadataPropertyHandling ?? self.metadataPropertyHandling,
            module: module ?? self.module,
            obj3Get: obj3Get ?? self.obj3Get,
            obj3Guard: obj3Guard ?? self.obj3Guard,
            obj3If: obj3If ?? self.obj3If,
            obj3Import: obj3Import ?? self.obj3Import,
            obj3In: obj3In ?? self.obj3In,
            obj3Indirect: obj3Indirect ?? self.obj3Indirect,
            obj3Infix: obj3Infix ?? self.obj3Infix,
            obj3Init: obj3Init ?? self.obj3Init,
            obj3Inout: obj3Inout ?? self.obj3Inout,
            obj3Internal: obj3Internal ?? self.obj3Internal,
            obj3Is: obj3Is ?? self.obj3Is,
            obj3JSON: obj3JSON ?? self.obj3JSON,
            obj3Lazy: obj3Lazy ?? self.obj3Lazy,
            obj3Left: obj3Left ?? self.obj3Left,
            obj3Let: obj3Let ?? self.obj3Let
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Function
@objcMembers class Function: NSObject, Codable {
    let function: Int

    enum CodingKeys: String, CodingKey {
        case function = "function"
    }

    init(function: Int) {
        self.function = function
    }
}

// MARK: Function convenience initializers and mutators

extension Function {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Function.self, from: data)
        self.init(function: me.function)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        function: Int? = nil
    ) -> Function {
        return Function(
            function: function ?? self.function
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Global
@objcMembers class Global: NSObject, Codable {
    let global: Int

    enum CodingKeys: String, CodingKey {
        case global = "global"
    }

    init(global: Int) {
        self.global = global
    }
}

// MARK: Global convenience initializers and mutators

extension Global {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Global.self, from: data)
        self.init(global: me.global)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        global: Int? = nil
    ) -> Global {
        return Global(
            global: global ?? self.global
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Go
@objcMembers class Go: NSObject, Codable {
    let go: Int

    enum CodingKeys: String, CodingKey {
        case go = "go"
    }

    init(go: Int) {
        self.go = go
    }
}

// MARK: Go convenience initializers and mutators

extension Go {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Go.self, from: data)
        self.init(go: me.go)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        go: Int? = nil
    ) -> Go {
        return Go(
            go: go ?? self.go
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Goto
@objcMembers class Goto: NSObject, Codable {
    let goto: Int

    enum CodingKeys: String, CodingKey {
        case goto = "goto"
    }

    init(goto: Int) {
        self.goto = goto
    }
}

// MARK: Goto convenience initializers and mutators

extension Goto {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Goto.self, from: data)
        self.init(goto: me.goto)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        goto: Int? = nil
    ) -> Goto {
        return Goto(
            goto: goto ?? self.goto
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - HasOwnProperty
@objcMembers class HasOwnProperty: NSObject, Codable {
    let hasOwnProperty: Int

    enum CodingKeys: String, CodingKey {
        case hasOwnProperty = "hasOwnProperty"
    }

    init(hasOwnProperty: Int) {
        self.hasOwnProperty = hasOwnProperty
    }
}

// MARK: HasOwnProperty convenience initializers and mutators

extension HasOwnProperty {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(HasOwnProperty.self, from: data)
        self.init(hasOwnProperty: me.hasOwnProperty)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        hasOwnProperty: Int? = nil
    ) -> HasOwnProperty {
        return HasOwnProperty(
            hasOwnProperty: hasOwnProperty ?? self.hasOwnProperty
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - HashCode
@objcMembers class HashCode: NSObject, Codable {
    let hashCode: Int

    enum CodingKeys: String, CodingKey {
        case hashCode = "hashCode"
    }

    init(hashCode: Int) {
        self.hashCode = hashCode
    }
}

// MARK: HashCode convenience initializers and mutators

extension HashCode {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(HashCode.self, from: data)
        self.init(hashCode: me.hashCode)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        hashCode: Int? = nil
    ) -> HashCode {
        return HashCode(
            hashCode: hashCode ?? self.hashCode
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - HashableClass
@objcMembers class HashableClass: NSObject, Codable {
    let hashable: Int

    enum CodingKeys: String, CodingKey {
        case hashable = "Hashable"
    }

    init(hashable: Int) {
        self.hashable = hashable
    }
}

// MARK: HashableClass convenience initializers and mutators

extension HashableClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(HashableClass.self, from: data)
        self.init(hashable: me.hashable)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        hashable: Int? = nil
    ) -> HashableClass {
        return HashableClass(
            hashable: hashable ?? self.hashable
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - HasherClass
@objcMembers class HasherClass: NSObject, Codable {
    let hasher: Int

    enum CodingKeys: String, CodingKey {
        case hasher = "Hasher"
    }

    init(hasher: Int) {
        self.hasher = hasher
    }
}

// MARK: HasherClass convenience initializers and mutators

extension HasherClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(HasherClass.self, from: data)
        self.init(hasher: me.hasher)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        hasher: Int? = nil
    ) -> HasherClass {
        return HasherClass(
            hasher: hasher ?? self.hasher
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ID
@objcMembers class ID: NSObject, Codable {
    let id: Int

    enum CodingKeys: String, CodingKey {
        case id = "id"
    }

    init(id: Int) {
        self.id = id
    }
}

// MARK: ID convenience initializers and mutators

extension ID {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ID.self, from: data)
        self.init(id: me.id)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: Int? = nil
    ) -> ID {
        return ID(
            id: id ?? self.id
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Imp
@objcMembers class Imp: NSObject, Codable {
    let imp: Int

    enum CodingKeys: String, CodingKey {
        case imp = "IMP"
    }

    init(imp: Int) {
        self.imp = imp
    }
}

// MARK: Imp convenience initializers and mutators

extension Imp {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Imp.self, from: data)
        self.init(imp: me.imp)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        imp: Int? = nil
    ) -> Imp {
        return Imp(
            imp: imp ?? self.imp
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Implements
@objcMembers class Implements: NSObject, Codable {
    let implements: Int

    enum CodingKeys: String, CodingKey {
        case implements = "implements"
    }

    init(implements: Int) {
        self.implements = implements
    }
}

// MARK: Implements convenience initializers and mutators

extension Implements {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Implements.self, from: data)
        self.init(implements: me.implements)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        implements: Int? = nil
    ) -> Implements {
        return Implements(
            implements: implements ?? self.implements
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Implicit
@objcMembers class Implicit: NSObject, Codable {
    let implicit: Int

    enum CodingKeys: String, CodingKey {
        case implicit = "implicit"
    }

    init(implicit: Int) {
        self.implicit = implicit
    }
}

// MARK: Implicit convenience initializers and mutators

extension Implicit {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Implicit.self, from: data)
        self.init(implicit: me.implicit)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        implicit: Int? = nil
    ) -> Implicit {
        return Implicit(
            implicit: implicit ?? self.implicit
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Inline
@objcMembers class Inline: NSObject, Codable {
    let inline: Int

    enum CodingKeys: String, CodingKey {
        case inline = "inline"
    }

    init(inline: Int) {
        self.inline = inline
    }
}

// MARK: Inline convenience initializers and mutators

extension Inline {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Inline.self, from: data)
        self.init(inline: me.inline)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        inline: Int? = nil
    ) -> Inline {
        return Inline(
            inline: inline ?? self.inline
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Instanceof
@objcMembers class Instanceof: NSObject, Codable {
    let instanceof: Int

    enum CodingKeys: String, CodingKey {
        case instanceof = "instanceof"
    }

    init(instanceof: Int) {
        self.instanceof = instanceof
    }
}

// MARK: Instanceof convenience initializers and mutators

extension Instanceof {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Instanceof.self, from: data)
        self.init(instanceof: me.instanceof)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        instanceof: Int? = nil
    ) -> Instanceof {
        return Instanceof(
            instanceof: instanceof ?? self.instanceof
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - IntClass
@objcMembers class IntClass: NSObject, Codable {
    let int: Int

    enum CodingKeys: String, CodingKey {
        case int = "int"
    }

    init(int: Int) {
        self.int = int
    }
}

// MARK: IntClass convenience initializers and mutators

extension IntClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(IntClass.self, from: data)
        self.init(int: me.int)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        int: Int? = nil
    ) -> IntClass {
        return IntClass(
            int: int ?? self.int
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - IntNode
@objcMembers class IntNode: NSObject, Codable {
    let intNode: Int

    enum CodingKeys: String, CodingKey {
        case intNode = "IntNode"
    }

    init(intNode: Int) {
        self.intNode = intNode
    }
}

// MARK: IntNode convenience initializers and mutators

extension IntNode {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(IntNode.self, from: data)
        self.init(intNode: me.intNode)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        intNode: Int? = nil
    ) -> IntNode {
        return IntNode(
            intNode: intNode ?? self.intNode
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Interface
@objcMembers class Interface: NSObject, Codable {
    let interface: Int

    enum CodingKeys: String, CodingKey {
        case interface = "interface"
    }

    init(interface: Int) {
        self.interface = interface
    }
}

// MARK: Interface convenience initializers and mutators

extension Interface {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Interface.self, from: data)
        self.init(interface: me.interface)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        interface: Int? = nil
    ) -> Interface {
        return Interface(
            interface: interface ?? self.interface
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ISODateTimeOffsetConverter
@objcMembers class ISODateTimeOffsetConverter: NSObject, Codable {
    let isoDateTimeOffsetConverter: Int

    enum CodingKeys: String, CodingKey {
        case isoDateTimeOffsetConverter = "IsoDateTimeOffsetConverter"
    }

    init(isoDateTimeOffsetConverter: Int) {
        self.isoDateTimeOffsetConverter = isoDateTimeOffsetConverter
    }
}

// MARK: ISODateTimeOffsetConverter convenience initializers and mutators

extension ISODateTimeOffsetConverter {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ISODateTimeOffsetConverter.self, from: data)
        self.init(isoDateTimeOffsetConverter: me.isoDateTimeOffsetConverter)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        isoDateTimeOffsetConverter: Int? = nil
    ) -> ISODateTimeOffsetConverter {
        return ISODateTimeOffsetConverter(
            isoDateTimeOffsetConverter: isoDateTimeOffsetConverter ?? self.isoDateTimeOffsetConverter
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Iterable
@objcMembers class Iterable: NSObject, Codable {
    let iterable: Int

    enum CodingKeys: String, CodingKey {
        case iterable = "iterable"
    }

    init(iterable: Int) {
        self.iterable = iterable
    }
}

// MARK: Iterable convenience initializers and mutators

extension Iterable {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Iterable.self, from: data)
        self.init(iterable: me.iterable)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        iterable: Int? = nil
    ) -> Iterable {
        return Iterable(
            iterable: iterable ?? self.iterable
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Jdec
@objcMembers class Jdec: NSObject, Codable {
    let jdec: Int

    enum CodingKeys: String, CodingKey {
        case jdec = "jdec"
    }

    init(jdec: Int) {
        self.jdec = jdec
    }
}

// MARK: Jdec convenience initializers and mutators

extension Jdec {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Jdec.self, from: data)
        self.init(jdec: me.jdec)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        jdec: Int? = nil
    ) -> Jdec {
        return Jdec(
            jdec: jdec ?? self.jdec
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Jenc
@objcMembers class Jenc: NSObject, Codable {
    let jenc: Int

    enum CodingKeys: String, CodingKey {
        case jenc = "jenc"
    }

    init(jenc: Int) {
        self.jenc = jenc
    }
}

// MARK: Jenc convenience initializers and mutators

extension Jenc {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Jenc.self, from: data)
        self.init(jenc: me.jenc)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        jenc: Int? = nil
    ) -> Jenc {
        return Jenc(
            jenc: jenc ?? self.jenc
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Jpipe
@objcMembers class Jpipe: NSObject, Codable {
    let jpipe: Int

    enum CodingKeys: String, CodingKey {
        case jpipe = "jpipe"
    }

    init(jpipe: Int) {
        self.jpipe = jpipe
    }
}

// MARK: Jpipe convenience initializers and mutators

extension Jpipe {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Jpipe.self, from: data)
        self.init(jpipe: me.jpipe)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        jpipe: Int? = nil
    ) -> Jpipe {
        return Jpipe(
            jpipe: jpipe ?? self.jpipe
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - JSONAnyClass
@objcMembers class JSONAnyClass: NSObject, Codable {
    let jsonAny: JSONNull?

    enum CodingKeys: String, CodingKey {
        case jsonAny = "JSONAny"
    }

    init(jsonAny: JSONNull?) {
        self.jsonAny = jsonAny
    }
}

// MARK: JSONAnyClass convenience initializers and mutators

extension JSONAnyClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(JSONAnyClass.self, from: data)
        self.init(jsonAny: me.jsonAny)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        jsonAny: JSONNull?? = nil
    ) -> JSONAnyClass {
        return JSONAnyClass(
            jsonAny: jsonAny ?? self.jsonAny
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - JSONCodingKeyClass
@objcMembers class JSONCodingKeyClass: NSObject, Codable {
    let jsonCodingKey: Int

    enum CodingKeys: String, CodingKey {
        case jsonCodingKey = "JSONCodingKey"
    }

    init(jsonCodingKey: Int) {
        self.jsonCodingKey = jsonCodingKey
    }
}

// MARK: JSONCodingKeyClass convenience initializers and mutators

extension JSONCodingKeyClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(JSONCodingKeyClass.self, from: data)
        self.init(jsonCodingKey: me.jsonCodingKey)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        jsonCodingKey: Int? = nil
    ) -> JSONCodingKeyClass {
        return JSONCodingKeyClass(
            jsonCodingKey: jsonCodingKey ?? self.jsonCodingKey
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - JSONConverter
@objcMembers class JSONConverter: NSObject, Codable {
    let jsonConverter: Int

    enum CodingKeys: String, CodingKey {
        case jsonConverter = "json_converter"
    }

    init(jsonConverter: Int) {
        self.jsonConverter = jsonConverter
    }
}

// MARK: JSONConverter convenience initializers and mutators

extension JSONConverter {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(JSONConverter.self, from: data)
        self.init(jsonConverter: me.jsonConverter)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        jsonConverter: Int? = nil
    ) -> JSONConverter {
        return JSONConverter(
            jsonConverter: jsonConverter ?? self.jsonConverter
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - JSONDecoderClass
@objcMembers class JSONDecoderClass: NSObject, Codable {
    let jsonDecoder: Int

    enum CodingKeys: String, CodingKey {
        case jsonDecoder = "JSONDecoder"
    }

    init(jsonDecoder: Int) {
        self.jsonDecoder = jsonDecoder
    }
}

// MARK: JSONDecoderClass convenience initializers and mutators

extension JSONDecoderClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(JSONDecoderClass.self, from: data)
        self.init(jsonDecoder: me.jsonDecoder)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        jsonDecoder: Int? = nil
    ) -> JSONDecoderClass {
        return JSONDecoderClass(
            jsonDecoder: jsonDecoder ?? self.jsonDecoder
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - JSONEncoderClass
@objcMembers class JSONEncoderClass: NSObject, Codable {
    let jsonEncoder: Int

    enum CodingKeys: String, CodingKey {
        case jsonEncoder = "JSONEncoder"
    }

    init(jsonEncoder: Int) {
        self.jsonEncoder = jsonEncoder
    }
}

// MARK: JSONEncoderClass convenience initializers and mutators

extension JSONEncoderClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(JSONEncoderClass.self, from: data)
        self.init(jsonEncoder: me.jsonEncoder)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        jsonEncoder: Int? = nil
    ) -> JSONEncoderClass {
        return JSONEncoderClass(
            jsonEncoder: jsonEncoder ?? self.jsonEncoder
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - JSONException
@objcMembers class JSONException: NSObject, Codable {
    let jsonException: Int

    enum CodingKeys: String, CodingKey {
        case jsonException = "JsonException"
    }

    init(jsonException: Int) {
        self.jsonException = jsonException
    }
}

// MARK: JSONException convenience initializers and mutators

extension JSONException {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(JSONException.self, from: data)
        self.init(jsonException: me.jsonException)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        jsonException: Int? = nil
    ) -> JSONException {
        return JSONException(
            jsonException: jsonException ?? self.jsonException
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - JSONGenerator
@objcMembers class JSONGenerator: NSObject, Codable {
    let jsonGenerator: Int

    enum CodingKeys: String, CodingKey {
        case jsonGenerator = "JsonGenerator"
    }

    init(jsonGenerator: Int) {
        self.jsonGenerator = jsonGenerator
    }
}

// MARK: JSONGenerator convenience initializers and mutators

extension JSONGenerator {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(JSONGenerator.self, from: data)
        self.init(jsonGenerator: me.jsonGenerator)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        jsonGenerator: Int? = nil
    ) -> JSONGenerator {
        return JSONGenerator(
            jsonGenerator: jsonGenerator ?? self.jsonGenerator
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - JSONNode
@objcMembers class JSONNode: NSObject, Codable {
    let jsonNode: Int

    enum CodingKeys: String, CodingKey {
        case jsonNode = "JsonNode"
    }

    init(jsonNode: Int) {
        self.jsonNode = jsonNode
    }
}

// MARK: JSONNode convenience initializers and mutators

extension JSONNode {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(JSONNode.self, from: data)
        self.init(jsonNode: me.jsonNode)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        jsonNode: Int? = nil
    ) -> JSONNode {
        return JSONNode(
            jsonNode: jsonNode ?? self.jsonNode
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - JSONNullClass
@objcMembers class JSONNullClass: NSObject, Codable {
    let jsonNull: Int

    enum CodingKeys: String, CodingKey {
        case jsonNull = "JSONNull"
    }

    init(jsonNull: Int) {
        self.jsonNull = jsonNull
    }
}

// MARK: JSONNullClass convenience initializers and mutators

extension JSONNullClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(JSONNullClass.self, from: data)
        self.init(jsonNull: me.jsonNull)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        jsonNull: Int? = nil
    ) -> JSONNullClass {
        return JSONNullClass(
            jsonNull: jsonNull ?? self.jsonNull
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - JSONParser
@objcMembers class JSONParser: NSObject, Codable {
    let jsonParser: Int

    enum CodingKeys: String, CodingKey {
        case jsonParser = "JsonParser"
    }

    init(jsonParser: Int) {
        self.jsonParser = jsonParser
    }
}

// MARK: JSONParser convenience initializers and mutators

extension JSONParser {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(JSONParser.self, from: data)
        self.init(jsonParser: me.jsonParser)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        jsonParser: Int? = nil
    ) -> JSONParser {
        return JSONParser(
            jsonParser: jsonParser ?? self.jsonParser
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - JSONReader
@objcMembers class JSONReader: NSObject, Codable {
    let jsonReader: Int

    enum CodingKeys: String, CodingKey {
        case jsonReader = "JsonReader"
    }

    init(jsonReader: Int) {
        self.jsonReader = jsonReader
    }
}

// MARK: JSONReader convenience initializers and mutators

extension JSONReader {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(JSONReader.self, from: data)
        self.init(jsonReader: me.jsonReader)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        jsonReader: Int? = nil
    ) -> JSONReader {
        return JSONReader(
            jsonReader: jsonReader ?? self.jsonReader
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - JSONSerializer
@objcMembers class JSONSerializer: NSObject, Codable {
    let jsonSerializer: Int

    enum CodingKeys: String, CodingKey {
        case jsonSerializer = "json_serializer"
    }

    init(jsonSerializer: Int) {
        self.jsonSerializer = jsonSerializer
    }
}

// MARK: JSONSerializer convenience initializers and mutators

extension JSONSerializer {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(JSONSerializer.self, from: data)
        self.init(jsonSerializer: me.jsonSerializer)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        jsonSerializer: Int? = nil
    ) -> JSONSerializer {
        return JSONSerializer(
            jsonSerializer: jsonSerializer ?? self.jsonSerializer
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - JSONToken
@objcMembers class JSONToken: NSObject, Codable {
    let jsonToken: Int

    enum CodingKeys: String, CodingKey {
        case jsonToken = "json_token"
    }

    init(jsonToken: Int) {
        self.jsonToken = jsonToken
    }
}

// MARK: JSONToken convenience initializers and mutators

extension JSONToken {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(JSONToken.self, from: data)
        self.init(jsonToken: me.jsonToken)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        jsonToken: Int? = nil
    ) -> JSONToken {
        return JSONToken(
            jsonToken: jsonToken ?? self.jsonToken
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - JSONTokenType
@objcMembers class JSONTokenType: NSObject, Codable {
    let jsonTokenType: Int

    enum CodingKeys: String, CodingKey {
        case jsonTokenType = "JsonTokenType"
    }

    init(jsonTokenType: Int) {
        self.jsonTokenType = jsonTokenType
    }
}

// MARK: JSONTokenType convenience initializers and mutators

extension JSONTokenType {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(JSONTokenType.self, from: data)
        self.init(jsonTokenType: me.jsonTokenType)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        jsonTokenType: Int? = nil
    ) -> JSONTokenType {
        return JSONTokenType(
            jsonTokenType: jsonTokenType ?? self.jsonTokenType
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - JSONWriter
@objcMembers class JSONWriter: NSObject, Codable {
    let jsonWriter: Int

    enum CodingKeys: String, CodingKey {
        case jsonWriter = "json_writer"
    }

    init(jsonWriter: Int) {
        self.jsonWriter = jsonWriter
    }
}

// MARK: JSONWriter convenience initializers and mutators

extension JSONWriter {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(JSONWriter.self, from: data)
        self.init(jsonWriter: me.jsonWriter)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        jsonWriter: Int? = nil
    ) -> JSONWriter {
        return JSONWriter(
            jsonWriter: jsonWriter ?? self.jsonWriter
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Lambda
@objcMembers class Lambda: NSObject, Codable {
    let lambda: Int

    enum CodingKeys: String, CodingKey {
        case lambda = "lambda"
    }

    init(lambda: Int) {
        self.lambda = lambda
    }
}

// MARK: Lambda convenience initializers and mutators

extension Lambda {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Lambda.self, from: data)
        self.init(lambda: me.lambda)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        lambda: Int? = nil
    ) -> Lambda {
        return Lambda(
            lambda: lambda ?? self.lambda
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - List
@objcMembers class List: NSObject, Codable {
    let list: Int

    enum CodingKeys: String, CodingKey {
        case list = "list"
    }

    init(list: Int) {
        self.list = list
    }
}

// MARK: List convenience initializers and mutators

extension List {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(List.self, from: data)
        self.init(list: me.list)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        list: Int? = nil
    ) -> List {
        return List(
            list: list ?? self.list
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - LocalDate
@objcMembers class LocalDate: NSObject, Codable {
    let localDate: Int

    enum CodingKeys: String, CodingKey {
        case localDate = "LocalDate"
    }

    init(localDate: Int) {
        self.localDate = localDate
    }
}

// MARK: LocalDate convenience initializers and mutators

extension LocalDate {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(LocalDate.self, from: data)
        self.init(localDate: me.localDate)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        localDate: Int? = nil
    ) -> LocalDate {
        return LocalDate(
            localDate: localDate ?? self.localDate
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - LocaleClass
@objcMembers class LocaleClass: NSObject, Codable {
    let locale: Int

    enum CodingKeys: String, CodingKey {
        case locale = "Locale"
    }

    init(locale: Int) {
        self.locale = locale
    }
}

// MARK: LocaleClass convenience initializers and mutators

extension LocaleClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(LocaleClass.self, from: data)
        self.init(locale: me.locale)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        locale: Int? = nil
    ) -> LocaleClass {
        return LocaleClass(
            locale: locale ?? self.locale
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Lock
@objcMembers class Lock: NSObject, Codable {
    let lock: Int

    enum CodingKeys: String, CodingKey {
        case lock = "lock"
    }

    init(lock: Int) {
        self.lock = lock
    }
}

// MARK: Lock convenience initializers and mutators

extension Lock {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Lock.self, from: data)
        self.init(lock: me.lock)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        lock: Int? = nil
    ) -> Lock {
        return Lock(
            lock: lock ?? self.lock
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Long
@objcMembers class Long: NSObject, Codable {
    let long: Int

    enum CodingKeys: String, CodingKey {
        case long = "long"
    }

    init(long: Int) {
        self.long = long
    }
}

// MARK: Long convenience initializers and mutators

extension Long {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Long.self, from: data)
        self.init(long: me.long)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        long: Int? = nil
    ) -> Long {
        return Long(
            long: long ?? self.long
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - LongNode
@objcMembers class LongNode: NSObject, Codable {
    let longNode: Int

    enum CodingKeys: String, CodingKey {
        case longNode = "LongNode"
    }

    init(longNode: Int) {
        self.longNode = longNode
    }
}

// MARK: LongNode convenience initializers and mutators

extension LongNode {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(LongNode.self, from: data)
        self.init(longNode: me.longNode)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        longNode: Int? = nil
    ) -> LongNode {
        return LongNode(
            longNode: longNode ?? self.longNode
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Map
@objcMembers class Map: NSObject, Codable {
    let map: Int

    enum CodingKeys: String, CodingKey {
        case map = "map"
    }

    init(map: Int) {
        self.map = map
    }
}

// MARK: Map convenience initializers and mutators

extension Map {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Map.self, from: data)
        self.init(map: me.map)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        map: Int? = nil
    ) -> Map {
        return Map(
            map: map ?? self.map
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - MapEntry
@objcMembers class MapEntry: NSObject, Codable {
    let mapEntry: Int

    enum CodingKeys: String, CodingKey {
        case mapEntry = "MapEntry"
    }

    init(mapEntry: Int) {
        self.mapEntry = mapEntry
    }
}

// MARK: MapEntry convenience initializers and mutators

extension MapEntry {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(MapEntry.self, from: data)
        self.init(mapEntry: me.mapEntry)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        mapEntry: Int? = nil
    ) -> MapEntry {
        return MapEntry(
            mapEntry: mapEntry ?? self.mapEntry
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - MarshalJSON
@objcMembers class MarshalJSON: NSObject, Codable {
    let marshalJSON: Int

    enum CodingKeys: String, CodingKey {
        case marshalJSON = "MarshalJSON"
    }

    init(marshalJSON: Int) {
        self.marshalJSON = marshalJSON
    }
}

// MARK: MarshalJSON convenience initializers and mutators

extension MarshalJSON {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(MarshalJSON.self, from: data)
        self.init(marshalJSON: me.marshalJSON)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        marshalJSON: Int? = nil
    ) -> MarshalJSON {
        return MarshalJSON(
            marshalJSON: marshalJSON ?? self.marshalJSON
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - MetadataPropertyHandling
@objcMembers class MetadataPropertyHandling: NSObject, Codable {
    let metadataPropertyHandling: Int

    enum CodingKeys: String, CodingKey {
        case metadataPropertyHandling = "metadata_property_handling"
    }

    init(metadataPropertyHandling: Int) {
        self.metadataPropertyHandling = metadataPropertyHandling
    }
}

// MARK: MetadataPropertyHandling convenience initializers and mutators

extension MetadataPropertyHandling {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(MetadataPropertyHandling.self, from: data)
        self.init(metadataPropertyHandling: me.metadataPropertyHandling)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        metadataPropertyHandling: Int? = nil
    ) -> MetadataPropertyHandling {
        return MetadataPropertyHandling(
            metadataPropertyHandling: metadataPropertyHandling ?? self.metadataPropertyHandling
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Module
@objcMembers class Module: NSObject, Codable {
    let module: Int

    enum CodingKeys: String, CodingKey {
        case module = "module"
    }

    init(module: Int) {
        self.module = module
    }
}

// MARK: Module convenience initializers and mutators

extension Module {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Module.self, from: data)
        self.init(module: me.module)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        module: Int? = nil
    ) -> Module {
        return Module(
            module: module ?? self.module
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Get
@objcMembers class Get: NSObject, Codable {
    let getGet: Int

    enum CodingKeys: String, CodingKey {
        case getGet = "get"
    }

    init(getGet: Int) {
        self.getGet = getGet
    }
}

// MARK: Get convenience initializers and mutators

extension Get {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Get.self, from: data)
        self.init(getGet: me.getGet)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        getGet: Int? = nil
    ) -> Get {
        return Get(
            getGet: getGet ?? self.getGet
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Guard
@objcMembers class Guard: NSObject, Codable {
    let guardGuard: Int

    enum CodingKeys: String, CodingKey {
        case guardGuard = "guard"
    }

    init(guardGuard: Int) {
        self.guardGuard = guardGuard
    }
}

// MARK: Guard convenience initializers and mutators

extension Guard {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Guard.self, from: data)
        self.init(guardGuard: me.guardGuard)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        guardGuard: Int? = nil
    ) -> Guard {
        return Guard(
            guardGuard: guardGuard ?? self.guardGuard
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - If
@objcMembers class If: NSObject, Codable {
    let ifIf: Int

    enum CodingKeys: String, CodingKey {
        case ifIf = "if"
    }

    init(ifIf: Int) {
        self.ifIf = ifIf
    }
}

// MARK: If convenience initializers and mutators

extension If {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(If.self, from: data)
        self.init(ifIf: me.ifIf)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        ifIf: Int? = nil
    ) -> If {
        return If(
            ifIf: ifIf ?? self.ifIf
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Import
@objcMembers class Import: NSObject, Codable {
    let importImport: Int

    enum CodingKeys: String, CodingKey {
        case importImport = "import"
    }

    init(importImport: Int) {
        self.importImport = importImport
    }
}

// MARK: Import convenience initializers and mutators

extension Import {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Import.self, from: data)
        self.init(importImport: me.importImport)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        importImport: Int? = nil
    ) -> Import {
        return Import(
            importImport: importImport ?? self.importImport
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - In
@objcMembers class In: NSObject, Codable {
    let inIn: Int

    enum CodingKeys: String, CodingKey {
        case inIn = "in"
    }

    init(inIn: Int) {
        self.inIn = inIn
    }
}

// MARK: In convenience initializers and mutators

extension In {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(In.self, from: data)
        self.init(inIn: me.inIn)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        inIn: Int? = nil
    ) -> In {
        return In(
            inIn: inIn ?? self.inIn
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Indirect
@objcMembers class Indirect: NSObject, Codable {
    let indirectIndirect: Int

    enum CodingKeys: String, CodingKey {
        case indirectIndirect = "indirect"
    }

    init(indirectIndirect: Int) {
        self.indirectIndirect = indirectIndirect
    }
}

// MARK: Indirect convenience initializers and mutators

extension Indirect {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Indirect.self, from: data)
        self.init(indirectIndirect: me.indirectIndirect)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        indirectIndirect: Int? = nil
    ) -> Indirect {
        return Indirect(
            indirectIndirect: indirectIndirect ?? self.indirectIndirect
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Infix
@objcMembers class Infix: NSObject, Codable {
    let infixInfix: Int

    enum CodingKeys: String, CodingKey {
        case infixInfix = "infix"
    }

    init(infixInfix: Int) {
        self.infixInfix = infixInfix
    }
}

// MARK: Infix convenience initializers and mutators

extension Infix {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Infix.self, from: data)
        self.init(infixInfix: me.infixInfix)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        infixInfix: Int? = nil
    ) -> Infix {
        return Infix(
            infixInfix: infixInfix ?? self.infixInfix
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Init
@objcMembers class Init: NSObject, Codable {
    let initInit: Int

    enum CodingKeys: String, CodingKey {
        case initInit = "init"
    }

    init(initInit: Int) {
        self.initInit = initInit
    }
}

// MARK: Init convenience initializers and mutators

extension Init {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Init.self, from: data)
        self.init(initInit: me.initInit)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        initInit: Int? = nil
    ) -> Init {
        return Init(
            initInit: initInit ?? self.initInit
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Inout
@objcMembers class Inout: NSObject, Codable {
    let inoutInout: Int

    enum CodingKeys: String, CodingKey {
        case inoutInout = "inout"
    }

    init(inoutInout: Int) {
        self.inoutInout = inoutInout
    }
}

// MARK: Inout convenience initializers and mutators

extension Inout {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Inout.self, from: data)
        self.init(inoutInout: me.inoutInout)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        inoutInout: Int? = nil
    ) -> Inout {
        return Inout(
            inoutInout: inoutInout ?? self.inoutInout
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Internal
@objcMembers class Internal: NSObject, Codable {
    let internalInternal: Int

    enum CodingKeys: String, CodingKey {
        case internalInternal = "internal"
    }

    init(internalInternal: Int) {
        self.internalInternal = internalInternal
    }
}

// MARK: Internal convenience initializers and mutators

extension Internal {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Internal.self, from: data)
        self.init(internalInternal: me.internalInternal)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        internalInternal: Int? = nil
    ) -> Internal {
        return Internal(
            internalInternal: internalInternal ?? self.internalInternal
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Is
@objcMembers class Is: NSObject, Codable {
    let isIs: Int

    enum CodingKeys: String, CodingKey {
        case isIs = "is"
    }

    init(isIs: Int) {
        self.isIs = isIs
    }
}

// MARK: Is convenience initializers and mutators

extension Is {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Is.self, from: data)
        self.init(isIs: me.isIs)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        isIs: Int? = nil
    ) -> Is {
        return Is(
            isIs: isIs ?? self.isIs
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - JSON
@objcMembers class JSON: NSObject, Codable {
    let jsonJSON: Int

    enum CodingKeys: String, CodingKey {
        case jsonJSON = "json"
    }

    init(jsonJSON: Int) {
        self.jsonJSON = jsonJSON
    }
}

// MARK: JSON convenience initializers and mutators

extension JSON {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(JSON.self, from: data)
        self.init(jsonJSON: me.jsonJSON)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        jsonJSON: Int? = nil
    ) -> JSON {
        return JSON(
            jsonJSON: jsonJSON ?? self.jsonJSON
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Lazy
@objcMembers class Lazy: NSObject, Codable {
    let lazyLazy: Int

    enum CodingKeys: String, CodingKey {
        case lazyLazy = "lazy"
    }

    init(lazyLazy: Int) {
        self.lazyLazy = lazyLazy
    }
}

// MARK: Lazy convenience initializers and mutators

extension Lazy {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Lazy.self, from: data)
        self.init(lazyLazy: me.lazyLazy)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        lazyLazy: Int? = nil
    ) -> Lazy {
        return Lazy(
            lazyLazy: lazyLazy ?? self.lazyLazy
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Left
@objcMembers class Left: NSObject, Codable {
    let leftLeft: Int

    enum CodingKeys: String, CodingKey {
        case leftLeft = "left"
    }

    init(leftLeft: Int) {
        self.leftLeft = leftLeft
    }
}

// MARK: Left convenience initializers and mutators

extension Left {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Left.self, from: data)
        self.init(leftLeft: me.leftLeft)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        leftLeft: Int? = nil
    ) -> Left {
        return Left(
            leftLeft: leftLeft ?? self.leftLeft
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Let
@objcMembers class Let: NSObject, Codable {
    let letLet: Int

    enum CodingKeys: String, CodingKey {
        case letLet = "let"
    }

    init(letLet: Int) {
        self.letLet = letLet
    }
}

// MARK: Let convenience initializers and mutators

extension Let {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Let.self, from: data)
        self.init(letLet: me.letLet)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        letLet: Int? = nil
    ) -> Let {
        return Let(
            letLet: letLet ?? self.letLet
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Obj4
@objcMembers class Obj4: NSObject, Codable {
    let dummy: Int
    let mutable: Mutable
    let namespace: Namespace
    let native: Native
    let new: New
    let newtonsoft: Newtonsoft
    let no: No
    let noSuchMethod: NoSuchMethod
    let noexcept: Noexcept
    let nonatomic: Nonatomic
    let none: None
    let nonlocal: Nonlocal
    let not: Not
    let notEq: NotEq
    let nsError: NSErrorClass
    let nsObject: NSObjectClass
    let nsString: NSString
    let null: Null
    let nullNode: NullNode
    let nullptr: Nullptr
    let number: Number
    let obj4Mutating: Mutating
    let obj4Nil: Nil
    let obj4None: NoneClass
    let obj4Nonmutating: Nonmutating
    let obj4Null: NullClass
    let obj4Open: Open
    let obj4Operator: Operator
    let obj4Optional: Optional
    let obj4Override: Override
    let obj4Postfix: Postfix
    let obj4Precedence: Precedence
    let obj4Prefix: Prefix
    let obj4Private: Private
    let obj4Protocol: ProtocolClass
    let obj4Public: Public
    let object: Object
    let objectMapper: ObjectMapper
    let objectNode: ObjectNode
    let objectReader: ObjectReader
    let objectWriter: ObjectWriter
    let of: Of
    let offsetDateTime: OffsetDateTime
    let offsetTime: OffsetTime
    let oneway: Oneway
    let or: Or
    let orEq: OrEq
    let out: Out
    let package: Package
    let params: Params
    let pass: Pass
    let port: Port
    let print: Print
    let printMembers: PrintMembers
    let printf: Printf
    let protected: Protected
    let purpleProtocol: Obj4Protocol
    let quicktype: Quicktype
    let raise: Raise
    let range: Range
    let readonly: Readonly
    let ref: Ref
    let regExp: RegExp
    let register: Register
    let reinterpretCast: ReinterpretCast

    enum CodingKeys: String, CodingKey {
        case dummy = "dummy"
        case mutable = "mutable"
        case namespace = "namespace"
        case native = "native"
        case new = "new"
        case newtonsoft = "newtonsoft"
        case no = "NO"
        case noSuchMethod = "noSuchMethod"
        case noexcept = "noexcept"
        case nonatomic = "nonatomic"
        case none = "None"
        case nonlocal = "nonlocal"
        case not = "not"
        case notEq = "not_eq"
        case nsError = "NSError"
        case nsObject = "NSObject"
        case nsString = "NSString"
        case null = "NULL"
        case nullNode = "NullNode"
        case nullptr = "nullptr"
        case number = "number"
        case obj4Mutating = "mutating"
        case obj4Nil = "nil"
        case obj4None = "none"
        case obj4Nonmutating = "nonmutating"
        case obj4Null = "null"
        case obj4Open = "open"
        case obj4Operator = "operator"
        case obj4Optional = "optional"
        case obj4Override = "override"
        case obj4Postfix = "postfix"
        case obj4Precedence = "precedence"
        case obj4Prefix = "prefix"
        case obj4Private = "private"
        case obj4Protocol = "Protocol"
        case obj4Public = "public"
        case object = "object"
        case objectMapper = "ObjectMapper"
        case objectNode = "ObjectNode"
        case objectReader = "ObjectReader"
        case objectWriter = "ObjectWriter"
        case of = "of"
        case offsetDateTime = "OffsetDateTime"
        case offsetTime = "OffsetTime"
        case oneway = "oneway"
        case or = "or"
        case orEq = "or_eq"
        case out = "out"
        case package = "package"
        case params = "params"
        case pass = "pass"
        case port = "port"
        case print = "print"
        case printMembers = "printMembers"
        case printf = "printf"
        case protected = "protected"
        case purpleProtocol = "protocol"
        case quicktype = "quicktype"
        case raise = "raise"
        case range = "range"
        case readonly = "readonly"
        case ref = "ref"
        case regExp = "RegExp"
        case register = "register"
        case reinterpretCast = "reinterpret_cast"
    }

    init(dummy: Int, mutable: Mutable, namespace: Namespace, native: Native, new: New, newtonsoft: Newtonsoft, no: No, noSuchMethod: NoSuchMethod, noexcept: Noexcept, nonatomic: Nonatomic, none: None, nonlocal: Nonlocal, not: Not, notEq: NotEq, nsError: NSErrorClass, nsObject: NSObjectClass, nsString: NSString, null: Null, nullNode: NullNode, nullptr: Nullptr, number: Number, obj4Mutating: Mutating, obj4Nil: Nil, obj4None: NoneClass, obj4Nonmutating: Nonmutating, obj4Null: NullClass, obj4Open: Open, obj4Operator: Operator, obj4Optional: Optional, obj4Override: Override, obj4Postfix: Postfix, obj4Precedence: Precedence, obj4Prefix: Prefix, obj4Private: Private, obj4Protocol: ProtocolClass, obj4Public: Public, object: Object, objectMapper: ObjectMapper, objectNode: ObjectNode, objectReader: ObjectReader, objectWriter: ObjectWriter, of: Of, offsetDateTime: OffsetDateTime, offsetTime: OffsetTime, oneway: Oneway, or: Or, orEq: OrEq, out: Out, package: Package, params: Params, pass: Pass, port: Port, print: Print, printMembers: PrintMembers, printf: Printf, protected: Protected, purpleProtocol: Obj4Protocol, quicktype: Quicktype, raise: Raise, range: Range, readonly: Readonly, ref: Ref, regExp: RegExp, register: Register, reinterpretCast: ReinterpretCast) {
        self.dummy = dummy
        self.mutable = mutable
        self.namespace = namespace
        self.native = native
        self.new = new
        self.newtonsoft = newtonsoft
        self.no = no
        self.noSuchMethod = noSuchMethod
        self.noexcept = noexcept
        self.nonatomic = nonatomic
        self.none = none
        self.nonlocal = nonlocal
        self.not = not
        self.notEq = notEq
        self.nsError = nsError
        self.nsObject = nsObject
        self.nsString = nsString
        self.null = null
        self.nullNode = nullNode
        self.nullptr = nullptr
        self.number = number
        self.obj4Mutating = obj4Mutating
        self.obj4Nil = obj4Nil
        self.obj4None = obj4None
        self.obj4Nonmutating = obj4Nonmutating
        self.obj4Null = obj4Null
        self.obj4Open = obj4Open
        self.obj4Operator = obj4Operator
        self.obj4Optional = obj4Optional
        self.obj4Override = obj4Override
        self.obj4Postfix = obj4Postfix
        self.obj4Precedence = obj4Precedence
        self.obj4Prefix = obj4Prefix
        self.obj4Private = obj4Private
        self.obj4Protocol = obj4Protocol
        self.obj4Public = obj4Public
        self.object = object
        self.objectMapper = objectMapper
        self.objectNode = objectNode
        self.objectReader = objectReader
        self.objectWriter = objectWriter
        self.of = of
        self.offsetDateTime = offsetDateTime
        self.offsetTime = offsetTime
        self.oneway = oneway
        self.or = or
        self.orEq = orEq
        self.out = out
        self.package = package
        self.params = params
        self.pass = pass
        self.port = port
        self.print = print
        self.printMembers = printMembers
        self.printf = printf
        self.protected = protected
        self.purpleProtocol = purpleProtocol
        self.quicktype = quicktype
        self.raise = raise
        self.range = range
        self.readonly = readonly
        self.ref = ref
        self.regExp = regExp
        self.register = register
        self.reinterpretCast = reinterpretCast
    }
}

// MARK: Obj4 convenience initializers and mutators

extension Obj4 {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Obj4.self, from: data)
        self.init(dummy: me.dummy, mutable: me.mutable, namespace: me.namespace, native: me.native, new: me.new, newtonsoft: me.newtonsoft, no: me.no, noSuchMethod: me.noSuchMethod, noexcept: me.noexcept, nonatomic: me.nonatomic, none: me.none, nonlocal: me.nonlocal, not: me.not, notEq: me.notEq, nsError: me.nsError, nsObject: me.nsObject, nsString: me.nsString, null: me.null, nullNode: me.nullNode, nullptr: me.nullptr, number: me.number, obj4Mutating: me.obj4Mutating, obj4Nil: me.obj4Nil, obj4None: me.obj4None, obj4Nonmutating: me.obj4Nonmutating, obj4Null: me.obj4Null, obj4Open: me.obj4Open, obj4Operator: me.obj4Operator, obj4Optional: me.obj4Optional, obj4Override: me.obj4Override, obj4Postfix: me.obj4Postfix, obj4Precedence: me.obj4Precedence, obj4Prefix: me.obj4Prefix, obj4Private: me.obj4Private, obj4Protocol: me.obj4Protocol, obj4Public: me.obj4Public, object: me.object, objectMapper: me.objectMapper, objectNode: me.objectNode, objectReader: me.objectReader, objectWriter: me.objectWriter, of: me.of, offsetDateTime: me.offsetDateTime, offsetTime: me.offsetTime, oneway: me.oneway, or: me.or, orEq: me.orEq, out: me.out, package: me.package, params: me.params, pass: me.pass, port: me.port, print: me.print, printMembers: me.printMembers, printf: me.printf, protected: me.protected, purpleProtocol: me.purpleProtocol, quicktype: me.quicktype, raise: me.raise, range: me.range, readonly: me.readonly, ref: me.ref, regExp: me.regExp, register: me.register, reinterpretCast: me.reinterpretCast)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        dummy: Int? = nil,
        mutable: Mutable? = nil,
        namespace: Namespace? = nil,
        native: Native? = nil,
        new: New? = nil,
        newtonsoft: Newtonsoft? = nil,
        no: No? = nil,
        noSuchMethod: NoSuchMethod? = nil,
        noexcept: Noexcept? = nil,
        nonatomic: Nonatomic? = nil,
        none: None? = nil,
        nonlocal: Nonlocal? = nil,
        not: Not? = nil,
        notEq: NotEq? = nil,
        nsError: NSErrorClass? = nil,
        nsObject: NSObjectClass? = nil,
        nsString: NSString? = nil,
        null: Null? = nil,
        nullNode: NullNode? = nil,
        nullptr: Nullptr? = nil,
        number: Number? = nil,
        obj4Mutating: Mutating? = nil,
        obj4Nil: Nil? = nil,
        obj4None: NoneClass? = nil,
        obj4Nonmutating: Nonmutating? = nil,
        obj4Null: NullClass? = nil,
        obj4Open: Open? = nil,
        obj4Operator: Operator? = nil,
        obj4Optional: Optional? = nil,
        obj4Override: Override? = nil,
        obj4Postfix: Postfix? = nil,
        obj4Precedence: Precedence? = nil,
        obj4Prefix: Prefix? = nil,
        obj4Private: Private? = nil,
        obj4Protocol: ProtocolClass? = nil,
        obj4Public: Public? = nil,
        object: Object? = nil,
        objectMapper: ObjectMapper? = nil,
        objectNode: ObjectNode? = nil,
        objectReader: ObjectReader? = nil,
        objectWriter: ObjectWriter? = nil,
        of: Of? = nil,
        offsetDateTime: OffsetDateTime? = nil,
        offsetTime: OffsetTime? = nil,
        oneway: Oneway? = nil,
        or: Or? = nil,
        orEq: OrEq? = nil,
        out: Out? = nil,
        package: Package? = nil,
        params: Params? = nil,
        pass: Pass? = nil,
        port: Port? = nil,
        print: Print? = nil,
        printMembers: PrintMembers? = nil,
        printf: Printf? = nil,
        protected: Protected? = nil,
        purpleProtocol: Obj4Protocol? = nil,
        quicktype: Quicktype? = nil,
        raise: Raise? = nil,
        range: Range? = nil,
        readonly: Readonly? = nil,
        ref: Ref? = nil,
        regExp: RegExp? = nil,
        register: Register? = nil,
        reinterpretCast: ReinterpretCast? = nil
    ) -> Obj4 {
        return Obj4(
            dummy: dummy ?? self.dummy,
            mutable: mutable ?? self.mutable,
            namespace: namespace ?? self.namespace,
            native: native ?? self.native,
            new: new ?? self.new,
            newtonsoft: newtonsoft ?? self.newtonsoft,
            no: no ?? self.no,
            noSuchMethod: noSuchMethod ?? self.noSuchMethod,
            noexcept: noexcept ?? self.noexcept,
            nonatomic: nonatomic ?? self.nonatomic,
            none: none ?? self.none,
            nonlocal: nonlocal ?? self.nonlocal,
            not: not ?? self.not,
            notEq: notEq ?? self.notEq,
            nsError: nsError ?? self.nsError,
            nsObject: nsObject ?? self.nsObject,
            nsString: nsString ?? self.nsString,
            null: null ?? self.null,
            nullNode: nullNode ?? self.nullNode,
            nullptr: nullptr ?? self.nullptr,
            number: number ?? self.number,
            obj4Mutating: obj4Mutating ?? self.obj4Mutating,
            obj4Nil: obj4Nil ?? self.obj4Nil,
            obj4None: obj4None ?? self.obj4None,
            obj4Nonmutating: obj4Nonmutating ?? self.obj4Nonmutating,
            obj4Null: obj4Null ?? self.obj4Null,
            obj4Open: obj4Open ?? self.obj4Open,
            obj4Operator: obj4Operator ?? self.obj4Operator,
            obj4Optional: obj4Optional ?? self.obj4Optional,
            obj4Override: obj4Override ?? self.obj4Override,
            obj4Postfix: obj4Postfix ?? self.obj4Postfix,
            obj4Precedence: obj4Precedence ?? self.obj4Precedence,
            obj4Prefix: obj4Prefix ?? self.obj4Prefix,
            obj4Private: obj4Private ?? self.obj4Private,
            obj4Protocol: obj4Protocol ?? self.obj4Protocol,
            obj4Public: obj4Public ?? self.obj4Public,
            object: object ?? self.object,
            objectMapper: objectMapper ?? self.objectMapper,
            objectNode: objectNode ?? self.objectNode,
            objectReader: objectReader ?? self.objectReader,
            objectWriter: objectWriter ?? self.objectWriter,
            of: of ?? self.of,
            offsetDateTime: offsetDateTime ?? self.offsetDateTime,
            offsetTime: offsetTime ?? self.offsetTime,
            oneway: oneway ?? self.oneway,
            or: or ?? self.or,
            orEq: orEq ?? self.orEq,
            out: out ?? self.out,
            package: package ?? self.package,
            params: params ?? self.params,
            pass: pass ?? self.pass,
            port: port ?? self.port,
            print: print ?? self.print,
            printMembers: printMembers ?? self.printMembers,
            printf: printf ?? self.printf,
            protected: protected ?? self.protected,
            purpleProtocol: purpleProtocol ?? self.purpleProtocol,
            quicktype: quicktype ?? self.quicktype,
            raise: raise ?? self.raise,
            range: range ?? self.range,
            readonly: readonly ?? self.readonly,
            ref: ref ?? self.ref,
            regExp: regExp ?? self.regExp,
            register: register ?? self.register,
            reinterpretCast: reinterpretCast ?? self.reinterpretCast
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Mutable
@objcMembers class Mutable: NSObject, Codable {
    let mutable: Int

    enum CodingKeys: String, CodingKey {
        case mutable = "mutable"
    }

    init(mutable: Int) {
        self.mutable = mutable
    }
}

// MARK: Mutable convenience initializers and mutators

extension Mutable {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Mutable.self, from: data)
        self.init(mutable: me.mutable)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        mutable: Int? = nil
    ) -> Mutable {
        return Mutable(
            mutable: mutable ?? self.mutable
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Namespace
@objcMembers class Namespace: NSObject, Codable {
    let namespace: Int

    enum CodingKeys: String, CodingKey {
        case namespace = "namespace"
    }

    init(namespace: Int) {
        self.namespace = namespace
    }
}

// MARK: Namespace convenience initializers and mutators

extension Namespace {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Namespace.self, from: data)
        self.init(namespace: me.namespace)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        namespace: Int? = nil
    ) -> Namespace {
        return Namespace(
            namespace: namespace ?? self.namespace
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Native
@objcMembers class Native: NSObject, Codable {
    let native: Int

    enum CodingKeys: String, CodingKey {
        case native = "native"
    }

    init(native: Int) {
        self.native = native
    }
}

// MARK: Native convenience initializers and mutators

extension Native {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Native.self, from: data)
        self.init(native: me.native)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        native: Int? = nil
    ) -> Native {
        return Native(
            native: native ?? self.native
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - New
@objcMembers class New: NSObject, Codable {
    let new: Int

    enum CodingKeys: String, CodingKey {
        case new = "new"
    }

    init(new: Int) {
        self.new = new
    }
}

// MARK: New convenience initializers and mutators

extension New {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(New.self, from: data)
        self.init(new: me.new)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        new: Int? = nil
    ) -> New {
        return New(
            new: new ?? self.new
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Newtonsoft
@objcMembers class Newtonsoft: NSObject, Codable {
    let newtonsoft: Int

    enum CodingKeys: String, CodingKey {
        case newtonsoft = "newtonsoft"
    }

    init(newtonsoft: Int) {
        self.newtonsoft = newtonsoft
    }
}

// MARK: Newtonsoft convenience initializers and mutators

extension Newtonsoft {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Newtonsoft.self, from: data)
        self.init(newtonsoft: me.newtonsoft)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        newtonsoft: Int? = nil
    ) -> Newtonsoft {
        return Newtonsoft(
            newtonsoft: newtonsoft ?? self.newtonsoft
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - No
@objcMembers class No: NSObject, Codable {
    let no: Int

    enum CodingKeys: String, CodingKey {
        case no = "NO"
    }

    init(no: Int) {
        self.no = no
    }
}

// MARK: No convenience initializers and mutators

extension No {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(No.self, from: data)
        self.init(no: me.no)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        no: Int? = nil
    ) -> No {
        return No(
            no: no ?? self.no
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - NoSuchMethod
@objcMembers class NoSuchMethod: NSObject, Codable {
    let noSuchMethod: Int

    enum CodingKeys: String, CodingKey {
        case noSuchMethod = "noSuchMethod"
    }

    init(noSuchMethod: Int) {
        self.noSuchMethod = noSuchMethod
    }
}

// MARK: NoSuchMethod convenience initializers and mutators

extension NoSuchMethod {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(NoSuchMethod.self, from: data)
        self.init(noSuchMethod: me.noSuchMethod)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        noSuchMethod: Int? = nil
    ) -> NoSuchMethod {
        return NoSuchMethod(
            noSuchMethod: noSuchMethod ?? self.noSuchMethod
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Noexcept
@objcMembers class Noexcept: NSObject, Codable {
    let noexcept: Int

    enum CodingKeys: String, CodingKey {
        case noexcept = "noexcept"
    }

    init(noexcept: Int) {
        self.noexcept = noexcept
    }
}

// MARK: Noexcept convenience initializers and mutators

extension Noexcept {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Noexcept.self, from: data)
        self.init(noexcept: me.noexcept)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        noexcept: Int? = nil
    ) -> Noexcept {
        return Noexcept(
            noexcept: noexcept ?? self.noexcept
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Nonatomic
@objcMembers class Nonatomic: NSObject, Codable {
    let nonatomic: Int

    enum CodingKeys: String, CodingKey {
        case nonatomic = "nonatomic"
    }

    init(nonatomic: Int) {
        self.nonatomic = nonatomic
    }
}

// MARK: Nonatomic convenience initializers and mutators

extension Nonatomic {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Nonatomic.self, from: data)
        self.init(nonatomic: me.nonatomic)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        nonatomic: Int? = nil
    ) -> Nonatomic {
        return Nonatomic(
            nonatomic: nonatomic ?? self.nonatomic
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - None
@objcMembers class None: NSObject, Codable {
    let none: Int

    enum CodingKeys: String, CodingKey {
        case none = "None"
    }

    init(none: Int) {
        self.none = none
    }
}

// MARK: None convenience initializers and mutators

extension None {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(None.self, from: data)
        self.init(none: me.none)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        none: Int? = nil
    ) -> None {
        return None(
            none: none ?? self.none
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Nonlocal
@objcMembers class Nonlocal: NSObject, Codable {
    let nonlocal: Int

    enum CodingKeys: String, CodingKey {
        case nonlocal = "nonlocal"
    }

    init(nonlocal: Int) {
        self.nonlocal = nonlocal
    }
}

// MARK: Nonlocal convenience initializers and mutators

extension Nonlocal {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Nonlocal.self, from: data)
        self.init(nonlocal: me.nonlocal)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        nonlocal: Int? = nil
    ) -> Nonlocal {
        return Nonlocal(
            nonlocal: nonlocal ?? self.nonlocal
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Not
@objcMembers class Not: NSObject, Codable {
    let not: Int

    enum CodingKeys: String, CodingKey {
        case not = "not"
    }

    init(not: Int) {
        self.not = not
    }
}

// MARK: Not convenience initializers and mutators

extension Not {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Not.self, from: data)
        self.init(not: me.not)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        not: Int? = nil
    ) -> Not {
        return Not(
            not: not ?? self.not
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - NotEq
@objcMembers class NotEq: NSObject, Codable {
    let notEq: Int

    enum CodingKeys: String, CodingKey {
        case notEq = "not_eq"
    }

    init(notEq: Int) {
        self.notEq = notEq
    }
}

// MARK: NotEq convenience initializers and mutators

extension NotEq {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(NotEq.self, from: data)
        self.init(notEq: me.notEq)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        notEq: Int? = nil
    ) -> NotEq {
        return NotEq(
            notEq: notEq ?? self.notEq
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - NSErrorClass
@objcMembers class NSErrorClass: NSObject, Codable {
    let nsError: Int

    enum CodingKeys: String, CodingKey {
        case nsError = "NSError"
    }

    init(nsError: Int) {
        self.nsError = nsError
    }
}

// MARK: NSErrorClass convenience initializers and mutators

extension NSErrorClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(NSErrorClass.self, from: data)
        self.init(nsError: me.nsError)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        nsError: Int? = nil
    ) -> NSErrorClass {
        return NSErrorClass(
            nsError: nsError ?? self.nsError
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - NSObjectClass
@objcMembers class NSObjectClass: NSObject, Codable {
    let nsObject: Int

    enum CodingKeys: String, CodingKey {
        case nsObject = "NSObject"
    }

    init(nsObject: Int) {
        self.nsObject = nsObject
    }
}

// MARK: NSObjectClass convenience initializers and mutators

extension NSObjectClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(NSObjectClass.self, from: data)
        self.init(nsObject: me.nsObject)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        nsObject: Int? = nil
    ) -> NSObjectClass {
        return NSObjectClass(
            nsObject: nsObject ?? self.nsObject
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - NSString
@objcMembers class NSString: NSObject, Codable {
    let nsString: Int

    enum CodingKeys: String, CodingKey {
        case nsString = "NSString"
    }

    init(nsString: Int) {
        self.nsString = nsString
    }
}

// MARK: NSString convenience initializers and mutators

extension NSString {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(NSString.self, from: data)
        self.init(nsString: me.nsString)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        nsString: Int? = nil
    ) -> NSString {
        return NSString(
            nsString: nsString ?? self.nsString
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Null
@objcMembers class Null: NSObject, Codable {
    let null: Int

    enum CodingKeys: String, CodingKey {
        case null = "NULL"
    }

    init(null: Int) {
        self.null = null
    }
}

// MARK: Null convenience initializers and mutators

extension Null {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Null.self, from: data)
        self.init(null: me.null)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        null: Int? = nil
    ) -> Null {
        return Null(
            null: null ?? self.null
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - NullNode
@objcMembers class NullNode: NSObject, Codable {
    let nullNode: Int

    enum CodingKeys: String, CodingKey {
        case nullNode = "NullNode"
    }

    init(nullNode: Int) {
        self.nullNode = nullNode
    }
}

// MARK: NullNode convenience initializers and mutators

extension NullNode {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(NullNode.self, from: data)
        self.init(nullNode: me.nullNode)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        nullNode: Int? = nil
    ) -> NullNode {
        return NullNode(
            nullNode: nullNode ?? self.nullNode
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Nullptr
@objcMembers class Nullptr: NSObject, Codable {
    let nullptr: Int

    enum CodingKeys: String, CodingKey {
        case nullptr = "nullptr"
    }

    init(nullptr: Int) {
        self.nullptr = nullptr
    }
}

// MARK: Nullptr convenience initializers and mutators

extension Nullptr {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Nullptr.self, from: data)
        self.init(nullptr: me.nullptr)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        nullptr: Int? = nil
    ) -> Nullptr {
        return Nullptr(
            nullptr: nullptr ?? self.nullptr
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Number
@objcMembers class Number: NSObject, Codable {
    let number: Int

    enum CodingKeys: String, CodingKey {
        case number = "number"
    }

    init(number: Int) {
        self.number = number
    }
}

// MARK: Number convenience initializers and mutators

extension Number {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Number.self, from: data)
        self.init(number: me.number)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        number: Int? = nil
    ) -> Number {
        return Number(
            number: number ?? self.number
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Mutating
@objcMembers class Mutating: NSObject, Codable {
    let mutatingMutating: Int

    enum CodingKeys: String, CodingKey {
        case mutatingMutating = "mutating"
    }

    init(mutatingMutating: Int) {
        self.mutatingMutating = mutatingMutating
    }
}

// MARK: Mutating convenience initializers and mutators

extension Mutating {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Mutating.self, from: data)
        self.init(mutatingMutating: me.mutatingMutating)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        mutatingMutating: Int? = nil
    ) -> Mutating {
        return Mutating(
            mutatingMutating: mutatingMutating ?? self.mutatingMutating
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Nil
@objcMembers class Nil: NSObject, Codable {
    let nilNil: Int

    enum CodingKeys: String, CodingKey {
        case nilNil = "nil"
    }

    init(nilNil: Int) {
        self.nilNil = nilNil
    }
}

// MARK: Nil convenience initializers and mutators

extension Nil {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Nil.self, from: data)
        self.init(nilNil: me.nilNil)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        nilNil: Int? = nil
    ) -> Nil {
        return Nil(
            nilNil: nilNil ?? self.nilNil
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - NoneClass
@objcMembers class NoneClass: NSObject, Codable {
    let none: Int

    enum CodingKeys: String, CodingKey {
        case none = "none"
    }

    init(none: Int) {
        self.none = none
    }
}

// MARK: NoneClass convenience initializers and mutators

extension NoneClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(NoneClass.self, from: data)
        self.init(none: me.none)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        none: Int? = nil
    ) -> NoneClass {
        return NoneClass(
            none: none ?? self.none
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Nonmutating
@objcMembers class Nonmutating: NSObject, Codable {
    let nonmutatingNonmutating: Int

    enum CodingKeys: String, CodingKey {
        case nonmutatingNonmutating = "nonmutating"
    }

    init(nonmutatingNonmutating: Int) {
        self.nonmutatingNonmutating = nonmutatingNonmutating
    }
}

// MARK: Nonmutating convenience initializers and mutators

extension Nonmutating {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Nonmutating.self, from: data)
        self.init(nonmutatingNonmutating: me.nonmutatingNonmutating)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        nonmutatingNonmutating: Int? = nil
    ) -> Nonmutating {
        return Nonmutating(
            nonmutatingNonmutating: nonmutatingNonmutating ?? self.nonmutatingNonmutating
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - NullClass
@objcMembers class NullClass: NSObject, Codable {
    let null: Int

    enum CodingKeys: String, CodingKey {
        case null = "null"
    }

    init(null: Int) {
        self.null = null
    }
}

// MARK: NullClass convenience initializers and mutators

extension NullClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(NullClass.self, from: data)
        self.init(null: me.null)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        null: Int? = nil
    ) -> NullClass {
        return NullClass(
            null: null ?? self.null
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Open
@objcMembers class Open: NSObject, Codable {
    let openOpen: Int

    enum CodingKeys: String, CodingKey {
        case openOpen = "open"
    }

    init(openOpen: Int) {
        self.openOpen = openOpen
    }
}

// MARK: Open convenience initializers and mutators

extension Open {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Open.self, from: data)
        self.init(openOpen: me.openOpen)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        openOpen: Int? = nil
    ) -> Open {
        return Open(
            openOpen: openOpen ?? self.openOpen
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Operator
@objcMembers class Operator: NSObject, Codable {
    let operatorOperator: Int

    enum CodingKeys: String, CodingKey {
        case operatorOperator = "operator"
    }

    init(operatorOperator: Int) {
        self.operatorOperator = operatorOperator
    }
}

// MARK: Operator convenience initializers and mutators

extension Operator {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Operator.self, from: data)
        self.init(operatorOperator: me.operatorOperator)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        operatorOperator: Int? = nil
    ) -> Operator {
        return Operator(
            operatorOperator: operatorOperator ?? self.operatorOperator
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Optional
@objcMembers class Optional: NSObject, Codable {
    let optionalOptional: Int

    enum CodingKeys: String, CodingKey {
        case optionalOptional = "optional"
    }

    init(optionalOptional: Int) {
        self.optionalOptional = optionalOptional
    }
}

// MARK: Optional convenience initializers and mutators

extension Optional {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Optional.self, from: data)
        self.init(optionalOptional: me.optionalOptional)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        optionalOptional: Int? = nil
    ) -> Optional {
        return Optional(
            optionalOptional: optionalOptional ?? self.optionalOptional
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Override
@objcMembers class Override: NSObject, Codable {
    let overrideOverride: Int

    enum CodingKeys: String, CodingKey {
        case overrideOverride = "override"
    }

    init(overrideOverride: Int) {
        self.overrideOverride = overrideOverride
    }
}

// MARK: Override convenience initializers and mutators

extension Override {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Override.self, from: data)
        self.init(overrideOverride: me.overrideOverride)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        overrideOverride: Int? = nil
    ) -> Override {
        return Override(
            overrideOverride: overrideOverride ?? self.overrideOverride
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Postfix
@objcMembers class Postfix: NSObject, Codable {
    let postfixPostfix: Int

    enum CodingKeys: String, CodingKey {
        case postfixPostfix = "postfix"
    }

    init(postfixPostfix: Int) {
        self.postfixPostfix = postfixPostfix
    }
}

// MARK: Postfix convenience initializers and mutators

extension Postfix {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Postfix.self, from: data)
        self.init(postfixPostfix: me.postfixPostfix)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        postfixPostfix: Int? = nil
    ) -> Postfix {
        return Postfix(
            postfixPostfix: postfixPostfix ?? self.postfixPostfix
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Precedence
@objcMembers class Precedence: NSObject, Codable {
    let precedencePrecedence: Int

    enum CodingKeys: String, CodingKey {
        case precedencePrecedence = "precedence"
    }

    init(precedencePrecedence: Int) {
        self.precedencePrecedence = precedencePrecedence
    }
}

// MARK: Precedence convenience initializers and mutators

extension Precedence {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Precedence.self, from: data)
        self.init(precedencePrecedence: me.precedencePrecedence)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        precedencePrecedence: Int? = nil
    ) -> Precedence {
        return Precedence(
            precedencePrecedence: precedencePrecedence ?? self.precedencePrecedence
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Prefix
@objcMembers class Prefix: NSObject, Codable {
    let prefixPrefix: Int

    enum CodingKeys: String, CodingKey {
        case prefixPrefix = "prefix"
    }

    init(prefixPrefix: Int) {
        self.prefixPrefix = prefixPrefix
    }
}

// MARK: Prefix convenience initializers and mutators

extension Prefix {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Prefix.self, from: data)
        self.init(prefixPrefix: me.prefixPrefix)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        prefixPrefix: Int? = nil
    ) -> Prefix {
        return Prefix(
            prefixPrefix: prefixPrefix ?? self.prefixPrefix
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Private
@objcMembers class Private: NSObject, Codable {
    let privatePrivate: Int

    enum CodingKeys: String, CodingKey {
        case privatePrivate = "private"
    }

    init(privatePrivate: Int) {
        self.privatePrivate = privatePrivate
    }
}

// MARK: Private convenience initializers and mutators

extension Private {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Private.self, from: data)
        self.init(privatePrivate: me.privatePrivate)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        privatePrivate: Int? = nil
    ) -> Private {
        return Private(
            privatePrivate: privatePrivate ?? self.privatePrivate
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ProtocolClass
@objcMembers class ProtocolClass: NSObject, Codable {
    let protocolProtocol: Int

    enum CodingKeys: String, CodingKey {
        case protocolProtocol = "Protocol"
    }

    init(protocolProtocol: Int) {
        self.protocolProtocol = protocolProtocol
    }
}

// MARK: ProtocolClass convenience initializers and mutators

extension ProtocolClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ProtocolClass.self, from: data)
        self.init(protocolProtocol: me.protocolProtocol)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        protocolProtocol: Int? = nil
    ) -> ProtocolClass {
        return ProtocolClass(
            protocolProtocol: protocolProtocol ?? self.protocolProtocol
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Public
@objcMembers class Public: NSObject, Codable {
    let publicPublic: Int

    enum CodingKeys: String, CodingKey {
        case publicPublic = "public"
    }

    init(publicPublic: Int) {
        self.publicPublic = publicPublic
    }
}

// MARK: Public convenience initializers and mutators

extension Public {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Public.self, from: data)
        self.init(publicPublic: me.publicPublic)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        publicPublic: Int? = nil
    ) -> Public {
        return Public(
            publicPublic: publicPublic ?? self.publicPublic
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Object
@objcMembers class Object: NSObject, Codable {
    let object: Int

    enum CodingKeys: String, CodingKey {
        case object = "object"
    }

    init(object: Int) {
        self.object = object
    }
}

// MARK: Object convenience initializers and mutators

extension Object {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Object.self, from: data)
        self.init(object: me.object)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        object: Int? = nil
    ) -> Object {
        return Object(
            object: object ?? self.object
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ObjectMapper
@objcMembers class ObjectMapper: NSObject, Codable {
    let objectMapper: Int

    enum CodingKeys: String, CodingKey {
        case objectMapper = "ObjectMapper"
    }

    init(objectMapper: Int) {
        self.objectMapper = objectMapper
    }
}

// MARK: ObjectMapper convenience initializers and mutators

extension ObjectMapper {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ObjectMapper.self, from: data)
        self.init(objectMapper: me.objectMapper)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        objectMapper: Int? = nil
    ) -> ObjectMapper {
        return ObjectMapper(
            objectMapper: objectMapper ?? self.objectMapper
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ObjectNode
@objcMembers class ObjectNode: NSObject, Codable {
    let objectNode: Int

    enum CodingKeys: String, CodingKey {
        case objectNode = "ObjectNode"
    }

    init(objectNode: Int) {
        self.objectNode = objectNode
    }
}

// MARK: ObjectNode convenience initializers and mutators

extension ObjectNode {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ObjectNode.self, from: data)
        self.init(objectNode: me.objectNode)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        objectNode: Int? = nil
    ) -> ObjectNode {
        return ObjectNode(
            objectNode: objectNode ?? self.objectNode
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ObjectReader
@objcMembers class ObjectReader: NSObject, Codable {
    let objectReader: Int

    enum CodingKeys: String, CodingKey {
        case objectReader = "ObjectReader"
    }

    init(objectReader: Int) {
        self.objectReader = objectReader
    }
}

// MARK: ObjectReader convenience initializers and mutators

extension ObjectReader {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ObjectReader.self, from: data)
        self.init(objectReader: me.objectReader)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        objectReader: Int? = nil
    ) -> ObjectReader {
        return ObjectReader(
            objectReader: objectReader ?? self.objectReader
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ObjectWriter
@objcMembers class ObjectWriter: NSObject, Codable {
    let objectWriter: Int

    enum CodingKeys: String, CodingKey {
        case objectWriter = "ObjectWriter"
    }

    init(objectWriter: Int) {
        self.objectWriter = objectWriter
    }
}

// MARK: ObjectWriter convenience initializers and mutators

extension ObjectWriter {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ObjectWriter.self, from: data)
        self.init(objectWriter: me.objectWriter)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        objectWriter: Int? = nil
    ) -> ObjectWriter {
        return ObjectWriter(
            objectWriter: objectWriter ?? self.objectWriter
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Of
@objcMembers class Of: NSObject, Codable {
    let of: Int

    enum CodingKeys: String, CodingKey {
        case of = "of"
    }

    init(of: Int) {
        self.of = of
    }
}

// MARK: Of convenience initializers and mutators

extension Of {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Of.self, from: data)
        self.init(of: me.of)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        of: Int? = nil
    ) -> Of {
        return Of(
            of: of ?? self.of
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - OffsetDateTime
@objcMembers class OffsetDateTime: NSObject, Codable {
    let offsetDateTime: Int

    enum CodingKeys: String, CodingKey {
        case offsetDateTime = "OffsetDateTime"
    }

    init(offsetDateTime: Int) {
        self.offsetDateTime = offsetDateTime
    }
}

// MARK: OffsetDateTime convenience initializers and mutators

extension OffsetDateTime {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(OffsetDateTime.self, from: data)
        self.init(offsetDateTime: me.offsetDateTime)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        offsetDateTime: Int? = nil
    ) -> OffsetDateTime {
        return OffsetDateTime(
            offsetDateTime: offsetDateTime ?? self.offsetDateTime
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - OffsetTime
@objcMembers class OffsetTime: NSObject, Codable {
    let offsetTime: Int

    enum CodingKeys: String, CodingKey {
        case offsetTime = "OffsetTime"
    }

    init(offsetTime: Int) {
        self.offsetTime = offsetTime
    }
}

// MARK: OffsetTime convenience initializers and mutators

extension OffsetTime {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(OffsetTime.self, from: data)
        self.init(offsetTime: me.offsetTime)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        offsetTime: Int? = nil
    ) -> OffsetTime {
        return OffsetTime(
            offsetTime: offsetTime ?? self.offsetTime
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Oneway
@objcMembers class Oneway: NSObject, Codable {
    let oneway: Int

    enum CodingKeys: String, CodingKey {
        case oneway = "oneway"
    }

    init(oneway: Int) {
        self.oneway = oneway
    }
}

// MARK: Oneway convenience initializers and mutators

extension Oneway {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Oneway.self, from: data)
        self.init(oneway: me.oneway)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        oneway: Int? = nil
    ) -> Oneway {
        return Oneway(
            oneway: oneway ?? self.oneway
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Or
@objcMembers class Or: NSObject, Codable {
    let or: Int

    enum CodingKeys: String, CodingKey {
        case or = "or"
    }

    init(or: Int) {
        self.or = or
    }
}

// MARK: Or convenience initializers and mutators

extension Or {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Or.self, from: data)
        self.init(or: me.or)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        or: Int? = nil
    ) -> Or {
        return Or(
            or: or ?? self.or
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - OrEq
@objcMembers class OrEq: NSObject, Codable {
    let orEq: Int

    enum CodingKeys: String, CodingKey {
        case orEq = "or_eq"
    }

    init(orEq: Int) {
        self.orEq = orEq
    }
}

// MARK: OrEq convenience initializers and mutators

extension OrEq {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(OrEq.self, from: data)
        self.init(orEq: me.orEq)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        orEq: Int? = nil
    ) -> OrEq {
        return OrEq(
            orEq: orEq ?? self.orEq
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Out
@objcMembers class Out: NSObject, Codable {
    let out: Int

    enum CodingKeys: String, CodingKey {
        case out = "out"
    }

    init(out: Int) {
        self.out = out
    }
}

// MARK: Out convenience initializers and mutators

extension Out {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Out.self, from: data)
        self.init(out: me.out)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        out: Int? = nil
    ) -> Out {
        return Out(
            out: out ?? self.out
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Package
@objcMembers class Package: NSObject, Codable {
    let package: Int

    enum CodingKeys: String, CodingKey {
        case package = "package"
    }

    init(package: Int) {
        self.package = package
    }
}

// MARK: Package convenience initializers and mutators

extension Package {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Package.self, from: data)
        self.init(package: me.package)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        package: Int? = nil
    ) -> Package {
        return Package(
            package: package ?? self.package
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Params
@objcMembers class Params: NSObject, Codable {
    let params: Int

    enum CodingKeys: String, CodingKey {
        case params = "params"
    }

    init(params: Int) {
        self.params = params
    }
}

// MARK: Params convenience initializers and mutators

extension Params {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Params.self, from: data)
        self.init(params: me.params)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        params: Int? = nil
    ) -> Params {
        return Params(
            params: params ?? self.params
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Pass
@objcMembers class Pass: NSObject, Codable {
    let pass: Int

    enum CodingKeys: String, CodingKey {
        case pass = "pass"
    }

    init(pass: Int) {
        self.pass = pass
    }
}

// MARK: Pass convenience initializers and mutators

extension Pass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Pass.self, from: data)
        self.init(pass: me.pass)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        pass: Int? = nil
    ) -> Pass {
        return Pass(
            pass: pass ?? self.pass
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Port
@objcMembers class Port: NSObject, Codable {
    let port: Int

    enum CodingKeys: String, CodingKey {
        case port = "port"
    }

    init(port: Int) {
        self.port = port
    }
}

// MARK: Port convenience initializers and mutators

extension Port {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Port.self, from: data)
        self.init(port: me.port)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        port: Int? = nil
    ) -> Port {
        return Port(
            port: port ?? self.port
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Print
@objcMembers class Print: NSObject, Codable {
    let print: Int

    enum CodingKeys: String, CodingKey {
        case print = "print"
    }

    init(print: Int) {
        self.print = print
    }
}

// MARK: Print convenience initializers and mutators

extension Print {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Print.self, from: data)
        self.init(print: me.print)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        print: Int? = nil
    ) -> Print {
        return Print(
            print: print ?? self.print
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - PrintMembers
@objcMembers class PrintMembers: NSObject, Codable {
    let printMembers: Int

    enum CodingKeys: String, CodingKey {
        case printMembers = "printMembers"
    }

    init(printMembers: Int) {
        self.printMembers = printMembers
    }
}

// MARK: PrintMembers convenience initializers and mutators

extension PrintMembers {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(PrintMembers.self, from: data)
        self.init(printMembers: me.printMembers)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        printMembers: Int? = nil
    ) -> PrintMembers {
        return PrintMembers(
            printMembers: printMembers ?? self.printMembers
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Printf
@objcMembers class Printf: NSObject, Codable {
    let printf: Int

    enum CodingKeys: String, CodingKey {
        case printf = "printf"
    }

    init(printf: Int) {
        self.printf = printf
    }
}

// MARK: Printf convenience initializers and mutators

extension Printf {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Printf.self, from: data)
        self.init(printf: me.printf)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        printf: Int? = nil
    ) -> Printf {
        return Printf(
            printf: printf ?? self.printf
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Protected
@objcMembers class Protected: NSObject, Codable {
    let protected: Int

    enum CodingKeys: String, CodingKey {
        case protected = "protected"
    }

    init(protected: Int) {
        self.protected = protected
    }
}

// MARK: Protected convenience initializers and mutators

extension Protected {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Protected.self, from: data)
        self.init(protected: me.protected)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        protected: Int? = nil
    ) -> Protected {
        return Protected(
            protected: protected ?? self.protected
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Obj4Protocol
@objcMembers class Obj4Protocol: NSObject, Codable {
    let protocolProtocol: Int

    enum CodingKeys: String, CodingKey {
        case protocolProtocol = "protocol"
    }

    init(protocolProtocol: Int) {
        self.protocolProtocol = protocolProtocol
    }
}

// MARK: Obj4Protocol convenience initializers and mutators

extension Obj4Protocol {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Obj4Protocol.self, from: data)
        self.init(protocolProtocol: me.protocolProtocol)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        protocolProtocol: Int? = nil
    ) -> Obj4Protocol {
        return Obj4Protocol(
            protocolProtocol: protocolProtocol ?? self.protocolProtocol
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Quicktype
@objcMembers class Quicktype: NSObject, Codable {
    let quicktype: Int

    enum CodingKeys: String, CodingKey {
        case quicktype = "quicktype"
    }

    init(quicktype: Int) {
        self.quicktype = quicktype
    }
}

// MARK: Quicktype convenience initializers and mutators

extension Quicktype {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Quicktype.self, from: data)
        self.init(quicktype: me.quicktype)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        quicktype: Int? = nil
    ) -> Quicktype {
        return Quicktype(
            quicktype: quicktype ?? self.quicktype
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Raise
@objcMembers class Raise: NSObject, Codable {
    let raise: Int

    enum CodingKeys: String, CodingKey {
        case raise = "raise"
    }

    init(raise: Int) {
        self.raise = raise
    }
}

// MARK: Raise convenience initializers and mutators

extension Raise {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Raise.self, from: data)
        self.init(raise: me.raise)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        raise: Int? = nil
    ) -> Raise {
        return Raise(
            raise: raise ?? self.raise
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Range
@objcMembers class Range: NSObject, Codable {
    let range: Int

    enum CodingKeys: String, CodingKey {
        case range = "range"
    }

    init(range: Int) {
        self.range = range
    }
}

// MARK: Range convenience initializers and mutators

extension Range {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Range.self, from: data)
        self.init(range: me.range)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        range: Int? = nil
    ) -> Range {
        return Range(
            range: range ?? self.range
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Readonly
@objcMembers class Readonly: NSObject, Codable {
    let readonly: Int

    enum CodingKeys: String, CodingKey {
        case readonly = "readonly"
    }

    init(readonly: Int) {
        self.readonly = readonly
    }
}

// MARK: Readonly convenience initializers and mutators

extension Readonly {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Readonly.self, from: data)
        self.init(readonly: me.readonly)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        readonly: Int? = nil
    ) -> Readonly {
        return Readonly(
            readonly: readonly ?? self.readonly
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Ref
@objcMembers class Ref: NSObject, Codable {
    let ref: Int

    enum CodingKeys: String, CodingKey {
        case ref = "ref"
    }

    init(ref: Int) {
        self.ref = ref
    }
}

// MARK: Ref convenience initializers and mutators

extension Ref {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Ref.self, from: data)
        self.init(ref: me.ref)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        ref: Int? = nil
    ) -> Ref {
        return Ref(
            ref: ref ?? self.ref
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - RegExp
@objcMembers class RegExp: NSObject, Codable {
    let regExp: UUID

    enum CodingKeys: String, CodingKey {
        case regExp = "RegExp"
    }

    init(regExp: UUID) {
        self.regExp = regExp
    }
}

// MARK: RegExp convenience initializers and mutators

extension RegExp {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(RegExp.self, from: data)
        self.init(regExp: me.regExp)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        regExp: UUID? = nil
    ) -> RegExp {
        return RegExp(
            regExp: regExp ?? self.regExp
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Register
@objcMembers class Register: NSObject, Codable {
    let register: Int

    enum CodingKeys: String, CodingKey {
        case register = "register"
    }

    init(register: Int) {
        self.register = register
    }
}

// MARK: Register convenience initializers and mutators

extension Register {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Register.self, from: data)
        self.init(register: me.register)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        register: Int? = nil
    ) -> Register {
        return Register(
            register: register ?? self.register
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ReinterpretCast
@objcMembers class ReinterpretCast: NSObject, Codable {
    let reinterpretCast: Int

    enum CodingKeys: String, CodingKey {
        case reinterpretCast = "reinterpret_cast"
    }

    init(reinterpretCast: Int) {
        self.reinterpretCast = reinterpretCast
    }
}

// MARK: ReinterpretCast convenience initializers and mutators

extension ReinterpretCast {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ReinterpretCast.self, from: data)
        self.init(reinterpretCast: me.reinterpretCast)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        reinterpretCast: Int? = nil
    ) -> ReinterpretCast {
        return ReinterpretCast(
            reinterpretCast: reinterpretCast ?? self.reinterpretCast
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Obj5
@objcMembers class Obj5: NSObject, Codable {
    let dummy: Int
    let kSerializer: KSerializer
    let obj5Repeat: Repeat
    let obj5Required: Required
    let obj5Retain: Retain
    let obj5Rethrows: Rethrows
    let obj5Return: Return
    let obj5Right: Right
    let obj5Self: SelfClass
    let obj5Set: Set
    let obj5Static: Static
    let obj5Struct: Struct
    let obj5Subscript: Subscript
    let obj5Super: Super
    let obj5Switch: Switch
    let obj5Throw: Throw
    let obj5Throws: Throws
    let obj5True: True
    let primitiveKind: PrimitiveKind
    let purpleSelf: Obj5Self
    let purpleTrue: TrueClass
    let require: Require
    let requires: Requires
    let restrict: Restrict
    let runtimeType: RuntimeType
    let s: S
    let sbyte: Sbyte
    let sealed: Sealed
    let sel: Sel
    let select: Select
    let sendable: Sendable
    let serialDescriptor: SerialDescriptor
    let serialName: SerialName
    let serializable: Serializable
    let serializationFeature: SerializationFeature
    let serialize: Serialize
    let serializerProvider: SerializerProvider
    let short: Short
    let signed: Signed
    let simpleModule: SimpleModule
    let sizeof: Sizeof
    let stackalloc: Stackalloc
    let standards: Standards
    let staticAssert: StaticAssert
    let staticCast: StaticCast
    let stdDeserializer: StdDeserializer
    let stdSerializer: StdSerializer
    let strictfp: Strictfp
    let string: StringClass
    let symbol: Symbol
    let synchronized: Synchronized
    let system: System
    let template: Template
    let textNode: TextNode
    let then: Then
    let this: This
    let threadLocal: ThreadLocal
    let timeOnly: TimeOnly
    let timeOnlyConverter: TimeOnlyConverter
    let timeZone: TimeZoneClass
    let toDict: ToDict
    let toJSON: ToJSON
    let toString: ToString
    let topLevel: TopLevelClass
    let transient: Transient

    enum CodingKeys: String, CodingKey {
        case dummy = "dummy"
        case kSerializer = "KSerializer"
        case obj5Repeat = "repeat"
        case obj5Required = "required"
        case obj5Retain = "retain"
        case obj5Rethrows = "rethrows"
        case obj5Return = "return"
        case obj5Right = "right"
        case obj5Self = "Self"
        case obj5Set = "set"
        case obj5Static = "static"
        case obj5Struct = "struct"
        case obj5Subscript = "subscript"
        case obj5Super = "super"
        case obj5Switch = "switch"
        case obj5Throw = "throw"
        case obj5Throws = "throws"
        case obj5True = "True"
        case primitiveKind = "PrimitiveKind"
        case purpleSelf = "self"
        case purpleTrue = "true"
        case require = "require"
        case requires = "requires"
        case restrict = "restrict"
        case runtimeType = "runtimeType"
        case s = "s"
        case sbyte = "sbyte"
        case sealed = "sealed"
        case sel = "SEL"
        case select = "select"
        case sendable = "Sendable"
        case serialDescriptor = "SerialDescriptor"
        case serialName = "SerialName"
        case serializable = "Serializable"
        case serializationFeature = "SerializationFeature"
        case serialize = "serialize"
        case serializerProvider = "SerializerProvider"
        case short = "short"
        case signed = "signed"
        case simpleModule = "SimpleModule"
        case sizeof = "sizeof"
        case stackalloc = "stackalloc"
        case standards = "Standards"
        case staticAssert = "static_assert"
        case staticCast = "static_cast"
        case stdDeserializer = "StdDeserializer"
        case stdSerializer = "StdSerializer"
        case strictfp = "strictfp"
        case string = "string"
        case symbol = "symbol"
        case synchronized = "synchronized"
        case system = "system"
        case template = "template"
        case textNode = "TextNode"
        case then = "then"
        case this = "this"
        case threadLocal = "thread_local"
        case timeOnly = "TimeOnly"
        case timeOnlyConverter = "TimeOnlyConverter"
        case timeZone = "TimeZone"
        case toDict = "to_dict"
        case toJSON = "to_json"
        case toString = "toString"
        case topLevel = "top_level"
        case transient = "transient"
    }

    init(dummy: Int, kSerializer: KSerializer, obj5Repeat: Repeat, obj5Required: Required, obj5Retain: Retain, obj5Rethrows: Rethrows, obj5Return: Return, obj5Right: Right, obj5Self: SelfClass, obj5Set: Set, obj5Static: Static, obj5Struct: Struct, obj5Subscript: Subscript, obj5Super: Super, obj5Switch: Switch, obj5Throw: Throw, obj5Throws: Throws, obj5True: True, primitiveKind: PrimitiveKind, purpleSelf: Obj5Self, purpleTrue: TrueClass, require: Require, requires: Requires, restrict: Restrict, runtimeType: RuntimeType, s: S, sbyte: Sbyte, sealed: Sealed, sel: Sel, select: Select, sendable: Sendable, serialDescriptor: SerialDescriptor, serialName: SerialName, serializable: Serializable, serializationFeature: SerializationFeature, serialize: Serialize, serializerProvider: SerializerProvider, short: Short, signed: Signed, simpleModule: SimpleModule, sizeof: Sizeof, stackalloc: Stackalloc, standards: Standards, staticAssert: StaticAssert, staticCast: StaticCast, stdDeserializer: StdDeserializer, stdSerializer: StdSerializer, strictfp: Strictfp, string: StringClass, symbol: Symbol, synchronized: Synchronized, system: System, template: Template, textNode: TextNode, then: Then, this: This, threadLocal: ThreadLocal, timeOnly: TimeOnly, timeOnlyConverter: TimeOnlyConverter, timeZone: TimeZoneClass, toDict: ToDict, toJSON: ToJSON, toString: ToString, topLevel: TopLevelClass, transient: Transient) {
        self.dummy = dummy
        self.kSerializer = kSerializer
        self.obj5Repeat = obj5Repeat
        self.obj5Required = obj5Required
        self.obj5Retain = obj5Retain
        self.obj5Rethrows = obj5Rethrows
        self.obj5Return = obj5Return
        self.obj5Right = obj5Right
        self.obj5Self = obj5Self
        self.obj5Set = obj5Set
        self.obj5Static = obj5Static
        self.obj5Struct = obj5Struct
        self.obj5Subscript = obj5Subscript
        self.obj5Super = obj5Super
        self.obj5Switch = obj5Switch
        self.obj5Throw = obj5Throw
        self.obj5Throws = obj5Throws
        self.obj5True = obj5True
        self.primitiveKind = primitiveKind
        self.purpleSelf = purpleSelf
        self.purpleTrue = purpleTrue
        self.require = require
        self.requires = requires
        self.restrict = restrict
        self.runtimeType = runtimeType
        self.s = s
        self.sbyte = sbyte
        self.sealed = sealed
        self.sel = sel
        self.select = select
        self.sendable = sendable
        self.serialDescriptor = serialDescriptor
        self.serialName = serialName
        self.serializable = serializable
        self.serializationFeature = serializationFeature
        self.serialize = serialize
        self.serializerProvider = serializerProvider
        self.short = short
        self.signed = signed
        self.simpleModule = simpleModule
        self.sizeof = sizeof
        self.stackalloc = stackalloc
        self.standards = standards
        self.staticAssert = staticAssert
        self.staticCast = staticCast
        self.stdDeserializer = stdDeserializer
        self.stdSerializer = stdSerializer
        self.strictfp = strictfp
        self.string = string
        self.symbol = symbol
        self.synchronized = synchronized
        self.system = system
        self.template = template
        self.textNode = textNode
        self.then = then
        self.this = this
        self.threadLocal = threadLocal
        self.timeOnly = timeOnly
        self.timeOnlyConverter = timeOnlyConverter
        self.timeZone = timeZone
        self.toDict = toDict
        self.toJSON = toJSON
        self.toString = toString
        self.topLevel = topLevel
        self.transient = transient
    }
}

// MARK: Obj5 convenience initializers and mutators

extension Obj5 {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Obj5.self, from: data)
        self.init(dummy: me.dummy, kSerializer: me.kSerializer, obj5Repeat: me.obj5Repeat, obj5Required: me.obj5Required, obj5Retain: me.obj5Retain, obj5Rethrows: me.obj5Rethrows, obj5Return: me.obj5Return, obj5Right: me.obj5Right, obj5Self: me.obj5Self, obj5Set: me.obj5Set, obj5Static: me.obj5Static, obj5Struct: me.obj5Struct, obj5Subscript: me.obj5Subscript, obj5Super: me.obj5Super, obj5Switch: me.obj5Switch, obj5Throw: me.obj5Throw, obj5Throws: me.obj5Throws, obj5True: me.obj5True, primitiveKind: me.primitiveKind, purpleSelf: me.purpleSelf, purpleTrue: me.purpleTrue, require: me.require, requires: me.requires, restrict: me.restrict, runtimeType: me.runtimeType, s: me.s, sbyte: me.sbyte, sealed: me.sealed, sel: me.sel, select: me.select, sendable: me.sendable, serialDescriptor: me.serialDescriptor, serialName: me.serialName, serializable: me.serializable, serializationFeature: me.serializationFeature, serialize: me.serialize, serializerProvider: me.serializerProvider, short: me.short, signed: me.signed, simpleModule: me.simpleModule, sizeof: me.sizeof, stackalloc: me.stackalloc, standards: me.standards, staticAssert: me.staticAssert, staticCast: me.staticCast, stdDeserializer: me.stdDeserializer, stdSerializer: me.stdSerializer, strictfp: me.strictfp, string: me.string, symbol: me.symbol, synchronized: me.synchronized, system: me.system, template: me.template, textNode: me.textNode, then: me.then, this: me.this, threadLocal: me.threadLocal, timeOnly: me.timeOnly, timeOnlyConverter: me.timeOnlyConverter, timeZone: me.timeZone, toDict: me.toDict, toJSON: me.toJSON, toString: me.toString, topLevel: me.topLevel, transient: me.transient)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        dummy: Int? = nil,
        kSerializer: KSerializer? = nil,
        obj5Repeat: Repeat? = nil,
        obj5Required: Required? = nil,
        obj5Retain: Retain? = nil,
        obj5Rethrows: Rethrows? = nil,
        obj5Return: Return? = nil,
        obj5Right: Right? = nil,
        obj5Self: SelfClass? = nil,
        obj5Set: Set? = nil,
        obj5Static: Static? = nil,
        obj5Struct: Struct? = nil,
        obj5Subscript: Subscript? = nil,
        obj5Super: Super? = nil,
        obj5Switch: Switch? = nil,
        obj5Throw: Throw? = nil,
        obj5Throws: Throws? = nil,
        obj5True: True? = nil,
        primitiveKind: PrimitiveKind? = nil,
        purpleSelf: Obj5Self? = nil,
        purpleTrue: TrueClass? = nil,
        require: Require? = nil,
        requires: Requires? = nil,
        restrict: Restrict? = nil,
        runtimeType: RuntimeType? = nil,
        s: S? = nil,
        sbyte: Sbyte? = nil,
        sealed: Sealed? = nil,
        sel: Sel? = nil,
        select: Select? = nil,
        sendable: Sendable? = nil,
        serialDescriptor: SerialDescriptor? = nil,
        serialName: SerialName? = nil,
        serializable: Serializable? = nil,
        serializationFeature: SerializationFeature? = nil,
        serialize: Serialize? = nil,
        serializerProvider: SerializerProvider? = nil,
        short: Short? = nil,
        signed: Signed? = nil,
        simpleModule: SimpleModule? = nil,
        sizeof: Sizeof? = nil,
        stackalloc: Stackalloc? = nil,
        standards: Standards? = nil,
        staticAssert: StaticAssert? = nil,
        staticCast: StaticCast? = nil,
        stdDeserializer: StdDeserializer? = nil,
        stdSerializer: StdSerializer? = nil,
        strictfp: Strictfp? = nil,
        string: StringClass? = nil,
        symbol: Symbol? = nil,
        synchronized: Synchronized? = nil,
        system: System? = nil,
        template: Template? = nil,
        textNode: TextNode? = nil,
        then: Then? = nil,
        this: This? = nil,
        threadLocal: ThreadLocal? = nil,
        timeOnly: TimeOnly? = nil,
        timeOnlyConverter: TimeOnlyConverter? = nil,
        timeZone: TimeZoneClass? = nil,
        toDict: ToDict? = nil,
        toJSON: ToJSON? = nil,
        toString: ToString? = nil,
        topLevel: TopLevelClass? = nil,
        transient: Transient? = nil
    ) -> Obj5 {
        return Obj5(
            dummy: dummy ?? self.dummy,
            kSerializer: kSerializer ?? self.kSerializer,
            obj5Repeat: obj5Repeat ?? self.obj5Repeat,
            obj5Required: obj5Required ?? self.obj5Required,
            obj5Retain: obj5Retain ?? self.obj5Retain,
            obj5Rethrows: obj5Rethrows ?? self.obj5Rethrows,
            obj5Return: obj5Return ?? self.obj5Return,
            obj5Right: obj5Right ?? self.obj5Right,
            obj5Self: obj5Self ?? self.obj5Self,
            obj5Set: obj5Set ?? self.obj5Set,
            obj5Static: obj5Static ?? self.obj5Static,
            obj5Struct: obj5Struct ?? self.obj5Struct,
            obj5Subscript: obj5Subscript ?? self.obj5Subscript,
            obj5Super: obj5Super ?? self.obj5Super,
            obj5Switch: obj5Switch ?? self.obj5Switch,
            obj5Throw: obj5Throw ?? self.obj5Throw,
            obj5Throws: obj5Throws ?? self.obj5Throws,
            obj5True: obj5True ?? self.obj5True,
            primitiveKind: primitiveKind ?? self.primitiveKind,
            purpleSelf: purpleSelf ?? self.purpleSelf,
            purpleTrue: purpleTrue ?? self.purpleTrue,
            require: require ?? self.require,
            requires: requires ?? self.requires,
            restrict: restrict ?? self.restrict,
            runtimeType: runtimeType ?? self.runtimeType,
            s: s ?? self.s,
            sbyte: sbyte ?? self.sbyte,
            sealed: sealed ?? self.sealed,
            sel: sel ?? self.sel,
            select: select ?? self.select,
            sendable: sendable ?? self.sendable,
            serialDescriptor: serialDescriptor ?? self.serialDescriptor,
            serialName: serialName ?? self.serialName,
            serializable: serializable ?? self.serializable,
            serializationFeature: serializationFeature ?? self.serializationFeature,
            serialize: serialize ?? self.serialize,
            serializerProvider: serializerProvider ?? self.serializerProvider,
            short: short ?? self.short,
            signed: signed ?? self.signed,
            simpleModule: simpleModule ?? self.simpleModule,
            sizeof: sizeof ?? self.sizeof,
            stackalloc: stackalloc ?? self.stackalloc,
            standards: standards ?? self.standards,
            staticAssert: staticAssert ?? self.staticAssert,
            staticCast: staticCast ?? self.staticCast,
            stdDeserializer: stdDeserializer ?? self.stdDeserializer,
            stdSerializer: stdSerializer ?? self.stdSerializer,
            strictfp: strictfp ?? self.strictfp,
            string: string ?? self.string,
            symbol: symbol ?? self.symbol,
            synchronized: synchronized ?? self.synchronized,
            system: system ?? self.system,
            template: template ?? self.template,
            textNode: textNode ?? self.textNode,
            then: then ?? self.then,
            this: this ?? self.this,
            threadLocal: threadLocal ?? self.threadLocal,
            timeOnly: timeOnly ?? self.timeOnly,
            timeOnlyConverter: timeOnlyConverter ?? self.timeOnlyConverter,
            timeZone: timeZone ?? self.timeZone,
            toDict: toDict ?? self.toDict,
            toJSON: toJSON ?? self.toJSON,
            toString: toString ?? self.toString,
            topLevel: topLevel ?? self.topLevel,
            transient: transient ?? self.transient
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - KSerializer
@objcMembers class KSerializer: NSObject, Codable {
    let kSerializer: Int

    enum CodingKeys: String, CodingKey {
        case kSerializer = "KSerializer"
    }

    init(kSerializer: Int) {
        self.kSerializer = kSerializer
    }
}

// MARK: KSerializer convenience initializers and mutators

extension KSerializer {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(KSerializer.self, from: data)
        self.init(kSerializer: me.kSerializer)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        kSerializer: Int? = nil
    ) -> KSerializer {
        return KSerializer(
            kSerializer: kSerializer ?? self.kSerializer
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Repeat
@objcMembers class Repeat: NSObject, Codable {
    let repeatRepeat: Int

    enum CodingKeys: String, CodingKey {
        case repeatRepeat = "repeat"
    }

    init(repeatRepeat: Int) {
        self.repeatRepeat = repeatRepeat
    }
}

// MARK: Repeat convenience initializers and mutators

extension Repeat {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Repeat.self, from: data)
        self.init(repeatRepeat: me.repeatRepeat)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        repeatRepeat: Int? = nil
    ) -> Repeat {
        return Repeat(
            repeatRepeat: repeatRepeat ?? self.repeatRepeat
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Required
@objcMembers class Required: NSObject, Codable {
    let requiredRequired: Int

    enum CodingKeys: String, CodingKey {
        case requiredRequired = "required"
    }

    init(requiredRequired: Int) {
        self.requiredRequired = requiredRequired
    }
}

// MARK: Required convenience initializers and mutators

extension Required {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Required.self, from: data)
        self.init(requiredRequired: me.requiredRequired)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        requiredRequired: Int? = nil
    ) -> Required {
        return Required(
            requiredRequired: requiredRequired ?? self.requiredRequired
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Retain
@objcMembers class Retain: NSObject, Codable {
    let retainRetain: Int

    enum CodingKeys: String, CodingKey {
        case retainRetain = "retain"
    }

    init(retainRetain: Int) {
        self.retainRetain = retainRetain
    }
}

// MARK: Retain convenience initializers and mutators

extension Retain {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Retain.self, from: data)
        self.init(retainRetain: me.retainRetain)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        retainRetain: Int? = nil
    ) -> Retain {
        return Retain(
            retainRetain: retainRetain ?? self.retainRetain
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Rethrows
@objcMembers class Rethrows: NSObject, Codable {
    let rethrowsRethrows: Int

    enum CodingKeys: String, CodingKey {
        case rethrowsRethrows = "rethrows"
    }

    init(rethrowsRethrows: Int) {
        self.rethrowsRethrows = rethrowsRethrows
    }
}

// MARK: Rethrows convenience initializers and mutators

extension Rethrows {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Rethrows.self, from: data)
        self.init(rethrowsRethrows: me.rethrowsRethrows)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        rethrowsRethrows: Int? = nil
    ) -> Rethrows {
        return Rethrows(
            rethrowsRethrows: rethrowsRethrows ?? self.rethrowsRethrows
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Return
@objcMembers class Return: NSObject, Codable {
    let returnReturn: Int

    enum CodingKeys: String, CodingKey {
        case returnReturn = "return"
    }

    init(returnReturn: Int) {
        self.returnReturn = returnReturn
    }
}

// MARK: Return convenience initializers and mutators

extension Return {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Return.self, from: data)
        self.init(returnReturn: me.returnReturn)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        returnReturn: Int? = nil
    ) -> Return {
        return Return(
            returnReturn: returnReturn ?? self.returnReturn
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Right
@objcMembers class Right: NSObject, Codable {
    let rightRight: Int

    enum CodingKeys: String, CodingKey {
        case rightRight = "right"
    }

    init(rightRight: Int) {
        self.rightRight = rightRight
    }
}

// MARK: Right convenience initializers and mutators

extension Right {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Right.self, from: data)
        self.init(rightRight: me.rightRight)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        rightRight: Int? = nil
    ) -> Right {
        return Right(
            rightRight: rightRight ?? self.rightRight
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - SelfClass
@objcMembers class SelfClass: NSObject, Codable {
    let selfSelf: Int

    enum CodingKeys: String, CodingKey {
        case selfSelf = "Self"
    }

    init(selfSelf: Int) {
        self.selfSelf = selfSelf
    }
}

// MARK: SelfClass convenience initializers and mutators

extension SelfClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(SelfClass.self, from: data)
        self.init(selfSelf: me.selfSelf)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        selfSelf: Int? = nil
    ) -> SelfClass {
        return SelfClass(
            selfSelf: selfSelf ?? self.selfSelf
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Set
@objcMembers class Set: NSObject, Codable {
    let setSet: Int

    enum CodingKeys: String, CodingKey {
        case setSet = "set"
    }

    init(setSet: Int) {
        self.setSet = setSet
    }
}

// MARK: Set convenience initializers and mutators

extension Set {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Set.self, from: data)
        self.init(setSet: me.setSet)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        setSet: Int? = nil
    ) -> Set {
        return Set(
            setSet: setSet ?? self.setSet
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Static
@objcMembers class Static: NSObject, Codable {
    let staticStatic: Int

    enum CodingKeys: String, CodingKey {
        case staticStatic = "static"
    }

    init(staticStatic: Int) {
        self.staticStatic = staticStatic
    }
}

// MARK: Static convenience initializers and mutators

extension Static {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Static.self, from: data)
        self.init(staticStatic: me.staticStatic)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        staticStatic: Int? = nil
    ) -> Static {
        return Static(
            staticStatic: staticStatic ?? self.staticStatic
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Struct
@objcMembers class Struct: NSObject, Codable {
    let structStruct: Int

    enum CodingKeys: String, CodingKey {
        case structStruct = "struct"
    }

    init(structStruct: Int) {
        self.structStruct = structStruct
    }
}

// MARK: Struct convenience initializers and mutators

extension Struct {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Struct.self, from: data)
        self.init(structStruct: me.structStruct)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        structStruct: Int? = nil
    ) -> Struct {
        return Struct(
            structStruct: structStruct ?? self.structStruct
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Subscript
@objcMembers class Subscript: NSObject, Codable {
    let subscriptSubscript: Int

    enum CodingKeys: String, CodingKey {
        case subscriptSubscript = "subscript"
    }

    init(subscriptSubscript: Int) {
        self.subscriptSubscript = subscriptSubscript
    }
}

// MARK: Subscript convenience initializers and mutators

extension Subscript {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Subscript.self, from: data)
        self.init(subscriptSubscript: me.subscriptSubscript)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        subscriptSubscript: Int? = nil
    ) -> Subscript {
        return Subscript(
            subscriptSubscript: subscriptSubscript ?? self.subscriptSubscript
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Super
@objcMembers class Super: NSObject, Codable {
    let superSuper: Int

    enum CodingKeys: String, CodingKey {
        case superSuper = "super"
    }

    init(superSuper: Int) {
        self.superSuper = superSuper
    }
}

// MARK: Super convenience initializers and mutators

extension Super {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Super.self, from: data)
        self.init(superSuper: me.superSuper)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        superSuper: Int? = nil
    ) -> Super {
        return Super(
            superSuper: superSuper ?? self.superSuper
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Switch
@objcMembers class Switch: NSObject, Codable {
    let switchSwitch: Int

    enum CodingKeys: String, CodingKey {
        case switchSwitch = "switch"
    }

    init(switchSwitch: Int) {
        self.switchSwitch = switchSwitch
    }
}

// MARK: Switch convenience initializers and mutators

extension Switch {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Switch.self, from: data)
        self.init(switchSwitch: me.switchSwitch)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        switchSwitch: Int? = nil
    ) -> Switch {
        return Switch(
            switchSwitch: switchSwitch ?? self.switchSwitch
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Throw
@objcMembers class Throw: NSObject, Codable {
    let throwThrow: Int

    enum CodingKeys: String, CodingKey {
        case throwThrow = "throw"
    }

    init(throwThrow: Int) {
        self.throwThrow = throwThrow
    }
}

// MARK: Throw convenience initializers and mutators

extension Throw {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Throw.self, from: data)
        self.init(throwThrow: me.throwThrow)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        throwThrow: Int? = nil
    ) -> Throw {
        return Throw(
            throwThrow: throwThrow ?? self.throwThrow
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Throws
@objcMembers class Throws: NSObject, Codable {
    let throwsThrows: Int

    enum CodingKeys: String, CodingKey {
        case throwsThrows = "throws"
    }

    init(throwsThrows: Int) {
        self.throwsThrows = throwsThrows
    }
}

// MARK: Throws convenience initializers and mutators

extension Throws {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Throws.self, from: data)
        self.init(throwsThrows: me.throwsThrows)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        throwsThrows: Int? = nil
    ) -> Throws {
        return Throws(
            throwsThrows: throwsThrows ?? self.throwsThrows
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - True
@objcMembers class True: NSObject, Codable {
    let trueTrue: Int

    enum CodingKeys: String, CodingKey {
        case trueTrue = "True"
    }

    init(trueTrue: Int) {
        self.trueTrue = trueTrue
    }
}

// MARK: True convenience initializers and mutators

extension True {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(True.self, from: data)
        self.init(trueTrue: me.trueTrue)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        trueTrue: Int? = nil
    ) -> True {
        return True(
            trueTrue: trueTrue ?? self.trueTrue
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - PrimitiveKind
@objcMembers class PrimitiveKind: NSObject, Codable {
    let primitiveKind: Int

    enum CodingKeys: String, CodingKey {
        case primitiveKind = "PrimitiveKind"
    }

    init(primitiveKind: Int) {
        self.primitiveKind = primitiveKind
    }
}

// MARK: PrimitiveKind convenience initializers and mutators

extension PrimitiveKind {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(PrimitiveKind.self, from: data)
        self.init(primitiveKind: me.primitiveKind)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        primitiveKind: Int? = nil
    ) -> PrimitiveKind {
        return PrimitiveKind(
            primitiveKind: primitiveKind ?? self.primitiveKind
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Obj5Self
@objcMembers class Obj5Self: NSObject, Codable {
    let selfSelf: Int

    enum CodingKeys: String, CodingKey {
        case selfSelf = "self"
    }

    init(selfSelf: Int) {
        self.selfSelf = selfSelf
    }
}

// MARK: Obj5Self convenience initializers and mutators

extension Obj5Self {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Obj5Self.self, from: data)
        self.init(selfSelf: me.selfSelf)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        selfSelf: Int? = nil
    ) -> Obj5Self {
        return Obj5Self(
            selfSelf: selfSelf ?? self.selfSelf
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - TrueClass
@objcMembers class TrueClass: NSObject, Codable {
    let trueTrue: Int

    enum CodingKeys: String, CodingKey {
        case trueTrue = "true"
    }

    init(trueTrue: Int) {
        self.trueTrue = trueTrue
    }
}

// MARK: TrueClass convenience initializers and mutators

extension TrueClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(TrueClass.self, from: data)
        self.init(trueTrue: me.trueTrue)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        trueTrue: Int? = nil
    ) -> TrueClass {
        return TrueClass(
            trueTrue: trueTrue ?? self.trueTrue
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Require
@objcMembers class Require: NSObject, Codable {
    let require: Int

    enum CodingKeys: String, CodingKey {
        case require = "require"
    }

    init(require: Int) {
        self.require = require
    }
}

// MARK: Require convenience initializers and mutators

extension Require {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Require.self, from: data)
        self.init(require: me.require)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        require: Int? = nil
    ) -> Require {
        return Require(
            require: require ?? self.require
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Requires
@objcMembers class Requires: NSObject, Codable {
    let requires: Int

    enum CodingKeys: String, CodingKey {
        case requires = "requires"
    }

    init(requires: Int) {
        self.requires = requires
    }
}

// MARK: Requires convenience initializers and mutators

extension Requires {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Requires.self, from: data)
        self.init(requires: me.requires)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        requires: Int? = nil
    ) -> Requires {
        return Requires(
            requires: requires ?? self.requires
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Restrict
@objcMembers class Restrict: NSObject, Codable {
    let restrict: Int

    enum CodingKeys: String, CodingKey {
        case restrict = "restrict"
    }

    init(restrict: Int) {
        self.restrict = restrict
    }
}

// MARK: Restrict convenience initializers and mutators

extension Restrict {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Restrict.self, from: data)
        self.init(restrict: me.restrict)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        restrict: Int? = nil
    ) -> Restrict {
        return Restrict(
            restrict: restrict ?? self.restrict
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - RuntimeType
@objcMembers class RuntimeType: NSObject, Codable {
    let runtimeType: Int

    enum CodingKeys: String, CodingKey {
        case runtimeType = "runtimeType"
    }

    init(runtimeType: Int) {
        self.runtimeType = runtimeType
    }
}

// MARK: RuntimeType convenience initializers and mutators

extension RuntimeType {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(RuntimeType.self, from: data)
        self.init(runtimeType: me.runtimeType)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        runtimeType: Int? = nil
    ) -> RuntimeType {
        return RuntimeType(
            runtimeType: runtimeType ?? self.runtimeType
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - S
@objcMembers class S: NSObject, Codable {
    let s: Int

    enum CodingKeys: String, CodingKey {
        case s = "s"
    }

    init(s: Int) {
        self.s = s
    }
}

// MARK: S convenience initializers and mutators

extension S {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(S.self, from: data)
        self.init(s: me.s)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        s: Int? = nil
    ) -> S {
        return S(
            s: s ?? self.s
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Sbyte
@objcMembers class Sbyte: NSObject, Codable {
    let sbyte: Int

    enum CodingKeys: String, CodingKey {
        case sbyte = "sbyte"
    }

    init(sbyte: Int) {
        self.sbyte = sbyte
    }
}

// MARK: Sbyte convenience initializers and mutators

extension Sbyte {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Sbyte.self, from: data)
        self.init(sbyte: me.sbyte)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        sbyte: Int? = nil
    ) -> Sbyte {
        return Sbyte(
            sbyte: sbyte ?? self.sbyte
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Sealed
@objcMembers class Sealed: NSObject, Codable {
    let sealed: Int

    enum CodingKeys: String, CodingKey {
        case sealed = "sealed"
    }

    init(sealed: Int) {
        self.sealed = sealed
    }
}

// MARK: Sealed convenience initializers and mutators

extension Sealed {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Sealed.self, from: data)
        self.init(sealed: me.sealed)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        sealed: Int? = nil
    ) -> Sealed {
        return Sealed(
            sealed: sealed ?? self.sealed
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Sel
@objcMembers class Sel: NSObject, Codable {
    let sel: Int

    enum CodingKeys: String, CodingKey {
        case sel = "SEL"
    }

    init(sel: Int) {
        self.sel = sel
    }
}

// MARK: Sel convenience initializers and mutators

extension Sel {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Sel.self, from: data)
        self.init(sel: me.sel)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        sel: Int? = nil
    ) -> Sel {
        return Sel(
            sel: sel ?? self.sel
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Select
@objcMembers class Select: NSObject, Codable {
    let select: Int

    enum CodingKeys: String, CodingKey {
        case select = "select"
    }

    init(select: Int) {
        self.select = select
    }
}

// MARK: Select convenience initializers and mutators

extension Select {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Select.self, from: data)
        self.init(select: me.select)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        select: Int? = nil
    ) -> Select {
        return Select(
            select: select ?? self.select
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Sendable
@objcMembers class Sendable: NSObject, Codable {
    let sendable: Int

    enum CodingKeys: String, CodingKey {
        case sendable = "Sendable"
    }

    init(sendable: Int) {
        self.sendable = sendable
    }
}

// MARK: Sendable convenience initializers and mutators

extension Sendable {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Sendable.self, from: data)
        self.init(sendable: me.sendable)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        sendable: Int? = nil
    ) -> Sendable {
        return Sendable(
            sendable: sendable ?? self.sendable
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - SerialDescriptor
@objcMembers class SerialDescriptor: NSObject, Codable {
    let serialDescriptor: Int

    enum CodingKeys: String, CodingKey {
        case serialDescriptor = "SerialDescriptor"
    }

    init(serialDescriptor: Int) {
        self.serialDescriptor = serialDescriptor
    }
}

// MARK: SerialDescriptor convenience initializers and mutators

extension SerialDescriptor {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(SerialDescriptor.self, from: data)
        self.init(serialDescriptor: me.serialDescriptor)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        serialDescriptor: Int? = nil
    ) -> SerialDescriptor {
        return SerialDescriptor(
            serialDescriptor: serialDescriptor ?? self.serialDescriptor
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - SerialName
@objcMembers class SerialName: NSObject, Codable {
    let serialName: Int

    enum CodingKeys: String, CodingKey {
        case serialName = "SerialName"
    }

    init(serialName: Int) {
        self.serialName = serialName
    }
}

// MARK: SerialName convenience initializers and mutators

extension SerialName {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(SerialName.self, from: data)
        self.init(serialName: me.serialName)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        serialName: Int? = nil
    ) -> SerialName {
        return SerialName(
            serialName: serialName ?? self.serialName
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Serializable
@objcMembers class Serializable: NSObject, Codable {
    let serializable: Int

    enum CodingKeys: String, CodingKey {
        case serializable = "Serializable"
    }

    init(serializable: Int) {
        self.serializable = serializable
    }
}

// MARK: Serializable convenience initializers and mutators

extension Serializable {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Serializable.self, from: data)
        self.init(serializable: me.serializable)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        serializable: Int? = nil
    ) -> Serializable {
        return Serializable(
            serializable: serializable ?? self.serializable
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - SerializationFeature
@objcMembers class SerializationFeature: NSObject, Codable {
    let serializationFeature: Int

    enum CodingKeys: String, CodingKey {
        case serializationFeature = "SerializationFeature"
    }

    init(serializationFeature: Int) {
        self.serializationFeature = serializationFeature
    }
}

// MARK: SerializationFeature convenience initializers and mutators

extension SerializationFeature {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(SerializationFeature.self, from: data)
        self.init(serializationFeature: me.serializationFeature)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        serializationFeature: Int? = nil
    ) -> SerializationFeature {
        return SerializationFeature(
            serializationFeature: serializationFeature ?? self.serializationFeature
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Serialize
@objcMembers class Serialize: NSObject, Codable {
    let serialize: Int

    enum CodingKeys: String, CodingKey {
        case serialize = "serialize"
    }

    init(serialize: Int) {
        self.serialize = serialize
    }
}

// MARK: Serialize convenience initializers and mutators

extension Serialize {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Serialize.self, from: data)
        self.init(serialize: me.serialize)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        serialize: Int? = nil
    ) -> Serialize {
        return Serialize(
            serialize: serialize ?? self.serialize
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - SerializerProvider
@objcMembers class SerializerProvider: NSObject, Codable {
    let serializerProvider: Int

    enum CodingKeys: String, CodingKey {
        case serializerProvider = "SerializerProvider"
    }

    init(serializerProvider: Int) {
        self.serializerProvider = serializerProvider
    }
}

// MARK: SerializerProvider convenience initializers and mutators

extension SerializerProvider {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(SerializerProvider.self, from: data)
        self.init(serializerProvider: me.serializerProvider)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        serializerProvider: Int? = nil
    ) -> SerializerProvider {
        return SerializerProvider(
            serializerProvider: serializerProvider ?? self.serializerProvider
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Short
@objcMembers class Short: NSObject, Codable {
    let short: Int

    enum CodingKeys: String, CodingKey {
        case short = "short"
    }

    init(short: Int) {
        self.short = short
    }
}

// MARK: Short convenience initializers and mutators

extension Short {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Short.self, from: data)
        self.init(short: me.short)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        short: Int? = nil
    ) -> Short {
        return Short(
            short: short ?? self.short
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Signed
@objcMembers class Signed: NSObject, Codable {
    let signed: Int

    enum CodingKeys: String, CodingKey {
        case signed = "signed"
    }

    init(signed: Int) {
        self.signed = signed
    }
}

// MARK: Signed convenience initializers and mutators

extension Signed {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Signed.self, from: data)
        self.init(signed: me.signed)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        signed: Int? = nil
    ) -> Signed {
        return Signed(
            signed: signed ?? self.signed
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - SimpleModule
@objcMembers class SimpleModule: NSObject, Codable {
    let simpleModule: Int

    enum CodingKeys: String, CodingKey {
        case simpleModule = "SimpleModule"
    }

    init(simpleModule: Int) {
        self.simpleModule = simpleModule
    }
}

// MARK: SimpleModule convenience initializers and mutators

extension SimpleModule {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(SimpleModule.self, from: data)
        self.init(simpleModule: me.simpleModule)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        simpleModule: Int? = nil
    ) -> SimpleModule {
        return SimpleModule(
            simpleModule: simpleModule ?? self.simpleModule
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Sizeof
@objcMembers class Sizeof: NSObject, Codable {
    let sizeof: Int

    enum CodingKeys: String, CodingKey {
        case sizeof = "sizeof"
    }

    init(sizeof: Int) {
        self.sizeof = sizeof
    }
}

// MARK: Sizeof convenience initializers and mutators

extension Sizeof {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Sizeof.self, from: data)
        self.init(sizeof: me.sizeof)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        sizeof: Int? = nil
    ) -> Sizeof {
        return Sizeof(
            sizeof: sizeof ?? self.sizeof
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Stackalloc
@objcMembers class Stackalloc: NSObject, Codable {
    let stackalloc: Int

    enum CodingKeys: String, CodingKey {
        case stackalloc = "stackalloc"
    }

    init(stackalloc: Int) {
        self.stackalloc = stackalloc
    }
}

// MARK: Stackalloc convenience initializers and mutators

extension Stackalloc {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Stackalloc.self, from: data)
        self.init(stackalloc: me.stackalloc)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        stackalloc: Int? = nil
    ) -> Stackalloc {
        return Stackalloc(
            stackalloc: stackalloc ?? self.stackalloc
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Standards
@objcMembers class Standards: NSObject, Codable {
    let standards: Int

    enum CodingKeys: String, CodingKey {
        case standards = "Standards"
    }

    init(standards: Int) {
        self.standards = standards
    }
}

// MARK: Standards convenience initializers and mutators

extension Standards {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Standards.self, from: data)
        self.init(standards: me.standards)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        standards: Int? = nil
    ) -> Standards {
        return Standards(
            standards: standards ?? self.standards
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - StaticAssert
@objcMembers class StaticAssert: NSObject, Codable {
    let staticAssert: Int

    enum CodingKeys: String, CodingKey {
        case staticAssert = "static_assert"
    }

    init(staticAssert: Int) {
        self.staticAssert = staticAssert
    }
}

// MARK: StaticAssert convenience initializers and mutators

extension StaticAssert {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(StaticAssert.self, from: data)
        self.init(staticAssert: me.staticAssert)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        staticAssert: Int? = nil
    ) -> StaticAssert {
        return StaticAssert(
            staticAssert: staticAssert ?? self.staticAssert
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - StaticCast
@objcMembers class StaticCast: NSObject, Codable {
    let staticCast: Int

    enum CodingKeys: String, CodingKey {
        case staticCast = "static_cast"
    }

    init(staticCast: Int) {
        self.staticCast = staticCast
    }
}

// MARK: StaticCast convenience initializers and mutators

extension StaticCast {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(StaticCast.self, from: data)
        self.init(staticCast: me.staticCast)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        staticCast: Int? = nil
    ) -> StaticCast {
        return StaticCast(
            staticCast: staticCast ?? self.staticCast
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - StdDeserializer
@objcMembers class StdDeserializer: NSObject, Codable {
    let stdDeserializer: Int

    enum CodingKeys: String, CodingKey {
        case stdDeserializer = "StdDeserializer"
    }

    init(stdDeserializer: Int) {
        self.stdDeserializer = stdDeserializer
    }
}

// MARK: StdDeserializer convenience initializers and mutators

extension StdDeserializer {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(StdDeserializer.self, from: data)
        self.init(stdDeserializer: me.stdDeserializer)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        stdDeserializer: Int? = nil
    ) -> StdDeserializer {
        return StdDeserializer(
            stdDeserializer: stdDeserializer ?? self.stdDeserializer
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - StdSerializer
@objcMembers class StdSerializer: NSObject, Codable {
    let stdSerializer: Int

    enum CodingKeys: String, CodingKey {
        case stdSerializer = "StdSerializer"
    }

    init(stdSerializer: Int) {
        self.stdSerializer = stdSerializer
    }
}

// MARK: StdSerializer convenience initializers and mutators

extension StdSerializer {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(StdSerializer.self, from: data)
        self.init(stdSerializer: me.stdSerializer)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        stdSerializer: Int? = nil
    ) -> StdSerializer {
        return StdSerializer(
            stdSerializer: stdSerializer ?? self.stdSerializer
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Strictfp
@objcMembers class Strictfp: NSObject, Codable {
    let strictfp: Int

    enum CodingKeys: String, CodingKey {
        case strictfp = "strictfp"
    }

    init(strictfp: Int) {
        self.strictfp = strictfp
    }
}

// MARK: Strictfp convenience initializers and mutators

extension Strictfp {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Strictfp.self, from: data)
        self.init(strictfp: me.strictfp)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        strictfp: Int? = nil
    ) -> Strictfp {
        return Strictfp(
            strictfp: strictfp ?? self.strictfp
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - StringClass
@objcMembers class StringClass: NSObject, Codable {
    let string: Int

    enum CodingKeys: String, CodingKey {
        case string = "string"
    }

    init(string: Int) {
        self.string = string
    }
}

// MARK: StringClass convenience initializers and mutators

extension StringClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(StringClass.self, from: data)
        self.init(string: me.string)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        string: Int? = nil
    ) -> StringClass {
        return StringClass(
            string: string ?? self.string
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Symbol
@objcMembers class Symbol: NSObject, Codable {
    let symbol: Int

    enum CodingKeys: String, CodingKey {
        case symbol = "symbol"
    }

    init(symbol: Int) {
        self.symbol = symbol
    }
}

// MARK: Symbol convenience initializers and mutators

extension Symbol {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Symbol.self, from: data)
        self.init(symbol: me.symbol)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        symbol: Int? = nil
    ) -> Symbol {
        return Symbol(
            symbol: symbol ?? self.symbol
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Synchronized
@objcMembers class Synchronized: NSObject, Codable {
    let synchronized: Int

    enum CodingKeys: String, CodingKey {
        case synchronized = "synchronized"
    }

    init(synchronized: Int) {
        self.synchronized = synchronized
    }
}

// MARK: Synchronized convenience initializers and mutators

extension Synchronized {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Synchronized.self, from: data)
        self.init(synchronized: me.synchronized)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        synchronized: Int? = nil
    ) -> Synchronized {
        return Synchronized(
            synchronized: synchronized ?? self.synchronized
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - System
@objcMembers class System: NSObject, Codable {
    let system: Int

    enum CodingKeys: String, CodingKey {
        case system = "system"
    }

    init(system: Int) {
        self.system = system
    }
}

// MARK: System convenience initializers and mutators

extension System {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(System.self, from: data)
        self.init(system: me.system)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        system: Int? = nil
    ) -> System {
        return System(
            system: system ?? self.system
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Template
@objcMembers class Template: NSObject, Codable {
    let template: Int

    enum CodingKeys: String, CodingKey {
        case template = "template"
    }

    init(template: Int) {
        self.template = template
    }
}

// MARK: Template convenience initializers and mutators

extension Template {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Template.self, from: data)
        self.init(template: me.template)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        template: Int? = nil
    ) -> Template {
        return Template(
            template: template ?? self.template
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - TextNode
@objcMembers class TextNode: NSObject, Codable {
    let textNode: Int

    enum CodingKeys: String, CodingKey {
        case textNode = "TextNode"
    }

    init(textNode: Int) {
        self.textNode = textNode
    }
}

// MARK: TextNode convenience initializers and mutators

extension TextNode {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(TextNode.self, from: data)
        self.init(textNode: me.textNode)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        textNode: Int? = nil
    ) -> TextNode {
        return TextNode(
            textNode: textNode ?? self.textNode
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Then
@objcMembers class Then: NSObject, Codable {
    let then: Int

    enum CodingKeys: String, CodingKey {
        case then = "then"
    }

    init(then: Int) {
        self.then = then
    }
}

// MARK: Then convenience initializers and mutators

extension Then {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Then.self, from: data)
        self.init(then: me.then)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        then: Int? = nil
    ) -> Then {
        return Then(
            then: then ?? self.then
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - This
@objcMembers class This: NSObject, Codable {
    let this: Int

    enum CodingKeys: String, CodingKey {
        case this = "this"
    }

    init(this: Int) {
        self.this = this
    }
}

// MARK: This convenience initializers and mutators

extension This {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(This.self, from: data)
        self.init(this: me.this)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        this: Int? = nil
    ) -> This {
        return This(
            this: this ?? self.this
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ThreadLocal
@objcMembers class ThreadLocal: NSObject, Codable {
    let threadLocal: Int

    enum CodingKeys: String, CodingKey {
        case threadLocal = "thread_local"
    }

    init(threadLocal: Int) {
        self.threadLocal = threadLocal
    }
}

// MARK: ThreadLocal convenience initializers and mutators

extension ThreadLocal {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ThreadLocal.self, from: data)
        self.init(threadLocal: me.threadLocal)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        threadLocal: Int? = nil
    ) -> ThreadLocal {
        return ThreadLocal(
            threadLocal: threadLocal ?? self.threadLocal
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - TimeOnly
@objcMembers class TimeOnly: NSObject, Codable {
    let timeOnly: Int

    enum CodingKeys: String, CodingKey {
        case timeOnly = "TimeOnly"
    }

    init(timeOnly: Int) {
        self.timeOnly = timeOnly
    }
}

// MARK: TimeOnly convenience initializers and mutators

extension TimeOnly {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(TimeOnly.self, from: data)
        self.init(timeOnly: me.timeOnly)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        timeOnly: Int? = nil
    ) -> TimeOnly {
        return TimeOnly(
            timeOnly: timeOnly ?? self.timeOnly
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - TimeOnlyConverter
@objcMembers class TimeOnlyConverter: NSObject, Codable {
    let timeOnlyConverter: Int

    enum CodingKeys: String, CodingKey {
        case timeOnlyConverter = "TimeOnlyConverter"
    }

    init(timeOnlyConverter: Int) {
        self.timeOnlyConverter = timeOnlyConverter
    }
}

// MARK: TimeOnlyConverter convenience initializers and mutators

extension TimeOnlyConverter {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(TimeOnlyConverter.self, from: data)
        self.init(timeOnlyConverter: me.timeOnlyConverter)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        timeOnlyConverter: Int? = nil
    ) -> TimeOnlyConverter {
        return TimeOnlyConverter(
            timeOnlyConverter: timeOnlyConverter ?? self.timeOnlyConverter
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - TimeZoneClass
@objcMembers class TimeZoneClass: NSObject, Codable {
    let timeZone: Int

    enum CodingKeys: String, CodingKey {
        case timeZone = "TimeZone"
    }

    init(timeZone: Int) {
        self.timeZone = timeZone
    }
}

// MARK: TimeZoneClass convenience initializers and mutators

extension TimeZoneClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(TimeZoneClass.self, from: data)
        self.init(timeZone: me.timeZone)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        timeZone: Int? = nil
    ) -> TimeZoneClass {
        return TimeZoneClass(
            timeZone: timeZone ?? self.timeZone
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ToDict
@objcMembers class ToDict: NSObject, Codable {
    let toDict: Int

    enum CodingKeys: String, CodingKey {
        case toDict = "to_dict"
    }

    init(toDict: Int) {
        self.toDict = toDict
    }
}

// MARK: ToDict convenience initializers and mutators

extension ToDict {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ToDict.self, from: data)
        self.init(toDict: me.toDict)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        toDict: Int? = nil
    ) -> ToDict {
        return ToDict(
            toDict: toDict ?? self.toDict
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ToJSON
@objcMembers class ToJSON: NSObject, Codable {
    let toJSON: Int

    enum CodingKeys: String, CodingKey {
        case toJSON = "to_json"
    }

    init(toJSON: Int) {
        self.toJSON = toJSON
    }
}

// MARK: ToJSON convenience initializers and mutators

extension ToJSON {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ToJSON.self, from: data)
        self.init(toJSON: me.toJSON)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        toJSON: Int? = nil
    ) -> ToJSON {
        return ToJSON(
            toJSON: toJSON ?? self.toJSON
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ToString
@objcMembers class ToString: NSObject, Codable {
    let toString: Int

    enum CodingKeys: String, CodingKey {
        case toString = "toString"
    }

    init(toString: Int) {
        self.toString = toString
    }
}

// MARK: ToString convenience initializers and mutators

extension ToString {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ToString.self, from: data)
        self.init(toString: me.toString)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        toString: Int? = nil
    ) -> ToString {
        return ToString(
            toString: toString ?? self.toString
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - TopLevelClass
@objcMembers class TopLevelClass: NSObject, Codable {
    let topLevel: Int

    enum CodingKeys: String, CodingKey {
        case topLevel = "top_level"
    }

    init(topLevel: Int) {
        self.topLevel = topLevel
    }
}

// MARK: TopLevelClass convenience initializers and mutators

extension TopLevelClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(TopLevelClass.self, from: data)
        self.init(topLevel: me.topLevel)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        topLevel: Int? = nil
    ) -> TopLevelClass {
        return TopLevelClass(
            topLevel: topLevel ?? self.topLevel
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Transient
@objcMembers class Transient: NSObject, Codable {
    let transient: Int

    enum CodingKeys: String, CodingKey {
        case transient = "transient"
    }

    init(transient: Int) {
        self.transient = transient
    }
}

// MARK: Transient convenience initializers and mutators

extension Transient {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Transient.self, from: data)
        self.init(transient: me.transient)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        transient: Int? = nil
    ) -> Transient {
        return Transient(
            transient: transient ?? self.transient
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Obj6
@objcMembers class Obj6: NSObject, Codable {
    let dummy: Int
    let obj6Try: Try
    let obj6Type: Obj6Type
    let obj6Typealias: Typealias
    let obj6Unowned: Unowned
    let obj6Var: Var
    let obj6Weak: Weak
    let obj6Where: Where
    let obj6While: While
    let obj6WillSet: WillSet
    let type: TypeClass
    let typedef: Typedef
    let typeid: Typeid
    let typename: Typename
    let typeof: Typeof
    let uint: Uint
    let ulong: Ulong
    let unchecked: Unchecked
    let undefined: Undefined
    let union: Union
    let unmarshalJSON: UnmarshalJSON
    let unsafe: Unsafe
    let unsigned: Unsigned
    let useSerializers: UseSerializers
    let ushort: Ushort
    let using: Using
    let utf8JSONReader: Utf8JSONReader
    let utf8JSONWriter: Utf8JSONWriter
    let uuid: UUIDClass
    let virtual: Virtual
    let void: Void
    let volatile: Volatile
    let wcharT: WcharT
    let with: With
    let xor: Xor
    let xorEq: XorEq
    let yes: Yes
    let yield: Yield

    enum CodingKeys: String, CodingKey {
        case dummy = "dummy"
        case obj6Try = "try"
        case obj6Type = "type"
        case obj6Typealias = "typealias"
        case obj6Unowned = "unowned"
        case obj6Var = "var"
        case obj6Weak = "weak"
        case obj6Where = "where"
        case obj6While = "while"
        case obj6WillSet = "willSet"
        case type = "Type"
        case typedef = "typedef"
        case typeid = "typeid"
        case typename = "typename"
        case typeof = "typeof"
        case uint = "uint"
        case ulong = "ulong"
        case unchecked = "unchecked"
        case undefined = "undefined"
        case union = "union"
        case unmarshalJSON = "UnmarshalJSON"
        case unsafe = "unsafe"
        case unsigned = "unsigned"
        case useSerializers = "UseSerializers"
        case ushort = "ushort"
        case using = "using"
        case utf8JSONReader = "Utf8JsonReader"
        case utf8JSONWriter = "Utf8JsonWriter"
        case uuid = "UUID"
        case virtual = "virtual"
        case void = "void"
        case volatile = "volatile"
        case wcharT = "wchar_t"
        case with = "with"
        case xor = "xor"
        case xorEq = "xor_eq"
        case yes = "YES"
        case yield = "yield"
    }

    init(dummy: Int, obj6Try: Try, obj6Type: Obj6Type, obj6Typealias: Typealias, obj6Unowned: Unowned, obj6Var: Var, obj6Weak: Weak, obj6Where: Where, obj6While: While, obj6WillSet: WillSet, type: TypeClass, typedef: Typedef, typeid: Typeid, typename: Typename, typeof: Typeof, uint: Uint, ulong: Ulong, unchecked: Unchecked, undefined: Undefined, union: Union, unmarshalJSON: UnmarshalJSON, unsafe: Unsafe, unsigned: Unsigned, useSerializers: UseSerializers, ushort: Ushort, using: Using, utf8JSONReader: Utf8JSONReader, utf8JSONWriter: Utf8JSONWriter, uuid: UUIDClass, virtual: Virtual, void: Void, volatile: Volatile, wcharT: WcharT, with: With, xor: Xor, xorEq: XorEq, yes: Yes, yield: Yield) {
        self.dummy = dummy
        self.obj6Try = obj6Try
        self.obj6Type = obj6Type
        self.obj6Typealias = obj6Typealias
        self.obj6Unowned = obj6Unowned
        self.obj6Var = obj6Var
        self.obj6Weak = obj6Weak
        self.obj6Where = obj6Where
        self.obj6While = obj6While
        self.obj6WillSet = obj6WillSet
        self.type = type
        self.typedef = typedef
        self.typeid = typeid
        self.typename = typename
        self.typeof = typeof
        self.uint = uint
        self.ulong = ulong
        self.unchecked = unchecked
        self.undefined = undefined
        self.union = union
        self.unmarshalJSON = unmarshalJSON
        self.unsafe = unsafe
        self.unsigned = unsigned
        self.useSerializers = useSerializers
        self.ushort = ushort
        self.using = using
        self.utf8JSONReader = utf8JSONReader
        self.utf8JSONWriter = utf8JSONWriter
        self.uuid = uuid
        self.virtual = virtual
        self.void = void
        self.volatile = volatile
        self.wcharT = wcharT
        self.with = with
        self.xor = xor
        self.xorEq = xorEq
        self.yes = yes
        self.yield = yield
    }
}

// MARK: Obj6 convenience initializers and mutators

extension Obj6 {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Obj6.self, from: data)
        self.init(dummy: me.dummy, obj6Try: me.obj6Try, obj6Type: me.obj6Type, obj6Typealias: me.obj6Typealias, obj6Unowned: me.obj6Unowned, obj6Var: me.obj6Var, obj6Weak: me.obj6Weak, obj6Where: me.obj6Where, obj6While: me.obj6While, obj6WillSet: me.obj6WillSet, type: me.type, typedef: me.typedef, typeid: me.typeid, typename: me.typename, typeof: me.typeof, uint: me.uint, ulong: me.ulong, unchecked: me.unchecked, undefined: me.undefined, union: me.union, unmarshalJSON: me.unmarshalJSON, unsafe: me.unsafe, unsigned: me.unsigned, useSerializers: me.useSerializers, ushort: me.ushort, using: me.using, utf8JSONReader: me.utf8JSONReader, utf8JSONWriter: me.utf8JSONWriter, uuid: me.uuid, virtual: me.virtual, void: me.void, volatile: me.volatile, wcharT: me.wcharT, with: me.with, xor: me.xor, xorEq: me.xorEq, yes: me.yes, yield: me.yield)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        dummy: Int? = nil,
        obj6Try: Try? = nil,
        obj6Type: Obj6Type? = nil,
        obj6Typealias: Typealias? = nil,
        obj6Unowned: Unowned? = nil,
        obj6Var: Var? = nil,
        obj6Weak: Weak? = nil,
        obj6Where: Where? = nil,
        obj6While: While? = nil,
        obj6WillSet: WillSet? = nil,
        type: TypeClass? = nil,
        typedef: Typedef? = nil,
        typeid: Typeid? = nil,
        typename: Typename? = nil,
        typeof: Typeof? = nil,
        uint: Uint? = nil,
        ulong: Ulong? = nil,
        unchecked: Unchecked? = nil,
        undefined: Undefined? = nil,
        union: Union? = nil,
        unmarshalJSON: UnmarshalJSON? = nil,
        unsafe: Unsafe? = nil,
        unsigned: Unsigned? = nil,
        useSerializers: UseSerializers? = nil,
        ushort: Ushort? = nil,
        using: Using? = nil,
        utf8JSONReader: Utf8JSONReader? = nil,
        utf8JSONWriter: Utf8JSONWriter? = nil,
        uuid: UUIDClass? = nil,
        virtual: Virtual? = nil,
        void: Void? = nil,
        volatile: Volatile? = nil,
        wcharT: WcharT? = nil,
        with: With? = nil,
        xor: Xor? = nil,
        xorEq: XorEq? = nil,
        yes: Yes? = nil,
        yield: Yield? = nil
    ) -> Obj6 {
        return Obj6(
            dummy: dummy ?? self.dummy,
            obj6Try: obj6Try ?? self.obj6Try,
            obj6Type: obj6Type ?? self.obj6Type,
            obj6Typealias: obj6Typealias ?? self.obj6Typealias,
            obj6Unowned: obj6Unowned ?? self.obj6Unowned,
            obj6Var: obj6Var ?? self.obj6Var,
            obj6Weak: obj6Weak ?? self.obj6Weak,
            obj6Where: obj6Where ?? self.obj6Where,
            obj6While: obj6While ?? self.obj6While,
            obj6WillSet: obj6WillSet ?? self.obj6WillSet,
            type: type ?? self.type,
            typedef: typedef ?? self.typedef,
            typeid: typeid ?? self.typeid,
            typename: typename ?? self.typename,
            typeof: typeof ?? self.typeof,
            uint: uint ?? self.uint,
            ulong: ulong ?? self.ulong,
            unchecked: unchecked ?? self.unchecked,
            undefined: undefined ?? self.undefined,
            union: union ?? self.union,
            unmarshalJSON: unmarshalJSON ?? self.unmarshalJSON,
            unsafe: unsafe ?? self.unsafe,
            unsigned: unsigned ?? self.unsigned,
            useSerializers: useSerializers ?? self.useSerializers,
            ushort: ushort ?? self.ushort,
            using: using ?? self.using,
            utf8JSONReader: utf8JSONReader ?? self.utf8JSONReader,
            utf8JSONWriter: utf8JSONWriter ?? self.utf8JSONWriter,
            uuid: uuid ?? self.uuid,
            virtual: virtual ?? self.virtual,
            void: void ?? self.void,
            volatile: volatile ?? self.volatile,
            wcharT: wcharT ?? self.wcharT,
            with: with ?? self.with,
            xor: xor ?? self.xor,
            xorEq: xorEq ?? self.xorEq,
            yes: yes ?? self.yes,
            yield: yield ?? self.yield
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Try
@objcMembers class Try: NSObject, Codable {
    let tryTry: Int

    enum CodingKeys: String, CodingKey {
        case tryTry = "try"
    }

    init(tryTry: Int) {
        self.tryTry = tryTry
    }
}

// MARK: Try convenience initializers and mutators

extension Try {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Try.self, from: data)
        self.init(tryTry: me.tryTry)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        tryTry: Int? = nil
    ) -> Try {
        return Try(
            tryTry: tryTry ?? self.tryTry
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Obj6Type
@objcMembers class Obj6Type: NSObject, Codable {
    let type: Int

    enum CodingKeys: String, CodingKey {
        case type = "type"
    }

    init(type: Int) {
        self.type = type
    }
}

// MARK: Obj6Type convenience initializers and mutators

extension Obj6Type {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Obj6Type.self, from: data)
        self.init(type: me.type)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        type: Int? = nil
    ) -> Obj6Type {
        return Obj6Type(
            type: type ?? self.type
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Typealias
@objcMembers class Typealias: NSObject, Codable {
    let typealiasTypealias: Int

    enum CodingKeys: String, CodingKey {
        case typealiasTypealias = "typealias"
    }

    init(typealiasTypealias: Int) {
        self.typealiasTypealias = typealiasTypealias
    }
}

// MARK: Typealias convenience initializers and mutators

extension Typealias {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Typealias.self, from: data)
        self.init(typealiasTypealias: me.typealiasTypealias)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        typealiasTypealias: Int? = nil
    ) -> Typealias {
        return Typealias(
            typealiasTypealias: typealiasTypealias ?? self.typealiasTypealias
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Unowned
@objcMembers class Unowned: NSObject, Codable {
    let unownedUnowned: Int

    enum CodingKeys: String, CodingKey {
        case unownedUnowned = "unowned"
    }

    init(unownedUnowned: Int) {
        self.unownedUnowned = unownedUnowned
    }
}

// MARK: Unowned convenience initializers and mutators

extension Unowned {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Unowned.self, from: data)
        self.init(unownedUnowned: me.unownedUnowned)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        unownedUnowned: Int? = nil
    ) -> Unowned {
        return Unowned(
            unownedUnowned: unownedUnowned ?? self.unownedUnowned
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Var
@objcMembers class Var: NSObject, Codable {
    let varVar: Int

    enum CodingKeys: String, CodingKey {
        case varVar = "var"
    }

    init(varVar: Int) {
        self.varVar = varVar
    }
}

// MARK: Var convenience initializers and mutators

extension Var {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Var.self, from: data)
        self.init(varVar: me.varVar)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        varVar: Int? = nil
    ) -> Var {
        return Var(
            varVar: varVar ?? self.varVar
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Weak
@objcMembers class Weak: NSObject, Codable {
    let weakWeak: Int

    enum CodingKeys: String, CodingKey {
        case weakWeak = "weak"
    }

    init(weakWeak: Int) {
        self.weakWeak = weakWeak
    }
}

// MARK: Weak convenience initializers and mutators

extension Weak {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Weak.self, from: data)
        self.init(weakWeak: me.weakWeak)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        weakWeak: Int? = nil
    ) -> Weak {
        return Weak(
            weakWeak: weakWeak ?? self.weakWeak
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Where
@objcMembers class Where: NSObject, Codable {
    let whereWhere: Int

    enum CodingKeys: String, CodingKey {
        case whereWhere = "where"
    }

    init(whereWhere: Int) {
        self.whereWhere = whereWhere
    }
}

// MARK: Where convenience initializers and mutators

extension Where {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Where.self, from: data)
        self.init(whereWhere: me.whereWhere)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        whereWhere: Int? = nil
    ) -> Where {
        return Where(
            whereWhere: whereWhere ?? self.whereWhere
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - While
@objcMembers class While: NSObject, Codable {
    let whileWhile: Int

    enum CodingKeys: String, CodingKey {
        case whileWhile = "while"
    }

    init(whileWhile: Int) {
        self.whileWhile = whileWhile
    }
}

// MARK: While convenience initializers and mutators

extension While {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(While.self, from: data)
        self.init(whileWhile: me.whileWhile)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        whileWhile: Int? = nil
    ) -> While {
        return While(
            whileWhile: whileWhile ?? self.whileWhile
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - WillSet
@objcMembers class WillSet: NSObject, Codable {
    let willSetWillSet: Int

    enum CodingKeys: String, CodingKey {
        case willSetWillSet = "willSet"
    }

    init(willSetWillSet: Int) {
        self.willSetWillSet = willSetWillSet
    }
}

// MARK: WillSet convenience initializers and mutators

extension WillSet {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(WillSet.self, from: data)
        self.init(willSetWillSet: me.willSetWillSet)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        willSetWillSet: Int? = nil
    ) -> WillSet {
        return WillSet(
            willSetWillSet: willSetWillSet ?? self.willSetWillSet
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - TypeClass
@objcMembers class TypeClass: NSObject, Codable {
    let type: Int

    enum CodingKeys: String, CodingKey {
        case type = "Type"
    }

    init(type: Int) {
        self.type = type
    }
}

// MARK: TypeClass convenience initializers and mutators

extension TypeClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(TypeClass.self, from: data)
        self.init(type: me.type)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        type: Int? = nil
    ) -> TypeClass {
        return TypeClass(
            type: type ?? self.type
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Typedef
@objcMembers class Typedef: NSObject, Codable {
    let typedef: Int

    enum CodingKeys: String, CodingKey {
        case typedef = "typedef"
    }

    init(typedef: Int) {
        self.typedef = typedef
    }
}

// MARK: Typedef convenience initializers and mutators

extension Typedef {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Typedef.self, from: data)
        self.init(typedef: me.typedef)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        typedef: Int? = nil
    ) -> Typedef {
        return Typedef(
            typedef: typedef ?? self.typedef
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Typeid
@objcMembers class Typeid: NSObject, Codable {
    let typeid: Int

    enum CodingKeys: String, CodingKey {
        case typeid = "typeid"
    }

    init(typeid: Int) {
        self.typeid = typeid
    }
}

// MARK: Typeid convenience initializers and mutators

extension Typeid {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Typeid.self, from: data)
        self.init(typeid: me.typeid)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        typeid: Int? = nil
    ) -> Typeid {
        return Typeid(
            typeid: typeid ?? self.typeid
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Typename
@objcMembers class Typename: NSObject, Codable {
    let typename: Int

    enum CodingKeys: String, CodingKey {
        case typename = "typename"
    }

    init(typename: Int) {
        self.typename = typename
    }
}

// MARK: Typename convenience initializers and mutators

extension Typename {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Typename.self, from: data)
        self.init(typename: me.typename)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        typename: Int? = nil
    ) -> Typename {
        return Typename(
            typename: typename ?? self.typename
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Typeof
@objcMembers class Typeof: NSObject, Codable {
    let typeof: Int

    enum CodingKeys: String, CodingKey {
        case typeof = "typeof"
    }

    init(typeof: Int) {
        self.typeof = typeof
    }
}

// MARK: Typeof convenience initializers and mutators

extension Typeof {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Typeof.self, from: data)
        self.init(typeof: me.typeof)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        typeof: Int? = nil
    ) -> Typeof {
        return Typeof(
            typeof: typeof ?? self.typeof
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Uint
@objcMembers class Uint: NSObject, Codable {
    let uint: Int

    enum CodingKeys: String, CodingKey {
        case uint = "uint"
    }

    init(uint: Int) {
        self.uint = uint
    }
}

// MARK: Uint convenience initializers and mutators

extension Uint {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Uint.self, from: data)
        self.init(uint: me.uint)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        uint: Int? = nil
    ) -> Uint {
        return Uint(
            uint: uint ?? self.uint
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Ulong
@objcMembers class Ulong: NSObject, Codable {
    let ulong: Int

    enum CodingKeys: String, CodingKey {
        case ulong = "ulong"
    }

    init(ulong: Int) {
        self.ulong = ulong
    }
}

// MARK: Ulong convenience initializers and mutators

extension Ulong {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Ulong.self, from: data)
        self.init(ulong: me.ulong)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        ulong: Int? = nil
    ) -> Ulong {
        return Ulong(
            ulong: ulong ?? self.ulong
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Unchecked
@objcMembers class Unchecked: NSObject, Codable {
    let unchecked: Int

    enum CodingKeys: String, CodingKey {
        case unchecked = "unchecked"
    }

    init(unchecked: Int) {
        self.unchecked = unchecked
    }
}

// MARK: Unchecked convenience initializers and mutators

extension Unchecked {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Unchecked.self, from: data)
        self.init(unchecked: me.unchecked)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        unchecked: Int? = nil
    ) -> Unchecked {
        return Unchecked(
            unchecked: unchecked ?? self.unchecked
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Undefined
@objcMembers class Undefined: NSObject, Codable {
    let undefined: Int

    enum CodingKeys: String, CodingKey {
        case undefined = "undefined"
    }

    init(undefined: Int) {
        self.undefined = undefined
    }
}

// MARK: Undefined convenience initializers and mutators

extension Undefined {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Undefined.self, from: data)
        self.init(undefined: me.undefined)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        undefined: Int? = nil
    ) -> Undefined {
        return Undefined(
            undefined: undefined ?? self.undefined
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Union
@objcMembers class Union: NSObject, Codable {
    let union: Int

    enum CodingKeys: String, CodingKey {
        case union = "union"
    }

    init(union: Int) {
        self.union = union
    }
}

// MARK: Union convenience initializers and mutators

extension Union {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Union.self, from: data)
        self.init(union: me.union)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        union: Int? = nil
    ) -> Union {
        return Union(
            union: union ?? self.union
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - UnmarshalJSON
@objcMembers class UnmarshalJSON: NSObject, Codable {
    let unmarshalJSON: Int

    enum CodingKeys: String, CodingKey {
        case unmarshalJSON = "UnmarshalJSON"
    }

    init(unmarshalJSON: Int) {
        self.unmarshalJSON = unmarshalJSON
    }
}

// MARK: UnmarshalJSON convenience initializers and mutators

extension UnmarshalJSON {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(UnmarshalJSON.self, from: data)
        self.init(unmarshalJSON: me.unmarshalJSON)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        unmarshalJSON: Int? = nil
    ) -> UnmarshalJSON {
        return UnmarshalJSON(
            unmarshalJSON: unmarshalJSON ?? self.unmarshalJSON
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Unsafe
@objcMembers class Unsafe: NSObject, Codable {
    let unsafe: Int

    enum CodingKeys: String, CodingKey {
        case unsafe = "unsafe"
    }

    init(unsafe: Int) {
        self.unsafe = unsafe
    }
}

// MARK: Unsafe convenience initializers and mutators

extension Unsafe {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Unsafe.self, from: data)
        self.init(unsafe: me.unsafe)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        unsafe: Int? = nil
    ) -> Unsafe {
        return Unsafe(
            unsafe: unsafe ?? self.unsafe
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Unsigned
@objcMembers class Unsigned: NSObject, Codable {
    let unsigned: Int

    enum CodingKeys: String, CodingKey {
        case unsigned = "unsigned"
    }

    init(unsigned: Int) {
        self.unsigned = unsigned
    }
}

// MARK: Unsigned convenience initializers and mutators

extension Unsigned {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Unsigned.self, from: data)
        self.init(unsigned: me.unsigned)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        unsigned: Int? = nil
    ) -> Unsigned {
        return Unsigned(
            unsigned: unsigned ?? self.unsigned
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - UseSerializers
@objcMembers class UseSerializers: NSObject, Codable {
    let useSerializers: Int

    enum CodingKeys: String, CodingKey {
        case useSerializers = "UseSerializers"
    }

    init(useSerializers: Int) {
        self.useSerializers = useSerializers
    }
}

// MARK: UseSerializers convenience initializers and mutators

extension UseSerializers {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(UseSerializers.self, from: data)
        self.init(useSerializers: me.useSerializers)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        useSerializers: Int? = nil
    ) -> UseSerializers {
        return UseSerializers(
            useSerializers: useSerializers ?? self.useSerializers
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Ushort
@objcMembers class Ushort: NSObject, Codable {
    let ushort: Int

    enum CodingKeys: String, CodingKey {
        case ushort = "ushort"
    }

    init(ushort: Int) {
        self.ushort = ushort
    }
}

// MARK: Ushort convenience initializers and mutators

extension Ushort {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Ushort.self, from: data)
        self.init(ushort: me.ushort)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        ushort: Int? = nil
    ) -> Ushort {
        return Ushort(
            ushort: ushort ?? self.ushort
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Using
@objcMembers class Using: NSObject, Codable {
    let using: Int

    enum CodingKeys: String, CodingKey {
        case using = "using"
    }

    init(using: Int) {
        self.using = using
    }
}

// MARK: Using convenience initializers and mutators

extension Using {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Using.self, from: data)
        self.init(using: me.using)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        using: Int? = nil
    ) -> Using {
        return Using(
            using: using ?? self.using
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Utf8JSONReader
@objcMembers class Utf8JSONReader: NSObject, Codable {
    let utf8JSONReader: Int

    enum CodingKeys: String, CodingKey {
        case utf8JSONReader = "Utf8JsonReader"
    }

    init(utf8JSONReader: Int) {
        self.utf8JSONReader = utf8JSONReader
    }
}

// MARK: Utf8JSONReader convenience initializers and mutators

extension Utf8JSONReader {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Utf8JSONReader.self, from: data)
        self.init(utf8JSONReader: me.utf8JSONReader)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        utf8JSONReader: Int? = nil
    ) -> Utf8JSONReader {
        return Utf8JSONReader(
            utf8JSONReader: utf8JSONReader ?? self.utf8JSONReader
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Utf8JSONWriter
@objcMembers class Utf8JSONWriter: NSObject, Codable {
    let utf8JSONWriter: Int

    enum CodingKeys: String, CodingKey {
        case utf8JSONWriter = "Utf8JsonWriter"
    }

    init(utf8JSONWriter: Int) {
        self.utf8JSONWriter = utf8JSONWriter
    }
}

// MARK: Utf8JSONWriter convenience initializers and mutators

extension Utf8JSONWriter {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Utf8JSONWriter.self, from: data)
        self.init(utf8JSONWriter: me.utf8JSONWriter)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        utf8JSONWriter: Int? = nil
    ) -> Utf8JSONWriter {
        return Utf8JSONWriter(
            utf8JSONWriter: utf8JSONWriter ?? self.utf8JSONWriter
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - UUIDClass
@objcMembers class UUIDClass: NSObject, Codable {
    let uuid: Int

    enum CodingKeys: String, CodingKey {
        case uuid = "UUID"
    }

    init(uuid: Int) {
        self.uuid = uuid
    }
}

// MARK: UUIDClass convenience initializers and mutators

extension UUIDClass {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(UUIDClass.self, from: data)
        self.init(uuid: me.uuid)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        uuid: Int? = nil
    ) -> UUIDClass {
        return UUIDClass(
            uuid: uuid ?? self.uuid
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Virtual
@objcMembers class Virtual: NSObject, Codable {
    let virtual: Int

    enum CodingKeys: String, CodingKey {
        case virtual = "virtual"
    }

    init(virtual: Int) {
        self.virtual = virtual
    }
}

// MARK: Virtual convenience initializers and mutators

extension Virtual {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Virtual.self, from: data)
        self.init(virtual: me.virtual)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        virtual: Int? = nil
    ) -> Virtual {
        return Virtual(
            virtual: virtual ?? self.virtual
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Void
@objcMembers class Void: NSObject, Codable {
    let void: Int

    enum CodingKeys: String, CodingKey {
        case void = "void"
    }

    init(void: Int) {
        self.void = void
    }
}

// MARK: Void convenience initializers and mutators

extension Void {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Void.self, from: data)
        self.init(void: me.void)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        void: Int? = nil
    ) -> Void {
        return Void(
            void: void ?? self.void
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Volatile
@objcMembers class Volatile: NSObject, Codable {
    let volatile: Int

    enum CodingKeys: String, CodingKey {
        case volatile = "volatile"
    }

    init(volatile: Int) {
        self.volatile = volatile
    }
}

// MARK: Volatile convenience initializers and mutators

extension Volatile {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Volatile.self, from: data)
        self.init(volatile: me.volatile)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        volatile: Int? = nil
    ) -> Volatile {
        return Volatile(
            volatile: volatile ?? self.volatile
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - WcharT
@objcMembers class WcharT: NSObject, Codable {
    let wcharT: Int

    enum CodingKeys: String, CodingKey {
        case wcharT = "wchar_t"
    }

    init(wcharT: Int) {
        self.wcharT = wcharT
    }
}

// MARK: WcharT convenience initializers and mutators

extension WcharT {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(WcharT.self, from: data)
        self.init(wcharT: me.wcharT)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        wcharT: Int? = nil
    ) -> WcharT {
        return WcharT(
            wcharT: wcharT ?? self.wcharT
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - With
@objcMembers class With: NSObject, Codable {
    let with: Int

    enum CodingKeys: String, CodingKey {
        case with = "with"
    }

    init(with: Int) {
        self.with = with
    }
}

// MARK: With convenience initializers and mutators

extension With {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(With.self, from: data)
        self.init(with: me.with)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        with: Int? = nil
    ) -> With {
        return With(
            with: with ?? self.with
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Xor
@objcMembers class Xor: NSObject, Codable {
    let xor: Int

    enum CodingKeys: String, CodingKey {
        case xor = "xor"
    }

    init(xor: Int) {
        self.xor = xor
    }
}

// MARK: Xor convenience initializers and mutators

extension Xor {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Xor.self, from: data)
        self.init(xor: me.xor)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        xor: Int? = nil
    ) -> Xor {
        return Xor(
            xor: xor ?? self.xor
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - XorEq
@objcMembers class XorEq: NSObject, Codable {
    let xorEq: Int

    enum CodingKeys: String, CodingKey {
        case xorEq = "xor_eq"
    }

    init(xorEq: Int) {
        self.xorEq = xorEq
    }
}

// MARK: XorEq convenience initializers and mutators

extension XorEq {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(XorEq.self, from: data)
        self.init(xorEq: me.xorEq)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        xorEq: Int? = nil
    ) -> XorEq {
        return XorEq(
            xorEq: xorEq ?? self.xorEq
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Yes
@objcMembers class Yes: NSObject, Codable {
    let yes: Int

    enum CodingKeys: String, CodingKey {
        case yes = "YES"
    }

    init(yes: Int) {
        self.yes = yes
    }
}

// MARK: Yes convenience initializers and mutators

extension Yes {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Yes.self, from: data)
        self.init(yes: me.yes)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        yes: Int? = nil
    ) -> Yes {
        return Yes(
            yes: yes ?? self.yes
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Yield
@objcMembers class Yield: NSObject, Codable {
    let yield: Int

    enum CodingKeys: String, CodingKey {
        case yield = "yield"
    }

    init(yield: Int) {
        self.yield = yield
    }
}

// MARK: Yield convenience initializers and mutators

extension Yield {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Yield.self, from: data)
        self.init(yield: me.yield)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        yield: Int? = nil
    ) -> Yield {
        return Yield(
            yield: yield ?? self.yield
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
        let container = try decoder.singleValueContainer()
        let dateStr = try container.decode(String.self)

        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        if let date = formatter.date(from: dateStr) {
            return date
        }
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
        if let date = formatter.date(from: dateStr) {
            return date
        }
        throw DecodingError.typeMismatch(Date.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Could not decode date"))
    })
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSXXXXX"
    encoder.dateEncodingStrategy = .formatted(formatter)
    return encoder
}

// MARK: - Encode/decode helpers

@objcMembers class JSONNull: NSObject, Codable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    override public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
