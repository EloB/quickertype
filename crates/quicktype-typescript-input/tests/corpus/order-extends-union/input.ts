export interface Base { x: Q | P; }
export interface P { p: string }
export interface Q { q: string }
export interface D extends Base { y: P | Q | null; z: Q[] | P; }
