package io.quicktype;

import com.fasterxml.jackson.annotation.*;

/**
 * Nested block comment openers:
 * {-
 * / *
 * This text must remain inside the generated documentation comment.
 */
public class TopLevel {
    private String value;

    /**
     * Nested property block comment openers:
     * {-
     * / *
     * This text must remain inside the generated property documentation comment.
     */
    @JsonProperty("value")
    public String getValue() { return value; }
    @JsonProperty("value")
    public void setValue(String value) { this.value = value; }
}
