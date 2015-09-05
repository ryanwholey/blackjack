class window.Game extends Backbone.Model
  initialize: ->
    @set 'pot', 0
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  bet: ->
    @trigger 'bet', @