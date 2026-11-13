export interface TopLevel {
    total_population: TotalPopulation[];
}

export interface TotalPopulation {
    date:       Date;
    population: number;
}
