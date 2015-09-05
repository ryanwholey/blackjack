# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model

  initialize: ->
    @set 'bank', 100
    @set 'game', game = new Game()
    console.log(@attributes.bank)


    
