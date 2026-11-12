package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevelData {
    private String after;
    private Object before;
    private List<Child> children;
    private String modhash;

    @JsonProperty("after")
    public String getAfter() { return after; }
    @JsonProperty("after")
    public void setAfter(String value) { this.after = value; }

    @JsonProperty("before")
    public Object getBefore() { return before; }
    @JsonProperty("before")
    public void setBefore(Object value) { this.before = value; }

    @JsonProperty("children")
    public List<Child> getChildren() { return children; }
    @JsonProperty("children")
    public void setChildren(List<Child> value) { this.children = value; }

    @JsonProperty("modhash")
    public String getModhash() { return modhash; }
    @JsonProperty("modhash")
    public void setModhash(String value) { this.modhash = value; }
}
