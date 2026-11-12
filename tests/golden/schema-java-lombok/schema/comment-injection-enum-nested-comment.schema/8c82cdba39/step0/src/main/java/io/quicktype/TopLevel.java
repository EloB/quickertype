package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private Kind kind;

    /**
     * Nested enum block comment openers:
     * {-
     * / *
     * This text must remain inside the generated enum documentation comment.
     */
    @JsonProperty("kind")
    public Kind getKind() { return kind; }
    @JsonProperty("kind")
    public void setKind(Kind value) { this.kind = value; }
}
