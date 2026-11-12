import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "git": S.Array(S.String),
    "github_services_sha": S.String,
    "hooks": S.Array(S.String),
    "importer": S.Array(S.String),
    "pages": S.Array(S.String),
    "verifiable_password_authentication": S.Boolean,
}) {}
