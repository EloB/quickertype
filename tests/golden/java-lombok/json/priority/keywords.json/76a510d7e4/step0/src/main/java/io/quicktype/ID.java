package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ID {
    private long id;

    @JsonProperty("id")
    public long getID() { return id; }
    @JsonProperty("id")
    public void setID(long value) { this.id = value; }
}
