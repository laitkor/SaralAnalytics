$(document).ready(function() { 
  $("#demograph_country,#demograph_city,#demograph_language").on('click', function() {
    $(".changedemobg_").removeClass("changedemobg_");
    $(this).addClass("changedemobg_");
    $(".country_block,.language_block,.city_block").hide();
    var content_class = this.id.split(/_/).slice(1).join('_') + '_block';
    $('.'+content_class).show();
    return false;
  })
  $("#system_browser,#system_platform,#system_operating_system,#system_sreen_resolution").on('click', function() {
    $(".changesysbg_").removeClass("changesysbg_");
    $(this).addClass("changesysbg_");
    var content_class = this.id.split(/_/).slice(1).join('_') + '_block';
    $(".browser_block,.platform_block,.operating_system_block,.screen_resolution_block").hide();
    $('.'+content_class).show();
    return false;
  })
  $("#mobile_device,#mobile_browser,#mobile_operating_system,#mobile_platform").on('click', function() {
    $(".changemobbg_").removeClass("changemobbg_");
    $(this).addClass("changemobbg_");
    $(".mobile_device_block,.mobile_browser_block,.mobile_operating_system_block,.mobile_platform_block").hide();
    var content_class = this.id + '_block';
    $('.'+content_class).show();
    return false;
  });
});

