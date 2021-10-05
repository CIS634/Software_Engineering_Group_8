function myDate(){
  var checkindate = document.getElementById("checkindate").value;
  var checkoutdate = document.getElementById("checkoutdate").value;
  var flag = false;
    if (checkindate == "" && checkoutdate == "") {
      alert("Please enter checkin and checkout dates");
    } else if (checkindate == "") {
      alert("Please enter checkin date");
    } else if (checkoutdate == "") {
      alert("Please enter checkout date");
    } else if (checkoutdate < checkindate) {
      alert("Checkout date cannot be lesser than checkindate");
    } else {
      flag = true;
      var indateObj = new Date(checkindate);
      var inmonth = indateObj.getUTCMonth() + 1; //months from 1-12
      var inday = indateObj.getUTCDate();
      var inyear = indateObj.getUTCFullYear();

      var outdateObj = new Date(checkoutdate);
      var outday = outdateObj.getUTCDate();
      var outmonth = outdateObj.getUTCMonth() + 1; //months from 1-12
      var outyear = outdateObj.getUTCFullYear();

      var noofdays = outday - inday;
      if (noofdays == 0) {
        noofdays = 1;
      }
      if ((outmonth - inmonth) > 0) {
        var noofdays = noofdays + 30;
      }
      var price = 100 * noofdays;
      var confirmmessage = " Price for " + noofdays + "days is $" + price + "!! Confirm your Booking for " + noofdays + " days?";

      let result = confirm(confirmmessage);

      //   if (result == true) {
      //    window.location = "\Finalpage.html";
      //      }
      //  else if (result == false){
      //  window.location = "  \booknow.html";
      //  }
      //   }while(flag == true);

  }
}
/*function myDate() {
  var checkindate = document.getElementById("checkindate").value;
  var checkoutdate = document.getElementById("checkoutdate").value;
  if (checkindate == "" && checkoutdate == "") {
    alert("Please enter checkin and checkout dates");
  } else if (checkindate == "") {
    alert("Please enter checkin date");
  } else if (checkoutdate == "") {
    alert("Please enter checkout date");
  } else if (checkoutdate < checkindate) {
    alert("Checkout date cannot be lesser than checkindate");
  } else {
    window.location = "\Finalpage.html";
  }
}
*/


/*
connection.end(function(err) {
  if (err) {
    return console.log('error:' + err.message);
  }
  console.log('Close the database connection.');
});
*/
