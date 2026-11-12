package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Keyword {
    OSI_APPROVED, DISCOURAGED, REDUNDANT;

    @JsonValue
    public String toValue() {
        switch (this) {
            case OSI_APPROVED: return "osi-approved";
            case DISCOURAGED: return "discouraged";
            case REDUNDANT: return "redundant";
        }
        return null;
    }

    @JsonCreator
    public static Keyword forValue(String value) throws IOException {
        if (value.equals("osi-approved")) return OSI_APPROVED;
        if (value.equals("discouraged")) return DISCOURAGED;
        if (value.equals("redundant")) return REDUNDANT;
        throw new IOException("Cannot deserialize Keyword");
    }
}
