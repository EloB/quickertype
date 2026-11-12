// To parse this data:
//
//   const Convert = require("./TopLevel");
//
//   const topLevel = Convert.toTopLevel(json);
//
// These functions will throw an error if the JSON doesn't
// match the expected interface, even if the JSON is valid.

// Converts JSON strings to/from your types
// and asserts the results of JSON.parse at runtime
function toTopLevel(json) {
    return cast(JSON.parse(json), a(r("TopLevelElement")));
}

function topLevelToJson(value) {
    return JSON.stringify(uncast(value, a(r("TopLevelElement"))), null, 2);
}

function invalidValue(typ, val, key, parent = '') {
    const prettyTyp = prettyTypeName(typ);
    const parentText = parent ? ` on ${parent}` : '';
    const keyText = key ? ` for key "${key}"` : '';
    throw Error(`Invalid value${keyText}${parentText}. Expected ${prettyTyp} but got ${JSON.stringify(val)}`);
}

function prettyTypeName(typ) {
    if (Array.isArray(typ)) {
        if (typ.length === 2 && typ[0] === undefined) {
            return `an optional ${prettyTypeName(typ[1])}`;
        } else {
            return `one of [${typ.map(a => { return prettyTypeName(a); }).join(", ")}]`;
        }
    } else if (typeof typ === "object" && typ.literal !== undefined) {
        return typ.literal;
    } else {
        return typeof typ;
    }
}

function jsonToJSProps(typ) {
    if (typ.jsonToJS === undefined) {
        const map = {};
        typ.props.forEach((p) => map[p.json] = { key: p.js, typ: p.typ });
        typ.jsonToJS = map;
    }
    return typ.jsonToJS;
}

function jsToJSONProps(typ) {
    if (typ.jsToJSON === undefined) {
        const map = {};
        typ.props.forEach((p) => map[p.js] = { key: p.json, typ: p.typ });
        typ.jsToJSON = map;
    }
    return typ.jsToJSON;
}

function transform(val, typ, getProps, key = '', parent = '') {
    function transformPrimitive(typ, val) {
        if (typeof typ === typeof val) return val;
        return invalidValue(typ, val, key, parent);
    }

    function transformUnion(typs, val) {
        // val must validate against one typ in typs
        const l = typs.length;
        for (let i = 0; i < l; i++) {
            const typ = typs[i];
            try {
                return transform(val, typ, getProps);
            } catch (_) {}
        }
        return invalidValue(typs, val, key, parent);
    }

    function transformEnum(cases, val) {
        if (cases.indexOf(val) !== -1) return val;
        return invalidValue(cases.map(a => { return l(a); }), val, key, parent);
    }

    function transformArray(typ, val) {
        // val must be an array with no invalid elements
        if (!Array.isArray(val)) return invalidValue(l("array"), val, key, parent);

        return val.map(el => transform(el, typ, getProps));
    }

    function transformDate(val) {
        if (val === null) {
            return null;
        }
        const d = new Date(val);
        if (isNaN(d.valueOf())) {
            return invalidValue(l("Date"), val, key, parent);
        }
        return d;
    }

    function transformObject(props, additional, val) {
        if (val === null || typeof val !== "object" || Array.isArray(val)) {
            return invalidValue(l(ref || "object"), val, key, parent);
        }
        const result = {};
        Object.getOwnPropertyNames(props).forEach(key => {
            const prop = props[key];
            const v = Object.prototype.hasOwnProperty.call(val, key) ? val[key] : undefined;
            result[prop.key] = transform(v, prop.typ, getProps, key, ref);
        });
        Object.getOwnPropertyNames(val).forEach(key => {
            if (!Object.prototype.hasOwnProperty.call(props, key)) {
                result[key] = transform(val[key], additional, getProps, key, ref);
            }
        });
        return result;
    }

    if (typ === "any") return val;
    if (typ === null) {
        if (val === null) return val;
        return invalidValue(typ, val, key, parent);
    }
    if (typ === false) return invalidValue(typ, val, key, parent);
    let ref = undefined;
    while (typeof typ === "object" && typ.ref !== undefined) {
        ref = typ.ref;
        typ = typeMap[typ.ref];
    }
    if (Array.isArray(typ)) return transformEnum(typ, val);
    if (typeof typ === "object") {
        return typ.hasOwnProperty("pattern")      ? typeof val === "string" && new RegExp(typ.pattern).test(val) ? val : invalidValue(typ, val, key, parent)
            : typ.hasOwnProperty("string")       ? typeof val === "string" && (typ.min === undefined || Array.from(val).length >= typ.min) && (typ.max === undefined || Array.from(val).length <= typ.max) ? transform(val, typ.string, getProps, key, parent) : invalidValue(typ, val, key, parent)
            : typ.hasOwnProperty("number")       ? typeof val === "number" && (typ.min === undefined || val >= typ.min) && (typ.max === undefined || val <= typ.max) ? transform(val, typ.number, getProps, key, parent) : invalidValue(typ, val, key, parent)
            : typ.hasOwnProperty("integer")      ? typeof val === "number" && val % 1 === 0 ? val : invalidValue(l("integer"), val, key, parent)
            : typ.hasOwnProperty("unionMembers") ? transformUnion(typ.unionMembers, val)
            : typ.hasOwnProperty("arrayItems")    ? transformArray(typ.arrayItems, val)
            : typ.hasOwnProperty("props")         ? transformObject(getProps(typ), typ.additional, val)
            : invalidValue(typ, val, key, parent);
    }
    // Numbers can be parsed by Date but shouldn't be.
    if (typ === Date && (typeof val === "string" || val instanceof Date)) return transformDate(val);
    return transformPrimitive(typ, val);
}

