public api
initializeCommandLineHandlerAndErrorHandling
	"This method is run before the new bootstrapped image is saved!"
	
	| allBehaviors allMethods |

	ProcessorScheduler initialize.
	
	Object initialize.
	ChronologyConstants initialize.
	DateAndTime initialize.
	SessionManager default installNewSession.
	Delay initialize.
	SmallInteger initialize.
	ProcessorScheduler startUp.
	OSPlatform startUp: true.
	String initialize.
	ByteString initialize. 
	ZnUTF8Encoder initialize.	
	Smalltalk specialObjectsArray at: 42 put: Semaphore new.
	"WeakArray restartFinalizationProcess."
	
	Smalltalk globals 
		at: #Transcript
		put: (NonInteractiveTranscript stdout install).
	Float initialize.

	SetElement initialize.
	ExternalSemaphoreTable initialize.
	Collection initialize.
	CompiledMethod initialize.
	Categorizer initialize.
	Slot initialize.
	TraitBehavior initialize.
	
	RPackage initialize.
	Behavior initializeClassProperties.
	UIManager classVarNamed: 'Default' put: NonInteractiveUIManager new.
	UIManager default activate.

	Smalltalk sourceFileVersionString: 'PharoV60'.
	(Smalltalk class classVariableNamed: 'LastImagePath') value: 	Smalltalk primImagePath. 
	SourceFiles := SourceFileArray new.
	
	ASTCache initialize.
	Stdio initialize.
	"NonInteractiveTranscript iniatialize."
	Stdio stdout nextPutAll: 'Hello World!'; lf.
	Smalltalk exit: 42.
