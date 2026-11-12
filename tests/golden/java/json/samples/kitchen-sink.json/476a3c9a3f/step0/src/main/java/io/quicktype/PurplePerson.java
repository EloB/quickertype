package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class PurplePerson {
    private long intOrString;
    private String name;

    @JsonProperty("intOrString")
    public long getIntOrString() { return intOrString; }
    @JsonProperty("intOrString")
    public void setIntOrString(long value) { this.intOrString = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }
}
