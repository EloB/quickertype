package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Title {
    SEN;

    @JsonValue
    public String toValue() {
        switch (this) {
            case SEN: return "Sen.";
        }
        return null;
    }

    @JsonCreator
    public static Title forValue(String value) throws IOException {
        if (value.equals("Sen.")) return SEN;
        throw new IOException("Cannot deserialize Title");
    }
}
