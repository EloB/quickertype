package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Definitions {
    private Rate rate;

    @JsonProperty("Rate")
    public Rate getRate() { return rate; }
    @JsonProperty("Rate")
    public void setRate(Rate value) { this.rate = value; }
}
