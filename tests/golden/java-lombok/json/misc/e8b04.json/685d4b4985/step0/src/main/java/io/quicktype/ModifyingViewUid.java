package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum ModifyingViewUid {
    S6_EW_H6_MP;

    @JsonValue
    public String toValue() {
        switch (this) {
            case S6_EW_H6_MP: return "s6ew-h6mp";
        }
        return null;
    }

    @JsonCreator
    public static ModifyingViewUid forValue(String value) throws IOException {
        if (value.equals("s6ew-h6mp")) return S6_EW_H6_MP;
        throw new IOException("Cannot deserialize ModifyingViewUid");
    }
}
