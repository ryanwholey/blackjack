assert = chai.assert

deck = null

describe "Card Model", ->

  beforeEach -> deck = new Deck()

  it "should create a card collection", ->
    assert.strictEqual deck.length, 52

  it "should change revealed property on flip()", ->
    deck.at(0).flip()
    assert.equal deck.at(0).attributes.revealed, false

  it "should expect cards to hold appropriate scoring values", ->
    card1 = new Card({suit:'heart', rank:3})
    card2 = new Card({suit:'diamond', rank:1})
    card3 = new Card({suit:'spade', rank:0})
    assert.equal card1.attributes.value, 3
    assert.equal card2.attributes.value, 1
    assert.equal card3.attributes.value, 10

  it "should expect cards to hold appropriate rank names", ->
    card1 = new Card({suit:'heart', rank:3})
    card2 = new Card({suit:'diamond', rank:1})
    card3 = new Card({suit:'spade', rank:0})
    assert.equal card1.attributes.rankName, 3
    assert.equal card2.attributes.rankName, 'Ace'
    assert.equal card3.attributes.rankName, 'King'
