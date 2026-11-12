package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Definitions {
    private Report report;

    @JsonProperty("Report")
    public Report getReport() { return report; }
    @JsonProperty("Report")
    public void setReport(Report value) { this.report = value; }
}
