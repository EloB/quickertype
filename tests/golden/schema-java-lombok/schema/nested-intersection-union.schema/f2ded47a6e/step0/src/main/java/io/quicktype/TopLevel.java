package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<Item> input;

    @JsonProperty("input")
    public List<Item> getInput() { return input; }
    @JsonProperty("input")
    public void setInput(List<Item> value) { this.input = value; }
}
