// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let data: [Datum]
    let meta: Meta
    let pagination: Pagination

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case meta = "meta"
        case pagination = "pagination"
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
        data: [Datum]? = nil,
        meta: Meta? = nil,
        pagination: Pagination? = nil
    ) -> TopLevel {
        return TopLevel(
            data: data ?? self.data,
            meta: meta ?? self.meta,
            pagination: pagination ?? self.pagination
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Datum
struct Datum: Codable {
    let bitlyGIFURL: String
    let bitlyURL: String
    let contentURL: String
    let embedURL: String
    let id: String
    let images: Images
    let importDatetime: String
    let isIndexable: Int
    let rating: Rating
    let slug: String
    let source: String
    let sourcePostURL: String
    let sourceTLD: String
    let trendingDatetime: String
    let type: TypeEnum
    let url: String
    let user: User?
    let username: Username

    enum CodingKeys: String, CodingKey {
        case bitlyGIFURL = "bitly_gif_url"
        case bitlyURL = "bitly_url"
        case contentURL = "content_url"
        case embedURL = "embed_url"
        case id = "id"
        case images = "images"
        case importDatetime = "import_datetime"
        case isIndexable = "is_indexable"
        case rating = "rating"
        case slug = "slug"
        case source = "source"
        case sourcePostURL = "source_post_url"
        case sourceTLD = "source_tld"
        case trendingDatetime = "trending_datetime"
        case type = "type"
        case url = "url"
        case user = "user"
        case username = "username"
    }
}

// MARK: Datum convenience initializers and mutators

extension Datum {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Datum.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        bitlyGIFURL: String? = nil,
        bitlyURL: String? = nil,
        contentURL: String? = nil,
        embedURL: String? = nil,
        id: String? = nil,
        images: Images? = nil,
        importDatetime: String? = nil,
        isIndexable: Int? = nil,
        rating: Rating? = nil,
        slug: String? = nil,
        source: String? = nil,
        sourcePostURL: String? = nil,
        sourceTLD: String? = nil,
        trendingDatetime: String? = nil,
        type: TypeEnum? = nil,
        url: String? = nil,
        user: User?? = nil,
        username: Username? = nil
    ) -> Datum {
        return Datum(
            bitlyGIFURL: bitlyGIFURL ?? self.bitlyGIFURL,
            bitlyURL: bitlyURL ?? self.bitlyURL,
            contentURL: contentURL ?? self.contentURL,
            embedURL: embedURL ?? self.embedURL,
            id: id ?? self.id,
            images: images ?? self.images,
            importDatetime: importDatetime ?? self.importDatetime,
            isIndexable: isIndexable ?? self.isIndexable,
            rating: rating ?? self.rating,
            slug: slug ?? self.slug,
            source: source ?? self.source,
            sourcePostURL: sourcePostURL ?? self.sourcePostURL,
            sourceTLD: sourceTLD ?? self.sourceTLD,
            trendingDatetime: trendingDatetime ?? self.trendingDatetime,
            type: type ?? self.type,
            url: url ?? self.url,
            user: user ?? self.user,
            username: username ?? self.username
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Images
struct Images: Codable {
    let downsized: The480_WStill
    let downsizedLarge: The480_WStill
    let downsizedMedium: The480_WStill
    let downsizedSmall: DownsizedSmall
    let downsizedStill: The480_WStill
    let fixedHeight: FixedHeight
    let fixedHeightDownsampled: FixedHeight
    let fixedHeightSmall: FixedHeight
    let fixedHeightSmallStill: The480_WStill
    let fixedHeightStill: The480_WStill
    let fixedWidth: FixedHeight
    let fixedWidthDownsampled: FixedHeight
    let fixedWidthSmall: FixedHeight
    let fixedWidthSmallStill: The480_WStill
    let fixedWidthStill: The480_WStill
    let looping: Looping
    let original: FixedHeight
    let originalMp4: DownsizedSmall
    let originalStill: The480_WStill
    let preview: DownsizedSmall
    let previewGIF: The480_WStill
    let previewWebp: The480_WStill
    let the480WStill: The480_WStill?

    enum CodingKeys: String, CodingKey {
        case downsized = "downsized"
        case downsizedLarge = "downsized_large"
        case downsizedMedium = "downsized_medium"
        case downsizedSmall = "downsized_small"
        case downsizedStill = "downsized_still"
        case fixedHeight = "fixed_height"
        case fixedHeightDownsampled = "fixed_height_downsampled"
        case fixedHeightSmall = "fixed_height_small"
        case fixedHeightSmallStill = "fixed_height_small_still"
        case fixedHeightStill = "fixed_height_still"
        case fixedWidth = "fixed_width"
        case fixedWidthDownsampled = "fixed_width_downsampled"
        case fixedWidthSmall = "fixed_width_small"
        case fixedWidthSmallStill = "fixed_width_small_still"
        case fixedWidthStill = "fixed_width_still"
        case looping = "looping"
        case original = "original"
        case originalMp4 = "original_mp4"
        case originalStill = "original_still"
        case preview = "preview"
        case previewGIF = "preview_gif"
        case previewWebp = "preview_webp"
        case the480WStill = "480w_still"
    }
}

// MARK: Images convenience initializers and mutators

extension Images {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Images.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        downsized: The480_WStill? = nil,
        downsizedLarge: The480_WStill? = nil,
        downsizedMedium: The480_WStill? = nil,
        downsizedSmall: DownsizedSmall? = nil,
        downsizedStill: The480_WStill? = nil,
        fixedHeight: FixedHeight? = nil,
        fixedHeightDownsampled: FixedHeight? = nil,
        fixedHeightSmall: FixedHeight? = nil,
        fixedHeightSmallStill: The480_WStill? = nil,
        fixedHeightStill: The480_WStill? = nil,
        fixedWidth: FixedHeight? = nil,
        fixedWidthDownsampled: FixedHeight? = nil,
        fixedWidthSmall: FixedHeight? = nil,
        fixedWidthSmallStill: The480_WStill? = nil,
        fixedWidthStill: The480_WStill? = nil,
        looping: Looping? = nil,
        original: FixedHeight? = nil,
        originalMp4: DownsizedSmall? = nil,
        originalStill: The480_WStill? = nil,
        preview: DownsizedSmall? = nil,
        previewGIF: The480_WStill? = nil,
        previewWebp: The480_WStill? = nil,
        the480WStill: The480_WStill?? = nil
    ) -> Images {
        return Images(
            downsized: downsized ?? self.downsized,
            downsizedLarge: downsizedLarge ?? self.downsizedLarge,
            downsizedMedium: downsizedMedium ?? self.downsizedMedium,
            downsizedSmall: downsizedSmall ?? self.downsizedSmall,
            downsizedStill: downsizedStill ?? self.downsizedStill,
            fixedHeight: fixedHeight ?? self.fixedHeight,
            fixedHeightDownsampled: fixedHeightDownsampled ?? self.fixedHeightDownsampled,
            fixedHeightSmall: fixedHeightSmall ?? self.fixedHeightSmall,
            fixedHeightSmallStill: fixedHeightSmallStill ?? self.fixedHeightSmallStill,
            fixedHeightStill: fixedHeightStill ?? self.fixedHeightStill,
            fixedWidth: fixedWidth ?? self.fixedWidth,
            fixedWidthDownsampled: fixedWidthDownsampled ?? self.fixedWidthDownsampled,
            fixedWidthSmall: fixedWidthSmall ?? self.fixedWidthSmall,
            fixedWidthSmallStill: fixedWidthSmallStill ?? self.fixedWidthSmallStill,
            fixedWidthStill: fixedWidthStill ?? self.fixedWidthStill,
            looping: looping ?? self.looping,
            original: original ?? self.original,
            originalMp4: originalMp4 ?? self.originalMp4,
            originalStill: originalStill ?? self.originalStill,
            preview: preview ?? self.preview,
            previewGIF: previewGIF ?? self.previewGIF,
            previewWebp: previewWebp ?? self.previewWebp,
            the480WStill: the480WStill ?? self.the480WStill
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - The480_WStill
struct The480_WStill: Codable {
    let height: String
    let size: String?
    let url: String
    let width: String

    enum CodingKeys: String, CodingKey {
        case height = "height"
        case size = "size"
        case url = "url"
        case width = "width"
    }
}

// MARK: The480_WStill convenience initializers and mutators

extension The480_WStill {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(The480_WStill.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        height: String? = nil,
        size: String?? = nil,
        url: String? = nil,
        width: String? = nil
    ) -> The480_WStill {
        return The480_WStill(
            height: height ?? self.height,
            size: size ?? self.size,
            url: url ?? self.url,
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

// MARK: - DownsizedSmall
struct DownsizedSmall: Codable {
    let height: String
    let mp4: String
    let mp4Size: String
    let width: String

    enum CodingKeys: String, CodingKey {
        case height = "height"
        case mp4 = "mp4"
        case mp4Size = "mp4_size"
        case width = "width"
    }
}

// MARK: DownsizedSmall convenience initializers and mutators

extension DownsizedSmall {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DownsizedSmall.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        height: String? = nil,
        mp4: String? = nil,
        mp4Size: String? = nil,
        width: String? = nil
    ) -> DownsizedSmall {
        return DownsizedSmall(
            height: height ?? self.height,
            mp4: mp4 ?? self.mp4,
            mp4Size: mp4Size ?? self.mp4Size,
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

// MARK: - FixedHeight
struct FixedHeight: Codable {
    let frames: String?
    let hash: String?
    let height: String
    let mp4: String?
    let mp4Size: String?
    let size: String
    let url: String
    let webp: String
    let webpSize: String
    let width: String

    enum CodingKeys: String, CodingKey {
        case frames = "frames"
        case hash = "hash"
        case height = "height"
        case mp4 = "mp4"
        case mp4Size = "mp4_size"
        case size = "size"
        case url = "url"
        case webp = "webp"
        case webpSize = "webp_size"
        case width = "width"
    }
}

// MARK: FixedHeight convenience initializers and mutators

extension FixedHeight {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FixedHeight.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        frames: String?? = nil,
        hash: String?? = nil,
        height: String? = nil,
        mp4: String?? = nil,
        mp4Size: String?? = nil,
        size: String? = nil,
        url: String? = nil,
        webp: String? = nil,
        webpSize: String? = nil,
        width: String? = nil
    ) -> FixedHeight {
        return FixedHeight(
            frames: frames ?? self.frames,
            hash: hash ?? self.hash,
            height: height ?? self.height,
            mp4: mp4 ?? self.mp4,
            mp4Size: mp4Size ?? self.mp4Size,
            size: size ?? self.size,
            url: url ?? self.url,
            webp: webp ?? self.webp,
            webpSize: webpSize ?? self.webpSize,
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

// MARK: - Looping
struct Looping: Codable {
    let mp4: String
    let mp4Size: String

    enum CodingKeys: String, CodingKey {
        case mp4 = "mp4"
        case mp4Size = "mp4_size"
    }
}

// MARK: Looping convenience initializers and mutators

extension Looping {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Looping.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        mp4: String? = nil,
        mp4Size: String? = nil
    ) -> Looping {
        return Looping(
            mp4: mp4 ?? self.mp4,
            mp4Size: mp4Size ?? self.mp4Size
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Rating: String, Codable {
    case g = "g"
    case pg = "pg"
    case pg13 = "pg-13"
}

enum TypeEnum: String, Codable {
    case gif = "gif"
}

// MARK: - User
struct User: Codable {
    let avatarURL: String
    let bannerURL: String
    let displayName: String
    let profileURL: String
    let twitter: String?
    let username: String

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case bannerURL = "banner_url"
        case displayName = "display_name"
        case profileURL = "profile_url"
        case twitter = "twitter"
        case username = "username"
    }
}

// MARK: User convenience initializers and mutators

extension User {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(User.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        avatarURL: String? = nil,
        bannerURL: String? = nil,
        displayName: String? = nil,
        profileURL: String? = nil,
        twitter: String?? = nil,
        username: String? = nil
    ) -> User {
        return User(
            avatarURL: avatarURL ?? self.avatarURL,
            bannerURL: bannerURL ?? self.bannerURL,
            displayName: displayName ?? self.displayName,
            profileURL: profileURL ?? self.profileURL,
            twitter: twitter ?? self.twitter,
            username: username ?? self.username
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Username: String, Codable {
    case empty = ""
    case mashable = "mashable"
    case nba = "nba"
    case originals = "Originals"
}

// MARK: - Meta
struct Meta: Codable {
    let msg: String
    let responseID: String
    let status: Int

    enum CodingKeys: String, CodingKey {
        case msg = "msg"
        case responseID = "response_id"
        case status = "status"
    }
}

// MARK: Meta convenience initializers and mutators

extension Meta {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Meta.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        msg: String? = nil,
        responseID: String? = nil,
        status: Int? = nil
    ) -> Meta {
        return Meta(
            msg: msg ?? self.msg,
            responseID: responseID ?? self.responseID,
            status: status ?? self.status
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Pagination
struct Pagination: Codable {
    let count: Int
    let offset: Int
    let totalCount: Int

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case offset = "offset"
        case totalCount = "total_count"
    }
}

// MARK: Pagination convenience initializers and mutators

extension Pagination {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Pagination.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        count: Int? = nil,
        offset: Int? = nil,
        totalCount: Int? = nil
    ) -> Pagination {
        return Pagination(
            count: count ?? self.count,
            offset: offset ?? self.offset,
            totalCount: totalCount ?? self.totalCount
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
