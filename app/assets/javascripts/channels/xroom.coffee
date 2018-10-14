xmessages_height = ->
  temp = 0;
  $("div.xmessage").each ->
    temp += ($(this).height());
  return temp

document.addEventListener 'turbolinks:load', ->
  App.xroom = App.cable.subscriptions.create { channel: "XroomChannel", xroom_id: $('#xmessages').data('xroom_id') },
    connected: ->
      # Called when the subscription is ready for use on the server
  
    disconnected: ->
      # Called when the subscription has been terminated by the server
  
    received: (data) ->
      $('#xmessages').append data['xmessage']
      $('section.xmessage_box').scrollTop(xmessages_height());
  
    speak: (xmessage) ->
      @perform 'speak', xmessage: xmessage
  
  
$(document).on 'keypress', '[data-behavior~=xroom_speaker]', (event) ->
  if event.keyCode is 13 && !event.shiftKey # return = send 
    App.xroom.speak event.target.value
    event.target.value = ''
    event.preventDefault()


