package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Definitions {
    private Taxonomy taxonomy;

    @JsonProperty("Taxonomy")
    public Taxonomy getTaxonomy() { return taxonomy; }
    @JsonProperty("Taxonomy")
    public void setTaxonomy(Taxonomy value) { this.taxonomy = value; }
}
