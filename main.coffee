String::capitalizeAllWords = ->
  @replace /(?:^|\s)\S/g, (a) ->
    a.toUpperCase()

employeeHTML = ""

employees = [];


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
        employees.push(data.results[0])
        # console.log( data.results[0])
        employeeHTML += "<div class=\"employee\"><img class=\"employee-image\" src=\"#{employeeImage}\">
            <div class=\"employee-info\"><h2 class=\"employee-name\">#{employeeName}</h2>
            <a class=\"employee-email\" href=\"mailto:#{employeeEmail}\">#{employeeEmail}</a>
            <p class=\"employee-location\">#{employeeLocation}</p>    </div>
        </div>"
        $("#employees").html(employeeHTML)

        $('.employee, .employee-image').on 'click touchstart',(event) ->
            showPopUp = (picture, name, email, simpleLocation, phoneNumber,street, state, postCode, birthday) ->

                popUpHTML = "
            <button id=\"exitPopup\">X</button>
            <img src=\"#{picture}\" class=\"popup-image\">
            <h2 class=\"popup-name\">#{name}</h2>
            <a href=\"mailto:#{email}\" class=\"popup-email employee-email\">#{email}</a>
            <p class=\"popup-simpleLocation\">#{simpleLocation}</p>
            <hr>
            <a href=\"tel:#{phoneNumber}\" class=\"popup-phoneNumber\">#{phoneNumber}</a>
            <p class=\"popup-location\">#{street}, #{state}, #{postCode}</p>
            <p class=\"popup-birthday\">Birthday: #{birthday}</p>
            "
                $("#popupContainer").html(popUpHTML)
                $("#popupContainer").fadeIn(300)
                $("#overlay").fadeIn(300)
            $("#overlay").on("click touchstart",(event)->
                if event.target.id is 'overlay'
                    $("#overlay").fadeOut(300)
                    $("#popupContainer").fadeOut(300)
                    )
            currentEmployeeData = employees[$(".employee").index(if event.target.className is "employee" then event.target else $(event.target).parent())]

            showPopUp(currentEmployeeData.picture.large,currentEmployeeData.name.first.capitalizeAllWords() + " " + currentEmployeeData .name.last.capitalizeAllWords(), currentEmployeeData.email, currentEmployeeData.location.city.capitalizeAllWords(), currentEmployeeData.cell,currentEmployeeData.location.street.capitalizeAllWords(),currentEmployeeData.location.state.capitalizeAllWords(),currentEmployeeData.location.postcode, new Date(currentEmployeeData.dob.date).toLocaleDateString('en-US')

            $("#popupContainer").on("click touchstart", "#exitPopup", ->
                $("#overlay").fadeOut(300)
                $("#popupContainer").fadeOut(300)
                )
            )


        return
    fetch(url).then(handleErrors).then(parseJSON).then(updateProfile)

    undefined
for i in [0..12]
    displayRandomUser()
