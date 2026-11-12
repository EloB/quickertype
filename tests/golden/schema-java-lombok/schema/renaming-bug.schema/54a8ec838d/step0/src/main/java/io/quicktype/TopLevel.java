package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private String version;
    private List<Fruit> fruits;
    private List<Vehicle> vehicles;

    @JsonProperty("version")
    public String getVersion() { return version; }
    @JsonProperty("version")
    public void setVersion(String value) { this.version = value; }

    @JsonProperty("fruits")
    public List<Fruit> getFruits() { return fruits; }
    @JsonProperty("fruits")
    public void setFruits(List<Fruit> value) { this.fruits = value; }

    @JsonProperty("vehicles")
    public List<Vehicle> getVehicles() { return vehicles; }
    @JsonProperty("vehicles")
    public void setVehicles(List<Vehicle> value) { this.vehicles = value; }
}
