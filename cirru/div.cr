
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