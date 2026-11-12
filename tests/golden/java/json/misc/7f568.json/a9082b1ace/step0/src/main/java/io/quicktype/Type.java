package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Type {
    TEXT_PLAIN;

    @JsonValue
    public String toValue() {
        switch (this) {
            case TEXT_PLAIN: return "text/plain";
        }
        return null;
    }

    @JsonCreator
    public static Type forValue(String value) throws IOException {
        if (value.equals("text/plain")) return TEXT_PLAIN;
        throw new IOException("Cannot deserialize Type");
    }
}
