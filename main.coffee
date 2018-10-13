String::capitalizeAllWords = ->
  @replace /(?:^|\s)\S/g, (a) ->
    a.toUpperCase()

employeeHTML = ""
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
        console.log(data.results[0])

        employeeName = (data.results[0].name.first + " " + data.results[0].name.last).capitalizeAllWords()

        employeeEmail =  data.results[0].email

        employeeLocation = data.results[0].location.city.capitalizeAllWords()

        employeeHTML += "<div class=\"employee\"><img class=\"employee-image\" src=\"#{employeeImage}\">
            <h2 class=\"employee-name\">#{employeeName}</h2>
            <a class=\"employee-email\" href=\"mailto:#{employeeEmail}\">#{employeeEmail}</a>
            <p class=\"employee-location\">#{employeeLocation}</p>
        </div>"
        $("#employees").html(employeeHTML)
        return

    fetch(url).then(handleErrors).then(parseJSON).then(updateProfile)
    undefined


for i in [0..12]
    displayRandomUser()
    console.log("displayRandomUser")
