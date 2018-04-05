package com.hisen.entity;

/**
 * Created by hisen on 17-4-24.
 */
public class Book {
  private long bookId;
  private String name;
  private int number;
  private String detail;
  private String picId;
  private Pic pic;


  public Book() {
  }

  @Override
  public String toString() {
    return "Book{" +
        "bookId=" + bookId +
        ", name='" + name + '\'' +
        ", number=" + number +
        ", detail='" + detail + '\'' +
            ", picId='" + picId + '\'' +

            '}';
  }

  public Pic getPic() {
    return pic;
  }

  public void setPic(Pic pic) {
    this.pic = pic;
  }

  public String getPicId() {
    return picId;
  }

  public void setPicId(String picId) {
    this.picId = picId;
  }

  public long getBookId() {
    return bookId;
  }

  public void setBookId(long bookId) {
    this.bookId = bookId;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public int getNumber() {
    return number;
  }

  public void setNumber(int number) {
    this.number = number;
  }

  public String getDetail() {
    return detail;
  }

  public void setDetail(String detail) {
    this.detail = detail;
  }
}
