package org.example.ikvmarithmetics

import com.google.inject.Inject
import com.google.inject.name.Named
import java.util.List
import org.eclipse.emf.common.util.URI
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.Constants
import org.eclipse.xtext.diagnostics.Severity
import org.eclipse.xtext.resource.SaveOptions
import org.eclipse.xtext.resource.XtextResource
import org.eclipse.xtext.resource.XtextResourceSet
import org.eclipse.xtext.serializer.ISerializer
import org.eclipse.xtext.validation.CheckMode
import org.eclipse.xtext.validation.IResourceValidator
import org.eclipse.xtext.validation.Issue
import org.example.ikvmarithmetics.arithmetics.ArithmeticsFactory
import org.example.ikvmarithmetics.arithmetics.Evaluation
import org.example.ikvmarithmetics.arithmetics.Module
import org.example.ikvmarithmetics.interpreter.Calculator

class CalculatorExample {
    @Inject XtextResourceSet resourceSet
    @Inject IResourceValidator validator
    @Inject Calculator interpreter
    @Inject ISerializer serializer
    @Inject @Named(Constants.FILE_EXTENSIONS) String fileExtension

    Resource inputResource
    boolean isInputExpression

    def void calculate() {
        if(inputResource === null) {
            throw new IllegalStateException("No input expression or file defined")
        }

        val root = inputResource.contents.head
        if(root instanceof Module) {
            // 1. Add all context modules as imports in order to avoid having to write
            // import statements for every context module in the input expression
            if(isInputExpression) {
                importContextResources(root)
            }

            // 2. Validate all resources in the resource set and print issues to console
            val issues = validateResources(resourceSet.resources)
            for (issue : issues) {
                System.err.println(issue)
            }

            // 3. If no severe problems exist, do the actual calculation
            if(!issues.exists[severity == Severity::ERROR]) {
                doCalculate(root)
            }
        } else {
            throw new IllegalStateException("Unexpected content in resource")
        }
    }

    public def void addContextFile(String filename) {
        val uri = URI::createFileURI(filename)
        if(uri.fileExtension != fileExtension) {
            System.err.println('''Please pass only *.«fileExtension» files as library arguments''')
        }

        resourceSet.resources += resourceSet.getResource(uri, true)
    }

    public def void setInputExpression(String text) {
        // Dummy URI for identifying the input dummy Resource
        val inputURI = URI::createURI('''<input>.«fileExtension»''')
        val resource = resourceSet.createResource(inputURI) as XtextResource
        resource.reparse(text)

        this.inputResource = resource
        this.isInputExpression = true
    }

    public def setInputFile(String filename) {
        val uri = URI::createFileURI(filename)
        if(uri.fileExtension != fileExtension) {
            throw new IllegalArgumentException('''Please pass only *.«fileExtension» files as library arguments''')
        }

        this.inputResource = resourceSet.getResource(uri, true)
        resourceSet.resources += this.inputResource
        this.isInputExpression = false
    }

    protected def void importContextResources(Module root) {
        for (resource : resourceSet.resources) {
            if(resource != inputResource) {
                val contextModule = resource.contents.head as Module
                root.imports += ArithmeticsFactory::eINSTANCE.createImport => [
                    module = contextModule
                ]
            }
        }
    }

    protected def List<Issue> validateResources(Iterable<Resource> resources) {
        resources.map[contextResource|validator.validate(contextResource, CheckMode::NORMAL_AND_FAST, [false])].flatten.toList
    }

    protected def void doCalculate(Module root) {
        val serializerOptions = SaveOptions::newBuilder.format.options

        print('''
            «FOR evaluation : root.statements.filter(Evaluation)»
                «val expression = evaluation.expression»
                «val result = interpreter.evaluate(expression)»
                - «serializer.serialize(expression, serializerOptions)»: «result»
            «ENDFOR»
        ''')
    }
}
