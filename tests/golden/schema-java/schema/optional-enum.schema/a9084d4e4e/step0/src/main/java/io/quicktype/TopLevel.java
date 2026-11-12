package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private String name;
    private Shortcut shortcut;

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("shortcut")
    public Shortcut getShortcut() { return shortcut; }
    @JsonProperty("shortcut")
    public void setShortcut(Shortcut value) { this.shortcut = value; }
}
