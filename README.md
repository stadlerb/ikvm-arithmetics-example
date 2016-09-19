#IKVM arithmetic example
This is a demonstration project for using Xtext standalone on .NET using IKVM.NET.
This example consists of an command-line calculator application based on the Xtext Simple Arithmetics Example DSL (identical to the version that can be instantiated from the Eclipse New Projects wizard when Xtext is installed).

##Prerequisites
The following programs/libraries must be present for this example to work:
 - Java 8 Development Kit (tested using Oracle JDK 8u101/102)
 - .NET Framework or Mono (tested using .NET Framework v4.0.30319 on Windows and using Mono 4.4.2 from https://www.mono-project.com/docs/getting-started/install/linux/#debian-ubuntu-and-derivatives on Linux Mint 18)
 - IKVM.NET (http://www.ikvm.net or http://weblog.ikvm.net) - tested using http://www.frijters.net/ikvmbin-8.1.5717.0.zip
 - Git
 - Maven 3.x

##Steps
 1. Install IKVM.NET (recommended default: `$HOME/ikvm`, such that ikvmc.exe can be found under `$HOME/ikvm/bin`).
    
    Under Linux, please make sure that ``bin/ikvmc.exe`` is executable by running ``chmod a+x $HOME/ikvm/bin/ikvmc.exe`` .
 2. Clone the example project using Git (in a directory of your choice):
        ``git clone https://github.com/stadlerb/ikvm-arithmetics-example.git``
 3. ``cd ikvm-arithmetics-example``
 4. Run Maven (if you installed IKVM.NET in a directory other than `$HOME/ikvm`, please specify the installation directory by adding `-Dikvm.home=path/to/ikvm/base/directory` to the `mvn` command):
 
    ``mvn -e clean verify``
    
    There will be "IKVMC0100" warnings about classes that cannot be found, which you can safely ignore.
 5. ``cd org.example.ikvmarithmetics``
 6. Try the examples, e.g.:
    - ``target/calculator.exe "3*5+10;"``
      ``- 3 * 5 + 10: 25``
    - ``target/calculator.exe "weightedsum(7, 9);" example/linearexample.ika``
      ``- weightedsum(7, 9): 59``
    - ``target/calculator.exe "examplepolynomial(5,7);" example/polynomialexample.ika``
      ``- examplepolynomial(5, 7): 96``
