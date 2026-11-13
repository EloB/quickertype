// The one HTML escape the page uses, for text and attribute values alike.

const entities = { "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" };

export const escapeHtml = (s) => String(s).replace(/[&<>"]/g, (c) => entities[c]);
