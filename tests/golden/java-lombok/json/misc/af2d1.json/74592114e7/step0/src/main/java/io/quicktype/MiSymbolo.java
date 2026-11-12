package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum MiSymbolo {
    PEN_2265535_BRUSH_1016777215;

    @JsonValue
    public String toValue() {
        switch (this) {
            case PEN_2265535_BRUSH_1016777215: return "Pen (2, 2, 65535) Brush (1, 0, 16777215)";
        }
        return null;
    }

    @JsonCreator
    public static MiSymbolo forValue(String value) throws IOException {
        if (value.equals("Pen (2, 2, 65535) Brush (1, 0, 16777215)")) return PEN_2265535_BRUSH_1016777215;
        throw new IOException("Cannot deserialize MiSymbolo");
    }
}
