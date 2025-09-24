local loTaskBarWrapper as Object, lcRutaInicial as String, loEstados as Collection, loDlls as Collection

lcRutaInicial = iif( type( "_Screen.Zoo.cRutaInicial" ) = "C", _Screen.Zoo.cRutaInicial, sys(2004) )
loEstados = newobject( "collection" )
loEstados.Add( 0, "NOPROGRESS" )
loEstados.Add( 1, "INDETERMINATE" )
loEstados.Add( 2, "NORMAL" )
loEstados.Add( 4, "ERROR" )
loEstados.Add( 8, "PAUSED" )

loDlls = newobject( "collection" )
loDlls.add( "Microsoft.WindowsAPICodePack.dll" )
loDlls.add( "Microsoft.WindowsAPICodePack.Shell.dll" )
loDlls.add( "TaskBarWrapper.dll" )


loTaskBarWrapper = newobject( "TaskBarWrapper", "TaskBarWrapper.prg", "", lcRutaInicial, loEstados, loDlls )

return loTaskBarWrapper