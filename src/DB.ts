import Book from "./model/Book";

class DB {
    public getBooks(): Promise<Book[]> {
        return fetch('/api/books').then(response => {
            return response.json();
        }).then(books => {
            // tslint:disable-next-line:no-console
            return books.map((b: Book) => {
                return Object.assign(new Book(), b);
            });
        });
    }
}

export default DB;