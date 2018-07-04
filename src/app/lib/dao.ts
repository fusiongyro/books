import {Book, Lend} from "./model";
import {HttpClient} from "@angular/common/http";
import {Injectable} from "@angular/core";
import {map} from "rxjs/operators";
import {Observable} from "rxjs/internal/Observable";

@Injectable({providedIn: 'root'})
class DB {
  constructor(private http: HttpClient) { }

  allLends(): Observable<Lend[]> {
    return this.http.get<Lend[]>('/api/lends_detail')
      .pipe(map(lends =>
        lends.map(lend => Object.assign(new Lend(), lend))));
  }

  allBooks(): Observable<Book[]> {
    return this.http.get<Book[]>('/api/books')
      .pipe(map(books => books.map(book => Object.assign(new Book(), book))));
  }
}

export default DB;
