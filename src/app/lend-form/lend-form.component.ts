import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-lend-form',
  templateUrl: './lend-form.component.html',
  styleUrls: ['./lend-form.component.css']
})
export class LendFormComponent implements OnInit {
  public isbn: string;
  public email: string;

  constructor() { }

  ngOnInit() {
  }

}
