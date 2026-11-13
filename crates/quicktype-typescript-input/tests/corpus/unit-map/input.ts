export interface Env {
    flags: Map<string, boolean>;
    services: Map<string, Service>;
    nested: ReadonlyMap<string, Map<string, number>>;
}

export interface Service {
    url: string;
}
