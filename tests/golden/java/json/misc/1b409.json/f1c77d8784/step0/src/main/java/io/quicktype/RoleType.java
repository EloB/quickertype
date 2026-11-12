package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum RoleType {
    REPRESENTATIVE;

    @JsonValue
    public String toValue() {
        switch (this) {
            case REPRESENTATIVE: return "representative";
        }
        return null;
    }

    @JsonCreator
    public static RoleType forValue(String value) throws IOException {
        if (value.equals("representative")) return REPRESENTATIVE;
        throw new IOException("Cannot deserialize RoleType");
    }
}
