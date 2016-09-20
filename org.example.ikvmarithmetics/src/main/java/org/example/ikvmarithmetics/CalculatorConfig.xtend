package org.example.ikvmarithmetics

import com.beust.jcommander.Parameter
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class CalculatorConfig {
	@Parameter(names=#["--file", "-f"], description="File to be interpreted")
	String filename

	@Parameter(names=#["--import", "-i"], description="Files to be imported when using -e/--expression")
	List<String> imports

	@Parameter(names=#["--expression", "-e"], description="Expression to be interpreted")
	String expression
}
