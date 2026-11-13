export interface Node { kids: (Node | Leaf)[]; parent: Leaf | Node | null; }
export interface Leaf { v: string }
