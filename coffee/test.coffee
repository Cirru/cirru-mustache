
q = (query) ->
  document.querySelector query

define (require, exports) ->
  cirru = require "cirru"
  compact = require "compact"
  cirru.parse.compact = yes

  mustache = require "./mustache"

  req = new XMLHttpRequest
  req.open "get", "./cirru/div.cr"
  req.send()
  req.onload = ->
    content = req.responseText
    show content

  show = (text) ->
    q(".source").value = text
    tree = cirru.parse text
    html = mustache.render tree
    q(".target").value = html
    console.clear()
    console.log compact.render tree

  q(".source").onkeyup = ->
    show @value
    
  handle = (event) ->
    console.log event.keyCode
    if event.keyCode is 13
      event.preventDefault()
      start = @selectionStart
      text_before = @value[...start]
      text_after = @value[start..]
      last_line = text_before.split("\n").reverse()[0]
      indent = ""
      while last_line[0] is " "
        indent += " "
        last_line = last_line[1..]
      new_text = text_before + "\n" + indent + text_after
      @value = new_text
      @selectionStart = @selectionEnd = start + indent.length + 1
    else if event.keyCode is 9
      event.preventDefault()
      start = @selectionStart
      text_before = @value[...start]
      text_after = @value[start...]
      new_text = text_before + "  " + text_after
      @value = new_text
      @selectionStart = @selectionEnd = start + 2

  q("textarea.source").onkeydown = handle
  q("textarea.target").onkeydown = handle