package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Units {
    private String distance;
    private String pressure;
    private String speed;
    private String temperature;

    @JsonProperty("distance")
    public String getDistance() { return distance; }
    @JsonProperty("distance")
    public void setDistance(String value) { this.distance = value; }

    @JsonProperty("pressure")
    public String getPressure() { return pressure; }
    @JsonProperty("pressure")
    public void setPressure(String value) { this.pressure = value; }

    @JsonProperty("speed")
    public String getSpeed() { return speed; }
    @JsonProperty("speed")
    public void setSpeed(String value) { this.speed = value; }

    @JsonProperty("temperature")
    public String getTemperature() { return temperature; }
    @JsonProperty("temperature")
    public void setTemperature(String value) { this.temperature = value; }
}
