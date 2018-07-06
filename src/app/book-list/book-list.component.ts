import { Component, OnInit } from '@angular/core';
import { HttpClient } from "@angular/common/http";
import {DBService} from "../db.service";
import {Book} from "../model/model.module";

@Component({
  selector: 'book-list',
  templateUrl: './book-list.component.html',
  styleUrls: ['./book-list.component.css']
})
export class BookListComponent implements OnInit {
  books: Array<Book>;
  columnsToDisplay = ['isbn', 'title', 'author'];

  constructor(private db: DBService) { }

  ngOnInit() {
    this.db.allBooks().subscribe(data => this.books = data);
  }
}
