package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Speed {
    private Limit velocity;

    @JsonProperty("velocity")
    public Limit getVelocity() { return velocity; }
    @JsonProperty("velocity")
    public void setVelocity(Limit value) { this.velocity = value; }
}
