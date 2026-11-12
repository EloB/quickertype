package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum RoleTypeLabel {
    REPRESENTATIVE, DELEGATE, RESIDENT_COMMISSIONER;

    @JsonValue
    public String toValue() {
        switch (this) {
            case REPRESENTATIVE: return "Representative";
            case DELEGATE: return "Delegate";
            case RESIDENT_COMMISSIONER: return "Resident Commissioner";
        }
        return null;
    }

    @JsonCreator
    public static RoleTypeLabel forValue(String value) throws IOException {
        if (value.equals("Representative")) return REPRESENTATIVE;
        if (value.equals("Delegate")) return DELEGATE;
        if (value.equals("Resident Commissioner")) return RESIDENT_COMMISSIONER;
        throw new IOException("Cannot deserialize RoleTypeLabel");
    }
}
