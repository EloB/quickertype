package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private String date;
    private List<String> stopAndSearch;

    @JsonProperty("date")
    public String getDate() { return date; }
    @JsonProperty("date")
    public void setDate(String value) { this.date = value; }

    @JsonProperty("stop-and-search")
    public List<String> getStopAndSearch() { return stopAndSearch; }
    @JsonProperty("stop-and-search")
    public void setStopAndSearch(List<String> value) { this.stopAndSearch = value; }
}
