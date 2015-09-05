assert = chai.assert

describe 'Deck', ->
  deck = null
  playerHand = null

  beforeEach ->
    deck = new Deck()
    playerHand = deck.dealPlayer()
    
  describe 'Dealing', ->
    it 'should deal two cards to the player at the start of a game, with both cards revealed', ->
      assert.equal playerHand.length, 2
      assert.equal playerHand.at(0).attributes.revealed, true
      assert.equal playerHand.at(1).attributes.revealed, true

    it 'should deal two cards to the dealer at the start of a game, with one card revealed', ->
      dealerHand = deck.dealDealer()
      assert.equal dealerHand.length, 2
      assert.equal dealerHand.at(0).attributes.revealed, false
      assert.equal dealerHand.at(1).attributes.revealed, true

  describe 'Hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 50
      assert.strictEqual deck.last(), playerHand.hit()
      assert.strictEqual deck.length, 49

    xit 'it should use a new deck if a player or dealer hits when all cards have been exhausted'
    #check if a new deck is used when cards in old deck are exhausted

  xdescribe 'Single Deck', ->
    it 'should use the same deck between games until all cards have been exhausted'
    #check if using the same deck after a game


#checks to see if cards are dealt properly to player (2 cards, both revealed)
#checks to see if cards are dealt properly to dealer (2 cards, one revealed)