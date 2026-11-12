package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum SignatureKindString {
    CALL_SIGNATURE, CONSTRUCTOR_SIGNATURE;

    @JsonValue
    public String toValue() {
        switch (this) {
            case CALL_SIGNATURE: return "Call signature";
            case CONSTRUCTOR_SIGNATURE: return "Constructor signature";
        }
        return null;
    }

    @JsonCreator
    public static SignatureKindString forValue(String value) throws IOException {
        if (value.equals("Call signature")) return CALL_SIGNATURE;
        if (value.equals("Constructor signature")) return CONSTRUCTOR_SIGNATURE;
        throw new IOException("Cannot deserialize SignatureKindString");
    }
}
