// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topLevel = try TopLevel(json)

import Foundation

// MARK: - TopLevelElement
struct TopLevelElement: Codable {
    let actor: Actor
    let createdAt: Date
    let id: String
    let org: Actor?
    let payload: Payload
    let repo: TopLevelRepo
    let topLevelPublic: Bool
    let type: String

    enum CodingKeys: String, CodingKey {
        case actor = "actor"
        case createdAt = "created_at"
        case id = "id"
        case org = "org"
        case payload = "payload"
        case repo = "repo"
        case topLevelPublic = "public"
        case type = "type"
    }
}

// MARK: TopLevelElement convenience initializers and mutators

extension TopLevelElement {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TopLevelElement.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        actor: Actor? = nil,
        createdAt: Date? = nil,
        id: String? = nil,
        org: Actor?? = nil,
        payload: Payload? = nil,
        repo: TopLevelRepo? = nil,
        topLevelPublic: Bool? = nil,
        type: String? = nil
    ) -> TopLevelElement {
        return TopLevelElement(
            actor: actor ?? self.actor,
            createdAt: createdAt ?? self.createdAt,
            id: id ?? self.id,
            org: org ?? self.org,
            payload: payload ?? self.payload,
            repo: repo ?? self.repo,
            topLevelPublic: topLevelPublic ?? self.topLevelPublic,
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

// MARK: - Actor
struct Actor: Codable {
    let avatarURL: String
    let displayLogin: String?
    let gravatarID: String
    let id: Int
    let login: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case displayLogin = "display_login"
        case gravatarID = "gravatar_id"
        case id = "id"
        case login = "login"
        case url = "url"
    }
}

// MARK: Actor convenience initializers and mutators

extension Actor {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Actor.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
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
        displayLogin: String?? = nil,
        gravatarID: String? = nil,
        id: Int? = nil,
        login: String? = nil,
        url: String? = nil
    ) -> Actor {
        return Actor(
            avatarURL: avatarURL ?? self.avatarURL,
            displayLogin: displayLogin ?? self.displayLogin,
            gravatarID: gravatarID ?? self.gravatarID,
            id: id ?? self.id,
            login: login ?? self.login,
            url: url ?? self.url
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Payload
struct Payload: Codable {
    let action: String?
    let before: String?
    let comment: Comment?
    let commits: [Commit]?
    let description: String?
    let distinctSize: Int?
    let head: String?
    let issue: Issue?
    let masterBranch: String?
    let number: Int?
    let pullRequest: PayloadPullRequest?
    let pushID: Int?
    let pusherType: String?
    let ref: String?
    let refType: String?
    let size: Int?

    enum CodingKeys: String, CodingKey {
        case action = "action"
        case before = "before"
        case comment = "comment"
        case commits = "commits"
        case description = "description"
        case distinctSize = "distinct_size"
        case head = "head"
        case issue = "issue"
        case masterBranch = "master_branch"
        case number = "number"
        case pullRequest = "pull_request"
        case pushID = "push_id"
        case pusherType = "pusher_type"
        case ref = "ref"
        case refType = "ref_type"
        case size = "size"
    }
}

// MARK: Payload convenience initializers and mutators

extension Payload {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Payload.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        action: String?? = nil,
        before: String?? = nil,
        comment: Comment?? = nil,
        commits: [Commit]?? = nil,
        description: String?? = nil,
        distinctSize: Int?? = nil,
        head: String?? = nil,
        issue: Issue?? = nil,
        masterBranch: String?? = nil,
        number: Int?? = nil,
        pullRequest: PayloadPullRequest?? = nil,
        pushID: Int?? = nil,
        pusherType: String?? = nil,
        ref: String?? = nil,
        refType: String?? = nil,
        size: Int?? = nil
    ) -> Payload {
        return Payload(
            action: action ?? self.action,
            before: before ?? self.before,
            comment: comment ?? self.comment,
            commits: commits ?? self.commits,
            description: description ?? self.description,
            distinctSize: distinctSize ?? self.distinctSize,
            head: head ?? self.head,
            issue: issue ?? self.issue,
            masterBranch: masterBranch ?? self.masterBranch,
            number: number ?? self.number,
            pullRequest: pullRequest ?? self.pullRequest,
            pushID: pushID ?? self.pushID,
            pusherType: pusherType ?? self.pusherType,
            ref: ref ?? self.ref,
            refType: refType ?? self.refType,
            size: size ?? self.size
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Comment
struct Comment: Codable {
    let body: String
    let createdAt: Date
    let htmlURL: String
    let id: Int
    let issueURL: String
    let updatedAt: Date
    let url: String
    let user: User

    enum CodingKeys: String, CodingKey {
        case body = "body"
        case createdAt = "created_at"
        case htmlURL = "html_url"
        case id = "id"
        case issueURL = "issue_url"
        case updatedAt = "updated_at"
        case url = "url"
        case user = "user"
    }
}

// MARK: Comment convenience initializers and mutators

extension Comment {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Comment.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        body: String? = nil,
        createdAt: Date? = nil,
        htmlURL: String? = nil,
        id: Int? = nil,
        issueURL: String? = nil,
        updatedAt: Date? = nil,
        url: String? = nil,
        user: User? = nil
    ) -> Comment {
        return Comment(
            body: body ?? self.body,
            createdAt: createdAt ?? self.createdAt,
            htmlURL: htmlURL ?? self.htmlURL,
            id: id ?? self.id,
            issueURL: issueURL ?? self.issueURL,
            updatedAt: updatedAt ?? self.updatedAt,
            url: url ?? self.url,
            user: user ?? self.user
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - User
struct User: Codable {
    let avatarURL: String
    let eventsURL: String
    let followersURL: String
    let followingURL: String
    let gistsURL: String
    let gravatarID: String
    let htmlURL: String
    let id: Int
    let login: String
    let organizationsURL: String
    let receivedEventsURL: String
    let reposURL: String
    let siteAdmin: Bool
    let starredURL: String
    let subscriptionsURL: String
    let type: TypeEnum
    let url: String

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case eventsURL = "events_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case gravatarID = "gravatar_id"
        case htmlURL = "html_url"
        case id = "id"
        case login = "login"
        case organizationsURL = "organizations_url"
        case receivedEventsURL = "received_events_url"
        case reposURL = "repos_url"
        case siteAdmin = "site_admin"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case type = "type"
        case url = "url"
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
        eventsURL: String? = nil,
        followersURL: String? = nil,
        followingURL: String? = nil,
        gistsURL: String? = nil,
        gravatarID: String? = nil,
        htmlURL: String? = nil,
        id: Int? = nil,
        login: String? = nil,
        organizationsURL: String? = nil,
        receivedEventsURL: String? = nil,
        reposURL: String? = nil,
        siteAdmin: Bool? = nil,
        starredURL: String? = nil,
        subscriptionsURL: String? = nil,
        type: TypeEnum? = nil,
        url: String? = nil
    ) -> User {
        return User(
            avatarURL: avatarURL ?? self.avatarURL,
            eventsURL: eventsURL ?? self.eventsURL,
            followersURL: followersURL ?? self.followersURL,
            followingURL: followingURL ?? self.followingURL,
            gistsURL: gistsURL ?? self.gistsURL,
            gravatarID: gravatarID ?? self.gravatarID,
            htmlURL: htmlURL ?? self.htmlURL,
            id: id ?? self.id,
            login: login ?? self.login,
            organizationsURL: organizationsURL ?? self.organizationsURL,
            receivedEventsURL: receivedEventsURL ?? self.receivedEventsURL,
            reposURL: reposURL ?? self.reposURL,
            siteAdmin: siteAdmin ?? self.siteAdmin,
            starredURL: starredURL ?? self.starredURL,
            subscriptionsURL: subscriptionsURL ?? self.subscriptionsURL,
            type: type ?? self.type,
            url: url ?? self.url
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum TypeEnum: String, Codable {
    case user = "User"
    case organization = "Organization"
}

// MARK: - Commit
struct Commit: Codable {
    let author: Author
    let distinct: Bool
    let message: String
    let sha: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case author = "author"
        case distinct = "distinct"
        case message = "message"
        case sha = "sha"
        case url = "url"
    }
}

// MARK: Commit convenience initializers and mutators

extension Commit {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Commit.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        author: Author? = nil,
        distinct: Bool? = nil,
        message: String? = nil,
        sha: String? = nil,
        url: String? = nil
    ) -> Commit {
        return Commit(
            author: author ?? self.author,
            distinct: distinct ?? self.distinct,
            message: message ?? self.message,
            sha: sha ?? self.sha,
            url: url ?? self.url
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Author
struct Author: Codable {
    let email: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case email = "email"
        case name = "name"
    }
}

// MARK: Author convenience initializers and mutators

extension Author {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Author.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        email: String? = nil,
        name: String? = nil
    ) -> Author {
        return Author(
            email: email ?? self.email,
            name: name ?? self.name
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Issue
struct Issue: Codable {
    let assignee: JSONNull?
    let assignees: [JSONAny]
    let body: String
    let closedAt: Date?
    let comments: Int
    let commentsURL: String
    let createdAt: Date
    let eventsURL: String
    let htmlURL: String
    let id: Int
    let labels: [Label]
    let labelsURL: String
    let locked: Bool
    let milestone: Milestone?
    let number: Int
    let pullRequest: IssuePullRequest?
    let repositoryURL: String
    let state: String
    let title: String
    let updatedAt: Date
    let url: String
    let user: User

    enum CodingKeys: String, CodingKey {
        case assignee = "assignee"
        case assignees = "assignees"
        case body = "body"
        case closedAt = "closed_at"
        case comments = "comments"
        case commentsURL = "comments_url"
        case createdAt = "created_at"
        case eventsURL = "events_url"
        case htmlURL = "html_url"
        case id = "id"
        case labels = "labels"
        case labelsURL = "labels_url"
        case locked = "locked"
        case milestone = "milestone"
        case number = "number"
        case pullRequest = "pull_request"
        case repositoryURL = "repository_url"
        case state = "state"
        case title = "title"
        case updatedAt = "updated_at"
        case url = "url"
        case user = "user"
    }
}

// MARK: Issue convenience initializers and mutators

extension Issue {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Issue.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        assignee: JSONNull?? = nil,
        assignees: [JSONAny]? = nil,
        body: String? = nil,
        closedAt: Date?? = nil,
        comments: Int? = nil,
        commentsURL: String? = nil,
        createdAt: Date? = nil,
        eventsURL: String? = nil,
        htmlURL: String? = nil,
        id: Int? = nil,
        labels: [Label]? = nil,
        labelsURL: String? = nil,
        locked: Bool? = nil,
        milestone: Milestone?? = nil,
        number: Int? = nil,
        pullRequest: IssuePullRequest?? = nil,
        repositoryURL: String? = nil,
        state: String? = nil,
        title: String? = nil,
        updatedAt: Date? = nil,
        url: String? = nil,
        user: User? = nil
    ) -> Issue {
        return Issue(
            assignee: assignee ?? self.assignee,
            assignees: assignees ?? self.assignees,
            body: body ?? self.body,
            closedAt: closedAt ?? self.closedAt,
            comments: comments ?? self.comments,
            commentsURL: commentsURL ?? self.commentsURL,
            createdAt: createdAt ?? self.createdAt,
            eventsURL: eventsURL ?? self.eventsURL,
            htmlURL: htmlURL ?? self.htmlURL,
            id: id ?? self.id,
            labels: labels ?? self.labels,
            labelsURL: labelsURL ?? self.labelsURL,
            locked: locked ?? self.locked,
            milestone: milestone ?? self.milestone,
            number: number ?? self.number,
            pullRequest: pullRequest ?? self.pullRequest,
            repositoryURL: repositoryURL ?? self.repositoryURL,
            state: state ?? self.state,
            title: title ?? self.title,
            updatedAt: updatedAt ?? self.updatedAt,
            url: url ?? self.url,
            user: user ?? self.user
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Label
struct Label: Codable {
    let color: String
    let id: Int
    let labelDefault: Bool
    let name: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case color = "color"
        case id = "id"
        case labelDefault = "default"
        case name = "name"
        case url = "url"
    }
}

// MARK: Label convenience initializers and mutators

extension Label {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Label.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        color: String? = nil,
        id: Int? = nil,
        labelDefault: Bool? = nil,
        name: String? = nil,
        url: String? = nil
    ) -> Label {
        return Label(
            color: color ?? self.color,
            id: id ?? self.id,
            labelDefault: labelDefault ?? self.labelDefault,
            name: name ?? self.name,
            url: url ?? self.url
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Milestone
struct Milestone: Codable {
    let closedAt: JSONNull?
    let closedIssues: Int
    let createdAt: Date
    let creator: User
    let description: String
    let dueOn: Date?
    let htmlURL: String
    let id: Int
    let labelsURL: String
    let number: Int
    let openIssues: Int
    let state: String
    let title: String
    let updatedAt: Date
    let url: String

    enum CodingKeys: String, CodingKey {
        case closedAt = "closed_at"
        case closedIssues = "closed_issues"
        case createdAt = "created_at"
        case creator = "creator"
        case description = "description"
        case dueOn = "due_on"
        case htmlURL = "html_url"
        case id = "id"
        case labelsURL = "labels_url"
        case number = "number"
        case openIssues = "open_issues"
        case state = "state"
        case title = "title"
        case updatedAt = "updated_at"
        case url = "url"
    }
}

// MARK: Milestone convenience initializers and mutators

extension Milestone {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Milestone.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        closedAt: JSONNull?? = nil,
        closedIssues: Int? = nil,
        createdAt: Date? = nil,
        creator: User? = nil,
        description: String? = nil,
        dueOn: Date?? = nil,
        htmlURL: String? = nil,
        id: Int? = nil,
        labelsURL: String? = nil,
        number: Int? = nil,
        openIssues: Int? = nil,
        state: String? = nil,
        title: String? = nil,
        updatedAt: Date? = nil,
        url: String? = nil
    ) -> Milestone {
        return Milestone(
            closedAt: closedAt ?? self.closedAt,
            closedIssues: closedIssues ?? self.closedIssues,
            createdAt: createdAt ?? self.createdAt,
            creator: creator ?? self.creator,
            description: description ?? self.description,
            dueOn: dueOn ?? self.dueOn,
            htmlURL: htmlURL ?? self.htmlURL,
            id: id ?? self.id,
            labelsURL: labelsURL ?? self.labelsURL,
            number: number ?? self.number,
            openIssues: openIssues ?? self.openIssues,
            state: state ?? self.state,
            title: title ?? self.title,
            updatedAt: updatedAt ?? self.updatedAt,
            url: url ?? self.url
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - IssuePullRequest
struct IssuePullRequest: Codable {
    let diffURL: String
    let htmlURL: String
    let patchURL: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case diffURL = "diff_url"
        case htmlURL = "html_url"
        case patchURL = "patch_url"
        case url = "url"
    }
}

// MARK: IssuePullRequest convenience initializers and mutators

extension IssuePullRequest {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(IssuePullRequest.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        diffURL: String? = nil,
        htmlURL: String? = nil,
        patchURL: String? = nil,
        url: String? = nil
    ) -> IssuePullRequest {
        return IssuePullRequest(
            diffURL: diffURL ?? self.diffURL,
            htmlURL: htmlURL ?? self.htmlURL,
            patchURL: patchURL ?? self.patchURL,
            url: url ?? self.url
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - PayloadPullRequest
struct PayloadPullRequest: Codable {
    let additions: Int
    let assignee: JSONNull?
    let assignees: [JSONAny]
    let base: Base
    let body: String
    let changedFiles: Int
    let closedAt: Date
    let comments: Int
    let commentsURL: String
    let commits: Int
    let commitsURL: String
    let createdAt: Date
    let deletions: Int
    let diffURL: String
    let head: Base
    let htmlURL: String
    let id: Int
    let issueURL: String
    let links: Links
    let locked: Bool
    let maintainerCanModify: Bool
    let mergeCommitSHA: String
    let mergeable: JSONNull?
    let mergeableState: String
    let merged: Bool
    let mergedAt: Date
    let mergedBy: User
    let milestone: JSONNull?
    let number: Int
    let patchURL: String
    let rebaseable: JSONNull?
    let requestedReviewers: [JSONAny]
    let reviewCommentURL: String
    let reviewComments: Int
    let reviewCommentsURL: String
    let state: String
    let statusesURL: String
    let title: String
    let updatedAt: Date
    let url: String
    let user: User

    enum CodingKeys: String, CodingKey {
        case additions = "additions"
        case assignee = "assignee"
        case assignees = "assignees"
        case base = "base"
        case body = "body"
        case changedFiles = "changed_files"
        case closedAt = "closed_at"
        case comments = "comments"
        case commentsURL = "comments_url"
        case commits = "commits"
        case commitsURL = "commits_url"
        case createdAt = "created_at"
        case deletions = "deletions"
        case diffURL = "diff_url"
        case head = "head"
        case htmlURL = "html_url"
        case id = "id"
        case issueURL = "issue_url"
        case links = "_links"
        case locked = "locked"
        case maintainerCanModify = "maintainer_can_modify"
        case mergeCommitSHA = "merge_commit_sha"
        case mergeable = "mergeable"
        case mergeableState = "mergeable_state"
        case merged = "merged"
        case mergedAt = "merged_at"
        case mergedBy = "merged_by"
        case milestone = "milestone"
        case number = "number"
        case patchURL = "patch_url"
        case rebaseable = "rebaseable"
        case requestedReviewers = "requested_reviewers"
        case reviewCommentURL = "review_comment_url"
        case reviewComments = "review_comments"
        case reviewCommentsURL = "review_comments_url"
        case state = "state"
        case statusesURL = "statuses_url"
        case title = "title"
        case updatedAt = "updated_at"
        case url = "url"
        case user = "user"
    }
}

// MARK: PayloadPullRequest convenience initializers and mutators

extension PayloadPullRequest {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PayloadPullRequest.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        additions: Int? = nil,
        assignee: JSONNull?? = nil,
        assignees: [JSONAny]? = nil,
        base: Base? = nil,
        body: String? = nil,
        changedFiles: Int? = nil,
        closedAt: Date? = nil,
        comments: Int? = nil,
        commentsURL: String? = nil,
        commits: Int? = nil,
        commitsURL: String? = nil,
        createdAt: Date? = nil,
        deletions: Int? = nil,
        diffURL: String? = nil,
        head: Base? = nil,
        htmlURL: String? = nil,
        id: Int? = nil,
        issueURL: String? = nil,
        links: Links? = nil,
        locked: Bool? = nil,
        maintainerCanModify: Bool? = nil,
        mergeCommitSHA: String? = nil,
        mergeable: JSONNull?? = nil,
        mergeableState: String? = nil,
        merged: Bool? = nil,
        mergedAt: Date? = nil,
        mergedBy: User? = nil,
        milestone: JSONNull?? = nil,
        number: Int? = nil,
        patchURL: String? = nil,
        rebaseable: JSONNull?? = nil,
        requestedReviewers: [JSONAny]? = nil,
        reviewCommentURL: String? = nil,
        reviewComments: Int? = nil,
        reviewCommentsURL: String? = nil,
        state: String? = nil,
        statusesURL: String? = nil,
        title: String? = nil,
        updatedAt: Date? = nil,
        url: String? = nil,
        user: User? = nil
    ) -> PayloadPullRequest {
        return PayloadPullRequest(
            additions: additions ?? self.additions,
            assignee: assignee ?? self.assignee,
            assignees: assignees ?? self.assignees,
            base: base ?? self.base,
            body: body ?? self.body,
            changedFiles: changedFiles ?? self.changedFiles,
            closedAt: closedAt ?? self.closedAt,
            comments: comments ?? self.comments,
            commentsURL: commentsURL ?? self.commentsURL,
            commits: commits ?? self.commits,
            commitsURL: commitsURL ?? self.commitsURL,
            createdAt: createdAt ?? self.createdAt,
            deletions: deletions ?? self.deletions,
            diffURL: diffURL ?? self.diffURL,
            head: head ?? self.head,
            htmlURL: htmlURL ?? self.htmlURL,
            id: id ?? self.id,
            issueURL: issueURL ?? self.issueURL,
            links: links ?? self.links,
            locked: locked ?? self.locked,
            maintainerCanModify: maintainerCanModify ?? self.maintainerCanModify,
            mergeCommitSHA: mergeCommitSHA ?? self.mergeCommitSHA,
            mergeable: mergeable ?? self.mergeable,
            mergeableState: mergeableState ?? self.mergeableState,
            merged: merged ?? self.merged,
            mergedAt: mergedAt ?? self.mergedAt,
            mergedBy: mergedBy ?? self.mergedBy,
            milestone: milestone ?? self.milestone,
            number: number ?? self.number,
            patchURL: patchURL ?? self.patchURL,
            rebaseable: rebaseable ?? self.rebaseable,
            requestedReviewers: requestedReviewers ?? self.requestedReviewers,
            reviewCommentURL: reviewCommentURL ?? self.reviewCommentURL,
            reviewComments: reviewComments ?? self.reviewComments,
            reviewCommentsURL: reviewCommentsURL ?? self.reviewCommentsURL,
            state: state ?? self.state,
            statusesURL: statusesURL ?? self.statusesURL,
            title: title ?? self.title,
            updatedAt: updatedAt ?? self.updatedAt,
            url: url ?? self.url,
            user: user ?? self.user
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
struct Base: Codable {
    let label: String
    let ref: String
    let repo: BaseRepo
    let sha: String
    let user: User

    enum CodingKeys: String, CodingKey {
        case label = "label"
        case ref = "ref"
        case repo = "repo"
        case sha = "sha"
        case user = "user"
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
        label: String? = nil,
        ref: String? = nil,
        repo: BaseRepo? = nil,
        sha: String? = nil,
        user: User? = nil
    ) -> Base {
        return Base(
            label: label ?? self.label,
            ref: ref ?? self.ref,
            repo: repo ?? self.repo,
            sha: sha ?? self.sha,
            user: user ?? self.user
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - BaseRepo
struct BaseRepo: Codable {
    let archiveURL: String
    let assigneesURL: String
    let blobsURL: String
    let branchesURL: String
    let cloneURL: String
    let collaboratorsURL: String
    let commentsURL: String
    let commitsURL: String
    let compareURL: String
    let contentsURL: String
    let contributorsURL: String
    let createdAt: Date
    let defaultBranch: String
    let deploymentsURL: String
    let description: String
    let downloadsURL: String
    let eventsURL: String
    let fork: Bool
    let forks: Int
    let forksCount: Int
    let forksURL: String
    let fullName: String
    let gitCommitsURL: String
    let gitRefsURL: String
    let gitTagsURL: String
    let gitURL: String
    let hasDownloads: Bool
    let hasIssues: Bool
    let hasPages: Bool
    let hasProjects: Bool
    let hasWiki: Bool
    let homepage: String
    let hooksURL: String
    let htmlURL: String
    let id: Int
    let issueCommentURL: String
    let issueEventsURL: String
    let issuesURL: String
    let keysURL: String
    let labelsURL: String
    let language: String
    let languagesURL: String
    let mergesURL: String
    let milestonesURL: String
    let mirrorURL: JSONNull?
    let name: String
    let notificationsURL: String
    let openIssues: Int
    let openIssuesCount: Int
    let owner: User
    let pullsURL: String
    let pushedAt: Date
    let releasesURL: String
    let repoPrivate: Bool
    let size: Int
    let sshURL: String
    let stargazersCount: Int
    let stargazersURL: String
    let statusesURL: String
    let subscribersURL: String
    let subscriptionURL: String
    let svnURL: String
    let tagsURL: String
    let teamsURL: String
    let treesURL: String
    let updatedAt: Date
    let url: String
    let watchers: Int
    let watchersCount: Int

    enum CodingKeys: String, CodingKey {
        case archiveURL = "archive_url"
        case assigneesURL = "assignees_url"
        case blobsURL = "blobs_url"
        case branchesURL = "branches_url"
        case cloneURL = "clone_url"
        case collaboratorsURL = "collaborators_url"
        case commentsURL = "comments_url"
        case commitsURL = "commits_url"
        case compareURL = "compare_url"
        case contentsURL = "contents_url"
        case contributorsURL = "contributors_url"
        case createdAt = "created_at"
        case defaultBranch = "default_branch"
        case deploymentsURL = "deployments_url"
        case description = "description"
        case downloadsURL = "downloads_url"
        case eventsURL = "events_url"
        case fork = "fork"
        case forks = "forks"
        case forksCount = "forks_count"
        case forksURL = "forks_url"
        case fullName = "full_name"
        case gitCommitsURL = "git_commits_url"
        case gitRefsURL = "git_refs_url"
        case gitTagsURL = "git_tags_url"
        case gitURL = "git_url"
        case hasDownloads = "has_downloads"
        case hasIssues = "has_issues"
        case hasPages = "has_pages"
        case hasProjects = "has_projects"
        case hasWiki = "has_wiki"
        case homepage = "homepage"
        case hooksURL = "hooks_url"
        case htmlURL = "html_url"
        case id = "id"
        case issueCommentURL = "issue_comment_url"
        case issueEventsURL = "issue_events_url"
        case issuesURL = "issues_url"
        case keysURL = "keys_url"
        case labelsURL = "labels_url"
        case language = "language"
        case languagesURL = "languages_url"
        case mergesURL = "merges_url"
        case milestonesURL = "milestones_url"
        case mirrorURL = "mirror_url"
        case name = "name"
        case notificationsURL = "notifications_url"
        case openIssues = "open_issues"
        case openIssuesCount = "open_issues_count"
        case owner = "owner"
        case pullsURL = "pulls_url"
        case pushedAt = "pushed_at"
        case releasesURL = "releases_url"
        case repoPrivate = "private"
        case size = "size"
        case sshURL = "ssh_url"
        case stargazersCount = "stargazers_count"
        case stargazersURL = "stargazers_url"
        case statusesURL = "statuses_url"
        case subscribersURL = "subscribers_url"
        case subscriptionURL = "subscription_url"
        case svnURL = "svn_url"
        case tagsURL = "tags_url"
        case teamsURL = "teams_url"
        case treesURL = "trees_url"
        case updatedAt = "updated_at"
        case url = "url"
        case watchers = "watchers"
        case watchersCount = "watchers_count"
    }
}

// MARK: BaseRepo convenience initializers and mutators

extension BaseRepo {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(BaseRepo.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        archiveURL: String? = nil,
        assigneesURL: String? = nil,
        blobsURL: String? = nil,
        branchesURL: String? = nil,
        cloneURL: String? = nil,
        collaboratorsURL: String? = nil,
        commentsURL: String? = nil,
        commitsURL: String? = nil,
        compareURL: String? = nil,
        contentsURL: String? = nil,
        contributorsURL: String? = nil,
        createdAt: Date? = nil,
        defaultBranch: String? = nil,
        deploymentsURL: String? = nil,
        description: String? = nil,
        downloadsURL: String? = nil,
        eventsURL: String? = nil,
        fork: Bool? = nil,
        forks: Int? = nil,
        forksCount: Int? = nil,
        forksURL: String? = nil,
        fullName: String? = nil,
        gitCommitsURL: String? = nil,
        gitRefsURL: String? = nil,
        gitTagsURL: String? = nil,
        gitURL: String? = nil,
        hasDownloads: Bool? = nil,
        hasIssues: Bool? = nil,
        hasPages: Bool? = nil,
        hasProjects: Bool? = nil,
        hasWiki: Bool? = nil,
        homepage: String? = nil,
        hooksURL: String? = nil,
        htmlURL: String? = nil,
        id: Int? = nil,
        issueCommentURL: String? = nil,
        issueEventsURL: String? = nil,
        issuesURL: String? = nil,
        keysURL: String? = nil,
        labelsURL: String? = nil,
        language: String? = nil,
        languagesURL: String? = nil,
        mergesURL: String? = nil,
        milestonesURL: String? = nil,
        mirrorURL: JSONNull?? = nil,
        name: String? = nil,
        notificationsURL: String? = nil,
        openIssues: Int? = nil,
        openIssuesCount: Int? = nil,
        owner: User? = nil,
        pullsURL: String? = nil,
        pushedAt: Date? = nil,
        releasesURL: String? = nil,
        repoPrivate: Bool? = nil,
        size: Int? = nil,
        sshURL: String? = nil,
        stargazersCount: Int? = nil,
        stargazersURL: String? = nil,
        statusesURL: String? = nil,
        subscribersURL: String? = nil,
        subscriptionURL: String? = nil,
        svnURL: String? = nil,
        tagsURL: String? = nil,
        teamsURL: String? = nil,
        treesURL: String? = nil,
        updatedAt: Date? = nil,
        url: String? = nil,
        watchers: Int? = nil,
        watchersCount: Int? = nil
    ) -> BaseRepo {
        return BaseRepo(
            archiveURL: archiveURL ?? self.archiveURL,
            assigneesURL: assigneesURL ?? self.assigneesURL,
            blobsURL: blobsURL ?? self.blobsURL,
            branchesURL: branchesURL ?? self.branchesURL,
            cloneURL: cloneURL ?? self.cloneURL,
            collaboratorsURL: collaboratorsURL ?? self.collaboratorsURL,
            commentsURL: commentsURL ?? self.commentsURL,
            commitsURL: commitsURL ?? self.commitsURL,
            compareURL: compareURL ?? self.compareURL,
            contentsURL: contentsURL ?? self.contentsURL,
            contributorsURL: contributorsURL ?? self.contributorsURL,
            createdAt: createdAt ?? self.createdAt,
            defaultBranch: defaultBranch ?? self.defaultBranch,
            deploymentsURL: deploymentsURL ?? self.deploymentsURL,
            description: description ?? self.description,
            downloadsURL: downloadsURL ?? self.downloadsURL,
            eventsURL: eventsURL ?? self.eventsURL,
            fork: fork ?? self.fork,
            forks: forks ?? self.forks,
            forksCount: forksCount ?? self.forksCount,
            forksURL: forksURL ?? self.forksURL,
            fullName: fullName ?? self.fullName,
            gitCommitsURL: gitCommitsURL ?? self.gitCommitsURL,
            gitRefsURL: gitRefsURL ?? self.gitRefsURL,
            gitTagsURL: gitTagsURL ?? self.gitTagsURL,
            gitURL: gitURL ?? self.gitURL,
            hasDownloads: hasDownloads ?? self.hasDownloads,
            hasIssues: hasIssues ?? self.hasIssues,
            hasPages: hasPages ?? self.hasPages,
            hasProjects: hasProjects ?? self.hasProjects,
            hasWiki: hasWiki ?? self.hasWiki,
            homepage: homepage ?? self.homepage,
            hooksURL: hooksURL ?? self.hooksURL,
            htmlURL: htmlURL ?? self.htmlURL,
            id: id ?? self.id,
            issueCommentURL: issueCommentURL ?? self.issueCommentURL,
            issueEventsURL: issueEventsURL ?? self.issueEventsURL,
            issuesURL: issuesURL ?? self.issuesURL,
            keysURL: keysURL ?? self.keysURL,
            labelsURL: labelsURL ?? self.labelsURL,
            language: language ?? self.language,
            languagesURL: languagesURL ?? self.languagesURL,
            mergesURL: mergesURL ?? self.mergesURL,
            milestonesURL: milestonesURL ?? self.milestonesURL,
            mirrorURL: mirrorURL ?? self.mirrorURL,
            name: name ?? self.name,
            notificationsURL: notificationsURL ?? self.notificationsURL,
            openIssues: openIssues ?? self.openIssues,
            openIssuesCount: openIssuesCount ?? self.openIssuesCount,
            owner: owner ?? self.owner,
            pullsURL: pullsURL ?? self.pullsURL,
            pushedAt: pushedAt ?? self.pushedAt,
            releasesURL: releasesURL ?? self.releasesURL,
            repoPrivate: repoPrivate ?? self.repoPrivate,
            size: size ?? self.size,
            sshURL: sshURL ?? self.sshURL,
            stargazersCount: stargazersCount ?? self.stargazersCount,
            stargazersURL: stargazersURL ?? self.stargazersURL,
            statusesURL: statusesURL ?? self.statusesURL,
            subscribersURL: subscribersURL ?? self.subscribersURL,
            subscriptionURL: subscriptionURL ?? self.subscriptionURL,
            svnURL: svnURL ?? self.svnURL,
            tagsURL: tagsURL ?? self.tagsURL,
            teamsURL: teamsURL ?? self.teamsURL,
            treesURL: treesURL ?? self.treesURL,
            updatedAt: updatedAt ?? self.updatedAt,
            url: url ?? self.url,
            watchers: watchers ?? self.watchers,
            watchersCount: watchersCount ?? self.watchersCount
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Links
struct Links: Codable {
    let comments: Comments
    let commits: Comments
    let html: Comments
    let issue: Comments
    let linksSelf: Comments
    let reviewComment: Comments
    let reviewComments: Comments
    let statuses: Comments

    enum CodingKeys: String, CodingKey {
        case comments = "comments"
        case commits = "commits"
        case html = "html"
        case issue = "issue"
        case linksSelf = "self"
        case reviewComment = "review_comment"
        case reviewComments = "review_comments"
        case statuses = "statuses"
    }
}

// MARK: Links convenience initializers and mutators

extension Links {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Links.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        comments: Comments? = nil,
        commits: Comments? = nil,
        html: Comments? = nil,
        issue: Comments? = nil,
        linksSelf: Comments? = nil,
        reviewComment: Comments? = nil,
        reviewComments: Comments? = nil,
        statuses: Comments? = nil
    ) -> Links {
        return Links(
            comments: comments ?? self.comments,
            commits: commits ?? self.commits,
            html: html ?? self.html,
            issue: issue ?? self.issue,
            linksSelf: linksSelf ?? self.linksSelf,
            reviewComment: reviewComment ?? self.reviewComment,
            reviewComments: reviewComments ?? self.reviewComments,
            statuses: statuses ?? self.statuses
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Comments
struct Comments: Codable {
    let href: String

    enum CodingKeys: String, CodingKey {
        case href = "href"
    }
}

// MARK: Comments convenience initializers and mutators

extension Comments {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Comments.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        href: String? = nil
    ) -> Comments {
        return Comments(
            href: href ?? self.href
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - TopLevelRepo
struct TopLevelRepo: Codable {
    let id: Int
    let name: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case url = "url"
    }
}

// MARK: TopLevelRepo convenience initializers and mutators

extension TopLevelRepo {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TopLevelRepo.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: Int? = nil,
        name: String? = nil,
        url: String? = nil
    ) -> TopLevelRepo {
        return TopLevelRepo(
            id: id ?? self.id,
            name: name ?? self.name,
            url: url ?? self.url
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

typealias TopLevel = [TopLevelElement]

extension Array where Element == TopLevel.Element {
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
