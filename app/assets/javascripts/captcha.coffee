$ ->
  $.getJSON "/get_captcha", (data) ->
    $("#captcha_image img").attr("src", data.url)
    $("#captcha_widget input[name=captcha_response_id]").attr("value", data.captcha)
