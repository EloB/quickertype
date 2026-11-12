package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Results {
    private List<Series> series;

    @JsonProperty("series")
    public List<Series> getSeries() { return series; }
    @JsonProperty("series")
    public void setSeries(List<Series> value) { this.series = value; }
}
