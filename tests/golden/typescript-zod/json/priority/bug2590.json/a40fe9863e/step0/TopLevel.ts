import * as z from "zod";


export const InvoiceSchema = z.object({
    "createdAt": z.union([z.null(), z.string().pipe(z.coerce.date())]),
    "dueDate": z.union([z.null(), z.string()]),
    "name": z.string(),
});
export type Invoice = z.infer<typeof InvoiceSchema>;

export const TopLevelSchema = z.object({
    "invoices": z.array(InvoiceSchema),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
