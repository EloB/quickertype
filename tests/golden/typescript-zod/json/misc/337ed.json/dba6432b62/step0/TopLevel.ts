import * as z from "zod";


export const StatusSchema = z.enum([
    "active",
    "inactive",
]);
export type Status = z.infer<typeof StatusSchema>;


export const CustomIncomeTypeSchema = z.enum([
    "public",
    "other",
]);
export type CustomIncomeType = z.infer<typeof CustomIncomeTypeSchema>;


export const ResultTypeSchema = z.enum([
    "FinancialDataNGO",
    "FinancialDataLawyer",
    "FinancialDataTradeAssociation",
]);
export type ResultType = z.infer<typeof ResultTypeSchema>;

export const FacetsSchema = z.object({
});
export type Facets = z.infer<typeof FacetsSchema>;

export const CustomIncomeSchema = z.object({
    "amount": z.number().int(),
    "created_at": z.string().pipe(z.coerce.date()),
    "id": z.string(),
    "name": z.string(),
    "status": StatusSchema,
    "type": CustomIncomeTypeSchema,
    "updated_at": z.string().pipe(z.coerce.date()),
    "uri": z.string(),
});
export type CustomIncome = z.infer<typeof CustomIncomeSchema>;

export const ResultSchema = z.object({
    "cost_absolute": z.union([z.null(), z.number().int()]),
    "cost_max": z.union([z.null(), z.number().int()]),
    "cost_min": z.union([z.null(), z.number().int()]),
    "created_at": z.string().pipe(z.coerce.date()),
    "customIncomes": z.array(CustomIncomeSchema),
    "direct_rep_costs_max": z.null(),
    "direct_rep_costs_min": z.null(),
    "end_date": z.string().pipe(z.coerce.date()),
    "eur_sources_grants": z.number().int(),
    "eur_sources_grants_src": z.union([z.null(), z.string()]),
    "eur_sources_procurement": z.number().int(),
    "eur_sources_procurement_src": z.union([z.null(), z.string()]),
    "id": z.string(),
    "new_organisation": z.null(),
    "no_clients": z.union([z.null(), z.string()]),
    "other_financial_information": z.union([z.null(), z.string()]),
    "other_sources_contributions": z.union([z.null(), z.number().int()]),
    "other_sources_donation": z.union([z.null(), z.number().int()]),
    "other_sources_total": z.union([z.null(), z.number().int()]),
    "public_financing_infranational": z.union([z.null(), z.number().int()]),
    "public_financing_national": z.union([z.null(), z.number().int()]),
    "public_financing_total": z.union([z.null(), z.number().int()]),
    "representative": z.string(),
    "start_date": z.string().pipe(z.coerce.date()),
    "status": StatusSchema,
    "total_budget": z.union([z.null(), z.number().int()]),
    "turnover_absolute": z.union([z.null(), z.number().int()]),
    "turnover_max": z.union([z.null(), z.number().int()]),
    "turnover_min": z.union([z.null(), z.number().int()]),
    "type": ResultTypeSchema,
    "updated_at": z.string().pipe(z.coerce.date()),
    "uri": z.string(),
});
export type Result = z.infer<typeof ResultSchema>;

export const TopLevelSchema = z.object({
    "count": z.number().int(),
    "facets": FacetsSchema,
    "limit": z.number().int(),
    "next": z.string(),
    "offset": z.number().int(),
    "previous": z.boolean(),
    "results": z.array(ResultSchema),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
