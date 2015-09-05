assert = chai.assert

app = new App()

describe 'Game Initialization', ->
  it 'should generate a deck on initialization', ->
    assert.ok app.get('deck'), true

  it 'should generate a player hand on initialization', ->
    assert.ok app.get('playerHand'), true

  it 'should generate a dealer hand on initialization', ->
    assert.ok app.get('dealerHand'), true