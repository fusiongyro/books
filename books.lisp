;; This is a story about my books.
;;
;; We begin with a Book Buddy file to import. Book Buddy files look like this:
;;
;; Uploaded Image URL,Author,"Author (Last, First)",Title,Subtitle,Genre,Rating,Loaned To,Date Loaned,Borrowed From,Date Borrowed,Publisher,Status,Notes,Edition,Date Published,Length,Format,Dimensions,Weight,ISBN,Physical Location,Date Added,Date Started,Date Finished,Purchase Date,Purchase Place,Purchase Price,List Price,Google VolumeID,Favorites,Wish List,Category,Series,Volume,Quantity,Summary,Tags
;; ,Editors of the American Heritage Dictionaries,"Dictionaries, Editors of the American Heritage",100 Words for Lovers,,Reference,0,,,,,Houghton Mifflin Harcourt,Unread,,,,,,,,9780547212579,,2014/03/02,,,,,,,9Fi-BfAGnooC,0,0,,,,,,
;;
;;
;; This is a bit on the disgusting side. Most of these fields are
;; blank or have garbage data. I really only want the title, author
;; and ISBN. These turn out to be fields 3, 1 and 20 respectively.
;;
;; Let's build a pretty simple database to hold this. Let's use
;; Postmodern.
(ql:quickload :postmodern)
(use-package :postmodern)

;; Let's connect.
(connect-toplevel "books" "dlyons" "" "localhost")

;; Let's define a book with the three parameters we need: title,
;; author, isbn
(defclass book ()
  ((title  :col-type string :initarg :title  :accessor book-title)
   (author :col-type string :initarg :author :accessor book-author)
   (isbn   :col-type isbn13 :initarg :isbn   :accessor book-isbn))
  (:metaclass dao-class)
  (:keys isbn)
  (:table-name books))

(defmethod print-object ((book book) out)
  (print-unreadable-object (book out :type t)
    (format out
	    "ISBN=~s TITLE=~a AUTHOR=~a"
	    (book-isbn book)
	    (book-title book)
	    (book-author book))))

(defun make-book (isbn &key title author)
  (make-instance 'book :isbn isbn :title title :author author))

;; Let's make the table now
;; (execute (dao-table-definition 'book))

;; Let's try making a sample book just to see what happens
;; (insert-dao
;;  (make-book "9781617290657"
;; 	    :title "Functional Programming in Scala"
;; 	    :author "Paul Chiusano and Rúnar Bjarnason"))

;; Let's try and fetch it for fun.
(do-select-dao (('book book))
  (format t "Found book: ~a~%" book))

;; This is pretty awesome.

;; OK, now let's go ahead and make a relation for book loans
(defclass loan ()
  ((id          :col-type serial    :initarg :id          :accessor load-id)
   (isbn        :col-type isbn13    :initarg :isbn        :accessor loan-isbn)
   (borrower    :col-type string    :initarg :borrower    :accessor loan-borrower)
   (borrowed-at :col-type timestamp :initarg :borrowed-at :accessor loan-borrowed-at)
   (returned-at :col-type (or db-null timestamp) :initarg :returned-at :accessor returned-at :col-default :null))
  (:metaclass dao-class)
  (:keys id)
  (:table-name loans))

(defmethod print-object ((loan loan) out)
  (with-slots (isbn borrower borrowed-at returned-at) loan
    (print-unreadable-object (loan out)
      (format out
	      "BOOK=~A BORROWER=~A BORROWED-AT=~A RETURNED-AT=~A"
	      isbn borrower borrowed-at returned-at))))

;; (execute "DROP TABLE loans")
;; (execute (dao-table-definition 'loan))
;; (execute "ALTER TABLE loans ADD FOREIGN KEY (isbn) REFERENCES books")

;; Let's make a convenient way to prepare book loans
(defun loan-book (book &key to on)
  (let ((loan (make-instance 'loan :isbn (book-isbn book) :borrower to :borrowed-at on)))
    (insert-dao loan)))

;; (loan-book "Functional Programming in Scala" :to "Max Spolaor" :email "<mspolaor@nrao.edu>" :on "2015-11-04
;; (loan-book (get-dao 'book "978-1-61729-065-7") :to "Max Spolaor <mspolaor@nrao.edu>" :on "2015-11-04")
;; we should eve
;; Now let's go ahead and figure out reading in the book buddy file
(ql:quickload "cl-csv")

(defun import-from-bookbuddy (file)
 (with-transaction ()
   (loop
      for row in (cl-csv:read-csv file)
      when (parse-integer (nth 20 row) :junk-allowed t)
      do (insert-dao (make-book (nth 20 row) :title (nth 3 row) :author (nth 1 row))))))

;; This seems to work!
;; (import-from-bookbuddy #P"~/BookBuddy.csv")

;; Now we need to work out returning a book.
;; Obviously it should look something like this:
; (return-book (get-dao 'book "978-1-61729-065-7"))

(defun return-book (book)
  (with-transaction ()
    (execute (:update 'books
		      :set 'returned-on (:now)
		      :where (:= 'isbn (book-isbn book))))))

(return-book (get-dao 'book "978-1-61729-065-7"))
