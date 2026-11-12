package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class DatasetInformation {
    private String agency;

    @JsonProperty("Agency")
    public String getAgency() { return agency; }
    @JsonProperty("Agency")
    public void setAgency(String value) { this.agency = value; }
}
