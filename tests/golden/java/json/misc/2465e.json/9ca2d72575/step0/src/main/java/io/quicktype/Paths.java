package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Paths {
    private ItaTaxonomiesSearch itaTaxonomiesSearch;

    @JsonProperty("/ita_taxonomies/search")
    public ItaTaxonomiesSearch getItaTaxonomiesSearch() { return itaTaxonomiesSearch; }
    @JsonProperty("/ita_taxonomies/search")
    public void setItaTaxonomiesSearch(ItaTaxonomiesSearch value) { this.itaTaxonomiesSearch = value; }
}
