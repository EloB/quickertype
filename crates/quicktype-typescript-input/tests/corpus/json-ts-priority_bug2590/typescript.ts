export interface TopLevel {
    invoices: Invoice[];
}

export interface Invoice {
    createdAt: Date | null;
    dueDate:   Date | null;
    name:      string;
}
