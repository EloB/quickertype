package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Rating {
    G;

    @JsonValue
    public String toValue() {
        switch (this) {
            case G: return "g";
        }
        return null;
    }

    @JsonCreator
    public static Rating forValue(String value) throws IOException {
        if (value.equals("g")) return G;
        throw new IOException("Cannot deserialize Rating");
    }
}
