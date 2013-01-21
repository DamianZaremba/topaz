# Memory usage collector
Function Collect {
    $data = New-Object System.Collections.ArrayList;

    $counter = (Get-counter -Counter "\memory\available bytes");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.available_bytes ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\committed bytes");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.comitted_bytes ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\commit limit");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.comit_limit ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\write copies/sec");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.write_copies ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\transition faults/sec");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.faults.transition ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\cache faults/sec");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.faults.cache ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\demand zero faults/sec");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.faults.demand_zero ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\page faults/sec");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.pages.faults ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\pages input/sec");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.pages.input ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\page reads/sec");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.pages.read ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\pages output/sec");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.pages.output ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\page writes/sec");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.pages.writes ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\free system page table entries");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.pages.table_entries ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\cache bytes");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.cache_bytes ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\pool paged bytes");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.pool.paged_bytes ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\pool nonpaged bytes");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.pool.paged_bytes ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\pool paged allocs");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.pool.paged_allocs ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\pool nonpaged allocs");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.pool.nonpaged_allocs ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\pool paged resident bytes");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.pool.paged_resident_bytes ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\system code total bytes");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.system.code.total_bytes ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\system code resident bytes");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.system.code.resident_bytes ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\system driver total bytes");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.system.driver.total_bytes ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\system driver resident bytes");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.system.driver.resident_bytes ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\system cache resident bytes");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.system.cache.resident_bytes ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\available kbytes");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.available_kbytes ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\available mbytes");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.available_mbytes ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\transition pages repurposed/sec");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.transition_pages_repurposed ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\free & zero page list bytes");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.free_and_zero_page_list_bytes ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\modified page list bytes");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.modified_page_list_bytes ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\standby cache reserve bytes");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.standby_cache.reserve_bytes ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\standby cache normal priority bytes");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.standby_cache.normal_priority_bytes ' + $value);
    }

    $counter = (Get-counter -Counter "\memory\standby cache core bytes");
    if($counter){
        $value = $counter.countersamples[0].CookedValue;
        $data.Add('memory.standby_cache.core_bytes ' + $value);
    }

    return $data;
}