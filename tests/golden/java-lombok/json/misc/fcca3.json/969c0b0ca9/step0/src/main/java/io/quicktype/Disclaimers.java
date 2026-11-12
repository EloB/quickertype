package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Disclaimers {
    private String disclaimer;
    private String limitations;

    @JsonProperty("Disclaimer")
    public String getDisclaimer() { return disclaimer; }
    @JsonProperty("Disclaimer")
    public void setDisclaimer(String value) { this.disclaimer = value; }

    @JsonProperty("Limitations")
    public String getLimitations() { return limitations; }
    @JsonProperty("Limitations")
    public void setLimitations(String value) { this.limitations = value; }
}
