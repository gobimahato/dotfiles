{
	"$schema": "https://json.schemastore.org/tsconfig",
	"compilerOptions": {
		/* Set the JavaScript language version for emitted JavaScript and include compatible library declarations. */
		"target": "ES2022",
		/* Specify a set of bundled library declaration files that describe the target runtime environment. */
		"lib": [],
		/* Enable experimental support for legacy experimental decorators. */
		"experimentalDecorators": false,
		/* Control what method is used to detect module-format JS files. */
		"moduleDetection": "auto",
		/* Specify what module code is generated. */
		"module": "ES2022",
		/* Specify the root folder within your source files. */
		"rootDir": "./src",
		/* Specify how TypeScript looks up a file from a given module specifier. */
		"moduleResolution": "node16",
		/* Specify multiple folders that act like './node_modules/@types'. */
		"typeRoots": [
			"./node_modules/@types",
			"./src/types"
		],
		/* Enable importing .json files. */
		"resolveJsonModule": true,
		/**
		 * Allow JavaScript files to be a part of your program. Use the 'checkJS' option to get
		 * errors from these files.
		 */
		"allowJs": true,
		/* Enable error reporting in type-checked JavaScript files. */
		"checkJs": true,
		/* Generate .d.ts files from TypeScript and JavaScript files in your project. */
		"declaration": true,
		/* Create sourcemaps for d.ts files. */
		"declarationMap": true,
		/* Create source map files for emitted JavaScript files. */
		"sourceMap": true,
		/* Specify an output folder for all emitted files. */
		"outDir": "./dist",
		/* Disable emitting comments. */
		"removeComments": false,
		/* Set the newline character for emitting files. */
		"newLine": "lf",
		/* Allow 'import x from y' when a module doesn't have a default export. */
		"allowSyntheticDefaultImports": true,
		/**
		 * Emit additional JavaScript to ease support for importing CommonJS modules. This enables
		 * 'allowSyntheticDefaultImports' for type compatibility.
		 */
		"esModuleInterop": true,
		/* Ensure that casing is correct in imports. */
		"forceConsistentCasingInFileNames": true,
		/* Enable all strict type-checking options. */
		"strict": true,
		/* Enable error reporting for expressions and declarations with an implied 'any' type. */
		"noImplicitAny": true,
		/* When type checking, take into account 'null' and 'undefined'. */
		"strictNullChecks": true,
		/* When assigning functions, check to ensure parameters and the return values are subtype-compatible. */
		"strictFunctionTypes": true,
		/* Check that the arguments for 'bind', 'call', and 'apply' methods match the original function. */
		"strictBindCallApply": true,
		/* Check for class properties that are declared but not set in the constructor. */
		"strictPropertyInitialization": true,
		/* Enable error reporting when 'this' is given the type 'any'. */
		"noImplicitThis": true,
		/* Default catch clause variables as 'unknown' instead of 'any'. */
		"useUnknownInCatchVariables": true,
		/* Ensure 'use strict' is always emitted. */
		"alwaysStrict": true,
		/* Enable error reporting when local variables aren't read. */
		"noUnusedLocals": false,
		/* Raise an error when a function parameter isn't read. */
		"noUnusedParameters": false,
		/* Enable error reporting for codepaths that do not explicitly return in a function. */
		"noImplicitReturns": true,
		/* Enable error reporting for fallthrough cases in switch statements. */
		"noFallthroughCasesInSwitch": true,
		/* Add 'undefined' to a type when accessed using an index. */
		"noUncheckedIndexedAccess": true,
		/* Ensure overriding members in derived classes are marked with an override modifier. */
		"noImplicitOverride": true,
		/* Enforces using indexed accessors for keys declared using an indexed type. */
		"noPropertyAccessFromIndexSignature": true,
		/* Skip type checking all .d.ts files. */
		"skipLibCheck": false
	}
}