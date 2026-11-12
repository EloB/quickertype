package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Definitions {
    private Provider provider;

    @JsonProperty("Provider")
    public Provider getProvider() { return provider; }
    @JsonProperty("Provider")
    public void setProvider(Provider value) { this.provider = value; }
}
