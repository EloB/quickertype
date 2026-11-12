package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Rating {
    PG, G, PG_13;

    @JsonValue
    public String toValue() {
        switch (this) {
            case PG: return "pg";
            case G: return "g";
            case PG_13: return "pg-13";
        }
        return null;
    }

    @JsonCreator
    public static Rating forValue(String value) throws IOException {
        if (value.equals("pg")) return PG;
        if (value.equals("g")) return G;
        if (value.equals("pg-13")) return PG_13;
        throw new IOException("Cannot deserialize Rating");
    }
}
