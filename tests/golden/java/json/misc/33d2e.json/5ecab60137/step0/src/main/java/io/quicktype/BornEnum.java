package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum BornEnum {
    THE_00000000, THE_18980000, THE_19430000;

    @JsonValue
    public String toValue() {
        switch (this) {
            case THE_00000000: return "0000-00-00";
            case THE_18980000: return "1898-00-00";
            case THE_19430000: return "1943-00-00";
        }
        return null;
    }

    @JsonCreator
    public static BornEnum forValue(String value) throws IOException {
        if (value.equals("0000-00-00")) return THE_00000000;
        if (value.equals("1898-00-00")) return THE_18980000;
        if (value.equals("1943-00-00")) return THE_19430000;
        throw new IOException("Cannot deserialize BornEnum");
    }
}
