String::capitalizeAllWords = ->
  @replace /(?:^|\s)\S/g, (a) ->
    a.toUpperCase()

employeeHTML = ""
employeeImage = null

employeeName = null

employeeEmail = null

employeeLocation = null

displayRandomUser = ->
    url = ' https://randomuser.me/api/ '
    handleErrors = (res) ->
      if !res.ok
        throw error(res.status)
      console.log res
      res
    parseJSON = (res) ->
      res.json()
    updateProfile = (data) ->
        employeeImage = data.results[0].picture.large

        employeeName = (data.results[0].name.first + " " + data.results[0].name.last).capitalizeAllWords()

        employeeEmail =  data.results[0].email

        employeeLocation = data.results[0].location.city.capitalizeAllWords()
        console.log( data.results[0])
        employeeHTML += "<div class=\"employee\"><img class=\"employee-image\" src=\"#{employeeImage}\">
            <div class=\"employee-info\"><h2 class=\"employee-name\">#{employeeName}</h2>
            <a class=\"employee-email\" href=\"mailto:#{employeeEmail}\">#{employeeEmail}</a>
            <p class=\"employee-location\">#{employeeLocation}</p>    </div>
        </div>"
        $("#employees").html(employeeHTML)

        $('.employee').on 'click touchstart', ->
          showPopUp = (picture, name, email, simpleLocation, phoneNumber,street, state, postCode)->
            popUpHTML = "
            <button id=\"exitPopup\">X</button>
            <img src=\"#{picture}\" class=\"popup-Image\">
            <h2 class=\"popup-name\">#{name}</h2>
            <a href=\"mailto:#{email}\" class=\"popup-email\">#{email}</a>
            <p class=\"popup-simpleLocation\">#{simpleLocation}</p>
            <hr>
            <a href=\"tel:#{phoneNumber}\">#{phoneNumber}</a>
            <p class=\"popup-location\">#{street}, #{state}, #{postCode}</p>
            <p class=\"popup-birthday\">Birthday: #{birthday}</p>
            "
            $("#popupContainer").html(popUpHTML)
            showPopUp(employeeImage, employeeName, employeeEmail, employeeLocation,  data.results[0].cell,data.results[0].location.street, data.results[0].location,data.results[0].state, data.results[0].location.postcode)




        return
    fetch(url).then(handleErrors).then(parseJSON).then(updateProfile)

    undefined
for i in [0..12]
    displayRandomUser()
    console.log("displayRandomUser")
