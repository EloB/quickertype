// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let txs: [Tx]

    enum CodingKeys: String, CodingKey {
        case txs = "txs"
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
        txs: [Tx]? = nil
    ) -> TopLevel {
        return TopLevel(
            txs: txs ?? self.txs
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Tx
struct Tx: Codable {
    let doubleSpend: Bool
    let hash: String
    let inputs: [Input]
    let lockTime: Int
    let out: [Out]
    let relayedBy: String
    let size: Int
    let time: Int
    let txIndex: Int
    let ver: Int
    let vinSz: Int
    let voutSz: Int

    enum CodingKeys: String, CodingKey {
        case doubleSpend = "double_spend"
        case hash = "hash"
        case inputs = "inputs"
        case lockTime = "lock_time"
        case out = "out"
        case relayedBy = "relayed_by"
        case size = "size"
        case time = "time"
        case txIndex = "tx_index"
        case ver = "ver"
        case vinSz = "vin_sz"
        case voutSz = "vout_sz"
    }
}

// MARK: Tx convenience initializers and mutators

extension Tx {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Tx.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        doubleSpend: Bool? = nil,
        hash: String? = nil,
        inputs: [Input]? = nil,
        lockTime: Int? = nil,
        out: [Out]? = nil,
        relayedBy: String? = nil,
        size: Int? = nil,
        time: Int? = nil,
        txIndex: Int? = nil,
        ver: Int? = nil,
        vinSz: Int? = nil,
        voutSz: Int? = nil
    ) -> Tx {
        return Tx(
            doubleSpend: doubleSpend ?? self.doubleSpend,
            hash: hash ?? self.hash,
            inputs: inputs ?? self.inputs,
            lockTime: lockTime ?? self.lockTime,
            out: out ?? self.out,
            relayedBy: relayedBy ?? self.relayedBy,
            size: size ?? self.size,
            time: time ?? self.time,
            txIndex: txIndex ?? self.txIndex,
            ver: ver ?? self.ver,
            vinSz: vinSz ?? self.vinSz,
            voutSz: voutSz ?? self.voutSz
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Input
struct Input: Codable {
    let prevOut: Out
    let script: String
    let sequence: Int

    enum CodingKeys: String, CodingKey {
        case prevOut = "prev_out"
        case script = "script"
        case sequence = "sequence"
    }
}

// MARK: Input convenience initializers and mutators

extension Input {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Input.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        prevOut: Out? = nil,
        script: String? = nil,
        sequence: Int? = nil
    ) -> Input {
        return Input(
            prevOut: prevOut ?? self.prevOut,
            script: script ?? self.script,
            sequence: sequence ?? self.sequence
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
struct Out: Codable {
    let addr: String
    let n: Int
    let script: String
    let spent: Bool
    let txIndex: Int
    let type: Int
    let value: Int

    enum CodingKeys: String, CodingKey {
        case addr = "addr"
        case n = "n"
        case script = "script"
        case spent = "spent"
        case txIndex = "tx_index"
        case type = "type"
        case value = "value"
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
        addr: String? = nil,
        n: Int? = nil,
        script: String? = nil,
        spent: Bool? = nil,
        txIndex: Int? = nil,
        type: Int? = nil,
        value: Int? = nil
    ) -> Out {
        return Out(
            addr: addr ?? self.addr,
            n: n ?? self.n,
            script: script ?? self.script,
            spent: spent ?? self.spent,
            txIndex: txIndex ?? self.txIndex,
            type: type ?? self.type,
            value: value ?? self.value
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
