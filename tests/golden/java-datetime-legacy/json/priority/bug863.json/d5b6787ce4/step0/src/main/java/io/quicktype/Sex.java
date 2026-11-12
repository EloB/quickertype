package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Sex {
    NEUTER, MALE, FEMALE;

    @JsonValue
    public String toValue() {
        switch (this) {
            case NEUTER: return "Neuter";
            case MALE: return "Male";
            case FEMALE: return "Female";
        }
        return null;
    }

    @JsonCreator
    public static Sex forValue(String value) throws IOException {
        if (value.equals("Neuter")) return NEUTER;
        if (value.equals("Male")) return MALE;
        if (value.equals("Female")) return FEMALE;
        throw new IOException("Cannot deserialize Sex");
    }
}
