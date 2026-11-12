package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum AddImprov {
    F, ADD_IMPROV_F, T;

    @JsonValue
    public String toValue() {
        switch (this) {
            case F: return "f";
            case ADD_IMPROV_F: return "F";
            case T: return "t";
        }
        return null;
    }

    @JsonCreator
    public static AddImprov forValue(String value) throws IOException {
        if (value.equals("f")) return F;
        if (value.equals("F")) return ADD_IMPROV_F;
        if (value.equals("t")) return T;
        throw new IOException("Cannot deserialize AddImprov");
    }
}
