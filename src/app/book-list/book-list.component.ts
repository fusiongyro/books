import { Component, OnInit } from '@angular/core';
import { HttpClient } from "@angular/common/http";
import {Book} from "../book";

@Component({
  selector: 'book-list',
  templateUrl: './book-list.component.html',
  styleUrls: ['./book-list.component.css']
})
export class BookListComponent implements OnInit {
  books: Array<Book>;
  columnsToDisplay = ['isbn', 'title', 'author'];

  constructor(private http: HttpClient) { }

  ngOnInit() {
    this.http.get<Array<Book>>('/api/books').subscribe(data => this.books = data);
  }

}
