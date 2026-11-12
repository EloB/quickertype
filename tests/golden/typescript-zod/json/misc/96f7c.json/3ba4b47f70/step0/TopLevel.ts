import * as z from "zod";


export const TopLevelSchema = z.object({
    "git": z.array(z.string()),
    "github_services_sha": z.string(),
    "hooks": z.array(z.string()),
    "importer": z.array(z.string()),
    "pages": z.array(z.string()),
    "verifiable_password_authentication": z.boolean(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
