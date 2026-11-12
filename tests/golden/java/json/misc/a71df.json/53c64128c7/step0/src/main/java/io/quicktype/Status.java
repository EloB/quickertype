package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Status {
    private String avgDelay;
    private String closureBegin;
    private String closureEnd;
    private String endTime;
    private String maxDelay;
    private String minDelay;
    private String reason;
    private String trend;
    private String type;

    @JsonProperty("avgDelay")
    public String getAvgDelay() { return avgDelay; }
    @JsonProperty("avgDelay")
    public void setAvgDelay(String value) { this.avgDelay = value; }

    @JsonProperty("closureBegin")
    public String getClosureBegin() { return closureBegin; }
    @JsonProperty("closureBegin")
    public void setClosureBegin(String value) { this.closureBegin = value; }

    @JsonProperty("closureEnd")
    public String getClosureEnd() { return closureEnd; }
    @JsonProperty("closureEnd")
    public void setClosureEnd(String value) { this.closureEnd = value; }

    @JsonProperty("endTime")
    public String getEndTime() { return endTime; }
    @JsonProperty("endTime")
    public void setEndTime(String value) { this.endTime = value; }

    @JsonProperty("maxDelay")
    public String getMaxDelay() { return maxDelay; }
    @JsonProperty("maxDelay")
    public void setMaxDelay(String value) { this.maxDelay = value; }

    @JsonProperty("minDelay")
    public String getMinDelay() { return minDelay; }
    @JsonProperty("minDelay")
    public void setMinDelay(String value) { this.minDelay = value; }

    @JsonProperty("reason")
    public String getReason() { return reason; }
    @JsonProperty("reason")
    public void setReason(String value) { this.reason = value; }

    @JsonProperty("trend")
    public String getTrend() { return trend; }
    @JsonProperty("trend")
    public void setTrend(String value) { this.trend = value; }

    @JsonProperty("type")
    public String getType() { return type; }
    @JsonProperty("type")
    public void setType(String value) { this.type = value; }
}
