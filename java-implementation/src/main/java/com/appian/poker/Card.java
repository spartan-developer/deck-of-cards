package com.appian.poker;

public class Card {
  private Suit suit;
  private Rank rank;

  public Card(int cardNumber) {
    this.suit = Suit.values()[(cardNumber-1) / 13];
    this.rank = Rank.values()[(cardNumber-1) % 13];
  }

  public Suit getSuit() { return suit; }

  public Rank getRank() { return rank; }

  public String toString() {
    return rank + " of " + suit;
  }
}
