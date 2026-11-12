package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Value {
    CHINA, POPULATION_TOTAL;

    @JsonValue
    public String toValue() {
        switch (this) {
            case CHINA: return "China";
            case POPULATION_TOTAL: return "Population, total";
        }
        return null;
    }

    @JsonCreator
    public static Value forValue(String value) throws IOException {
        if (value.equals("China")) return CHINA;
        if (value.equals("Population, total")) return POPULATION_TOTAL;
        throw new IOException("Cannot deserialize Value");
    }
}
