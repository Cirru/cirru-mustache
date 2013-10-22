
single_tags = [
  "area", "base", "br", "col", "command", "embed"
  "hr", "img", "input", "keygen", "link", "meta"
  "param", "source", "track", "wbr"
]

pattern = (name) ->
  if      name.match /^\w/ then "element"
  else if name.match /^\:/ then "attribute"
  else if name.match /^\#/ then "section"
  else if name.match /^\^/ then "inverted"
  else if name.match /^\!/ then "comment"
  else if name.match /^\=/ then "content"
  else if name.match /^\>/ then "partial"

short = (name) ->
  name[1..]

expand = (head, tag) ->
  name = head.match /^[\w-]+/
  classes = head.match /\.[\w-]+/g
  ids = head.match /\#[\w-]+/g
  tag.name = name[0]
  tag.attribute.class.push classes.map(short) if classes?
  tag.attribute.id.push ids.map(short) if ids?

attrs = (tag) ->
  buffer = []
  for key, value of tag.attribute
    if value.length > 0
      if (typeof value) is "string"
        buffer.push "#{key}=\"#{value}\""
      else
        buffer.push "#{key}=\"#{value.join(" ")}\""
  buffer = buffer.join(" ").trim()
  if buffer.length > 0
    buffer = " " + buffer
  buffer

indentation = (indent) ->
  buffer = ""
  while indent > 0
    indent -= 1
    buffer += "  "
  buffer

class Writer
  constructor: ->
    @buffer = ""

  line: (indent, text) ->
    @buffer += "\n" + (indentation indent) + text

  renderTag: (indent, exps) ->
    tag =
      attribute:
        id: []
        class: []
    expand exps[0], tag
    body = []
    exps[1..].map (line) =>
      if (pattern line[0]) is "attribute"
        target = tag.attribute[short line[0]]
        if target?
          target.push line[1..]...
        else
          tag.attribute[short line[0]] = line[1..]
      else
        body.push line
    if tag.name in single_tags
      @line indent, "<#{tag.name}#{attrs tag} />"
    else
      @line indent, "<#{tag.name}#{attrs tag}>"
      @renderBlock indent, body
      @line indent, "</#{tag.name}>"

  renderBlock: (indent, exps) ->
    exps.map (line) =>
      if (typeof line) is "string"
        @line (indent + 1), line
      else
        head = line[0]
        switch pattern head
          when "element"  then @renderTag      (indent + 1), line
          when "section"  then @renderSection  (indent + 1), line
          when "inverted" then @renderInverted (indent + 1), line
          when "content"  then @renderContent  (indent + 1), line
          when "partial"  then @renderPartial  (indent + 1), line

  renderSection: (indent, section) ->
    head = section[0]
    name = (short head).match(/^[\w\d-\?]+/)[0]
    @line indent, "{{##{short head}}}"
    @renderBlock indent, section[1..]
    @line indent, "{{/#{name}}}"

  renderInverted: (indent, section) ->
    head = section[0]
    head = (short head).match(/^[\w\d-\?]+/)[0]
    @line indent, "{{^#{short head}}}"
    @renderBlock indent, section[1..]
    @line indent, "{{/#{name}}}"

  renderPartial: (indent, line) ->
    head = line[0]
    @line indent, "{{> #{short head}}}"

  renderContent: (indent, line) ->
    words = line[1..].join(" ")
    @line indent, words

  render: (exps) ->
    @renderBlock -1, exps
    @buffer

render = (tree) ->
  (new Writer).render tree

if define?
  define {render}
else if exports?
  exports.render = render