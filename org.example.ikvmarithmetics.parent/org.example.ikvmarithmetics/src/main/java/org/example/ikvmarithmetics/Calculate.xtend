package org.example.ikvmarithmetics

class Calculate {
    def static void main(String[] args) {
        // 1. Parse argument array
        if(args.length == 0) {
            System.err.println(ARGS_ERROR)
            return
        }

        val contextFilenames = args.take(args.length - 1).toList
        val expressionText = args.last

        // 2. Do standalone setup
        val injector = new ArithmeticsStandaloneSetup().createInjectorAndDoEMFRegistration()

        // 3. Instantiate and execute calculator CLI
        val cli = injector.getInstance(CalculateCLI)
        cli.calculate(expressionText, contextFilenames)
    }

    private static val ARGS_ERROR = "Please pass an arithmetic expression followed by any number of *.ika files as arguments"
}