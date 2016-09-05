// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


  $(document).ready(function() { 
    dict = {
      "Browser": "filter",
      "City": "city",
      "Country": "country",
      "Operating System": "operating_system"
    }
    var current_prop, current_page;
    var showComparison = function(chart_data){
      Highcharts.setOptions({
        colors: ['#FF0000', '#0000FF', '#0B610B', '#61210B', '#7907F2', '#39a5ee']
      });
      new Highcharts.Chart({
        chart: {  
          renderTo: "details_chart",
          plotBackgroundImage:'/assets/lightpaperfibers.png',
        },
        title: {
          text: current_prop + " Comparison"
        },
        xAxis: {
          type: "datetime"
        },
        yAxis: {
          min: 0,
          title: {
            text: "Number of Hits"
          },
        },
        series: chart_data
      });
    }
    var update_map = function update_map () {
      $('.segmentation_spinner').show();
      current_prop = $('#property').val();
      current_page = $('#title_page_url').val(); 
      $.ajax({
        type: "GET",
        url: "/segmentations/"+dict[current_prop],
        async: true,
        data: {page: current_page},
        dataType: 'json',
        success: function(return_data){
          var date = parseInt(return_data.quarterly_range);
          var week = parseInt(return_data.weekly_range);
          var month = parseInt(return_data.monthly_range);
          var chart_data = [];
          if ($('#time_period :selected').text() == "Past 7 days"){
            for (var i in return_data.weekly_result) {
              chart_data.push({
                name: i,
                pointInterval: 86400000,
                pointStart: week,
                data: return_data.weekly_result[i]
              });
            }
          }
          else if ($('#time_period :selected').text() == "Past 3 weeks"){
            for (var i in return_data.result) {
              chart_data.push({
                name: i,
                pointInterval: 86400000,
                pointStart: date,
                data: return_data.result[i]
              });
            }
          }
          else{
            for (var i in return_data.monthly_result) {
              chart_data.push({
                name: i,
                pointInterval: 31*86400000,
                pointStart: month,
                data: return_data.monthly_result[i]
              });
            }            
          }
          $('.segmentation_spinner').hide();
          showComparison(chart_data)
        }
      });
    };
    $('#property').change(update_map);
    $('#title_page_url').change(update_map);
    $('#time_period').change(update_map);
    update_map();

  })


