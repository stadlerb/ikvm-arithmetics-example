/*
 * generated by Xtext 2.10.0
 */
package org.example.ikvmarithmetics

/**
 * Initialization support for running Xtext languages without Equinox extension registry.
 */
class ArithmeticsStandaloneSetup extends ArithmeticsStandaloneSetupGenerated {

    def static void doSetup() {
        new ArithmeticsStandaloneSetup().createInjectorAndDoEMFRegistration()
    }
}
