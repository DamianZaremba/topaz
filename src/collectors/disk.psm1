# Disk usage collector
Function Collect {
    $data = New-Object System.Collections.ArrayList;

    ForEach ($Disk in Get-WmiObject Win32_LogicalDisk -filter "DriveType=3") {
        $drive = $Disk.DeviceID;
        $drive_letter = $drive;
        $free = $Disk.FreeSpace;
        $size = $Disk.Size;

        # Remove the colon if needed
        if($drive_letter -match ":") {
            $drive_letter = $drive_letter -replace ":", "";
        }

        # Clean up any whitespace
        if($drive_letter -match " ") {
            $drive_letter = $drive_letter -replace " ", "_";
        }

        # Free/size
        $data.Add('disk.' + $drive_letter + '.free ' + $free);
        $data.Add('disk.' + $drive_letter + '.size ' + $size);

        # Stats
        $counter = (Get-counter -Counter "\LogicalDisk($drive)\Current Disk Queue Length");
        if($counter) {
            $value = $counter.countersamples[0].CookedValue;
            $data.Add('disk.' + $drive_letter + '.queue_length ' + $value);
        }

        $counter = (Get-counter -Counter "\LogicalDisk($drive)\% Disk Time");
        if($counter) {
            $value = $counter.countersamples[0].CookedValue;
            $data.Add('disk.' + $drive_letter + '.time.perc_disk ' + $value);
        }

        $counter = (Get-counter -Counter "\LogicalDisk($drive)\% Disk Read Time");
        if($counter) {
            $value = $counter.countersamples[0].CookedValue;
            $data.Add('disk.' + $drive_letter + '.time.perc_read ' + $value);
        }

        $counter = (Get-counter -Counter "\LogicalDisk($drive)\% Disk Write Time");
        if($counter) {
            $value = $counter.countersamples[0].CookedValue;
            $data.Add('disk.' + $drive_letter + '.time.perc_write ' + $value);
        }

        $counter = (Get-counter -Counter "\LogicalDisk($drive)\Disk Transfers/sec");
        if($counter) {
            $value = $counter.countersamples[0].CookedValue;
            $data.Add('disk.' + $drive_letter + '.transfers ' + $value);
        }

        $counter = (Get-counter -Counter "\LogicalDisk($drive)\Disk Reads/sec");
        if($counter) {
            $value = $counter.countersamples[0].CookedValue;
            $data.Add('disk.' + $drive_letter + '.reads ' + $value);
        }

        $counter = (Get-counter -Counter "\LogicalDisk($drive)\Disk Writes/sec");
        if($counter) {
            $value = $counter.countersamples[0].CookedValue;
            $data.Add('disk.' + $drive_letter + '.writes ' + $value);
        }

        $counter = (Get-counter -Counter "\LogicalDisk($drive)\Disk Bytes/sec");
        if($counter) {
            $value = $counter.countersamples[0].CookedValue;
            $data.Add('disk.' + $drive_letter + '.bytes ' + $value);
        }

        $counter = (Get-counter -Counter "\LogicalDisk($drive)\Disk Read Bytes/sec");
        if($counter) {
            $value = $counter.countersamples[0].CookedValue;
            $data.Add('disk.' + $drive_letter + '.read_bytes ' + $value);
        }

        $counter = (Get-counter -Counter "\LogicalDisk($drive)\Disk Write Bytes/sec");
        if($counter) {
            $value = $counter.countersamples[0].CookedValue;
            $data.Add('disk.' + $drive_letter + '.write_bytes ' + $value);
        }

        $counter = (Get-counter -Counter "\LogicalDisk($drive)\% Idle Time");
        if($counter) {
            $value = $counter.countersamples[0].CookedValue;
            $data.Add('disk.' + $drive_letter + '.time.perc_idle ' + $value);
        }

        $counter = (Get-counter -Counter "\LogicalDisk($drive)\Split IO/Sec");
        if($counter) {
            $value = $counter.countersamples[0].CookedValue;
            $data.Add('disk.' + $drive_letter + '.split_io ' + $value);
        }
    }

    return $data;
}