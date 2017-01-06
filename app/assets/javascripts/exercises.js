$(document).on('click', '#show-details', function(e){
  e.preventDefault();
  var text = $('#show-details').text();
  if(text === 'Show Details') {
    $('.details').toggleClass('dn');
    $('#show-details').text('Hide Details');
  } else {
    $('.details').toggleClass('dn');
    $('#show-details').text('Show Details');
  }
});