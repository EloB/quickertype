package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Egg {
    THE_2_KM, NOT_IN_EGGS, THE_5_KM, THE_10_KM, OMANYTE_CANDY;

    @JsonValue
    public String toValue() {
        switch (this) {
            case THE_2_KM: return "2 km";
            case NOT_IN_EGGS: return "Not in Eggs";
            case THE_5_KM: return "5 km";
            case THE_10_KM: return "10 km";
            case OMANYTE_CANDY: return "Omanyte Candy";
        }
        return null;
    }

    @JsonCreator
    public static Egg forValue(String value) throws IOException {
        if (value.equals("2 km")) return THE_2_KM;
        if (value.equals("Not in Eggs")) return NOT_IN_EGGS;
        if (value.equals("5 km")) return THE_5_KM;
        if (value.equals("10 km")) return THE_10_KM;
        if (value.equals("Omanyte Candy")) return OMANYTE_CANDY;
        throw new IOException("Cannot deserialize Egg");
    }
}
