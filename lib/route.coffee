Router.configure({
  layoutTemplate: 'main'
})

Router.map(->
  this.route('bookMarkList', {path: '/'})
)

Meteor.Router.add('/add', 'POST', ->
  bookmark = eval(this.request.body)
  if BookMarks.find({url:bookmark.url}).count() == 0
    BookMarks.insert(bookmark)
    console.log(bookmark)
)
Meteor.Router.add('/remove', 'POST', ->
  console.log('remove')
  bookmark = eval(this.request.body)
  BookMarks.remove({index:bookmark.index})
  console.log(bookmark[0])
)

cook = (node)->
  #console.log(node)
  temp = new node.constructor()
  for key of node
    if key != 'children'
      temp[key] = node[key]
    else
      for i in node[key]
        cook(i)
  BookMarks.insert(temp)

Meteor.Router.add('/upload', 'POST', ->
  console.log('upload')
  bookmark = eval(this.request.body)
  cook(bookmark[0])
)

      

