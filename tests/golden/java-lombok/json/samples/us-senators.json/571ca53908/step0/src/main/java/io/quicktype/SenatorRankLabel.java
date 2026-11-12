package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum SenatorRankLabel {
    JUNIOR, SENIOR;

    @JsonValue
    public String toValue() {
        switch (this) {
            case JUNIOR: return "Junior";
            case SENIOR: return "Senior";
        }
        return null;
    }

    @JsonCreator
    public static SenatorRankLabel forValue(String value) throws IOException {
        if (value.equals("Junior")) return JUNIOR;
        if (value.equals("Senior")) return SENIOR;
        throw new IOException("Cannot deserialize SenatorRankLabel");
    }
}
