// Writes site/data/quicktype.json: what the landing page says about
// quicktype, the project quickertype is a port of, taken from primary
// sources only:
//
// * quicktype's git history, in a checkout at the commit the port matches
//   (`quicktype_commit` in tests/golden/REFERENCE): the first commit, the
//   number of commits and of author names, the commits per year;
// * GitHub's REST API (with the `gh` CLI): the repository (stars, forks,
//   licence, default branch, owner) and its contributors list, the people
//   GitHub links commits on the default branch to, with their avatars. Bots
//   are left out, and named in the file.
//
//   node site/quicktype-snapshot.mjs [quicktype checkout]
//
// The checkout is found as tests/golden/REFERENCE's tools do: the argument,
// $QUICKTYPE_REFERENCE, ../quicktype or ../../quicktype. The build reads the
// file (site/landing.mjs) and refuses it when its commit is not the one in
// tests/golden/REFERENCE: re-recording the corpus against a new quicktype
// commit means running this again. Nothing here states a role (who
// "created" what): the page says what the history and the API say.

import { execFileSync } from "node:child_process";
import * as fs from "node:fs";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

import { quicktypeReference } from "./reference.mjs";

const siteRoot = path.dirname(fileURLToPath(import.meta.url));
const repositoryRoot = path.join(siteRoot, "..");
export const quicktypeFile = path.join(siteRoot, "data", "quicktype.json");
const repository = "glideapps/quicktype";

function checkout() {
    const candidates = [process.argv[2], process.env.QUICKTYPE_REFERENCE, "../quicktype", "../../quicktype"].filter(Boolean);
    for (const candidate of candidates) {
        const dir = path.resolve(repositoryRoot, candidate);
        if (fs.existsSync(path.join(dir, ".git")) && fs.existsSync(path.join(dir, "packages", "quicktype-core"))) return dir;
    }

    throw new Error(`no quicktype checkout (tried ${candidates.join(", ")}): pass its path`);
}

const git = (dir, ...args) => execFileSync("git", ["-C", dir, ...args], { encoding: "utf8", maxBuffer: 1 << 26 });
const gh = (endpoint) => JSON.parse(execFileSync("gh", ["api", "--paginate", "--slurp", endpoint], { encoding: "utf8", maxBuffer: 1 << 26 })).flat();
const utcDate = (seconds) => new Date(seconds * 1000).toISOString().slice(0, 10);

const { commit } = quicktypeReference();
const dir = checkout();
git(dir, "cat-file", "-e", `${commit}^{commit}`);

// The history up to the commit the port matches, merges left out.
const times = git(dir, "log", "--no-merges", "--format=%H %at", commit)
    .trim()
    .split("\n")
    .map((line) => {
        const [sha, at] = line.split(" ");
        return { sha, at: Number(at) };
    });
const first = times.at(-1);
const byYear = {};
for (const { at } of times) {
    const year = new Date(at * 1000).getUTCFullYear();
    byYear[year] = (byYear[year] ?? 0) + 1;
}
const authors = git(dir, "shortlog", "-sn", "--no-merges", commit).trim().split("\n").length;
const committed = Number(git(dir, "log", "-1", "--format=%ct", commit).trim());

const [repo] = gh(`repos/${repository}`);
const [owner] = gh(`orgs/${repo.owner.login}`);
const listed = gh(`repos/${repository}/contributors?per_page=100`);
const people = listed.filter((c) => c.type === "User");
const bots = listed.filter((c) => c.type !== "User").map((c) => c.login);

const snapshot = {
    format: 1,
    retrieved: new Date().toISOString().slice(0, 10),
    sources: {
        history: `git log and git shortlog --no-merges of a quicktype checkout, up to ${commit} (tests/golden/REFERENCE)`,
        repository: `GitHub REST API: GET /repos/${repository} and GET /orgs/${repo.owner.login}`,
        contributors: `GitHub REST API: GET /repos/${repository}/contributors (accounts linked to commits on ${repo.default_branch}; bots left out)`,
    },
    repository: {
        url: repo.html_url,
        default_branch: repo.default_branch,
        owner: { login: owner.login, name: owner.name, url: owner.html_url },
        homepage: repo.homepage,
        description: repo.description,
        license: repo.license?.spdx_id,
        created_at: repo.created_at,
        stars: repo.stargazers_count,
        forks: repo.forks_count,
    },
    history: {
        commit,
        commit_date: utcDate(committed),
        first_commit: first.sha,
        first_commit_date: utcDate(first.at),
        commits: times.length,
        author_names: authors,
        commits_by_year: byYear,
    },
    contributors: {
        bots_left_out: bots,
        people: people.map((c) => ({ login: c.login, id: c.id, contributions: c.contributions })),
    },
};

fs.writeFileSync(quicktypeFile, `${JSON.stringify(snapshot, null, 2)}\n`);
console.log(
    `${path.relative(repositoryRoot, quicktypeFile)}: ${snapshot.history.commits} commits since ${snapshot.history.first_commit_date}, ` +
        `${people.length} people (${bots.length} bots left out), ${repo.stargazers_count} stars`,
);
