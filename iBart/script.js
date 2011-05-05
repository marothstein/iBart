/* Author: Matthew Rothstein

*/

$(document).ready( start );

$(document).bind("mobileinit", function(){
	// $.extend(  $.mobile , { foo: bar } );
});

function start() {
	// make sure jquery is linked in properly
	// alert(" THIS IS JQUERY WORKING! - " + $.mobile );
	
	// set up bindings
	bind_listeners();
	
	// zero out data in .fields
	reset_data();
	
	// print out data for debug purposes
	print_data();
	
}

function bind_listeners() {
	
	// one-time binds
	$("#fever").bind( 'tap', fever_tapped );
	$("#fever").bind( 'swipe', fever_swiped );
	
	// live listener binds 
}

function reset_data() {
	jQuery.jqmData( $('#fever').get(0), 'status', 'unset' );
}

function print_data() {
	
	var msg = "";
	
	$(".field").each( function() {
		var id = $(this).attr( 'id' );
		msg += "data for [id= " + id + "] = " + jQuery.jqmData( $(this).get(0), 'status' ) + "\n";	
	});
}

function fever_tapped( event ) {
	// alert( "ALERT: you have tapped fever!" );
	
	// need to unbind the tap listener to prevent multiple taps
	$("#fever").unbind('tap');
	
	// capture the current data
	var data = jQuery.jqmData( $(this).get(0), 'status' );
	
	switch( data ) {
		case 'unset': setTrue( ); // $(this) );
			break;
		case 'true': unsetData( ); // $(this) );
			break;
		case 'false': unsetData( ); // $(this) );
			break;
		default: setTrue( ); // $(this) ); // set to true
			break;
	}
	
	// print fever data now
	// alert( "fever data: " + jQuery.jqmData( $('#fever').get(0), 'status' ) );
	
	// rebind the tap handler
	$("#fever").bind( 'tap', fever_tapped );
	
	// add in audit message
	add_audit_entry( 'tap', 'fever', jQuery.jqmData( $('#fever').get(0), 'status' ) );
}

function fever_swiped( event ) {
	
	// alert( "fever element was swiped!" );
	
	// need to unbind the tap listener to prevent this from failing
	$("#fever").unbind('tap');
	
	// set data to false
	jQuery.jqmData( $('#fever').get(0), 'status', 'false' );
	
	// change image to circled fever
	$("#fever img").attr( "src", "fever-crossout.gif" );
	
	// print fever data now
	// alert( "fever data: " + jQuery.jqmData( $('#fever').get(0), 'status' ) );
	
	// rebind the tap handler
	$("#fever").bind( 'tap', fever_tapped );
	
	// add in audit message
	add_audit_entry( 'swipe', 'fever', jQuery.jqmData( $('#fever').get(0), 'status' ) );
}

function setTrue( ) { // jQueryObject ) {
	
	// set data to true
	jQuery.jqmData( $('#fever').get(0), 'status', 'true' );
	
	// change image to circled fever
	$("#fever img").attr( "src", "fever-circled.gif" );
	
}

function unsetData( ) { // jQueryObject ) {
	
	// set data to unset
	jQuery.jqmData( $('#fever').get(0), 'status', 'unset' );
	
	// change image to circled fever
	$("#fever img").attr( "src", "fever.gif" );
}

function add_audit_entry( event_type, event_target_id, data ) {
	
	// build the audit_entry
	var audit_entry = build_audit_entry( event_type, event_target_id, data );
	
	// append the audit entry to the audit box
	$( "#audit_container" ).append( audit_entry );
}

function build_audit_entry( event_type, event_target_id, data ) {
	// construct audit entry
	var audit_entry = $("<div class='audit_item'></div>");
	var entryHTML = "";
	entryHTML += '<div class="audit_item_row">';
	entryHTML += '	<span class="event_type_title"> Event Type: </span>';
	entryHTML += '	<span class="event_type"> ' + event_type + ' </span>';
	entryHTML += '</div>';
	entryHTML += '<div class="audit_item_row">';
	entryHTML += '	<span class="event_target_title"> Event Target: </span>';
	entryHTML += '	<span class="event_target"> ' + event_target_id + ' </span>	';
	entryHTML += '</div>';
	entryHTML += '<div class="audit_item_row">';
	entryHTML += '	<span class="audit_data_title"> Data: </span>';
	entryHTML += '	<span class="audit_data"> ' + data + ' </span>	';
	entryHTML += '</div>';
	
	// append the audit_entry content
	audit_entry.html( entryHTML );
	
	// // build first audit_entry_row
	// var audit_entry_row = $( "<div class="audit_item_row">" );
	// 
	// // build event type row
	// audit_entry_row.append( $( "<span class='event_type_title'> Event Type: </span>" ) );
	// audit_entry_row.append( $( '<span class="event_type"> ' + event_type + ' </span> ') );
	// audit_entry.append( audit_entry_row );
	// 
	return audit_entry;
}

// 
// <div class="audit_item">
// 	<div class="audit_item_row">
// 		<span class="event_type_title"> Event Type: </span>
// 		<span class="event_type"> tap </span>
// 	</div>
// 	<div class="audit_item_row">
// 		<span class="event_target_title"> Event Target: </span>
// 		<span class="event_target"> #fever </span>	
// 	</div>
// 	<div class="audit_item_row">
// 		<span class="audit_data_title"> Data: </span>
// 		<span class="audit_data"> status = true </span>	
// 	</div>
// </div>






