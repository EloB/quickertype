/**
 * The root type. #TopLevel
 */
export interface Root {
    id: number;
    child: Child;
}

export interface Child {
    label: string;
}
