package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class CRSProperties {
    private String name;

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }
}
