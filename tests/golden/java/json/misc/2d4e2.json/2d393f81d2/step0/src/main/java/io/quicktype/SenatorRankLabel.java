package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum SenatorRankLabel {
    SENIOR, JUNIOR;

    @JsonValue
    public String toValue() {
        switch (this) {
            case SENIOR: return "Senior";
            case JUNIOR: return "Junior";
        }
        return null;
    }

    @JsonCreator
    public static SenatorRankLabel forValue(String value) throws IOException {
        if (value.equals("Senior")) return SENIOR;
        if (value.equals("Junior")) return JUNIOR;
        throw new IOException("Cannot deserialize SenatorRankLabel");
    }
}
