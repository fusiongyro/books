import { Component, OnInit } from '@angular/core';
import { HttpClient } from "@angular/common/http";
import {Book} from "../book";
import DB from "../lib/dao";

@Component({
  selector: 'book-list',
  templateUrl: './book-list.component.html',
  styleUrls: ['./book-list.component.css']
})
export class BookListComponent implements OnInit {
  books: Array<Book>;
  columnsToDisplay = ['isbn', 'title', 'author'];

  constructor(private db: DB) { }

  ngOnInit() {
    this.db.allBooks().subscribe(data => this.books = data);
  }
}
