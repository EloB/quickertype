package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Provenance {
    OFFICIAL;

    @JsonValue
    public String toValue() {
        switch (this) {
            case OFFICIAL: return "official";
        }
        return null;
    }

    @JsonCreator
    public static Provenance forValue(String value) throws IOException {
        if (value.equals("official")) return OFFICIAL;
        throw new IOException("Cannot deserialize Provenance");
    }
}
