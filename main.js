var displayRandomUser, employeeHTML, i, j;

String.prototype.capitalizeAllWords = function() {
  return this.replace(/(?:^|\s)\S/g, function(a) {
    return a.toUpperCase();
  });
};

employeeHTML = "";

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
    var employeeEmail, employeeImage, employeeLocation, employeeName;
    employeeImage = data.results[0].picture.large;
    console.log(data.results[0]);
    employeeName = (data.results[0].name.first + " " + data.results[0].name.last).capitalizeAllWords();
    employeeEmail = data.results[0].email;
    employeeLocation = data.results[0].location.city.capitalizeAllWords();
    employeeHTML += `<div class="employee"><img class="employee-image" src="${employeeImage}"> <h2 class="employee-name">${employeeName}</h2> <a class="employee-email" href="mailto:${employeeEmail}">${employeeEmail}</a> <p class="employee-location">${employeeLocation}</p> </div>`;
    $("#employees").html(employeeHTML);
  };
  fetch(url).then(handleErrors).then(parseJSON).then(updateProfile);
  return void 0;
};

for (i = j = 0; j <= 12; i = ++j) {
  displayRandomUser();
  console.log("displayRandomUser");
}
