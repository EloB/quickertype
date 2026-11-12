package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private String b;
    private Kind kind;

    @JsonProperty("b")
    public String getB() { return b; }
    @JsonProperty("b")
    public void setB(String value) { this.b = value; }

    @JsonProperty("kind")
    public Kind getKind() { return kind; }
    @JsonProperty("kind")
    public void setKind(Kind value) { this.kind = value; }
}
