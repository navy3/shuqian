Router.configure({
  layoutTemplate: 'main'
})

Router.map(->
  this.route('col', {path: '/'})
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
  temp = new node.constructor()
  isTag = false
  for key of node
    if key != 'children'
      temp[key] = node[key]
    else
      if Tags.find({title:node.title}).count() == 0
        Tags.insert({title:node.title})
      for i in node[key]
        cook(i)
  if BookMarks.find(temp).count() == 0
    BookMarks.insert(temp)

Meteor.Router.add('/upload', 'POST', ->
  console.log('upload')
  bookmark = eval(this.request.body)
  cook(bookmark[0])
)

      

