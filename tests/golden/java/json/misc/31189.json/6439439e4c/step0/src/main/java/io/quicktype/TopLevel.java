package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private String details;
    private List<Rate> rates;
    private Object version;

    @JsonProperty("details")
    public String getDetails() { return details; }
    @JsonProperty("details")
    public void setDetails(String value) { this.details = value; }

    @JsonProperty("rates")
    public List<Rate> getRates() { return rates; }
    @JsonProperty("rates")
    public void setRates(List<Rate> value) { this.rates = value; }

    @JsonProperty("version")
    public Object getVersion() { return version; }
    @JsonProperty("version")
    public void setVersion(Object value) { this.version = value; }
}
