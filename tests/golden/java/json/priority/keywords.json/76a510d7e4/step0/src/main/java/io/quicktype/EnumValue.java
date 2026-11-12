package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum EnumValue {
    READY, DONE;

    @JsonValue
    public String toValue() {
        switch (this) {
            case READY: return "ready";
            case DONE: return "done";
        }
        return null;
    }

    @JsonCreator
    public static EnumValue forValue(String value) throws IOException {
        if (value.equals("ready")) return READY;
        if (value.equals("done")) return DONE;
        throw new IOException("Cannot deserialize EnumValue");
    }
}
