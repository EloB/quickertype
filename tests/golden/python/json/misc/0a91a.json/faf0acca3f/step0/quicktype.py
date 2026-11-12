import datetime
from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast, Callable
from enum import Enum
import dateutil.parser


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


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


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
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


@dataclass
class Actor:
    avatar_url: str
    gravatar_id: str
    id: int
    login: str
    url: str
    display_login: str | None

    @staticmethod
    def from_dict(obj: Any) -> 'Actor':
        assert isinstance(obj, dict)
        avatar_url = from_str(obj["avatar_url"])
        gravatar_id = from_str(obj["gravatar_id"])
        id = from_int(obj["id"])
        login = from_str(obj["login"])
        url = from_str(obj["url"])
        display_login = from_union([from_none, from_str], obj.get("display_login"))
        return Actor(avatar_url, gravatar_id, id, login, url, display_login)

    def to_dict(self) -> dict:
        result: dict = {}
        result["avatar_url"] = from_str(self.avatar_url)
        result["gravatar_id"] = from_str(self.gravatar_id)
        result["id"] = from_int(self.id)
        result["login"] = from_str(self.login)
        result["url"] = from_str(self.url)
        if self.display_login is not None:
            result["display_login"] = from_union([from_none, from_str], self.display_login)
        return result


