package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class PurplePerson {
    private String name;
    private long intOrString;

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("intOrString")
    public long getIntOrString() { return intOrString; }
    @JsonProperty("intOrString")
    public void setIntOrString(long value) { this.intOrString = value; }
}
