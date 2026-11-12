package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Location {
    private String latitude;
    private String longitude;
    private Street street;

    @JsonProperty("latitude")
    public String getLatitude() { return latitude; }
    @JsonProperty("latitude")
    public void setLatitude(String value) { this.latitude = value; }

    @JsonProperty("longitude")
    public String getLongitude() { return longitude; }
    @JsonProperty("longitude")
    public void setLongitude(String value) { this.longitude = value; }

    @JsonProperty("street")
    public Street getStreet() { return street; }
    @JsonProperty("street")
    public void setStreet(Street value) { this.street = value; }
}
