package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum ClassEnum {
    NO_CODE_ALLOCATED, OS_DISTRICT, OS_NEIGHBOURHOOD, OS_REGIONAL;

    @JsonValue
    public String toValue() {
        switch (this) {
            case NO_CODE_ALLOCATED: return "No Code Allocated";
            case OS_DISTRICT: return "OS-District";
            case OS_NEIGHBOURHOOD: return "OS-Neighbourhood";
            case OS_REGIONAL: return "OS-Regional";
        }
        return null;
    }

    @JsonCreator
    public static ClassEnum forValue(String value) throws IOException {
        if (value.equals("No Code Allocated")) return NO_CODE_ALLOCATED;
        if (value.equals("OS-District")) return OS_DISTRICT;
        if (value.equals("OS-Neighbourhood")) return OS_NEIGHBOURHOOD;
        if (value.equals("OS-Regional")) return OS_REGIONAL;
        throw new IOException("Cannot deserialize ClassEnum");
    }
}
