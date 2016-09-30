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
      setAlertAws(items["awscolor"+num], items["awsbackground"+num], document)
    else if location.pathname.includes("/s3/")
      setTimeout(->
        doc = document.getElementsByTagName("iframe")[0].contentWindow.document
        if id && doc.getElementById("nav-usernameMenu") != null && doc.getElementById("nav-usernameMenu").innerHTML.includes(id)
          setAlertAws(items["awscolor"+num], items["awsbackground"+num], doc)
      , 3000)
  )

setAlertAws = (color, backgroundColor, doc) ->
  [].forEach.call(doc.getElementsByClassName("nav-menu"), (el) ->
    el.style.background = color
  )
  if backgroundColor
    if doc.getElementById("h")
      doc.getElementById("h").style.background = backgroundColor
    if doc.getElementById("c")
      doc.getElementById("c").style.background = backgroundColor
    if doc.getElementById("cc")
      doc.getElementById("cc").style.background = backgroundColor
    if doc.getElementById("f")
      doc.getElementById("f").style.background = backgroundColor
    if doc.getElementById("content")
      doc.getElementById("content").style.background = backgroundColor
  doc.getElementById("nav-menubar").style.background = color

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

