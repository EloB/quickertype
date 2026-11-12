package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Keyword {
    OSI_APPROVED, DISCOURAGED, REDUNDANT, MISCELLANEOUS, NON_REUSABLE, OBSOLETE, POPULAR, PERMISSIVE, RETIRED, SPECIAL_PURPOSE, COPYLEFT, INTERNATIONAL;

    @JsonValue
    public String toValue() {
        switch (this) {
            case OSI_APPROVED: return "osi-approved";
            case DISCOURAGED: return "discouraged";
            case REDUNDANT: return "redundant";
            case MISCELLANEOUS: return "miscellaneous";
            case NON_REUSABLE: return "non-reusable";
            case OBSOLETE: return "obsolete";
            case POPULAR: return "popular";
            case PERMISSIVE: return "permissive";
            case RETIRED: return "retired";
            case SPECIAL_PURPOSE: return "special-purpose";
            case COPYLEFT: return "copyleft";
            case INTERNATIONAL: return "international";
        }
        return null;
    }

    @JsonCreator
    public static Keyword forValue(String value) throws IOException {
        if (value.equals("osi-approved")) return OSI_APPROVED;
        if (value.equals("discouraged")) return DISCOURAGED;
        if (value.equals("redundant")) return REDUNDANT;
        if (value.equals("miscellaneous")) return MISCELLANEOUS;
        if (value.equals("non-reusable")) return NON_REUSABLE;
        if (value.equals("obsolete")) return OBSOLETE;
        if (value.equals("popular")) return POPULAR;
        if (value.equals("permissive")) return PERMISSIVE;
        if (value.equals("retired")) return RETIRED;
        if (value.equals("special-purpose")) return SPECIAL_PURPOSE;
        if (value.equals("copyleft")) return COPYLEFT;
        if (value.equals("international")) return INTERNATIONAL;
        throw new IOException("Cannot deserialize Keyword");
    }
}
