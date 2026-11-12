package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private double longitude;

    @JsonProperty("longitude")
    public double getLongitude() { return longitude; }
    @JsonProperty("longitude")
    public void setLongitude(double value) { this.longitude = value; }
}
