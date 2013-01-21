Function Collect {
	$data = New-Object System.Collections.ArrayList;

	$data.Add('test.wibble.0 0');
	$data.Add('test.wibble.1 1');
	$data.Add('test.wibble.2 2');
	$data.Add('test.wibble.3 3');
	$data.Add('test.wibble.4 4');
	$data.Add('test.wibble.5 4');

	return $data;
}