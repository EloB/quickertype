package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Username {
    EMPTY, MASHABLE, NBA, ORIGINALS;

    @JsonValue
    public String toValue() {
        switch (this) {
            case EMPTY: return "";
            case MASHABLE: return "mashable";
            case NBA: return "nba";
            case ORIGINALS: return "Originals";
        }
        return null;
    }

    @JsonCreator
    public static Username forValue(String value) throws IOException {
        if (value.equals("")) return EMPTY;
        if (value.equals("mashable")) return MASHABLE;
        if (value.equals("nba")) return NBA;
        if (value.equals("Originals")) return ORIGINALS;
        throw new IOException("Cannot deserialize Username");
    }
}
