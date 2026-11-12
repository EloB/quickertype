package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Rating {
    G, PG, Y;

    @JsonValue
    public String toValue() {
        switch (this) {
            case G: return "g";
            case PG: return "pg";
            case Y: return "y";
        }
        return null;
    }

    @JsonCreator
    public static Rating forValue(String value) throws IOException {
        if (value.equals("g")) return G;
        if (value.equals("pg")) return PG;
        if (value.equals("y")) return Y;
        throw new IOException("Cannot deserialize Rating");
    }
}
