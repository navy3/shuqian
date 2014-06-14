log = (parm)-> console.log parm

Router.configure({
  layoutTemplate: 'main'
})

getBookMarksByTag = (tag)->
  tagNode = BookMarks.findOne({title:tag})
  #会调二次,要解决,很奇怪(route没有wait导致的)
  #if !tagNode
  #  return
  id = tagNode.id
  bookMarks = BookMarks.find({parentId:id}).fetch()
  distinct = _.uniq(bookMarks, false, (d)-> return d.url)
  distinct

getTags = ->
  tags = Tags.find().fetch()
  willPop = [tags]
  for tag in tags
    bookMark = BookMarks.findOne({title:tag.title})
    if !bookMark
      continue
    tag.count = BookMarks.find({parentId:bookMark.id}).count()
    if tag.count == 0
      willPop.push(tag)
  _.without.apply(this, willPop)

getTagsById = (id)->
  #找到这个id的bookMark
  bookMark = BookMarks.findOne({_id:id})
  #找到所有相等的url的bookMark
  url = bookMark.url
  bookMarks = BookMarks.find({url:url}).fetch()
  #归属其上级节点id合集
  tagIds = []
  for bookMark in bookMarks
    tagIds.push(bookMark.parentId)
  #找到所有的tag
  BookMarks.find({id: {$in:tagIds}})

getTagsByURL = (url)->
  url = decodeURIComponent(url)
  bookMarks = BookMarks.find({url:url}).fetch()
  #归属其上级节点id合集
  tagIds = []
  for bookMark in bookMarks
    tagIds.push(bookMark.parentId)
  #找到所有的tag
  BookMarks.find({id: {$in:tagIds}})

  
Router.map(->
  this.route('col', {
    path: '/',
    waitOn: -> [Meteor.subscribe('bookMarks'), Meteor.subscribe('tags')],
    data: ->
      {
        bookMarks: BookMarks.find(),
        tags: getTags()
        #tags: Tags.find()
      }
  })

  this.route('col', {
    path: '/tag/:_tag',
    waitOn: -> [Meteor.subscribe('bookMarks'), Meteor.subscribe('tags')],
    data: ->
      {
        bookMarks: getBookMarksByTag(@params._tag),
        tags: getTags()
      }
  })

  this.route('bookMarkDetail', {
    path: '/d/:_url',
    waitOn: -> [Meteor.subscribe('bookMarks'), Meteor.subscribe('tags')],
    data: ->
      {
        bookMark: BookMarks.findOne({url:decodeURIComponent(@params._url)}),
        tags: getTagsByURL(@params._url)
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
  console.log(bookmark)
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

Meteor.Router.add('/update', 'POST', ->
  console.log('update')
  bookmark = eval(this.request.body)
  log bookmark
  BookMarks.update({id:bookmark.id}, {$set:{index:bookmark.index, parentId:bookmark.parentId}})
)
