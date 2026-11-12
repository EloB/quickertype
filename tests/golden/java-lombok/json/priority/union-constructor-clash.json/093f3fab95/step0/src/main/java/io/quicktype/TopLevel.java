package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private BoolInUnion boolInUnion;
    private List<Union> union;

    @JsonProperty("BoolInUnion")
    public BoolInUnion getBoolInUnion() { return boolInUnion; }
    @JsonProperty("BoolInUnion")
    public void setBoolInUnion(BoolInUnion value) { this.boolInUnion = value; }

    @JsonProperty("union")
    public List<Union> getUnion() { return union; }
    @JsonProperty("union")
    public void setUnion(List<Union> value) { this.union = value; }
}
