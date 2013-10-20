
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
    #scope
      = such a scope
    ^not-scope
      = this is not in scope
    ! comment
    div#id-of-it $ = content
```

to Mustache:

```mustache
<html>
  <head>
    <title>
      demo
    </title>
    <meta charset="utf-8">
    </meta>
  </head>
  <body>
    <div id="name" class="btn btn-primary">
      content of this
    </div>
    {{#scope}}
      such a scope
    {{/scope}}
    {{^not-scope}}
      this is not in scope
    {{/not-scope}}
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