package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Wind {
    private String chill;
    private String direction;
    private String speed;

    @JsonProperty("chill")
    public String getChill() { return chill; }
    @JsonProperty("chill")
    public void setChill(String value) { this.chill = value; }

    @JsonProperty("direction")
    public String getDirection() { return direction; }
    @JsonProperty("direction")
    public void setDirection(String value) { this.direction = value; }

    @JsonProperty("speed")
    public String getSpeed() { return speed; }
    @JsonProperty("speed")
    public void setSpeed(String value) { this.speed = value; }
}
