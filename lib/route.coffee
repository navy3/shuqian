Router.configure({
  layoutTemplate: 'main'
})

Router.map(->
  this.route('bookMarkList', {path: '/'})
)

Meteor.Router.add('/add', 'POST', ->
  console.log('add')
  bookmark = eval(this.request.body)
  BookMarks.insert(bookmark)
  console.log(bookmark)
)
Meteor.Router.add('/remove', 'POST', ->
  console.log('remove')
  bookmark = eval(this.request.body)
  BookMarks.remove({index:bookmark.index})
  console.log(bookmark)
)
