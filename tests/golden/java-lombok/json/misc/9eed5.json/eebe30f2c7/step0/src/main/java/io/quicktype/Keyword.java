package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Keyword {
    SPECIAL_PURPOSE, OSI_APPROVED;

    @JsonValue
    public String toValue() {
        switch (this) {
            case SPECIAL_PURPOSE: return "special-purpose";
            case OSI_APPROVED: return "osi-approved";
        }
        return null;
    }

    @JsonCreator
    public static Keyword forValue(String value) throws IOException {
        if (value.equals("special-purpose")) return SPECIAL_PURPOSE;
        if (value.equals("osi-approved")) return OSI_APPROVED;
        throw new IOException("Cannot deserialize Keyword");
    }
}
