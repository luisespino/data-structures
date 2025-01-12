# Install .NET in Arch Linux


Upgrade the system:

```
sudo pacman -Syu
```

Install dependencies:

```
sudo pacman -Sy \
    glibc \
    gcc \
    krb5 \
    icu \
    openssl \
    libc++ \
    zlib
```

Download the installation script:

```
wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
```

Grant execute permission to the script:

```
chmod +x ./dotnet-install.sh
```

Run the script to install the latest version:
```
./dotnet-install.sh --version latest
```

Install the .NET Runtime:
```
./dotnet-install.sh --version latest --runtime aspnetcore
```

You can install a specific major version:
```
./dotnet-install.sh --channel 9.0
```

Set DOTNET_ROOT environment variable:
```
export DOTNET_ROOT=$HOME/.dotnet
```

Update the PATH environment variable:
```
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools
```

Check the installed version:
```
dotnet --version
```

![Alt text](https://github.com/luisespino/data-structures/blob/master/csharp/img/screenshot1.png?raw=true "version")

Install the GTK library (for GUI applications):
```
sudo pacman -S gtk3
```
&nbsp;

# Create a graphical 'Hello, World!' program

Create a new project:
```
dotnet new console -n HelloWorld
cd HelloWorld
```

Add the GtkSharp package to the project:
```
dotnet add package GtkSharp
```

Edit Program.cs with your favorite text editor:
```
using Gtk;

class Program
{
    public static void Main()
    {
        // Init GTK
        Application.Init();

        // Create main window
        Window window = new Window("HelloWorld");
        window.Resize(250, 150);

        // Create label
        Label label = new Label("Hello, World!");

        // Add label to window 
        window.Add(label);

        // Show components
        window.ShowAll();

        // Connect close event
        window.DeleteEvent += (o, e) => { Application.Quit(); };

        // Run application
        Application.Run();
    }
}
```

Compile and run the application:
```
dotnet build
dotnet run
```

![Alt text](https://github.com/luisespino/data-structures/blob/master/csharp/img/screenshot2.png?raw=true "version")

You can create a self-contained bundle of the application (for .NET 9.0 and Linux x64):
```
dotnet publish -c Release -r linux-x64 --self-contained
cd bin/Release/net9.0/linux-x64/publish
chmod +x HelloWorld
./HelloWorld
```

You can also use Visual Studio Code with the C# Dev Kit:

![Alt text](https://github.com/luisespino/data-structures/blob/master/csharp/img/screenshot3.png?raw=true "version")
