package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Keyword {
    OSI_APPROVED, POPULAR, COPYLEFT, INTERNATIONAL;

    @JsonValue
    public String toValue() {
        switch (this) {
            case OSI_APPROVED: return "osi-approved";
            case POPULAR: return "popular";
            case COPYLEFT: return "copyleft";
            case INTERNATIONAL: return "international";
        }
        return null;
    }

    @JsonCreator
    public static Keyword forValue(String value) throws IOException {
        if (value.equals("osi-approved")) return OSI_APPROVED;
        if (value.equals("popular")) return POPULAR;
        if (value.equals("copyleft")) return COPYLEFT;
        if (value.equals("international")) return INTERNATIONAL;
        throw new IOException("Cannot deserialize Keyword");
    }
}
