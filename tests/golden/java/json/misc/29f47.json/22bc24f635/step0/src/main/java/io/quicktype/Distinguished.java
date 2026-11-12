package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Distinguished {
    ADMIN;

    @JsonValue
    public String toValue() {
        switch (this) {
            case ADMIN: return "admin";
        }
        return null;
    }

    @JsonCreator
    public static Distinguished forValue(String value) throws IOException {
        if (value.equals("admin")) return ADMIN;
        throw new IOException("Cannot deserialize Distinguished");
    }
}
