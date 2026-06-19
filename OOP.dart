// ignore_for_file: unused_local_variable, unused_import, unused_element, unused_field
import 'dart:io';

// Library

// This project is currently under development.

// Current Progress:
// - Basic structure implemented
// - Core functionality partially completed

// ## Purpose:
// This project is part of my learning journey in [Dart / Mobile development].

class Book {
  String title;
  String author;
  double price;
  int amount;

  Book(this.title, this.author, this.price, this.amount);
}

class User {
  String name;
  String id;

  List<BookCopy> borrowedBooks = [];

  User(this.name, this.id);
}

class BookCopy {
  Book book;
  User? borrowedBy;

  BookCopy(this.book);
}

class LibraryManager {
  List<Book> books = [];
  List<User> users = [];
  List<BookCopy> copies = [];

  void addBook(
    String title,
    String author,
    double price,
    int amount,
  ) {
    if (books.any((b) => b.title == title)) {
      print("Book already exists!");
      return;
    }

    Book book = Book(title, author, price, amount);

    books.add(book);

    for (int i = 0; i < amount; i++) {
      copies.add(BookCopy(book));
    }

    print("Book added successfully");
  }

  void addUser(String name, String id) {
    if (users.any((u) => u.id == id)) {
      print("User already exists!");
      return;
    }

    users.add(User(name, id));

    print("User added successfully");
  }

  void editBook(String title) {
    var book = books.where((b) => b.title == title).firstOrNull;

    if (book == null) {
      print("Book doesn't exist.");
      return;
    }

    print("Enter new title:");
    String? newTitle = stdin.readLineSync();

    print("Enter new author:");
    String? newAuthor = stdin.readLineSync();

    print("Enter new price:");
    String? priceInput = stdin.readLineSync();

    double? newPrice = double.tryParse(priceInput ?? '');

    if (newTitle == null ||
        newAuthor == null ||
        newPrice == null) {
      print("Invalid data.");
      return;
    }

    if (books.any((b) => b.title == newTitle && b != book)) {
      print("Another book already has this title.");
      return;
    }

    book.title = newTitle;
    book.author = newAuthor;
    book.price = newPrice;

    print("Book edited successfully");
  }

  void deleteBook(String title) {
    var book = books.where((b) => b.title == title).firstOrNull;

    if (book == null) {
      print("Book not found.");
      return;
    }

    books.remove(book);

    copies.removeWhere((c) => c.book == book);

    print("Book deleted successfully");
  }

  void deleteUser(String id) {
    var user = users.where((u) => u.id == id).firstOrNull;

    if (user == null) {
      print("User not found.");
      return;
    }

    // إرجاع كل الكتب تلقائيًا قبل الحذف
    for (var copy in user.borrowedBooks) {
      copy.borrowedBy = null;
    }

    users.remove(user);

    print("User deleted successfully");
  }

  void showBooks() {
    if (books.isEmpty) {
      print("No books found.");
      return;
    }

    int x = 1;

    for (var book in books) {
      int availableCopies = copies
          .where((c) =>
              c.book == book &&
              c.borrowedBy == null)
          .length;

      int borrowedCopies = copies
          .where((c) =>
              c.book == book &&
              c.borrowedBy != null)
          .length;

      print("""
$x)
Title: ${book.title}
Author: ${book.author}
Price: ${book.price}

Total copies: ${book.amount}
Available: $availableCopies
Borrowed: $borrowedCopies

-------------------
""");

      x++;
    }
  }

  void showUsers() {
    if (users.isEmpty) {
      print("No users found.");
      return;
    }

    int x = 1;

    for (var user in users) {
      print("""
$x)
Name: ${user.name}
ID: ${user.id}
Borrowed books: ${user.borrowedBooks.length}

-------------------
""");

      x++;
    }
  }

  void searchBook(String title) {
    var book = books.where((b) => b.title == title).firstOrNull;

    if (book == null) {
      print("Book doesn't exist.");
      return;
    }

    int availableCopies = copies
        .where((c) =>
            c.book == book &&
            c.borrowedBy == null)
        .length;

    print("""
Title: ${book.title}
Author: ${book.author}
Price: ${book.price}

Available copies: $availableCopies
""");
  }

  void borrowBook(String userId, String title) {
    var user = users
        .where((u) => u.id == userId)
        .firstOrNull;

    if (user == null) {
      print("User doesn't exist.");
      return;
    }

    bool alreadyBorrowed = user.borrowedBooks.any(
      (c) => c.book.title == title,
    );

    if (alreadyBorrowed) {
      print("You already borrowed this book.");
      return;
    }

    var copy = copies
        .where((c) =>
            c.book.title == title &&
            c.borrowedBy == null)
        .firstOrNull;

    if (copy == null) {
      print("No available copies.");
      return;
    }

    copy.borrowedBy = user;

    user.borrowedBooks.add(copy);

    print("Book borrowed successfully.");
  }

  void returnBook(String userId, String title) {
    var user = users
        .where((u) => u.id == userId)
        .firstOrNull;

    if (user == null) {
      print("User doesn't exist.");
      return;
    }

    var copy = user.borrowedBooks
        .where((c) => c.book.title == title)
        .firstOrNull;

    if (copy == null) {
      print("You didn't borrow this book.");
      return;
    }

    copy.borrowedBy = null;

    user.borrowedBooks.remove(copy);

    print("Book returned successfully.");
  }
}

void main() {

}
