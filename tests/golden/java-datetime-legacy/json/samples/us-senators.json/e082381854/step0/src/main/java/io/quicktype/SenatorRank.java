package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum SenatorRank {
    JUNIOR, SENIOR;

    @JsonValue
    public String toValue() {
        switch (this) {
            case JUNIOR: return "junior";
            case SENIOR: return "senior";
        }
        return null;
    }

    @JsonCreator
    public static SenatorRank forValue(String value) throws IOException {
        if (value.equals("junior")) return JUNIOR;
        if (value.equals("senior")) return SENIOR;
        throw new IOException("Cannot deserialize SenatorRank");
    }
}
