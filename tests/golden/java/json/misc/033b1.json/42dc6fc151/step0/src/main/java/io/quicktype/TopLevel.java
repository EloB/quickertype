package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.time.LocalDate;
import java.util.Map;

public class TopLevel {
    private String base;
    private LocalDate date;
    private Map<String, Double> rates;

    @JsonProperty("base")
    public String getBase() { return base; }
    @JsonProperty("base")
    public void setBase(String value) { this.base = value; }

    @JsonProperty("date")
    public LocalDate getDate() { return date; }
    @JsonProperty("date")
    public void setDate(LocalDate value) { this.date = value; }

    @JsonProperty("rates")
    public Map<String, Double> getRates() { return rates; }
    @JsonProperty("rates")
    public void setRates(Map<String, Double> value) { this.rates = value; }
}
