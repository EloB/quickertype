package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum SubType {
    JUMPSHOT, LAYUP, DUNK;

    @JsonValue
    public String toValue() {
        switch (this) {
            case JUMPSHOT: return "jumpshot";
            case LAYUP: return "layup";
            case DUNK: return "dunk";
        }
        return null;
    }

    @JsonCreator
    public static SubType forValue(String value) throws IOException {
        if (value.equals("jumpshot")) return JUMPSHOT;
        if (value.equals("layup")) return LAYUP;
        if (value.equals("dunk")) return DUNK;
        throw new IOException("Cannot deserialize SubType");
    }
}
