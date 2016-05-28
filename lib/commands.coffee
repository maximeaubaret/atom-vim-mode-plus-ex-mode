# Utils
# -------------------------
dispatch = (target, command) ->
  atom.commands.dispatch(target, command)

# ex command
# -------------------------
w = ({editor}={}) ->
  if editor?.getPath()
    editor.save()
  else
    atom.workspace.saveActivePaneItem()

q = ->
  atom.workspace.closeActivePaneItemOrEmptyPaneOrWindow()

wq = ->
  w()
  q()

qall = ->
  q() for item in atom.workspace.getPaneItems()

wall = ->
  w({editor}) for editor in atom.workspace.getTextEditors() when editor.isModified()

wqall = ->
  for item in atom.workspace.getPaneItems()
    w()
    q()

split = ({editor, editorElement}) ->
  atom.workspace.getActivePane().splitDown(copyActiveItem: true)
  scrollToCursorPosition()

vsplit = ({editor, editorElement}) ->
  atom.workspace.getActivePane().splitRight(copyActiveItem: true)
  scrollToCursorPosition()

# Configuration switch
# -------------------------
# Util
scrollToCursorPosition = ->
  editor = atom.workspace.getActiveTextEditor()
  if editor then editor.scrollToCursorPosition()

toggleConfig = (param) ->
  value = atom.config.get(param)
  atom.config.set(param, not value)

showInvisible = ->
  toggleConfig('editor.showInvisibles')

highlightSearch = ->
  toggleConfig('vim-mode-plus.highlightSearch')

softWrap = ({editorElement}) ->
  dispatch(editorElement, 'editor:toggle-soft-wrap')

indentGuide = ({editorElement}) ->
  dispatch(editorElement, 'editor:toggle-indent-guide')

lineNumbers = ({editorElement}) ->
  dispatch(editorElement, 'editor:toggle-line-numbers')

# When number was typed
# -------------------------
moveToLine = (vimState, count) ->
  vimState.setCount(count)
  vimState.operationStack.run('MoveToFirstLine')

moveToLineByPercent = (vimState, count) ->
  vimState.setCount(count)
  vimState.operationStack.run('MoveToLineByPercent')

module.exports =
  normalCommands: {
    w
    wq
    wall
    wqall
    q
    qall
    split
    vsplit
  }
  toggleCommands: {
    showInvisible
    softWrap
    indentGuide
    lineNumbers
    highlightSearch
  }
  numberCommands: {
    moveToLine
    moveToLineByPercent
  }
