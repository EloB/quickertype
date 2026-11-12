package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Keyword {
    OSI_APPROVED, POPULAR, PERMISSIVE, COPYLEFT;

    @JsonValue
    public String toValue() {
        switch (this) {
            case OSI_APPROVED: return "osi-approved";
            case POPULAR: return "popular";
            case PERMISSIVE: return "permissive";
            case COPYLEFT: return "copyleft";
        }
        return null;
    }

    @JsonCreator
    public static Keyword forValue(String value) throws IOException {
        if (value.equals("osi-approved")) return OSI_APPROVED;
        if (value.equals("popular")) return POPULAR;
        if (value.equals("permissive")) return PERMISSIVE;
        if (value.equals("copyleft")) return COPYLEFT;
        throw new IOException("Cannot deserialize Keyword");
    }
}
