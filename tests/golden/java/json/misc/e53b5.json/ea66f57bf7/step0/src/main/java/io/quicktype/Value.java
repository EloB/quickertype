package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Value {
    INDIA, POPULATION_TOTAL;

    @JsonValue
    public String toValue() {
        switch (this) {
            case INDIA: return "India";
            case POPULATION_TOTAL: return "Population, total";
        }
        return null;
    }

    @JsonCreator
    public static Value forValue(String value) throws IOException {
        if (value.equals("India")) return INDIA;
        if (value.equals("Population, total")) return POPULATION_TOTAL;
        throw new IOException("Cannot deserialize Value");
    }
}
