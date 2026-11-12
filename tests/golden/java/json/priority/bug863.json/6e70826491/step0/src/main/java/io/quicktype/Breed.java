package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Breed {
    ATROX, SOLITUS, OPIFEX, NANO;

    @JsonValue
    public String toValue() {
        switch (this) {
            case ATROX: return "Atrox";
            case SOLITUS: return "Solitus";
            case OPIFEX: return "Opifex";
            case NANO: return "Nano";
        }
        return null;
    }

    @JsonCreator
    public static Breed forValue(String value) throws IOException {
        if (value.equals("Atrox")) return ATROX;
        if (value.equals("Solitus")) return SOLITUS;
        if (value.equals("Opifex")) return OPIFEX;
        if (value.equals("Nano")) return NANO;
        throw new IOException("Cannot deserialize Breed");
    }
}
