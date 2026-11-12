package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Paths {
    private ConsolidatedScreeningListSearch consolidatedScreeningListSearch;

    @JsonProperty("/consolidated_screening_list/search")
    public ConsolidatedScreeningListSearch getConsolidatedScreeningListSearch() { return consolidatedScreeningListSearch; }
    @JsonProperty("/consolidated_screening_list/search")
    public void setConsolidatedScreeningListSearch(ConsolidatedScreeningListSearch value) { this.consolidatedScreeningListSearch = value; }
}
