package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class LegalityElement {
    private String format;
    private LegalityEnum legality;

    @JsonProperty("format")
    public String getFormat() { return format; }
    @JsonProperty("format")
    public void setFormat(String value) { this.format = value; }

    @JsonProperty("legality")
    public LegalityEnum getLegality() { return legality; }
    @JsonProperty("legality")
    public void setLegality(LegalityEnum value) { this.legality = value; }
}
