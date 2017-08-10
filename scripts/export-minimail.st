repository := MCFileTreeRepository new
	directory: './pharo-core/src' asFileReference;
	yourself.
	
packageNames := #('AST-Core' 'Announcements-Core' 'Colors' 'Collections-Abstract' 'Collections-Arithmetic' 'Collections-Atomic' 'Collections-Native' 'Collections-Sequenceable' 'Collections-Stack' 'Collections-Streams' 'Collections-Strings' 'Collections-Support' 'Collections-Unordered' 'Collections-Weak' 'Files' 'FileSystem-Path' 'Hermes' 'Jobs' 'Kernel' 'Kernel-BytecodeEncoders' 'Network-UUID' 'NonInteractiveTranscript' 'PharoBootstrap-Initialization' 'RPackage-Core' 'Random-Core' 'Slot' 'System-Announcements' 'System-BasicCommandLineHandler' 'System-CommandLine' 'System-CommandLineHandler' 'System-Finalization' 'System-Hashing' 'System-Model' 'System-Platforms' 'System-SessionManager' 'System-Sources' 'System-Support' 'Traits' 'Transcript' 'UIManager' 'Zinc-Character-Encoding-Core').

	
environment := repository asRing2EnvironmentWith: packageNames.		
		
usedClasses := ((FileStream readOnlyFileNamed: 'specifications/minimal-classes.txt') contentsOfEntireFile lines collect: #asSymbol) asIdentitySet.	
calledMethods := ((FileStream readOnlyFileNamed: 'specifications/minimal-methods.txt') contentsOfEntireFile lines collect: #asSymbol) asIdentitySet.

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

	Smalltalk primitiveGarbageCollect.
	Smalltalk exit: 42.
'.	
	
environment removeEmptyMethodTags.
environment fixProtoObjectClassSuperclass.
environment addGlobalsNamed: #(#Smalltalk #SourceFiles #Transcript #Undeclared #Display #TextConstants  #Sensor #Processor #SystemOrganization).
environment clean.

outputRepo := MCFileTreeRepository new
	directory: './src-minimal' asFileReference ensureCreateDirectory;
	yourself.

environment writeIntoFileTree: outputRepo.

