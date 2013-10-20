
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