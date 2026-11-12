package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<Datum> data;
    private Meta meta;
    private Pagination pagination;

    @JsonProperty("data")
    public List<Datum> getData() { return data; }
    @JsonProperty("data")
    public void setData(List<Datum> value) { this.data = value; }

    @JsonProperty("meta")
    public Meta getMeta() { return meta; }
    @JsonProperty("meta")
    public void setMeta(Meta value) { this.meta = value; }

    @JsonProperty("pagination")
    public Pagination getPagination() { return pagination; }
    @JsonProperty("pagination")
    public void setPagination(Pagination value) { this.pagination = value; }
}
