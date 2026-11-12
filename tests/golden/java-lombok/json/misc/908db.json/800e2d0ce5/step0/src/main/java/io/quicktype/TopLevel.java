package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<StateElement> states;

    @JsonProperty("states")
    public List<StateElement> getStates() { return states; }
    @JsonProperty("states")
    public void setStates(List<StateElement> value) { this.states = value; }
}
