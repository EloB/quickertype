package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum SuggestedSort {
    CONFIDENCE, QA;

    @JsonValue
    public String toValue() {
        switch (this) {
            case CONFIDENCE: return "confidence";
            case QA: return "qa";
        }
        return null;
    }

    @JsonCreator
    public static SuggestedSort forValue(String value) throws IOException {
        if (value.equals("confidence")) return CONFIDENCE;
        if (value.equals("qa")) return QA;
        throw new IOException("Cannot deserialize SuggestedSort");
    }
}
