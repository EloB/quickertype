package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<Long> maxOnly;
    private List<Double> minAndMax;
    private List<String> minOnly;
    private List<String> plain;
    private List<UnionItem> unionItems;

    @JsonProperty("maxOnly")
    public List<Long> getMaxOnly() { return maxOnly; }
    @JsonProperty("maxOnly")
    public void setMaxOnly(List<Long> value) { this.maxOnly = value; }

    @JsonProperty("minAndMax")
    public List<Double> getMinAndMax() { return minAndMax; }
    @JsonProperty("minAndMax")
    public void setMinAndMax(List<Double> value) { this.minAndMax = value; }

    @JsonProperty("minOnly")
    public List<String> getMinOnly() { return minOnly; }
    @JsonProperty("minOnly")
    public void setMinOnly(List<String> value) { this.minOnly = value; }

    @JsonProperty("plain")
    public List<String> getPlain() { return plain; }
    @JsonProperty("plain")
    public void setPlain(List<String> value) { this.plain = value; }

    @JsonProperty("unionItems")
    public List<UnionItem> getUnionItems() { return unionItems; }
    @JsonProperty("unionItems")
    public void setUnionItems(List<UnionItem> value) { this.unionItems = value; }
}
