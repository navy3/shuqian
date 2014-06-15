Template.main.events = {
  'keyup input':  (evt, template)->
    value = $(evt.target).val()
    console.log(value)
    if value != ''
      Router.go('/search/'+value)
}
