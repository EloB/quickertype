package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.Map;

public class Totallds {
    private Map<String, Scorer> sAssists;
    private Map<String, Scorer> sBlocks;
    private Map<String, Scorer> sPoints;
    private Map<String, Scorer> sReboundsTotal;
    private Map<String, Scorer> sSteals;

    @JsonProperty("sAssists")
    public Map<String, Scorer> getSAssists() { return sAssists; }
    @JsonProperty("sAssists")
    public void setSAssists(Map<String, Scorer> value) { this.sAssists = value; }

    @JsonProperty("sBlocks")
    public Map<String, Scorer> getSBlocks() { return sBlocks; }
    @JsonProperty("sBlocks")
    public void setSBlocks(Map<String, Scorer> value) { this.sBlocks = value; }

    @JsonProperty("sPoints")
    public Map<String, Scorer> getSPoints() { return sPoints; }
    @JsonProperty("sPoints")
    public void setSPoints(Map<String, Scorer> value) { this.sPoints = value; }

    @JsonProperty("sReboundsTotal")
    public Map<String, Scorer> getSReboundsTotal() { return sReboundsTotal; }
    @JsonProperty("sReboundsTotal")
    public void setSReboundsTotal(Map<String, Scorer> value) { this.sReboundsTotal = value; }

    @JsonProperty("sSteals")
    public Map<String, Scorer> getSSteals() { return sSteals; }
    @JsonProperty("sSteals")
    public void setSSteals(Map<String, Scorer> value) { this.sSteals = value; }
}
