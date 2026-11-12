package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Type {
    POSTER, BACKDROP;

    @JsonValue
    public String toValue() {
        switch (this) {
            case POSTER: return "Poster";
            case BACKDROP: return "Backdrop";
        }
        return null;
    }

    @JsonCreator
    public static Type forValue(String value) throws IOException {
        if (value.equals("Poster")) return POSTER;
        if (value.equals("Backdrop")) return BACKDROP;
        throw new IOException("Cannot deserialize Type");
    }
}
