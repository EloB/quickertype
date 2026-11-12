package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ConsolidatedScreeningListSearch {
    private Get get;

    @JsonProperty("get")
    public Get getGet() { return get; }
    @JsonProperty("get")
    public void setGet(Get value) { this.get = value; }
}
