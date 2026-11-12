package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.time.OffsetDateTime;
import java.util.List;

public class Result {
    private Long costAbsolute;
    private Long costMax;
    private Long costMin;
    private OffsetDateTime createdAt;
    private List<CustomIncome> customIncomes;
    private Object directRepCostsMax;
    private Object directRepCostsMin;
    private OffsetDateTime endDate;
    private long eurSourcesGrants;
    private String eurSourcesGrantsSrc;
    private long eurSourcesProcurement;
    private String eurSourcesProcurementSrc;
    private String id;
    private Object newOrganisation;
    private String noClients;
    private String otherFinancialInformation;
    private Long otherSourcesContributions;
    private Long otherSourcesDonation;
    private Long otherSourcesTotal;
    private Long publicFinancingInfranational;
    private Long publicFinancingNational;
    private Long publicFinancingTotal;
    private String representative;
    private OffsetDateTime startDate;
    private Status status;
    private Long totalBudget;
    private Long turnoverAbsolute;
    private Long turnoverMax;
    private Long turnoverMin;
    private ResultType type;
    private OffsetDateTime updatedAt;
    private String uri;

    @JsonProperty("cost_absolute")
    public Long getCostAbsolute() { return costAbsolute; }
    @JsonProperty("cost_absolute")
    public void setCostAbsolute(Long value) { this.costAbsolute = value; }

    @JsonProperty("cost_max")
    public Long getCostMax() { return costMax; }
    @JsonProperty("cost_max")
    public void setCostMax(Long value) { this.costMax = value; }

    @JsonProperty("cost_min")
    public Long getCostMin() { return costMin; }
    @JsonProperty("cost_min")
    public void setCostMin(Long value) { this.costMin = value; }

    @JsonProperty("created_at")
    public OffsetDateTime getCreatedAt() { return createdAt; }
    @JsonProperty("created_at")
    @JsonSetter(nulls = Nulls.FAIL)
    public void setCreatedAt(OffsetDateTime value) { this.createdAt = value; }

    @JsonProperty("customIncomes")
    public List<CustomIncome> getCustomIncomes() { return customIncomes; }
    @JsonProperty("customIncomes")
    public void setCustomIncomes(List<CustomIncome> value) { this.customIncomes = value; }

    @JsonProperty("direct_rep_costs_max")
    public Object getDirectRepCostsMax() { return directRepCostsMax; }
    @JsonProperty("direct_rep_costs_max")
    public void setDirectRepCostsMax(Object value) { this.directRepCostsMax = value; }

    @JsonProperty("direct_rep_costs_min")
    public Object getDirectRepCostsMin() { return directRepCostsMin; }
    @JsonProperty("direct_rep_costs_min")
    public void setDirectRepCostsMin(Object value) { this.directRepCostsMin = value; }

    @JsonProperty("end_date")
    public OffsetDateTime getEndDate() { return endDate; }
    @JsonProperty("end_date")
    @JsonSetter(nulls = Nulls.FAIL)
    public void setEndDate(OffsetDateTime value) { this.endDate = value; }

    @JsonProperty("eur_sources_grants")
    public long getEurSourcesGrants() { return eurSourcesGrants; }
    @JsonProperty("eur_sources_grants")
    public void setEurSourcesGrants(long value) { this.eurSourcesGrants = value; }

    @JsonProperty("eur_sources_grants_src")
    public String getEurSourcesGrantsSrc() { return eurSourcesGrantsSrc; }
    @JsonProperty("eur_sources_grants_src")
    public void setEurSourcesGrantsSrc(String value) { this.eurSourcesGrantsSrc = value; }

    @JsonProperty("eur_sources_procurement")
    public long getEurSourcesProcurement() { return eurSourcesProcurement; }
    @JsonProperty("eur_sources_procurement")
    public void setEurSourcesProcurement(long value) { this.eurSourcesProcurement = value; }

