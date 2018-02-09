	/*
		Author: Robin Viktorsson
		Date:	2017-11-02
		Filename: custom.js
	*/
	
$(document).ready(function() {

	$(".channel_programmes").each(function(){

		var startTime = $(this).find('.programme_time').text();
		var stopTime = $(this).find('.programme_time').data('stoptime');

		var live = LiveOrNot(startTime, stopTime);
		if(live)
			$(this).append("<span class='live'>Live nu</span>");
	});

    function LiveOrNot(startTime, stopTime){

      var now = new Date();
      var thisHour = now.getHours();
      var thisMinute = now.getMinutes();

      //Get all program times
      var startHour = startTime[0] + startTime[1];
      var startMinute = startTime[3] + startTime[4];
      var start = new Date();
      start.setHours(startHour);
      start.setMinutes(startMinute);

      var stopHour = stopTime[0] + stopTime[1];
      var stopMinute = stopTime[3] + stopTime[4];
      var stop = new Date();
      stop.setHours(stopHour);
      stop.setMinutes(stopMinute);

      if(now >= start && now <= stop)
        return true;
    }

    $(document).on('click', '.programme_title', function() {

		var getID = $(this).parent().data('id');

        $.ajax({
            type: "GET",
            url: "xml_docs/allChannels.xml",
            dataType: "xml",
            success: function(xml) {
                $(xml).find('programme').each(function() {

                    var id = $(this).find('id').text();
                    if (id == getID) {

												var title = $(this).find('title').text();
                        var desc = $(this).find('desc').text();
                        var start = $(this).find('start').text();
                        var stop = $(this).find('stop').text();
                        var date = $(this).find('date').text();
                        var type = $(this).find('type').text();
                        var categories = $(this).find('category');

                        var allInfo = "<div><span class='title'>Titel: " + title + "</span><br/><br/>";

                        if (desc != "")
                          allInfo += "Beskrivning: " + desc + "<br/><br/>";

                        //There is a start and stop time on all the programmes. No need to check it.
                        allInfo += "Tid: " + start + " - " + stop + "<br/><br/>";

                        if(date != "")
                          allInfo += "<span class='date'>Datum: " + date + "</span><br/><br/>";

                        if(type != ""){
                          switch(type){
                            case "movie":
                                allInfo += "<span class='movie' style='float:none'>Film</span><br/><br/>";
                                break;
                            case "series":
                                allInfo += "<span class='series' style='float:none'>Serie</span><br/><br/>";
                                break;
                            case "tvshow":
                                allInfo += "<span class='tvshow' style='float:none'>Tv show</span><br/><br/>";
                                break;
                            case "sports":
                                allInfo += "<span class='sports' style='float:none'>Sport</span><br/><br/>";
                                break;
                            default:
                                break;
                          }
                        }

                        if(categories != ""){
                          for(i = 0; i < categories.length; i++)
														allInfo += "<span class='category' style='float:none'>"+ categories[i].innerHTML +"</span>";
                        }
                        allInfo += "</div>";

						$(allInfo).dialog({
							resizable: false,
							height: "auto",
							width: 400,
							modal: true,
							buttons: {
								Ok: function() {
									$(this).dialog("close");
								}
							}
						});
						$(".ui-dialog-titlebar").hide();
                    }

                });
            },
            error: function() {
                alert("An error occurred while processing XML file.");
            }

        }); //ajax

    }); //onclick

}); //doc.ready
