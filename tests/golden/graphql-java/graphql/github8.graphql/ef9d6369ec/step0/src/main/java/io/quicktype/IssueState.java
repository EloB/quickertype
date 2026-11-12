package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum IssueState {
    OPEN, CLOSED;

    @JsonValue
    public String toValue() {
        switch (this) {
            case OPEN: return "OPEN";
            case CLOSED: return "CLOSED";
        }
        return null;
    }

    @JsonCreator
    public static IssueState forValue(String value) throws IOException {
        if (value.equals("OPEN")) return OPEN;
        if (value.equals("CLOSED")) return CLOSED;
        throw new IOException("Cannot deserialize IssueState");
    }
}
