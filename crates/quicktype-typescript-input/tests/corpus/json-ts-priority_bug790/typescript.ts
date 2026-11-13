export interface TopLevel {
    children_data: TopLevel[];
    id:            number;
    is_active:     boolean;
    level:         number;
    name:          string;
    parent_id:     number;
    position:      number;
    product_count: number;
}
