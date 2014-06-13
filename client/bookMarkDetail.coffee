Template.bookMarkDetail.helpers({
  domain: ->
    a = document.createElement('a')
    if this.bookMark
      a.href = this.bookMark.url
      return a.hostname
    else
      return
})
