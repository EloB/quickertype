package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.time.LocalDate;

public class Period {
    private EffectiveFromUnion effectiveFrom;
    private Rates rates;

    @JsonProperty("effective_from")
    public EffectiveFromUnion getEffectiveFrom() { return effectiveFrom; }
    @JsonProperty("effective_from")
    public void setEffectiveFrom(EffectiveFromUnion value) { this.effectiveFrom = value; }

    @JsonProperty("rates")
    public Rates getRates() { return rates; }
    @JsonProperty("rates")
    public void setRates(Rates value) { this.rates = value; }
}
