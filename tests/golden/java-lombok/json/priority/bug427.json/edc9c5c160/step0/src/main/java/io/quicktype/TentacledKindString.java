package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum TentacledKindString {
    EXTERNAL_MODULE;

    @JsonValue
    public String toValue() {
        switch (this) {
            case EXTERNAL_MODULE: return "External module";
        }
        return null;
    }

    @JsonCreator
    public static TentacledKindString forValue(String value) throws IOException {
        if (value.equals("External module")) return EXTERNAL_MODULE;
        throw new IOException("Cannot deserialize TentacledKindString");
    }
}
