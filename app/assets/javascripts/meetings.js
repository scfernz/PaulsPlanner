function createGmap(data){
  handler = Gmaps.build('Google');
  handler.buildMap({
      provider: {},
      internal: {id: 'googleMap'}
    },
    function() {
      markers = handler.addMarkers(data);
      handler.bounds.extendWith(markers);
      handler.fitMapToBounds();
    }
  );
}

function loadAndCreateGmap() {
  // Only load map data if we have a map on the page
  if ($('#googleMap').length > 0) {
    // Access the data-apartment-id attribute on the map element
    var meetingId = $('#meeting_id').attr('value');

    $.ajax({
      dataType: 'json',
      url: '/meetings/' + meetingId + '/map_markers',
      method: 'GET',
      data: '',
      success: function(data) {
        createGmap(data);
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert("Getting map data failed: " + errorThrown);
      }
    });
  }
};


$(document).ready(function(){

  loadAndCreateGmap();

})
