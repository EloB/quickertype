package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Pvptitle {
    FRESHMAN;

    @JsonValue
    public String toValue() {
        switch (this) {
            case FRESHMAN: return "Freshman";
        }
        return null;
    }

    @JsonCreator
    public static Pvptitle forValue(String value) throws IOException {
        if (value.equals("Freshman")) return FRESHMAN;
        throw new IOException("Cannot deserialize Pvptitle");
    }
}
