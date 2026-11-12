package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Domain {
    SELF_ASK_REDDIT;

    @JsonValue
    public String toValue() {
        switch (this) {
            case SELF_ASK_REDDIT: return "self.AskReddit";
        }
        return null;
    }

    @JsonCreator
    public static Domain forValue(String value) throws IOException {
        if (value.equals("self.AskReddit")) return SELF_ASK_REDDIT;
        throw new IOException("Cannot deserialize Domain");
    }
}
