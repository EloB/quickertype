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

import { COMMON, SCENES, VERTEX } from "./landing-scenes.js";

/** Draws one scene on a canvas over its image; returns false if WebGL cannot. */
function animate(image, scene, place) {
    const canvas = document.createElement("canvas");
    canvas.className = image.classList.contains("hero-art") ? "hero-art live-art" : "live-art";
    canvas.setAttribute("aria-hidden", "true");
    const gl = canvas.getContext("webgl", { alpha: false, antialias: false, depth: false, stencil: false, powerPreference: "low-power" });
    if (gl === null) return false;
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
        return false;
    }
    gl.useProgram(program);
    gl.bindBuffer(gl.ARRAY_BUFFER, gl.createBuffer());
    gl.bufferData(gl.ARRAY_BUFFER, new Float32Array([-1, -1, 3, -1, -1, 3]), gl.STATIC_DRAW);
    gl.enableVertexAttribArray(0);
    gl.vertexAttribPointer(0, 2, gl.FLOAT, false, 0, 0);
    const size = gl.getUniformLocation(program, "R");
    const time = gl.getUniformLocation(program, "T");

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

    const fit = () => {
        const ratio = Math.min(window.devicePixelRatio || 1, 1.5) * scales[step];
        const width = Math.max(1, Math.round(canvas.clientWidth * ratio));
        const height = Math.max(1, Math.round(canvas.clientHeight * ratio));
        if (canvas.width !== width || canvas.height !== height) {
            canvas.width = width;
            canvas.height = height;
        }
    };
    const stop = () => {
        cancelAnimationFrame(request);
        request = 0;
        last = null;
    };
    const remove = () => {
        gone = true;
        stop();
        observer.disconnect();
        resized.disconnect();
        canvas.remove();
    };
    const frame = (now) => {
        request = 0;
        if (last !== null) {
            const elapsed = now - last;
            // A long gap (a background tab, a debugger) is a pause, not a slow frame.
            if (elapsed < 250) {
                seconds += elapsed / 1000;
                frames.push(elapsed);
            }
        }
        last = now;
        if (frames.length === 45) {
            const average = frames.reduce((a, b) => a + b) / frames.length;
            frames = [];
            if (average > 40) {
                if (step === scales.length - 1) return remove();
                step += 1;
            }
        }
        fit();
        gl.viewport(0, 0, canvas.width, canvas.height);
        gl.uniform2f(size, canvas.width, canvas.height);
        gl.uniform1f(time, seconds);
        gl.drawArrays(gl.TRIANGLES, 0, 3);
        if (!canvas.classList.contains("on")) {
            if (gl.getError() !== gl.NO_ERROR) return remove();
            canvas.classList.add("on");
        }
        if (visible && !motion.matches) request = requestAnimationFrame(frame);
    };
    const run = () => {
        if (!gone && request === 0 && visible && !motion.matches) request = requestAnimationFrame(frame);
    };
    const observer = new IntersectionObserver(
        ([entry]) => {
            visible = entry.isIntersecting;
            if (visible) run();
            else stop();
        },
        { rootMargin: "64px" },
    );
    const resized = new ResizeObserver(() => run());
    canvas.addEventListener("webglcontextlost", remove);
    motion.addEventListener("change", () => {
        canvas.classList.toggle("on", !motion.matches && canvas.classList.contains("on"));
        if (motion.matches) stop();
        else run();
    });
    place(canvas);
    observer.observe(canvas);
    resized.observe(canvas);
    return true;
}

const motion = matchMedia("(prefers-reduced-motion: reduce)");

/** Starts the scenes, and says on <html data-art> whether they run ("live") or why not. */
function start() {
    const root = document.documentElement;
    if (motion.matches) return void (root.dataset.art = "reduced-motion");
    if (navigator.connection?.saveData) return void (root.dataset.art = "save-data");
    for (const image of document.querySelectorAll("img[data-scene]")) {
        const scene = image.dataset.scene;
        if (!(scene in SCENES)) continue;
        // The hero's canvas is the image's sibling, with its class (its box
        // and mask); a section image's is laid over it in its frame.
        if (!animate(image, scene, (canvas) => image.after(canvas))) return void (root.dataset.art = "no-webgl");
    }
    root.dataset.art = "live";
}

// After the page has loaded and gone quiet: the images come first.
const later = (callback) => ("requestIdleCallback" in window ? requestIdleCallback(callback, { timeout: 1500 }) : setTimeout(callback, 200));
if (document.readyState === "complete") later(start);
else addEventListener("load", () => later(start), { once: true });
