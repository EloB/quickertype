package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<Country> countries;

    @JsonProperty("countries")
    public List<Country> getCountries() { return countries; }
    @JsonProperty("countries")
    public void setCountries(List<Country> value) { this.countries = value; }
}
