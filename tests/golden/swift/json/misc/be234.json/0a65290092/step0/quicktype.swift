// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevel
struct TopLevel: Codable {
    let data: TopLevelData
    let kind: String

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case kind = "kind"
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
        data: TopLevelData? = nil,
        kind: String? = nil
    ) -> TopLevel {
        return TopLevel(
            data: data ?? self.data,
            kind: kind ?? self.kind
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - TopLevelData
struct TopLevelData: Codable {
    let after: String
    let before: JSONNull?
    let children: [Child]
    let modhash: String

    enum CodingKeys: String, CodingKey {
        case after = "after"
        case before = "before"
        case children = "children"
        case modhash = "modhash"
    }
}

// MARK: TopLevelData convenience initializers and mutators

extension TopLevelData {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TopLevelData.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        after: String? = nil,
        before: JSONNull?? = nil,
        children: [Child]? = nil,
        modhash: String? = nil
    ) -> TopLevelData {
        return TopLevelData(
            after: after ?? self.after,
            before: before ?? self.before,
            children: children ?? self.children,
            modhash: modhash ?? self.modhash
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Child
struct Child: Codable {
    let data: ChildData
    let kind: Kind

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case kind = "kind"
    }
}

// MARK: Child convenience initializers and mutators

extension Child {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Child.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        data: ChildData? = nil,
        kind: Kind? = nil
    ) -> Child {
        return Child(
            data: data ?? self.data,
            kind: kind ?? self.kind
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ChildData
struct ChildData: Codable {
    let approvedAtUTC: JSONNull?
    let approvedBy: JSONNull?
    let archived: Bool
    let author: String
    let authorFlairCSSClass: JSONNull?
    let authorFlairText: String?
    let bannedAtUTC: JSONNull?
    let bannedBy: JSONNull?
    let brandSafe: Bool
    let canGild: Bool
    let canModPost: Bool
    let clicked: Bool
    let contestMode: Bool
    let created: Double
    let createdUTC: Double
    let distinguished: String?
    let domain: Domain
    let downs: Int
    let edited: Bool
    let gilded: Int
    let hidden: Bool
    let hideScore: Bool
    let id: String
    let isSelf: Bool
    let isVideo: Bool
    let likes: JSONNull?
    let linkFlairCSSClass: JSONNull?
    let linkFlairText: JSONNull?
    let locked: Bool
    let media: Media?
    let mediaEmbed: MediaEmbed
    let modReports: [JSONAny]
    let name: String
    let numComments: Int
    let numReports: JSONNull?
    let over18: Bool
    let permalink: String
    let postHint: PostHint
    let preview: Preview
    let quarantine: Bool
    let removalReason: JSONNull?
    let reportReasons: JSONNull?
    let saved: Bool
    let score: Int
    let secureMedia: Media?
    let secureMediaEmbed: MediaEmbed
    let selftext: String
    let selftextHTML: JSONNull?
    let spoiler: Bool
    let stickied: Bool
    let subreddit: Subreddit
    let subredditID: SubredditID
    let subredditNamePrefixed: SubredditNamePrefixed
    let subredditType: SubredditType
    let suggestedSort: JSONNull?
    let thumbnail: String
    let thumbnailHeight: Int
    let thumbnailWidth: Int
    let title: String
    let ups: Int
    let url: String
    let userReports: [JSONAny]
    let viewCount: JSONNull?
    let visited: Bool

    enum CodingKeys: String, CodingKey {
        case approvedAtUTC = "approved_at_utc"
        case approvedBy = "approved_by"
        case archived = "archived"
        case author = "author"
        case authorFlairCSSClass = "author_flair_css_class"
        case authorFlairText = "author_flair_text"
        case bannedAtUTC = "banned_at_utc"
        case bannedBy = "banned_by"
        case brandSafe = "brand_safe"
        case canGild = "can_gild"
        case canModPost = "can_mod_post"
        case clicked = "clicked"
        case contestMode = "contest_mode"
        case created = "created"
        case createdUTC = "created_utc"
        case distinguished = "distinguished"
        case domain = "domain"
        case downs = "downs"
        case edited = "edited"
        case gilded = "gilded"
        case hidden = "hidden"
        case hideScore = "hide_score"
        case id = "id"
        case isSelf = "is_self"
        case isVideo = "is_video"
        case likes = "likes"
        case linkFlairCSSClass = "link_flair_css_class"
        case linkFlairText = "link_flair_text"
        case locked = "locked"
        case media = "media"
        case mediaEmbed = "media_embed"
        case modReports = "mod_reports"
        case name = "name"
        case numComments = "num_comments"
        case numReports = "num_reports"
        case over18 = "over_18"
        case permalink = "permalink"
        case postHint = "post_hint"
        case preview = "preview"
        case quarantine = "quarantine"
        case removalReason = "removal_reason"
        case reportReasons = "report_reasons"
        case saved = "saved"
        case score = "score"
        case secureMedia = "secure_media"
        case secureMediaEmbed = "secure_media_embed"
        case selftext = "selftext"
        case selftextHTML = "selftext_html"
        case spoiler = "spoiler"
        case stickied = "stickied"
        case subreddit = "subreddit"
        case subredditID = "subreddit_id"
        case subredditNamePrefixed = "subreddit_name_prefixed"
        case subredditType = "subreddit_type"
        case suggestedSort = "suggested_sort"
        case thumbnail = "thumbnail"
        case thumbnailHeight = "thumbnail_height"
        case thumbnailWidth = "thumbnail_width"
        case title = "title"
        case ups = "ups"
        case url = "url"
        case userReports = "user_reports"
        case viewCount = "view_count"
        case visited = "visited"
    }
}

// MARK: ChildData convenience initializers and mutators

extension ChildData {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ChildData.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        approvedAtUTC: JSONNull?? = nil,
        approvedBy: JSONNull?? = nil,
        archived: Bool? = nil,
        author: String? = nil,
        authorFlairCSSClass: JSONNull?? = nil,
        authorFlairText: String?? = nil,
        bannedAtUTC: JSONNull?? = nil,
        bannedBy: JSONNull?? = nil,
        brandSafe: Bool? = nil,
        canGild: Bool? = nil,
        canModPost: Bool? = nil,
        clicked: Bool? = nil,
        contestMode: Bool? = nil,
        created: Double? = nil,
        createdUTC: Double? = nil,
        distinguished: String?? = nil,
        domain: Domain? = nil,
        downs: Int? = nil,
        edited: Bool? = nil,
        gilded: Int? = nil,
        hidden: Bool? = nil,
        hideScore: Bool? = nil,
        id: String? = nil,
        isSelf: Bool? = nil,
        isVideo: Bool? = nil,
        likes: JSONNull?? = nil,
        linkFlairCSSClass: JSONNull?? = nil,
        linkFlairText: JSONNull?? = nil,
        locked: Bool? = nil,
        media: Media?? = nil,
        mediaEmbed: MediaEmbed? = nil,
        modReports: [JSONAny]? = nil,
        name: String? = nil,
        numComments: Int? = nil,
        numReports: JSONNull?? = nil,
        over18: Bool? = nil,
        permalink: String? = nil,
        postHint: PostHint? = nil,
        preview: Preview? = nil,
        quarantine: Bool? = nil,
        removalReason: JSONNull?? = nil,
        reportReasons: JSONNull?? = nil,
        saved: Bool? = nil,
        score: Int? = nil,
        secureMedia: Media?? = nil,
        secureMediaEmbed: MediaEmbed? = nil,
        selftext: String? = nil,
        selftextHTML: JSONNull?? = nil,
        spoiler: Bool? = nil,
        stickied: Bool? = nil,
        subreddit: Subreddit? = nil,
        subredditID: SubredditID? = nil,
        subredditNamePrefixed: SubredditNamePrefixed? = nil,
        subredditType: SubredditType? = nil,
        suggestedSort: JSONNull?? = nil,
        thumbnail: String? = nil,
        thumbnailHeight: Int? = nil,
        thumbnailWidth: Int? = nil,
        title: String? = nil,
        ups: Int? = nil,
        url: String? = nil,
        userReports: [JSONAny]? = nil,
        viewCount: JSONNull?? = nil,
        visited: Bool? = nil
    ) -> ChildData {
        return ChildData(
            approvedAtUTC: approvedAtUTC ?? self.approvedAtUTC,
            approvedBy: approvedBy ?? self.approvedBy,
            archived: archived ?? self.archived,
            author: author ?? self.author,
            authorFlairCSSClass: authorFlairCSSClass ?? self.authorFlairCSSClass,
            authorFlairText: authorFlairText ?? self.authorFlairText,
            bannedAtUTC: bannedAtUTC ?? self.bannedAtUTC,
            bannedBy: bannedBy ?? self.bannedBy,
            brandSafe: brandSafe ?? self.brandSafe,
            canGild: canGild ?? self.canGild,
            canModPost: canModPost ?? self.canModPost,
            clicked: clicked ?? self.clicked,
            contestMode: contestMode ?? self.contestMode,
            created: created ?? self.created,
            createdUTC: createdUTC ?? self.createdUTC,
            distinguished: distinguished ?? self.distinguished,
            domain: domain ?? self.domain,
            downs: downs ?? self.downs,
            edited: edited ?? self.edited,
            gilded: gilded ?? self.gilded,
            hidden: hidden ?? self.hidden,
            hideScore: hideScore ?? self.hideScore,
            id: id ?? self.id,
            isSelf: isSelf ?? self.isSelf,
            isVideo: isVideo ?? self.isVideo,
            likes: likes ?? self.likes,
            linkFlairCSSClass: linkFlairCSSClass ?? self.linkFlairCSSClass,
            linkFlairText: linkFlairText ?? self.linkFlairText,
            locked: locked ?? self.locked,
            media: media ?? self.media,
            mediaEmbed: mediaEmbed ?? self.mediaEmbed,
            modReports: modReports ?? self.modReports,
            name: name ?? self.name,
            numComments: numComments ?? self.numComments,
            numReports: numReports ?? self.numReports,
            over18: over18 ?? self.over18,
            permalink: permalink ?? self.permalink,
            postHint: postHint ?? self.postHint,
            preview: preview ?? self.preview,
            quarantine: quarantine ?? self.quarantine,
            removalReason: removalReason ?? self.removalReason,
            reportReasons: reportReasons ?? self.reportReasons,
            saved: saved ?? self.saved,
            score: score ?? self.score,
            secureMedia: secureMedia ?? self.secureMedia,
            secureMediaEmbed: secureMediaEmbed ?? self.secureMediaEmbed,
            selftext: selftext ?? self.selftext,
            selftextHTML: selftextHTML ?? self.selftextHTML,
            spoiler: spoiler ?? self.spoiler,
            stickied: stickied ?? self.stickied,
            subreddit: subreddit ?? self.subreddit,
            subredditID: subredditID ?? self.subredditID,
            subredditNamePrefixed: subredditNamePrefixed ?? self.subredditNamePrefixed,
            subredditType: subredditType ?? self.subredditType,
            suggestedSort: suggestedSort ?? self.suggestedSort,
            thumbnail: thumbnail ?? self.thumbnail,
            thumbnailHeight: thumbnailHeight ?? self.thumbnailHeight,
            thumbnailWidth: thumbnailWidth ?? self.thumbnailWidth,
            title: title ?? self.title,
            ups: ups ?? self.ups,
            url: url ?? self.url,
            userReports: userReports ?? self.userReports,
            viewCount: viewCount ?? self.viewCount,
            visited: visited ?? self.visited
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Domain: String, Codable {
    case redditCOM = "reddit.com"
    case iReddIt = "i.redd.it"
    case iImgurCOM = "i.imgur.com"
    case gfycatCOM = "gfycat.com"
    case imgurCOM = "imgur.com"
}

// MARK: - Media
struct Media: Codable {
    let oembed: Oembed
    let type: Domain

    enum CodingKeys: String, CodingKey {
        case oembed = "oembed"
        case type = "type"
    }
}

// MARK: Media convenience initializers and mutators

extension Media {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Media.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        oembed: Oembed? = nil,
        type: Domain? = nil
    ) -> Media {
        return Media(
            oembed: oembed ?? self.oembed,
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

// MARK: - Oembed
struct Oembed: Codable {
    let description: String
    let height: Int
    let html: String
    let providerName: String
    let providerURL: String
    let thumbnailHeight: Int
    let thumbnailURL: String
    let thumbnailWidth: Int
    let title: String
    let type: String
    let version: String
    let width: Int

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case height = "height"
        case html = "html"
        case providerName = "provider_name"
        case providerURL = "provider_url"
        case thumbnailHeight = "thumbnail_height"
        case thumbnailURL = "thumbnail_url"
        case thumbnailWidth = "thumbnail_width"
        case title = "title"
        case type = "type"
        case version = "version"
        case width = "width"
    }
}

// MARK: Oembed convenience initializers and mutators

extension Oembed {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Oembed.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        description: String? = nil,
        height: Int? = nil,
        html: String? = nil,
        providerName: String? = nil,
        providerURL: String? = nil,
        thumbnailHeight: Int? = nil,
        thumbnailURL: String? = nil,
        thumbnailWidth: Int? = nil,
        title: String? = nil,
        type: String? = nil,
        version: String? = nil,
        width: Int? = nil
    ) -> Oembed {
        return Oembed(
            description: description ?? self.description,
            height: height ?? self.height,
            html: html ?? self.html,
            providerName: providerName ?? self.providerName,
            providerURL: providerURL ?? self.providerURL,
            thumbnailHeight: thumbnailHeight ?? self.thumbnailHeight,
            thumbnailURL: thumbnailURL ?? self.thumbnailURL,
            thumbnailWidth: thumbnailWidth ?? self.thumbnailWidth,
            title: title ?? self.title,
            type: type ?? self.type,
            version: version ?? self.version,
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

// MARK: - MediaEmbed
struct MediaEmbed: Codable {
    let content: String?
    let height: Int?
    let scrolling: Bool?
    let width: Int?

    enum CodingKeys: String, CodingKey {
        case content = "content"
        case height = "height"
        case scrolling = "scrolling"
        case width = "width"
    }
}

// MARK: MediaEmbed convenience initializers and mutators

extension MediaEmbed {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(MediaEmbed.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        content: String?? = nil,
        height: Int?? = nil,
        scrolling: Bool?? = nil,
        width: Int?? = nil
    ) -> MediaEmbed {
        return MediaEmbed(
            content: content ?? self.content,
            height: height ?? self.height,
            scrolling: scrolling ?? self.scrolling,
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

enum PostHint: String, Codable {
    case link = "link"
    case image = "image"
    case richVideo = "rich:video"
}

// MARK: - Preview
struct Preview: Codable {
    let enabled: Bool
    let images: [Image]

    enum CodingKeys: String, CodingKey {
        case enabled = "enabled"
        case images = "images"
    }
}

// MARK: Preview convenience initializers and mutators

extension Preview {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Preview.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        enabled: Bool? = nil,
        images: [Image]? = nil
    ) -> Preview {
        return Preview(
            enabled: enabled ?? self.enabled,
            images: images ?? self.images
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Image
struct Image: Codable {
    let id: String
    let resolutions: [Source]
    let source: Source
    let variants: Variants

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case resolutions = "resolutions"
        case source = "source"
        case variants = "variants"
    }
}

// MARK: Image convenience initializers and mutators

extension Image {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Image.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: String? = nil,
        resolutions: [Source]? = nil,
        source: Source? = nil,
        variants: Variants? = nil
    ) -> Image {
        return Image(
            id: id ?? self.id,
            resolutions: resolutions ?? self.resolutions,
            source: source ?? self.source,
            variants: variants ?? self.variants
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Source
struct Source: Codable {
    let height: Int
    let url: String
    let width: Int

    enum CodingKeys: String, CodingKey {
        case height = "height"
        case url = "url"
        case width = "width"
    }
}

// MARK: Source convenience initializers and mutators

extension Source {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Source.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        height: Int? = nil,
        url: String? = nil,
        width: Int? = nil
    ) -> Source {
        return Source(
            height: height ?? self.height,
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

// MARK: - Variants
struct Variants: Codable {
    let gif: GIF?
    let mp4: GIF?

    enum CodingKeys: String, CodingKey {
        case gif = "gif"
        case mp4 = "mp4"
    }
}

// MARK: Variants convenience initializers and mutators

extension Variants {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Variants.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        gif: GIF?? = nil,
        mp4: GIF?? = nil
    ) -> Variants {
        return Variants(
            gif: gif ?? self.gif,
            mp4: mp4 ?? self.mp4
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - GIF
struct GIF: Codable {
    let resolutions: [Source]
    let source: Source

    enum CodingKeys: String, CodingKey {
        case resolutions = "resolutions"
        case source = "source"
    }
}

// MARK: GIF convenience initializers and mutators

extension GIF {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(GIF.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        resolutions: [Source]? = nil,
        source: Source? = nil
    ) -> GIF {
        return GIF(
            resolutions: resolutions ?? self.resolutions,
            source: source ?? self.source
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Subreddit: String, Codable {
    case funny = "funny"
}

enum SubredditID: String, Codable {
    case t52Qh33 = "t5_2qh33"
}

enum SubredditNamePrefixed: String, Codable {
    case rFunny = "r/funny"
}

enum SubredditType: String, Codable {
    case subredditTypePublic = "public"
}

enum Kind: String, Codable {
    case t3 = "t3"
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

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
