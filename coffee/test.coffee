
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