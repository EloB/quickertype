export interface Node { value: number; children: Node[]; parent?: Node | null; }
export type Tree = { left?: Tree; right?: Tree; v: string };
