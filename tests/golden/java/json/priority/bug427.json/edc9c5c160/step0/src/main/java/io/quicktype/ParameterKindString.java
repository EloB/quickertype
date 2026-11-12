package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum ParameterKindString {
    PARAMETER;

    @JsonValue
    public String toValue() {
        switch (this) {
            case PARAMETER: return "Parameter";
        }
        return null;
    }

    @JsonCreator
    public static ParameterKindString forValue(String value) throws IOException {
        if (value.equals("Parameter")) return PARAMETER;
        throw new IOException("Cannot deserialize ParameterKindString");
    }
}
