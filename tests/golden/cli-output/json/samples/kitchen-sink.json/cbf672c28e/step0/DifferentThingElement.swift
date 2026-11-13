import Foundation

enum DifferentThingElement: Codable {
    case differentThingClass(DifferentThingClass)
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(DifferentThingClass.self) {
            self = .differentThingClass(x)
            return
        }
        throw DecodingError.typeMismatch(DifferentThingElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for DifferentThingElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .differentThingClass(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
