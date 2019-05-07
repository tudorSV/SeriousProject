$(document).ready( function() {
  $( "#dialog" ).dialog({
    autoOpen: false,
    draggable: false,
    height: 300,
    width: 600,
    buttons: {
      "Yes": function() {
        $( this ).dialog( "Pretend it deletes something" );
      },
      No: function() {
        $( this ).dialog( "close" );
      }
    }
  });

  $( "#opener" ).on( "click", function() {
    $( "#dialog" ).dialog( "open" );
  });
} );
