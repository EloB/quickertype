package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum LegalityEnum {
    LEGAL, BANNED, RESTRICTED;

    @JsonValue
    public String toValue() {
        switch (this) {
            case LEGAL: return "Legal";
            case BANNED: return "Banned";
            case RESTRICTED: return "Restricted";
        }
        return null;
    }

    @JsonCreator
    public static LegalityEnum forValue(String value) throws IOException {
        if (value.equals("Legal")) return LEGAL;
        if (value.equals("Banned")) return BANNED;
        if (value.equals("Restricted")) return RESTRICTED;
        throw new IOException("Cannot deserialize LegalityEnum");
    }
}
