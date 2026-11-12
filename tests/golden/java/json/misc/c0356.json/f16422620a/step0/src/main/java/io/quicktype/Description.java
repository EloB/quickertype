package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Description {
    private String basePeriod;
    private long missing;
    private String title;

    @JsonProperty("base_period")
    public String getBasePeriod() { return basePeriod; }
    @JsonProperty("base_period")
    public void setBasePeriod(String value) { this.basePeriod = value; }

    @JsonProperty("missing")
    public long getMissing() { return missing; }
    @JsonProperty("missing")
    public void setMissing(long value) { this.missing = value; }

    @JsonProperty("title")
    public String getTitle() { return title; }
    @JsonProperty("title")
    public void setTitle(String value) { this.title = value; }
}
