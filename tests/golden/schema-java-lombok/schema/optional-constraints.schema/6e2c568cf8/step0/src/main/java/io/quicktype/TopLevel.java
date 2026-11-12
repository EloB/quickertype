package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private Double optDouble;
    private Long optInt;
    private String optPattern;
    private String optString;
    private long reqZeroMin;

    @JsonProperty("optDouble")
    public Double getOptDouble() { return optDouble; }
    @JsonProperty("optDouble")
    public void setOptDouble(Double value) { this.optDouble = value; }

    @JsonProperty("optInt")
    public Long getOptInt() { return optInt; }
    @JsonProperty("optInt")
    public void setOptInt(Long value) { this.optInt = value; }

    @JsonProperty("optPattern")
    public String getOptPattern() { return optPattern; }
    @JsonProperty("optPattern")
    public void setOptPattern(String value) { this.optPattern = value; }

    @JsonProperty("optString")
    public String getOptString() { return optString; }
    @JsonProperty("optString")
    public void setOptString(String value) { this.optString = value; }

    @JsonProperty("reqZeroMin")
    public long getReqZeroMin() { return reqZeroMin; }
    @JsonProperty("reqZeroMin")
    public void setReqZeroMin(long value) { this.reqZeroMin = value; }
}
