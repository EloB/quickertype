package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum FirstNameInitial {
    D, J, T, C, O, H, L, A, K, R, B, N;

    @JsonValue
    public String toValue() {
        switch (this) {
            case D: return "D";
            case J: return "J";
            case T: return "T";
            case C: return "C";
            case O: return "O";
            case H: return "H";
            case L: return "L";
            case A: return "A";
            case K: return "K";
            case R: return "R";
            case B: return "B";
            case N: return "N";
        }
        return null;
    }

    @JsonCreator
    public static FirstNameInitial forValue(String value) throws IOException {
        if (value.equals("D")) return D;
        if (value.equals("J")) return J;
        if (value.equals("T")) return T;
        if (value.equals("C")) return C;
        if (value.equals("O")) return O;
        if (value.equals("H")) return H;
        if (value.equals("L")) return L;
        if (value.equals("A")) return A;
        if (value.equals("K")) return K;
        if (value.equals("R")) return R;
        if (value.equals("B")) return B;
        if (value.equals("N")) return N;
        throw new IOException("Cannot deserialize FirstNameInitial");
    }
}
