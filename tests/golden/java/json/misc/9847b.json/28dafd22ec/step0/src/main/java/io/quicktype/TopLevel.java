package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private String id;
    private String name;

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }
}
