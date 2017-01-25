package com.appian.poker;

import java.util.Random;

public class Deck {
  private final int NUM_CARDS = 52;
  private Card[] deck = new Card[NUM_CARDS];
  private int index = 0;
  private Random random = new Random();

  public Deck() {
    for (int i = 1; i <= NUM_CARDS; i++)
      deck[i-1] = new Card(i); 
  }  

  public Card dealOneCard() throws EmptyDeckException {
    if (isEmpty())
      throw new EmptyDeckException("The deck is empty");
    return deck[index++];
  }

  public boolean isEmpty() {
    return index >= deck.length;
  }

  public int cardsRemaining() {
    return NUM_CARDS - index;
  }

  /* Implements the Fisher–Yates shuffle algorithm */
  public void shuffle() {
    for (int i = index; i <= NUM_CARDS - 2; i++) {
      int j = random.nextInt(NUM_CARDS - i) + i; 
      Card temp = deck[i];
      deck[i] = deck[j];
      deck[j] = temp;
    }
  }

  public void reset() {
    index = 0;
    shuffle();
  }
}
