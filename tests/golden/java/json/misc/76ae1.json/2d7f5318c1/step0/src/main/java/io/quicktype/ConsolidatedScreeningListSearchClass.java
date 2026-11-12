package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ConsolidatedScreeningListSearchClass {
    private ConsolidatedScreeningListSearchGet get;

    @JsonProperty("get")
    public ConsolidatedScreeningListSearchGet getGet() { return get; }
    @JsonProperty("get")
    public void setGet(ConsolidatedScreeningListSearchGet value) { this.get = value; }
}
