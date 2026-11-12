package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum RoleType {
    SENATOR;

    @JsonValue
    public String toValue() {
        switch (this) {
            case SENATOR: return "senator";
        }
        return null;
    }

    @JsonCreator
    public static RoleType forValue(String value) throws IOException {
        if (value.equals("senator")) return SENATOR;
        throw new IOException("Cannot deserialize RoleType");
    }
}
