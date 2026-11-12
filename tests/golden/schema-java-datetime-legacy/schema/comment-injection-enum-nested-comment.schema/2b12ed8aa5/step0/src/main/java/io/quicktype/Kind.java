package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

/**
 * Nested enum block comment openers:
 * {-
 * / *
 * This text must remain inside the generated enum documentation comment.
 */
public enum Kind {
    OK;

    @JsonValue
    public String toValue() {
        switch (this) {
            case OK: return "ok";
        }
        return null;
    }

    @JsonCreator
    public static Kind forValue(String value) throws IOException {
        if (value.equals("ok")) return OK;
        throw new IOException("Cannot deserialize Kind");
    }
}
