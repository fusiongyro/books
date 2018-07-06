import { Injectable } from '@angular/core';
import {Observable} from "rxjs/internal/Observable";
import {map} from "rxjs/operators";
import {HttpClient} from "@angular/common/http";
import {Book, Lend} from "./model/model.module";

@Injectable({
  providedIn: 'root'
})
export class DBService {

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
