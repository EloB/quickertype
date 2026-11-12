package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<Option> options;

    @JsonProperty("options")
    public List<Option> getOptions() { return options; }
    @JsonProperty("options")
    public void setOptions(List<Option> value) { this.options = value; }
}
