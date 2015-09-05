assert = chai.assert
    
deck = null
playerHand = null
dealerHand = null

describe "Hand Model", ->

  beforeEach -> 
    deck = new Deck()
    playerHand = deck.dealPlayer()
    dealerHand = deck.dealDealer()

  it "should remove a card from the deck when either the player or the dealer chooses to hit", ->
    playerHand.hit()
    assert.equal deck.length, 47
    dealerHand.hit()
    assert.equal deck.length, 46

  it "should add a card to the player or the dealer's hand when they choose to hit", ->
    cardDrawn = playerHand.hit()
    assert.equal playerHand.length, 3
    assert.strictEqual cardDrawn, playerHand.last()
    cardDrawn2 = dealerHand.hit()
    assert.equal dealerHand.length, 3
    assert.strictEqual cardDrawn2, dealerHand.last()

  it "should trigger a 'stand' event when the player chooses to stand", ->
    spy = sinon.spy playerHand, 'trigger'
    playerHand.stand()
    assert.equal playerHand.trigger.calledWith('stand'), true

  it "should calculate a score for the player's total hand", ->
    card1 = new Card({suit:'heart', rank:5})
    card2 = new Card({suit:'diamond', rank:7})
    card3 = new Card({suit:'club', rank:11})
    hand = new Hand([card1, card2], deck)
    hand.add(card3)
    assert.equal hand.scores()[0], 22

  it "should keep track of two possible scores if the hand contains an ace", ->
    card1 = new Card({suit:'heart', rank:3})
    card2 = new Card({suit:'diamond', rank:1})
    hand = new Hand([card1, card2], deck)
    assert.deepEqual hand.scores(), [4, 14]

  it "should calculate a minimum score of two possible scores if the hand contains an ace", ->
    card1 = new Card({suit:'heart', rank:5})
    card2 = new Card({suit:'diamond', rank:1})
    hand = new Hand([card1, card2], deck)
    assert.equal hand.minScore(), 6

  it "should calculate the highest score that is not a bust if the hand contains an ace", ->
    card1 = new Card({suit:'heart', rank:5})
    card2 = new Card({suit:'diamond', rank:1})
    card3 = new Card({suit:'club', rank:9})
    hand = new Hand([card1, card2], deck)
    assert.equal hand.bestScore(), 16
    hand.add(card3)
    assert.equal hand.bestScore(), 15