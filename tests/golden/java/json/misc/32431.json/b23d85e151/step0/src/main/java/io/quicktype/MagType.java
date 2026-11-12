package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum MagType {
    MD, ML, MB;

    @JsonValue
    public String toValue() {
        switch (this) {
            case MD: return "md";
            case ML: return "ml";
            case MB: return "mb";
        }
        return null;
    }

    @JsonCreator
    public static MagType forValue(String value) throws IOException {
        if (value.equals("md")) return MD;
        if (value.equals("ml")) return ML;
        if (value.equals("mb")) return MB;
        throw new IOException("Cannot deserialize MagType");
    }
}
