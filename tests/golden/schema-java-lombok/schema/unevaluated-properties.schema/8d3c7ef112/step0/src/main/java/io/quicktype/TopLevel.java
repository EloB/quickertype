package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private Config config;

    @JsonProperty("config")
    public Config getConfig() { return config; }
    @JsonProperty("config")
    public void setConfig(Config value) { this.config = value; }
}
