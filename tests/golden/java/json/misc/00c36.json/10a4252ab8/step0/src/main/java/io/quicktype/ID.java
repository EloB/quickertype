package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum ID {
    US, NY_GDP_MKTP_CD;

    @JsonValue
    public String toValue() {
        switch (this) {
            case US: return "US";
            case NY_GDP_MKTP_CD: return "NY.GDP.MKTP.CD";
        }
        return null;
    }

    @JsonCreator
    public static ID forValue(String value) throws IOException {
        if (value.equals("US")) return US;
        if (value.equals("NY.GDP.MKTP.CD")) return NY_GDP_MKTP_CD;
        throw new IOException("Cannot deserialize ID");
    }
}
