MotaView = require './mota-view'
{CompositeDisposable} = require 'atom'

module.exports = Mota =
  motaView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @motaView = new MotaView(state.motaViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @motaView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'mota:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @motaView.destroy()

  serialize: ->
    motaViewState: @motaView.serialize()

  toggle: ->
    console.log 'Mota was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
