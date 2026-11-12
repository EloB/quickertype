package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Name {
    OFFICE_ON_VIOLENCE_AGAINST_WOMEN;

    @JsonValue
    public String toValue() {
        switch (this) {
            case OFFICE_ON_VIOLENCE_AGAINST_WOMEN: return "Office on Violence Against Women";
        }
        return null;
    }

    @JsonCreator
    public static Name forValue(String value) throws IOException {
        if (value.equals("Office on Violence Against Women")) return OFFICE_ON_VIOLENCE_AGAINST_WOMEN;
        throw new IOException("Cannot deserialize Name");
    }
}
