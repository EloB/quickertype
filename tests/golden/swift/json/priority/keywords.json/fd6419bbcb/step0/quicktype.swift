// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable, Equatable {
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
}

// MARK: TopLevel convenience initializers and mutators

extension TopLevel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TopLevel.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Obj1
struct Obj1: Codable, Equatable {
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
}

// MARK: Obj1 convenience initializers and mutators

extension Obj1 {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Obj1.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Abstract
struct Abstract: Codable, Equatable {
    let abstract: Int

    enum CodingKeys: String, CodingKey {
        case abstract = "abstract"
    }
}

// MARK: Abstract convenience initializers and mutators

extension Abstract {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Abstract.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Alignas
struct Alignas: Codable, Equatable {
    let alignas: Int

    enum CodingKeys: String, CodingKey {
        case alignas = "alignas"
    }
}

// MARK: Alignas convenience initializers and mutators

extension Alignas {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Alignas.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Alignof
struct Alignof: Codable, Equatable {
    let alignof: Int

    enum CodingKeys: String, CodingKey {
        case alignof = "alignof"
    }
}

// MARK: Alignof convenience initializers and mutators

extension Alignof {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Alignof.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - And
struct And: Codable, Equatable {
    let and: Int

    enum CodingKeys: String, CodingKey {
        case and = "and"
    }
}

// MARK: And convenience initializers and mutators

extension And {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(And.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - AndEq
struct AndEq: Codable, Equatable {
    let andEq: Int

    enum CodingKeys: String, CodingKey {
        case andEq = "and_eq"
    }
}

// MARK: AndEq convenience initializers and mutators

extension AndEq {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AndEq.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - AnyClass
struct AnyClass: Codable, Equatable {
    let any: Int

    enum CodingKeys: String, CodingKey {
        case any = "Any"
    }
}

// MARK: AnyClass convenience initializers and mutators

extension AnyClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AnyClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Array
struct Array: Codable, Equatable {
    let array: Int

    enum CodingKeys: String, CodingKey {
        case array = "array"
    }
}

// MARK: Array convenience initializers and mutators

extension Array {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Array.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - ArrayNode
struct ArrayNode: Codable, Equatable {
    let arrayNode: Int

    enum CodingKeys: String, CodingKey {
        case arrayNode = "ArrayNode"
    }
}

// MARK: ArrayNode convenience initializers and mutators

extension ArrayNode {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ArrayNode.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - ASM
struct ASM: Codable, Equatable {
    let asm: Int

    enum CodingKeys: String, CodingKey {
        case asm = "asm"
    }
}

// MARK: ASM convenience initializers and mutators

extension ASM {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ASM.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Assert
struct Assert: Codable, Equatable {
    let assert: Int

    enum CodingKeys: String, CodingKey {
        case assert = "assert"
    }
}

// MARK: Assert convenience initializers and mutators

extension Assert {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Assert.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Async
struct Async: Codable, Equatable {
    let async: Int

    enum CodingKeys: String, CodingKey {
        case async = "async"
    }
}

// MARK: Async convenience initializers and mutators

extension Async {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Async.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Atomic
struct Atomic: Codable, Equatable {
    let atomic: Int

    enum CodingKeys: String, CodingKey {
        case atomic = "atomic"
    }
}

// MARK: Atomic convenience initializers and mutators

extension Atomic {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Atomic.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - AtomicCancel
struct AtomicCancel: Codable, Equatable {
    let atomicCancel: Int

    enum CodingKeys: String, CodingKey {
        case atomicCancel = "atomic_cancel"
    }
}

// MARK: AtomicCancel convenience initializers and mutators

extension AtomicCancel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AtomicCancel.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - AtomicCommit
struct AtomicCommit: Codable, Equatable {
    let atomicCommit: Int

    enum CodingKeys: String, CodingKey {
        case atomicCommit = "atomic_commit"
    }
}

// MARK: AtomicCommit convenience initializers and mutators

extension AtomicCommit {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AtomicCommit.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - AtomicNoexcept
struct AtomicNoexcept: Codable, Equatable {
    let atomicNoexcept: Int

    enum CodingKeys: String, CodingKey {
        case atomicNoexcept = "atomic_noexcept"
    }
}

// MARK: AtomicNoexcept convenience initializers and mutators

extension AtomicNoexcept {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AtomicNoexcept.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Auto
struct Auto: Codable, Equatable {
    let auto: Int

    enum CodingKeys: String, CodingKey {
        case auto = "auto"
    }
}

// MARK: Auto convenience initializers and mutators

extension Auto {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Auto.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Base
struct Base: Codable, Equatable {
    let base: Int

    enum CodingKeys: String, CodingKey {
        case base = "base"
    }
}

// MARK: Base convenience initializers and mutators

extension Base {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Base.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Bitand
struct Bitand: Codable, Equatable {
    let bitand: Int

    enum CodingKeys: String, CodingKey {
        case bitand = "bitand"
    }
}

// MARK: Bitand convenience initializers and mutators

extension Bitand {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Bitand.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Bitor
struct Bitor: Codable, Equatable {
    let bitor: Int

    enum CodingKeys: String, CodingKey {
        case bitor = "bitor"
    }
}

// MARK: Bitor convenience initializers and mutators

extension Bitor {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Bitor.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - BOOLClass
struct BOOLClass: Codable, Equatable {
    let bool: Int

    enum CodingKeys: String, CodingKey {
        case bool = "BOOL"
    }
}

// MARK: BOOLClass convenience initializers and mutators

extension BOOLClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(BOOLClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Boolean
struct Boolean: Codable, Equatable {
    let boolean: Int

    enum CodingKeys: String, CodingKey {
        case boolean = "boolean"
    }
}

// MARK: Boolean convenience initializers and mutators

extension Boolean {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Boolean.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - BooleanNode
struct BooleanNode: Codable, Equatable {
    let booleanNode: Int

    enum CodingKeys: String, CodingKey {
        case booleanNode = "BooleanNode"
    }
}

// MARK: BooleanNode convenience initializers and mutators

extension BooleanNode {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(BooleanNode.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Bycopy
struct Bycopy: Codable, Equatable {
    let bycopy: Int

    enum CodingKeys: String, CodingKey {
        case bycopy = "bycopy"
    }
}

// MARK: Bycopy convenience initializers and mutators

extension Bycopy {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Bycopy.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Byref
struct Byref: Codable, Equatable {
    let byref: Int

    enum CodingKeys: String, CodingKey {
        case byref = "byref"
    }
}

// MARK: Byref convenience initializers and mutators

extension Byref {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Byref.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Byte
struct Byte: Codable, Equatable {
    let byte: Int

    enum CodingKeys: String, CodingKey {
        case byte = "byte"
    }
}

// MARK: Byte convenience initializers and mutators

extension Byte {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Byte.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - CalendarClass
struct CalendarClass: Codable, Equatable {
    let calendar: Int

    enum CodingKeys: String, CodingKey {
        case calendar = "Calendar"
    }
}

// MARK: CalendarClass convenience initializers and mutators

extension CalendarClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CalendarClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Chan
struct Chan: Codable, Equatable {
    let chan: Int

    enum CodingKeys: String, CodingKey {
        case chan = "chan"
    }
}

// MARK: Chan convenience initializers and mutators

extension Chan {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Chan.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Char
struct Char: Codable, Equatable {
    let char: Int

    enum CodingKeys: String, CodingKey {
        case char = "char"
    }
}

// MARK: Char convenience initializers and mutators

extension Char {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Char.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Char16T
struct Char16T: Codable, Equatable {
    let char16T: Int

    enum CodingKeys: String, CodingKey {
        case char16T = "char16_t"
    }
}

// MARK: Char16T convenience initializers and mutators

extension Char16T {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Char16T.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Char32T
struct Char32T: Codable, Equatable {
    let char32T: Int

    enum CodingKeys: String, CodingKey {
        case char32T = "char32_t"
    }
}

// MARK: Char32T convenience initializers and mutators

extension Char32T {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Char32T.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Checked
struct Checked: Codable, Equatable {
    let checked: Int

    enum CodingKeys: String, CodingKey {
        case checked = "checked"
    }
}

// MARK: Checked convenience initializers and mutators

extension Checked {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Checked.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Clone
struct Clone: Codable, Equatable {
    let clone: Int

    enum CodingKeys: String, CodingKey {
        case clone = "clone"
    }
}

// MARK: Clone convenience initializers and mutators

extension Clone {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Clone.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - CoAwait
struct CoAwait: Codable, Equatable {
    let coAwait: Int

    enum CodingKeys: String, CodingKey {
        case coAwait = "co_await"
    }
}

// MARK: CoAwait convenience initializers and mutators

extension CoAwait {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CoAwait.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - CoReturn
struct CoReturn: Codable, Equatable {
    let coReturn: Int

    enum CodingKeys: String, CodingKey {
        case coReturn = "co_return"
    }
}

// MARK: CoReturn convenience initializers and mutators

extension CoReturn {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CoReturn.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - CoYield
struct CoYield: Codable, Equatable {
    let coYield: Int

    enum CodingKeys: String, CodingKey {
        case coYield = "co_yield"
    }
}

// MARK: CoYield convenience initializers and mutators

extension CoYield {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CoYield.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - CodableClass
struct CodableClass: Codable, Equatable {
    let codable: Int

    enum CodingKeys: String, CodingKey {
        case codable = "Codable"
    }
}

// MARK: CodableClass convenience initializers and mutators

extension CodableClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CodableClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - CodingKeyClass
struct CodingKeyClass: Codable, Equatable {
    let codingKey: Int

    enum CodingKeys: String, CodingKey {
        case codingKey = "CodingKey"
    }
}

// MARK: CodingKeyClass convenience initializers and mutators

extension CodingKeyClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CodingKeyClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - CodingKeysClass
struct CodingKeysClass: Codable, Equatable {
    let codingKeys: Int

    enum CodingKeys: String, CodingKey {
        case codingKeys = "CodingKeys"
    }
}

// MARK: CodingKeysClass convenience initializers and mutators

extension CodingKeysClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CodingKeysClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Compl
struct Compl: Codable, Equatable {
    let compl: Int

    enum CodingKeys: String, CodingKey {
        case compl = "compl"
    }
}

// MARK: Compl convenience initializers and mutators

extension Compl {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Compl.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Complex
struct Complex: Codable, Equatable {
    let complex: Int

    enum CodingKeys: String, CodingKey {
        case complex = "_Complex"
    }
}

// MARK: Complex convenience initializers and mutators

extension Complex {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Complex.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Concept
struct Concept: Codable, Equatable {
    let concept: Int

    enum CodingKeys: String, CodingKey {
        case concept = "concept"
    }
}

// MARK: Concept convenience initializers and mutators

extension Concept {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Concept.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Console
struct Console: Codable, Equatable {
    let console: Int

    enum CodingKeys: String, CodingKey {
        case console = "console"
    }
}

// MARK: Console convenience initializers and mutators

extension Console {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Console.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Const
struct Const: Codable, Equatable {
    let const: Int

    enum CodingKeys: String, CodingKey {
        case const = "const"
    }
}

// MARK: Const convenience initializers and mutators

extension Const {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Const.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - ConstCast
struct ConstCast: Codable, Equatable {
    let constCast: Int

    enum CodingKeys: String, CodingKey {
        case constCast = "const_cast"
    }
}

// MARK: ConstCast convenience initializers and mutators

extension ConstCast {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ConstCast.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Constexpr
struct Constexpr: Codable, Equatable {
    let constexpr: Int

    enum CodingKeys: String, CodingKey {
        case constexpr = "constexpr"
    }
}

// MARK: Constexpr convenience initializers and mutators

extension Constexpr {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Constexpr.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Constructor
struct Constructor: Codable, Equatable {
    let constructor: Int

    enum CodingKeys: String, CodingKey {
        case constructor = "constructor"
    }
}

// MARK: Constructor convenience initializers and mutators

extension Constructor {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Constructor.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Convert
struct Convert: Codable, Equatable {
    let convert: Int

    enum CodingKeys: String, CodingKey {
        case convert = "convert"
    }
}

// MARK: Convert convenience initializers and mutators

extension Convert {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Convert.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Converter
struct Converter: Codable, Equatable {
    let converter: Int

    enum CodingKeys: String, CodingKey {
        case converter = "converter"
    }
}

// MARK: Converter convenience initializers and mutators

extension Converter {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Converter.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Empty
struct Empty: Codable, Equatable {
    let empty: Int

    enum CodingKeys: String, CodingKey {
        case empty = "_"
    }
}

// MARK: Empty convenience initializers and mutators

extension Empty {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Empty.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Imaginery
struct Imaginery: Codable, Equatable {
    let imaginery: Int

    enum CodingKeys: String, CodingKey {
        case imaginery = "_Imaginery"
    }
}

// MARK: Imaginery convenience initializers and mutators

extension Imaginery {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Imaginery.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Obj1Any
struct Obj1Any: Codable, Equatable {
    let any: Int

    enum CodingKeys: String, CodingKey {
        case any = "any"
    }
}

// MARK: Obj1Any convenience initializers and mutators

extension Obj1Any {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Obj1Any.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - As
struct As: Codable, Equatable {
    let asAs: Int

    enum CodingKeys: String, CodingKey {
        case asAs = "as"
    }
}

// MARK: As convenience initializers and mutators

extension As {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(As.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Associatedtype
struct Associatedtype: Codable, Equatable {
    let associatedtypeAssociatedtype: Int

    enum CodingKeys: String, CodingKey {
        case associatedtypeAssociatedtype = "associatedtype"
    }
}

// MARK: Associatedtype convenience initializers and mutators

extension Associatedtype {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Associatedtype.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Associativity
struct Associativity: Codable, Equatable {
    let associativityAssociativity: Int

    enum CodingKeys: String, CodingKey {
        case associativityAssociativity = "associativity"
    }
}

// MARK: Associativity convenience initializers and mutators

extension Associativity {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Associativity.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Await
struct Await: Codable, Equatable {
    let awaitAwait: Int

    enum CodingKeys: String, CodingKey {
        case awaitAwait = "await"
    }
}

// MARK: Await convenience initializers and mutators

extension Await {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Await.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - BoolClass
struct BoolClass: Codable, Equatable {
    let bool: Int

    enum CodingKeys: String, CodingKey {
        case bool = "_Bool"
    }
}

// MARK: BoolClass convenience initializers and mutators

extension BoolClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(BoolClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Break
struct Break: Codable, Equatable {
    let breakBreak: Int

    enum CodingKeys: String, CodingKey {
        case breakBreak = "break"
    }
}

// MARK: Break convenience initializers and mutators

extension Break {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Break.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Case
struct Case: Codable, Equatable {
    let caseCase: Int

    enum CodingKeys: String, CodingKey {
        case caseCase = "case"
    }
}

// MARK: Case convenience initializers and mutators

extension Case {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Case.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Catch
struct Catch: Codable, Equatable {
    let catchCatch: Int

    enum CodingKeys: String, CodingKey {
        case catchCatch = "catch"
    }
}

// MARK: Catch convenience initializers and mutators

extension Catch {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Catch.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Class
struct Class: Codable, Equatable {
    let classClass: Int

    enum CodingKeys: String, CodingKey {
        case classClass = "Class"
    }
}

// MARK: Class convenience initializers and mutators

extension Class {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Class.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Continue
struct Continue: Codable, Equatable {
    let continueContinue: Int

    enum CodingKeys: String, CodingKey {
        case continueContinue = "continue"
    }
}

// MARK: Continue convenience initializers and mutators

extension Continue {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Continue.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Convenience
struct Convenience: Codable, Equatable {
    let convenienceConvenience: Int

    enum CodingKeys: String, CodingKey {
        case convenienceConvenience = "convenience"
    }
}

// MARK: Convenience convenience initializers and mutators

extension Convenience {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Convenience.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Obj1Bool
struct Obj1Bool: Codable, Equatable {
    let bool: Int

    enum CodingKeys: String, CodingKey {
        case bool = "bool"
    }
}

// MARK: Obj1Bool convenience initializers and mutators

extension Obj1Bool {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Obj1Bool.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - ClassClass
struct ClassClass: Codable, Equatable {
    let classClass: Int

    enum CodingKeys: String, CodingKey {
        case classClass = "class"
    }
}

// MARK: ClassClass convenience initializers and mutators

extension ClassClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ClassClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Obj2
struct Obj2: Codable, Equatable {
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
    let equatable: EquatableClass
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
}

// MARK: Obj2 convenience initializers and mutators

extension Obj2 {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Obj2.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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
        equatable: EquatableClass? = nil,
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - CultureInfo
struct CultureInfo: Codable, Equatable {
    let cultureInfo: Int

    enum CodingKeys: String, CodingKey {
        case cultureInfo = "CultureInfo"
    }
}

// MARK: CultureInfo convenience initializers and mutators

extension CultureInfo {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CultureInfo.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - DateClass
struct DateClass: Codable, Equatable {
    let date: Int

    enum CodingKeys: String, CodingKey {
        case date = "date"
    }
}

// MARK: DateClass convenience initializers and mutators

extension DateClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DateClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - DateFormatterClass
struct DateFormatterClass: Codable, Equatable {
    let dateFormatter: Int

    enum CodingKeys: String, CodingKey {
        case dateFormatter = "DateFormatter"
    }
}

// MARK: DateFormatterClass convenience initializers and mutators

extension DateFormatterClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DateFormatterClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - DateOnly
struct DateOnly: Codable, Equatable {
    let dateOnly: Int

    enum CodingKeys: String, CodingKey {
        case dateOnly = "DateOnly"
    }
}

// MARK: DateOnly convenience initializers and mutators

extension DateOnly {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DateOnly.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - DateOnlyConverter
struct DateOnlyConverter: Codable, Equatable {
    let dateOnlyConverter: Int

    enum CodingKeys: String, CodingKey {
        case dateOnlyConverter = "DateOnlyConverter"
    }
}

// MARK: DateOnlyConverter convenience initializers and mutators

extension DateOnlyConverter {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DateOnlyConverter.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - DateParseHandling
struct DateParseHandling: Codable, Equatable {
    let dateParseHandling: Int

    enum CodingKeys: String, CodingKey {
        case dateParseHandling = "date_parse_handling"
    }
}

// MARK: DateParseHandling convenience initializers and mutators

extension DateParseHandling {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DateParseHandling.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - DateTime
struct DateTime: Codable, Equatable {
    let dateTime: Date

    enum CodingKeys: String, CodingKey {
        case dateTime = "DateTime"
    }
}

// MARK: DateTime convenience initializers and mutators

extension DateTime {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DateTime.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - DateTimeStyles
struct DateTimeStyles: Codable, Equatable {
    let dateTimeStyles: Int

    enum CodingKeys: String, CodingKey {
        case dateTimeStyles = "DateTimeStyles"
    }
}

// MARK: DateTimeStyles convenience initializers and mutators

extension DateTimeStyles {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DateTimeStyles.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Debugger
struct Debugger: Codable, Equatable {
    let debugger: Int

    enum CodingKeys: String, CodingKey {
        case debugger = "debugger"
    }
}

// MARK: Debugger convenience initializers and mutators

extension Debugger {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Debugger.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Decimal
struct Decimal: Codable, Equatable {
    let decimal: Int

    enum CodingKeys: String, CodingKey {
        case decimal = "decimal"
    }
}

// MARK: Decimal convenience initializers and mutators

extension Decimal {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Decimal.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Declare
struct Declare: Codable, Equatable {
    let declare: Int

    enum CodingKeys: String, CodingKey {
        case declare = "declare"
    }
}

// MARK: Declare convenience initializers and mutators

extension Declare {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Declare.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Decltype
struct Decltype: Codable, Equatable {
    let decltype: Int

    enum CodingKeys: String, CodingKey {
        case decltype = "decltype"
    }
}

// MARK: Decltype convenience initializers and mutators

extension Decltype {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Decltype.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - DecodeString
struct DecodeString: Codable, Equatable {
    let decodeString: Int

    enum CodingKeys: String, CodingKey {
        case decodeString = "decode_string"
    }
}

// MARK: DecodeString convenience initializers and mutators

extension DecodeString {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DecodeString.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - DecoderClass
struct DecoderClass: Codable, Equatable {
    let decoder: Int

    enum CodingKeys: String, CodingKey {
        case decoder = "Decoder"
    }
}

// MARK: DecoderClass convenience initializers and mutators

extension DecoderClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DecoderClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - DecodingErrorClass
struct DecodingErrorClass: Codable, Equatable {
    let decodingError: Int

    enum CodingKeys: String, CodingKey {
        case decodingError = "DecodingError"
    }
}

// MARK: DecodingErrorClass convenience initializers and mutators

extension DecodingErrorClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DecodingErrorClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Def
struct Def: Codable, Equatable {
    let def: Int

    enum CodingKeys: String, CodingKey {
        case def = "def"
    }
}

// MARK: Def convenience initializers and mutators

extension Def {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Def.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Del
struct Del: Codable, Equatable {
    let del: Int

    enum CodingKeys: String, CodingKey {
        case del = "del"
    }
}

// MARK: Del convenience initializers and mutators

extension Del {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Del.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Delegate
struct Delegate: Codable, Equatable {
    let delegate: Int

    enum CodingKeys: String, CodingKey {
        case delegate = "delegate"
    }
}

// MARK: Delegate convenience initializers and mutators

extension Delegate {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Delegate.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Delete
struct Delete: Codable, Equatable {
    let delete: Int

    enum CodingKeys: String, CodingKey {
        case delete = "delete"
    }
}

// MARK: Delete convenience initializers and mutators

extension Delete {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Delete.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - DeserializationFeature
struct DeserializationFeature: Codable, Equatable {
    let deserializationFeature: Int

    enum CodingKeys: String, CodingKey {
        case deserializationFeature = "DeserializationFeature"
    }
}

// MARK: DeserializationFeature convenience initializers and mutators

extension DeserializationFeature {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DeserializationFeature.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Dict
struct Dict: Codable, Equatable {
    let dict: Int

    enum CodingKeys: String, CodingKey {
        case dict = "dict"
    }
}

// MARK: Dict convenience initializers and mutators

extension Dict {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Dict.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Dictionary
struct Dictionary: Codable, Equatable {
    let dictionary: Int

    enum CodingKeys: String, CodingKey {
        case dictionary = "dictionary"
    }
}

// MARK: Dictionary convenience initializers and mutators

extension Dictionary {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Dictionary.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - DoubleClass
struct DoubleClass: Codable, Equatable {
    let double: Int

    enum CodingKeys: String, CodingKey {
        case double = "double"
    }
}

// MARK: DoubleClass convenience initializers and mutators

extension DoubleClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DoubleClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - DoubleNode
struct DoubleNode: Codable, Equatable {
    let doubleNode: Int

    enum CodingKeys: String, CodingKey {
        case doubleNode = "DoubleNode"
    }
}

// MARK: DoubleNode convenience initializers and mutators

extension DoubleNode {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DoubleNode.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - DynamicCast
struct DynamicCast: Codable, Equatable {
    let dynamicCast: Int

    enum CodingKeys: String, CodingKey {
        case dynamicCast = "dynamic_cast"
    }
}

// MARK: DynamicCast convenience initializers and mutators

extension DynamicCast {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DynamicCast.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Elif
struct Elif: Codable, Equatable {
    let elif: Int

    enum CodingKeys: String, CodingKey {
        case elif = "elif"
    }
}

// MARK: Elif convenience initializers and mutators

extension Elif {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Elif.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - EncodeQuickType
struct EncodeQuickType: Codable, Equatable {
    let encodeQuickType: Int

    enum CodingKeys: String, CodingKey {
        case encodeQuickType = "encode_quick_type"
    }
}

// MARK: EncodeQuickType convenience initializers and mutators

extension EncodeQuickType {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(EncodeQuickType.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - EncoderClass
struct EncoderClass: Codable, Equatable {
    let encoder: Int

    enum CodingKeys: String, CodingKey {
        case encoder = "Encoder"
    }
}

// MARK: EncoderClass convenience initializers and mutators

extension EncoderClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(EncoderClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - EnumValues
struct EnumValues: Codable, Equatable {
    let enumValues: [EnumValue]

    enum CodingKeys: String, CodingKey {
        case enumValues = "EnumValues"
    }
}

// MARK: EnumValues convenience initializers and mutators

extension EnumValues {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(EnumValues.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

enum EnumValue: String, Codable, Equatable {
    case ready = "ready"
    case done = "done"
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - EqualityContract
struct EqualityContract: Codable, Equatable {
    let equalityContract: Int

    enum CodingKeys: String, CodingKey {
        case equalityContract = "equalityContract"
    }
}

// MARK: EqualityContract convenience initializers and mutators

extension EqualityContract {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(EqualityContract.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - EquatableClass
struct EquatableClass: Codable, Equatable {
    let equatable: Int

    enum CodingKeys: String, CodingKey {
        case equatable = "Equatable"
    }
}

// MARK: EquatableClass convenience initializers and mutators

extension EquatableClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(EquatableClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        equatable: Int? = nil
    ) -> EquatableClass {
        return EquatableClass(
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Event
struct Event: Codable, Equatable {
    let event: Int

    enum CodingKeys: String, CodingKey {
        case event = "event"
    }
}

// MARK: Event convenience initializers and mutators

extension Event {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Event.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Except
struct Except: Codable, Equatable {
    let except: Int

    enum CodingKeys: String, CodingKey {
        case except = "except"
    }
}

// MARK: Except convenience initializers and mutators

extension Except {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Except.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Exception
struct Exception: Codable, Equatable {
    let exception: Int

    enum CodingKeys: String, CodingKey {
        case exception = "exception"
    }
}

// MARK: Exception convenience initializers and mutators

extension Exception {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Exception.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Explicit
struct Explicit: Codable, Equatable {
    let explicit: Int

    enum CodingKeys: String, CodingKey {
        case explicit = "explicit"
    }
}

// MARK: Explicit convenience initializers and mutators

extension Explicit {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Explicit.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Export
struct Export: Codable, Equatable {
    let export: Int

    enum CodingKeys: String, CodingKey {
        case export = "export"
    }
}

// MARK: Export convenience initializers and mutators

extension Export {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Export.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Exposing
struct Exposing: Codable, Equatable {
    let exposing: Int

    enum CodingKeys: String, CodingKey {
        case exposing = "exposing"
    }
}

// MARK: Exposing convenience initializers and mutators

extension Exposing {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Exposing.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Extends
struct Extends: Codable, Equatable {
    let extends: Int

    enum CodingKeys: String, CodingKey {
        case extends = "extends"
    }
}

// MARK: Extends convenience initializers and mutators

extension Extends {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Extends.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Extern
struct Extern: Codable, Equatable {
    let extern: Int

    enum CodingKeys: String, CodingKey {
        case extern = "extern"
    }
}

// MARK: Extern convenience initializers and mutators

extension Extern {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Extern.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Finally
struct Finally: Codable, Equatable {
    let finally: Int

    enum CodingKeys: String, CodingKey {
        case finally = "finally"
    }
}

// MARK: Finally convenience initializers and mutators

extension Finally {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Finally.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Fixed
struct Fixed: Codable, Equatable {
    let fixed: Int

    enum CodingKeys: String, CodingKey {
        case fixed = "fixed"
    }
}

// MARK: Fixed convenience initializers and mutators

extension Fixed {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Fixed.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Float
struct Float: Codable, Equatable {
    let float: Int

    enum CodingKeys: String, CodingKey {
        case float = "float"
    }
}

// MARK: Float convenience initializers and mutators

extension Float {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Float.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Foreach
struct Foreach: Codable, Equatable {
    let foreach: Int

    enum CodingKeys: String, CodingKey {
        case foreach = "foreach"
    }
}

// MARK: Foreach convenience initializers and mutators

extension Foreach {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Foreach.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - FormatException
struct FormatException: Codable, Equatable {
    let formatException: Int

    enum CodingKeys: String, CodingKey {
        case formatException = "FormatException"
    }
}

// MARK: FormatException convenience initializers and mutators

extension FormatException {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FormatException.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Friend
struct Friend: Codable, Equatable {
    let friend: Int

    enum CodingKeys: String, CodingKey {
        case friend = "friend"
    }
}

// MARK: Friend convenience initializers and mutators

extension Friend {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Friend.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - From
struct From: Codable, Equatable {
    let from: Int

    enum CodingKeys: String, CodingKey {
        case from = "from"
    }
}

// MARK: From convenience initializers and mutators

extension From {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(From.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - FromDict
struct FromDict: Codable, Equatable {
    let fromDict: Int

    enum CodingKeys: String, CodingKey {
        case fromDict = "from_dict"
    }
}

// MARK: FromDict convenience initializers and mutators

extension FromDict {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FromDict.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - FromJSON
struct FromJSON: Codable, Equatable {
    let fromJSON: Int

    enum CodingKeys: String, CodingKey {
        case fromJSON = "from_json"
    }
}

// MARK: FromJSON convenience initializers and mutators

extension FromJSON {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FromJSON.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Default
struct Default: Codable, Equatable {
    let defaultDefault: Int

    enum CodingKeys: String, CodingKey {
        case defaultDefault = "default"
    }
}

// MARK: Default convenience initializers and mutators

extension Default {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Default.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Defer
struct Defer: Codable, Equatable {
    let deferDefer: Int

    enum CodingKeys: String, CodingKey {
        case deferDefer = "defer"
    }
}

// MARK: Defer convenience initializers and mutators

extension Defer {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Defer.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Deinit
struct Deinit: Codable, Equatable {
    let deinitDeinit: Int

    enum CodingKeys: String, CodingKey {
        case deinitDeinit = "deinit"
    }
}

// MARK: Deinit convenience initializers and mutators

extension Deinit {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Deinit.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - DidSet
struct DidSet: Codable, Equatable {
    let didSetDidSet: Int

    enum CodingKeys: String, CodingKey {
        case didSetDidSet = "didSet"
    }
}

// MARK: DidSet convenience initializers and mutators

extension DidSet {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DidSet.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Do
struct Do: Codable, Equatable {
    let doDo: Int

    enum CodingKeys: String, CodingKey {
        case doDo = "do"
    }
}

// MARK: Do convenience initializers and mutators

extension Do {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Do.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Dynamic
struct Dynamic: Codable, Equatable {
    let dynamicDynamic: Int

    enum CodingKeys: String, CodingKey {
        case dynamicDynamic = "dynamic"
    }
}

// MARK: Dynamic convenience initializers and mutators

extension Dynamic {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Dynamic.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Else
struct Else: Codable, Equatable {
    let elseElse: Int

    enum CodingKeys: String, CodingKey {
        case elseElse = "else"
    }
}

// MARK: Else convenience initializers and mutators

extension Else {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Else.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Enum
struct Enum: Codable, Equatable {
    let enumEnum: Int

    enum CodingKeys: String, CodingKey {
        case enumEnum = "enum"
    }
}

// MARK: Enum convenience initializers and mutators

extension Enum {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Enum.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Extension
struct Extension: Codable, Equatable {
    let extensionExtension: Int

    enum CodingKeys: String, CodingKey {
        case extensionExtension = "extension"
    }
}

// MARK: Extension convenience initializers and mutators

extension Extension {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Extension.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Fallthrough
struct Fallthrough: Codable, Equatable {
    let fallthroughFallthrough: Int

    enum CodingKeys: String, CodingKey {
        case fallthroughFallthrough = "fallthrough"
    }
}

// MARK: Fallthrough convenience initializers and mutators

extension Fallthrough {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Fallthrough.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - False
struct False: Codable, Equatable {
    let falseFalse: Int

    enum CodingKeys: String, CodingKey {
        case falseFalse = "False"
    }
}

// MARK: False convenience initializers and mutators

extension False {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(False.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Fileprivate
struct Fileprivate: Codable, Equatable {
    let fileprivateFileprivate: Int

    enum CodingKeys: String, CodingKey {
        case fileprivateFileprivate = "fileprivate"
    }
}

// MARK: Fileprivate convenience initializers and mutators

extension Fileprivate {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Fileprivate.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Final
struct Final: Codable, Equatable {
    let finalFinal: Int

    enum CodingKeys: String, CodingKey {
        case finalFinal = "final"
    }
}

// MARK: Final convenience initializers and mutators

extension Final {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Final.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - For
struct For: Codable, Equatable {
    let forFor: Int

    enum CodingKeys: String, CodingKey {
        case forFor = "for"
    }
}

// MARK: For convenience initializers and mutators

extension For {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(For.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Func
struct Func: Codable, Equatable {
    let funcFunc: Int

    enum CodingKeys: String, CodingKey {
        case funcFunc = "func"
    }
}

// MARK: Func convenience initializers and mutators

extension Func {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Func.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - FalseClass
struct FalseClass: Codable, Equatable {
    let falseFalse: Int

    enum CodingKeys: String, CodingKey {
        case falseFalse = "false"
    }
}

// MARK: FalseClass convenience initializers and mutators

extension FalseClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FalseClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Obj3
struct Obj3: Codable, Equatable {
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
}

// MARK: Obj3 convenience initializers and mutators

extension Obj3 {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Obj3.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Function
struct Function: Codable, Equatable {
    let function: Int

    enum CodingKeys: String, CodingKey {
        case function = "function"
    }
}

// MARK: Function convenience initializers and mutators

extension Function {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Function.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Global
struct Global: Codable, Equatable {
    let global: Int

    enum CodingKeys: String, CodingKey {
        case global = "global"
    }
}

// MARK: Global convenience initializers and mutators

extension Global {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Global.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Go
struct Go: Codable, Equatable {
    let go: Int

    enum CodingKeys: String, CodingKey {
        case go = "go"
    }
}

// MARK: Go convenience initializers and mutators

extension Go {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Go.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Goto
struct Goto: Codable, Equatable {
    let goto: Int

    enum CodingKeys: String, CodingKey {
        case goto = "goto"
    }
}

// MARK: Goto convenience initializers and mutators

extension Goto {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Goto.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - HasOwnProperty
struct HasOwnProperty: Codable, Equatable {
    let hasOwnProperty: Int

    enum CodingKeys: String, CodingKey {
        case hasOwnProperty = "hasOwnProperty"
    }
}

// MARK: HasOwnProperty convenience initializers and mutators

extension HasOwnProperty {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(HasOwnProperty.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - HashCode
struct HashCode: Codable, Equatable {
    let hashCode: Int

    enum CodingKeys: String, CodingKey {
        case hashCode = "hashCode"
    }
}

// MARK: HashCode convenience initializers and mutators

extension HashCode {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(HashCode.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - HashableClass
struct HashableClass: Codable, Equatable {
    let hashable: Int

    enum CodingKeys: String, CodingKey {
        case hashable = "Hashable"
    }
}

// MARK: HashableClass convenience initializers and mutators

extension HashableClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(HashableClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - HasherClass
struct HasherClass: Codable, Equatable {
    let hasher: Int

    enum CodingKeys: String, CodingKey {
        case hasher = "Hasher"
    }
}

// MARK: HasherClass convenience initializers and mutators

extension HasherClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(HasherClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - ID
struct ID: Codable, Equatable {
    let id: Int

    enum CodingKeys: String, CodingKey {
        case id = "id"
    }
}

// MARK: ID convenience initializers and mutators

extension ID {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ID.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Imp
struct Imp: Codable, Equatable {
    let imp: Int

    enum CodingKeys: String, CodingKey {
        case imp = "IMP"
    }
}

// MARK: Imp convenience initializers and mutators

extension Imp {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Imp.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Implements
struct Implements: Codable, Equatable {
    let implements: Int

    enum CodingKeys: String, CodingKey {
        case implements = "implements"
    }
}

// MARK: Implements convenience initializers and mutators

extension Implements {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Implements.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Implicit
struct Implicit: Codable, Equatable {
    let implicit: Int

    enum CodingKeys: String, CodingKey {
        case implicit = "implicit"
    }
}

// MARK: Implicit convenience initializers and mutators

extension Implicit {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Implicit.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Inline
struct Inline: Codable, Equatable {
    let inline: Int

    enum CodingKeys: String, CodingKey {
        case inline = "inline"
    }
}

// MARK: Inline convenience initializers and mutators

extension Inline {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Inline.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Instanceof
struct Instanceof: Codable, Equatable {
    let instanceof: Int

    enum CodingKeys: String, CodingKey {
        case instanceof = "instanceof"
    }
}

// MARK: Instanceof convenience initializers and mutators

extension Instanceof {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Instanceof.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - IntClass
struct IntClass: Codable, Equatable {
    let int: Int

    enum CodingKeys: String, CodingKey {
        case int = "int"
    }
}

// MARK: IntClass convenience initializers and mutators

extension IntClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(IntClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - IntNode
struct IntNode: Codable, Equatable {
    let intNode: Int

    enum CodingKeys: String, CodingKey {
        case intNode = "IntNode"
    }
}

// MARK: IntNode convenience initializers and mutators

extension IntNode {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(IntNode.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Interface
struct Interface: Codable, Equatable {
    let interface: Int

    enum CodingKeys: String, CodingKey {
        case interface = "interface"
    }
}

// MARK: Interface convenience initializers and mutators

extension Interface {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Interface.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - ISODateTimeOffsetConverter
struct ISODateTimeOffsetConverter: Codable, Equatable {
    let isoDateTimeOffsetConverter: Int

    enum CodingKeys: String, CodingKey {
        case isoDateTimeOffsetConverter = "IsoDateTimeOffsetConverter"
    }
}

// MARK: ISODateTimeOffsetConverter convenience initializers and mutators

extension ISODateTimeOffsetConverter {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ISODateTimeOffsetConverter.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Iterable
struct Iterable: Codable, Equatable {
    let iterable: Int

    enum CodingKeys: String, CodingKey {
        case iterable = "iterable"
    }
}

// MARK: Iterable convenience initializers and mutators

extension Iterable {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Iterable.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Jdec
struct Jdec: Codable, Equatable {
    let jdec: Int

    enum CodingKeys: String, CodingKey {
        case jdec = "jdec"
    }
}

// MARK: Jdec convenience initializers and mutators

extension Jdec {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Jdec.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Jenc
struct Jenc: Codable, Equatable {
    let jenc: Int

    enum CodingKeys: String, CodingKey {
        case jenc = "jenc"
    }
}

// MARK: Jenc convenience initializers and mutators

extension Jenc {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Jenc.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Jpipe
struct Jpipe: Codable, Equatable {
    let jpipe: Int

    enum CodingKeys: String, CodingKey {
        case jpipe = "jpipe"
    }
}

// MARK: Jpipe convenience initializers and mutators

extension Jpipe {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Jpipe.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - JSONAnyClass
struct JSONAnyClass: Codable, Equatable {
    let jsonAny: JSONNull?

    enum CodingKeys: String, CodingKey {
        case jsonAny = "JSONAny"
    }
}

// MARK: JSONAnyClass convenience initializers and mutators

extension JSONAnyClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONAnyClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - JSONCodingKeyClass
struct JSONCodingKeyClass: Codable, Equatable {
    let jsonCodingKey: Int

    enum CodingKeys: String, CodingKey {
        case jsonCodingKey = "JSONCodingKey"
    }
}

// MARK: JSONCodingKeyClass convenience initializers and mutators

extension JSONCodingKeyClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONCodingKeyClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - JSONConverter
struct JSONConverter: Codable, Equatable {
    let jsonConverter: Int

    enum CodingKeys: String, CodingKey {
        case jsonConverter = "json_converter"
    }
}

// MARK: JSONConverter convenience initializers and mutators

extension JSONConverter {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONConverter.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - JSONDecoderClass
struct JSONDecoderClass: Codable, Equatable {
    let jsonDecoder: Int

    enum CodingKeys: String, CodingKey {
        case jsonDecoder = "JSONDecoder"
    }
}

// MARK: JSONDecoderClass convenience initializers and mutators

extension JSONDecoderClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONDecoderClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - JSONEncoderClass
struct JSONEncoderClass: Codable, Equatable {
    let jsonEncoder: Int

    enum CodingKeys: String, CodingKey {
        case jsonEncoder = "JSONEncoder"
    }
}

// MARK: JSONEncoderClass convenience initializers and mutators

extension JSONEncoderClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONEncoderClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - JSONException
struct JSONException: Codable, Equatable {
    let jsonException: Int

    enum CodingKeys: String, CodingKey {
        case jsonException = "JsonException"
    }
}

// MARK: JSONException convenience initializers and mutators

extension JSONException {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONException.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - JSONGenerator
struct JSONGenerator: Codable, Equatable {
    let jsonGenerator: Int

    enum CodingKeys: String, CodingKey {
        case jsonGenerator = "JsonGenerator"
    }
}

// MARK: JSONGenerator convenience initializers and mutators

extension JSONGenerator {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONGenerator.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - JSONNode
struct JSONNode: Codable, Equatable {
    let jsonNode: Int

    enum CodingKeys: String, CodingKey {
        case jsonNode = "JsonNode"
    }
}

// MARK: JSONNode convenience initializers and mutators

extension JSONNode {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONNode.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - JSONNullClass
struct JSONNullClass: Codable, Equatable {
    let jsonNull: Int

    enum CodingKeys: String, CodingKey {
        case jsonNull = "JSONNull"
    }
}

// MARK: JSONNullClass convenience initializers and mutators

extension JSONNullClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONNullClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - JSONParser
struct JSONParser: Codable, Equatable {
    let jsonParser: Int

    enum CodingKeys: String, CodingKey {
        case jsonParser = "JsonParser"
    }
}

// MARK: JSONParser convenience initializers and mutators

extension JSONParser {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONParser.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - JSONReader
struct JSONReader: Codable, Equatable {
    let jsonReader: Int

    enum CodingKeys: String, CodingKey {
        case jsonReader = "JsonReader"
    }
}

// MARK: JSONReader convenience initializers and mutators

extension JSONReader {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONReader.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - JSONSerializer
struct JSONSerializer: Codable, Equatable {
    let jsonSerializer: Int

    enum CodingKeys: String, CodingKey {
        case jsonSerializer = "json_serializer"
    }
}

// MARK: JSONSerializer convenience initializers and mutators

extension JSONSerializer {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONSerializer.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - JSONToken
struct JSONToken: Codable, Equatable {
    let jsonToken: Int

    enum CodingKeys: String, CodingKey {
        case jsonToken = "json_token"
    }
}

// MARK: JSONToken convenience initializers and mutators

extension JSONToken {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONToken.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - JSONTokenType
struct JSONTokenType: Codable, Equatable {
    let jsonTokenType: Int

    enum CodingKeys: String, CodingKey {
        case jsonTokenType = "JsonTokenType"
    }
}

// MARK: JSONTokenType convenience initializers and mutators

extension JSONTokenType {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONTokenType.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - JSONWriter
struct JSONWriter: Codable, Equatable {
    let jsonWriter: Int

    enum CodingKeys: String, CodingKey {
        case jsonWriter = "json_writer"
    }
}

// MARK: JSONWriter convenience initializers and mutators

extension JSONWriter {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSONWriter.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Lambda
struct Lambda: Codable, Equatable {
    let lambda: Int

    enum CodingKeys: String, CodingKey {
        case lambda = "lambda"
    }
}

// MARK: Lambda convenience initializers and mutators

extension Lambda {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Lambda.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - List
struct List: Codable, Equatable {
    let list: Int

    enum CodingKeys: String, CodingKey {
        case list = "list"
    }
}

// MARK: List convenience initializers and mutators

extension List {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(List.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - LocalDate
struct LocalDate: Codable, Equatable {
    let localDate: Int

    enum CodingKeys: String, CodingKey {
        case localDate = "LocalDate"
    }
}

// MARK: LocalDate convenience initializers and mutators

extension LocalDate {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(LocalDate.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - LocaleClass
struct LocaleClass: Codable, Equatable {
    let locale: Int

    enum CodingKeys: String, CodingKey {
        case locale = "Locale"
    }
}

// MARK: LocaleClass convenience initializers and mutators

extension LocaleClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(LocaleClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Lock
struct Lock: Codable, Equatable {
    let lock: Int

    enum CodingKeys: String, CodingKey {
        case lock = "lock"
    }
}

// MARK: Lock convenience initializers and mutators

extension Lock {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Lock.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Long
struct Long: Codable, Equatable {
    let long: Int

    enum CodingKeys: String, CodingKey {
        case long = "long"
    }
}

// MARK: Long convenience initializers and mutators

extension Long {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Long.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - LongNode
struct LongNode: Codable, Equatable {
    let longNode: Int

    enum CodingKeys: String, CodingKey {
        case longNode = "LongNode"
    }
}

// MARK: LongNode convenience initializers and mutators

extension LongNode {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(LongNode.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Map
struct Map: Codable, Equatable {
    let map: Int

    enum CodingKeys: String, CodingKey {
        case map = "map"
    }
}

// MARK: Map convenience initializers and mutators

extension Map {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Map.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - MapEntry
struct MapEntry: Codable, Equatable {
    let mapEntry: Int

    enum CodingKeys: String, CodingKey {
        case mapEntry = "MapEntry"
    }
}

// MARK: MapEntry convenience initializers and mutators

extension MapEntry {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(MapEntry.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - MarshalJSON
struct MarshalJSON: Codable, Equatable {
    let marshalJSON: Int

    enum CodingKeys: String, CodingKey {
        case marshalJSON = "MarshalJSON"
    }
}

// MARK: MarshalJSON convenience initializers and mutators

extension MarshalJSON {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(MarshalJSON.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - MetadataPropertyHandling
struct MetadataPropertyHandling: Codable, Equatable {
    let metadataPropertyHandling: Int

    enum CodingKeys: String, CodingKey {
        case metadataPropertyHandling = "metadata_property_handling"
    }
}

// MARK: MetadataPropertyHandling convenience initializers and mutators

extension MetadataPropertyHandling {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(MetadataPropertyHandling.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Module
struct Module: Codable, Equatable {
    let module: Int

    enum CodingKeys: String, CodingKey {
        case module = "module"
    }
}

// MARK: Module convenience initializers and mutators

extension Module {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Module.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Get
struct Get: Codable, Equatable {
    let getGet: Int

    enum CodingKeys: String, CodingKey {
        case getGet = "get"
    }
}

// MARK: Get convenience initializers and mutators

extension Get {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Get.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Guard
struct Guard: Codable, Equatable {
    let guardGuard: Int

    enum CodingKeys: String, CodingKey {
        case guardGuard = "guard"
    }
}

// MARK: Guard convenience initializers and mutators

extension Guard {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Guard.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - If
struct If: Codable, Equatable {
    let ifIf: Int

    enum CodingKeys: String, CodingKey {
        case ifIf = "if"
    }
}

// MARK: If convenience initializers and mutators

extension If {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(If.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Import
struct Import: Codable, Equatable {
    let importImport: Int

    enum CodingKeys: String, CodingKey {
        case importImport = "import"
    }
}

// MARK: Import convenience initializers and mutators

extension Import {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Import.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - In
struct In: Codable, Equatable {
    let inIn: Int

    enum CodingKeys: String, CodingKey {
        case inIn = "in"
    }
}

// MARK: In convenience initializers and mutators

extension In {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(In.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Indirect
struct Indirect: Codable, Equatable {
    let indirectIndirect: Int

    enum CodingKeys: String, CodingKey {
        case indirectIndirect = "indirect"
    }
}

// MARK: Indirect convenience initializers and mutators

extension Indirect {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Indirect.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Infix
struct Infix: Codable, Equatable {
    let infixInfix: Int

    enum CodingKeys: String, CodingKey {
        case infixInfix = "infix"
    }
}

// MARK: Infix convenience initializers and mutators

extension Infix {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Infix.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Init
struct Init: Codable, Equatable {
    let initInit: Int

    enum CodingKeys: String, CodingKey {
        case initInit = "init"
    }
}

// MARK: Init convenience initializers and mutators

extension Init {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Init.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Inout
struct Inout: Codable, Equatable {
    let inoutInout: Int

    enum CodingKeys: String, CodingKey {
        case inoutInout = "inout"
    }
}

// MARK: Inout convenience initializers and mutators

extension Inout {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Inout.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Internal
struct Internal: Codable, Equatable {
    let internalInternal: Int

    enum CodingKeys: String, CodingKey {
        case internalInternal = "internal"
    }
}

// MARK: Internal convenience initializers and mutators

extension Internal {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Internal.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Is
struct Is: Codable, Equatable {
    let isIs: Int

    enum CodingKeys: String, CodingKey {
        case isIs = "is"
    }
}

// MARK: Is convenience initializers and mutators

extension Is {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Is.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - JSON
struct JSON: Codable, Equatable {
    let jsonJSON: Int

    enum CodingKeys: String, CodingKey {
        case jsonJSON = "json"
    }
}

// MARK: JSON convenience initializers and mutators

extension JSON {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JSON.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Lazy
struct Lazy: Codable, Equatable {
    let lazyLazy: Int

    enum CodingKeys: String, CodingKey {
        case lazyLazy = "lazy"
    }
}

// MARK: Lazy convenience initializers and mutators

extension Lazy {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Lazy.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Left
struct Left: Codable, Equatable {
    let leftLeft: Int

    enum CodingKeys: String, CodingKey {
        case leftLeft = "left"
    }
}

// MARK: Left convenience initializers and mutators

extension Left {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Left.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Let
struct Let: Codable, Equatable {
    let letLet: Int

    enum CodingKeys: String, CodingKey {
        case letLet = "let"
    }
}

// MARK: Let convenience initializers and mutators

extension Let {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Let.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Obj4
struct Obj4: Codable, Equatable {
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
    let nsObject: NSObject
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
}

// MARK: Obj4 convenience initializers and mutators

extension Obj4 {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Obj4.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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
        nsObject: NSObject? = nil,
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Mutable
struct Mutable: Codable, Equatable {
    let mutable: Int

    enum CodingKeys: String, CodingKey {
        case mutable = "mutable"
    }
}

// MARK: Mutable convenience initializers and mutators

extension Mutable {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Mutable.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Namespace
struct Namespace: Codable, Equatable {
    let namespace: Int

    enum CodingKeys: String, CodingKey {
        case namespace = "namespace"
    }
}

// MARK: Namespace convenience initializers and mutators

extension Namespace {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Namespace.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Native
struct Native: Codable, Equatable {
    let native: Int

    enum CodingKeys: String, CodingKey {
        case native = "native"
    }
}

// MARK: Native convenience initializers and mutators

extension Native {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Native.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - New
struct New: Codable, Equatable {
    let new: Int

    enum CodingKeys: String, CodingKey {
        case new = "new"
    }
}

// MARK: New convenience initializers and mutators

extension New {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(New.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Newtonsoft
struct Newtonsoft: Codable, Equatable {
    let newtonsoft: Int

    enum CodingKeys: String, CodingKey {
        case newtonsoft = "newtonsoft"
    }
}

// MARK: Newtonsoft convenience initializers and mutators

extension Newtonsoft {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Newtonsoft.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - No
struct No: Codable, Equatable {
    let no: Int

    enum CodingKeys: String, CodingKey {
        case no = "NO"
    }
}

// MARK: No convenience initializers and mutators

extension No {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(No.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - NoSuchMethod
struct NoSuchMethod: Codable, Equatable {
    let noSuchMethod: Int

    enum CodingKeys: String, CodingKey {
        case noSuchMethod = "noSuchMethod"
    }
}

// MARK: NoSuchMethod convenience initializers and mutators

extension NoSuchMethod {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(NoSuchMethod.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Noexcept
struct Noexcept: Codable, Equatable {
    let noexcept: Int

    enum CodingKeys: String, CodingKey {
        case noexcept = "noexcept"
    }
}

// MARK: Noexcept convenience initializers and mutators

extension Noexcept {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Noexcept.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Nonatomic
struct Nonatomic: Codable, Equatable {
    let nonatomic: Int

    enum CodingKeys: String, CodingKey {
        case nonatomic = "nonatomic"
    }
}

// MARK: Nonatomic convenience initializers and mutators

extension Nonatomic {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Nonatomic.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - None
struct None: Codable, Equatable {
    let none: Int

    enum CodingKeys: String, CodingKey {
        case none = "None"
    }
}

// MARK: None convenience initializers and mutators

extension None {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(None.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Nonlocal
struct Nonlocal: Codable, Equatable {
    let nonlocal: Int

    enum CodingKeys: String, CodingKey {
        case nonlocal = "nonlocal"
    }
}

// MARK: Nonlocal convenience initializers and mutators

extension Nonlocal {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Nonlocal.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Not
struct Not: Codable, Equatable {
    let not: Int

    enum CodingKeys: String, CodingKey {
        case not = "not"
    }
}

// MARK: Not convenience initializers and mutators

extension Not {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Not.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - NotEq
struct NotEq: Codable, Equatable {
    let notEq: Int

    enum CodingKeys: String, CodingKey {
        case notEq = "not_eq"
    }
}

// MARK: NotEq convenience initializers and mutators

extension NotEq {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(NotEq.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - NSErrorClass
struct NSErrorClass: Codable, Equatable {
    let nsError: Int

    enum CodingKeys: String, CodingKey {
        case nsError = "NSError"
    }
}

// MARK: NSErrorClass convenience initializers and mutators

extension NSErrorClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(NSErrorClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - NSObject
struct NSObject: Codable, Equatable {
    let nsObject: Int

    enum CodingKeys: String, CodingKey {
        case nsObject = "NSObject"
    }
}

// MARK: NSObject convenience initializers and mutators

extension NSObject {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(NSObject.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        nsObject: Int? = nil
    ) -> NSObject {
        return NSObject(
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - NSString
struct NSString: Codable, Equatable {
    let nsString: Int

    enum CodingKeys: String, CodingKey {
        case nsString = "NSString"
    }
}

// MARK: NSString convenience initializers and mutators

extension NSString {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(NSString.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Null
struct Null: Codable, Equatable {
    let null: Int

    enum CodingKeys: String, CodingKey {
        case null = "NULL"
    }
}

// MARK: Null convenience initializers and mutators

extension Null {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Null.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - NullNode
struct NullNode: Codable, Equatable {
    let nullNode: Int

    enum CodingKeys: String, CodingKey {
        case nullNode = "NullNode"
    }
}

// MARK: NullNode convenience initializers and mutators

extension NullNode {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(NullNode.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Nullptr
struct Nullptr: Codable, Equatable {
    let nullptr: Int

    enum CodingKeys: String, CodingKey {
        case nullptr = "nullptr"
    }
}

// MARK: Nullptr convenience initializers and mutators

extension Nullptr {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Nullptr.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Number
struct Number: Codable, Equatable {
    let number: Int

    enum CodingKeys: String, CodingKey {
        case number = "number"
    }
}

// MARK: Number convenience initializers and mutators

extension Number {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Number.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Mutating
struct Mutating: Codable, Equatable {
    let mutatingMutating: Int

    enum CodingKeys: String, CodingKey {
        case mutatingMutating = "mutating"
    }
}

// MARK: Mutating convenience initializers and mutators

extension Mutating {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Mutating.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Nil
struct Nil: Codable, Equatable {
    let nilNil: Int

    enum CodingKeys: String, CodingKey {
        case nilNil = "nil"
    }
}

// MARK: Nil convenience initializers and mutators

extension Nil {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Nil.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - NoneClass
struct NoneClass: Codable, Equatable {
    let none: Int

    enum CodingKeys: String, CodingKey {
        case none = "none"
    }
}

// MARK: NoneClass convenience initializers and mutators

extension NoneClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(NoneClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Nonmutating
struct Nonmutating: Codable, Equatable {
    let nonmutatingNonmutating: Int

    enum CodingKeys: String, CodingKey {
        case nonmutatingNonmutating = "nonmutating"
    }
}

// MARK: Nonmutating convenience initializers and mutators

extension Nonmutating {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Nonmutating.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - NullClass
struct NullClass: Codable, Equatable {
    let null: Int

    enum CodingKeys: String, CodingKey {
        case null = "null"
    }
}

// MARK: NullClass convenience initializers and mutators

extension NullClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(NullClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Open
struct Open: Codable, Equatable {
    let openOpen: Int

    enum CodingKeys: String, CodingKey {
        case openOpen = "open"
    }
}

// MARK: Open convenience initializers and mutators

extension Open {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Open.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Operator
struct Operator: Codable, Equatable {
    let operatorOperator: Int

    enum CodingKeys: String, CodingKey {
        case operatorOperator = "operator"
    }
}

// MARK: Operator convenience initializers and mutators

extension Operator {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Operator.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Optional
struct Optional: Codable, Equatable {
    let optionalOptional: Int

    enum CodingKeys: String, CodingKey {
        case optionalOptional = "optional"
    }
}

// MARK: Optional convenience initializers and mutators

extension Optional {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Optional.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Override
struct Override: Codable, Equatable {
    let overrideOverride: Int

    enum CodingKeys: String, CodingKey {
        case overrideOverride = "override"
    }
}

// MARK: Override convenience initializers and mutators

extension Override {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Override.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Postfix
struct Postfix: Codable, Equatable {
    let postfixPostfix: Int

    enum CodingKeys: String, CodingKey {
        case postfixPostfix = "postfix"
    }
}

// MARK: Postfix convenience initializers and mutators

extension Postfix {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Postfix.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Precedence
struct Precedence: Codable, Equatable {
    let precedencePrecedence: Int

    enum CodingKeys: String, CodingKey {
        case precedencePrecedence = "precedence"
    }
}

// MARK: Precedence convenience initializers and mutators

extension Precedence {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Precedence.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Prefix
struct Prefix: Codable, Equatable {
    let prefixPrefix: Int

    enum CodingKeys: String, CodingKey {
        case prefixPrefix = "prefix"
    }
}

// MARK: Prefix convenience initializers and mutators

extension Prefix {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Prefix.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Private
struct Private: Codable, Equatable {
    let privatePrivate: Int

    enum CodingKeys: String, CodingKey {
        case privatePrivate = "private"
    }
}

// MARK: Private convenience initializers and mutators

extension Private {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Private.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - ProtocolClass
struct ProtocolClass: Codable, Equatable {
    let protocolProtocol: Int

    enum CodingKeys: String, CodingKey {
        case protocolProtocol = "Protocol"
    }
}

// MARK: ProtocolClass convenience initializers and mutators

extension ProtocolClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ProtocolClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Public
struct Public: Codable, Equatable {
    let publicPublic: Int

    enum CodingKeys: String, CodingKey {
        case publicPublic = "public"
    }
}

// MARK: Public convenience initializers and mutators

extension Public {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Public.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Object
struct Object: Codable, Equatable {
    let object: Int

    enum CodingKeys: String, CodingKey {
        case object = "object"
    }
}

// MARK: Object convenience initializers and mutators

extension Object {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Object.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - ObjectMapper
struct ObjectMapper: Codable, Equatable {
    let objectMapper: Int

    enum CodingKeys: String, CodingKey {
        case objectMapper = "ObjectMapper"
    }
}

// MARK: ObjectMapper convenience initializers and mutators

extension ObjectMapper {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ObjectMapper.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - ObjectNode
struct ObjectNode: Codable, Equatable {
    let objectNode: Int

    enum CodingKeys: String, CodingKey {
        case objectNode = "ObjectNode"
    }
}

// MARK: ObjectNode convenience initializers and mutators

extension ObjectNode {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ObjectNode.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - ObjectReader
struct ObjectReader: Codable, Equatable {
    let objectReader: Int

    enum CodingKeys: String, CodingKey {
        case objectReader = "ObjectReader"
    }
}

// MARK: ObjectReader convenience initializers and mutators

extension ObjectReader {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ObjectReader.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - ObjectWriter
struct ObjectWriter: Codable, Equatable {
    let objectWriter: Int

    enum CodingKeys: String, CodingKey {
        case objectWriter = "ObjectWriter"
    }
}

// MARK: ObjectWriter convenience initializers and mutators

extension ObjectWriter {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ObjectWriter.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Of
struct Of: Codable, Equatable {
    let of: Int

    enum CodingKeys: String, CodingKey {
        case of = "of"
    }
}

// MARK: Of convenience initializers and mutators

extension Of {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Of.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - OffsetDateTime
struct OffsetDateTime: Codable, Equatable {
    let offsetDateTime: Int

    enum CodingKeys: String, CodingKey {
        case offsetDateTime = "OffsetDateTime"
    }
}

// MARK: OffsetDateTime convenience initializers and mutators

extension OffsetDateTime {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(OffsetDateTime.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - OffsetTime
struct OffsetTime: Codable, Equatable {
    let offsetTime: Int

    enum CodingKeys: String, CodingKey {
        case offsetTime = "OffsetTime"
    }
}

// MARK: OffsetTime convenience initializers and mutators

extension OffsetTime {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(OffsetTime.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Oneway
struct Oneway: Codable, Equatable {
    let oneway: Int

    enum CodingKeys: String, CodingKey {
        case oneway = "oneway"
    }
}

// MARK: Oneway convenience initializers and mutators

extension Oneway {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Oneway.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Or
struct Or: Codable, Equatable {
    let or: Int

    enum CodingKeys: String, CodingKey {
        case or = "or"
    }
}

// MARK: Or convenience initializers and mutators

extension Or {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Or.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - OrEq
struct OrEq: Codable, Equatable {
    let orEq: Int

    enum CodingKeys: String, CodingKey {
        case orEq = "or_eq"
    }
}

// MARK: OrEq convenience initializers and mutators

extension OrEq {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(OrEq.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Out
struct Out: Codable, Equatable {
    let out: Int

    enum CodingKeys: String, CodingKey {
        case out = "out"
    }
}

// MARK: Out convenience initializers and mutators

extension Out {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Out.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Package
struct Package: Codable, Equatable {
    let package: Int

    enum CodingKeys: String, CodingKey {
        case package = "package"
    }
}

// MARK: Package convenience initializers and mutators

extension Package {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Package.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Params
struct Params: Codable, Equatable {
    let params: Int

    enum CodingKeys: String, CodingKey {
        case params = "params"
    }
}

// MARK: Params convenience initializers and mutators

extension Params {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Params.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Pass
struct Pass: Codable, Equatable {
    let pass: Int

    enum CodingKeys: String, CodingKey {
        case pass = "pass"
    }
}

// MARK: Pass convenience initializers and mutators

extension Pass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Pass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Port
struct Port: Codable, Equatable {
    let port: Int

    enum CodingKeys: String, CodingKey {
        case port = "port"
    }
}

// MARK: Port convenience initializers and mutators

extension Port {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Port.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Print
struct Print: Codable, Equatable {
    let print: Int

    enum CodingKeys: String, CodingKey {
        case print = "print"
    }
}

// MARK: Print convenience initializers and mutators

extension Print {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Print.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - PrintMembers
struct PrintMembers: Codable, Equatable {
    let printMembers: Int

    enum CodingKeys: String, CodingKey {
        case printMembers = "printMembers"
    }
}

// MARK: PrintMembers convenience initializers and mutators

extension PrintMembers {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PrintMembers.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Printf
struct Printf: Codable, Equatable {
    let printf: Int

    enum CodingKeys: String, CodingKey {
        case printf = "printf"
    }
}

// MARK: Printf convenience initializers and mutators

extension Printf {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Printf.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Protected
struct Protected: Codable, Equatable {
    let protected: Int

    enum CodingKeys: String, CodingKey {
        case protected = "protected"
    }
}

// MARK: Protected convenience initializers and mutators

extension Protected {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Protected.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Obj4Protocol
struct Obj4Protocol: Codable, Equatable {
    let protocolProtocol: Int

    enum CodingKeys: String, CodingKey {
        case protocolProtocol = "protocol"
    }
}

// MARK: Obj4Protocol convenience initializers and mutators

extension Obj4Protocol {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Obj4Protocol.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Quicktype
struct Quicktype: Codable, Equatable {
    let quicktype: Int

    enum CodingKeys: String, CodingKey {
        case quicktype = "quicktype"
    }
}

// MARK: Quicktype convenience initializers and mutators

extension Quicktype {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Quicktype.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Raise
struct Raise: Codable, Equatable {
    let raise: Int

    enum CodingKeys: String, CodingKey {
        case raise = "raise"
    }
}

// MARK: Raise convenience initializers and mutators

extension Raise {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Raise.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Range
struct Range: Codable, Equatable {
    let range: Int

    enum CodingKeys: String, CodingKey {
        case range = "range"
    }
}

// MARK: Range convenience initializers and mutators

extension Range {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Range.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Readonly
struct Readonly: Codable, Equatable {
    let readonly: Int

    enum CodingKeys: String, CodingKey {
        case readonly = "readonly"
    }
}

// MARK: Readonly convenience initializers and mutators

extension Readonly {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Readonly.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Ref
struct Ref: Codable, Equatable {
    let ref: Int

    enum CodingKeys: String, CodingKey {
        case ref = "ref"
    }
}

// MARK: Ref convenience initializers and mutators

extension Ref {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Ref.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - RegExp
struct RegExp: Codable, Equatable {
    let regExp: UUID

    enum CodingKeys: String, CodingKey {
        case regExp = "RegExp"
    }
}

// MARK: RegExp convenience initializers and mutators

extension RegExp {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(RegExp.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Register
struct Register: Codable, Equatable {
    let register: Int

    enum CodingKeys: String, CodingKey {
        case register = "register"
    }
}

// MARK: Register convenience initializers and mutators

extension Register {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Register.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - ReinterpretCast
struct ReinterpretCast: Codable, Equatable {
    let reinterpretCast: Int

    enum CodingKeys: String, CodingKey {
        case reinterpretCast = "reinterpret_cast"
    }
}

// MARK: ReinterpretCast convenience initializers and mutators

extension ReinterpretCast {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ReinterpretCast.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Obj5
struct Obj5: Codable, Equatable {
    let dummy: Int
    let kSerializer: KSerializer
    let obj5Repeat: Repeat
    let obj5Required: Required
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
    let retain: Retain
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
        case retain = "retain"
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
}

// MARK: Obj5 convenience initializers and mutators

extension Obj5 {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Obj5.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        dummy: Int? = nil,
        kSerializer: KSerializer? = nil,
        obj5Repeat: Repeat? = nil,
        obj5Required: Required? = nil,
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
        retain: Retain? = nil,
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
            retain: retain ?? self.retain,
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - KSerializer
struct KSerializer: Codable, Equatable {
    let kSerializer: Int

    enum CodingKeys: String, CodingKey {
        case kSerializer = "KSerializer"
    }
}

// MARK: KSerializer convenience initializers and mutators

extension KSerializer {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(KSerializer.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Repeat
struct Repeat: Codable, Equatable {
    let repeatRepeat: Int

    enum CodingKeys: String, CodingKey {
        case repeatRepeat = "repeat"
    }
}

// MARK: Repeat convenience initializers and mutators

extension Repeat {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Repeat.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Required
struct Required: Codable, Equatable {
    let requiredRequired: Int

    enum CodingKeys: String, CodingKey {
        case requiredRequired = "required"
    }
}

// MARK: Required convenience initializers and mutators

extension Required {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Required.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Rethrows
struct Rethrows: Codable, Equatable {
    let rethrowsRethrows: Int

    enum CodingKeys: String, CodingKey {
        case rethrowsRethrows = "rethrows"
    }
}

// MARK: Rethrows convenience initializers and mutators

extension Rethrows {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Rethrows.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Return
struct Return: Codable, Equatable {
    let returnReturn: Int

    enum CodingKeys: String, CodingKey {
        case returnReturn = "return"
    }
}

// MARK: Return convenience initializers and mutators

extension Return {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Return.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Right
struct Right: Codable, Equatable {
    let rightRight: Int

    enum CodingKeys: String, CodingKey {
        case rightRight = "right"
    }
}

// MARK: Right convenience initializers and mutators

extension Right {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Right.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - SelfClass
struct SelfClass: Codable, Equatable {
    let selfSelf: Int

    enum CodingKeys: String, CodingKey {
        case selfSelf = "Self"
    }
}

// MARK: SelfClass convenience initializers and mutators

extension SelfClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SelfClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Set
struct Set: Codable, Equatable {
    let setSet: Int

    enum CodingKeys: String, CodingKey {
        case setSet = "set"
    }
}

// MARK: Set convenience initializers and mutators

extension Set {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Set.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Static
struct Static: Codable, Equatable {
    let staticStatic: Int

    enum CodingKeys: String, CodingKey {
        case staticStatic = "static"
    }
}

// MARK: Static convenience initializers and mutators

extension Static {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Static.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Struct
struct Struct: Codable, Equatable {
    let structStruct: Int

    enum CodingKeys: String, CodingKey {
        case structStruct = "struct"
    }
}

// MARK: Struct convenience initializers and mutators

extension Struct {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Struct.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Subscript
struct Subscript: Codable, Equatable {
    let subscriptSubscript: Int

    enum CodingKeys: String, CodingKey {
        case subscriptSubscript = "subscript"
    }
}

// MARK: Subscript convenience initializers and mutators

extension Subscript {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Subscript.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Super
struct Super: Codable, Equatable {
    let superSuper: Int

    enum CodingKeys: String, CodingKey {
        case superSuper = "super"
    }
}

// MARK: Super convenience initializers and mutators

extension Super {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Super.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Switch
struct Switch: Codable, Equatable {
    let switchSwitch: Int

    enum CodingKeys: String, CodingKey {
        case switchSwitch = "switch"
    }
}

// MARK: Switch convenience initializers and mutators

extension Switch {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Switch.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Throw
struct Throw: Codable, Equatable {
    let throwThrow: Int

    enum CodingKeys: String, CodingKey {
        case throwThrow = "throw"
    }
}

// MARK: Throw convenience initializers and mutators

extension Throw {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Throw.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Throws
struct Throws: Codable, Equatable {
    let throwsThrows: Int

    enum CodingKeys: String, CodingKey {
        case throwsThrows = "throws"
    }
}

// MARK: Throws convenience initializers and mutators

extension Throws {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Throws.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - True
struct True: Codable, Equatable {
    let trueTrue: Int

    enum CodingKeys: String, CodingKey {
        case trueTrue = "True"
    }
}

// MARK: True convenience initializers and mutators

extension True {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(True.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - PrimitiveKind
struct PrimitiveKind: Codable, Equatable {
    let primitiveKind: Int

    enum CodingKeys: String, CodingKey {
        case primitiveKind = "PrimitiveKind"
    }
}

// MARK: PrimitiveKind convenience initializers and mutators

extension PrimitiveKind {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PrimitiveKind.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Obj5Self
struct Obj5Self: Codable, Equatable {
    let selfSelf: Int

    enum CodingKeys: String, CodingKey {
        case selfSelf = "self"
    }
}

// MARK: Obj5Self convenience initializers and mutators

extension Obj5Self {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Obj5Self.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - TrueClass
struct TrueClass: Codable, Equatable {
    let trueTrue: Int

    enum CodingKeys: String, CodingKey {
        case trueTrue = "true"
    }
}

// MARK: TrueClass convenience initializers and mutators

extension TrueClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TrueClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Require
struct Require: Codable, Equatable {
    let require: Int

    enum CodingKeys: String, CodingKey {
        case require = "require"
    }
}

// MARK: Require convenience initializers and mutators

extension Require {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Require.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Requires
struct Requires: Codable, Equatable {
    let requires: Int

    enum CodingKeys: String, CodingKey {
        case requires = "requires"
    }
}

// MARK: Requires convenience initializers and mutators

extension Requires {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Requires.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Restrict
struct Restrict: Codable, Equatable {
    let restrict: Int

    enum CodingKeys: String, CodingKey {
        case restrict = "restrict"
    }
}

// MARK: Restrict convenience initializers and mutators

extension Restrict {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Restrict.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Retain
struct Retain: Codable, Equatable {
    let retain: Int

    enum CodingKeys: String, CodingKey {
        case retain = "retain"
    }
}

// MARK: Retain convenience initializers and mutators

extension Retain {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Retain.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        retain: Int? = nil
    ) -> Retain {
        return Retain(
            retain: retain ?? self.retain
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - RuntimeType
struct RuntimeType: Codable, Equatable {
    let runtimeType: Int

    enum CodingKeys: String, CodingKey {
        case runtimeType = "runtimeType"
    }
}

// MARK: RuntimeType convenience initializers and mutators

extension RuntimeType {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(RuntimeType.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - S
struct S: Codable, Equatable {
    let s: Int

    enum CodingKeys: String, CodingKey {
        case s = "s"
    }
}

// MARK: S convenience initializers and mutators

extension S {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(S.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Sbyte
struct Sbyte: Codable, Equatable {
    let sbyte: Int

    enum CodingKeys: String, CodingKey {
        case sbyte = "sbyte"
    }
}

// MARK: Sbyte convenience initializers and mutators

extension Sbyte {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Sbyte.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Sealed
struct Sealed: Codable, Equatable {
    let sealed: Int

    enum CodingKeys: String, CodingKey {
        case sealed = "sealed"
    }
}

// MARK: Sealed convenience initializers and mutators

extension Sealed {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Sealed.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Sel
struct Sel: Codable, Equatable {
    let sel: Int

    enum CodingKeys: String, CodingKey {
        case sel = "SEL"
    }
}

// MARK: Sel convenience initializers and mutators

extension Sel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Sel.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Select
struct Select: Codable, Equatable {
    let select: Int

    enum CodingKeys: String, CodingKey {
        case select = "select"
    }
}

// MARK: Select convenience initializers and mutators

extension Select {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Select.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Sendable
struct Sendable: Codable, Equatable {
    let sendable: Int

    enum CodingKeys: String, CodingKey {
        case sendable = "Sendable"
    }
}

// MARK: Sendable convenience initializers and mutators

extension Sendable {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Sendable.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - SerialDescriptor
struct SerialDescriptor: Codable, Equatable {
    let serialDescriptor: Int

    enum CodingKeys: String, CodingKey {
        case serialDescriptor = "SerialDescriptor"
    }
}

// MARK: SerialDescriptor convenience initializers and mutators

extension SerialDescriptor {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SerialDescriptor.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - SerialName
struct SerialName: Codable, Equatable {
    let serialName: Int

    enum CodingKeys: String, CodingKey {
        case serialName = "SerialName"
    }
}

// MARK: SerialName convenience initializers and mutators

extension SerialName {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SerialName.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Serializable
struct Serializable: Codable, Equatable {
    let serializable: Int

    enum CodingKeys: String, CodingKey {
        case serializable = "Serializable"
    }
}

// MARK: Serializable convenience initializers and mutators

extension Serializable {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Serializable.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - SerializationFeature
struct SerializationFeature: Codable, Equatable {
    let serializationFeature: Int

    enum CodingKeys: String, CodingKey {
        case serializationFeature = "SerializationFeature"
    }
}

// MARK: SerializationFeature convenience initializers and mutators

extension SerializationFeature {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SerializationFeature.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Serialize
struct Serialize: Codable, Equatable {
    let serialize: Int

    enum CodingKeys: String, CodingKey {
        case serialize = "serialize"
    }
}

// MARK: Serialize convenience initializers and mutators

extension Serialize {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Serialize.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - SerializerProvider
struct SerializerProvider: Codable, Equatable {
    let serializerProvider: Int

    enum CodingKeys: String, CodingKey {
        case serializerProvider = "SerializerProvider"
    }
}

// MARK: SerializerProvider convenience initializers and mutators

extension SerializerProvider {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SerializerProvider.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Short
struct Short: Codable, Equatable {
    let short: Int

    enum CodingKeys: String, CodingKey {
        case short = "short"
    }
}

// MARK: Short convenience initializers and mutators

extension Short {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Short.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Signed
struct Signed: Codable, Equatable {
    let signed: Int

    enum CodingKeys: String, CodingKey {
        case signed = "signed"
    }
}

// MARK: Signed convenience initializers and mutators

extension Signed {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Signed.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - SimpleModule
struct SimpleModule: Codable, Equatable {
    let simpleModule: Int

    enum CodingKeys: String, CodingKey {
        case simpleModule = "SimpleModule"
    }
}

// MARK: SimpleModule convenience initializers and mutators

extension SimpleModule {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SimpleModule.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Sizeof
struct Sizeof: Codable, Equatable {
    let sizeof: Int

    enum CodingKeys: String, CodingKey {
        case sizeof = "sizeof"
    }
}

// MARK: Sizeof convenience initializers and mutators

extension Sizeof {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Sizeof.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Stackalloc
struct Stackalloc: Codable, Equatable {
    let stackalloc: Int

    enum CodingKeys: String, CodingKey {
        case stackalloc = "stackalloc"
    }
}

// MARK: Stackalloc convenience initializers and mutators

extension Stackalloc {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Stackalloc.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Standards
struct Standards: Codable, Equatable {
    let standards: Int

    enum CodingKeys: String, CodingKey {
        case standards = "Standards"
    }
}

// MARK: Standards convenience initializers and mutators

extension Standards {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Standards.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - StaticAssert
struct StaticAssert: Codable, Equatable {
    let staticAssert: Int

    enum CodingKeys: String, CodingKey {
        case staticAssert = "static_assert"
    }
}

// MARK: StaticAssert convenience initializers and mutators

extension StaticAssert {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(StaticAssert.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - StaticCast
struct StaticCast: Codable, Equatable {
    let staticCast: Int

    enum CodingKeys: String, CodingKey {
        case staticCast = "static_cast"
    }
}

// MARK: StaticCast convenience initializers and mutators

extension StaticCast {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(StaticCast.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - StdDeserializer
struct StdDeserializer: Codable, Equatable {
    let stdDeserializer: Int

    enum CodingKeys: String, CodingKey {
        case stdDeserializer = "StdDeserializer"
    }
}

// MARK: StdDeserializer convenience initializers and mutators

extension StdDeserializer {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(StdDeserializer.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - StdSerializer
struct StdSerializer: Codable, Equatable {
    let stdSerializer: Int

    enum CodingKeys: String, CodingKey {
        case stdSerializer = "StdSerializer"
    }
}

// MARK: StdSerializer convenience initializers and mutators

extension StdSerializer {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(StdSerializer.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Strictfp
struct Strictfp: Codable, Equatable {
    let strictfp: Int

    enum CodingKeys: String, CodingKey {
        case strictfp = "strictfp"
    }
}

// MARK: Strictfp convenience initializers and mutators

extension Strictfp {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Strictfp.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - StringClass
struct StringClass: Codable, Equatable {
    let string: Int

    enum CodingKeys: String, CodingKey {
        case string = "string"
    }
}

// MARK: StringClass convenience initializers and mutators

extension StringClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(StringClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Symbol
struct Symbol: Codable, Equatable {
    let symbol: Int

    enum CodingKeys: String, CodingKey {
        case symbol = "symbol"
    }
}

// MARK: Symbol convenience initializers and mutators

extension Symbol {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Symbol.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Synchronized
struct Synchronized: Codable, Equatable {
    let synchronized: Int

    enum CodingKeys: String, CodingKey {
        case synchronized = "synchronized"
    }
}

// MARK: Synchronized convenience initializers and mutators

extension Synchronized {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Synchronized.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - System
struct System: Codable, Equatable {
    let system: Int

    enum CodingKeys: String, CodingKey {
        case system = "system"
    }
}

// MARK: System convenience initializers and mutators

extension System {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(System.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Template
struct Template: Codable, Equatable {
    let template: Int

    enum CodingKeys: String, CodingKey {
        case template = "template"
    }
}

// MARK: Template convenience initializers and mutators

extension Template {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Template.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - TextNode
struct TextNode: Codable, Equatable {
    let textNode: Int

    enum CodingKeys: String, CodingKey {
        case textNode = "TextNode"
    }
}

// MARK: TextNode convenience initializers and mutators

extension TextNode {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TextNode.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Then
struct Then: Codable, Equatable {
    let then: Int

    enum CodingKeys: String, CodingKey {
        case then = "then"
    }
}

// MARK: Then convenience initializers and mutators

extension Then {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Then.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - This
struct This: Codable, Equatable {
    let this: Int

    enum CodingKeys: String, CodingKey {
        case this = "this"
    }
}

// MARK: This convenience initializers and mutators

extension This {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(This.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - ThreadLocal
struct ThreadLocal: Codable, Equatable {
    let threadLocal: Int

    enum CodingKeys: String, CodingKey {
        case threadLocal = "thread_local"
    }
}

// MARK: ThreadLocal convenience initializers and mutators

extension ThreadLocal {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ThreadLocal.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - TimeOnly
struct TimeOnly: Codable, Equatable {
    let timeOnly: Int

    enum CodingKeys: String, CodingKey {
        case timeOnly = "TimeOnly"
    }
}

// MARK: TimeOnly convenience initializers and mutators

extension TimeOnly {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TimeOnly.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - TimeOnlyConverter
struct TimeOnlyConverter: Codable, Equatable {
    let timeOnlyConverter: Int

    enum CodingKeys: String, CodingKey {
        case timeOnlyConverter = "TimeOnlyConverter"
    }
}

// MARK: TimeOnlyConverter convenience initializers and mutators

extension TimeOnlyConverter {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TimeOnlyConverter.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - TimeZoneClass
struct TimeZoneClass: Codable, Equatable {
    let timeZone: Int

    enum CodingKeys: String, CodingKey {
        case timeZone = "TimeZone"
    }
}

// MARK: TimeZoneClass convenience initializers and mutators

extension TimeZoneClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TimeZoneClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - ToDict
struct ToDict: Codable, Equatable {
    let toDict: Int

    enum CodingKeys: String, CodingKey {
        case toDict = "to_dict"
    }
}

// MARK: ToDict convenience initializers and mutators

extension ToDict {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ToDict.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - ToJSON
struct ToJSON: Codable, Equatable {
    let toJSON: Int

    enum CodingKeys: String, CodingKey {
        case toJSON = "to_json"
    }
}

// MARK: ToJSON convenience initializers and mutators

extension ToJSON {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ToJSON.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - ToString
struct ToString: Codable, Equatable {
    let toString: Int

    enum CodingKeys: String, CodingKey {
        case toString = "toString"
    }
}

// MARK: ToString convenience initializers and mutators

extension ToString {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ToString.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - TopLevelClass
struct TopLevelClass: Codable, Equatable {
    let topLevel: Int

    enum CodingKeys: String, CodingKey {
        case topLevel = "top_level"
    }
}

// MARK: TopLevelClass convenience initializers and mutators

extension TopLevelClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TopLevelClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Transient
struct Transient: Codable, Equatable {
    let transient: Int

    enum CodingKeys: String, CodingKey {
        case transient = "transient"
    }
}

// MARK: Transient convenience initializers and mutators

extension Transient {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Transient.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Obj6
struct Obj6: Codable, Equatable {
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
}

// MARK: Obj6 convenience initializers and mutators

extension Obj6 {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Obj6.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Try
struct Try: Codable, Equatable {
    let tryTry: Int

    enum CodingKeys: String, CodingKey {
        case tryTry = "try"
    }
}

// MARK: Try convenience initializers and mutators

extension Try {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Try.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Obj6Type
struct Obj6Type: Codable, Equatable {
    let type: Int

    enum CodingKeys: String, CodingKey {
        case type = "type"
    }
}

// MARK: Obj6Type convenience initializers and mutators

extension Obj6Type {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Obj6Type.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Typealias
struct Typealias: Codable, Equatable {
    let typealiasTypealias: Int

    enum CodingKeys: String, CodingKey {
        case typealiasTypealias = "typealias"
    }
}

// MARK: Typealias convenience initializers and mutators

extension Typealias {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Typealias.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Unowned
struct Unowned: Codable, Equatable {
    let unownedUnowned: Int

    enum CodingKeys: String, CodingKey {
        case unownedUnowned = "unowned"
    }
}

// MARK: Unowned convenience initializers and mutators

extension Unowned {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Unowned.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Var
struct Var: Codable, Equatable {
    let varVar: Int

    enum CodingKeys: String, CodingKey {
        case varVar = "var"
    }
}

// MARK: Var convenience initializers and mutators

extension Var {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Var.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Weak
struct Weak: Codable, Equatable {
    let weakWeak: Int

    enum CodingKeys: String, CodingKey {
        case weakWeak = "weak"
    }
}

// MARK: Weak convenience initializers and mutators

extension Weak {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Weak.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Where
struct Where: Codable, Equatable {
    let whereWhere: Int

    enum CodingKeys: String, CodingKey {
        case whereWhere = "where"
    }
}

// MARK: Where convenience initializers and mutators

extension Where {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Where.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - While
struct While: Codable, Equatable {
    let whileWhile: Int

    enum CodingKeys: String, CodingKey {
        case whileWhile = "while"
    }
}

// MARK: While convenience initializers and mutators

extension While {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(While.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - WillSet
struct WillSet: Codable, Equatable {
    let willSetWillSet: Int

    enum CodingKeys: String, CodingKey {
        case willSetWillSet = "willSet"
    }
}

// MARK: WillSet convenience initializers and mutators

extension WillSet {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(WillSet.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - TypeClass
struct TypeClass: Codable, Equatable {
    let type: Int

    enum CodingKeys: String, CodingKey {
        case type = "Type"
    }
}

// MARK: TypeClass convenience initializers and mutators

extension TypeClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TypeClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Typedef
struct Typedef: Codable, Equatable {
    let typedef: Int

    enum CodingKeys: String, CodingKey {
        case typedef = "typedef"
    }
}

// MARK: Typedef convenience initializers and mutators

extension Typedef {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Typedef.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Typeid
struct Typeid: Codable, Equatable {
    let typeid: Int

    enum CodingKeys: String, CodingKey {
        case typeid = "typeid"
    }
}

// MARK: Typeid convenience initializers and mutators

extension Typeid {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Typeid.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Typename
struct Typename: Codable, Equatable {
    let typename: Int

    enum CodingKeys: String, CodingKey {
        case typename = "typename"
    }
}

// MARK: Typename convenience initializers and mutators

extension Typename {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Typename.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Typeof
struct Typeof: Codable, Equatable {
    let typeof: Int

    enum CodingKeys: String, CodingKey {
        case typeof = "typeof"
    }
}

// MARK: Typeof convenience initializers and mutators

extension Typeof {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Typeof.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Uint
struct Uint: Codable, Equatable {
    let uint: Int

    enum CodingKeys: String, CodingKey {
        case uint = "uint"
    }
}

// MARK: Uint convenience initializers and mutators

extension Uint {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Uint.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Ulong
struct Ulong: Codable, Equatable {
    let ulong: Int

    enum CodingKeys: String, CodingKey {
        case ulong = "ulong"
    }
}

// MARK: Ulong convenience initializers and mutators

extension Ulong {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Ulong.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Unchecked
struct Unchecked: Codable, Equatable {
    let unchecked: Int

    enum CodingKeys: String, CodingKey {
        case unchecked = "unchecked"
    }
}

// MARK: Unchecked convenience initializers and mutators

extension Unchecked {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Unchecked.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Undefined
struct Undefined: Codable, Equatable {
    let undefined: Int

    enum CodingKeys: String, CodingKey {
        case undefined = "undefined"
    }
}

// MARK: Undefined convenience initializers and mutators

extension Undefined {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Undefined.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Union
struct Union: Codable, Equatable {
    let union: Int

    enum CodingKeys: String, CodingKey {
        case union = "union"
    }
}

// MARK: Union convenience initializers and mutators

extension Union {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Union.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - UnmarshalJSON
struct UnmarshalJSON: Codable, Equatable {
    let unmarshalJSON: Int

    enum CodingKeys: String, CodingKey {
        case unmarshalJSON = "UnmarshalJSON"
    }
}

// MARK: UnmarshalJSON convenience initializers and mutators

extension UnmarshalJSON {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(UnmarshalJSON.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Unsafe
struct Unsafe: Codable, Equatable {
    let unsafe: Int

    enum CodingKeys: String, CodingKey {
        case unsafe = "unsafe"
    }
}

// MARK: Unsafe convenience initializers and mutators

extension Unsafe {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Unsafe.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Unsigned
struct Unsigned: Codable, Equatable {
    let unsigned: Int

    enum CodingKeys: String, CodingKey {
        case unsigned = "unsigned"
    }
}

// MARK: Unsigned convenience initializers and mutators

extension Unsigned {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Unsigned.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - UseSerializers
struct UseSerializers: Codable, Equatable {
    let useSerializers: Int

    enum CodingKeys: String, CodingKey {
        case useSerializers = "UseSerializers"
    }
}

// MARK: UseSerializers convenience initializers and mutators

extension UseSerializers {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(UseSerializers.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Ushort
struct Ushort: Codable, Equatable {
    let ushort: Int

    enum CodingKeys: String, CodingKey {
        case ushort = "ushort"
    }
}

// MARK: Ushort convenience initializers and mutators

extension Ushort {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Ushort.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Using
struct Using: Codable, Equatable {
    let using: Int

    enum CodingKeys: String, CodingKey {
        case using = "using"
    }
}

// MARK: Using convenience initializers and mutators

extension Using {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Using.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Utf8JSONReader
struct Utf8JSONReader: Codable, Equatable {
    let utf8JSONReader: Int

    enum CodingKeys: String, CodingKey {
        case utf8JSONReader = "Utf8JsonReader"
    }
}

// MARK: Utf8JSONReader convenience initializers and mutators

extension Utf8JSONReader {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Utf8JSONReader.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Utf8JSONWriter
struct Utf8JSONWriter: Codable, Equatable {
    let utf8JSONWriter: Int

    enum CodingKeys: String, CodingKey {
        case utf8JSONWriter = "Utf8JsonWriter"
    }
}

// MARK: Utf8JSONWriter convenience initializers and mutators

extension Utf8JSONWriter {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Utf8JSONWriter.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - UUIDClass
struct UUIDClass: Codable, Equatable {
    let uuid: Int

    enum CodingKeys: String, CodingKey {
        case uuid = "UUID"
    }
}

// MARK: UUIDClass convenience initializers and mutators

extension UUIDClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(UUIDClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Virtual
struct Virtual: Codable, Equatable {
    let virtual: Int

    enum CodingKeys: String, CodingKey {
        case virtual = "virtual"
    }
}

// MARK: Virtual convenience initializers and mutators

extension Virtual {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Virtual.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Void
struct Void: Codable, Equatable {
    let void: Int

    enum CodingKeys: String, CodingKey {
        case void = "void"
    }
}

// MARK: Void convenience initializers and mutators

extension Void {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Void.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Volatile
struct Volatile: Codable, Equatable {
    let volatile: Int

    enum CodingKeys: String, CodingKey {
        case volatile = "volatile"
    }
}

// MARK: Volatile convenience initializers and mutators

extension Volatile {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Volatile.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - WcharT
struct WcharT: Codable, Equatable {
    let wcharT: Int

    enum CodingKeys: String, CodingKey {
        case wcharT = "wchar_t"
    }
}

// MARK: WcharT convenience initializers and mutators

extension WcharT {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(WcharT.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - With
struct With: Codable, Equatable {
    let with: Int

    enum CodingKeys: String, CodingKey {
        case with = "with"
    }
}

// MARK: With convenience initializers and mutators

extension With {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(With.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Xor
struct Xor: Codable, Equatable {
    let xor: Int

    enum CodingKeys: String, CodingKey {
        case xor = "xor"
    }
}

// MARK: Xor convenience initializers and mutators

extension Xor {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Xor.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - XorEq
struct XorEq: Codable, Equatable {
    let xorEq: Int

    enum CodingKeys: String, CodingKey {
        case xorEq = "xor_eq"
    }
}

// MARK: XorEq convenience initializers and mutators

extension XorEq {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(XorEq.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Yes
struct Yes: Codable, Equatable {
    let yes: Int

    enum CodingKeys: String, CodingKey {
        case yes = "YES"
    }
}

// MARK: Yes convenience initializers and mutators

extension Yes {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Yes.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Yield
struct Yield: Codable, Equatable {
    let yield: Int

    enum CodingKeys: String, CodingKey {
        case yield = "yield"
    }
}

// MARK: Yield convenience initializers and mutators

extension Yield {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Yield.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
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

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }

    public init() {}

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
