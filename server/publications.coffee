Meteor.publish('bookMarks', ->
  return BookMarks.find()
)


