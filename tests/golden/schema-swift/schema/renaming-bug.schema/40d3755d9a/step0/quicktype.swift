// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let version: String?
    let fruits: [Fruit]?
    let vehicles: [Vehicle]?

    enum CodingKeys: String, CodingKey {
        case version = "version"
        case fruits = "fruits"
        case vehicles = "vehicles"
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
        version: String?? = nil,
        fruits: [Fruit]?? = nil,
        vehicles: [Vehicle]?? = nil
    ) -> TopLevel {
        return TopLevel(
            version: version ?? self.version,
            fruits: fruits ?? self.fruits,
            vehicles: vehicles ?? self.vehicles
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Fruit
struct Fruit: Codable {
    let apple: Bool?
    let berries: [Berry]?
    let orange: Bool?

    enum CodingKeys: String, CodingKey {
        case apple = "apple"
        case berries = "berries"
        case orange = "orange"
    }
}

// MARK: Fruit convenience initializers and mutators

extension Fruit {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Fruit.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        apple: Bool?? = nil,
        berries: [Berry]?? = nil,
        orange: Bool?? = nil
    ) -> Fruit {
        return Fruit(
            apple: apple ?? self.apple,
            berries: berries ?? self.berries,
            orange: orange ?? self.orange
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Berry
struct Berry: Codable {
    let color: Color?
    let name: String?
    let shapes: [Shape]?

    enum CodingKeys: String, CodingKey {
        case color = "color"
        case name = "name"
        case shapes = "shapes"
    }
}

// MARK: Berry convenience initializers and mutators

extension Berry {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Berry.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        color: Color?? = nil,
        name: String?? = nil,
        shapes: [Shape]?? = nil
    ) -> Berry {
        return Berry(
            color: color ?? self.color,
            name: name ?? self.name,
            shapes: shapes ?? self.shapes
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Color
struct Color: Codable {
    let rgb: Double?

    enum CodingKeys: String, CodingKey {
        case rgb = "rgb"
    }
}

// MARK: Color convenience initializers and mutators

extension Color {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Color.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        rgb: Double?? = nil
    ) -> Color {
        return Color(
            rgb: rgb ?? self.rgb
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Shape
struct Shape: Codable {
    let geometry: Geometry?
    let history: History?

    enum CodingKeys: String, CodingKey {
        case geometry = "geometry"
        case history = "history"
    }
}

// MARK: Shape convenience initializers and mutators

extension Shape {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Shape.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        geometry: Geometry?? = nil,
        history: History?? = nil
    ) -> Shape {
        return Shape(
            geometry: geometry ?? self.geometry,
            history: history ?? self.history
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Geometry
struct Geometry: Codable {
    let rectShape: RectShape?
    let circularShape: [CircularShape]?

    enum CodingKeys: String, CodingKey {
        case rectShape = "rectShape"
        case circularShape = "circularShape"
    }
}

// MARK: Geometry convenience initializers and mutators

extension Geometry {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Geometry.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        rectShape: RectShape?? = nil,
        circularShape: [CircularShape]?? = nil
    ) -> Geometry {
        return Geometry(
            rectShape: rectShape ?? self.rectShape,
            circularShape: circularShape ?? self.circularShape
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - CircularShape
struct CircularShape: Codable {
    let shapeName: String?

    enum CodingKeys: String, CodingKey {
        case shapeName = "shapeName"
    }
}

// MARK: CircularShape convenience initializers and mutators

extension CircularShape {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CircularShape.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        shapeName: String?? = nil
    ) -> CircularShape {
        return CircularShape(
            shapeName: shapeName ?? self.shapeName
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - RectShape
struct RectShape: Codable {
    let parts: [Part]?

    enum CodingKeys: String, CodingKey {
        case parts = "parts"
    }
}

// MARK: RectShape convenience initializers and mutators

extension RectShape {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(RectShape.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        parts: [Part]?? = nil
    ) -> RectShape {
        return RectShape(
            parts: parts ?? self.parts
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Part
struct Part: Codable {
    let depth: String?
    let length: String?
    let width: String?

    enum CodingKeys: String, CodingKey {
        case depth = "depth"
        case length = "length"
        case width = "width"
    }
}

// MARK: Part convenience initializers and mutators

extension Part {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Part.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        depth: String?? = nil,
        length: String?? = nil,
        width: String?? = nil
    ) -> Part {
        return Part(
            depth: depth ?? self.depth,
            length: length ?? self.length,
            width: width ?? self.width
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - History
struct History: Codable {
    let historyClass: String?

    enum CodingKeys: String, CodingKey {
        case historyClass = "class"
    }
}

// MARK: History convenience initializers and mutators

extension History {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(History.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        historyClass: String?? = nil
    ) -> History {
        return History(
            historyClass: historyClass ?? self.historyClass
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Vehicle
struct Vehicle: Codable {
    let brand: String?
    let id: String?
    let speed: Speed?
    let subModule: Bool?
    let type: VehicleType?
    let year: String?

    enum CodingKeys: String, CodingKey {
        case brand = "brand"
        case id = "id"
        case speed = "speed"
        case subModule = "subModule"
        case type = "type"
        case year = "year"
    }
}

// MARK: Vehicle convenience initializers and mutators

extension Vehicle {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Vehicle.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        brand: String?? = nil,
        id: String?? = nil,
        speed: Speed?? = nil,
        subModule: Bool?? = nil,
        type: VehicleType?? = nil,
        year: String?? = nil
    ) -> Vehicle {
        return Vehicle(
            brand: brand ?? self.brand,
            id: id ?? self.id,
            speed: speed ?? self.speed,
            subModule: subModule ?? self.subModule,
            type: type ?? self.type,
            year: year ?? self.year
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Speed
struct Speed: Codable {
    let velocity: Limit?

    enum CodingKeys: String, CodingKey {
        case velocity = "velocity"
    }
}

// MARK: Speed convenience initializers and mutators

extension Speed {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Speed.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        velocity: Limit?? = nil
    ) -> Speed {
        return Speed(
            velocity: velocity ?? self.velocity
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Limit
struct Limit: Codable {
    let maximum: Double?
    let minimum: Double?

    enum CodingKeys: String, CodingKey {
        case maximum = "maximum"
        case minimum = "minimum"
    }
}

// MARK: Limit convenience initializers and mutators

extension Limit {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Limit.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        maximum: Double?? = nil,
        minimum: Double?? = nil
    ) -> Limit {
        return Limit(
            maximum: maximum ?? self.maximum,
            minimum: minimum ?? self.minimum
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - VehicleType
struct VehicleType: Codable {
    let name: Name?
    let width: Axis?
    let length: Axis?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case width = "width"
        case length = "length"
    }
}

// MARK: VehicleType convenience initializers and mutators

extension VehicleType {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(VehicleType.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        name: Name?? = nil,
        width: Axis?? = nil,
        length: Axis?? = nil
    ) -> VehicleType {
        return VehicleType(
            name: name ?? self.name,
            width: width ?? self.width,
            length: length ?? self.length
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Axis: String, Codable {
    case x = "X"
    case y = "Y"
    case z = "Z"
    case xy = "XY"
    case yz = "YZ"
    case zx = "ZX"
}

enum Name: String, Codable {
    case truck = "truck"
    case bus = "bus"
    case car = "car"
    case van = "van"
    case train = "train"
    case bike = "Bike"
    case aeroplane = "Aeroplane"
    case jeep = "Jeep"
    case trolley = "Trolley"
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
