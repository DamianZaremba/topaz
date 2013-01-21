using System;
using System.Text;
using System.Management;
using System.Management.Automation;
using System.IO;
using System.Net.Sockets;
using System.Collections.Generic;
using System.Text.RegularExpressions;

// TODO:
// * Add threading to GatherStats

public class Topaz {
    public static void Main() {
        // Main shizzles
        while(true) {
            Console.WriteLine("Loop1");
            // Get the stats
            List<string> stats = StatsRun();

            // Dump to buffer
            Console.WriteLine("Sending to graphite:");
            Console.WriteLine(string.Join("\n", stats.ToArray()));
            DumpData(stats);
        }
    }

    public static List<string> StatsRun() {
        List<string> stats_buffer = new List<string>();

        // Grab the config
        Dictionary<string, string> config = get_config();

        // Calculate the collect/dump times and steps
        int collect_time = Convert.ToInt32(config["collect_time"])*1000;
        int steps = Convert.ToInt32(config["collection_count"]);

        for(int i=0; i < steps; i++) {
            Console.WriteLine("Loop2");
            // Get the stats
            List<string> stats = GatherStats();

            // Add them to our buffer
            foreach(string stat in stats) {
                stats_buffer.Add(stat);
            }

            // Sleep for 10 seconds
            System.Threading.Thread.Sleep(collect_time);
        }

        // Return buffer to main
        return stats_buffer;
    }

    public static List<string> GatherStats() {
        // Loop over all the modules and run them
        List<string> data = new List<string>();

        // Run each module
        foreach(string fileName in Directory.GetFiles("collectors")) {
            if(!fileName.EndsWith(".psm1")) {
                Console.WriteLine("Skipping " + fileName);
                continue;
            }

            List<string> mbuffer;
            try {
                mbuffer = RunModule(Path.Combine(Environment.CurrentDirectory, @fileName));

                // Merge the plugin results into the data buffer
                foreach(string stat in mbuffer) {
                    data.Add(stat);
                }
            } catch (Exception e) {
                Console.WriteLine("Failed to run " + fileName + ":");
                Console.WriteLine(e);
                continue;
            }

        }

        return data;
    }

    public static List<string> RunModule(string module_path) {
        // Execute a powershell module
        List<string> module_buffer = new List<string>();

        // Executes powershell code and returns a list
        PowerShell ps = PowerShell.Create();
        StringBuilder sb = new StringBuilder();

        // No fucks given
        sb.AppendLine("Set-ExecutionPolicy Unrestricted");

        // Import the module
        sb.AppendLine("Import-Module " + module_path);

        // Run the collect function
        sb.AppendLine("Collect");

        // Boom
        ps.AddScript(sb.ToString());

        // Grab the config
        Dictionary<string, string> config = get_config();

        // Process the lines
        foreach (PSObject result in ps.Invoke()) {
            string line = result.ToString();

            if(Regex.Match(line, "^[^\\s]+\\s[0-9]+$").Success) {
                // Mangle the data
                line = config["prefix"] + line + " " + UnixTime();

                // Push into the buffer
                module_buffer.Add(line);
            }
        }

        return module_buffer;
    }

    public static void DumpData(List<string> data) {
        // Grab the config
        Dictionary<string, string> config = get_config();

        // Sort the data
        byte[] byteBuffer = Encoding.ASCII.GetBytes(string.Join("\n", data.ToArray()));

        NetworkStream stream;
        TcpClient client;

        // Try and send our payload
        try {
            client = new TcpClient(config["server"], Convert.ToInt32(config["port"]));

            // Dump a list of data to graphite
            stream = client.GetStream();
            stream.Write(byteBuffer, 0, byteBuffer.Length);

            // Disconnect from graphite
            stream.Close();
            client.Close();

        } catch (Exception e) {
            Console.Write("Failed to send data to graphite");
            Console.Write(e.ToString());
        }

        Console.WriteLine("Dumped to graphite");
        return;
    }

    public static string UnixTime() {
        // Return the current unix time as a string
        TimeSpan ts = (DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0));
        long seconds = (long)ts.TotalSeconds;
        return seconds.ToString();
    }

    public static Dictionary<string, string> get_config() {
        // Dict we update
        Dictionary<string, string> config = new Dictionary<string, string>();

        // We overwrite these values
        config["server"] = "localhost";
        config["port"] = "2003";
        config["prefix"] = "";
        config["collect_time"] = "10";
        config["collection_count"] = "6";

        // Open the config file if it exists
        string config_path = Path.Combine(Environment.CurrentDirectory, "topaz.conf");

        if(File.Exists(config_path)) {
            string[] lines = System.IO.File.ReadAllLines(config_path);

            // Process each line
            foreach (string line in lines) {
                // Update the dict if needed
                string[] line_parts = line.Split(':');
                if(line_parts.Length == 2) {
                    line_parts[0] = line_parts[0].Trim();
                    line_parts[1] = line_parts[1].Trim();

                    if(line_parts[0] == "server") {
                        if(Regex.Match(line_parts[1], "^[A-Za-z0-9.-]+$").Success) {
                            config["server"] = line_parts[1];
                        }

                    } else if(line_parts[0] == "port") {
                        if(Regex.Match(line_parts[1], "^[0-9]{1,5}$").Success) {
                            config["port"] = line_parts[1];
                        }

                    } else if(line_parts[0] == "collect_time") {
                        if(Regex.Match(line_parts[1], "^[0-9]{1,5}$").Success) {
                            config["collect_time"] = line_parts[1];
                        }

                    } else if(line_parts[0] == "collection_count") {
                        if(Regex.Match(line_parts[1], "^[0-9]{1,5}$").Success) {
                            config["collection_count"] = line_parts[1];
                        }

                    } else if(line_parts[0] == "prefix") {
                        config["prefix"] = line_parts[1];
                    }
                }
            }
        }

        // Replace the hostname in the prefix
        config["prefix"] = config["prefix"].Replace("%%HOST_NAME%%", System.Environment.GetEnvironmentVariable("COMPUTERNAME"));

        // Lower all the things and make the port an int
        config["prefix"] = config["prefix"].ToLower();
        config["server"] = config["server"].ToLower();

        return config;
    }
}