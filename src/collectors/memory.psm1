# Memory usage collector
Function Collect {
	$data = New-Object System.Collections.ArrayList;

	# Pages
	$counter = (Get-counter -Counter "\Memory\Page Faults/sec");
	$data.Add('memory.page.faults ' + $counter.countersamples[0].CookedValue);

	$counter = (Get-counter -Counter "\Memory\Page Writes/sec");
	$data.Add('memory.page.writes ' + $counter.countersamples[0].CookedValue);

	$counter = (Get-counter -Counter "\Memory\Page Reads/sec");
	$data.Add('memory.page.reads ' + $counter.countersamples[0].CookedValue);

	$counter = (Get-counter -Counter "\Memory\Pages Input/sec");
	$data.Add('memory.page.input ' + $counter.countersamples[0].CookedValue);

	$counter = (Get-counter -Counter "\Memory\Pages Output/sec");
	$data.Add('memory.page.output ' + $counter.countersamples[0].CookedValue);

	# Usage
	$counter = (Get-counter -Counter "\Memory\Cache Bytes");
	$data.Add('memory.cache ' + $counter.countersamples[0].CookedValue);

	$counter = (Get-counter -Counter "\Memory\Free & Zero Page List Bytes");
	$data.Add('memory.free ' + $counter.countersamples[0].CookedValue);

	Write-Host $data;
	return $data;
}