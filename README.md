Topaz
=====

Think [Diamond](https://github.com/BrightcoveOS/Diamond) for Windows.

Threaded C# deamon using powershell modules on the backend for fun.

Requires windows 7/server 08 or above (if it don't run powershell, it aint gonna work).

Writing a module
----------------
Create a .psm1 file in the collectors folder with a Collect method that returns an ArrayList.

The ArrayList should contain the metric name and value seperated by a single space.

How it's suppose to work
-------------------------
Threaded c# binary that loops over each powershell module in the collectors folder, runs them and dumps the data to graphite in a loop.