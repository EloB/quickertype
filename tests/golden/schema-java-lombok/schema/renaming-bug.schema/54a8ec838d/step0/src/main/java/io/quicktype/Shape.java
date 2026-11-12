package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Shape {
    private Geometry geometry;
    private History history;

    @JsonProperty("geometry")
    public Geometry getGeometry() { return geometry; }
    @JsonProperty("geometry")
    public void setGeometry(Geometry value) { this.geometry = value; }

    @JsonProperty("history")
    public History getHistory() { return history; }
    @JsonProperty("history")
    public void setHistory(History value) { this.history = value; }
}
