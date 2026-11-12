package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevelElement {
    private Country country;
    private String date;
    private String decimal;
    private Country indicator;
    private String value;

    @JsonProperty("country")
    public Country getCountry() { return country; }
    @JsonProperty("country")
    public void setCountry(Country value) { this.country = value; }

    @JsonProperty("date")
    public String getDate() { return date; }
    @JsonProperty("date")
    public void setDate(String value) { this.date = value; }

    @JsonProperty("decimal")
    public String getDecimal() { return decimal; }
    @JsonProperty("decimal")
    public void setDecimal(String value) { this.decimal = value; }

    @JsonProperty("indicator")
    public Country getIndicator() { return indicator; }
    @JsonProperty("indicator")
    public void setIndicator(Country value) { this.indicator = value; }

    @JsonProperty("value")
    public String getValue() { return value; }
    @JsonProperty("value")
    public void setValue(String value) { this.value = value; }
}
