package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Health {
    OK, ERROR;

    @JsonValue
    public String toValue() {
        switch (this) {
            case OK: return "ok";
            case ERROR: return "error";
        }
        return null;
    }

    @JsonCreator
    public static Health forValue(String value) throws IOException {
        if (value.equals("ok")) return OK;
        if (value.equals("error")) return ERROR;
        throw new IOException("Cannot deserialize Health");
    }
}
