package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Title {
    MR, MS;

    @JsonValue
    public String toValue() {
        switch (this) {
            case MR: return "Mr";
            case MS: return "Ms";
        }
        return null;
    }

    @JsonCreator
    public static Title forValue(String value) throws IOException {
        if (value.equals("Mr")) return MR;
        if (value.equals("Ms")) return MS;
        throw new IOException("Cannot deserialize Title");
    }
}
