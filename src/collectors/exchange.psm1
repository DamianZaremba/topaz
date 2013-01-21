# Exchange queue collector
Function Collect {
    $data = New-Object System.Collections.ArrayList;

    # Try and load the exchange snap in
    # Bail if we can't (exchange not installed)
    try {
        Add-PSSnapin Microsoft.Exchange.Management.PowerShell.E2010;
    } Catch {
        return $data;
    }

    # Get the message count for every queue
    ForEach ($Queue in Get-Queue) {
        $identity = $Queue.Identity.ToString();
        $count = $Queue.MessageCount;

        # Get rid of the server name if needed
        if($identity -match "\\") {
            $identity = $identity.Split("\\")[1];

        }

        # Clean up any whitespace
        if($identity -match " ") {
            $identity = $identity -replace " ", "_";
        }

        # Shove the data into the array
        $data.Add('exchange.queue.' + $identity + ' ' + $count);
    }

    return $data;
}