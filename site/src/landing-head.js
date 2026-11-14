// Inlined in the landing page's head by the build (site/build.mjs), so that it
// runs before anything paints; a Content-Security-Policy allows it by its
// hash, which the build prints.
//
// The playground used to be the site's root, and the links shared from it
// carry its state in the hash (#v=2&l=typescript&s=pokedex). Such a link goes
// on to the playground, now at app/, with the same hash. The landing page's
// own anchors (#thanks) have no "=" in them; the build makes sure of that.

if (location.hash.includes("=")) {
    document.documentElement.style.display = "none";
    location.replace(`app/${location.hash}`);
}
