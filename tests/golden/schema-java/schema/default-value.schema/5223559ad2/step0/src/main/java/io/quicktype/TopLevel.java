package io.quicktype;

import com.fasterxml.jackson.annotation.*;

/**
 * An object with a scalar default
 */
public class TopLevel {
    private long id;

    @JsonProperty("id")
    public long getID() { return id; }
    @JsonProperty("id")
    public void setID(long value) { this.id = value; }
}
