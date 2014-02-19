
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

### Usage

In CommonJS

```
npm install --save cirru-mustache
```

* render:

```coffee
tree = cirru.parse code
html = require("cirru-mustache").render tree
```

### Live demo

Link http://repo.tiye,me/cirru-mustache/

### License

BSD