package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum OrderColumnFieldName {
    DATE_RECEIVED, AGREEMENT_DATE, IN_EFFECT_AS_OF_1_1_2012;

    @JsonValue
    public String toValue() {
        switch (this) {
            case DATE_RECEIVED: return "date_received";
            case AGREEMENT_DATE: return "agreement_date";
            case IN_EFFECT_AS_OF_1_1_2012: return "in_effect_as_of_1_1_2012";
        }
        return null;
    }

    @JsonCreator
    public static OrderColumnFieldName forValue(String value) throws IOException {
        if (value.equals("date_received")) return DATE_RECEIVED;
        if (value.equals("agreement_date")) return AGREEMENT_DATE;
        if (value.equals("in_effect_as_of_1_1_2012")) return IN_EFFECT_AS_OF_1_1_2012;
        throw new IOException("Cannot deserialize OrderColumnFieldName");
    }
}
