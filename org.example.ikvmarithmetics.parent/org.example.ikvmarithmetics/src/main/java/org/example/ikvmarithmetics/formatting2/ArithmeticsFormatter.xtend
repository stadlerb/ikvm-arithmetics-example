/*
 * generated by Xtext 2.10.0
 */
package org.example.ikvmarithmetics.formatting2

import com.google.inject.Inject
import org.eclipse.xtext.formatting2.AbstractFormatter2
import org.eclipse.xtext.formatting2.IFormattableDocument
import org.example.ikvmarithmetics.arithmetics.Definition
import org.example.ikvmarithmetics.arithmetics.Div
import org.example.ikvmarithmetics.arithmetics.Evaluation
import org.example.ikvmarithmetics.arithmetics.Expression
import org.example.ikvmarithmetics.arithmetics.FunctionCall
import org.example.ikvmarithmetics.arithmetics.Import
import org.example.ikvmarithmetics.arithmetics.Minus
import org.example.ikvmarithmetics.arithmetics.Module
import org.example.ikvmarithmetics.arithmetics.Multi
import org.example.ikvmarithmetics.arithmetics.Plus
import org.example.ikvmarithmetics.arithmetics.Statement
import org.example.ikvmarithmetics.services.ArithmeticsGrammarAccess

class ArithmeticsFormatter extends AbstractFormatter2 {
    @Inject extension ArithmeticsGrammarAccess

    def dispatch void format(Module module, extension IFormattableDocument document) {
        document.prepend(module, [noSpace])
        for (Import imports : module.getImports()) {
            imports.format;
        }
        for (Statement statements : module.getStatements()) {
            statements.format;
        }
    }

    def dispatch void format(Import ^import, extension IFormattableDocument document) {
        import.prepend[noSpace]
        import.module.prepend[oneSpace].append[noSpace]
    }

    def dispatch void format(Definition definition, extension IFormattableDocument document) {
        definition.regionFor.keyword("def").prepend[noSpace].append[oneSpace]
        definition.allRegionsFor.keyword("(").prepend[noSpace].append[noSpace]
        definition.allRegionsFor.keyword(",").prepend[noSpace].append[oneSpace]
        definition.allRegionsFor.keyword(")").prepend[noSpace]
        definition.regionFor.keyword(":").prepend[noSpace].append[newLine]
        definition.regionFor.keywordPairs(":", ";").forEach[interior[indent]]
        definition.regionFor.keyword(";").prepend[newLine; noSpace].append[newLines = 2]

        definition.expr.format;
    }

    def dispatch void format(Evaluation evaluation, extension IFormattableDocument document) {
        evaluation.prepend[noSpace]
        evaluation.regionFor.assignment(evaluationAccess.expressionAssignment_0).prepend[noSpace]
        evaluation.regionFor.keyword(";").prepend[noSpace].append[newLine]
        evaluation.expression.format
    }

    def dispatch void format(Plus expression, extension IFormattableDocument document) {
        expression.formatParentheses(document)
        expression.regionFor.keyword("+").prepend[oneSpace].append[oneSpace]
        expression.left.format
        expression.right.format
    }

    def dispatch void format(Minus expression, extension IFormattableDocument document) {
        expression.formatParentheses(document)
        expression.regionFor.keyword("-").prepend[oneSpace].append[oneSpace]
        expression.left.format
        expression.right.format
    }

    def dispatch void format(Multi expression, extension IFormattableDocument document) {
        expression.formatParentheses(document)
        expression.regionFor.keyword("*").prepend[oneSpace].append[oneSpace]
        expression.left.format
        expression.right.format
    }

    def dispatch void format(Div expression, extension IFormattableDocument document) {
        expression.formatParentheses(document)
        expression.regionFor.keyword("/").prepend[oneSpace].append[oneSpace]
        expression.left.format
        expression.right.format
    }

    def dispatch void format(FunctionCall expression, extension IFormattableDocument document) {
        expression.prepend[noSpace]
        expression.regionFor.crossRef(primaryExpressionAccess.funcAbstractDefinitionCrossReference_2_1_0).prepend [
            noSpace
        ]
        expression.formatParentheses(document)
        val leftFunctionPar = primaryExpressionAccess.leftParenthesisKeyword_2_2_0
        expression.allRegionsFor.keyword(leftFunctionPar).prepend[noSpace].append[noSpace]
        expression.allRegionsFor.keyword(",").prepend[noSpace].append[oneSpace]
        val rightFunctionPar = primaryExpressionAccess.rightParenthesisKeyword_2_2_3
        expression.allRegionsFor.keyword(rightFunctionPar).prepend[noSpace].append[noSpace]

        expression.args.forEach[format]
    }

    def void formatParentheses(Expression expression, extension IFormattableDocument document) {
        val leftPar = primaryExpressionAccess.leftParenthesisKeyword_0_0
        expression.allRegionsFor.keyword(leftPar).prepend[noSpace].append[noSpace]
        val rightPar = primaryExpressionAccess.rightParenthesisKeyword_0_2
        expression.allRegionsFor.keyword(rightPar).prepend[noSpace].append[noSpace]
    }
}
