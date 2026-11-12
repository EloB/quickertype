package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum ViewType {
    TABULAR;

    @JsonValue
    public String toValue() {
        switch (this) {
            case TABULAR: return "tabular";
        }
        return null;
    }

    @JsonCreator
    public static ViewType forValue(String value) throws IOException {
        if (value.equals("tabular")) return TABULAR;
        throw new IOException("Cannot deserialize ViewType");
    }
}
