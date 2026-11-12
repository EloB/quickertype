package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Series {
    private List<Datum> data;
    private String seriesID;

    @JsonProperty("data")
    public List<Datum> getData() { return data; }
    @JsonProperty("data")
    public void setData(List<Datum> value) { this.data = value; }

    @JsonProperty("seriesID")
    public String getSeriesID() { return seriesID; }
    @JsonProperty("seriesID")
    public void setSeriesID(String value) { this.seriesID = value; }
}
