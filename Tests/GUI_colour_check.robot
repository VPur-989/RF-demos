***Settings***
Library		Browser
Suite Setup		Browser Setup
***Variables***

${HDR_COLOUR}	rgb(255, 255, 255)
${WRP_COLOUR}	rgb(246, 246, 246)

***Test Cases***

Check header colour
	
	${bg_colour} =	Get Style	xpath=//header[@id='header']/div[2]	background-color
	Should Be True		'${bg_colour}' == '${HDR_COLOUR}'
	

Check wrapper colour

	${bg_colour} =	Get Style	css=#wrapper	background	#local variable, can use the same name as the 		previous one
	Should Be True		'${bg_colour}' == '${WRP_COLOUR}'

***Keywords***

Browser Setup
	New Browser		firefox
	New Page	https://vm1376.kaj.pouta.csc.fi/index.php

