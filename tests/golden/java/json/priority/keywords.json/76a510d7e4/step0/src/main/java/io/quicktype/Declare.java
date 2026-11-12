package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Declare {
    private long declare;

    @JsonProperty("declare")
    public long getDeclare() { return declare; }
    @JsonProperty("declare")
    public void setDeclare(long value) { this.declare = value; }
}
