package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Frequency {
    WEEKLY, MONTHLY, ANNUALLY;

    @JsonValue
    public String toValue() {
        switch (this) {
            case WEEKLY: return "Weekly";
            case MONTHLY: return "Monthly";
            case ANNUALLY: return "Annually";
        }
        return null;
    }

    @JsonCreator
    public static Frequency forValue(String value) throws IOException {
        if (value.equals("Weekly")) return WEEKLY;
        if (value.equals("Monthly")) return MONTHLY;
        if (value.equals("Annually")) return ANNUALLY;
        throw new IOException("Cannot deserialize Frequency");
    }
}
