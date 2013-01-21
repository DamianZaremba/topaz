# CPU load collector
Function Collect {
    $data = New-Object System.Collections.ArrayList;

    $counter = (Get-counter -Counter "\Processor(_Total)\% Processor Time");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('cpu.time.processor ' + $value);
    }

    $counter = (Get-counter -Counter "\Processor(_Total)\% Privileged Time");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('cpu.time.privileged ' + $value);
    }

    $counter = (Get-counter -Counter "\Processor(_Total)\Interrupts/sec");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('cpu.interrupts ' + $value);
    }

    $counter = (Get-counter -Counter "\Processor(_Total)\DPCS Queued/sec");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('cpu.dpcs_queued ' + $value);
    }

    $counter = (Get-counter -Counter "\Processor(_Total)\% User Time");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('cpu.time.user ' + $value);
    }

    $counter = (Get-counter -Counter "\Processor(_Total)\% Idle Time");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('cpu.time.idle ' + $value);
    }

    $counter = (Get-counter -Counter "\System\Processor Queue Length");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('cpu.queue_length ' + $value);
    }

    $data.Add('cpu.process_count ' + @(Get-Process).count);

    return $data;
}