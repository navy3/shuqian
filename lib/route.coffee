Router.map(->
  this.route('brandList', {path: '/'})
)

Meteor.Router.add('/add', 'POST', ->
  console.log(this.request.body)
  bookmark = eval(this.request.body)
  console.log(bookmark)
  BookMarks.insert(bookmark)
  return [200, 'ok']
)
