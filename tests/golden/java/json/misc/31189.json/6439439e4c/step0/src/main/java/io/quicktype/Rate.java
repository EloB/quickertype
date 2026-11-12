package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Rate {
    private String code;
    private String countryCode;
    private String name;
    private List<Period> periods;

    @JsonProperty("code")
    public String getCode() { return code; }
    @JsonProperty("code")
    public void setCode(String value) { this.code = value; }

    @JsonProperty("country_code")
    public String getCountryCode() { return countryCode; }
    @JsonProperty("country_code")
    public void setCountryCode(String value) { this.countryCode = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("periods")
    public List<Period> getPeriods() { return periods; }
    @JsonProperty("periods")
    public void setPeriods(List<Period> value) { this.periods = value; }
}
