Meteor.publish('bookMarks', ->
  return BookMarks.find()
)
Meteor.publish('tags', ->
  return Tags.find()
)

