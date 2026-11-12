package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.UUID;

public class Component {
    private String name;
    private UUID uuid;

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("uuid")
    public UUID getUUID() { return uuid; }
    @JsonProperty("uuid")
    public void setUUID(UUID value) { this.uuid = value; }
}
