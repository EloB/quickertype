package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Type {
    GROSS_SALARY_AMOUNT, OVERTIME;

    @JsonValue
    public String toValue() {
        switch (this) {
            case GROSS_SALARY_AMOUNT: return "GrossSalaryAmount";
            case OVERTIME: return "Overtime";
        }
        return null;
    }

    @JsonCreator
    public static Type forValue(String value) throws IOException {
        if (value.equals("GrossSalaryAmount")) return GROSS_SALARY_AMOUNT;
        if (value.equals("Overtime")) return OVERTIME;
        throw new IOException("Cannot deserialize Type");
    }
}