function cast(val, typ) {
    return transform(val, typ, jsonToJSProps);
}

function uncast(val, typ) {
    return transform(val, typ, jsToJSONProps);
}

function l(typ) {
    return { literal: typ };
}

function a(typ) {
    return { arrayItems: typ };
}

function i(typ) {
    return { integer: typ };
}

function p(pattern) {
    return { pattern };
}

function s(typ, min, max) {
    return { string: typ, min, max };
}

function n(typ, min, max) {
    return { number: typ, min, max };
}

function u(...typs) {
    return { unionMembers: typs };
}

function o(props, additional) {
    return { props, additional };
}

function m(additional) {
    const props = [];
    return { props, additional };
}

function r(name) {
    return { ref: name };
}

const typeMap = {
    "TopLevelElement": o([
        { json: "actor", js: "actor", typ: r("Actor") },
        { json: "created_at", js: "created_at", typ: Date },
        { json: "id", js: "id", typ: "" },
        { json: "org", js: "org", typ: u(undefined, r("Actor")) },
        { json: "payload", js: "payload", typ: r("Payload") },
        { json: "public", js: "public", typ: true },
        { json: "repo", js: "repo", typ: r("TopLevelRepo") },
        { json: "type", js: "type", typ: r("Type") },
    ], false),
    "Actor": o([
        { json: "avatar_url", js: "avatar_url", typ: "" },
        { json: "display_login", js: "display_login", typ: u(undefined, "") },
        { json: "gravatar_id", js: "gravatar_id", typ: "" },
        { json: "id", js: "id", typ: i(0) },
        { json: "login", js: "login", typ: "" },
        { json: "url", js: "url", typ: "" },
    ], false),
    "Payload": o([
        { json: "action", js: "action", typ: u(undefined, "") },
        { json: "before", js: "before", typ: u(undefined, "") },
        { json: "commits", js: "commits", typ: u(undefined, a(r("Commit"))) },
        { json: "description", js: "description", typ: u(undefined, u(null, "")) },
        { json: "distinct_size", js: "distinct_size", typ: u(undefined, i(0)) },
        { json: "head", js: "head", typ: u(undefined, "") },
        { json: "master_branch", js: "master_branch", typ: u(undefined, "") },
        { json: "number", js: "number", typ: u(undefined, i(0)) },
        { json: "pull_request", js: "pull_request", typ: u(undefined, r("PullRequest")) },
        { json: "push_id", js: "push_id", typ: u(undefined, i(0)) },
        { json: "pusher_type", js: "pusher_type", typ: u(undefined, "") },
        { json: "ref", js: "ref", typ: u(undefined, "") },
        { json: "ref_type", js: "ref_type", typ: u(undefined, "") },
        { json: "size", js: "size", typ: u(undefined, i(0)) },
    ], false),
    "Commit": o([
        { json: "author", js: "author", typ: r("Author") },
        { json: "distinct", js: "distinct", typ: true },
        { json: "message", js: "message", typ: "" },
        { json: "sha", js: "sha", typ: "" },
        { json: "url", js: "url", typ: "" },
    ], false),
    "Author": o([
        { json: "email", js: "email", typ: "" },
        { json: "name", js: "name", typ: "" },
    ], false),
    "PullRequest": o([
        { json: "_links", js: "_links", typ: r("Links") },
        { json: "additions", js: "additions", typ: i(0) },
        { json: "assignee", js: "assignee", typ: null },
        { json: "assignees", js: "assignees", typ: a("any") },
        { json: "base", js: "base", typ: r("Base") },
        { json: "body", js: "body", typ: "" },
        { json: "changed_files", js: "changed_files", typ: i(0) },
        { json: "closed_at", js: "closed_at", typ: Date },
        { json: "comments", js: "comments", typ: i(0) },
        { json: "comments_url", js: "comments_url", typ: "" },
        { json: "commits", js: "commits", typ: i(0) },
        { json: "commits_url", js: "commits_url", typ: "" },
        { json: "created_at", js: "created_at", typ: Date },
        { json: "deletions", js: "deletions", typ: i(0) },
        { json: "diff_url", js: "diff_url", typ: "" },
        { json: "head", js: "head", typ: r("Base") },
        { json: "html_url", js: "html_url", typ: "" },
        { json: "id", js: "id", typ: i(0) },
        { json: "issue_url", js: "issue_url", typ: "" },
        { json: "locked", js: "locked", typ: true },
        { json: "maintainer_can_modify", js: "maintainer_can_modify", typ: true },
        { json: "merge_commit_sha", js: "merge_commit_sha", typ: "" },
        { json: "mergeable", js: "mergeable", typ: null },
        { json: "mergeable_state", js: "mergeable_state", typ: "" },
        { json: "merged", js: "merged", typ: true },
        { json: "merged_at", js: "merged_at", typ: Date },
        { json: "merged_by", js: "merged_by", typ: r("MergedBy") },
        { json: "milestone", js: "milestone", typ: null },
        { json: "number", js: "number", typ: i(0) },
        { json: "patch_url", js: "patch_url", typ: "" },
        { json: "rebaseable", js: "rebaseable", typ: null },
        { json: "requested_reviewers", js: "requested_reviewers", typ: a("any") },
        { json: "review_comment_url", js: "review_comment_url", typ: "" },
        { json: "review_comments", js: "review_comments", typ: i(0) },
        { json: "review_comments_url", js: "review_comments_url", typ: "" },
        { json: "state", js: "state", typ: "" },
        { json: "statuses_url", js: "statuses_url", typ: "" },
        { json: "title", js: "title", typ: "" },
        { json: "updated_at", js: "updated_at", typ: Date },
        { json: "url", js: "url", typ: "" },
        { json: "user", js: "user", typ: r("MergedBy") },
    ], false),
    "Links": o([
        { json: "comments", js: "comments", typ: r("Comments") },
        { json: "commits", js: "commits", typ: r("Comments") },
        { json: "html", js: "html", typ: r("Comments") },
        { json: "issue", js: "issue", typ: r("Comments") },
        { json: "review_comment", js: "review_comment", typ: r("Comments") },
        { json: "review_comments", js: "review_comments", typ: r("Comments") },
        { json: "self", js: "self", typ: r("Comments") },
        { json: "statuses", js: "statuses", typ: r("Comments") },
    ], false),
    "Comments": o([
        { json: "href", js: "href", typ: "" },
    ], false),
    "Base": o([
        { json: "label", js: "label", typ: "" },
        { json: "ref", js: "ref", typ: "" },
        { json: "repo", js: "repo", typ: r("BaseRepo") },
        { json: "sha", js: "sha", typ: "" },
        { json: "user", js: "user", typ: r("MergedBy") },
    ], false),
    "BaseRepo": o([
        { json: "archive_url", js: "archive_url", typ: "" },
        { json: "assignees_url", js: "assignees_url", typ: "" },
        { json: "blobs_url", js: "blobs_url", typ: "" },
        { json: "branches_url", js: "branches_url", typ: "" },
        { json: "clone_url", js: "clone_url", typ: "" },
        { json: "collaborators_url", js: "collaborators_url", typ: "" },
        { json: "comments_url", js: "comments_url", typ: "" },
        { json: "commits_url", js: "commits_url", typ: "" },
        { json: "compare_url", js: "compare_url", typ: "" },
        { json: "contents_url", js: "contents_url", typ: "" },
        { json: "contributors_url", js: "contributors_url", typ: "" },
        { json: "created_at", js: "created_at", typ: Date },
        { json: "default_branch", js: "default_branch", typ: "" },
        { json: "deployments_url", js: "deployments_url", typ: "" },
        { json: "description", js: "description", typ: null },
        { json: "downloads_url", js: "downloads_url", typ: "" },
        { json: "events_url", js: "events_url", typ: "" },
        { json: "fork", js: "fork", typ: true },
        { json: "forks", js: "forks", typ: i(0) },
        { json: "forks_count", js: "forks_count", typ: i(0) },
        { json: "forks_url", js: "forks_url", typ: "" },
        { json: "full_name", js: "full_name", typ: "" },
        { json: "git_commits_url", js: "git_commits_url", typ: "" },
        { json: "git_refs_url", js: "git_refs_url", typ: "" },
        { json: "git_tags_url", js: "git_tags_url", typ: "" },
        { json: "git_url", js: "git_url", typ: "" },
        { json: "has_downloads", js: "has_downloads", typ: true },
        { json: "has_issues", js: "has_issues", typ: true },
        { json: "has_pages", js: "has_pages", typ: true },
        { json: "has_projects", js: "has_projects", typ: true },
        { json: "has_wiki", js: "has_wiki", typ: true },
        { json: "homepage", js: "homepage", typ: null },
        { json: "hooks_url", js: "hooks_url", typ: "" },
        { json: "html_url", js: "html_url", typ: "" },
        { json: "id", js: "id", typ: i(0) },
        { json: "issue_comment_url", js: "issue_comment_url", typ: "" },
        { json: "issue_events_url", js: "issue_events_url", typ: "" },
        { json: "issues_url", js: "issues_url", typ: "" },
        { json: "keys_url", js: "keys_url", typ: "" },
        { json: "labels_url", js: "labels_url", typ: "" },
        { json: "language", js: "language", typ: "" },
        { json: "languages_url", js: "languages_url", typ: "" },
        { json: "merges_url", js: "merges_url", typ: "" },
        { json: "milestones_url", js: "milestones_url", typ: "" },
        { json: "mirror_url", js: "mirror_url", typ: null },
        { json: "name", js: "name", typ: "" },
        { json: "notifications_url", js: "notifications_url", typ: "" },
        { json: "open_issues", js: "open_issues", typ: i(0) },
        { json: "open_issues_count", js: "open_issues_count", typ: i(0) },
        { json: "owner", js: "owner", typ: r("MergedBy") },
        { json: "private", js: "private", typ: true },
        { json: "pulls_url", js: "pulls_url", typ: "" },
        { json: "pushed_at", js: "pushed_at", typ: Date },
        { json: "releases_url", js: "releases_url", typ: "" },
        { json: "size", js: "size", typ: i(0) },
        { json: "ssh_url", js: "ssh_url", typ: "" },
        { json: "stargazers_count", js: "stargazers_count", typ: i(0) },
        { json: "stargazers_url", js: "stargazers_url", typ: "" },
        { json: "statuses_url", js: "statuses_url", typ: "" },
        { json: "subscribers_url", js: "subscribers_url", typ: "" },
        { json: "subscription_url", js: "subscription_url", typ: "" },
        { json: "svn_url", js: "svn_url", typ: "" },
        { json: "tags_url", js: "tags_url", typ: "" },
        { json: "teams_url", js: "teams_url", typ: "" },
        { json: "trees_url", js: "trees_url", typ: "" },
        { json: "updated_at", js: "updated_at", typ: Date },
        { json: "url", js: "url", typ: "" },
        { json: "watchers", js: "watchers", typ: i(0) },
        { json: "watchers_count", js: "watchers_count", typ: i(0) },
    ], false),
    "MergedBy": o([
        { json: "avatar_url", js: "avatar_url", typ: "" },
        { json: "events_url", js: "events_url", typ: "" },
        { json: "followers_url", js: "followers_url", typ: "" },
        { json: "following_url", js: "following_url", typ: "" },
        { json: "gists_url", js: "gists_url", typ: "" },
        { json: "gravatar_id", js: "gravatar_id", typ: "" },
        { json: "html_url", js: "html_url", typ: "" },
        { json: "id", js: "id", typ: i(0) },
        { json: "login", js: "login", typ: "" },
        { json: "organizations_url", js: "organizations_url", typ: "" },
        { json: "received_events_url", js: "received_events_url", typ: "" },
        { json: "repos_url", js: "repos_url", typ: "" },
        { json: "site_admin", js: "site_admin", typ: true },
        { json: "starred_url", js: "starred_url", typ: "" },
        { json: "subscriptions_url", js: "subscriptions_url", typ: "" },
        { json: "type", js: "type", typ: "" },
        { json: "url", js: "url", typ: "" },
    ], false),
    "TopLevelRepo": o([
        { json: "id", js: "id", typ: i(0) },
        { json: "name", js: "name", typ: "" },
        { json: "url", js: "url", typ: "" },
    ], false),
    "Type": [
        "PushEvent",
        "CreateEvent",
        "WatchEvent",
        "PullRequestEvent",
        "DeleteEvent",
    ],
};

module.exports = {
    "topLevelToJson": topLevelToJson,
    "toTopLevel": toTopLevel,
};
