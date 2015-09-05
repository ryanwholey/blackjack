class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> 
    <button class="stand-button">Stand</button> 
    <button class="start-button">Start New Game</button>
    <button class="bet-button">Bet</button>
    <div class="betting-container"></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  bettingTemplate: _.template '
    <h3>Bank: <%- bank %></h3>
    <h4>Pot: <%- pot %></h4>
    <input type="textarea" class="betInput" placeholder="5"></input>
  '

  events:
    'click .hit-button': -> @model.get('game').get('playerHand').hit()
    'click .stand-button': -> @model.get('game').get('playerHand').stand()
    'click .start-button': -> @startGame()
    'click .bet-button': -> @model.get('game').bet()

  initialize: ->
    @model.get('game').get('playerHand').on 'stand', @dealerPlay, @
    @model.get('game').get('dealerHand').on 'stand', @scoreGame, @
    @model.get('game').on 'bet', @makeBet, @

    @buyIn()
    @render()
    @renderBets()

    @$('.start-button').prop('disabled', true)
    @$('.bet-button').prop('disabled', false)

  startGame: ->
    @model.initialize()
    @initialize()

  buyIn: ->
    if !@makeBet(5) then @kickPlayerOut()

  kickPlayerOut: ->
    @$('button').prop('disabled', true)
    console.log('Get a job you bum!')

  dealerPlay: ->
    @$('.hit-button').prop('disabled', true)
    @$('.stand-button').prop('disabled', true)
    dealer = @model.get('game').get('dealerHand')
    dealer.first().flip()
    if @model.get('game').get('playerHand').minScore() <= 21 then dealer.hit() while dealer.scores()[1] < 17
    dealer.stand()  

  makeBet: -> 
    value = +@$(".betInput").val() || 5
    @$('.bet-button').prop('disabled',true)
    if (@model.get 'bank') >= value 
      @betFromBank(value)
      @renderBets()
    else 
      false


  betFromBank: (value) ->
    @model.set('bank', (@model.get 'bank') - value)
    @model.get('game').set('pot', (@model.get('game').get('pot')) + value)
    true

  scoreGame: ->
    playerWin = false
    if @model.get('game').get('playerHand').minScore() > 21 then console.log('DEALER WINS')
    else 
      if @model.get('game').get('dealerHand').minScore() > 21 then playerWin = true
      else 
        if @model.get('game').get('dealerHand').scores().some( (value) -> value == 21) then console.log('DEALER WINS')
        else
          if @model.get('game').get('dealerHand').bestScore() > @model.get('game').get('playerHand').bestScore() then console.log('DEALER WINS')
          else 
            if @model.get('game').get('dealerHand').bestScore() == @model.get('game').get('playerHand').bestScore() then console.log('PUSH')
            else
              playerWin = true
    if playerWin
      console.log('PLAYER WINS')
      @model.set('bank', @model.get('bank') + @model.get('game').get('pot')*2)
    
    @model.get('game').set('pot', 0)
    @renderBets();  
    @$('.start-button').prop('disabled', false)

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get('game').get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get('game').get 'dealerHand').el

  renderBets: ->
    @$('.betting-container').html @bettingTemplate({bank: @model.get('bank'), pot: @model.get('game').get('pot')}) 
    

