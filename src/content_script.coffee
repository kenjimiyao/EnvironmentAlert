checkUrl = (num) ->
  l("checkProduction"+num)
  chrome.storage.sync.get(['url'+num, 'color'+num, 'message'+num], (items) ->
    l("get"+num)
    if items["url"+num] && location.href.includes(items["url"+num])
      setAlert(items["color"+num], items["message"+num])
  )

checkAws = (num) ->
  if !location.hostname.includes("aws.amazon.com")
    return

  chrome.storage.sync.get(['aws'+num, 'awscolor'+num, 'awsbackground'+num], (items) ->
    id = items['aws'+num]
    l("awsget"+id)
    if id && document.getElementById("nav-usernameMenu") != null && document.getElementById("nav-usernameMenu").innerHTML.includes(id)
      setAlertAws(items["awscolor"+num], items["awsbackground"+num])
  )

setAlertAws = (color, backgroundColor) ->
  [].forEach.call(document.getElementsByClassName("nav-menu"), (el) ->
    el.style.background = color
  )
  if backgroundColor
    if document.getElementById("h")
      document.getElementById("h").style.background = backgroundColor
    if document.getElementById("c")
      document.getElementById("c").style.background = backgroundColor
  document.getElementById("nav-menubar").style.background = color
  # document.getElementById("h").style.background = color

setAlert = (color, message) ->
  body = document.body
  div = document.createElement("div")
  div.textContent = message
  div.style.backgroundColor = color
  div.style.width = "100%"
  div.style.height = "27px"
  div.style.textAlign = "center"
  div.style.color = "white"
  div.style.lineHeight = "27px"
  body.insertBefore(div, body.firstChild)

l = (message) ->
  return
  console.log(message)

for i in [1..10]
  checkUrl(i)

for i in [1..5]
  checkAws(i)

