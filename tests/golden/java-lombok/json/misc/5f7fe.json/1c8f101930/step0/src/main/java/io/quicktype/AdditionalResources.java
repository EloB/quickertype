package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class AdditionalResources {
    private String additionalResourcesSeeAlso;
    private String seeAlso;

    @JsonProperty("See Also ")
    public String getAdditionalResourcesSeeAlso() { return additionalResourcesSeeAlso; }
    @JsonProperty("See Also ")
    public void setAdditionalResourcesSeeAlso(String value) { this.additionalResourcesSeeAlso = value; }

    @JsonProperty("See Also")
    public String getSeeAlso() { return seeAlso; }
    @JsonProperty("See Also")
    public void setSeeAlso(String value) { this.seeAlso = value; }
}
