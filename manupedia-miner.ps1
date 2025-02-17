<#
	https://www.open.edu/openlearn/manupedia
	
	# test mining page
	https://www.open.edu/openlearn/science-maths-technology/engineering-technology/shot-peening
	https://www.open.edu/openlearn/pluginfile.php/3277669/tool_ocwmanage/articletext/0/screen_shot_2018_800.png
#>

$a = iwr https://www.open.edu/openlearn/manupedia

$b = iwr https://www.open.edu/openlearn/pluginfile.php/3277669/tool_ocwmanage/articletext/0/screen_shot_2018_800.png

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


gc .\Manupedia\3d-printing.html | 
	%{ $_ -match '<img src="(.+?)"'; $Matches[1] }

$img_link = 'https://www.listchallenges.com/f/items2022/19ad4981-f572-4a30-8a45-75d6f75f1a52.jpg'
$a = iwr $img_link
$m = $img_link -match '(?ims)\.(jpg|png|gif|webp)\Z'
$file_ext = $Matches[1].ToLower()
$b = [Convert]::ToBase64String($a.Content)
"<img src=`"data:image/jpg;base64,$b`" alt=`"Red dot`" />" | out-file test.html



------------------------



<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4
  //8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==" alt="Red dot" />

  

<div class="openlearnng-blockcontent"> ..... <div class="clearfix spacebg">
<div class="openlearnng-blockcontent" id="yui_3_18_1_1_1739805136734_20">  ..... <div class="clearfix spacebg">


$(gc .\Manupedia\3d-printing.html -Raw) -match '(?ims)<div class="openlearnng-blockcontent".*?>(.+?)<div class="clearfix spacebg">'





