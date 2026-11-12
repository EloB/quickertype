package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Source {
    private long character;
    private FileName fileName;
    private long line;

    @JsonProperty("character")
    public long getCharacter() { return character; }
    @JsonProperty("character")
    public void setCharacter(long value) { this.character = value; }

    @JsonProperty("fileName")
    public FileName getFileName() { return fileName; }
    @JsonProperty("fileName")
    public void setFileName(FileName value) { this.fileName = value; }

    @JsonProperty("line")
    public long getLine() { return line; }
    @JsonProperty("line")
    public void setLine(long value) { this.line = value; }
}
