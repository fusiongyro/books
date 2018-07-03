class Book {
    public isbn: string;
    public title: string;
    public author: string;

    public get displayName() {
        return `${this.isbn}: ${this.title} by ${this.author}`;
    }
}

export default Book;