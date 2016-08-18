# iOS Swift Assessment: Core Data

## Instructions

* Fork and clone this repository. Your final result will be submitted as a pull request to the `learn-students` repository.
* Your app should persistently store authors and books, and you'll have to set up those relationships in your `xcdatamodeld`. Each book has one author, but each author may have multiple books.
* Create in your `DataStore` class a function named `generateTestData`, which inserts the following books and authors into your data store:
  * *The Swift Programming Language* by Apple Inc.
  * *Hacking with Swift* and *Pro Swift* by Paul Hudson
  * *Advanced Swift* by Chris Eidhof
* Impement a `fetchData` function which is able to access the data store and fulfill the following step.
* In your `AppDelegate` file, retrieve and print to your console log the authors in your data store, along with the books they've written.
* Bask in the glory of your Core Data-enabled app!
