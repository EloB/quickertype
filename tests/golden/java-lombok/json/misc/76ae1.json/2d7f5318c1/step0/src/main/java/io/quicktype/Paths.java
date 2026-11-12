package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Paths {
    private BusinessServiceProvidersSearchClass businessServiceProvidersSearch;
    private ConsolidatedScreeningListSearchClass consolidatedScreeningListSearch;
    private ConsolidatedScreeningListSearchClass deMinimisSearch;
    private ConsolidatedScreeningListSearchClass itaFaqsSearch;
    private ConsolidatedScreeningListSearchClass itaOfficeLocationsSearch;
    private BusinessServiceProvidersSearchClass itaTaxonomiesSearch;
    private BusinessServiceProvidersSearchClass itaZipcodeToPostSearch;
    private ConsolidatedScreeningListSearchClass marketIntelligenceSearch;
    private ConsolidatedScreeningListSearchClass marketResearchLibrarySearch;
    private ConsolidatedScreeningListSearchClass tariffRatesSearch;
    private ConsolidatedScreeningListSearchClass tradeArticlesSearch;
    private ConsolidatedScreeningListSearchClass tradeEventsSearch;
    private ConsolidatedScreeningListSearchClass tradeLeadsSearch;

    @JsonProperty("/business_service_providers/search")
    public BusinessServiceProvidersSearchClass getBusinessServiceProvidersSearch() { return businessServiceProvidersSearch; }
    @JsonProperty("/business_service_providers/search")
    public void setBusinessServiceProvidersSearch(BusinessServiceProvidersSearchClass value) { this.businessServiceProvidersSearch = value; }

    @JsonProperty("/consolidated_screening_list/search")
    public ConsolidatedScreeningListSearchClass getConsolidatedScreeningListSearch() { return consolidatedScreeningListSearch; }
    @JsonProperty("/consolidated_screening_list/search")
    public void setConsolidatedScreeningListSearch(ConsolidatedScreeningListSearchClass value) { this.consolidatedScreeningListSearch = value; }

    @JsonProperty("/de_minimis/search")
    public ConsolidatedScreeningListSearchClass getDeMinimisSearch() { return deMinimisSearch; }
    @JsonProperty("/de_minimis/search")
    public void setDeMinimisSearch(ConsolidatedScreeningListSearchClass value) { this.deMinimisSearch = value; }

    @JsonProperty("/ita_faqs/search")
    public ConsolidatedScreeningListSearchClass getItaFaqsSearch() { return itaFaqsSearch; }
    @JsonProperty("/ita_faqs/search")
    public void setItaFaqsSearch(ConsolidatedScreeningListSearchClass value) { this.itaFaqsSearch = value; }

    @JsonProperty("/ita_office_locations/search")
    public ConsolidatedScreeningListSearchClass getItaOfficeLocationsSearch() { return itaOfficeLocationsSearch; }
    @JsonProperty("/ita_office_locations/search")
    public void setItaOfficeLocationsSearch(ConsolidatedScreeningListSearchClass value) { this.itaOfficeLocationsSearch = value; }

    @JsonProperty("/ita_taxonomies/search")
    public BusinessServiceProvidersSearchClass getItaTaxonomiesSearch() { return itaTaxonomiesSearch; }
    @JsonProperty("/ita_taxonomies/search")
    public void setItaTaxonomiesSearch(BusinessServiceProvidersSearchClass value) { this.itaTaxonomiesSearch = value; }

    @JsonProperty("/ita_zipcode_to_post/search")
    public BusinessServiceProvidersSearchClass getItaZipcodeToPostSearch() { return itaZipcodeToPostSearch; }
    @JsonProperty("/ita_zipcode_to_post/search")
    public void setItaZipcodeToPostSearch(BusinessServiceProvidersSearchClass value) { this.itaZipcodeToPostSearch = value; }

    @JsonProperty("/market_intelligence/search")
    public ConsolidatedScreeningListSearchClass getMarketIntelligenceSearch() { return marketIntelligenceSearch; }
    @JsonProperty("/market_intelligence/search")
    public void setMarketIntelligenceSearch(ConsolidatedScreeningListSearchClass value) { this.marketIntelligenceSearch = value; }

    @JsonProperty("/market_research_library/search")
    public ConsolidatedScreeningListSearchClass getMarketResearchLibrarySearch() { return marketResearchLibrarySearch; }
    @JsonProperty("/market_research_library/search")
    public void setMarketResearchLibrarySearch(ConsolidatedScreeningListSearchClass value) { this.marketResearchLibrarySearch = value; }

    @JsonProperty("/tariff_rates/search")
    public ConsolidatedScreeningListSearchClass getTariffRatesSearch() { return tariffRatesSearch; }
    @JsonProperty("/tariff_rates/search")
    public void setTariffRatesSearch(ConsolidatedScreeningListSearchClass value) { this.tariffRatesSearch = value; }

    @JsonProperty("/trade_articles/search")
    public ConsolidatedScreeningListSearchClass getTradeArticlesSearch() { return tradeArticlesSearch; }
    @JsonProperty("/trade_articles/search")
    public void setTradeArticlesSearch(ConsolidatedScreeningListSearchClass value) { this.tradeArticlesSearch = value; }

    @JsonProperty("/trade_events/search")
    public ConsolidatedScreeningListSearchClass getTradeEventsSearch() { return tradeEventsSearch; }
    @JsonProperty("/trade_events/search")
    public void setTradeEventsSearch(ConsolidatedScreeningListSearchClass value) { this.tradeEventsSearch = value; }

    @JsonProperty("/trade_leads/search")
    public ConsolidatedScreeningListSearchClass getTradeLeadsSearch() { return tradeLeadsSearch; }
    @JsonProperty("/trade_leads/search")
    public void setTradeLeadsSearch(ConsolidatedScreeningListSearchClass value) { this.tradeLeadsSearch = value; }
}
