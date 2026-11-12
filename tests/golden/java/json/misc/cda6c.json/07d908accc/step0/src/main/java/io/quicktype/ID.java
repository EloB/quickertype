package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum ID {
    CN, SP_POP_TOTL;

    @JsonValue
    public String toValue() {
        switch (this) {
            case CN: return "CN";
            case SP_POP_TOTL: return "SP.POP.TOTL";
        }
        return null;
    }

    @JsonCreator
    public static ID forValue(String value) throws IOException {
        if (value.equals("CN")) return CN;
        if (value.equals("SP.POP.TOTL")) return SP_POP_TOTL;
        throw new IOException("Cannot deserialize ID");
    }
}