@dataclass
class Author:
    email: str
    name: str

    @staticmethod
    def from_dict(obj: Any) -> 'Author':
        assert isinstance(obj, dict)
        email = from_str(obj["email"])
        name = from_str(obj["name"])
        return Author(email, name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["email"] = from_str(self.email)
        result["name"] = from_str(self.name)
        return result


@dataclass
class Commit:
    author: Author
    distinct: bool
    message: str
    sha: str
    url: str

    @staticmethod
    def from_dict(obj: Any) -> 'Commit':
        assert isinstance(obj, dict)
        author = Author.from_dict(obj["author"])
        distinct = from_bool(obj["distinct"])
        message = from_str(obj["message"])
        sha = from_str(obj["sha"])
        url = from_str(obj["url"])
        return Commit(author, distinct, message, sha, url)

    def to_dict(self) -> dict:
        result: dict = {}
        result["author"] = to_class(Author, self.author)
        result["distinct"] = from_bool(self.distinct)
        result["message"] = from_str(self.message)
        result["sha"] = from_str(self.sha)
        result["url"] = from_str(self.url)
        return result


@dataclass
class MergedBy:
    avatar_url: str
    events_url: str
    followers_url: str
    following_url: str
    gists_url: str
    gravatar_id: str
    html_url: str
    id: int
    login: str
    organizations_url: str
    received_events_url: str
    repos_url: str
    site_admin: bool
    starred_url: str
    subscriptions_url: str
    type: str
    url: str

    @staticmethod
    def from_dict(obj: Any) -> 'MergedBy':
        assert isinstance(obj, dict)
        avatar_url = from_str(obj["avatar_url"])
        events_url = from_str(obj["events_url"])
        followers_url = from_str(obj["followers_url"])
        following_url = from_str(obj["following_url"])
        gists_url = from_str(obj["gists_url"])
        gravatar_id = from_str(obj["gravatar_id"])
        html_url = from_str(obj["html_url"])
        id = from_int(obj["id"])
        login = from_str(obj["login"])
        organizations_url = from_str(obj["organizations_url"])
        received_events_url = from_str(obj["received_events_url"])
        repos_url = from_str(obj["repos_url"])
        site_admin = from_bool(obj["site_admin"])
        starred_url = from_str(obj["starred_url"])
        subscriptions_url = from_str(obj["subscriptions_url"])
        type = from_str(obj["type"])
        url = from_str(obj["url"])
        return MergedBy(avatar_url, events_url, followers_url, following_url, gists_url, gravatar_id, html_url, id, login, organizations_url, received_events_url, repos_url, site_admin, starred_url, subscriptions_url, type, url)

    def to_dict(self) -> dict:
        result: dict = {}
        result["avatar_url"] = from_str(self.avatar_url)
        result["events_url"] = from_str(self.events_url)
        result["followers_url"] = from_str(self.followers_url)
        result["following_url"] = from_str(self.following_url)
        result["gists_url"] = from_str(self.gists_url)
        result["gravatar_id"] = from_str(self.gravatar_id)
        result["html_url"] = from_str(self.html_url)
        result["id"] = from_int(self.id)
        result["login"] = from_str(self.login)
        result["organizations_url"] = from_str(self.organizations_url)
        result["received_events_url"] = from_str(self.received_events_url)
        result["repos_url"] = from_str(self.repos_url)
        result["site_admin"] = from_bool(self.site_admin)
        result["starred_url"] = from_str(self.starred_url)
        result["subscriptions_url"] = from_str(self.subscriptions_url)
        result["type"] = from_str(self.type)
        result["url"] = from_str(self.url)
        return result


@dataclass
class BaseRepo:
    archive_url: str
    assignees_url: str
    blobs_url: str
    branches_url: str
    clone_url: str
    collaborators_url: str
    comments_url: str
    commits_url: str
    compare_url: str
    contents_url: str
    contributors_url: str
    created_at: datetime.datetime
    default_branch: str
    deployments_url: str
    downloads_url: str
    events_url: str
    fork: bool
    forks: int
    forks_count: int
    forks_url: str
    full_name: str
    git_commits_url: str
    git_refs_url: str
    git_tags_url: str
    git_url: str
    has_downloads: bool
    has_issues: bool
    has_pages: bool
    has_projects: bool
    has_wiki: bool
    hooks_url: str
    html_url: str
    id: int
    issue_comment_url: str
    issue_events_url: str
    issues_url: str
    keys_url: str
    labels_url: str
    language: str
    languages_url: str
    merges_url: str
    milestones_url: str
    name: str
    notifications_url: str
    open_issues: int
    open_issues_count: int
    owner: MergedBy
    private: bool
    pulls_url: str
    pushed_at: datetime.datetime
    releases_url: str
    size: int
    ssh_url: str
    stargazers_count: int
    stargazers_url: str
    statuses_url: str
    subscribers_url: str
    subscription_url: str
    svn_url: str
    tags_url: str
    teams_url: str
    trees_url: str
    updated_at: datetime.datetime
    url: str
    watchers: int
    watchers_count: int
    description: None
    homepage: None
    mirror_url: None

    @staticmethod
    def from_dict(obj: Any) -> 'BaseRepo':
        assert isinstance(obj, dict)
        archive_url = from_str(obj["archive_url"])
        assignees_url = from_str(obj["assignees_url"])
        blobs_url = from_str(obj["blobs_url"])
        branches_url = from_str(obj["branches_url"])
        clone_url = from_str(obj["clone_url"])
        collaborators_url = from_str(obj["collaborators_url"])
        comments_url = from_str(obj["comments_url"])
        commits_url = from_str(obj["commits_url"])
        compare_url = from_str(obj["compare_url"])
        contents_url = from_str(obj["contents_url"])
        contributors_url = from_str(obj["contributors_url"])
        created_at = from_datetime(obj["created_at"])
        default_branch = from_str(obj["default_branch"])
        deployments_url = from_str(obj["deployments_url"])
        downloads_url = from_str(obj["downloads_url"])
        events_url = from_str(obj["events_url"])
        fork = from_bool(obj["fork"])
        forks = from_int(obj["forks"])
        forks_count = from_int(obj["forks_count"])
        forks_url = from_str(obj["forks_url"])
        full_name = from_str(obj["full_name"])
        git_commits_url = from_str(obj["git_commits_url"])
        git_refs_url = from_str(obj["git_refs_url"])
        git_tags_url = from_str(obj["git_tags_url"])
        git_url = from_str(obj["git_url"])
        has_downloads = from_bool(obj["has_downloads"])
        has_issues = from_bool(obj["has_issues"])
        has_pages = from_bool(obj["has_pages"])
        has_projects = from_bool(obj["has_projects"])
        has_wiki = from_bool(obj["has_wiki"])
        hooks_url = from_str(obj["hooks_url"])
        html_url = from_str(obj["html_url"])
        id = from_int(obj["id"])
        issue_comment_url = from_str(obj["issue_comment_url"])
        issue_events_url = from_str(obj["issue_events_url"])
        issues_url = from_str(obj["issues_url"])
        keys_url = from_str(obj["keys_url"])
        labels_url = from_str(obj["labels_url"])
        language = from_str(obj["language"])
        languages_url = from_str(obj["languages_url"])
        merges_url = from_str(obj["merges_url"])
        milestones_url = from_str(obj["milestones_url"])
        name = from_str(obj["name"])
        notifications_url = from_str(obj["notifications_url"])
        open_issues = from_int(obj["open_issues"])
        open_issues_count = from_int(obj["open_issues_count"])
        owner = MergedBy.from_dict(obj["owner"])
        private = from_bool(obj["private"])
        pulls_url = from_str(obj["pulls_url"])
        pushed_at = from_datetime(obj["pushed_at"])
        releases_url = from_str(obj["releases_url"])
        size = from_int(obj["size"])
        ssh_url = from_str(obj["ssh_url"])
        stargazers_count = from_int(obj["stargazers_count"])
        stargazers_url = from_str(obj["stargazers_url"])
        statuses_url = from_str(obj["statuses_url"])
        subscribers_url = from_str(obj["subscribers_url"])
        subscription_url = from_str(obj["subscription_url"])
        svn_url = from_str(obj["svn_url"])
        tags_url = from_str(obj["tags_url"])
        teams_url = from_str(obj["teams_url"])
        trees_url = from_str(obj["trees_url"])
        updated_at = from_datetime(obj["updated_at"])
        url = from_str(obj["url"])
        watchers = from_int(obj["watchers"])
        watchers_count = from_int(obj["watchers_count"])
        description = from_none(obj["description"])
        homepage = from_none(obj["homepage"])
        mirror_url = from_none(obj["mirror_url"])
        return BaseRepo(archive_url, assignees_url, blobs_url, branches_url, clone_url, collaborators_url, comments_url, commits_url, compare_url, contents_url, contributors_url, created_at, default_branch, deployments_url, downloads_url, events_url, fork, forks, forks_count, forks_url, full_name, git_commits_url, git_refs_url, git_tags_url, git_url, has_downloads, has_issues, has_pages, has_projects, has_wiki, hooks_url, html_url, id, issue_comment_url, issue_events_url, issues_url, keys_url, labels_url, language, languages_url, merges_url, milestones_url, name, notifications_url, open_issues, open_issues_count, owner, private, pulls_url, pushed_at, releases_url, size, ssh_url, stargazers_count, stargazers_url, statuses_url, subscribers_url, subscription_url, svn_url, tags_url, teams_url, trees_url, updated_at, url, watchers, watchers_count, description, homepage, mirror_url)

    def to_dict(self) -> dict:
        result: dict = {}
        result["archive_url"] = from_str(self.archive_url)
        result["assignees_url"] = from_str(self.assignees_url)
        result["blobs_url"] = from_str(self.blobs_url)
        result["branches_url"] = from_str(self.branches_url)
        result["clone_url"] = from_str(self.clone_url)
        result["collaborators_url"] = from_str(self.collaborators_url)
        result["comments_url"] = from_str(self.comments_url)
        result["commits_url"] = from_str(self.commits_url)
        result["compare_url"] = from_str(self.compare_url)
        result["contents_url"] = from_str(self.contents_url)
        result["contributors_url"] = from_str(self.contributors_url)
        result["created_at"] = self.created_at.isoformat()
        result["default_branch"] = from_str(self.default_branch)
        result["deployments_url"] = from_str(self.deployments_url)
        result["downloads_url"] = from_str(self.downloads_url)
        result["events_url"] = from_str(self.events_url)
        result["fork"] = from_bool(self.fork)
        result["forks"] = from_int(self.forks)
        result["forks_count"] = from_int(self.forks_count)
        result["forks_url"] = from_str(self.forks_url)
        result["full_name"] = from_str(self.full_name)
        result["git_commits_url"] = from_str(self.git_commits_url)
        result["git_refs_url"] = from_str(self.git_refs_url)
        result["git_tags_url"] = from_str(self.git_tags_url)
        result["git_url"] = from_str(self.git_url)
        result["has_downloads"] = from_bool(self.has_downloads)
        result["has_issues"] = from_bool(self.has_issues)
        result["has_pages"] = from_bool(self.has_pages)
        result["has_projects"] = from_bool(self.has_projects)
        result["has_wiki"] = from_bool(self.has_wiki)
        result["hooks_url"] = from_str(self.hooks_url)
        result["html_url"] = from_str(self.html_url)
        result["id"] = from_int(self.id)
        result["issue_comment_url"] = from_str(self.issue_comment_url)
        result["issue_events_url"] = from_str(self.issue_events_url)
        result["issues_url"] = from_str(self.issues_url)
        result["keys_url"] = from_str(self.keys_url)
        result["labels_url"] = from_str(self.labels_url)
        result["language"] = from_str(self.language)
        result["languages_url"] = from_str(self.languages_url)
        result["merges_url"] = from_str(self.merges_url)
        result["milestones_url"] = from_str(self.milestones_url)
        result["name"] = from_str(self.name)
        result["notifications_url"] = from_str(self.notifications_url)
        result["open_issues"] = from_int(self.open_issues)
        result["open_issues_count"] = from_int(self.open_issues_count)
        result["owner"] = to_class(MergedBy, self.owner)
        result["private"] = from_bool(self.private)
        result["pulls_url"] = from_str(self.pulls_url)
        result["pushed_at"] = self.pushed_at.isoformat()
        result["releases_url"] = from_str(self.releases_url)
        result["size"] = from_int(self.size)
        result["ssh_url"] = from_str(self.ssh_url)
        result["stargazers_count"] = from_int(self.stargazers_count)
        result["stargazers_url"] = from_str(self.stargazers_url)
        result["statuses_url"] = from_str(self.statuses_url)
        result["subscribers_url"] = from_str(self.subscribers_url)
        result["subscription_url"] = from_str(self.subscription_url)
        result["svn_url"] = from_str(self.svn_url)
        result["tags_url"] = from_str(self.tags_url)
        result["teams_url"] = from_str(self.teams_url)
        result["trees_url"] = from_str(self.trees_url)
        result["updated_at"] = self.updated_at.isoformat()
        result["url"] = from_str(self.url)
        result["watchers"] = from_int(self.watchers)
        result["watchers_count"] = from_int(self.watchers_count)
        result["description"] = from_none(self.description)
        result["homepage"] = from_none(self.homepage)
        result["mirror_url"] = from_none(self.mirror_url)
        return result


@dataclass
class Base:
    label: str
    ref: str
    repo: BaseRepo
    sha: str
    user: MergedBy

    @staticmethod
    def from_dict(obj: Any) -> 'Base':
        assert isinstance(obj, dict)
        label = from_str(obj["label"])
        ref = from_str(obj["ref"])
        repo = BaseRepo.from_dict(obj["repo"])
        sha = from_str(obj["sha"])
        user = MergedBy.from_dict(obj["user"])
        return Base(label, ref, repo, sha, user)

    def to_dict(self) -> dict:
        result: dict = {}
        result["label"] = from_str(self.label)
        result["ref"] = from_str(self.ref)
        result["repo"] = to_class(BaseRepo, self.repo)
        result["sha"] = from_str(self.sha)
        result["user"] = to_class(MergedBy, self.user)
        return result


@dataclass
class Comments:
    href: str

    @staticmethod
    def from_dict(obj: Any) -> 'Comments':
        assert isinstance(obj, dict)
        href = from_str(obj["href"])
        return Comments(href)

    def to_dict(self) -> dict:
        result: dict = {}
        result["href"] = from_str(self.href)
        return result


@dataclass
class Links:
    comments: Comments
    commits: Comments
    html: Comments
    issue: Comments
    review_comment: Comments
    review_comments: Comments
    links_self: Comments
    statuses: Comments

    @staticmethod
    def from_dict(obj: Any) -> 'Links':
        assert isinstance(obj, dict)
        comments = Comments.from_dict(obj["comments"])
        commits = Comments.from_dict(obj["commits"])
        html = Comments.from_dict(obj["html"])
        issue = Comments.from_dict(obj["issue"])
        review_comment = Comments.from_dict(obj["review_comment"])
        review_comments = Comments.from_dict(obj["review_comments"])
        links_self = Comments.from_dict(obj["self"])
        statuses = Comments.from_dict(obj["statuses"])
        return Links(comments, commits, html, issue, review_comment, review_comments, links_self, statuses)

    def to_dict(self) -> dict:
        result: dict = {}
        result["comments"] = to_class(Comments, self.comments)
        result["commits"] = to_class(Comments, self.commits)
        result["html"] = to_class(Comments, self.html)
        result["issue"] = to_class(Comments, self.issue)
        result["review_comment"] = to_class(Comments, self.review_comment)
        result["review_comments"] = to_class(Comments, self.review_comments)
        result["self"] = to_class(Comments, self.links_self)
        result["statuses"] = to_class(Comments, self.statuses)
        return result


@dataclass
class PullRequest:
    links: Links
    additions: int
    assignees: list[Any]
    base: Base
    body: str
    changed_files: int
    closed_at: datetime.datetime
    comments: int
    comments_url: str
    commits: int
    commits_url: str
    created_at: datetime.datetime
    deletions: int
    diff_url: str
    head: Base
    html_url: str
    id: int
    issue_url: str
    locked: bool
    maintainer_can_modify: bool
    merge_commit_sha: str
    mergeable_state: str
    merged: bool
    merged_at: datetime.datetime
    merged_by: MergedBy
    number: int
    patch_url: str
    requested_reviewers: list[Any]
    review_comment_url: str
    review_comments: int
    review_comments_url: str
    state: str
    statuses_url: str
    title: str
    updated_at: datetime.datetime
    url: str
    user: MergedBy
    assignee: None
    mergeable: None
    milestone: None
    rebaseable: None

    @staticmethod
    def from_dict(obj: Any) -> 'PullRequest':
        assert isinstance(obj, dict)
        links = Links.from_dict(obj["_links"])
        additions = from_int(obj["additions"])
        assignees = from_list(lambda x: x, obj["assignees"])
        base = Base.from_dict(obj["base"])
        body = from_str(obj["body"])
        changed_files = from_int(obj["changed_files"])
        closed_at = from_datetime(obj["closed_at"])
        comments = from_int(obj["comments"])
        comments_url = from_str(obj["comments_url"])
        commits = from_int(obj["commits"])
        commits_url = from_str(obj["commits_url"])
        created_at = from_datetime(obj["created_at"])
        deletions = from_int(obj["deletions"])
        diff_url = from_str(obj["diff_url"])
        head = Base.from_dict(obj["head"])
        html_url = from_str(obj["html_url"])
        id = from_int(obj["id"])
        issue_url = from_str(obj["issue_url"])
        locked = from_bool(obj["locked"])
        maintainer_can_modify = from_bool(obj["maintainer_can_modify"])
        merge_commit_sha = from_str(obj["merge_commit_sha"])
        mergeable_state = from_str(obj["mergeable_state"])
        merged = from_bool(obj["merged"])
        merged_at = from_datetime(obj["merged_at"])
        merged_by = MergedBy.from_dict(obj["merged_by"])
        number = from_int(obj["number"])
        patch_url = from_str(obj["patch_url"])
        requested_reviewers = from_list(lambda x: x, obj["requested_reviewers"])
        review_comment_url = from_str(obj["review_comment_url"])
        review_comments = from_int(obj["review_comments"])
        review_comments_url = from_str(obj["review_comments_url"])
        state = from_str(obj["state"])
        statuses_url = from_str(obj["statuses_url"])
        title = from_str(obj["title"])
        updated_at = from_datetime(obj["updated_at"])
        url = from_str(obj["url"])
        user = MergedBy.from_dict(obj["user"])
        assignee = from_none(obj["assignee"])
        mergeable = from_none(obj["mergeable"])
        milestone = from_none(obj["milestone"])
        rebaseable = from_none(obj["rebaseable"])
        return PullRequest(links, additions, assignees, base, body, changed_files, closed_at, comments, comments_url, commits, commits_url, created_at, deletions, diff_url, head, html_url, id, issue_url, locked, maintainer_can_modify, merge_commit_sha, mergeable_state, merged, merged_at, merged_by, number, patch_url, requested_reviewers, review_comment_url, review_comments, review_comments_url, state, statuses_url, title, updated_at, url, user, assignee, mergeable, milestone, rebaseable)

    def to_dict(self) -> dict:
        result: dict = {}
        result["_links"] = to_class(Links, self.links)
        result["additions"] = from_int(self.additions)
        result["assignees"] = from_list(lambda x: x, self.assignees)
        result["base"] = to_class(Base, self.base)
        result["body"] = from_str(self.body)
        result["changed_files"] = from_int(self.changed_files)
        result["closed_at"] = self.closed_at.isoformat()
        result["comments"] = from_int(self.comments)
        result["comments_url"] = from_str(self.comments_url)
        result["commits"] = from_int(self.commits)
        result["commits_url"] = from_str(self.commits_url)
        result["created_at"] = self.created_at.isoformat()
        result["deletions"] = from_int(self.deletions)
        result["diff_url"] = from_str(self.diff_url)
        result["head"] = to_class(Base, self.head)
        result["html_url"] = from_str(self.html_url)
        result["id"] = from_int(self.id)
        result["issue_url"] = from_str(self.issue_url)
        result["locked"] = from_bool(self.locked)
        result["maintainer_can_modify"] = from_bool(self.maintainer_can_modify)
        result["merge_commit_sha"] = from_str(self.merge_commit_sha)
        result["mergeable_state"] = from_str(self.mergeable_state)
        result["merged"] = from_bool(self.merged)
        result["merged_at"] = self.merged_at.isoformat()
        result["merged_by"] = to_class(MergedBy, self.merged_by)
        result["number"] = from_int(self.number)
        result["patch_url"] = from_str(self.patch_url)
        result["requested_reviewers"] = from_list(lambda x: x, self.requested_reviewers)
        result["review_comment_url"] = from_str(self.review_comment_url)
        result["review_comments"] = from_int(self.review_comments)
        result["review_comments_url"] = from_str(self.review_comments_url)
        result["state"] = from_str(self.state)
        result["statuses_url"] = from_str(self.statuses_url)
        result["title"] = from_str(self.title)
        result["updated_at"] = self.updated_at.isoformat()
        result["url"] = from_str(self.url)
        result["user"] = to_class(MergedBy, self.user)
        result["assignee"] = from_none(self.assignee)
        result["mergeable"] = from_none(self.mergeable)
        result["milestone"] = from_none(self.milestone)
        result["rebaseable"] = from_none(self.rebaseable)
        return result


@dataclass
class Payload:
    action: str | None
    before: str | None
    commits: list[Commit] | None
    description: str | None
    distinct_size: int | None
    head: str | None
    master_branch: str | None
    number: int | None
    pull_request: PullRequest | None
    push_id: int | None
    pusher_type: str | None
    ref: str | None
    ref_type: str | None
    size: int | None

    @staticmethod
    def from_dict(obj: Any) -> 'Payload':
        assert isinstance(obj, dict)
        action = from_union([from_none, from_str], obj.get("action"))
        before = from_union([from_none, from_str], obj.get("before"))
        commits = from_union([lambda x: from_list(Commit.from_dict, x), from_none], obj.get("commits"))
        description = from_union([from_none, from_str], obj.get("description"))
        distinct_size = from_union([from_int, from_none], obj.get("distinct_size"))
        head = from_union([from_none, from_str], obj.get("head"))
        master_branch = from_union([from_none, from_str], obj.get("master_branch"))
        number = from_union([from_int, from_none], obj.get("number"))
        pull_request = from_union([PullRequest.from_dict, from_none], obj.get("pull_request"))
        push_id = from_union([from_int, from_none], obj.get("push_id"))
        pusher_type = from_union([from_none, from_str], obj.get("pusher_type"))
        ref = from_union([from_none, from_str], obj.get("ref"))
        ref_type = from_union([from_none, from_str], obj.get("ref_type"))
        size = from_union([from_int, from_none], obj.get("size"))
        return Payload(action, before, commits, description, distinct_size, head, master_branch, number, pull_request, push_id, pusher_type, ref, ref_type, size)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.action is not None:
            result["action"] = from_union([from_none, from_str], self.action)
        if self.before is not None:
            result["before"] = from_union([from_none, from_str], self.before)
        if self.commits is not None:
            result["commits"] = from_union([lambda x: from_list(lambda x: to_class(Commit, x), x), from_none], self.commits)
        if self.description is not None:
            result["description"] = from_union([from_none, from_str], self.description)
        if self.distinct_size is not None:
            result["distinct_size"] = from_union([from_int, from_none], self.distinct_size)
        if self.head is not None:
            result["head"] = from_union([from_none, from_str], self.head)
        if self.master_branch is not None:
            result["master_branch"] = from_union([from_none, from_str], self.master_branch)
        if self.number is not None:
            result["number"] = from_union([from_int, from_none], self.number)
        if self.pull_request is not None:
            result["pull_request"] = from_union([lambda x: to_class(PullRequest, x), from_none], self.pull_request)
        if self.push_id is not None:
            result["push_id"] = from_union([from_int, from_none], self.push_id)
        if self.pusher_type is not None:
            result["pusher_type"] = from_union([from_none, from_str], self.pusher_type)
        if self.ref is not None:
            result["ref"] = from_union([from_none, from_str], self.ref)
        if self.ref_type is not None:
            result["ref_type"] = from_union([from_none, from_str], self.ref_type)
        if self.size is not None:
            result["size"] = from_union([from_int, from_none], self.size)
        return result


@dataclass
class TopLevelRepo:
    id: int
    name: str
    url: str

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevelRepo':
        assert isinstance(obj, dict)
        id = from_int(obj["id"])
        name = from_str(obj["name"])
        url = from_str(obj["url"])
        return TopLevelRepo(id, name, url)

    def to_dict(self) -> dict:
        result: dict = {}
        result["id"] = from_int(self.id)
        result["name"] = from_str(self.name)
        result["url"] = from_str(self.url)
        return result


class TypeEnum(Enum):
    PUSH_EVENT = "PushEvent"
    CREATE_EVENT = "CreateEvent"
    WATCH_EVENT = "WatchEvent"
    PULL_REQUEST_EVENT = "PullRequestEvent"
    DELETE_EVENT = "DeleteEvent"


@dataclass
class TopLevelElement:
    actor: Actor
    created_at: datetime.datetime
    id: str
    payload: Payload
    public: bool
    repo: TopLevelRepo
    type: TypeEnum
    org: Actor | None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevelElement':
        assert isinstance(obj, dict)
        actor = Actor.from_dict(obj["actor"])
        created_at = from_datetime(obj["created_at"])
        id = from_str(obj["id"])
        payload = Payload.from_dict(obj["payload"])
        public = from_bool(obj["public"])
        repo = TopLevelRepo.from_dict(obj["repo"])
        type = TypeEnum(obj["type"])
        org = from_union([Actor.from_dict, from_none], obj.get("org"))
        return TopLevelElement(actor, created_at, id, payload, public, repo, type, org)

    def to_dict(self) -> dict:
        result: dict = {}
        result["actor"] = to_class(Actor, self.actor)
        result["created_at"] = self.created_at.isoformat()
        result["id"] = from_str(self.id)
        result["payload"] = to_class(Payload, self.payload)
        result["public"] = from_bool(self.public)
        result["repo"] = to_class(TopLevelRepo, self.repo)
        result["type"] = to_enum(TypeEnum, self.type)
        if self.org is not None:
            result["org"] = from_union([lambda x: to_class(Actor, x), from_none], self.org)
        return result


def top_level_from_dict(s: Any) -> list[TopLevelElement]:
    return from_list(TopLevelElement.from_dict, s)


def top_level_to_dict(x: list[TopLevelElement]) -> Any:
    return from_list(lambda x: to_class(TopLevelElement, x), x)
