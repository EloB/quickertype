package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Identifier {
    private String identifier;
    private Scheme scheme;

    @JsonProperty("identifier")
    public String getIdentifier() { return identifier; }
    @JsonProperty("identifier")
    public void setIdentifier(String value) { this.identifier = value; }

    @JsonProperty("scheme")
    public Scheme getScheme() { return scheme; }
    @JsonProperty("scheme")
    public void setScheme(Scheme value) { this.scheme = value; }
}
