@BookMarks = new Meteor.Collection('bookmarks')
BookMarks.allow({
  remove: (userId, id)->
    return !! userId
})
