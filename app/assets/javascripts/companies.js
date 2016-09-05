// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready(function() {  
  $.validator.addMethod("regx", function(value, element, regexpr) {
      return regexpr.test(value);
  }, "Please enter a valid Phone number.");

  $("#newsignupform").validate({
    rules: {
        "company[name]":{
            required: true,
            minlength: 3
        },
        "company[address1]":{
            required: true,
        },
        "company[contact_phone]":{
            required: true,
            regx: /^[\(\)0-9\- \+\.]{5,20} *[extension\.]{0,9} *[0-9]{0,5}$/i
        },
        "user[email]":{
            required: true,
            email: true
        },
        "user[password]":{
            required: true,
            minlength: 6
        },
        "user[password_confirmation]":{
            required: true,
            minlength: 6,
            equalTo: "#user_password"
        }
    },
    messages: {
        "company[name]":{
            required: "Name can't be blank",
            minlength: "Name should be of atleast 3 characters"
        },
        "company[address1]":{
            required: "Address can't be blank"
        },
        "company[contact_phone]":{
            required: "Phone can't be blank",
        },
        "user[email]":{
            required: "Email can't be blank",
            email: "Please enter a proper email address"
        },
        "user[password]":{
            required: "Password can't be blank",
            minlength: "Password should be of atleast 6 characters"
        },
        "user[password_confirmation]":{
            required: "Confirm Password can't be blank",
            minlength: "Please enter the same password as above",
            equalTo: "Please enter the same password as above"
        }
    }
  });
  
  $("#editsignupform").validate({
    rules: {
        "company[name]":{
            required: true,
            minlength: 3
        },
        "company[address1]":{
            required: true,
        },
        "company[contact_phone]":{
            required: true,
            regx: /^[\(\)0-9\- \+\.]{5,20} *[extension\.]{0,9} *[0-9]{0,5}$/i
        },
        "user[email]":{
            required: true,
            email: true
        }
    },
    messages: {
        "company[name]":{
            required: "Name can't be blank",
            minlength: "Name should be of atleast 3 characters"
        },
        "company[address1]":{
            required: "Address can't be blank"
        },
        "company[contact_phone]":{
            required: "Phone can't be blank",
        },
        "user[email]":{
            required: "Email can't be blank",
            email: "Please enter a proper email address"
        }
    }
  });
});