Template.bookMarkDetail.helpers({
  domain: ->
    a = document.createElement('a')
    #要取两次的奇怪问题
    if this.bookMark
      a.href = this.bookMark.url
    return a.hostname
})
