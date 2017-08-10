"Iceberg enableMetacelloIntegration: true."

Metacello new
  baseline: 'PharoBootstrapProcess';
  repository: 'filetree://pharo-core/bootstrap/src';
  load.

Metacello new
  baseline: 'Calypso';
  repository: 'github://dionisiydk/Calypso';
  load.

Metacello new
  baseline: 'Ring2';
  repository: 'github://pavel-krivanek/Ring2/src';
  load: #all.
  
'scripts' asFileReference children do: [ :script | (GTPlayground openContents: script readStream contents) window title: script basename. ]
