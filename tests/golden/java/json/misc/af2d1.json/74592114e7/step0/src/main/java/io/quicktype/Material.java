package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Material {
    GRAVEL, CONCRETE, BITUMEN, INTERLOCK_CONC_BLOCK, OTHER, EARTH;

    @JsonValue
    public String toValue() {
        switch (this) {
            case GRAVEL: return "Gravel";
            case CONCRETE: return "Concrete";
            case BITUMEN: return "Bitumen";
            case INTERLOCK_CONC_BLOCK: return "Interlock Conc Block";
            case OTHER: return "Other";
            case EARTH: return "Earth";
        }
        return null;
    }

    @JsonCreator
    public static Material forValue(String value) throws IOException {
        if (value.equals("Gravel")) return GRAVEL;
        if (value.equals("Concrete")) return CONCRETE;
        if (value.equals("Bitumen")) return BITUMEN;
        if (value.equals("Interlock Conc Block")) return INTERLOCK_CONC_BLOCK;
        if (value.equals("Other")) return OTHER;
        if (value.equals("Earth")) return EARTH;
        throw new IOException("Cannot deserialize Material");
    }
}
