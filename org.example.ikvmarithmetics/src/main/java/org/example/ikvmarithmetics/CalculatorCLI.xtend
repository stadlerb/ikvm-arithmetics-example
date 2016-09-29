package org.example.ikvmarithmetics

import com.beust.jcommander.JCommander

class CalculatorCLI {
    def static void main(String[] args) {
        // 1. Parse argument array
        val config = new CalculatorConfig
        val jc = new JCommander(config, args)

        if(args.length == 0) {
            jc.usage
            return
        }

        // 2. Do standalone setup
        val injector = new ArithmeticsStandaloneSetup().createInjectorAndDoEMFRegistration()

        // 3. Instantiate and execute calculator CLI
        val cli = injector.getInstance(CalculatorExample)

        // 4. Register imported files (for -e)
        val contextFilenames = config.imports
        for (contextFilename : contextFilenames) {
            cli.addContextFile(contextFilename)
        }

        // 5. Parse the input file or expression
        val expressionText = config.expression
        val filename = config.filename

        if(expressionText !== null) {
            if(filename !== null) {
                jc.usage
                return
            }
            cli.inputExpression = expressionText
        } else if(filename !== null) {
            cli.inputFile = filename
        }

        // 6. Perform the calculation
        cli.calculate()
    }
}
