<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang='en'>
<head>
<!-- fullcalender -->
<link href='/css/fulcalendarmain.css' rel='stylesheet' />
<script src='/javascript/fulcalendarmain.js'></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('calendar');
	var calendar = new FullCalendar.Calendar(calendarEl, {
	initialView: 'dayGridMonth'
	});
	calendar.render();
});
</script>
</head>
<body>
	gg
	<div id='calendar'></div>
</body>
</html>