    @JsonProperty("eur_sources_procurement_src")
    public String getEurSourcesProcurementSrc() { return eurSourcesProcurementSrc; }
    @JsonProperty("eur_sources_procurement_src")
    public void setEurSourcesProcurementSrc(String value) { this.eurSourcesProcurementSrc = value; }

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }

    @JsonProperty("new_organisation")
    public Object getNewOrganisation() { return newOrganisation; }
    @JsonProperty("new_organisation")
    public void setNewOrganisation(Object value) { this.newOrganisation = value; }

    @JsonProperty("no_clients")
    public String getNoClients() { return noClients; }
    @JsonProperty("no_clients")
    public void setNoClients(String value) { this.noClients = value; }

    @JsonProperty("other_financial_information")
    public String getOtherFinancialInformation() { return otherFinancialInformation; }
    @JsonProperty("other_financial_information")
    public void setOtherFinancialInformation(String value) { this.otherFinancialInformation = value; }

    @JsonProperty("other_sources_contributions")
    public Long getOtherSourcesContributions() { return otherSourcesContributions; }
    @JsonProperty("other_sources_contributions")
    public void setOtherSourcesContributions(Long value) { this.otherSourcesContributions = value; }

    @JsonProperty("other_sources_donation")
    public Long getOtherSourcesDonation() { return otherSourcesDonation; }
    @JsonProperty("other_sources_donation")
    public void setOtherSourcesDonation(Long value) { this.otherSourcesDonation = value; }

    @JsonProperty("other_sources_total")
    public Long getOtherSourcesTotal() { return otherSourcesTotal; }
    @JsonProperty("other_sources_total")
    public void setOtherSourcesTotal(Long value) { this.otherSourcesTotal = value; }

    @JsonProperty("public_financing_infranational")
    public Long getPublicFinancingInfranational() { return publicFinancingInfranational; }
    @JsonProperty("public_financing_infranational")
    public void setPublicFinancingInfranational(Long value) { this.publicFinancingInfranational = value; }

    @JsonProperty("public_financing_national")
    public Long getPublicFinancingNational() { return publicFinancingNational; }
    @JsonProperty("public_financing_national")
    public void setPublicFinancingNational(Long value) { this.publicFinancingNational = value; }

    @JsonProperty("public_financing_total")
    public Long getPublicFinancingTotal() { return publicFinancingTotal; }
    @JsonProperty("public_financing_total")
    public void setPublicFinancingTotal(Long value) { this.publicFinancingTotal = value; }

    @JsonProperty("representative")
    public String getRepresentative() { return representative; }
    @JsonProperty("representative")
    public void setRepresentative(String value) { this.representative = value; }

    @JsonProperty("start_date")
    public OffsetDateTime getStartDate() { return startDate; }
    @JsonProperty("start_date")
    @JsonSetter(nulls = Nulls.FAIL)
    public void setStartDate(OffsetDateTime value) { this.startDate = value; }

    @JsonProperty("status")
    public Status getStatus() { return status; }
    @JsonProperty("status")
    public void setStatus(Status value) { this.status = value; }

    @JsonProperty("total_budget")
    public Long getTotalBudget() { return totalBudget; }
    @JsonProperty("total_budget")
    public void setTotalBudget(Long value) { this.totalBudget = value; }

    @JsonProperty("turnover_absolute")
    public Long getTurnoverAbsolute() { return turnoverAbsolute; }
    @JsonProperty("turnover_absolute")
    public void setTurnoverAbsolute(Long value) { this.turnoverAbsolute = value; }

    @JsonProperty("turnover_max")
    public Long getTurnoverMax() { return turnoverMax; }
    @JsonProperty("turnover_max")
    public void setTurnoverMax(Long value) { this.turnoverMax = value; }

    @JsonProperty("turnover_min")
    public Long getTurnoverMin() { return turnoverMin; }
    @JsonProperty("turnover_min")
    public void setTurnoverMin(Long value) { this.turnoverMin = value; }

    @JsonProperty("type")
    public ResultType getType() { return type; }
    @JsonProperty("type")
    public void setType(ResultType value) { this.type = value; }

    @JsonProperty("updated_at")
    public OffsetDateTime getUpdatedAt() { return updatedAt; }
    @JsonProperty("updated_at")
    @JsonSetter(nulls = Nulls.FAIL)
    public void setUpdatedAt(OffsetDateTime value) { this.updatedAt = value; }

    @JsonProperty("uri")
    public String getURI() { return uri; }
    @JsonProperty("uri")
    public void setURI(String value) { this.uri = value; }
}
