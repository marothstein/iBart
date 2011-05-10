/* Author: Matthew Rothstein

*/

var testbutton = null;

var TAPCOUNT = 0;
var SWIPECOUNT = 0;

$(document).ready( start );

$(document).bind("mobileinit", function(){
	// $.extend(  $.mobile , { foo: bar } );
    
    alert(" THIS IS JQUERY WORKING! - " + $.mobile );
});

function start() {
	// make sure jquery is linked in properly
	
	// set up bindings
	bind_listeners();
	
	// zero out data in .fields
	// reset_data();
	
	// print out data for debug purposes
	// print_data();
	
	// stop native scrolling - THANKS GOOGLE!
	document.body.addEventListener('touchmove', function(e) {
	  // This prevents native scrolling from happening.
	
		console.log( "TOUCHING AND MOVING!!" );
	  e.preventDefault();
	}, false);
	
}

function bind_listeners() {
    alert( "THIS SHOULD HAPPEN!");
	// alert( google.ui.FastButton );
	
	// one-time binds
	// $("#fever").bind( 'tap', fever_tapped );
	// $("#fever").bind( 'swipe', fever_swiped );
	
	
	// live listener binds 
	
	// create fastbuttons out of the .fields
	$('.tappable').each( function(i, element) {
		// alert(" adding tappable fastbutton: " + element + "[" + element.id + "]" );
		var button = new google.ui.FastButton( element, field_tapped );
	});
	
	$(".swipeable").bind( 'swipe', field_swiped );
	
	$(".markable").each( function(i, element) {
		// alert(" adding tappable fastbutton: " + element + "[" + element.id + "]" );
		var button = new google.ui.FastButton( element, hit_point_tapped );
	});
	// alert('done creating fastbuttons');
	
	//create overlays
	create_overlays();
	
}

