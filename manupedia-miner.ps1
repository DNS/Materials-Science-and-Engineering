<#
	https://www.open.edu/openlearn/manupedia
	
	# test mining page
	https://www.open.edu/openlearn/science-maths-technology/engineering-technology/shot-peening
	https://www.open.edu/openlearn/pluginfile.php/3277669/tool_ocwmanage/articletext/0/screen_shot_2018_800.png
#>

$a = iwr https://www.open.edu/openlearn/manupedia

$b = iwr https://www.open.edu/openlearn/pluginfile.php/3277669/tool_ocwmanage/articletext/0/screen_shot_2018_800.png

'<img src="(.+?)" alt="" />'


https://www.open.edu/openlearn/manupedia?filter=date/grid/all/all/all/all/all/all/all&page=0
https://www.open.edu/openlearn/manupedia?filter=date/grid/all/all/all/all/all/all/all&page=8


$a = iwr 'https://www.open.edu/openlearn/manupedia?filter=date/grid/all/all/all/all/all/all/all&page=0'
$b = $a.Links.href | sls engineering-technology | select -Unique

------------------------

0..8 | %{ iwr "https://www.open.edu/openlearn/manupedia?filter=date/grid/all/all/all/all/all/all/all&page=$_" } | % Links | % href | sls engineering-technology | select -Unique | Add-Content Manupedia\links.txt

$links = gc Manupedia\links.txt
	
$titles = $links | 
	%{ $_ -replace 'https://www.open.edu/openlearn/science-maths-technology/engineering-technology/.+?/.+?/.+?/' } | 
	%{ $_ -replace 'https://www.open.edu/openlearn/science-maths-technology/engineering-technology/.+?/.+?/' } | 
	%{ $_ -replace 'https://www.open.edu/openlearn/science-maths-technology/engineering-technology/.+?/' } | 
	%{ $_ -replace 'https://www.open.edu/openlearn/science-maths-technology/engineering-technology/' }

for ($i=0; $i -lt $links.Count; $i++) {
	iwr $links[$i] | % Content | Out-File "Manupedia\$($titles[$i]).html"
}





https://www.open.edu/openlearn/science-maths-technology/engineering-technology/





