package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Variants {
    private GIF gif;
    private GIF mp4;
    private GIF nsfw;
    private GIF obfuscated;

    @JsonProperty("gif")
    public GIF getGIF() { return gif; }
    @JsonProperty("gif")
    public void setGIF(GIF value) { this.gif = value; }

    @JsonProperty("mp4")
    public GIF getMp4() { return mp4; }
    @JsonProperty("mp4")
    public void setMp4(GIF value) { this.mp4 = value; }

    @JsonProperty("nsfw")
    public GIF getNsfw() { return nsfw; }
    @JsonProperty("nsfw")
    public void setNsfw(GIF value) { this.nsfw = value; }

    @JsonProperty("obfuscated")
    public GIF getObfuscated() { return obfuscated; }
    @JsonProperty("obfuscated")
    public void setObfuscated(GIF value) { this.obfuscated = value; }
}
