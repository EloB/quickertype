package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Vehicle {
    private String brand;
    private String id;
    private Speed speed;
    private Boolean subModule;
    private VehicleType type;
    private String year;

    @JsonProperty("brand")
    public String getBrand() { return brand; }
    @JsonProperty("brand")
    public void setBrand(String value) { this.brand = value; }

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }

    @JsonProperty("speed")
    public Speed getSpeed() { return speed; }
    @JsonProperty("speed")
    public void setSpeed(Speed value) { this.speed = value; }

    @JsonProperty("subModule")
    public Boolean getSubModule() { return subModule; }
    @JsonProperty("subModule")
    public void setSubModule(Boolean value) { this.subModule = value; }

    @JsonProperty("type")
    public VehicleType getType() { return type; }
    @JsonProperty("type")
    public void setType(VehicleType value) { this.type = value; }

    @JsonProperty("year")
    public String getYear() { return year; }
    @JsonProperty("year")
    public void setYear(String value) { this.year = value; }
}
