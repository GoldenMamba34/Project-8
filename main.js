var displayRandomUser, employeeEmail, employeeHTML, employeeImage, employeeLocation, employeeName, employees, i, j;

String.prototype.capitalizeAllWords = function() {
  return this.replace(/(?:^|\s)\S/g, function(a) {
    return a.toUpperCase();
  });
};

employeeHTML = "";

employees = [];

employeeImage = null;

employeeName = null;

employeeEmail = null;

employeeLocation = null;

displayRandomUser = function() {
  var handleErrors, parseJSON, updateProfile, url;
  url = ' https://randomuser.me/api/ ';
  handleErrors = function(res) {
    if (!res.ok) {
      throw error(res.status);
    }
    console.log(res);
    return res;
  };
  parseJSON = function(res) {
    return res.json();
  };
  updateProfile = function(data) {
    employeeImage = data.results[0].picture.large;
    employeeName = (data.results[0].name.first + " " + data.results[0].name.last).capitalizeAllWords();
    employeeEmail = data.results[0].email;
    employeeLocation = data.results[0].location.city.capitalizeAllWords();
    employees.push(data.results[0]);
    // console.log( data.results[0])
    employeeHTML += `<div class="employee"><img class="employee-image" src="${employeeImage}"> <div class="employee-info"><h2 class="employee-name">${employeeName}</h2> <a class="employee-email" href="mailto:${employeeEmail}">${employeeEmail}</a> <p class="employee-location">${employeeLocation}</p>    </div> </div>`;
    $("#employees").html(employeeHTML);
    $('.employee, .employee *').on('click touchstart', function(event) {
      var currentEmployeeData, showPopUp;
      showPopUp = function(picture, name, email, simpleLocation, phoneNumber, street, state, postCode, birthday) {
        var popUpHTML;
        popUpHTML = `<button id="exitPopup">X</button> <img src="${picture}" class="popup-Image"> <h2 class="popup-name">${name}</h2> <a href="mailto:${email}" class="popup-email">${email}</a> <p class="popup-simpleLocation">${simpleLocation}</p> <hr> <a href="tel:${phoneNumber}">${phoneNumber}</a> <p class="popup-location">${street}, ${state}, ${postCode}</p> <p class="popup-birthday">Birthday: ${birthday}</p>`;
        $("#popupContainer").html(popUpHTML);
        $("#popupContainer").fadeIn(300);
        return $("#overlay").fadeIn(300);
      };
      $("#overlay").on("click touchstart", function(event) {
        if (event.target.id === 'overlay') {
          $("#overlay").fadeOut(300);
          return $("#popupContainer").fadeOut(300);
        }
      });
      $("#exitPopup").on("click touchstart", function() {
        $("#overlay").fadeOut(300);
        $("#popupContainer").fadeOut(300);
        return alert("Exit Popup");
      });
      currentEmployeeData = employees[$(".employee").index(event.target)];
      console.log(currentEmployeeData);
      return showPopUp(currentEmployeeData.picture.large, currentEmployeeData.name.first + " " + currentEmployeeData.name.last.capitalizeAllWords(), currentEmployeeData.email, currentEmployeeData.location.city.capitalizeAllWords(), currentEmployeeData.cell, currentEmployeeData.location.street.capitalizeAllWords(), currentEmployeeData.location.state.capitalizeAllWords(), currentEmployeeData.location.postcode, new Date(currentEmployeeData.dob.date).toLocaleDateString('en-US'));
    });
  };
  fetch(url).then(handleErrors).then(parseJSON).then(updateProfile);
  return void 0;
};

for (i = j = 0; j <= 12; i = ++j) {
  displayRandomUser();
}
