package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Currency {
    private String abbreviation;

    @JsonProperty("abbreviation")
    public String getAbbreviation() { return abbreviation; }
    @JsonProperty("abbreviation")
    public void setAbbreviation(String value) { this.abbreviation = value; }
}
