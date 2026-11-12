package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<Laureate> laureates;

    @JsonProperty("laureates")
    public List<Laureate> getLaureates() { return laureates; }
    @JsonProperty("laureates")
    public void setLaureates(List<Laureate> value) { this.laureates = value; }
}
