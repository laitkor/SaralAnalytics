// This is a manifest file that'll be compiled into application, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require admin
//= require ripple
//= require jquery.validate
//= require companies


$(document).ready(function() {


  $(".submit_project").attr('disabled','disabled');
  
  $("#add_project").click(function(e){
    e.stopPropagation();
    $(".create_project").slideToggle();
  });

  $(".create_project").click(function(e){
    if($("#project_name").val() == ''){
      e.stopPropagation();
      return false;
    }
  });

  $(document).click(function(){
    $('.create_project').slideUp();
  });

  $('input[type="text"]').keyup(function() {
    if($(this).val() != '') {
      $(".submit_project").removeAttr('disabled');
    }
  });

  $('input[type="text"]').click(function() {
    if($(this).val() != '') {
      $(".submit_project").removeAttr('disabled');
    }
  });

  var project_option=$('.test_1 :selected'),
  project_name = project_option.text();
  if (project_name.length > 15) {
    var truncated_name = ( project_name.substr(0, 6) + '...' + project_name.substr(project_name.length-10, project_name.length));
    project_option.text(truncated_name);
  }
});

function project_name(){
  var project_key = ($('#name_key').val());
  var params = {
      'project_key' : project_key
    };
  $.ajax({
    type: "POST",
    url: "/projects/get_key",
    data: params,
    success: function(data){
      if(location.pathname.substr(0,9) == "/projects" && location.pathname != "/projects/learn"){
        var url = "/projects/"+$('#name_key').val()
        if (url) {
          window.location.replace(url);
        }
      }
      else{
        window.location.reload();
      }
    }
  });
}

