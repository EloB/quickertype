package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<List<Datum>> data;
    private Meta meta;

    @JsonProperty("data")
    public List<List<Datum>> getData() { return data; }
    @JsonProperty("data")
    public void setData(List<List<Datum>> value) { this.data = value; }

    @JsonProperty("meta")
    public Meta getMeta() { return meta; }
    @JsonProperty("meta")
    public void setMeta(Meta value) { this.meta = value; }
}
