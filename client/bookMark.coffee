Template.bookMark.helpers({
  domain: ->
    a = document.createElement('a')
    console.log(this)
    a.href = this.url
    return a.hostname
})
