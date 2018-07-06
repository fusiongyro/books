import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppComponent } from './app.component';
import { BookListComponent } from './book-list/book-list.component';
import { HttpClientModule} from "@angular/common/http";
import {
  MatButtonModule,
  MatInputModule,
  MatListModule,
  MatNavList,
  MatTableModule,
  MatToolbarModule
} from "@angular/material";
import {BrowserAnimationsModule} from "@angular/platform-browser/animations";
import { AppRoutingModule } from './app-routing.module';
import { LendFormComponent } from './lend-form/lend-form.component';
import {FormsModule} from "@angular/forms";
import {ModelModule} from "./model/model.module";

@NgModule({
  declarations: [
    AppComponent,
    BookListComponent,
    LendFormComponent,
  ],
  imports: [
    BrowserModule,
    BrowserAnimationsModule,
    FormsModule,
    HttpClientModule,
    MatTableModule, MatToolbarModule, MatListModule, MatInputModule, MatButtonModule,
    AppRoutingModule, ModelModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
