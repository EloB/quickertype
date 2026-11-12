package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private Health health;

    @JsonProperty("health")
    public Health getHealth() { return health; }
    @JsonProperty("health")
    public void setHealth(Health value) { this.health = value; }
}
