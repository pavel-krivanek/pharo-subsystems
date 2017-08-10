repository := MCFileTreeRepository new
	directory: './src-minimal' asFileReference;
	yourself.
	
environment := repository asRing2Environment.		

"environment removeEmptyMethodTags."
environment fixProtoObjectClassSuperclass.
environment addGlobalsNamed: #(#Smalltalk #SourceFiles #Transcript #Undeclared #Display #TextConstants  #Sensor #Processor #SystemOrganization).
environment clean.

"environment browse."

environment bootstrap.
