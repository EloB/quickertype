package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<Open> open;
    private List<Open> tuple;

    @JsonProperty("open")
    public List<Open> getOpen() { return open; }
    @JsonProperty("open")
    public void setOpen(List<Open> value) { this.open = value; }

    @JsonProperty("tuple")
    public List<Open> getTuple() { return tuple; }
    @JsonProperty("tuple")
    public void setTuple(List<Open> value) { this.tuple = value; }
}
