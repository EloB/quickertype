package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Keyword {
    DISCOURAGED, OBSOLETE, OSI_APPROVED;

    @JsonValue
    public String toValue() {
        switch (this) {
            case DISCOURAGED: return "discouraged";
            case OBSOLETE: return "obsolete";
            case OSI_APPROVED: return "osi-approved";
        }
        return null;
    }

    @JsonCreator
    public static Keyword forValue(String value) throws IOException {
        if (value.equals("discouraged")) return DISCOURAGED;
        if (value.equals("obsolete")) return OBSOLETE;
        if (value.equals("osi-approved")) return OSI_APPROVED;
        throw new IOException("Cannot deserialize Keyword");
    }
}
