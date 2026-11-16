// The landing page's three images, alive: each gets a WebGL canvas over it
// that draws the same scene, moving, in the image's colours.
//
// - speed-trails (the hero): two light trails racing. quickertype's violet
//   trail overtakes quicktype's slower blue one, again and again.
// - thanks-threads: threads twisting together into one cord, which turns.
// - parity-mirror: two glass lattices turning as exact mirror images of
//   each other, either side of a line of light that a pulse runs along.
//
// The images stay. They are the first paint, and what anyone sees without
// WebGL, with reduced motion or Save-Data, or on a device too slow to draw
// the scene (a canvas lowers its resolution first, then gives up and is
// removed). A canvas fades in over its image after its first frame, and
// draws only while it is on screen and the page is visible.
//
// <html data-art> says what happened: "live" while a scene draws; else why
// none does: "reduced-motion", "save-data", "no-webgl" (no WebGL, or none
// with highp floats in fragment shaders, which the scenes need), "failed"
// (a scene's shader did not compile), and once the last canvas has gone,
// "too-slow" or "context-lost".

import { COMMON, SCENES, VERTEX } from "./landing-scenes.js";

const root = document.documentElement;
const motion = matchMedia("(prefers-reduced-motion: reduce)");
/** The canvases that draw a scene. */
const live = new Set();

/** A WebGL context the scenes can draw with, or null. */
function context(canvas) {
    const gl = canvas.getContext("webgl", { alpha: false, antialias: false, depth: false, stencil: false, powerPreference: "low-power" });
    if (gl === null) return null;
    const high = gl.getShaderPrecisionFormat(gl.FRAGMENT_SHADER, gl.HIGH_FLOAT);
    if (high === null || high.precision === 0) {
        gl.getExtension("WEBGL_lose_context")?.loseContext();
        return null;
    }
    return gl;
}

/** Draws `scene` on a canvas after `image`: "live", "no-webgl" or "failed". */
function animate(image, scene) {
    const canvas = document.createElement("canvas");
    // The hero's canvas takes the image's class (its box and its mask); a
    // section image's is laid over it in its frame (.art-frame).
    canvas.className = image.classList.contains("hero-art") ? "hero-art live-art" : "live-art";
    canvas.setAttribute("aria-hidden", "true");
    const gl = context(canvas);
    if (gl === null) return "no-webgl";
    const program = gl.createProgram();
    for (const [type, source] of [
        [gl.VERTEX_SHADER, VERTEX],
        [gl.FRAGMENT_SHADER, COMMON + SCENES[scene]],
    ]) {
        const shader = gl.createShader(type);
        gl.shaderSource(shader, source);
        gl.compileShader(shader);
        gl.attachShader(program, shader);
    }
    gl.bindAttribLocation(program, 0, "a");
    gl.linkProgram(program);
    if (!gl.getProgramParameter(program, gl.LINK_STATUS)) {
        gl.getExtension("WEBGL_lose_context")?.loseContext();
        return "failed";
    }
    gl.useProgram(program);
    gl.bindBuffer(gl.ARRAY_BUFFER, gl.createBuffer());
    gl.bufferData(gl.ARRAY_BUFFER, new Float32Array([-1, -1, 3, -1, -1, 3]), gl.STATIC_DRAW);
    gl.enableVertexAttribArray(0);
    gl.vertexAttribPointer(0, 2, gl.FLOAT, false, 0, 0);
    const sizeAt = gl.getUniformLocation(program, "R");
    const timeAt = gl.getUniformLocation(program, "T");

    // The resolution steps down while frames take too long, and the canvas
    // gives up below the last step.
    const scales = [1, 0.75, 0.5];
    let step = 0;
    let frames = [];
    let seconds = 0;
    let last = null;
    let request = 0;
    let visible = false;
    let gone = false;
    // The canvas's size in CSS pixels, from the ResizeObserver.
    let cssWidth = 0;
    let cssHeight = 0;
    const listening = new AbortController();

    const stop = () => {
        cancelAnimationFrame(request);
        request = 0;
        last = null;
    };
    const remove = (why) => {
        if (gone) return;
        gone = true;
        stop();
        observer.disconnect();
        resized.disconnect();
        listening.abort();
        gl.getExtension("WEBGL_lose_context")?.loseContext();
        canvas.remove();
        live.delete(canvas);
        if (live.size === 0) root.dataset.art = why;
    };
    const frame = (now) => {
        request = 0;
        if (last !== null) {
            // A frame counts at most 250 ms against the device (a debugger's
            // pause is not a slow device) and moves the scene at most 100 ms.
            const elapsed = now - last;
            frames.push(Math.min(elapsed, 250));
            seconds += Math.min(elapsed, 100) / 1000;
        }
        last = now;
        if (frames.length === 45) {
            const average = frames.reduce((a, b) => a + b) / frames.length;
            frames = [];
            if (average > 40) {
                if (step === scales.length - 1) return remove("too-slow");
                step += 1;
            }
        }
        const ratio = Math.min(window.devicePixelRatio || 1, 1.5) * scales[step];
        const width = Math.max(1, Math.round(cssWidth * ratio));
        const height = Math.max(1, Math.round(cssHeight * ratio));
        if (canvas.width !== width || canvas.height !== height) {
            canvas.width = width;
            canvas.height = height;
        }
        gl.viewport(0, 0, width, height);
        gl.uniform2f(sizeAt, width, height);
        gl.uniform1f(timeAt, seconds);
        gl.drawArrays(gl.TRIANGLES, 0, 3);
        if (!canvas.classList.contains("on")) {
            if (gl.getError() !== gl.NO_ERROR) return remove("failed");
            canvas.classList.add("on");
        }
        if (visible && !motion.matches) request = requestAnimationFrame(frame);
    };
    const run = () => {
        if (!gone && request === 0 && visible && !motion.matches && cssWidth > 0) request = requestAnimationFrame(frame);
    };
    const observer = new IntersectionObserver(
        ([entry]) => {
            visible = entry.isIntersecting;
            if (visible) run();
            else stop();
        },
        { rootMargin: "64px" },
    );
    const resized = new ResizeObserver(([entry]) => {
        cssWidth = entry.contentRect.width;
        cssHeight = entry.contentRect.height;
        run();
    });
    canvas.addEventListener("webglcontextlost", () => remove("context-lost"), { signal: listening.signal });
    // A hidden tab gets no frames; the time it was hidden is not a frame.
    document.addEventListener("visibilitychange", () => document.hidden && (last = null), { signal: listening.signal });
    motion.addEventListener(
        "change",
        () => {
            if (motion.matches) {
                canvas.classList.remove("on");
                stop();
            } else run();
        },
        { signal: listening.signal },
    );
    image.after(canvas);
    live.add(canvas);
    observer.observe(canvas);
    resized.observe(canvas);
    return "live";
}

function start() {
    if (motion.matches) return void (root.dataset.art = "reduced-motion");
    if (navigator.connection?.saveData) return void (root.dataset.art = "save-data");
    let why = "no-webgl";
    for (const image of document.querySelectorAll("img[data-scene]")) {
        if (!(image.dataset.scene in SCENES)) continue;
        const result = animate(image, image.dataset.scene);
        if (result === "no-webgl") break;
        if (result === "failed") why = "failed";
    }
    root.dataset.art = live.size > 0 ? "live" : why;
}

// After the page has loaded and gone quiet: the images come first.
const later = (callback) => ("requestIdleCallback" in window ? requestIdleCallback(callback, { timeout: 1500 }) : setTimeout(callback, 200));
if (document.readyState === "complete") later(start);
else addEventListener("load", () => later(start), { once: true });
