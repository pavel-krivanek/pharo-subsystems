Iceberg enableMetacelloIntegration: true.

Metacello new
  baseline: 'Calypso';
  repository: 'github://dionisiydk/Calypso';
  load.

Metacello new
  baseline: 'Ring2';
  repository: 'github://pavel-krivanek/Ring2/src';
  load: #all.
  
GTPlayground openContents: 'playground.st' sFileReference readStream contents.

