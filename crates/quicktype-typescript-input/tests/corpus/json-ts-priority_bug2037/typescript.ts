export interface TopLevel {
    mission_specs: { [key: string]: MissionSpec };
}

export interface MissionSpec {
    objectives: { [key: string]: Objective };
}

export interface Objective {
    rewards: { [key: string]: object };
}
