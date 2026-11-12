package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class PC {
    private long count;
    private String label;
    private long peak24;

    @JsonProperty("count")
    public long getCount() { return count; }
    @JsonProperty("count")
    public void setCount(long value) { this.count = value; }

    @JsonProperty("label")
    public String getLabel() { return label; }
    @JsonProperty("label")
    public void setLabel(String value) { this.label = value; }

    @JsonProperty("peak24")
    public long getPeak24() { return peak24; }
    @JsonProperty("peak24")
    public void setPeak24(long value) { this.peak24 = value; }
}
