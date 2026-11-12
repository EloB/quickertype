package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum FundingBa {
    NON_GCCC, CAPEX, INITIAL, CONTRIBUTE;

    @JsonValue
    public String toValue() {
        switch (this) {
            case NON_GCCC: return "Non GCCC";
            case CAPEX: return "Capex";
            case INITIAL: return "Initial";
            case CONTRIBUTE: return "Contribute";
        }
        return null;
    }

    @JsonCreator
    public static FundingBa forValue(String value) throws IOException {
        if (value.equals("Non GCCC")) return NON_GCCC;
        if (value.equals("Capex")) return CAPEX;
        if (value.equals("Initial")) return INITIAL;
        if (value.equals("Contribute")) return CONTRIBUTE;
        throw new IOException("Cannot deserialize FundingBa");
    }
}
