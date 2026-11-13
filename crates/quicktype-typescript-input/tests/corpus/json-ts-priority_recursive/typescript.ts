export interface TopLevel {
    category:              Category;
    details:               Details;
    match:                 string;
    page:                  number;
    product:               ProductElement[];
    schk:                  boolean;
    totallooseoffers:      number;
    totalpages:            number;
    totalresultsavailable: number;
    totalresultsreturned:  number;
}

export interface Category {
    concatenatecategoryname: boolean;
    hasoffer:                boolean;
    id:                      number;
    isfinal:                 boolean;
    links:                   LinkElement[];
    name:                    string;
    parentcategoryid:        number;
    thumbnail:               CategoryThumbnail;
}

export interface LinkElement {
    link: LinkLink;
}

export interface LinkLink {
    type: string;
    url:  string;
}

export interface CategoryThumbnail {
    url: string;
}

export interface Details {
    applicationid:      string;
    applicationversion: string;
    code:               number;
    date:               DateClass;
    elapsedtime:        number;
    message:            string;
    status:             string;
}

export interface DateClass {
    day:           number;
    eonandyear:    Eonandyear;
    hour:          number;
    millisecond:   number;
    minute:        number;
    month:         number;
    second:        number;
    timezone:      number;
    valid:         boolean;
    xmlschematype: Xmlschematype;
    year:          number;
}

export interface Eonandyear {
    lowestsetbit: number;
}

export interface Xmlschematype {
    localpart:    string;
    namespaceuri: string;
    prefix:       string;
}

export interface ProductElement {
    product: ProductProduct;
}

export interface ProductProduct {
    categoryid:      number;
    currency:        Currency;
    eco:             boolean;
    fulldescription: boolean;
    hasmetasearch:   boolean;
    id:              number;
    links:           LinkElement[];
    numoffers:       number;
    pricemax:        string;
    pricemin:        string;
    productname:     string;
    quantity:        number;
    rating:          Rating;
    specification:   Specification;
    thumbnail:       FormatsClass;
    totalsellers:    number;
}

export interface Currency {
    abbreviation: string;
}

export interface Rating {
    useraveragerating: Useraveragerating;
}

export interface Useraveragerating {
    links:       LinkElement[];
    numcomments: number;
    rating:      string;
}

export interface Specification {
    links: LinkElement[];
}

export interface Format {
    formats: FormatsClass;
}

export interface FormatsClass {
    formats?: Format[];
    height:   number;
    url:      string;
    width:    number;
}
