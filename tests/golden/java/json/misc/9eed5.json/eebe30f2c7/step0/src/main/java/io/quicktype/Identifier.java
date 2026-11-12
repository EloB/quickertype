package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Identifier {
    private String identifier;
    private String scheme;

    @JsonProperty("identifier")
    public String getIdentifier() { return identifier; }
    @JsonProperty("identifier")
    public void setIdentifier(String value) { this.identifier = value; }

    @JsonProperty("scheme")
    public String getScheme() { return scheme; }
    @JsonProperty("scheme")
    public void setScheme(String value) { this.scheme = value; }
}
