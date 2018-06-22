import { Routes, RouterModule, RouterOutlet } from '@angular/router';
import { NgModule } from '@angular/core';
import { BookListComponent } from "./book-list/book-list.component";

const routes: Routes = [
  { path: 'books', component: BookListComponent}
];


@NgModule({
  imports: [
    RouterModule.forRoot(routes)
  ],
  declarations: [],
  exports: [ RouterModule ]
})
export class AppRoutingModule { }
