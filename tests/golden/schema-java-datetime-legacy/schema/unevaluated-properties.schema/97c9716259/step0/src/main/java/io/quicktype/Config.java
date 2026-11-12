package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;
import java.util.Map;

public class Config {
    private Closed closed;
    private String name;
    private Map<String, List<Item>> settings;

    @JsonProperty("closed")
    public Closed getClosed() { return closed; }
    @JsonProperty("closed")
    public void setClosed(Closed value) { this.closed = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("settings")
    public Map<String, List<Item>> getSettings() { return settings; }
    @JsonProperty("settings")
    public void setSettings(Map<String, List<Item>> value) { this.settings = value; }
}