function chart() {
  if ($('.period :selected').text()=="Month"){
    $('#daily_data').css({display: 'none'});
    $('#monthly_data').css({display: 'block'}); 
    if ($('.chart :selected').text()=="Bar"){
      $('.audience_overview_spinner').show();
      showChart = function(visitors_data, month_array){ 
        Highcharts.setOptions({
          colors: ['#FE0202', '#50B432', '#39a5ee', '#DDDF00', '#ED561B', '#FFF263']
        });
        new Highcharts.Chart({
          chart: {  
            type: "column",
            renderTo: "details_chart",
            plotBackgroundImage:'/assets/lightpaperfibers.png',
          },
          title: {
            text: "Browsing by "+$('.period :selected').text()
          },
          xAxis: {
            categories: month_array
          },
          yAxis: {
            min: 0,
            title: {
              text: "Number of Hits"
            },        
          plotOptions: {
            column: {
                colorByPoint: true,
                pointPadding: 0.2,
                borderWidth: 0
              }
            },  
          },
          series: visitors_data
        });
      }
      showChart([]);
      $.ajax({
        type: "GET",
        url: "/admin/audience_overview",
        async: true,
        dataType: 'json',
        success: function(return_data){
          var date = parseInt(return_data.monthly_range);
          var visitors_data = [];
            visitors_data.push({
              name: "Monthly Visit",
              data: return_data.monthly_frequency
            });
            number_of_months = return_data.monthly_frequency.length;
          
          var month_array = get_month_array(number_of_months, new Date());
          showChart(visitors_data, month_array);
          $('.audience_overview_spinner').hide();
        }
      })
    }
    else if ($('.chart :selected').text()=="Area"){
      $('.audience_overview_spinner').show();
      showChart = function(visitors_data, month_array){
        new Highcharts.Chart({
          chart: {  
            type: "area",
            renderTo: "details_chart",
            plotBackgroundImage:'/assets/lightpaperfibers.png',
          },
          title: {
            text: "Browsing by "+$('.period :selected').text()
          },
          xAxis: {
            categories: month_array
          },
          yAxis: {
            min: 0,
            title: {
              text: "Number of Hits"
            },        
          plotOptions: {
              area: {
                pointStart: 1940,
                marker: {
                  enabled: false,
                  symbol: 'circle',
                  radius: 2,
                  states: {
                    hover: {
                        enabled: true
                    }
                  }
                }
              }
            },  
          },
          series: visitors_data
        });
      }
      showChart([]);
      $.ajax({
        type: "GET",
        url: "/admin/audience_overview",
        async: true,
        dataType: 'json',
        success: function(return_data){
          var date = parseInt(return_data.monthly_range);
          var visitors_data = [];
            visitors_data.push({
              name: "Monthly Visit",
              data: return_data.monthly_frequency
            });
            number_of_months = return_data.monthly_frequency.length;
          
          var month_array = get_month_array(number_of_months, new Date());
          showChart(visitors_data, month_array);
          $('.audience_overview_spinner').hide();
        }
      })
    }
    else{
      $('.audience_overview_spinner').show();
      showChart = function(visitors_data, month_array){
        new Highcharts.Chart({
          chart: {  
            renderTo: "details_chart",
            plotBackgroundImage:'/assets/lightpaperfibers.png',
          },
          title: {
            text: "Browsing by "+$('.period :selected').text()
          },
          xAxis: {
            categories: month_array
          },
          yAxis: {
            min: 0,
            title: {
              text: "Number of Hits"
            },
          },
          series: visitors_data
        });
      }
      showChart([]);
      $.ajax({
        type: "GET",
        url: "/admin/audience_overview",
        async: true,
        dataType: 'json',
        success: function(return_data){
          var date = parseInt(return_data.monthly_range);
          var visitors_data = [];
            visitors_data.push({
              name: "Monthly Visit",
              data: return_data.monthly_frequency
            });
            number_of_months = return_data.monthly_frequency.length;
          
          var month_array = get_month_array(number_of_months, new Date());
          showChart(visitors_data, month_array);
          $('.audience_overview_spinner').hide();
        }
      })
    }
  }  
  else{
    if ($('.chart :selected').text()=="Bar"){
      $('.audience_overview_spinner').show();
      showChart = function(data, date){ 
        Highcharts.setOptions({
          colors: ['#FE0202', '#50B432', '#39a5ee', '#DDDF00', '#ED561B', '#FFF263']
        });
        new Highcharts.Chart({
          chart: {  
            type: "column",
            renderTo: "details_chart",
            plotBackgroundImage:'/assets/lightpaperfibers.png',
          },
          title: {
            text: "Browsing by "+$('.period :selected').text()
          },
          xAxis: {
            type: "datetime"
          },
          yAxis: {
            min: 0,
            title: {
              text: "Number of Hits"
            },        
          plotOptions: {
            column: {
                colorByPoint: true,
                pointPadding: 0.2,
                borderWidth: 0
              }
            },  
          },
          series: [{
            name: "Daily Visit",
            pointInterval: 86400000,
            pointStart: date,
            data: data
          }]
        });
      }
      showChart([]);
      $.ajax({
        type: "GET",
        url: "/admin/audience_overview",
        async: true,
        dataType: 'json',
        success: function(return_data){
          showChart(return_data.daily_frequency, return_data.daily_range)
          $('.audience_overview_spinner').hide();
        }
      })
    }
    else if ($('.chart :selected').text()=="Area"){
      $('.audience_overview_spinner').show();
      showChart = function(data, date){
        new Highcharts.Chart({
          chart: {  
            type: "area",
            renderTo: "details_chart",
            plotBackgroundImage:'/assets/lightpaperfibers.png',
          },
          title: {
            text: "Browsing by "+$('.period :selected').text()
          },
          xAxis: {
            type: "datetime"
          },
          yAxis: {
            min: 0,
            title: {
              text: "Number of Hits"
            },        
          plotOptions: {
              area: {
                pointStart: 1940,
                marker: {
                  enabled: false,
                  symbol: 'circle',
                  radius: 2,
                  states: {
                    hover: {
                        enabled: true
                    }
                  }
                }
              }
            },  
          },
          series: [{
            name: "Daily Visit",
            pointInterval: 86400000,
            pointStart: date,
            data: data
          }]
        });
      }
      showChart([]);
      $.ajax({
        type: "GET",
        url: "/admin/audience_overview",
        async: true,
        dataType: 'json',
        success: function(return_data){
          showChart(return_data.daily_frequency, return_data.daily_range)
          $('.audience_overview_spinner').hide();
        }
      })
    }
    else{
      $('.audience_overview_spinner').show();
      showChart = function(data, date){
        new Highcharts.Chart({
          chart: {  
            renderTo: "details_chart",
            plotBackgroundImage:'/assets/lightpaperfibers.png',
          },
          title: {
            text: "Browsing by "+$('.period :selected').text()
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
          series: [{
            name: "Daily Visit",
            pointInterval: 86400000,
            pointStart: date,
            data: data
          }]
        });
      }
      showChart([]);
      $.ajax({
        type: "GET",
        url: "/admin/audience_overview",
        async: true,
        dataType: 'json',
        success: function(return_data){
          showChart(return_data.daily_frequency, return_data.daily_range)
          $('.audience_overview_spinner').hide();
        }
      })
    }
  }  
}



