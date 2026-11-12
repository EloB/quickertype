package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private Kind kind;

    /**
     * Comment delimiters:
     * * /
     * {-
     * -}
     * """
     * }
     * }
     */
    @JsonProperty("kind")
    public Kind getKind() { return kind; }
    @JsonProperty("kind")
    public void setKind(Kind value) { this.kind = value; }
}
