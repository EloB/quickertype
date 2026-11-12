package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Right {
    READ;

    @JsonValue
    public String toValue() {
        switch (this) {
            case READ: return "read";
        }
        return null;
    }

    @JsonCreator
    public static Right forValue(String value) throws IOException {
        if (value.equals("read")) return READ;
        throw new IOException("Cannot deserialize Right");
    }
}
