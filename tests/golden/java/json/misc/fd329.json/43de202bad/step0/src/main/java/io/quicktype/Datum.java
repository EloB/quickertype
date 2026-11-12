package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Datum {
    private String anomaly;
    private String value;

    @JsonProperty("anomaly")
    public String getAnomaly() { return anomaly; }
    @JsonProperty("anomaly")
    public void setAnomaly(String value) { this.anomaly = value; }

    @JsonProperty("value")
    public String getValue() { return value; }
    @JsonProperty("value")
    public void setValue(String value) { this.value = value; }
}
