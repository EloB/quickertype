package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Paths {
    private MarketResearchLibrarySearch marketResearchLibrarySearch;

    @JsonProperty("/market_research_library/search")
    public MarketResearchLibrarySearch getMarketResearchLibrarySearch() { return marketResearchLibrarySearch; }
    @JsonProperty("/market_research_library/search")
    public void setMarketResearchLibrarySearch(MarketResearchLibrarySearch value) { this.marketResearchLibrarySearch = value; }
}
