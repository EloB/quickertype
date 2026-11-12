package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ASM {
    private long asm;

    @JsonProperty("asm")
    public long getASM() { return asm; }
    @JsonProperty("asm")
    public void setASM(long value) { this.asm = value; }
}
