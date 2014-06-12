log = (parm)-> console.log parm

Router.configure({
  layoutTemplate: 'main'
})

getBookMarksByTag = (tag)->
  tagNode = BookMarks.findOne({title:tag})
  id = tagNode.id
  BookMarks.find({parentId:id})#.distinct('url', true)

getTags = ->
  tags = Tags.find().fetch()
  for tag in tags
    bookMark = BookMarks.findOne({title:tag.title})
    tag.count = BookMarks.find({parentId:bookMark.id}).count()
  tags

Router.map(->
  this.route('col', {
    path: '/tag/:_tag',
    data: ->
      {
        bookMarks: getBookMarksByTag(@params._tag),
        tags: getTags()
      }
  })
  this.route('col', {
    path: '/',
    data: ->
      {
        bookMarks: BookMarks.find(),
        tags: getTags()
      }
    })
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
      if Tags.find({title:node.title}).count() == 0 and node.title!=''
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
