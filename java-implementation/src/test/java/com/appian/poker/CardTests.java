package com.appian.poker;
import org.junit.*;
import org.junit.Assert;

public class CardTests {
  Deck deck;

  @Before
  public void setup() { deck = new Deck(); }
  
  // Card

  @Test
  public void instantiatingCardWith1through52DeterminesRankAndSuit() {
    Card card1 = new Card(1);
    Assert.assertEquals(card1.getSuit(), Suit.Clubs);
    Assert.assertEquals(card1.getRank(), Rank.Ace);
    Card card52 = new Card(52);
    Assert.assertEquals(card52.getSuit(), Suit.Spades);
    Assert.assertEquals(card52.getRank(), Rank.King);
  }

  @Test
  public void cardToStringProducesRankOfSuit() {
    Card card = new Card(15);
    Assert.assertEquals(card.toString(), "Two of Diamonds");
  }

  // Deck
  
  @Test
  public void aNewDeckComesWithCardsInSortedOrder() throws EmptyDeckException {
    Card card = deck.dealOneCard();
    Assert.assertEquals(card.toString(), "Ace of Clubs");
    card = deck.dealOneCard();
    Assert.assertEquals(card.toString(), "Two of Clubs");
    card = deck.dealOneCard();
    Assert.assertEquals(card.toString(), "Three of Clubs");
    card = deck.dealOneCard();
    Assert.assertEquals(card.toString(), "Four of Clubs");
  }

  @Test
  public void deckIsEmptyAfterAllCardsDrawn() throws EmptyDeckException {
    Assert.assertFalse(deck.isEmpty());
    for (int i = 0; i < 52; i++) deck.dealOneCard();
    Assert.assertTrue(deck.isEmpty());
  }

  @Test(expected = EmptyDeckException.class)
  public void dealOneCardThrowsIfDeckEmpty() throws EmptyDeckException {
    for (int i = 0; i < 52; i++) deck.dealOneCard();
    deck.dealOneCard();
  }

  @Test
  public void shufflingDoesntChangeNumCardsRemaining() throws EmptyDeckException {
    for (int i = 0; i < 10; i++) deck.dealOneCard();
    Assert.assertEquals(deck.cardsRemaining(), 42);
  }

  @Test
  public void canDrawAfterResettingEmptyDeck() throws EmptyDeckException {
    for (int i = 0; i < 52; i++) deck.dealOneCard();
    deck.reset();
    Assert.assertEquals(deck.cardsRemaining(), 52);
    deck.dealOneCard();
  }
}
