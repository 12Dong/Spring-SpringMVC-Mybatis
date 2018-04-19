package com.hisen.entity;

public class ExBook {
    private String bookId;
    private String ISBN;
    private String location;
    private String status;
    private String managerId;
    private String readerId;
    private String renddate;
    private String returndate;

    private BookClass bookClass;

    public String getBookId() {
        return bookId;
    }

    public void setBookId(String bookId) {
        this.bookId = bookId;
    }

    public String getISBN() {
        return ISBN;
    }

    public void setISBN(String ISBN) {
        this.ISBN = ISBN;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getManagerId() {
        return managerId;
    }

    public void setManagerId(String managerId) {
        this.managerId = managerId;
    }

    public String getReaderId() {
        return readerId;
    }

    public void setReaderId(String readerId) {
        this.readerId = readerId;
    }

    public BookClass getBookClass() {
        return bookClass;
    }

    public String getRenddate() {
        return renddate;
    }

    public void setRenddate(String renddate) {
        this.renddate = renddate;
    }

    public String getReturndate() {
        return returndate;
    }

    public void setReturndate(String returndate) {
        this.returndate = returndate;
    }

    public void setBookClass(BookClass bookClass) {
        this.bookClass = bookClass;
    }

    @Override
    public String toString() {
        return "ExBook{" +
                "bookId='" + bookId + '\'' +
                ", ISBN='" + ISBN + '\'' +
                ", location='" + location + '\'' +
                ", status='" + status + '\'' +
                ", managerId='" + managerId + '\'' +
                ", readerId='" + readerId + '\'' +
                '}';
    }
}
