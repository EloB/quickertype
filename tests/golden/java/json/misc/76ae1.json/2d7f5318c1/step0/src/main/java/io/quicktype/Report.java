package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Report {
    private ReportProperties properties;

    @JsonProperty("properties")
    public ReportProperties getProperties() { return properties; }
    @JsonProperty("properties")
    public void setProperties(ReportProperties value) { this.properties = value; }
}
