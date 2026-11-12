package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Images {
    private Downsized downsized;
    private Downsized downsizedLarge;
    private Downsized downsizedMedium;
    private DownsizedSmall downsizedSmall;
    private Downsized downsizedStill;
    private FixedHeight fixedHeight;
    private FixedHeight fixedHeightDownsampled;
    private FixedHeight fixedHeightSmall;
    private Downsized fixedHeightSmallStill;
    private Downsized fixedHeightStill;
    private FixedHeight fixedWidth;
    private FixedHeight fixedWidthDownsampled;
    private FixedHeight fixedWidthSmall;
    private Downsized fixedWidthSmallStill;
    private Downsized fixedWidthStill;
    private DownsizedSmall hd;
    private Looping looping;
    private FixedHeight original;
    private DownsizedSmall originalMp4;
    private Downsized originalStill;
    private DownsizedSmall preview;
    private Downsized previewGIF;
    private Downsized previewWebp;

    @JsonProperty("downsized")
    public Downsized getDownsized() { return downsized; }
    @JsonProperty("downsized")
    public void setDownsized(Downsized value) { this.downsized = value; }

    @JsonProperty("downsized_large")
    public Downsized getDownsizedLarge() { return downsizedLarge; }
    @JsonProperty("downsized_large")
    public void setDownsizedLarge(Downsized value) { this.downsizedLarge = value; }

    @JsonProperty("downsized_medium")
    public Downsized getDownsizedMedium() { return downsizedMedium; }
    @JsonProperty("downsized_medium")
    public void setDownsizedMedium(Downsized value) { this.downsizedMedium = value; }

    @JsonProperty("downsized_small")
    public DownsizedSmall getDownsizedSmall() { return downsizedSmall; }
    @JsonProperty("downsized_small")
    public void setDownsizedSmall(DownsizedSmall value) { this.downsizedSmall = value; }

    @JsonProperty("downsized_still")
    public Downsized getDownsizedStill() { return downsizedStill; }
    @JsonProperty("downsized_still")
    public void setDownsizedStill(Downsized value) { this.downsizedStill = value; }

    @JsonProperty("fixed_height")
    public FixedHeight getFixedHeight() { return fixedHeight; }
    @JsonProperty("fixed_height")
    public void setFixedHeight(FixedHeight value) { this.fixedHeight = value; }

    @JsonProperty("fixed_height_downsampled")
    public FixedHeight getFixedHeightDownsampled() { return fixedHeightDownsampled; }
    @JsonProperty("fixed_height_downsampled")
    public void setFixedHeightDownsampled(FixedHeight value) { this.fixedHeightDownsampled = value; }

    @JsonProperty("fixed_height_small")
    public FixedHeight getFixedHeightSmall() { return fixedHeightSmall; }
    @JsonProperty("fixed_height_small")
    public void setFixedHeightSmall(FixedHeight value) { this.fixedHeightSmall = value; }

    @JsonProperty("fixed_height_small_still")
    public Downsized getFixedHeightSmallStill() { return fixedHeightSmallStill; }
    @JsonProperty("fixed_height_small_still")
    public void setFixedHeightSmallStill(Downsized value) { this.fixedHeightSmallStill = value; }

    @JsonProperty("fixed_height_still")
    public Downsized getFixedHeightStill() { return fixedHeightStill; }
    @JsonProperty("fixed_height_still")
    public void setFixedHeightStill(Downsized value) { this.fixedHeightStill = value; }

    @JsonProperty("fixed_width")
    public FixedHeight getFixedWidth() { return fixedWidth; }
    @JsonProperty("fixed_width")
    public void setFixedWidth(FixedHeight value) { this.fixedWidth = value; }

    @JsonProperty("fixed_width_downsampled")
    public FixedHeight getFixedWidthDownsampled() { return fixedWidthDownsampled; }
    @JsonProperty("fixed_width_downsampled")
    public void setFixedWidthDownsampled(FixedHeight value) { this.fixedWidthDownsampled = value; }

    @JsonProperty("fixed_width_small")
    public FixedHeight getFixedWidthSmall() { return fixedWidthSmall; }
    @JsonProperty("fixed_width_small")
    public void setFixedWidthSmall(FixedHeight value) { this.fixedWidthSmall = value; }

    @JsonProperty("fixed_width_small_still")
    public Downsized getFixedWidthSmallStill() { return fixedWidthSmallStill; }
    @JsonProperty("fixed_width_small_still")
    public void setFixedWidthSmallStill(Downsized value) { this.fixedWidthSmallStill = value; }

    @JsonProperty("fixed_width_still")
    public Downsized getFixedWidthStill() { return fixedWidthStill; }
    @JsonProperty("fixed_width_still")
    public void setFixedWidthStill(Downsized value) { this.fixedWidthStill = value; }

    @JsonProperty("hd")
    public DownsizedSmall getHD() { return hd; }
    @JsonProperty("hd")
    public void setHD(DownsizedSmall value) { this.hd = value; }

    @JsonProperty("looping")
    public Looping getLooping() { return looping; }
    @JsonProperty("looping")
    public void setLooping(Looping value) { this.looping = value; }

    @JsonProperty("original")
    public FixedHeight getOriginal() { return original; }
    @JsonProperty("original")
    public void setOriginal(FixedHeight value) { this.original = value; }

    @JsonProperty("original_mp4")
    public DownsizedSmall getOriginalMp4() { return originalMp4; }
    @JsonProperty("original_mp4")
    public void setOriginalMp4(DownsizedSmall value) { this.originalMp4 = value; }

    @JsonProperty("original_still")
    public Downsized getOriginalStill() { return originalStill; }
    @JsonProperty("original_still")
    public void setOriginalStill(Downsized value) { this.originalStill = value; }

    @JsonProperty("preview")
    public DownsizedSmall getPreview() { return preview; }
    @JsonProperty("preview")
    public void setPreview(DownsizedSmall value) { this.preview = value; }

    @JsonProperty("preview_gif")
    public Downsized getPreviewGIF() { return previewGIF; }
    @JsonProperty("preview_gif")
    public void setPreviewGIF(Downsized value) { this.previewGIF = value; }

    @JsonProperty("preview_webp")
    public Downsized getPreviewWebp() { return previewWebp; }
    @JsonProperty("preview_webp")
    public void setPreviewWebp(Downsized value) { this.previewWebp = value; }
}
