{View} = require 'atom'

Subscriber = null

module.exports =
class ListeningModeView extends View
  @content: ->
    @div class: 'overlay from-top', =>
      @h1 'Waiting for core...'
      @p =>
        @img src: 'atom://spark-ide/images/listening.gif'
      @p 'Check if your core is connected via USB and it\'s in listening mode (LED blinking blue).'
      @div class: 'block', =>
        @button click: 'cancel', class: 'btn', 'Cancel'

  initialize: (serializeState) ->
    {Subscriber} = require 'emissary'

    @prop 'id', 'spark-ide-listening-mode-view'

    @subscriber = new Subscriber()
    @subscriber.subscribeToCommand atom.workspaceView, 'core:cancel core:close', ({target}) =>
      @hide()

  serialize: ->

  destroy: ->
    @detach()

  show: ->
    if !@hasParent()
      atom.workspaceView.append(this)

  hide: ->
    if @hasParent()
      @detach()

  cancel: (event, element) ->
    atom.workspaceView.trigger 'core:cancel'
