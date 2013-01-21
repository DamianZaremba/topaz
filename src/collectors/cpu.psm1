# CPU load collector
Function Collect {
	$data = New-Object System.Collections.ArrayList;

	$data.Add('cpu.load ' + ((Get-counter -Counter "\Processor(_Total)\% Processor Time").countersamples[0].CookedValue));

	return $data;
}