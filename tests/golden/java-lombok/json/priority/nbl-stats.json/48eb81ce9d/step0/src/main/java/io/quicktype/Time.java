package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Time {
    private String gt;
    private long per;
    private PerType perType;

    @JsonProperty("gt")
    public String getGt() { return gt; }
    @JsonProperty("gt")
    public void setGt(String value) { this.gt = value; }

    @JsonProperty("per")
    public long getPer() { return per; }
    @JsonProperty("per")
    public void setPer(long value) { this.per = value; }

    @JsonProperty("perType")
    public PerType getPerType() { return perType; }
    @JsonProperty("perType")
    public void setPerType(PerType value) { this.perType = value; }
}
