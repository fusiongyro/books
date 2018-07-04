class Book {
  isbn:   string;
  title:  string;
  author: string;
}

class Person {
  name:  string;
  email: string;
}

class Lend {
  book:        Book;
  borrower:    Person;
  lent_on:     Date;
  returned_on: Date;
}

export {Book, Person, Lend};
