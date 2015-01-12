
  var options = {format: 'dd/mm/yyyy', autoclose: true, language: 'fr'};

  /*$("#search_form_section").hide();
  $("#toggle_search_form").on('click', function(){
    if ($("#search_form_section").is(":visible")){
      $("#search_form_section").hide("slow");
    }
    else{
      $("#search_form_section").show("slow");
    }
  });*/

  $("#night_section").hide();

  $('#begin_date').datepicker(options).on('changeDate', function(e){
    var begin_date = $('#begin_date').datepicker('getDate');
    var end_date = $('#end_date').datepicker('getDate');



    if (end_date - begin_date < (7 * 86400 * 1000) || end_date == "Invalid Date"){
      var dd = begin_date.getDate() + 1;
      var mm = begin_date.getMonth() + 1;
      var y = begin_date.getFullYear();


      var end_date = dd + '-'+ mm + '-'+ y;

      $('#end_date').datepicker('update', end_date);

    }

    var number_of_nights =  (Math.floor($('#end_date').datepicker('getDate') - $('#begin_date').datepicker('getDate')) / 86400000);
    //var number_of_nights = ($('#end_date').datepicker('getDate') - $('#begin_date').datepicker('getDate')).getDate();
    if (number_of_nights > 1){
      $("#night_s").html("Nuits");
    }
    else{
      $("#night_s").html("Nuit");
    }
    $("#night_number").html(number_of_nights);
    $("#night_section").show();
  });
  $('#end_date').datepicker(options).on('changeDate', function(e){
    var begin_date = $('#begin_date').datepicker('getDate');
    var end_date = $('#end_date').datepicker('getDate');

    if (end_date - begin_date < 7 * 86400 * 1000){
      var dd = end_date.getDate() - 1;
      var mm = end_date.getMonth() + 1;
      var y = end_date.getFullYear();
      var begin_date = dd + '-'+ mm + '-'+ y;

      $('#begin_date').datepicker('update', begin_date);
    }

    var number_of_nights =  (Math.floor($('#end_date').datepicker('getDate') - $('#begin_date').datepicker('getDate')) / 86400000);
    //var number_of_nights = ($('#end_date').datepicker('getDate') - $('#begin_date').datepicker('getDate')).getDate();
    if (number_of_nights > 1){
      $("#night_s").html("Nuits");
    }
    else{
      $("#night_s").html("Nuit");
    }
    $("#night_number").html(number_of_nights);
    $("#night_section").show();
  });
