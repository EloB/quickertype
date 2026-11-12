package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Category {
    PHYSICS, CHEMISTRY, PEACE, MEDICINE, LITERATURE, ECONOMICS;

    @JsonValue
    public String toValue() {
        switch (this) {
            case PHYSICS: return "physics";
            case CHEMISTRY: return "chemistry";
            case PEACE: return "peace";
            case MEDICINE: return "medicine";
            case LITERATURE: return "literature";
            case ECONOMICS: return "economics";
        }
        return null;
    }

    @JsonCreator
    public static Category forValue(String value) throws IOException {
        if (value.equals("physics")) return PHYSICS;
        if (value.equals("chemistry")) return CHEMISTRY;
        if (value.equals("peace")) return PEACE;
        if (value.equals("medicine")) return MEDICINE;
        if (value.equals("literature")) return LITERATURE;
        if (value.equals("economics")) return ECONOMICS;
        throw new IOException("Cannot deserialize Category");
    }
}
