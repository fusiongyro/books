import Book from './Book';
import Person from './Person';

class Lend {
    private book: Book;
    private person: Person;
    private lentOn: Date;
    private returnedOn: Date;
}

export default Lend;