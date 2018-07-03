import * as React from 'react';
import './App.css';
import DB from './DB';
import Book from './model/Book';

import logo from './logo.svg';

class App extends React.Component<{}, {books: Book[]}> {
    private db: DB;

    constructor(props: any) {
        super(props);
        this.db = new DB();
        this.state = {books: []};
        this.db.getBooks().then(books => this.setState({books}));
    }

  public render() {
    return (
      <div className="App">
        <header className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <h1 className="App-title">Welcome to React</h1>
        </header>
          <pre>{JSON.stringify(this.state.books)}</pre>
          <ul>{this.state.books.map(book => <li key={book.isbn}>{book.displayName}</li>)}</ul>
        <p className="App-intro">
          To get started, edit <code>src/App.tsx</code> and save to reload.
        </p>
      </div>
    );
  }
}

export default App;
