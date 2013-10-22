
Convert Cirru to Mustache
------

Converts:

```cirru
html
  head
    title demo
    meta
      :charset utf-8
  body
    div (:class "btn btn-primary")
      :id name
      = content of this
    div.demo
      #scope
        = such a scope
      ^not-scope
        = this is not in scope
      >partial
      ! comment

    div.demo
      "#name :name"
        = s
      "^name :name"
        = s
    div#id-of-it $ = content
```

to Mustache:

```mustache
<html>
  <head>
    <title>
      demo
    </title>
    <meta charset="utf-8" />
  </head>
  <body>
    <div id="name" class="btn btn-primary">
      content of this
    </div>
    <div class="demo">
      {{#scope}}
        such a scope
      {{/scope}}
      {{^ot-scope}}
        this is not in scope
      {{/}}
      {{> partial}}
    </div>
    <div class="demo">
      {{#name :name}}
        s
      {{/name}}
      {{^ame}}
        s
      {{/}}
    </div>
    <div id="id-of-it">
      content
    </div>
  </body>
</html>
```

### API

* render:

```
render :: Tree -> String
mustache = render tree
```

In Node:

```
npm install --save cirru-to-mustache
```

```coffee
tree = cirru.parse code
html = require("cirru-to-mustache").render tree
```

In browser:

```
bower install --save cirru-to-mustache
```

```coffee
define (require, exports) ->
  html = require("cirru-to-mustache").render tree
```

With RequireJS or SeaJS, you may only link to my code on Github.

```
seajs.config
  map: [
    ["http://jiyinyiyong.github.io/", "jiyinyiyong"]
  ]
  alias:
    cirru2html: "jiyinyiyong/cirru-to-mustache/src/mustache"
```

### Live demo

Link http://jiyinyiyong.github.io/cirru-to-mustache/

### License

BSD