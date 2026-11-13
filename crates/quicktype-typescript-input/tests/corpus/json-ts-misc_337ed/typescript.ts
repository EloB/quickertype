export interface TopLevel {
    count:    number;
    facets:   object;
    limit:    number;
    next:     string;
    offset:   number;
    previous: boolean;
    results:  Result[];
}

export interface Result {
    cost_absolute:                  number | null;
    cost_max:                       number | null;
    cost_min:                       number | null;
    created_at:                     Date;
    customIncomes:                  CustomIncome[];
    direct_rep_costs_max:           null;
    direct_rep_costs_min:           null;
    end_date:                       Date;
    eur_sources_grants:             number;
    eur_sources_grants_src:         null | string;
    eur_sources_procurement:        number;
    eur_sources_procurement_src:    null | string;
    id:                             string;
    new_organisation:               null;
    no_clients:                     null | string;
    other_financial_information:    null | string;
    other_sources_contributions:    number | null;
    other_sources_donation:         number | null;
    other_sources_total:            number | null;
    public_financing_infranational: number | null;
    public_financing_national:      number | null;
    public_financing_total:         number | null;
    representative:                 string;
    start_date:                     Date;
    status:                         Status;
    total_budget:                   number | null;
    turnover_absolute:              number | null;
    turnover_max:                   number | null;
    turnover_min:                   number | null;
    type:                           ResultType;
    updated_at:                     Date;
    uri:                            string;
}

export interface CustomIncome {
    amount:     number;
    created_at: Date;
    id:         string;
    name:       string;
    status:     Status;
    type:       CustomIncomeType;
    updated_at: Date;
    uri:        string;
}

export type Status = "active" | "inactive";

export type CustomIncomeType = "public" | "other";

export type ResultType = "FinancialDataNGO" | "FinancialDataLawyer" | "FinancialDataTradeAssociation";
