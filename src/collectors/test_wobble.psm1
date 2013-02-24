Function Collect {
	$data = New-Object System.Collections.ArrayList;

	$data.Add('test.wobble.0 0');
	$data.Add('test.wobble.1 1');
	$data.Add('test.wobble.2 2');
	$data.Add('test.wobble.3 3');
	$data.Add('test.wobble.4 4');
	$data.Add('test.wobble.5 4');

	return $data;
}