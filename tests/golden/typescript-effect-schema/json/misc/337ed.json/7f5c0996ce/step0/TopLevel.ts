import * as S from "effect/Schema";


export const Status = S.Literal(
    "active",
    "inactive",
);
export type Status = S.Schema.Type<typeof Status>;


export const CustomIncomeType = S.Literal(
    "public",
    "other",
);
export type CustomIncomeType = S.Schema.Type<typeof CustomIncomeType>;


export const ResultType = S.Literal(
    "FinancialDataNGO",
    "FinancialDataLawyer",
    "FinancialDataTradeAssociation",
);
export type ResultType = S.Schema.Type<typeof ResultType>;

export class CustomIncome extends S.Class<CustomIncome>("CustomIncome")({
    "amount": S.Int,
    "created_at": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)),
    "id": S.String,
    "name": S.String,
    "status": Status,
    "type": CustomIncomeType,
    "updated_at": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)),
    "uri": S.String,
}) {}

export class Result extends S.Class<Result>("Result")({
    "cost_absolute": S.NullOr(S.Int),
    "cost_max": S.NullOr(S.Int),
    "cost_min": S.NullOr(S.Int),
    "created_at": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)),
    "customIncomes": S.Array(CustomIncome),
    "direct_rep_costs_max": S.Null,
    "direct_rep_costs_min": S.Null,
    "end_date": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)),
    "eur_sources_grants": S.Int,
    "eur_sources_grants_src": S.NullOr(S.String),
    "eur_sources_procurement": S.Int,
    "eur_sources_procurement_src": S.NullOr(S.String),
    "id": S.String,
    "new_organisation": S.Null,
    "no_clients": S.NullOr(S.String),
    "other_financial_information": S.NullOr(S.String),
    "other_sources_contributions": S.NullOr(S.Int),
    "other_sources_donation": S.NullOr(S.Int),
    "other_sources_total": S.NullOr(S.Int),
    "public_financing_infranational": S.NullOr(S.Int),
    "public_financing_national": S.NullOr(S.Int),
    "public_financing_total": S.NullOr(S.Int),
    "representative": S.String,
    "start_date": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)),
    "status": Status,
    "total_budget": S.NullOr(S.Int),
    "turnover_absolute": S.NullOr(S.Int),
    "turnover_max": S.NullOr(S.Int),
    "turnover_min": S.NullOr(S.Int),
    "type": ResultType,
    "updated_at": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)),
    "uri": S.String,
}) {}

export class Facets extends S.Class<Facets>("Facets")(S.Struct({}).pipe(S.filter(value => typeof value === "object" && value !== null && !Array.isArray(value)))
) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "count": S.Int,
    "facets": Facets,
    "limit": S.Int,
    "next": S.String,
    "offset": S.Int,
    "previous": S.Boolean,
    "results": S.Array(Result),
}) {}
