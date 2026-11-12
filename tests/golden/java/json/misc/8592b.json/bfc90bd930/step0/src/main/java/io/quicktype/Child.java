package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Child {
    private ChildData data;
    private Kind kind;

    @JsonProperty("data")
    public ChildData getData() { return data; }
    @JsonProperty("data")
    public void setData(ChildData value) { this.data = value; }

    @JsonProperty("kind")
    public Kind getKind() { return kind; }
    @JsonProperty("kind")
    public void setKind(Kind value) { this.kind = value; }
}
