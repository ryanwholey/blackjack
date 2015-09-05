
assert = chai.assert

appView = new AppView(model: new App())

describe 'App Views',->
  it "should render a representation of the player hand in the form of a player container and player hand",->
    assert.ok $('.player-hand-container .hand'), true

  it "should render a representation of the dealer hand in the form of a dealer container and dealer hand",->
    assert.ok $('.dealer-hand-container .hand'), true

describe 'Dealer Logic',->
  beforeEach ->
    card1 = new Card({suit:'heart', rank:10})
    card2 = new Card({suit:'diamond', rank:4})
    console.log(appView.model)
    appView.model.set 'dealerHand', new Hand([card1, card2], appView.model.get('deck'), true)

  it "should have the dealer stand when it has a hand value of 17 or higher", ->
    card3 = new Card({suit:'clubs', rank:2})
    card4 = new Card({suit:'spades', rank:3})
    appView.model.set 'playerHand', new Hand([card3, card4], appView.model.get('deck'), false)
    dealerHand = appView.model.get('dealerHand')
    playerHand = appView.model.get('playerHand')
    dealerHand.at(0).flip()
    spy = sinon.spy dealerHand, 'stand'
    card5 = new Card({suit:'spade', rank:3})
    appView.model.get('deck').push(card5)
    assert.equal dealerHand.stand.calledOnce, false
    appView.dealerPlay()
    assert.equal dealerHand.stand.calledOnce, true
    assert.deepEqual dealerHand.last(), card5 
    
#has game logic which can evalute the following victory/loss conditions:
  #Player has greater than 21
  #Dealer has greater than 21
  #Both have greater than 21
  #Hand where player would have lost if ace was 11, but wins if ace is 1
  #Push where values are tied
  #Dealer wins when both have 21
#reveals dealer's first card on dealer's turn