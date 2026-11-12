package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private TopLevelData data;
    private String kind;

    @JsonProperty("data")
    public TopLevelData getData() { return data; }
    @JsonProperty("data")
    public void setData(TopLevelData value) { this.data = value; }

    @JsonProperty("kind")
    public String getKind() { return kind; }
    @JsonProperty("kind")
    public void setKind(String value) { this.kind = value; }
}
