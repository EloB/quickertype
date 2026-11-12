package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Group {
    private List<Long> children;
    private long kind;
    private String title;

    @JsonProperty("children")
    public List<Long> getChildren() { return children; }
    @JsonProperty("children")
    public void setChildren(List<Long> value) { this.children = value; }

    @JsonProperty("kind")
    public long getKind() { return kind; }
    @JsonProperty("kind")
    public void setKind(long value) { this.kind = value; }

    @JsonProperty("title")
    public String getTitle() { return title; }
    @JsonProperty("title")
    public void setTitle(String value) { this.title = value; }
}
