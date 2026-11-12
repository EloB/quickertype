package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.Map;

public class TopLevel {
    private Map<String, UnionValue> union;

    @JsonProperty("union")
    public Map<String, UnionValue> getUnion() { return union; }
    @JsonProperty("union")
    public void setUnion(Map<String, UnionValue> value) { this.union = value; }
}
