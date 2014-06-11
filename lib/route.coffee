Router.map(->
  this.route('brandList', {path: '/'})
)

Meteor.Router.add('/add', 'POST', ->
  bookmark = eval("(" + this.request.body + ')')
  console.log(bookmark)
  #@BookMarks.insert(bookmark)
  return [200, 'ok']
)