function create_overlays() {
	
	
	var msg = "";
	var parent = null;
	
	$(".tappable").each( function() {
		// apply overlays only if the field is not a markable field
		
		// YES: <span id="pain_quality" class="field tappable swipeable debug"> "Pain" </span>
		// NO: <td class="hit_point markable"> <div class="mark"> </div> </td>
		
		// if( ) {
			var thisElem =  $(this);
			parent = thisElem.parent();
			
			thisElem.detach();
			
			var id = thisElem.attr( 'id' );
			
			var wrapper = $( "<div class='tappable_wrapper " + id + "'></div>" );
			var overlay = $( "<span class='tappable_overlay'></span>" );
			
			thisElem.appendTo( wrapper );
			overlay.appendTo( wrapper );
			
			wrapper.appendTo( parent );
			
			
			msg += "\t" + id + "\n";
			
		// }
		
		
	});
	
	console.log("parent: " + parent + "\ntappable ids: \n"+ msg );
	
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

function field_touched() { 
	
}

function field_tapped( event ) {
	
	// put tapped element into a variable
	var tapped = event.currentTarget;
	
	
	TAPCOUNT++;
	
	// object message
	var msg = "Tapped: " + tapped + "\n\nProperties: \n";
	for( prop in tapped ) {
	
		msg += "tapped[" + prop+ "] = " + tapped[prop] + "\n";
	}
	console.log(" tapped:\n\n " + msg );
	
	
	console.log( msg );
	console.log( "Taps received: " + TAPCOUNT );
	
	// print out current classes
	$("#button1_classes").html( $("#test_button").attr("class") );
	$("#button2_classes").html( $("#test_button2").attr("class") );
	
	//console.log( "\tfield status = " jQuery.jqmData( tapped, 'status' ) );
	
	alert( "tapped = " + $(tapped).attr('id') );
	
	// alert(" Field is tapped! - " + tapped );
	
	// unbind tap listener here
	// $(tapped).unbind( 'tap' );
	
	var msg = "";
	for( prop in event ) {
		msg += "event[" + prop+ "] = " + event[prop] + "\n";
	}
	// alert(" event:\n\n " + msg );
	console.log( " event:\n\n " + msg );
	
	// check for current data
	// if( jQuery.jqmHasData( tapped) && jQuery.jqmData( tapped, 'status' ) != undefined ) {
	if( $(tapped).hasClass( "tapped" ) || $(tapped).hasClass( "swiped" ) ) {
		
		var state = jQuery.jqmData( tapped, 'status' );
		// alert(" state = (" + jQuery.jqmData( tapped, 'status' ) + ")" );
		
		// remove data
		jQuery.jqmRemoveData( tapped, 'status' );
		
		// change the image back to uncircled / unswiped
		// $(tapped).attr( "src", "images/fever.gif" );
		
		// remove class="swiped"
		$(tapped).removeClass("swiped");
		
		// remove class="tapped"
		$(tapped).removeClass("tapped");
	}
	else {
		// alert(" tapped element has no state!  " );
		
		// the state is unset, so set it to true!
		// jQuery.jqmData( tapped, 'status', 'true' );
		
		// set it to circled
		// $(tapped).attr( "src", "images/fever-circled.gif" );
		
		// add class="tapped"
		$(tapped).addClass("tapped");
	}
	
	// rebind tap listener here
	// $(tapped).bind( 'tap', field_tapped );
	
	
	// DEBUG: add in audit message
	add_audit_entry( event, tapped, jQuery.jqmData( $(tapped).get(0), 'status' ) );
}

function field_swiped( event ) {
	// put swiped element into a variable
	var swiped = event.currentTarget;
	
	
	SWIPECOUNT++;
	
	// object message
	var msg = "swiped: " + swiped + "\n\nProperties: \n";
	for( prop in swiped ) {
	
		msg += "swiped[" + prop+ "] = " + swiped[prop] + "\n";
	}
	console.log(" swiped:\n\n " + msg );
	
	
	console.log( msg );
	console.log( "Taps received: " + SWIPECOUNT );
	
	// print out current classes
	$("#button1_classes").html( $("#test_button").attr("class") );
	$("#button2_classes").html( $("#test_button2").attr("class") );
	
	//console.log( "\tfield status = " jQuery.jqmData( swiped, 'status' ) );
	
	// alert( "swiped = " + $(swiped).attr('id') );
	
	// alert(" Field is swiped! - " + swiped );
	
	// unbind tap listener here
	// $(swiped).unbind( 'tap' );
	
	var msg = "";
	for( prop in event ) {
		msg += "event[" + prop+ "] = " + event[prop] + "\n";
	}
	// alert(" event:\n\n " + msg );
	console.log( " event:\n\n " + msg );
	
	// check for current data
	// if( jQuery.jqmHasData( swiped) && jQuery.jqmData( swiped, 'status' ) != undefined ) {
	if( $(swiped).hasClass( "swiped" ) ) {
		
		var state = jQuery.jqmData( swiped, 'status' );
		// alert(" state = (" + jQuery.jqmData( swiped, 'status' ) + ")" );
		
		// remove data
		jQuery.jqmRemoveData( swiped, 'status' );
		
		// change the image back to uncircled / unswiped
		// $(swiped).attr( "src", "images/fever.gif" );
		
		// remove class="swiped"
		$(swiped).removeClass("swiped");
		
	}
	else {
		// alert(" swiped element has no state!  " );
		
		// the state is unset, so set it to true!
		// jQuery.jqmData( swiped, 'status', 'true' );
		
		// set it to circled
		// $(swiped).attr( "src", "images/fever-circled.gif" );
		
		// add class="swiped"
		$(swiped).addClass("swiped");
		
		if( $(swiped).hasClass("tapped") ) {
			$(swiped).removeClass("tapped");
		}
	}
	
	// rebind tap listener here
	// $(swiped).bind( 'tap', field_swiped );
	
	
	// DEBUG: add in audit message
	add_audit_entry( event, swiped, jQuery.jqmData( $(swiped).get(0), 'status' ) );
}

function hit_point_tapped( event ) {
	var hit_point = event.currentTarget;
	
	$(hit_point).toggleClass( "marked" );
	
	// alert(" marking point!" );
	console.log("marking point");
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
	$("#fever img").attr( "src", "images/fever-crossout.gif" );
	
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
	$("#fever img").attr( "src", "images/fever-circled.gif" );
	
}

function unsetData( ) { // jQueryObject ) {
	
	// set data to unset
	jQuery.jqmData( $('#fever').get(0), 'status', 'unset' );
	
	// change image to circled fever
	$("#fever img").attr( "src", "images/fever.gif" );
}

function add_audit_entry( event, event_target, data ) {
	
	// build the audit_entry
	var audit_entry = build_audit_entry( event, event_target, data );
	
	// append the audit entry to the audit box
	$( "#audit_container" ).append( audit_entry );
}

function build_audit_entry( event, event_target, data ) {
	// construct audit entry
	var audit_entry = $("<div class='audit_item'></div>");
	var entryHTML = "";
	entryHTML += '<div class="audit_item_row">';
	entryHTML += '	<span class="audit_item_row_title"> Event Type: </span>';
	entryHTML += '	<span class="event_type"> ' + event['type'] + ' </span>';
	entryHTML += '</div>';
	entryHTML += '<div class="audit_item_row">';
	entryHTML += '	<span class="audit_item_row_title"> Event Target: </span>';
	entryHTML += '	<span class="event_target"> ' + event['target'] + ' </span>';
	entryHTML += '</div>';
	entryHTML += '<div class="audit_item_row">';
	entryHTML += '	<span class="audit_item_row_title"> Event CurrentTarget: </span>';
	entryHTML += '	<span class="event_target"> ' + event['currentTarget'] + ' </span>';
	entryHTML += '</div>';
	// entryHTML += '<div class="audit_item_row">';
	// entryHTML += '	<span class="audit_item_row_title"> Event Target ID: </span>';
	// entryHTML += '	<span class="event_target"> ' + event_target.id + ' </span>	';
	// entryHTML += '</div>';
	entryHTML += '<div class="audit_item_row">';
	entryHTML += '	<span class="audit_item_row_title"> Event CurrentTarget ID: </span>';
	entryHTML += '	<span class="event_target"> ' + event['currentTarget'].id + ' </span>	';
	entryHTML += '</div>';
	entryHTML += '<div class="audit_item_row">';
	entryHTML += '	<span class="audit_item_row_title"> Event Target Class: </span>';
	entryHTML += '	<span class="event_target_class"> ' + event['currentTarget'].className + ' </span>	';
	entryHTML += '</div>';
	entryHTML += '<div class="audit_item_row">';
	entryHTML += '	<span class="audit_item_row_title"> Data: </span>';
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






