package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum SenatorRank {
    SENIOR, JUNIOR;

    @JsonValue
    public String toValue() {
        switch (this) {
            case SENIOR: return "senior";
            case JUNIOR: return "junior";
        }
        return null;
    }

    @JsonCreator
    public static SenatorRank forValue(String value) throws IOException {
        if (value.equals("senior")) return SENIOR;
        if (value.equals("junior")) return JUNIOR;
        throw new IOException("Cannot deserialize SenatorRank");
    }
}
