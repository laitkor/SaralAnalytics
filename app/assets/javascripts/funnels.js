// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(function () {
  if(location.path != "/admin/chart"){
    $('.funnel_spinner').show();
    showChart = function(data){   
      Highcharts.setOptions({
           colors: ['#FE0202', '#50B432', '#39a5ee', '#DDDF00', '#ED561B', '#FFF263']
          });
      new Highcharts.Chart({
        chart: { 
          type: "column", 
          renderTo: "funnels_chart",
          plotBackgroundImage:'/assets/lightpaperfibers.png',
        },
        title: {
          text: "Bar Chart for "+$('#Funnel :selected').text()
        },
        xAxis: {
          categories: []
        },
        yAxis: {
          title: {
            text: "Number of Hits"
          },
        },
        plotOptions: {
          column: {
            colorByPoint: true
          },
        },
        series: [{
          name: "Total Visit Count",
          data: data
        }]
      });
    }
    showChart([]);
    $.ajax({
      type: "GET",
      url: $('#deleteFunnel').attr('href')+'.js',
      async: true,
      dataType: 'json',
      success: function(return_data){
        showChart(return_data)
        $('.funnel_spinner').hide();
      }
    })
  }
});