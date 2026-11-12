package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum RoleTypeLabel {
    SENATOR;

    @JsonValue
    public String toValue() {
        switch (this) {
            case SENATOR: return "Senator";
        }
        return null;
    }

    @JsonCreator
    public static RoleTypeLabel forValue(String value) throws IOException {
        if (value.equals("Senator")) return SENATOR;
        throw new IOException("Cannot deserialize RoleTypeLabel");
    }
}
