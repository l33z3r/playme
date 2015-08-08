$('.qrcode.login_attempt').ready ->
  alert("ready to start logging in ");

  tryLogin = =>
    console.log("trying login")

    tryLoginURL = "/qrcode/login"

    data =
      login_key : $('#loginKey').val()

    completeHandler = (res) =>
      if res.status is 401
        #do nothing
      else if res.status is 200
        #login success
        window.location = "/"

    $.ajax
      url: tryLoginURL
      type: "POST"
      data: data
      complete: completeHandler

  loginPolling = =>
    tryLogin()
    setTimeout(loginPolling, 1000)

  setTimeout =>
    loginPolling()
  , 5000