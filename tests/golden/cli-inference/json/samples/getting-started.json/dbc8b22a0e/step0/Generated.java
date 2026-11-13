package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Generated {
    private String greeting;
    private List<String> instructions;

    @JsonProperty("greeting")
    public String getGreeting() { return greeting; }
    @JsonProperty("greeting")
    public void setGreeting(String value) { this.greeting = value; }

    @JsonProperty("instructions")
    public List<String> getInstructions() { return instructions; }
    @JsonProperty("instructions")
    public void setInstructions(List<String> value) { this.instructions = value; }
}
