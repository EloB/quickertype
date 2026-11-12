package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum GrantFlag {
    PUBLIC;

    @JsonValue
    public String toValue() {
        switch (this) {
            case PUBLIC: return "public";
        }
        return null;
    }

    @JsonCreator
    public static GrantFlag forValue(String value) throws IOException {
        if (value.equals("public")) return PUBLIC;
        throw new IOException("Cannot deserialize GrantFlag");
    }
}
