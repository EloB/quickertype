interface Point { x: number; y: number }
type Line = { from: Point; to: Point };
interface Shape { lines: Line[] }
