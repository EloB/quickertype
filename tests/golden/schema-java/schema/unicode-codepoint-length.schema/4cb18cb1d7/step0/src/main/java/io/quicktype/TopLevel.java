package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private String exact;
    private String maximum;
    private String minimum;

    @JsonProperty("exact")
    public String getExact() { return exact; }
    @JsonProperty("exact")
    public void setExact(String value) { this.exact = value; }

    @JsonProperty("maximum")
    public String getMaximum() { return maximum; }
    @JsonProperty("maximum")
    public void setMaximum(String value) { this.maximum = value; }

    @JsonProperty("minimum")
    public String getMinimum() { return minimum; }
    @JsonProperty("minimum")
    public void setMinimum(String value) { this.minimum = value; }
}
