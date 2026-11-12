package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<String> countries;

    @JsonProperty("countries")
    public List<String> getCountries() { return countries; }
    @JsonProperty("countries")
    public void setCountries(List<String> value) { this.countries = value; }
}
