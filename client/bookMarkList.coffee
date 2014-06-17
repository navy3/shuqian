Template.bookMarkList.events = {
  'click #editor':  (evt, template)->
    $('input[type="checkbox"]').toggle()
  'click .remove': (evt, template)->
    id = $(evt.target).data('id')
    BookMarks.remove({_id:id})
}

