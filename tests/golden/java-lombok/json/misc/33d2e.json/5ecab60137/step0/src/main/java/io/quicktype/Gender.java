package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Gender {
    MALE, FEMALE, ORG;

    @JsonValue
    public String toValue() {
        switch (this) {
            case MALE: return "male";
            case FEMALE: return "female";
            case ORG: return "org";
        }
        return null;
    }

    @JsonCreator
    public static Gender forValue(String value) throws IOException {
        if (value.equals("male")) return MALE;
        if (value.equals("female")) return FEMALE;
        if (value.equals("org")) return ORG;
        throw new IOException("Cannot deserialize Gender");
    }
}
