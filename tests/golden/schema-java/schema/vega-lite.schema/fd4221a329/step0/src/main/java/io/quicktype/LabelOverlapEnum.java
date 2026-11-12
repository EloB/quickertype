package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum LabelOverlapEnum {
    PARITY, GREEDY;

    @JsonValue
    public String toValue() {
        switch (this) {
            case PARITY: return "parity";
            case GREEDY: return "greedy";
        }
        return null;
    }

    @JsonCreator
    public static LabelOverlapEnum forValue(String value) throws IOException {
        if (value.equals("parity")) return PARITY;
        if (value.equals("greedy")) return GREEDY;
        throw new IOException("Cannot deserialize LabelOverlapEnum");
    }
}
