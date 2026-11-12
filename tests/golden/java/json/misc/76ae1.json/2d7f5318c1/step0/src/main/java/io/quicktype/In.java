package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum In {
    QUERY;

    @JsonValue
    public String toValue() {
        switch (this) {
            case QUERY: return "query";
        }
        return null;
    }

    @JsonCreator
    public static In forValue(String value) throws IOException {
        if (value.equals("query")) return QUERY;
        throw new IOException("Cannot deserialize In");
    }
}
