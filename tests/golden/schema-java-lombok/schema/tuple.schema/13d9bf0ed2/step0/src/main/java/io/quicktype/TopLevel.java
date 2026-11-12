package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<Tuple> tuple;

    @JsonProperty("tuple")
    public List<Tuple> getTuple() { return tuple; }
    @JsonProperty("tuple")
    public void setTuple(List<Tuple> value) { this.tuple = value; }
}
