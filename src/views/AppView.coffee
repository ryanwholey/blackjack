class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="start-button">Start New Game</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .start-button': -> @startGame()

  initialize: ->
    @render()
    @model.get('playerHand').on 'stand', @dealerPlay, @
    @model.get('dealerHand').on 'stand', @scoreGame, @
    @$('.start-button').prop('disabled', true)

  startGame: ->
    @model.initialize()
    @initialize()

  dealerPlay: ->
    @$('.hit-button').prop('disabled', true)
    @$('.stand-button').prop('disabled', true)
    dealer = @model.get('dealerHand')
    dealer.first().flip()
    if @model.get('playerHand').minScore() <= 21 then dealer.hit() while dealer.scores()[1] < 17
    dealer.stand()  


  scoreGame: ->
    if @model.get('playerHand').minScore() > 21 then console.log('DEALER WINS')
    else 
      if @model.get('dealerHand').minScore() > 21 then console.log('PLAYER WINS')
      else 
        if @model.get('dealerHand').scores().some( (value) -> value == 21) then console.log('DEALER WINS')
        else
          if @model.get('dealerHand').bestScore() > @model.get('playerHand').bestScore() then console.log('DEALER WINS')
          else 
            if @model.get('dealerHand').bestScore() == @model.get('playerHand').bestScore() then console.log('PUSH')
            else
              console.log('PLAYER WINS')
    @$('.start-button').prop('disabled', false)

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

