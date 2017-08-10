repository := MCFileTreeRepository new
	directory: './pharo-core/src' asFileReference;
	yourself.
	
packageNames := #('AST-Core' 'Announcements-Core' 'Colors' 'Collections-Abstract' 'Collections-Arithmetic' 'Collections-Atomic' 'Collections-Native' 'Collections-Sequenceable' 'Collections-Stack' 'Collections-Streams' 'Collections-Strings' 'Collections-Support' 'Collections-Unordered' 'Collections-Weak' 'Files' 'FileSystem-Path' 'Hermes' 'Jobs' 'Kernel' 'Kernel-BytecodeEncoders' 'Network-UUID' 'NonInteractiveTranscript' 'PharoBootstrap-Initialization' 'RPackage-Core' 'Random-Core' 'Slot' 'System-Announcements' 'System-BasicCommandLineHandler' 'System-CommandLine' 'System-CommandLineHandler' 'System-Finalization' 'System-Hashing' 'System-Model' 'System-Platforms' 'System-SessionManager' 'System-Sources' 'System-Support' 'Traits' 'Transcript' 'UIManager' 'Zinc-Character-Encoding-Core').

	
environment := repository asRing2EnvironmentWith: packageNames.		
		
usedClasses := ((FileStream readOnlyFileNamed: 'specifications/minimal-classes.txt') contentsOfEntireFile lines collect: #asSymbol) asIdentitySet.	
calledMethods := ((FileStream readOnlyFileNamed: 'specifications/minimal-methods.txt') contentsOfEntireFile lines collect: #asSymbol) asIdentitySet.
usedClasses addAll: ((FileStream readOnlyFileNamed: 'specifications/hello-classes.txt') contentsOfEntireFile lines collect: #asSymbol) asIdentitySet.	
calledMethods addAll: ((FileStream readOnlyFileNamed: 'specifications/hello-methods.txt') contentsOfEntireFile lines collect: #asSymbol) asIdentitySet.
environment removeAllButBehaviorsNamed: usedClasses.
environment removeAllButMethodsNamed: calledMethods.	
 
((environment ask behaviorNamed: #String) methodNamed: #asSlotCollection) sourceCode: 
'asSlotCollection
	"Parse as slots.
	Example: 
	  ''a b'' asSlotCollection --> {a => Slot. b => Slot}
	"
	^(self substrings: '' '') collect: [ :substring | substring asSlot ]	'.

((environment ask behaviorNamed: #SlotClassBuilder) methodNamed: #validateClassName) sourceCode: 
'validateClassName'.	

((environment ask behaviorNamed: #'PharoBootstrapInitialization class') methodNamed: #initializeCommandLineHandlerAndErrorHandling) sourceCode: 
'initializeCommandLineHandlerAndErrorHandling
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
	UIManager classVarNamed: ''Default'' put: NonInteractiveUIManager new.
	UIManager default activate.

	Smalltalk sourceFileVersionString: ''PharoV60''.
	(Smalltalk class classVariableNamed: ''LastImagePath'') value: 	Smalltalk primImagePath. 
	SourceFiles := SourceFileArray new.
	
	ASTCache initialize.
	Stdio initialize.
	"NonInteractiveTranscript iniatialize."
	Stdio stdout nextPutAll: ''Hello World!''; lf.
	Smalltalk exit: 42.
'.
	
	
((environment ask behaviorNamed: #SmalltalkImage) ensureLocalMethodNamed: #primitiveClipboardText:) sourceCode:
'primitiveClipboardText: aString
	<primitive: 141>'.
	
((environment ask behaviorNamed: #ProtoObject) ensureLocalMethodNamed: #doesNotUnderstand:) sourceCode:
'doesNotUnderstand: aMessage
	Smalltalk primitiveClipboardText: aMessage selector.
	[ true ] whileTrue. 
	Smalltalk exit: 1'.	
	
environment removeEmptyMethodTags.
environment fixProtoObjectClassSuperclass.
environment addGlobalsNamed: #(#Smalltalk #SourceFiles #Transcript #Undeclared #Display #TextConstants  #Sensor #Processor #SystemOrganization).
environment clean.

outputRepo := MCFileTreeRepository new
	directory: './src-hello' asFileReference ensureCreateDirectory;
	yourself.

environment writeIntoFileTree: outputRepo.

