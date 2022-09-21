OpenBoView = require './open-bo-view'
{CompositeDisposable} = require 'atom'

module.exports = OpenBo =
  openBoView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @openBoView = new OpenBoView(state.openBoViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @openBoView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'open-bo:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @openBoView.destroy()

  serialize: ->
    openBoViewState: @openBoView.serialize()

  toggle: ->
    console.log 'OpenBo was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
