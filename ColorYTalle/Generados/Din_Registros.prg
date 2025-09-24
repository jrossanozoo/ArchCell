

define class din_Registros as custom
	oDatos = null

	nNodo = 0
	lAccess = .f.
	lDestroy = .f.

	Adnimplant = null
	Colorytalle = null
	Dibujante = null
	Felino = null
	Generadores = null
	Nucleo = null

	function init() as void
		with this
			.oDatos = _Screen.zoo.crearObjeto( 'DatosREGISTROS' )
			.Adnimplant = newobject( "Parametros_Adnimplant") 
			.Colorytalle = newobject( "Parametros_Colorytalle") 
			.Dibujante = newobject( "Parametros_Dibujante") 
			.Felino = newobject( "Parametros_Felino") 
			.Generadores = newobject( "Parametros_Generadores") 
			.Nucleo = newobject( "Parametros_Nucleo") 
		endwith
	endfunc


			*-----------------------------------------------------------------------------------------
			function Destroy()
				local lnCantidad as Integer, laPropiedades as array, lnTablaActual as Integer,;
				lnPropiedadActual as Integer, lcPropiedad as String, lcEliminaReferencia as String    
				dimension laPropiedades(1)

				this.lDestroy = .t.

				lnCantidad = Amembers(laPropiedades,this,0,"U" )
				for lnPropiedadActual = 1 to lnCantidad
					lcPropiedad = "this."+ alltrim(laPropiedades(lnPropiedadActual))
					if vartype ( evaluate(lcPropiedad) ) = "O"
						if pemstatus(&lcPropiedad,"release",5)
							lcEliminaReferencia = lcPropiedad + ".release"
							&lcEliminaReferencia
						endif
					endif
				endfor

			endfunc

			*-----------------------------------------------------------------------------------------
			function Release() as Void
				release this 
			endfunc 
enddefine


define class Parametros_Adnimplant as custom

	nNodo = 1
	lAccess = .f.
	lDestroy = .f.

	function init() as void
		with this
		endwith
	endfunc


			*-----------------------------------------------------------------------------------------
			function Destroy()
				local lnCantidad as Integer, laPropiedades as array, lnTablaActual as Integer,;
				lnPropiedadActual as Integer, lcPropiedad as String, lcEliminaReferencia as String    
				dimension laPropiedades(1)

				this.lDestroy = .t.

				lnCantidad = Amembers(laPropiedades,this,0,"U" )
				for lnPropiedadActual = 1 to lnCantidad
					lcPropiedad = "this."+ alltrim(laPropiedades(lnPropiedadActual))
					if vartype ( evaluate(lcPropiedad) ) = "O"
						if pemstatus(&lcPropiedad,"release",5)
							lcEliminaReferencia = lcPropiedad + ".release"
							&lcEliminaReferencia
						endif
					endif
				endfor

			endfunc

			*-----------------------------------------------------------------------------------------
			function Release() as Void
				release this 
			endfunc 
enddefine


define class Parametros_Colorytalle as custom

	nNodo = 1
	lAccess = .f.
	lDestroy = .f.

	CompatibilidadLincev3 = null

	function init() as void
		with this
			.CompatibilidadLincev3 = newobject( "COLORYTALLE_CompatibilidadLincev3") 
		endwith
	endfunc


			*-----------------------------------------------------------------------------------------
			function Destroy()
				local lnCantidad as Integer, laPropiedades as array, lnTablaActual as Integer,;
				lnPropiedadActual as Integer, lcPropiedad as String, lcEliminaReferencia as String    
				dimension laPropiedades(1)

				this.lDestroy = .t.

				lnCantidad = Amembers(laPropiedades,this,0,"U" )
				for lnPropiedadActual = 1 to lnCantidad
					lcPropiedad = "this."+ alltrim(laPropiedades(lnPropiedadActual))
					if vartype ( evaluate(lcPropiedad) ) = "O"
						if pemstatus(&lcPropiedad,"release",5)
							lcEliminaReferencia = lcPropiedad + ".release"
							&lcEliminaReferencia
						endif
					endif
				endfor

			endfunc

			*-----------------------------------------------------------------------------------------
			function Release() as Void
				release this 
			endfunc 
enddefine


define class COLORYTALLE_CompatibilidadLincev3 as custom

	nNodo = 2
	lAccess = .f.
	lDestroy = .f.

	Estadodelsistema = '_20g0sdwj1'

	function init() as void
		with this
		endwith
	endfunc

	function Estadodelsistema_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 2
					.Parametro = 'EstadoDelSistema'
					.Proyecto = 'COLORYTALLE'
					.TipoDato = 'C'
					.Default = '_20g0sdwj1'
					.IdUnico = '1C20B7F131495214C68190E312123386117171'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Estadodelsistema = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Estadodelsistema = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Estadodelsistema

			endif
		endwith
	endfunc

	function Estadodelsistema_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 2
						.Parametro = 'EstadoDelSistema'
						.Proyecto = 'COLORYTALLE'
						.TipoDato = 'C'
						.Default = '_20g0sdwj1'
						.IdUnico = '1C20B7F131495214C68190E312123386117171'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Estadodelsistema = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Estadodelsistema = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Estadodelsistema = txValor 
				return .Estadodelsistema

			endif
		endwith
	endfunc


			*-----------------------------------------------------------------------------------------
			function Destroy()
				local lnCantidad as Integer, laPropiedades as array, lnTablaActual as Integer,;
				lnPropiedadActual as Integer, lcPropiedad as String, lcEliminaReferencia as String    
				dimension laPropiedades(1)

				this.lDestroy = .t.

				lnCantidad = Amembers(laPropiedades,this,0,"U" )
				for lnPropiedadActual = 1 to lnCantidad
					lcPropiedad = "this."+ alltrim(laPropiedades(lnPropiedadActual))
					if vartype ( evaluate(lcPropiedad) ) = "O"
						if pemstatus(&lcPropiedad,"release",5)
							lcEliminaReferencia = lcPropiedad + ".release"
							&lcEliminaReferencia
						endif
					endif
				endfor

			endfunc

			*-----------------------------------------------------------------------------------------
			function Release() as Void
				release this 
			endfunc 
enddefine


define class Parametros_Dibujante as custom

	nNodo = 1
	lAccess = .f.
	lDestroy = .f.

	ModoDeComportamiento = null
	Acomodador = null
	Zoogrillaextensible = null
	Listados = null
	Codigodebarras = null
	Reportes = null

	EspacioVerticalSubgrupo = 3
	Imagendefaultdelaempresa = ''
	Iconodefaultdelosformularios = 'zooIcon.ico'
	Detalleitemparte = 50
	Colorparaadvertenciasvisuales = 255
	Fuenteestilo1nombre = 'DIN MITTELSCHRIFT STD'
	Fuenteestilo1tamanio = 14
	Fuenteestilo2tamanio = 8
	Fuenteestilo2nombre = 'TAHOMA'
	Teclaaccesorapidobuscadorespecifico = 'F4'
	Margentextboxestilo1 = 4
	Margentextboxestilo2 = 4
	Backcolormenu = 13160660
	Colordeetiquetasdeshabilitadas = 8421504
	Caracterseparadordeatributosdecombinacionparaimpresiondecodigodebarras = '!'
	Teclaaccesorapidoaccionesespecificas = 'F9'
	Teclaaccesorapidograbar = -6
	Permitirtodotipodecaracteresenobservacion = .T.

	function init() as void
		with this
			.ModoDeComportamiento = newobject( "DIBUJANTE_ModoDeComportamiento") 
			.Acomodador = newobject( "DIBUJANTE_Acomodador") 
			.Zoogrillaextensible = newobject( "DIBUJANTE_Zoogrillaextensible") 
			.Listados = newobject( "DIBUJANTE_Listados") 
			.Codigodebarras = newobject( "DIBUJANTE_Codigodebarras") 
			.Reportes = newobject( "DIBUJANTE_Reportes") 
		endwith
	endfunc

	function EspacioVerticalSubgrupo_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Espacio Vertical SubGrupo'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 3
					.IdUnico = '152EC0B871895F1412F1BA7C12681215709501'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.EspacioVerticalSubgrupo = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.EspacioVerticalSubgrupo = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .EspacioVerticalSubgrupo

			endif
		endwith
	endfunc

	function EspacioVerticalSubgrupo_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Espacio Vertical SubGrupo'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 3
						.IdUnico = '152EC0B871895F1412F1BA7C12681215709501'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.EspacioVerticalSubgrupo = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.EspacioVerticalSubgrupo = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.EspacioVerticalSubgrupo = txValor 
				return .EspacioVerticalSubgrupo

			endif
		endwith
	endfunc

	function Imagendefaultdelaempresa_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Imagen Default de la Empresa'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'C'
					.Default = ''
					.IdUnico = '1CBF24468171A21458B199A319037272896461'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Imagendefaultdelaempresa = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Imagendefaultdelaempresa = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Imagendefaultdelaempresa

			endif
		endwith
	endfunc

	function Imagendefaultdelaempresa_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Imagen Default de la Empresa'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'C'
						.Default = ''
						.IdUnico = '1CBF24468171A21458B199A319037272896461'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Imagendefaultdelaempresa = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Imagendefaultdelaempresa = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Imagendefaultdelaempresa = txValor 
				return .Imagendefaultdelaempresa

			endif
		endwith
	endfunc

	function Iconodefaultdelosformularios_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Icono Default de los formularios'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'C'
					.Default = 'zooIcon.ico'
					.IdUnico = '12130F6361EB961426D1A10217535731666331'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Iconodefaultdelosformularios = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Iconodefaultdelosformularios = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Iconodefaultdelosformularios

			endif
		endwith
	endfunc

	function Iconodefaultdelosformularios_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Icono Default de los formularios'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'C'
						.Default = 'zooIcon.ico'
						.IdUnico = '12130F6361EB961426D1A10217535731666331'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Iconodefaultdelosformularios = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Iconodefaultdelosformularios = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Iconodefaultdelosformularios = txValor 
				return .Iconodefaultdelosformularios

			endif
		endwith
	endfunc

	function Detalleitemparte_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'DetalleItemParte'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 50
					.IdUnico = '1159F9AD51B3BC1424A1AB1410246720859001'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Detalleitemparte = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Detalleitemparte = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Detalleitemparte

			endif
		endwith
	endfunc

	function Detalleitemparte_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'DetalleItemParte'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 50
						.IdUnico = '1159F9AD51B3BC1424A1AB1410246720859001'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Detalleitemparte = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Detalleitemparte = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Detalleitemparte = txValor 
				return .Detalleitemparte

			endif
		endwith
	endfunc

	function Colorparaadvertenciasvisuales_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Color para advertencias visuales'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 255
					.IdUnico = '1561B283814D3B1437F1820B19968951181801'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Colorparaadvertenciasvisuales = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Colorparaadvertenciasvisuales = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Colorparaadvertenciasvisuales

			endif
		endwith
	endfunc

	function Colorparaadvertenciasvisuales_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Color para advertencias visuales'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 255
						.IdUnico = '1561B283814D3B1437F1820B19968951181801'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Colorparaadvertenciasvisuales = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Colorparaadvertenciasvisuales = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Colorparaadvertenciasvisuales = txValor 
				return .Colorparaadvertenciasvisuales

			endif
		endwith
	endfunc

	function Fuenteestilo1nombre_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'FuenteEstilo1Nombre'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'C'
					.Default = 'DIN MITTELSCHRIFT STD'
					.IdUnico = '1C28951D21001E14FCE1BBE712526845363501'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Fuenteestilo1nombre = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Fuenteestilo1nombre = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Fuenteestilo1nombre

			endif
		endwith
	endfunc

	function Fuenteestilo1nombre_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'FuenteEstilo1Nombre'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'C'
						.Default = 'DIN MITTELSCHRIFT STD'
						.IdUnico = '1C28951D21001E14FCE1BBE712526845363501'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Fuenteestilo1nombre = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Fuenteestilo1nombre = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Fuenteestilo1nombre = txValor 
				return .Fuenteestilo1nombre

			endif
		endwith
	endfunc

	function Fuenteestilo1tamanio_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'FuenteEstilo1Tamanio'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 14
					.IdUnico = '1725C77791D6F314FA818D6816324496193801'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Fuenteestilo1tamanio = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Fuenteestilo1tamanio = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Fuenteestilo1tamanio

			endif
		endwith
	endfunc

	function Fuenteestilo1tamanio_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'FuenteEstilo1Tamanio'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 14
						.IdUnico = '1725C77791D6F314FA818D6816324496193801'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Fuenteestilo1tamanio = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Fuenteestilo1tamanio = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Fuenteestilo1tamanio = txValor 
				return .Fuenteestilo1tamanio

			endif
		endwith
	endfunc

	function Fuenteestilo2tamanio_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'FuenteEstilo2Tamanio'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 8
					.IdUnico = '10F3B77B312C30142361B36412536985229551'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Fuenteestilo2tamanio = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Fuenteestilo2tamanio = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Fuenteestilo2tamanio

			endif
		endwith
	endfunc

	function Fuenteestilo2tamanio_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'FuenteEstilo2Tamanio'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 8
						.IdUnico = '10F3B77B312C30142361B36412536985229551'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Fuenteestilo2tamanio = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Fuenteestilo2tamanio = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Fuenteestilo2tamanio = txValor 
				return .Fuenteestilo2tamanio

			endif
		endwith
	endfunc

	function Fuenteestilo2nombre_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'FuenteEstilo2Nombre'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'C'
					.Default = 'TAHOMA'
					.IdUnico = '197DCA95F1702E14A531B24612496243607981'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Fuenteestilo2nombre = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Fuenteestilo2nombre = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Fuenteestilo2nombre

			endif
		endwith
	endfunc

	function Fuenteestilo2nombre_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'FuenteEstilo2Nombre'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'C'
						.Default = 'TAHOMA'
						.IdUnico = '197DCA95F1702E14A531B24612496243607981'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Fuenteestilo2nombre = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Fuenteestilo2nombre = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Fuenteestilo2nombre = txValor 
				return .Fuenteestilo2nombre

			endif
		endwith
	endfunc

	function Teclaaccesorapidobuscadorespecifico_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Tecla Acceso Rapido Buscador Especifico'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'C'
					.Default = 'F4'
					.IdUnico = '153857B6312E3F145B1187FD14675995778941'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Teclaaccesorapidobuscadorespecifico = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Teclaaccesorapidobuscadorespecifico = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Teclaaccesorapidobuscadorespecifico

			endif
		endwith
	endfunc

	function Teclaaccesorapidobuscadorespecifico_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Tecla Acceso Rapido Buscador Especifico'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'C'
						.Default = 'F4'
						.IdUnico = '153857B6312E3F145B1187FD14675995778941'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Teclaaccesorapidobuscadorespecifico = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Teclaaccesorapidobuscadorespecifico = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Teclaaccesorapidobuscadorespecifico = txValor 
				return .Teclaaccesorapidobuscadorespecifico

			endif
		endwith
	endfunc

	function Margentextboxestilo1_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'MargenTextBoxEstilo1'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 4
					.IdUnico = '1457CF27A1143A145D41A3C413024631954191'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Margentextboxestilo1 = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Margentextboxestilo1 = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Margentextboxestilo1

			endif
		endwith
	endfunc

	function Margentextboxestilo1_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'MargenTextBoxEstilo1'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 4
						.IdUnico = '1457CF27A1143A145D41A3C413024631954191'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Margentextboxestilo1 = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Margentextboxestilo1 = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Margentextboxestilo1 = txValor 
				return .Margentextboxestilo1

			endif
		endwith
	endfunc

	function Margentextboxestilo2_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'MargenTextBoxEstilo2'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 4
					.IdUnico = '15EA513C91D60E14D071932C14121145236671'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Margentextboxestilo2 = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Margentextboxestilo2 = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Margentextboxestilo2

			endif
		endwith
	endfunc

	function Margentextboxestilo2_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'MargenTextBoxEstilo2'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 4
						.IdUnico = '15EA513C91D60E14D071932C14121145236671'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Margentextboxestilo2 = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Margentextboxestilo2 = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Margentextboxestilo2 = txValor 
				return .Margentextboxestilo2

			endif
		endwith
	endfunc

	function Backcolormenu_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'BackColorMenu'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 13160660
					.IdUnico = '1E5FCC51D1690E14FFC1BF0012730893158001'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Backcolormenu = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Backcolormenu = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Backcolormenu

			endif
		endwith
	endfunc

	function Backcolormenu_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'BackColorMenu'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 13160660
						.IdUnico = '1E5FCC51D1690E14FFC1BF0012730893158001'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Backcolormenu = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Backcolormenu = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Backcolormenu = txValor 
				return .Backcolormenu

			endif
		endwith
	endfunc

	function Colordeetiquetasdeshabilitadas_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Color de etiquetas deshabilitadas'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 8421504
					.IdUnico = '10445E3D21E34E14F831BDE817527931814751'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Colordeetiquetasdeshabilitadas = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Colordeetiquetasdeshabilitadas = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Colordeetiquetasdeshabilitadas

			endif
		endwith
	endfunc

	function Colordeetiquetasdeshabilitadas_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Color de etiquetas deshabilitadas'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 8421504
						.IdUnico = '10445E3D21E34E14F831BDE817527931814751'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Colordeetiquetasdeshabilitadas = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Colordeetiquetasdeshabilitadas = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Colordeetiquetasdeshabilitadas = txValor 
				return .Colordeetiquetasdeshabilitadas

			endif
		endwith
	endfunc

	function Caracterseparadordeatributosdecombinacionparaimpresiondecodigodebarras_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Caracter separador de atributos de combinación para impresión de código de barras'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'C'
					.Default = '!'
					.IdUnico = '1B449C6861E6021493D18BF410033430620541'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Caracterseparadordeatributosdecombinacionparaimpresiondecodigodebarras = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Caracterseparadordeatributosdecombinacionparaimpresiondecodigodebarras = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Caracterseparadordeatributosdecombinacionparaimpresiondecodigodebarras

			endif
		endwith
	endfunc

	function Caracterseparadordeatributosdecombinacionparaimpresiondecodigodebarras_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Caracter separador de atributos de combinación para impresión de código de barras'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'C'
						.Default = '!'
						.IdUnico = '1B449C6861E6021493D18BF410033430620541'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Caracterseparadordeatributosdecombinacionparaimpresiondecodigodebarras = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Caracterseparadordeatributosdecombinacionparaimpresiondecodigodebarras = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Caracterseparadordeatributosdecombinacionparaimpresiondecodigodebarras = txValor 
				return .Caracterseparadordeatributosdecombinacionparaimpresiondecodigodebarras

			endif
		endwith
	endfunc

	function Teclaaccesorapidoaccionesespecificas_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Tecla Acceso Rapido para acciones especificas'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'C'
					.Default = 'F9'
					.IdUnico = '1EA1833B71065B14027188CF11848164052001'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Teclaaccesorapidoaccionesespecificas = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Teclaaccesorapidoaccionesespecificas = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Teclaaccesorapidoaccionesespecificas

			endif
		endwith
	endfunc

	function Teclaaccesorapidoaccionesespecificas_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Tecla Acceso Rapido para acciones especificas'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'C'
						.Default = 'F9'
						.IdUnico = '1EA1833B71065B14027188CF11848164052001'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Teclaaccesorapidoaccionesespecificas = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Teclaaccesorapidoaccionesespecificas = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Teclaaccesorapidoaccionesespecificas = txValor 
				return .Teclaaccesorapidoaccionesespecificas

			endif
		endwith
	endfunc

	function Teclaaccesorapidograbar_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Tecla Acceso Rapido Grabar'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = -6
					.IdUnico = '1DAB6F76C19F371495B196B513253826379401'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Teclaaccesorapidograbar = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Teclaaccesorapidograbar = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Teclaaccesorapidograbar

			endif
		endwith
	endfunc

	function Teclaaccesorapidograbar_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Tecla Acceso Rapido Grabar'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = -6
						.IdUnico = '1DAB6F76C19F371495B196B513253826379401'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Teclaaccesorapidograbar = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Teclaaccesorapidograbar = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Teclaaccesorapidograbar = txValor 
				return .Teclaaccesorapidograbar

			endif
		endwith
	endfunc

	function Permitirtodotipodecaracteresenobservacion_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 1
					.Parametro = 'PermitirTodoTipoDeCaracteresEnObservacion'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'L'
					.Default = .T.
					.IdUnico = '189F3B6CA1C94014F7C1B6CF13466096519631'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Permitirtodotipodecaracteresenobservacion = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Permitirtodotipodecaracteresenobservacion = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Permitirtodotipodecaracteresenobservacion

			endif
		endwith
	endfunc

	function Permitirtodotipodecaracteresenobservacion_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 1
						.Parametro = 'PermitirTodoTipoDeCaracteresEnObservacion'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'L'
						.Default = .T.
						.IdUnico = '189F3B6CA1C94014F7C1B6CF13466096519631'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Permitirtodotipodecaracteresenobservacion = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Permitirtodotipodecaracteresenobservacion = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Permitirtodotipodecaracteresenobservacion = txValor 
				return .Permitirtodotipodecaracteresenobservacion

			endif
		endwith
	endfunc


			*-----------------------------------------------------------------------------------------
			function Destroy()
				local lnCantidad as Integer, laPropiedades as array, lnTablaActual as Integer,;
				lnPropiedadActual as Integer, lcPropiedad as String, lcEliminaReferencia as String    
				dimension laPropiedades(1)

				this.lDestroy = .t.

				lnCantidad = Amembers(laPropiedades,this,0,"U" )
				for lnPropiedadActual = 1 to lnCantidad
					lcPropiedad = "this."+ alltrim(laPropiedades(lnPropiedadActual))
					if vartype ( evaluate(lcPropiedad) ) = "O"
						if pemstatus(&lcPropiedad,"release",5)
							lcEliminaReferencia = lcPropiedad + ".release"
							&lcEliminaReferencia
						endif
					endif
				endfor

			endfunc

			*-----------------------------------------------------------------------------------------
			function Release() as Void
				release this 
			endfunc 
enddefine


define class DIBUJANTE_ModoDeComportamiento as custom

	nNodo = 2
	lAccess = .f.
	lDestroy = .f.

	SinChequeos = 1
	ConChequeoDeRepeticionDeCodigoNoDejaPasarBlanco = 2
	ConChequeoDeExistenciaDeCodigoNoDejaPasarBlanco = 3
	ConChequeoDeExistenciaDeCodigoDejandoPasarElBlanco = 4
	ConChequeoDeExistenciaDeCodigoDejandoPasarCualquiera = 5
	ConBusquedaDejandoPasarCualquiera = 6
	ConChequeoDeRepeticionDeCodigoDejandoPasarElBlanco = 7
	ConBusquedaDejandoPasarCualquieraConSignoMasHabilitado = 8
	ConChequeoDeExistenciaDeCodigoDejandoPasarElBlancoConSignoMasAnulado = 9

	function init() as void
		with this
		endwith
	endfunc

	function SinChequeos_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 2
					.Parametro = 'Sin chequeos'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 1
					.IdUnico = '156FB221A1B3CD14DDC1918915202758974001'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.SinChequeos = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.SinChequeos = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .SinChequeos

			endif
		endwith
	endfunc

	function SinChequeos_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 2
						.Parametro = 'Sin chequeos'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 1
						.IdUnico = '156FB221A1B3CD14DDC1918915202758974001'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.SinChequeos = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.SinChequeos = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.SinChequeos = txValor 
				return .SinChequeos

			endif
		endwith
	endfunc

	function ConChequeoDeRepeticionDeCodigoNoDejaPasarBlanco_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 2
					.Parametro = 'Con chequeo de repetición de código, no deja pasar blanco'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 2
					.IdUnico = '1568296611A70B1441119AD613982141754901'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.ConChequeoDeRepeticionDeCodigoNoDejaPasarBlanco = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.ConChequeoDeRepeticionDeCodigoNoDejaPasarBlanco = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .ConChequeoDeRepeticionDeCodigoNoDejaPasarBlanco

			endif
		endwith
	endfunc

	function ConChequeoDeRepeticionDeCodigoNoDejaPasarBlanco_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 2
						.Parametro = 'Con chequeo de repetición de código, no deja pasar blanco'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 2
						.IdUnico = '1568296611A70B1441119AD613982141754901'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.ConChequeoDeRepeticionDeCodigoNoDejaPasarBlanco = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.ConChequeoDeRepeticionDeCodigoNoDejaPasarBlanco = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.ConChequeoDeRepeticionDeCodigoNoDejaPasarBlanco = txValor 
				return .ConChequeoDeRepeticionDeCodigoNoDejaPasarBlanco

			endif
		endwith
	endfunc

	function ConChequeoDeExistenciaDeCodigoNoDejaPasarBlanco_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 2
					.Parametro = 'Con chequeo de existencia de código, no deja pasar blanco'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 3
					.IdUnico = '146A4ED3E1B1C114EFF1A78F17940352992671'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.ConChequeoDeExistenciaDeCodigoNoDejaPasarBlanco = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.ConChequeoDeExistenciaDeCodigoNoDejaPasarBlanco = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .ConChequeoDeExistenciaDeCodigoNoDejaPasarBlanco

			endif
		endwith
	endfunc

	function ConChequeoDeExistenciaDeCodigoNoDejaPasarBlanco_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 2
						.Parametro = 'Con chequeo de existencia de código, no deja pasar blanco'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 3
						.IdUnico = '146A4ED3E1B1C114EFF1A78F17940352992671'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.ConChequeoDeExistenciaDeCodigoNoDejaPasarBlanco = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.ConChequeoDeExistenciaDeCodigoNoDejaPasarBlanco = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.ConChequeoDeExistenciaDeCodigoNoDejaPasarBlanco = txValor 
				return .ConChequeoDeExistenciaDeCodigoNoDejaPasarBlanco

			endif
		endwith
	endfunc

	function ConChequeoDeExistenciaDeCodigoDejandoPasarElBlanco_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 2
					.Parametro = 'Con chequeo de existencia de código, dejando pasar el blanco'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 4
					.IdUnico = '1608CA8B91512514A971960113116371232151'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.ConChequeoDeExistenciaDeCodigoDejandoPasarElBlanco = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.ConChequeoDeExistenciaDeCodigoDejandoPasarElBlanco = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .ConChequeoDeExistenciaDeCodigoDejandoPasarElBlanco

			endif
		endwith
	endfunc

	function ConChequeoDeExistenciaDeCodigoDejandoPasarElBlanco_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 2
						.Parametro = 'Con chequeo de existencia de código, dejando pasar el blanco'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 4
						.IdUnico = '1608CA8B91512514A971960113116371232151'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.ConChequeoDeExistenciaDeCodigoDejandoPasarElBlanco = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.ConChequeoDeExistenciaDeCodigoDejandoPasarElBlanco = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.ConChequeoDeExistenciaDeCodigoDejandoPasarElBlanco = txValor 
				return .ConChequeoDeExistenciaDeCodigoDejandoPasarElBlanco

			endif
		endwith
	endfunc

	function ConChequeoDeExistenciaDeCodigoDejandoPasarCualquiera_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 2
					.Parametro = 'Con chequeo de existencia de código, dejando pasar cualquiera'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 5
					.IdUnico = '19F62E2D010BC21447A18B1919816180420201'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.ConChequeoDeExistenciaDeCodigoDejandoPasarCualquiera = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.ConChequeoDeExistenciaDeCodigoDejandoPasarCualquiera = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .ConChequeoDeExistenciaDeCodigoDejandoPasarCualquiera

			endif
		endwith
	endfunc

	function ConChequeoDeExistenciaDeCodigoDejandoPasarCualquiera_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 2
						.Parametro = 'Con chequeo de existencia de código, dejando pasar cualquiera'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 5
						.IdUnico = '19F62E2D010BC21447A18B1919816180420201'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.ConChequeoDeExistenciaDeCodigoDejandoPasarCualquiera = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.ConChequeoDeExistenciaDeCodigoDejandoPasarCualquiera = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.ConChequeoDeExistenciaDeCodigoDejandoPasarCualquiera = txValor 
				return .ConChequeoDeExistenciaDeCodigoDejandoPasarCualquiera

			endif
		endwith
	endfunc

	function ConBusquedaDejandoPasarCualquiera_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 2
					.Parametro = 'Con búsqueda, dejando pasar cualquiera'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 6
					.IdUnico = '19E82E1E11B0BA1419A1AFDF16380535171511'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.ConBusquedaDejandoPasarCualquiera = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.ConBusquedaDejandoPasarCualquiera = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .ConBusquedaDejandoPasarCualquiera

			endif
		endwith
	endfunc

	function ConBusquedaDejandoPasarCualquiera_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 2
						.Parametro = 'Con búsqueda, dejando pasar cualquiera'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 6
						.IdUnico = '19E82E1E11B0BA1419A1AFDF16380535171511'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.ConBusquedaDejandoPasarCualquiera = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.ConBusquedaDejandoPasarCualquiera = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.ConBusquedaDejandoPasarCualquiera = txValor 
				return .ConBusquedaDejandoPasarCualquiera

			endif
		endwith
	endfunc

	function ConChequeoDeRepeticionDeCodigoDejandoPasarElBlanco_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 2
					.Parametro = 'Con chequeo de repetición de código, dejando pasar el blanco'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 7
					.IdUnico = '1C433162B1FCE6147931AA9615690774174731'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.ConChequeoDeRepeticionDeCodigoDejandoPasarElBlanco = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.ConChequeoDeRepeticionDeCodigoDejandoPasarElBlanco = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .ConChequeoDeRepeticionDeCodigoDejandoPasarElBlanco

			endif
		endwith
	endfunc

	function ConChequeoDeRepeticionDeCodigoDejandoPasarElBlanco_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 2
						.Parametro = 'Con chequeo de repetición de código, dejando pasar el blanco'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 7
						.IdUnico = '1C433162B1FCE6147931AA9615690774174731'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.ConChequeoDeRepeticionDeCodigoDejandoPasarElBlanco = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.ConChequeoDeRepeticionDeCodigoDejandoPasarElBlanco = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.ConChequeoDeRepeticionDeCodigoDejandoPasarElBlanco = txValor 
				return .ConChequeoDeRepeticionDeCodigoDejandoPasarElBlanco

			endif
		endwith
	endfunc

	function ConBusquedaDejandoPasarCualquieraConSignoMasHabilitado_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 2
					.Parametro = 'Con búsqueda, dejando pasar cualquiera con Signo Mas habilitado'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 8
					.IdUnico = '1A4F038351C6451464E1B94313318193843601'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.ConBusquedaDejandoPasarCualquieraConSignoMasHabilitado = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.ConBusquedaDejandoPasarCualquieraConSignoMasHabilitado = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .ConBusquedaDejandoPasarCualquieraConSignoMasHabilitado

			endif
		endwith
	endfunc

	function ConBusquedaDejandoPasarCualquieraConSignoMasHabilitado_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 2
						.Parametro = 'Con búsqueda, dejando pasar cualquiera con Signo Mas habilitado'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 8
						.IdUnico = '1A4F038351C6451464E1B94313318193843601'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.ConBusquedaDejandoPasarCualquieraConSignoMasHabilitado = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.ConBusquedaDejandoPasarCualquieraConSignoMasHabilitado = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.ConBusquedaDejandoPasarCualquieraConSignoMasHabilitado = txValor 
				return .ConBusquedaDejandoPasarCualquieraConSignoMasHabilitado

			endif
		endwith
	endfunc

	function ConChequeoDeExistenciaDeCodigoDejandoPasarElBlancoConSignoMasAnulado_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 2
					.Parametro = 'Con chequeo de existencia de código, dejando pasar el blanco, con Signo Mas anulado'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 9
					.IdUnico = '1D50B1F7516BD1143781BFEF13439584827701'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.ConChequeoDeExistenciaDeCodigoDejandoPasarElBlancoConSignoMasAnulado = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.ConChequeoDeExistenciaDeCodigoDejandoPasarElBlancoConSignoMasAnulado = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .ConChequeoDeExistenciaDeCodigoDejandoPasarElBlancoConSignoMasAnulado

			endif
		endwith
	endfunc

	function ConChequeoDeExistenciaDeCodigoDejandoPasarElBlancoConSignoMasAnulado_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 2
						.Parametro = 'Con chequeo de existencia de código, dejando pasar el blanco, con Signo Mas anulado'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 9
						.IdUnico = '1D50B1F7516BD1143781BFEF13439584827701'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.ConChequeoDeExistenciaDeCodigoDejandoPasarElBlancoConSignoMasAnulado = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.ConChequeoDeExistenciaDeCodigoDejandoPasarElBlancoConSignoMasAnulado = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.ConChequeoDeExistenciaDeCodigoDejandoPasarElBlancoConSignoMasAnulado = txValor 
				return .ConChequeoDeExistenciaDeCodigoDejandoPasarElBlancoConSignoMasAnulado

			endif
		endwith
	endfunc


			*-----------------------------------------------------------------------------------------
			function Destroy()
				local lnCantidad as Integer, laPropiedades as array, lnTablaActual as Integer,;
				lnPropiedadActual as Integer, lcPropiedad as String, lcEliminaReferencia as String    
				dimension laPropiedades(1)

				this.lDestroy = .t.

				lnCantidad = Amembers(laPropiedades,this,0,"U" )
				for lnPropiedadActual = 1 to lnCantidad
					lcPropiedad = "this."+ alltrim(laPropiedades(lnPropiedadActual))
					if vartype ( evaluate(lcPropiedad) ) = "O"
						if pemstatus(&lcPropiedad,"release",5)
							lcEliminaReferencia = lcPropiedad + ".release"
							&lcEliminaReferencia
						endif
					endif
				endfor

			endfunc

			*-----------------------------------------------------------------------------------------
			function Release() as Void
				release this 
			endfunc 
enddefine


define class DIBUJANTE_Acomodador as custom

	nNodo = 3
	lAccess = .f.
	lDestroy = .f.

	AltoSatusBar = 20
	AltoMenu = 25

	function init() as void
		with this
		endwith
	endfunc

	function AltoSatusBar_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 3
					.Parametro = 'Alto Satus Bar'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 20
					.IdUnico = '136B2FA151312A145471BCBE19353124053351'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.AltoSatusBar = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.AltoSatusBar = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .AltoSatusBar

			endif
		endwith
	endfunc

	function AltoSatusBar_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 3
						.Parametro = 'Alto Satus Bar'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 20
						.IdUnico = '136B2FA151312A145471BCBE19353124053351'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.AltoSatusBar = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.AltoSatusBar = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.AltoSatusBar = txValor 
				return .AltoSatusBar

			endif
		endwith
	endfunc

	function AltoMenu_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 3
					.Parametro = 'Alto Menu'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 25
					.IdUnico = '1C3B47BAD1DB0E146DD1A30312309926945501'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.AltoMenu = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.AltoMenu = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .AltoMenu

			endif
		endwith
	endfunc

	function AltoMenu_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 3
						.Parametro = 'Alto Menu'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 25
						.IdUnico = '1C3B47BAD1DB0E146DD1A30312309926945501'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.AltoMenu = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.AltoMenu = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.AltoMenu = txValor 
				return .AltoMenu

			endif
		endwith
	endfunc


			*-----------------------------------------------------------------------------------------
			function Destroy()
				local lnCantidad as Integer, laPropiedades as array, lnTablaActual as Integer,;
				lnPropiedadActual as Integer, lcPropiedad as String, lcEliminaReferencia as String    
				dimension laPropiedades(1)

				this.lDestroy = .t.

				lnCantidad = Amembers(laPropiedades,this,0,"U" )
				for lnPropiedadActual = 1 to lnCantidad
					lcPropiedad = "this."+ alltrim(laPropiedades(lnPropiedadActual))
					if vartype ( evaluate(lcPropiedad) ) = "O"
						if pemstatus(&lcPropiedad,"release",5)
							lcEliminaReferencia = lcPropiedad + ".release"
							&lcEliminaReferencia
						endif
					endif
				endfor

			endfunc

			*-----------------------------------------------------------------------------------------
			function Release() as Void
				release this 
			endfunc 
enddefine


define class DIBUJANTE_Zoogrillaextensible as custom

	nNodo = 4
	lAccess = .f.
	lDestroy = .f.

	Descripcionultimalinea = 'Items:'
	Porcentajevisualdedetallepordefecto = 50

	function init() as void
		with this
		endwith
	endfunc

	function Descripcionultimalinea_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 4
					.Parametro = 'DescripcionUltimaLinea'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'C'
					.Default = 'Items:'
					.IdUnico = '1D12FA1D219272146571A21912478977347461'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Descripcionultimalinea = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Descripcionultimalinea = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Descripcionultimalinea

			endif
		endwith
	endfunc

	function Descripcionultimalinea_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 4
						.Parametro = 'DescripcionUltimaLinea'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'C'
						.Default = 'Items:'
						.IdUnico = '1D12FA1D219272146571A21912478977347461'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Descripcionultimalinea = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Descripcionultimalinea = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Descripcionultimalinea = txValor 
				return .Descripcionultimalinea

			endif
		endwith
	endfunc

	function Porcentajevisualdedetallepordefecto_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 4
					.Parametro = 'Porcentaje Visual De Detalle Por Defecto'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 50
					.IdUnico = '189F616351B4F814F5619C0711215266333501'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Porcentajevisualdedetallepordefecto = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Porcentajevisualdedetallepordefecto = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Porcentajevisualdedetallepordefecto

			endif
		endwith
	endfunc

	function Porcentajevisualdedetallepordefecto_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 4
						.Parametro = 'Porcentaje Visual De Detalle Por Defecto'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 50
						.IdUnico = '189F616351B4F814F5619C0711215266333501'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Porcentajevisualdedetallepordefecto = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Porcentajevisualdedetallepordefecto = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Porcentajevisualdedetallepordefecto = txValor 
				return .Porcentajevisualdedetallepordefecto

			endif
		endwith
	endfunc


			*-----------------------------------------------------------------------------------------
			function Destroy()
				local lnCantidad as Integer, laPropiedades as array, lnTablaActual as Integer,;
				lnPropiedadActual as Integer, lcPropiedad as String, lcEliminaReferencia as String    
				dimension laPropiedades(1)

				this.lDestroy = .t.

				lnCantidad = Amembers(laPropiedades,this,0,"U" )
				for lnPropiedadActual = 1 to lnCantidad
					lcPropiedad = "this."+ alltrim(laPropiedades(lnPropiedadActual))
					if vartype ( evaluate(lcPropiedad) ) = "O"
						if pemstatus(&lcPropiedad,"release",5)
							lcEliminaReferencia = lcPropiedad + ".release"
							&lcEliminaReferencia
						endif
					endif
				endfor

			endfunc

			*-----------------------------------------------------------------------------------------
			function Release() as Void
				release this 
			endfunc 
enddefine


define class DIBUJANTE_Listados as custom

	nNodo = 5
	lAccess = .f.
	lDestroy = .f.

	Porcentajeizquierdodeajusteaderecha = 75
	Diferenciatitulo = 2
	Diferenciapie = -2
	Diferenciapiedeinforme = -3
	Porcentajeanchootros = 30
	Margenderecho = 40
	Multiploensanchedetotales = 2
	Margensuperiorsubtotal = 100
	Delegarordenamientodesubtotalesacrystalreport = .F.
	Margenizquierdototal = 50

	function init() as void
		with this
		endwith
	endfunc

	function Porcentajeizquierdodeajusteaderecha_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 5
					.Parametro = 'Porcentaje Izquierdo De Ajuste a Derecha'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 75
					.IdUnico = '16048DEBF19DEC140D6193E417208319360901'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Porcentajeizquierdodeajusteaderecha = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Porcentajeizquierdodeajusteaderecha = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Porcentajeizquierdodeajusteaderecha

			endif
		endwith
	endfunc

	function Porcentajeizquierdodeajusteaderecha_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 5
						.Parametro = 'Porcentaje Izquierdo De Ajuste a Derecha'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 75
						.IdUnico = '16048DEBF19DEC140D6193E417208319360901'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Porcentajeizquierdodeajusteaderecha = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Porcentajeizquierdodeajusteaderecha = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Porcentajeizquierdodeajusteaderecha = txValor 
				return .Porcentajeizquierdodeajusteaderecha

			endif
		endwith
	endfunc

	function Diferenciatitulo_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 5
					.Parametro = 'Diferencia Titulo'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 2
					.IdUnico = '130EFFE7414688143B11B73C15400158346691'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Diferenciatitulo = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Diferenciatitulo = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Diferenciatitulo

			endif
		endwith
	endfunc

	function Diferenciatitulo_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 5
						.Parametro = 'Diferencia Titulo'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 2
						.IdUnico = '130EFFE7414688143B11B73C15400158346691'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Diferenciatitulo = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Diferenciatitulo = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Diferenciatitulo = txValor 
				return .Diferenciatitulo

			endif
		endwith
	endfunc

	function Diferenciapie_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 5
					.Parametro = 'Diferencia Pie'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = -2
					.IdUnico = '1B2F05A49173DE144FD1A33611531841631101'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Diferenciapie = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Diferenciapie = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Diferenciapie

			endif
		endwith
	endfunc

	function Diferenciapie_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 5
						.Parametro = 'Diferencia Pie'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = -2
						.IdUnico = '1B2F05A49173DE144FD1A33611531841631101'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Diferenciapie = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Diferenciapie = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Diferenciapie = txValor 
				return .Diferenciapie

			endif
		endwith
	endfunc

	function Diferenciapiedeinforme_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 5
					.Parametro = 'Diferencia Pie de Informe'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = -3
					.IdUnico = '19EE9485B1FCC81422819B1915419378305161'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Diferenciapiedeinforme = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Diferenciapiedeinforme = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Diferenciapiedeinforme

			endif
		endwith
	endfunc

	function Diferenciapiedeinforme_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 5
						.Parametro = 'Diferencia Pie de Informe'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = -3
						.IdUnico = '19EE9485B1FCC81422819B1915419378305161'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Diferenciapiedeinforme = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Diferenciapiedeinforme = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Diferenciapiedeinforme = txValor 
				return .Diferenciapiedeinforme

			endif
		endwith
	endfunc

	function Porcentajeanchootros_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 5
					.Parametro = 'Porcentaje Ancho Otros'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 30
					.IdUnico = '1E290B8C51E3E614B371AD1517805474727341'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Porcentajeanchootros = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Porcentajeanchootros = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Porcentajeanchootros

			endif
		endwith
	endfunc

	function Porcentajeanchootros_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 5
						.Parametro = 'Porcentaje Ancho Otros'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 30
						.IdUnico = '1E290B8C51E3E614B371AD1517805474727341'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Porcentajeanchootros = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Porcentajeanchootros = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Porcentajeanchootros = txValor 
				return .Porcentajeanchootros

			endif
		endwith
	endfunc

	function Margenderecho_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 5
					.Parametro = 'Margen Derecho'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 40
					.IdUnico = '13F83122C11A661459719CA118366010254801'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Margenderecho = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Margenderecho = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Margenderecho

			endif
		endwith
	endfunc

	function Margenderecho_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 5
						.Parametro = 'Margen Derecho'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 40
						.IdUnico = '13F83122C11A661459719CA118366010254801'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Margenderecho = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Margenderecho = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Margenderecho = txValor 
				return .Margenderecho

			endif
		endwith
	endfunc

	function Multiploensanchedetotales_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 5
					.Parametro = 'Multiplo Ensanche De Totales'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 2
					.IdUnico = '14F64941A180DC149F91AF6316909766925371'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Multiploensanchedetotales = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Multiploensanchedetotales = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Multiploensanchedetotales

			endif
		endwith
	endfunc

	function Multiploensanchedetotales_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 5
						.Parametro = 'Multiplo Ensanche De Totales'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 2
						.IdUnico = '14F64941A180DC149F91AF6316909766925371'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Multiploensanchedetotales = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Multiploensanchedetotales = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Multiploensanchedetotales = txValor 
				return .Multiploensanchedetotales

			endif
		endwith
	endfunc

	function Margensuperiorsubtotal_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 5
					.Parametro = 'Margen Superior Subtotal'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 100
					.IdUnico = '1D2DCF89C1932F1487A19AAE13555164235261'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Margensuperiorsubtotal = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Margensuperiorsubtotal = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Margensuperiorsubtotal

			endif
		endwith
	endfunc

	function Margensuperiorsubtotal_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 5
						.Parametro = 'Margen Superior Subtotal'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 100
						.IdUnico = '1D2DCF89C1932F1487A19AAE13555164235261'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Margensuperiorsubtotal = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Margensuperiorsubtotal = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Margensuperiorsubtotal = txValor 
				return .Margensuperiorsubtotal

			endif
		endwith
	endfunc

	function Delegarordenamientodesubtotalesacrystalreport_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 5
					.Parametro = 'DelegarOrdenamientoDeSubtotalesACrystalReport'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'L'
					.Default = .F.
					.IdUnico = '12703DBBA1B39C1469E1851C10726009114001'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Delegarordenamientodesubtotalesacrystalreport = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Delegarordenamientodesubtotalesacrystalreport = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Delegarordenamientodesubtotalesacrystalreport

			endif
		endwith
	endfunc

	function Delegarordenamientodesubtotalesacrystalreport_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 5
						.Parametro = 'DelegarOrdenamientoDeSubtotalesACrystalReport'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'L'
						.Default = .F.
						.IdUnico = '12703DBBA1B39C1469E1851C10726009114001'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Delegarordenamientodesubtotalesacrystalreport = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Delegarordenamientodesubtotalesacrystalreport = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Delegarordenamientodesubtotalesacrystalreport = txValor 
				return .Delegarordenamientodesubtotalesacrystalreport

			endif
		endwith
	endfunc

	function Margenizquierdototal_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 5
					.Parametro = 'Margen Izquierdo Total'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 50
					.IdUnico = '12A21EE8A1DA5C14A2B1B2EF18247633686791'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Margenizquierdototal = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Margenizquierdototal = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Margenizquierdototal

			endif
		endwith
	endfunc

	function Margenizquierdototal_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 5
						.Parametro = 'Margen Izquierdo Total'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 50
						.IdUnico = '12A21EE8A1DA5C14A2B1B2EF18247633686791'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Margenizquierdototal = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Margenizquierdototal = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Margenizquierdototal = txValor 
				return .Margenizquierdototal

			endif
		endwith
	endfunc


			*-----------------------------------------------------------------------------------------
			function Destroy()
				local lnCantidad as Integer, laPropiedades as array, lnTablaActual as Integer,;
				lnPropiedadActual as Integer, lcPropiedad as String, lcEliminaReferencia as String    
				dimension laPropiedades(1)

				this.lDestroy = .t.

				lnCantidad = Amembers(laPropiedades,this,0,"U" )
				for lnPropiedadActual = 1 to lnCantidad
					lcPropiedad = "this."+ alltrim(laPropiedades(lnPropiedadActual))
					if vartype ( evaluate(lcPropiedad) ) = "O"
						if pemstatus(&lcPropiedad,"release",5)
							lcEliminaReferencia = lcPropiedad + ".release"
							&lcEliminaReferencia
						endif
					endif
				endfor

			endfunc

			*-----------------------------------------------------------------------------------------
			function Release() as Void
				release this 
			endfunc 
enddefine


define class DIBUJANTE_Codigodebarras as custom

	nNodo = 6
	lAccess = .f.
	lDestroy = .f.

	Anchodecontrolparalecturadecodigodebarrasencomprobantesencaracteres = 30
	Cantidaddecaracteresparalecturadecodigodebarras = 50

	function init() as void
		with this
		endwith
	endfunc

	function Anchodecontrolparalecturadecodigodebarrasencomprobantesencaracteres_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 6
					.Parametro = 'Ancho de control para lectura de código de barras en comprobantes (en caracteres)'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 30
					.IdUnico = '17AD1E6071C6CA14F2B1B45412850488157301'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Anchodecontrolparalecturadecodigodebarrasencomprobantesencaracteres = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Anchodecontrolparalecturadecodigodebarrasencomprobantesencaracteres = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Anchodecontrolparalecturadecodigodebarrasencomprobantesencaracteres

			endif
		endwith
	endfunc

	function Anchodecontrolparalecturadecodigodebarrasencomprobantesencaracteres_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 6
						.Parametro = 'Ancho de control para lectura de código de barras en comprobantes (en caracteres)'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 30
						.IdUnico = '17AD1E6071C6CA14F2B1B45412850488157301'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Anchodecontrolparalecturadecodigodebarrasencomprobantesencaracteres = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Anchodecontrolparalecturadecodigodebarrasencomprobantesencaracteres = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Anchodecontrolparalecturadecodigodebarrasencomprobantesencaracteres = txValor 
				return .Anchodecontrolparalecturadecodigodebarrasencomprobantesencaracteres

			endif
		endwith
	endfunc

	function Cantidaddecaracteresparalecturadecodigodebarras_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 6
					.Parametro = 'Cantidad de caracteres para lectura de código de barras'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 50
					.IdUnico = '1C8C0025F104AC149971861B13623171136361'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Cantidaddecaracteresparalecturadecodigodebarras = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Cantidaddecaracteresparalecturadecodigodebarras = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Cantidaddecaracteresparalecturadecodigodebarras

			endif
		endwith
	endfunc

	function Cantidaddecaracteresparalecturadecodigodebarras_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 6
						.Parametro = 'Cantidad de caracteres para lectura de código de barras'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 50
						.IdUnico = '1C8C0025F104AC149971861B13623171136361'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Cantidaddecaracteresparalecturadecodigodebarras = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Cantidaddecaracteresparalecturadecodigodebarras = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Cantidaddecaracteresparalecturadecodigodebarras = txValor 
				return .Cantidaddecaracteresparalecturadecodigodebarras

			endif
		endwith
	endfunc


			*-----------------------------------------------------------------------------------------
			function Destroy()
				local lnCantidad as Integer, laPropiedades as array, lnTablaActual as Integer,;
				lnPropiedadActual as Integer, lcPropiedad as String, lcEliminaReferencia as String    
				dimension laPropiedades(1)

				this.lDestroy = .t.

				lnCantidad = Amembers(laPropiedades,this,0,"U" )
				for lnPropiedadActual = 1 to lnCantidad
					lcPropiedad = "this."+ alltrim(laPropiedades(lnPropiedadActual))
					if vartype ( evaluate(lcPropiedad) ) = "O"
						if pemstatus(&lcPropiedad,"release",5)
							lcEliminaReferencia = lcPropiedad + ".release"
							&lcEliminaReferencia
						endif
					endif
				endfor

			endfunc

			*-----------------------------------------------------------------------------------------
			function Release() as Void
				release this 
			endfunc 
enddefine


define class DIBUJANTE_Reportes as custom

	nNodo = 7
	lAccess = .f.
	lDestroy = .f.

	Twipspormilimetro = 56.7

	function init() as void
		with this
		endwith
	endfunc

	function Twipspormilimetro_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 7
					.Parametro = 'TwipsPorMilimetro'
					.Proyecto = 'DIBUJANTE'
					.TipoDato = 'N'
					.Default = 56.7
					.IdUnico = '17C5D240E1045714C9F1A2AF13024449564171'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Twipspormilimetro = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Twipspormilimetro = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Twipspormilimetro

			endif
		endwith
	endfunc

	function Twipspormilimetro_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 7
						.Parametro = 'TwipsPorMilimetro'
						.Proyecto = 'DIBUJANTE'
						.TipoDato = 'N'
						.Default = 56.7
						.IdUnico = '17C5D240E1045714C9F1A2AF13024449564171'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Twipspormilimetro = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Twipspormilimetro = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Twipspormilimetro = txValor 
				return .Twipspormilimetro

			endif
		endwith
	endfunc


			*-----------------------------------------------------------------------------------------
			function Destroy()
				local lnCantidad as Integer, laPropiedades as array, lnTablaActual as Integer,;
				lnPropiedadActual as Integer, lcPropiedad as String, lcEliminaReferencia as String    
				dimension laPropiedades(1)

				this.lDestroy = .t.

				lnCantidad = Amembers(laPropiedades,this,0,"U" )
				for lnPropiedadActual = 1 to lnCantidad
					lcPropiedad = "this."+ alltrim(laPropiedades(lnPropiedadActual))
					if vartype ( evaluate(lcPropiedad) ) = "O"
						if pemstatus(&lcPropiedad,"release",5)
							lcEliminaReferencia = lcPropiedad + ".release"
							&lcEliminaReferencia
						endif
					endif
				endfor

			endfunc

			*-----------------------------------------------------------------------------------------
			function Release() as Void
				release this 
			endfunc 
enddefine


define class Parametros_Felino as custom

	nNodo = 1
	lAccess = .f.
	lDestroy = .f.

	EspacioVerticalSubgrupo = 0
	Situacionfiscalempresainscripto = 1
	Situacionfiscalempresanoinscripto = 2
	Situacionfiscalempresamonotributo = 3
	Situacionfiscalclienteinscripto = 1
	Situacionfiscalclientenoinscripto = 2
	Situacionfiscalclienteconsumidorfinal = 3
	Situacionfiscalclienteexento = 4
	Situacionfiscalclienteinscriptonoresponsable = 5
	Situacionfiscalclienteliberado = 6
	Situacionfiscalclientemonotributo = 7
	Situacionfiscalclientemonotributistasocial = 8
	Situacionfiscalclientepequenocontribuyenteeventual = 9
	Situacionfiscalclientepequenocontribuyenteeventualsocial = 10
	Situacionfiscalclientenocategorizado = 11
	Tipodecomprobantepermitidoa = 1
	Tipodecomprobantepermitidob = 2
	Tipodecomprobantepermitidoc = 3
	Tipodecomprobantepermitidoe = 4
	Tipodecomprobantepermitidom = 5
	Tipodeivaventagravadofijo = 1
	Tipodeivaventanogravado = 2
	Tipodeivaventagravadolibre = 3
	Listadepreciosivaincluido = 1
	Listadepreciosmasiva = 2
	Situacionfiscalempresaexento = 4
	Situacionfiscalempresainscriptonoresponsable = 5
	Situacionfiscalempresaliberado = 6
	ArticuloEnOferta = 2
	CmlLogCantidadDeRegistrosQueNoSePuedenAchicar = 0
	VisualizaImpuestosComprobanteA = .T.
	VisualizaImpuestosComprobanteB = .T.
	VisualizaImpuestosComprobanteC = .T.
	VisualizaImpuestosComprobanteE = .T.
	VisualizaImpuestosComprobanteM = .T.
	Decimalespararedondeoencomprobantes = 10
	Cotizacionpordefault = 1
	Grupodevalorpordefecto = 'Varios'
	Diferenciapermitidaentretotalyticket = 0.20
	Procesoimportacion = 'importacion04974'
	Etiquetainformacionadicionalcomprobantesafectados = 'Afectado'
	Etiquetainformacionadicionalcomprobantesafectantes = 'Afectante'
	Descripcionpagoacuenta = 'Pago a cuenta'
	Reintentoscapturarcf = 30
	Tiempoentrereintentodecaptura = 1
	Charvalidosdigito3 = '24,16,25,17,50,48,51,49'
	Preciosparapreviewredondeodeprecios = '945,950,951,1915,1950,1975,'
	Archivodesonidoparareproducirenacumulaciondelecturadecodigodebarras = 'LecturaAcumulacionCB.wav'
	Cantidadpordefectoenlecturadecodigodebarras = 1
	Caracterseparadordeatributosdecombinacionparalecturadecodigodebarras = '*'
	Codigodearticulosena = 'SEÑA'
	Tipodecuponpordefectoparacomprobantesdesignopositivo = 'C'
	Tipodecuponpordefectoparacomprobantesdesignonegativo = 'D'
	Facturacionelectronicapaisargentina = 200
	Codigoverificadorpromociones = ''
	Dispositivopostamanopaquete = 10000
	Dispositivopostiempoentremensajes = 3000
	Dispositivopostiempodechequeoentremensajes = 1
	Dispositivopostimeoutrecepcion = 3000
	Cantidadmaximadevaloresencomprobantesfiscales = 5
	Tipodecupondeanulacionpordefectoparacomprobantesdesignopositivo = 'AC'
	Tipodecupondeanulacionpordefectoparacomprobantesdesignonegativo = 'AD'
	Proveedordeservicioparaobtenerferiados = 'NoLaborables'
	Situacionfiscalempresanoalcanzado = 7
	Situacionfiscalclientenoalcanzado = 12
	Idsponsormercadopagopoint = '272112295'
	Interfazsanjustoshoppingtiempoentremensajes = 0.25
	Interfazsanjustoshoppingcantidaddereintentos = 10
	Tipodeivaventagravadofijoreducido = 4
	Vigenciacambioscot = {^2019-6-3}
	Fechadeobsolenciaparanuevapreparaciondemercaderiaenpicking = {^2021-12-31}
	Estadoparametroforzarqrcontinuo = .T.
	Estadoparametroforzarqrnocontinuo = .F.
	Feuruguaymodocontingenciaactivado = .F.
	Tiempodedemoradeleventoaplicarpromocionautomatica = 150
	Urldeventademercadolibre = 'www.mercadolibre.com.ar/ventas/#NroDeOrden#/detalle'
	Femodocaeaactivado = .F.
	Actualizotipodeentregaporpuesto = .F.
	Diasrestringidosporafipparainformarcaea = '1,16'
	Idcomprobanteequidadarca = ''

	function init() as void
		with this
		endwith
	endfunc

	function EspacioVerticalSubgrupo_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Espacio Vertical SubGrupo'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 0
					.IdUnico = '185D4536A1A1B0140AA1BE1517580056962401'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.EspacioVerticalSubgrupo = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.EspacioVerticalSubgrupo = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .EspacioVerticalSubgrupo

			endif
		endwith
	endfunc

	function EspacioVerticalSubgrupo_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Espacio Vertical SubGrupo'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 0
						.IdUnico = '185D4536A1A1B0140AA1BE1517580056962401'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.EspacioVerticalSubgrupo = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.EspacioVerticalSubgrupo = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.EspacioVerticalSubgrupo = txValor 
				return .EspacioVerticalSubgrupo

			endif
		endwith
	endfunc

	function Situacionfiscalempresainscripto_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Situación fiscal empresa - Inscripto'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 1
					.IdUnico = '16F34E9FD155CA14FBC1853F10216033334401'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Situacionfiscalempresainscripto = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Situacionfiscalempresainscripto = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Situacionfiscalempresainscripto

			endif
		endwith
	endfunc

	function Situacionfiscalempresainscripto_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Situación fiscal empresa - Inscripto'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 1
						.IdUnico = '16F34E9FD155CA14FBC1853F10216033334401'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Situacionfiscalempresainscripto = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Situacionfiscalempresainscripto = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Situacionfiscalempresainscripto = txValor 
				return .Situacionfiscalempresainscripto

			endif
		endwith
	endfunc

	function Situacionfiscalempresanoinscripto_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Situación fiscal empresa - No inscripto'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 2
					.IdUnico = '1B4128CC11616F149111BC2312607114908341'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Situacionfiscalempresanoinscripto = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Situacionfiscalempresanoinscripto = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Situacionfiscalempresanoinscripto

			endif
		endwith
	endfunc

	function Situacionfiscalempresanoinscripto_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Situación fiscal empresa - No inscripto'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 2
						.IdUnico = '1B4128CC11616F149111BC2312607114908341'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Situacionfiscalempresanoinscripto = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Situacionfiscalempresanoinscripto = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Situacionfiscalempresanoinscripto = txValor 
				return .Situacionfiscalempresanoinscripto

			endif
		endwith
	endfunc

	function Situacionfiscalempresamonotributo_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Situación fiscal empresa - Monotributo'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 3
					.IdUnico = '12168A7B61934B14C4D1AD7714884832053831'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Situacionfiscalempresamonotributo = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Situacionfiscalempresamonotributo = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Situacionfiscalempresamonotributo

			endif
		endwith
	endfunc

	function Situacionfiscalempresamonotributo_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Situación fiscal empresa - Monotributo'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 3
						.IdUnico = '12168A7B61934B14C4D1AD7714884832053831'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Situacionfiscalempresamonotributo = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Situacionfiscalempresamonotributo = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Situacionfiscalempresamonotributo = txValor 
				return .Situacionfiscalempresamonotributo

			endif
		endwith
	endfunc

	function Situacionfiscalclienteinscripto_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Situación fiscal cliente - Inscripto'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 1
					.IdUnico = '17AE9E5C91E23E1406119E0616371258681701'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Situacionfiscalclienteinscripto = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Situacionfiscalclienteinscripto = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Situacionfiscalclienteinscripto

			endif
		endwith
	endfunc

	function Situacionfiscalclienteinscripto_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Situación fiscal cliente - Inscripto'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 1
						.IdUnico = '17AE9E5C91E23E1406119E0616371258681701'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Situacionfiscalclienteinscripto = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Situacionfiscalclienteinscripto = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Situacionfiscalclienteinscripto = txValor 
				return .Situacionfiscalclienteinscripto

			endif
		endwith
	endfunc

	function Situacionfiscalclientenoinscripto_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Situación fiscal cliente - No inscripto'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 2
					.IdUnico = '1879282F41A849147F41A25716088772218601'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Situacionfiscalclientenoinscripto = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Situacionfiscalclientenoinscripto = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Situacionfiscalclientenoinscripto

			endif
		endwith
	endfunc

	function Situacionfiscalclientenoinscripto_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Situación fiscal cliente - No inscripto'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 2
						.IdUnico = '1879282F41A849147F41A25716088772218601'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Situacionfiscalclientenoinscripto = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Situacionfiscalclientenoinscripto = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Situacionfiscalclientenoinscripto = txValor 
				return .Situacionfiscalclientenoinscripto

			endif
		endwith
	endfunc

	function Situacionfiscalclienteconsumidorfinal_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Situación fiscal cliente - Consumidor final'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 3
					.IdUnico = '1B4A7AF371780114CFE1A63311351489957291'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Situacionfiscalclienteconsumidorfinal = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Situacionfiscalclienteconsumidorfinal = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Situacionfiscalclienteconsumidorfinal

			endif
		endwith
	endfunc

	function Situacionfiscalclienteconsumidorfinal_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Situación fiscal cliente - Consumidor final'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 3
						.IdUnico = '1B4A7AF371780114CFE1A63311351489957291'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Situacionfiscalclienteconsumidorfinal = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Situacionfiscalclienteconsumidorfinal = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Situacionfiscalclienteconsumidorfinal = txValor 
				return .Situacionfiscalclienteconsumidorfinal

			endif
		endwith
	endfunc

	function Situacionfiscalclienteexento_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Situación fiscal cliente - Exento'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 4
					.IdUnico = '13C2DC0CF126B714C2618B7E17408405965701'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Situacionfiscalclienteexento = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Situacionfiscalclienteexento = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Situacionfiscalclienteexento

			endif
		endwith
	endfunc

	function Situacionfiscalclienteexento_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Situación fiscal cliente - Exento'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 4
						.IdUnico = '13C2DC0CF126B714C2618B7E17408405965701'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Situacionfiscalclienteexento = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Situacionfiscalclienteexento = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Situacionfiscalclienteexento = txValor 
				return .Situacionfiscalclienteexento

			endif
		endwith
	endfunc

	function Situacionfiscalclienteinscriptonoresponsable_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Situación fiscal cliente - No responsable'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 5
					.IdUnico = '17144CAD81F45E143041919F14496313451721'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Situacionfiscalclienteinscriptonoresponsable = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Situacionfiscalclienteinscriptonoresponsable = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Situacionfiscalclienteinscriptonoresponsable

			endif
		endwith
	endfunc

	function Situacionfiscalclienteinscriptonoresponsable_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Situación fiscal cliente - No responsable'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 5
						.IdUnico = '17144CAD81F45E143041919F14496313451721'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Situacionfiscalclienteinscriptonoresponsable = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Situacionfiscalclienteinscriptonoresponsable = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Situacionfiscalclienteinscriptonoresponsable = txValor 
				return .Situacionfiscalclienteinscriptonoresponsable

			endif
		endwith
	endfunc

	function Situacionfiscalclienteliberado_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Situación fiscal cliente - Liberado'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 6
					.IdUnico = '17B708CF51C91A1460A1B8FC12931481247511'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Situacionfiscalclienteliberado = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Situacionfiscalclienteliberado = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Situacionfiscalclienteliberado

			endif
		endwith
	endfunc

	function Situacionfiscalclienteliberado_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Situación fiscal cliente - Liberado'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 6
						.IdUnico = '17B708CF51C91A1460A1B8FC12931481247511'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Situacionfiscalclienteliberado = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Situacionfiscalclienteliberado = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Situacionfiscalclienteliberado = txValor 
				return .Situacionfiscalclienteliberado

			endif
		endwith
	endfunc

	function Situacionfiscalclientemonotributo_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Situación fiscal cliente - Monotributo'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 7
					.IdUnico = '11E99F4A0148261420A1B37B13479069926501'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Situacionfiscalclientemonotributo = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Situacionfiscalclientemonotributo = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Situacionfiscalclientemonotributo

			endif
		endwith
	endfunc

	function Situacionfiscalclientemonotributo_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Situación fiscal cliente - Monotributo'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 7
						.IdUnico = '11E99F4A0148261420A1B37B13479069926501'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Situacionfiscalclientemonotributo = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Situacionfiscalclientemonotributo = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Situacionfiscalclientemonotributo = txValor 
				return .Situacionfiscalclientemonotributo

			endif
		endwith
	endfunc

	function Situacionfiscalclientemonotributistasocial_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Situación fiscal cliente - Monotributista social'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 8
					.IdUnico = '1DF17FBA1199ED143841BED117639961305001'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Situacionfiscalclientemonotributistasocial = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Situacionfiscalclientemonotributistasocial = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Situacionfiscalclientemonotributistasocial

			endif
		endwith
	endfunc

	function Situacionfiscalclientemonotributistasocial_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Situación fiscal cliente - Monotributista social'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 8
						.IdUnico = '1DF17FBA1199ED143841BED117639961305001'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Situacionfiscalclientemonotributistasocial = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Situacionfiscalclientemonotributistasocial = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Situacionfiscalclientemonotributistasocial = txValor 
				return .Situacionfiscalclientemonotributistasocial

			endif
		endwith
	endfunc

	function Situacionfiscalclientepequenocontribuyenteeventual_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Situación fiscal cliente - Pequeño contribuyente eventual'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 9
					.IdUnico = '1B0851D1E1E6CF142461922311581305778801'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Situacionfiscalclientepequenocontribuyenteeventual = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Situacionfiscalclientepequenocontribuyenteeventual = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Situacionfiscalclientepequenocontribuyenteeventual

			endif
		endwith
	endfunc

	function Situacionfiscalclientepequenocontribuyenteeventual_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Situación fiscal cliente - Pequeño contribuyente eventual'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 9
						.IdUnico = '1B0851D1E1E6CF142461922311581305778801'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Situacionfiscalclientepequenocontribuyenteeventual = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Situacionfiscalclientepequenocontribuyenteeventual = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Situacionfiscalclientepequenocontribuyenteeventual = txValor 
				return .Situacionfiscalclientepequenocontribuyenteeventual

			endif
		endwith
	endfunc

	function Situacionfiscalclientepequenocontribuyenteeventualsocial_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Situación fiscal cliente - Pequeño contribuyente eventual social'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 10
					.IdUnico = '1399A7C2A178851433D19DDD18240044688161'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Situacionfiscalclientepequenocontribuyenteeventualsocial = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Situacionfiscalclientepequenocontribuyenteeventualsocial = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Situacionfiscalclientepequenocontribuyenteeventualsocial

			endif
		endwith
	endfunc

	function Situacionfiscalclientepequenocontribuyenteeventualsocial_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Situación fiscal cliente - Pequeño contribuyente eventual social'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 10
						.IdUnico = '1399A7C2A178851433D19DDD18240044688161'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Situacionfiscalclientepequenocontribuyenteeventualsocial = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Situacionfiscalclientepequenocontribuyenteeventualsocial = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Situacionfiscalclientepequenocontribuyenteeventualsocial = txValor 
				return .Situacionfiscalclientepequenocontribuyenteeventualsocial

			endif
		endwith
	endfunc

	function Situacionfiscalclientenocategorizado_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Situación fiscal cliente - No categorizado'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 11
					.IdUnico = '10048DE6816404146631A83012581003952961'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Situacionfiscalclientenocategorizado = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Situacionfiscalclientenocategorizado = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Situacionfiscalclientenocategorizado

			endif
		endwith
	endfunc

	function Situacionfiscalclientenocategorizado_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Situación fiscal cliente - No categorizado'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 11
						.IdUnico = '10048DE6816404146631A83012581003952961'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Situacionfiscalclientenocategorizado = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Situacionfiscalclientenocategorizado = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Situacionfiscalclientenocategorizado = txValor 
				return .Situacionfiscalclientenocategorizado

			endif
		endwith
	endfunc

	function Tipodecomprobantepermitidoa_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Tipo de comprobante permitido - A'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 1
					.IdUnico = '14BB485691CB401473718AF711044031562181'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Tipodecomprobantepermitidoa = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Tipodecomprobantepermitidoa = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Tipodecomprobantepermitidoa

			endif
		endwith
	endfunc

	function Tipodecomprobantepermitidoa_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Tipo de comprobante permitido - A'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 1
						.IdUnico = '14BB485691CB401473718AF711044031562181'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Tipodecomprobantepermitidoa = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Tipodecomprobantepermitidoa = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Tipodecomprobantepermitidoa = txValor 
				return .Tipodecomprobantepermitidoa

			endif
		endwith
	endfunc

	function Tipodecomprobantepermitidob_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Tipo de comprobante permitido - B'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 2
					.IdUnico = '136B7D2F61AD261403B1AA5D19595266254441'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Tipodecomprobantepermitidob = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Tipodecomprobantepermitidob = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Tipodecomprobantepermitidob

			endif
		endwith
	endfunc

	function Tipodecomprobantepermitidob_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Tipo de comprobante permitido - B'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 2
						.IdUnico = '136B7D2F61AD261403B1AA5D19595266254441'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Tipodecomprobantepermitidob = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Tipodecomprobantepermitidob = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Tipodecomprobantepermitidob = txValor 
				return .Tipodecomprobantepermitidob

			endif
		endwith
	endfunc

	function Tipodecomprobantepermitidoc_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Tipo de comprobante permitido - C'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 3
					.IdUnico = '182B3B5371E24714C7118D7516011149841111'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Tipodecomprobantepermitidoc = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Tipodecomprobantepermitidoc = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Tipodecomprobantepermitidoc

			endif
		endwith
	endfunc

	function Tipodecomprobantepermitidoc_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Tipo de comprobante permitido - C'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 3
						.IdUnico = '182B3B5371E24714C7118D7516011149841111'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Tipodecomprobantepermitidoc = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Tipodecomprobantepermitidoc = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Tipodecomprobantepermitidoc = txValor 
				return .Tipodecomprobantepermitidoc

			endif
		endwith
	endfunc

	function Tipodecomprobantepermitidoe_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Tipo de comprobante permitido - E'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 4
					.IdUnico = '15BA07C0E1B64C146A01B81710579842790161'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Tipodecomprobantepermitidoe = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Tipodecomprobantepermitidoe = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Tipodecomprobantepermitidoe

			endif
		endwith
	endfunc

	function Tipodecomprobantepermitidoe_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Tipo de comprobante permitido - E'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 4
						.IdUnico = '15BA07C0E1B64C146A01B81710579842790161'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Tipodecomprobantepermitidoe = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Tipodecomprobantepermitidoe = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Tipodecomprobantepermitidoe = txValor 
				return .Tipodecomprobantepermitidoe

			endif
		endwith
	endfunc

	function Tipodecomprobantepermitidom_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Tipo de comprobante permitido - M'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 5
					.IdUnico = '1C2D540721CDC914E97198EE12095480745661'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Tipodecomprobantepermitidom = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Tipodecomprobantepermitidom = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Tipodecomprobantepermitidom

			endif
		endwith
	endfunc

	function Tipodecomprobantepermitidom_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Tipo de comprobante permitido - M'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 5
						.IdUnico = '1C2D540721CDC914E97198EE12095480745661'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Tipodecomprobantepermitidom = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Tipodecomprobantepermitidom = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Tipodecomprobantepermitidom = txValor 
				return .Tipodecomprobantepermitidom

			endif
		endwith
	endfunc

	function Tipodeivaventagravadofijo_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Tipo de IVA Venta - Gravado fijo'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 1
					.IdUnico = '1872DE421150BA145D6193B813873541573101'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Tipodeivaventagravadofijo = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Tipodeivaventagravadofijo = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Tipodeivaventagravadofijo

			endif
		endwith
	endfunc

	function Tipodeivaventagravadofijo_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Tipo de IVA Venta - Gravado fijo'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 1
						.IdUnico = '1872DE421150BA145D6193B813873541573101'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Tipodeivaventagravadofijo = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Tipodeivaventagravadofijo = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Tipodeivaventagravadofijo = txValor 
				return .Tipodeivaventagravadofijo

			endif
		endwith
	endfunc

	function Tipodeivaventanogravado_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Tipo de IVA Venta - No Gravado'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 2
					.IdUnico = '15C8498A91164A14EB61951619924512081211'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Tipodeivaventanogravado = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Tipodeivaventanogravado = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Tipodeivaventanogravado

			endif
		endwith
	endfunc

	function Tipodeivaventanogravado_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Tipo de IVA Venta - No Gravado'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 2
						.IdUnico = '15C8498A91164A14EB61951619924512081211'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Tipodeivaventanogravado = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Tipodeivaventanogravado = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Tipodeivaventanogravado = txValor 
				return .Tipodeivaventanogravado

			endif
		endwith
	endfunc

	function Tipodeivaventagravadolibre_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Tipo de IVA Venta - Gravado libre'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 3
					.IdUnico = '1FE5BA92C1EFBF14DAF189A218278292335011'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Tipodeivaventagravadolibre = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Tipodeivaventagravadolibre = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Tipodeivaventagravadolibre

			endif
		endwith
	endfunc

	function Tipodeivaventagravadolibre_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Tipo de IVA Venta - Gravado libre'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 3
						.IdUnico = '1FE5BA92C1EFBF14DAF189A218278292335011'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Tipodeivaventagravadolibre = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Tipodeivaventagravadolibre = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Tipodeivaventagravadolibre = txValor 
				return .Tipodeivaventagravadolibre

			endif
		endwith
	endfunc

	function Listadepreciosivaincluido_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Lista de precios - IVA incluido'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 1
					.IdUnico = '183306E6419B0D148E919C0512908511855121'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Listadepreciosivaincluido = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Listadepreciosivaincluido = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Listadepreciosivaincluido

			endif
		endwith
	endfunc

	function Listadepreciosivaincluido_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Lista de precios - IVA incluido'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 1
						.IdUnico = '183306E6419B0D148E919C0512908511855121'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Listadepreciosivaincluido = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Listadepreciosivaincluido = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Listadepreciosivaincluido = txValor 
				return .Listadepreciosivaincluido

			endif
		endwith
	endfunc

	function Listadepreciosmasiva_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Lista de precios - Mas IVA'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 2
					.IdUnico = '123CDE616199B414EB91A1F013812273137841'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Listadepreciosmasiva = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Listadepreciosmasiva = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Listadepreciosmasiva

			endif
		endwith
	endfunc

	function Listadepreciosmasiva_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Lista de precios - Mas IVA'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 2
						.IdUnico = '123CDE616199B414EB91A1F013812273137841'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Listadepreciosmasiva = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Listadepreciosmasiva = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Listadepreciosmasiva = txValor 
				return .Listadepreciosmasiva

			endif
		endwith
	endfunc

	function Situacionfiscalempresaexento_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Situación fiscal empresa - Exento'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 4
					.IdUnico = '14EA42DEA108B614DEE1AE3D17315312234841'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Situacionfiscalempresaexento = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Situacionfiscalempresaexento = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Situacionfiscalempresaexento

			endif
		endwith
	endfunc

	function Situacionfiscalempresaexento_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Situación fiscal empresa - Exento'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 4
						.IdUnico = '14EA42DEA108B614DEE1AE3D17315312234841'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Situacionfiscalempresaexento = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Situacionfiscalempresaexento = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Situacionfiscalempresaexento = txValor 
				return .Situacionfiscalempresaexento

			endif
		endwith
	endfunc

	function Situacionfiscalempresainscriptonoresponsable_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Situación fiscal empresa - Inscripto No Responsable'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 5
					.IdUnico = '1C362F581160E61416C1948217508245073201'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Situacionfiscalempresainscriptonoresponsable = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Situacionfiscalempresainscriptonoresponsable = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Situacionfiscalempresainscriptonoresponsable

			endif
		endwith
	endfunc

	function Situacionfiscalempresainscriptonoresponsable_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Situación fiscal empresa - Inscripto No Responsable'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 5
						.IdUnico = '1C362F581160E61416C1948217508245073201'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Situacionfiscalempresainscriptonoresponsable = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Situacionfiscalempresainscriptonoresponsable = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Situacionfiscalempresainscriptonoresponsable = txValor 
				return .Situacionfiscalempresainscriptonoresponsable

			endif
		endwith
	endfunc

	function Situacionfiscalempresaliberado_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Situación fiscal empresa - Liberado'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 6
					.IdUnico = '1B88BC8511BCC1144A019DA618336058899311'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Situacionfiscalempresaliberado = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Situacionfiscalempresaliberado = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Situacionfiscalempresaliberado

			endif
		endwith
	endfunc

	function Situacionfiscalempresaliberado_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Situación fiscal empresa - Liberado'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 6
						.IdUnico = '1B88BC8511BCC1144A019DA618336058899311'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Situacionfiscalempresaliberado = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Situacionfiscalempresaliberado = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Situacionfiscalempresaliberado = txValor 
				return .Situacionfiscalempresaliberado

			endif
		endwith
	endfunc

	function ArticuloEnOferta_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Artículo en oferta'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 2
					.IdUnico = '14E2596111FD0514363186E217733403297291'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.ArticuloEnOferta = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.ArticuloEnOferta = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .ArticuloEnOferta

			endif
		endwith
	endfunc

	function ArticuloEnOferta_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Artículo en oferta'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 2
						.IdUnico = '14E2596111FD0514363186E217733403297291'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.ArticuloEnOferta = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.ArticuloEnOferta = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.ArticuloEnOferta = txValor 
				return .ArticuloEnOferta

			endif
		endwith
	endfunc

	function CmlLogCantidadDeRegistrosQueNoSePuedenAchicar_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'CML - Log - Cantidad de registros que no se pueden achicar'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 0
					.IdUnico = '190D45B1D1EF9414434196B215704435888801'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.CmlLogCantidadDeRegistrosQueNoSePuedenAchicar = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.CmlLogCantidadDeRegistrosQueNoSePuedenAchicar = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .CmlLogCantidadDeRegistrosQueNoSePuedenAchicar

			endif
		endwith
	endfunc

	function CmlLogCantidadDeRegistrosQueNoSePuedenAchicar_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'CML - Log - Cantidad de registros que no se pueden achicar'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 0
						.IdUnico = '190D45B1D1EF9414434196B215704435888801'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.CmlLogCantidadDeRegistrosQueNoSePuedenAchicar = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.CmlLogCantidadDeRegistrosQueNoSePuedenAchicar = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.CmlLogCantidadDeRegistrosQueNoSePuedenAchicar = txValor 
				return .CmlLogCantidadDeRegistrosQueNoSePuedenAchicar

			endif
		endwith
	endfunc

	function VisualizaImpuestosComprobanteA_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Visualiza Impuestos Comprobante A'
					.Proyecto = 'FELINO'
					.TipoDato = 'L'
					.Default = .T.
					.IdUnico = '16B558019104C714E8A1ADA013898347243001'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.VisualizaImpuestosComprobanteA = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.VisualizaImpuestosComprobanteA = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .VisualizaImpuestosComprobanteA

			endif
		endwith
	endfunc

	function VisualizaImpuestosComprobanteA_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Visualiza Impuestos Comprobante A'
						.Proyecto = 'FELINO'
						.TipoDato = 'L'
						.Default = .T.
						.IdUnico = '16B558019104C714E8A1ADA013898347243001'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.VisualizaImpuestosComprobanteA = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.VisualizaImpuestosComprobanteA = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.VisualizaImpuestosComprobanteA = txValor 
				return .VisualizaImpuestosComprobanteA

			endif
		endwith
	endfunc

	function VisualizaImpuestosComprobanteB_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Visualiza Impuestos Comprobante B'
					.Proyecto = 'FELINO'
					.TipoDato = 'L'
					.Default = .T.
					.IdUnico = '1DFC17AC61B0BC1434B1B0D119202856570671'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.VisualizaImpuestosComprobanteB = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.VisualizaImpuestosComprobanteB = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .VisualizaImpuestosComprobanteB

			endif
		endwith
	endfunc

	function VisualizaImpuestosComprobanteB_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Visualiza Impuestos Comprobante B'
						.Proyecto = 'FELINO'
						.TipoDato = 'L'
						.Default = .T.
						.IdUnico = '1DFC17AC61B0BC1434B1B0D119202856570671'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.VisualizaImpuestosComprobanteB = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.VisualizaImpuestosComprobanteB = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.VisualizaImpuestosComprobanteB = txValor 
				return .VisualizaImpuestosComprobanteB

			endif
		endwith
	endfunc

	function VisualizaImpuestosComprobanteC_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Visualiza Impuestos Comprobante C'
					.Proyecto = 'FELINO'
					.TipoDato = 'L'
					.Default = .T.
					.IdUnico = '11F9D72AC1DB0D14E4218D0310758526617161'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.VisualizaImpuestosComprobanteC = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.VisualizaImpuestosComprobanteC = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .VisualizaImpuestosComprobanteC

			endif
		endwith
	endfunc

	function VisualizaImpuestosComprobanteC_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Visualiza Impuestos Comprobante C'
						.Proyecto = 'FELINO'
						.TipoDato = 'L'
						.Default = .T.
						.IdUnico = '11F9D72AC1DB0D14E4218D0310758526617161'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.VisualizaImpuestosComprobanteC = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.VisualizaImpuestosComprobanteC = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.VisualizaImpuestosComprobanteC = txValor 
				return .VisualizaImpuestosComprobanteC

			endif
		endwith
	endfunc

	function VisualizaImpuestosComprobanteE_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Visualiza Impuestos Comprobante E'
					.Proyecto = 'FELINO'
					.TipoDato = 'L'
					.Default = .T.
					.IdUnico = '17C20FE0C10DA7143D5198BF14204666014781'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.VisualizaImpuestosComprobanteE = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.VisualizaImpuestosComprobanteE = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .VisualizaImpuestosComprobanteE

			endif
		endwith
	endfunc

	function VisualizaImpuestosComprobanteE_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Visualiza Impuestos Comprobante E'
						.Proyecto = 'FELINO'
						.TipoDato = 'L'
						.Default = .T.
						.IdUnico = '17C20FE0C10DA7143D5198BF14204666014781'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.VisualizaImpuestosComprobanteE = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.VisualizaImpuestosComprobanteE = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.VisualizaImpuestosComprobanteE = txValor 
				return .VisualizaImpuestosComprobanteE

			endif
		endwith
	endfunc

	function VisualizaImpuestosComprobanteM_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Visualiza Impuestos Comprobante M'
					.Proyecto = 'FELINO'
					.TipoDato = 'L'
					.Default = .T.
					.IdUnico = '1AD077B0F1F0A114C4B1A83E13314879416151'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.VisualizaImpuestosComprobanteM = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.VisualizaImpuestosComprobanteM = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .VisualizaImpuestosComprobanteM

			endif
		endwith
	endfunc

	function VisualizaImpuestosComprobanteM_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Visualiza Impuestos Comprobante M'
						.Proyecto = 'FELINO'
						.TipoDato = 'L'
						.Default = .T.
						.IdUnico = '1AD077B0F1F0A114C4B1A83E13314879416151'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.VisualizaImpuestosComprobanteM = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.VisualizaImpuestosComprobanteM = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.VisualizaImpuestosComprobanteM = txValor 
				return .VisualizaImpuestosComprobanteM

			endif
		endwith
	endfunc

	function Decimalespararedondeoencomprobantes_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Decimales para redondeo en comprobantes'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 10
					.IdUnico = '10671250918F1C14C121BD8212376460988001'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Decimalespararedondeoencomprobantes = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Decimalespararedondeoencomprobantes = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Decimalespararedondeoencomprobantes

			endif
		endwith
	endfunc

	function Decimalespararedondeoencomprobantes_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Decimales para redondeo en comprobantes'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 10
						.IdUnico = '10671250918F1C14C121BD8212376460988001'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Decimalespararedondeoencomprobantes = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Decimalespararedondeoencomprobantes = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Decimalespararedondeoencomprobantes = txValor 
				return .Decimalespararedondeoencomprobantes

			endif
		endwith
	endfunc

	function Cotizacionpordefault_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 1
					.Parametro = 'CotizacionPorDefault'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 1
					.IdUnico = '1E5DD703711D9214B0E191D412046715994371'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Cotizacionpordefault = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Cotizacionpordefault = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Cotizacionpordefault

			endif
		endwith
	endfunc

	function Cotizacionpordefault_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 1
						.Parametro = 'CotizacionPorDefault'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 1
						.IdUnico = '1E5DD703711D9214B0E191D412046715994371'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Cotizacionpordefault = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Cotizacionpordefault = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Cotizacionpordefault = txValor 
				return .Cotizacionpordefault

			endif
		endwith
	endfunc

	function Grupodevalorpordefecto_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Grupo de valor por defecto'
					.Proyecto = 'FELINO'
					.TipoDato = 'C'
					.Default = 'Varios'
					.IdUnico = '1F7248A68117FB140BE181CC10714045843001'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Grupodevalorpordefecto = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Grupodevalorpordefecto = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Grupodevalorpordefecto

			endif
		endwith
	endfunc

	function Grupodevalorpordefecto_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Grupo de valor por defecto'
						.Proyecto = 'FELINO'
						.TipoDato = 'C'
						.Default = 'Varios'
						.IdUnico = '1F7248A68117FB140BE181CC10714045843001'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Grupodevalorpordefecto = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Grupodevalorpordefecto = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Grupodevalorpordefecto = txValor 
				return .Grupodevalorpordefecto

			endif
		endwith
	endfunc

	function Diferenciapermitidaentretotalyticket_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Diferencia Permitida entre total y ticket'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 0.20
					.IdUnico = '182FC8D511C08114B031A73017266500721101'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Diferenciapermitidaentretotalyticket = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Diferenciapermitidaentretotalyticket = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Diferenciapermitidaentretotalyticket

			endif
		endwith
	endfunc

	function Diferenciapermitidaentretotalyticket_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Diferencia Permitida entre total y ticket'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 0.20
						.IdUnico = '182FC8D511C08114B031A73017266500721101'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Diferenciapermitidaentretotalyticket = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Diferenciapermitidaentretotalyticket = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Diferenciapermitidaentretotalyticket = txValor 
				return .Diferenciapermitidaentretotalyticket

			endif
		endwith
	endfunc

	function Procesoimportacion_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 1
					.Parametro = 'Proceso Importacion'
					.Proyecto = 'FELINO'
					.TipoDato = 'C'
					.Default = 'importacion04974'
					.IdUnico = '158487793176471473F18DF519103147772921'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Procesoimportacion = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Procesoimportacion = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Procesoimportacion

			endif
		endwith
	endfunc

	function Procesoimportacion_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 1
						.Parametro = 'Proceso Importacion'
						.Proyecto = 'FELINO'
						.TipoDato = 'C'
						.Default = 'importacion04974'
						.IdUnico = '158487793176471473F18DF519103147772921'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Procesoimportacion = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Procesoimportacion = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Procesoimportacion = txValor 
				return .Procesoimportacion

			endif
		endwith
	endfunc

	function Etiquetainformacionadicionalcomprobantesafectados_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Etiqueta información adicional comprobantes afectados'
					.Proyecto = 'FELINO'
					.TipoDato = 'C'
					.Default = 'Afectado'
					.IdUnico = '193B4526B10B92143771853012301083304801'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Etiquetainformacionadicionalcomprobantesafectados = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Etiquetainformacionadicionalcomprobantesafectados = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Etiquetainformacionadicionalcomprobantesafectados

			endif
		endwith
	endfunc

	function Etiquetainformacionadicionalcomprobantesafectados_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Etiqueta información adicional comprobantes afectados'
						.Proyecto = 'FELINO'
						.TipoDato = 'C'
						.Default = 'Afectado'
						.IdUnico = '193B4526B10B92143771853012301083304801'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Etiquetainformacionadicionalcomprobantesafectados = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Etiquetainformacionadicionalcomprobantesafectados = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Etiquetainformacionadicionalcomprobantesafectados = txValor 
				return .Etiquetainformacionadicionalcomprobantesafectados

			endif
		endwith
	endfunc

	function Etiquetainformacionadicionalcomprobantesafectantes_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Etiqueta información adicional comprobantes afectantes'
					.Proyecto = 'FELINO'
					.TipoDato = 'C'
					.Default = 'Afectante'
					.IdUnico = '1F3C1347413483144851836E14266064743341'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Etiquetainformacionadicionalcomprobantesafectantes = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Etiquetainformacionadicionalcomprobantesafectantes = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Etiquetainformacionadicionalcomprobantesafectantes

			endif
		endwith
	endfunc

	function Etiquetainformacionadicionalcomprobantesafectantes_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Etiqueta información adicional comprobantes afectantes'
						.Proyecto = 'FELINO'
						.TipoDato = 'C'
						.Default = 'Afectante'
						.IdUnico = '1F3C1347413483144851836E14266064743341'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Etiquetainformacionadicionalcomprobantesafectantes = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Etiquetainformacionadicionalcomprobantesafectantes = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Etiquetainformacionadicionalcomprobantesafectantes = txValor 
				return .Etiquetainformacionadicionalcomprobantesafectantes

			endif
		endwith
	endfunc

	function Descripcionpagoacuenta_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Descripcion pago a cuenta'
					.Proyecto = 'FELINO'
					.TipoDato = 'C'
					.Default = 'Pago a cuenta'
					.IdUnico = '14428FB0314B451451B1BF3018103112080501'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Descripcionpagoacuenta = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Descripcionpagoacuenta = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Descripcionpagoacuenta

			endif
		endwith
	endfunc

	function Descripcionpagoacuenta_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Descripcion pago a cuenta'
						.Proyecto = 'FELINO'
						.TipoDato = 'C'
						.Default = 'Pago a cuenta'
						.IdUnico = '14428FB0314B451451B1BF3018103112080501'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Descripcionpagoacuenta = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Descripcionpagoacuenta = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Descripcionpagoacuenta = txValor 
				return .Descripcionpagoacuenta

			endif
		endwith
	endfunc

	function Reintentoscapturarcf_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Reintentos Capturar CF'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 30
					.IdUnico = '1356DABBA1DCAE148151B09914124324486201'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Reintentoscapturarcf = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Reintentoscapturarcf = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Reintentoscapturarcf

			endif
		endwith
	endfunc

	function Reintentoscapturarcf_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Reintentos Capturar CF'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 30
						.IdUnico = '1356DABBA1DCAE148151B09914124324486201'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Reintentoscapturarcf = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Reintentoscapturarcf = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Reintentoscapturarcf = txValor 
				return .Reintentoscapturarcf

			endif
		endwith
	endfunc

	function Tiempoentrereintentodecaptura_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Tiempo Entre Reintento De Captura'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 1
					.IdUnico = '1D956D83B1187A148B21928B11077236544721'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Tiempoentrereintentodecaptura = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Tiempoentrereintentodecaptura = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Tiempoentrereintentodecaptura

			endif
		endwith
	endfunc

	function Tiempoentrereintentodecaptura_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Tiempo Entre Reintento De Captura'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 1
						.IdUnico = '1D956D83B1187A148B21928B11077236544721'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Tiempoentrereintentodecaptura = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Tiempoentrereintentodecaptura = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Tiempoentrereintentodecaptura = txValor 
				return .Tiempoentrereintentodecaptura

			endif
		endwith
	endfunc

	function Charvalidosdigito3_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Caracteres válidos de control ( 3er dígito )'
					.Proyecto = 'FELINO'
					.TipoDato = 'C'
					.Default = '24,16,25,17,50,48,51,49'
					.IdUnico = '178DE42FE1269914CF01AB1219014564530001'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Charvalidosdigito3 = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Charvalidosdigito3 = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Charvalidosdigito3

			endif
		endwith
	endfunc

	function Charvalidosdigito3_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Caracteres válidos de control ( 3er dígito )'
						.Proyecto = 'FELINO'
						.TipoDato = 'C'
						.Default = '24,16,25,17,50,48,51,49'
						.IdUnico = '178DE42FE1269914CF01AB1219014564530001'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Charvalidosdigito3 = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Charvalidosdigito3 = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Charvalidosdigito3 = txValor 
				return .Charvalidosdigito3

			endif
		endwith
	endfunc

	function Preciosparapreviewredondeodeprecios_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'PreciosParaPreviewRedondeoDePrecios'
					.Proyecto = 'FELINO'
					.TipoDato = 'C'
					.Default = '945,950,951,1915,1950,1975,'
					.IdUnico = '11F63B51816BC0143F31BFC310247076156201'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Preciosparapreviewredondeodeprecios = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Preciosparapreviewredondeodeprecios = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Preciosparapreviewredondeodeprecios

			endif
		endwith
	endfunc

	function Preciosparapreviewredondeodeprecios_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'PreciosParaPreviewRedondeoDePrecios'
						.Proyecto = 'FELINO'
						.TipoDato = 'C'
						.Default = '945,950,951,1915,1950,1975,'
						.IdUnico = '11F63B51816BC0143F31BFC310247076156201'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Preciosparapreviewredondeodeprecios = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Preciosparapreviewredondeodeprecios = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Preciosparapreviewredondeodeprecios = txValor 
				return .Preciosparapreviewredondeodeprecios

			endif
		endwith
	endfunc

	function Archivodesonidoparareproducirenacumulaciondelecturadecodigodebarras_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Archivo de sonido para reproducir en acumulación de lectura de código de barras'
					.Proyecto = 'FELINO'
					.TipoDato = 'C'
					.Default = 'LecturaAcumulacionCB.wav'
					.IdUnico = '1FD8626301FA27143441B7A415858174641201'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Archivodesonidoparareproducirenacumulaciondelecturadecodigodebarras = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Archivodesonidoparareproducirenacumulaciondelecturadecodigodebarras = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Archivodesonidoparareproducirenacumulaciondelecturadecodigodebarras

			endif
		endwith
	endfunc

	function Archivodesonidoparareproducirenacumulaciondelecturadecodigodebarras_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Archivo de sonido para reproducir en acumulación de lectura de código de barras'
						.Proyecto = 'FELINO'
						.TipoDato = 'C'
						.Default = 'LecturaAcumulacionCB.wav'
						.IdUnico = '1FD8626301FA27143441B7A415858174641201'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Archivodesonidoparareproducirenacumulaciondelecturadecodigodebarras = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Archivodesonidoparareproducirenacumulaciondelecturadecodigodebarras = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Archivodesonidoparareproducirenacumulaciondelecturadecodigodebarras = txValor 
				return .Archivodesonidoparareproducirenacumulaciondelecturadecodigodebarras

			endif
		endwith
	endfunc

	function Cantidadpordefectoenlecturadecodigodebarras_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Cantidad por defecto en lectura de código de barras'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 1
					.IdUnico = '1DE30F2411C39314A131A6BF12660531648511'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Cantidadpordefectoenlecturadecodigodebarras = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Cantidadpordefectoenlecturadecodigodebarras = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Cantidadpordefectoenlecturadecodigodebarras

			endif
		endwith
	endfunc

	function Cantidadpordefectoenlecturadecodigodebarras_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Cantidad por defecto en lectura de código de barras'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 1
						.IdUnico = '1DE30F2411C39314A131A6BF12660531648511'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Cantidadpordefectoenlecturadecodigodebarras = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Cantidadpordefectoenlecturadecodigodebarras = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Cantidadpordefectoenlecturadecodigodebarras = txValor 
				return .Cantidadpordefectoenlecturadecodigodebarras

			endif
		endwith
	endfunc

	function Caracterseparadordeatributosdecombinacionparalecturadecodigodebarras_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Caracter separador de atributos de combinacion para lectura de código de barras'
					.Proyecto = 'FELINO'
					.TipoDato = 'C'
					.Default = '*'
					.IdUnico = '18357F0A91BA1B14528192B213289501985551'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Caracterseparadordeatributosdecombinacionparalecturadecodigodebarras = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Caracterseparadordeatributosdecombinacionparalecturadecodigodebarras = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Caracterseparadordeatributosdecombinacionparalecturadecodigodebarras

			endif
		endwith
	endfunc

	function Caracterseparadordeatributosdecombinacionparalecturadecodigodebarras_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Caracter separador de atributos de combinacion para lectura de código de barras'
						.Proyecto = 'FELINO'
						.TipoDato = 'C'
						.Default = '*'
						.IdUnico = '18357F0A91BA1B14528192B213289501985551'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Caracterseparadordeatributosdecombinacionparalecturadecodigodebarras = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Caracterseparadordeatributosdecombinacionparalecturadecodigodebarras = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Caracterseparadordeatributosdecombinacionparalecturadecodigodebarras = txValor 
				return .Caracterseparadordeatributosdecombinacionparalecturadecodigodebarras

			endif
		endwith
	endfunc

	function Codigodearticulosena_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'CodigoDeArticuloSeña'
					.Proyecto = 'FELINO'
					.TipoDato = 'C'
					.Default = 'SEÑA'
					.IdUnico = '1CCBD327E117D814E911B58D14712144911141'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Codigodearticulosena = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Codigodearticulosena = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Codigodearticulosena

			endif
		endwith
	endfunc

	function Codigodearticulosena_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'CodigoDeArticuloSeña'
						.Proyecto = 'FELINO'
						.TipoDato = 'C'
						.Default = 'SEÑA'
						.IdUnico = '1CCBD327E117D814E911B58D14712144911141'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Codigodearticulosena = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Codigodearticulosena = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Codigodearticulosena = txValor 
				return .Codigodearticulosena

			endif
		endwith
	endfunc

	function Tipodecuponpordefectoparacomprobantesdesignopositivo_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'TipoDeCuponPorDefectoParaComprobantesDeSignoPositivo'
					.Proyecto = 'FELINO'
					.TipoDato = 'C'
					.Default = 'C'
					.IdUnico = '16187AEBF1EC761487F1B35B13575095226581'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Tipodecuponpordefectoparacomprobantesdesignopositivo = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Tipodecuponpordefectoparacomprobantesdesignopositivo = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Tipodecuponpordefectoparacomprobantesdesignopositivo

			endif
		endwith
	endfunc

	function Tipodecuponpordefectoparacomprobantesdesignopositivo_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'TipoDeCuponPorDefectoParaComprobantesDeSignoPositivo'
						.Proyecto = 'FELINO'
						.TipoDato = 'C'
						.Default = 'C'
						.IdUnico = '16187AEBF1EC761487F1B35B13575095226581'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Tipodecuponpordefectoparacomprobantesdesignopositivo = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Tipodecuponpordefectoparacomprobantesdesignopositivo = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Tipodecuponpordefectoparacomprobantesdesignopositivo = txValor 
				return .Tipodecuponpordefectoparacomprobantesdesignopositivo

			endif
		endwith
	endfunc

	function Tipodecuponpordefectoparacomprobantesdesignonegativo_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'TipoDeCuponPorDefectoParaComprobantesDeSignoNegativo'
					.Proyecto = 'FELINO'
					.TipoDato = 'C'
					.Default = 'D'
					.IdUnico = '164199FF314D5214F811804118306112699031'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Tipodecuponpordefectoparacomprobantesdesignonegativo = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Tipodecuponpordefectoparacomprobantesdesignonegativo = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Tipodecuponpordefectoparacomprobantesdesignonegativo

			endif
		endwith
	endfunc

	function Tipodecuponpordefectoparacomprobantesdesignonegativo_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'TipoDeCuponPorDefectoParaComprobantesDeSignoNegativo'
						.Proyecto = 'FELINO'
						.TipoDato = 'C'
						.Default = 'D'
						.IdUnico = '164199FF314D5214F811804118306112699031'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Tipodecuponpordefectoparacomprobantesdesignonegativo = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Tipodecuponpordefectoparacomprobantesdesignonegativo = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Tipodecuponpordefectoparacomprobantesdesignonegativo = txValor 
				return .Tipodecuponpordefectoparacomprobantesdesignonegativo

			endif
		endwith
	endfunc

	function Facturacionelectronicapaisargentina_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'FacturacionElectronicaPaisArgentina'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 200
					.IdUnico = '1995DA74A1CA8E14CCA1A7F911283080598801'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Facturacionelectronicapaisargentina = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Facturacionelectronicapaisargentina = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Facturacionelectronicapaisargentina

			endif
		endwith
	endfunc

	function Facturacionelectronicapaisargentina_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'FacturacionElectronicaPaisArgentina'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 200
						.IdUnico = '1995DA74A1CA8E14CCA1A7F911283080598801'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Facturacionelectronicapaisargentina = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Facturacionelectronicapaisargentina = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Facturacionelectronicapaisargentina = txValor 
				return .Facturacionelectronicapaisargentina

			endif
		endwith
	endfunc

	function Codigoverificadorpromociones_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 3
					.idNodo = 1
					.Parametro = 'CodigoVerificadorPromociones'
					.Proyecto = 'FELINO'
					.TipoDato = 'C'
					.Default = ''
					.IdUnico = '107C23BDC1CF7114E341A0D512615441526621'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Codigoverificadorpromociones = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Codigoverificadorpromociones = .Sucursal.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Codigoverificadorpromociones

			endif
		endwith
	endfunc

	function Codigoverificadorpromociones_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 3
						.idNodo = 1
						.Parametro = 'CodigoVerificadorPromociones'
						.Proyecto = 'FELINO'
						.TipoDato = 'C'
						.Default = ''
						.IdUnico = '107C23BDC1CF7114E341A0D512615441526621'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Codigoverificadorpromociones = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Codigoverificadorpromociones = .Sucursal.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Codigoverificadorpromociones = txValor 
				return .Codigoverificadorpromociones

			endif
		endwith
	endfunc

	function Dispositivopostamanopaquete_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'DispositivoPOS Tamaño Paquete'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 10000
					.IdUnico = '1049F180D1FADF142AD1BFCE19046581154721'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Dispositivopostamanopaquete = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Dispositivopostamanopaquete = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Dispositivopostamanopaquete

			endif
		endwith
	endfunc

	function Dispositivopostamanopaquete_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'DispositivoPOS Tamaño Paquete'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 10000
						.IdUnico = '1049F180D1FADF142AD1BFCE19046581154721'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Dispositivopostamanopaquete = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Dispositivopostamanopaquete = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Dispositivopostamanopaquete = txValor 
				return .Dispositivopostamanopaquete

			endif
		endwith
	endfunc

	function Dispositivopostiempoentremensajes_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'DispositivoPOS Tiempo entre mensajes'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 3000
					.IdUnico = '177FFEA5E189DE1429D1BFD512017554084401'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Dispositivopostiempoentremensajes = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Dispositivopostiempoentremensajes = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Dispositivopostiempoentremensajes

			endif
		endwith
	endfunc

	function Dispositivopostiempoentremensajes_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'DispositivoPOS Tiempo entre mensajes'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 3000
						.IdUnico = '177FFEA5E189DE1429D1BFD512017554084401'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Dispositivopostiempoentremensajes = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Dispositivopostiempoentremensajes = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Dispositivopostiempoentremensajes = txValor 
				return .Dispositivopostiempoentremensajes

			endif
		endwith
	endfunc

	function Dispositivopostiempodechequeoentremensajes_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'DispositivoPOS Tiempo de chequeo entre mensajes'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 1
					.IdUnico = '15756339E1BF471442A19DCF14536121724201'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Dispositivopostiempodechequeoentremensajes = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Dispositivopostiempodechequeoentremensajes = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Dispositivopostiempodechequeoentremensajes

			endif
		endwith
	endfunc

	function Dispositivopostiempodechequeoentremensajes_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'DispositivoPOS Tiempo de chequeo entre mensajes'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 1
						.IdUnico = '15756339E1BF471442A19DCF14536121724201'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Dispositivopostiempodechequeoentremensajes = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Dispositivopostiempodechequeoentremensajes = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Dispositivopostiempodechequeoentremensajes = txValor 
				return .Dispositivopostiempodechequeoentremensajes

			endif
		endwith
	endfunc

	function Dispositivopostimeoutrecepcion_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'DispositivoPOS Timeout recepcion'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 3000
					.IdUnico = '1F136702C16DCD140891934C13123971394211'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Dispositivopostimeoutrecepcion = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Dispositivopostimeoutrecepcion = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Dispositivopostimeoutrecepcion

			endif
		endwith
	endfunc

	function Dispositivopostimeoutrecepcion_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'DispositivoPOS Timeout recepcion'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 3000
						.IdUnico = '1F136702C16DCD140891934C13123971394211'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Dispositivopostimeoutrecepcion = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Dispositivopostimeoutrecepcion = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Dispositivopostimeoutrecepcion = txValor 
				return .Dispositivopostimeoutrecepcion

			endif
		endwith
	endfunc

	function Cantidadmaximadevaloresencomprobantesfiscales_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Cantidad máxima de valores en comprobantes fiscales'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 5
					.IdUnico = '191ACF8971A4E814A271ADF415352465886701'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Cantidadmaximadevaloresencomprobantesfiscales = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Cantidadmaximadevaloresencomprobantesfiscales = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Cantidadmaximadevaloresencomprobantesfiscales

			endif
		endwith
	endfunc

	function Cantidadmaximadevaloresencomprobantesfiscales_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Cantidad máxima de valores en comprobantes fiscales'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 5
						.IdUnico = '191ACF8971A4E814A271ADF415352465886701'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Cantidadmaximadevaloresencomprobantesfiscales = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Cantidadmaximadevaloresencomprobantesfiscales = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Cantidadmaximadevaloresencomprobantesfiscales = txValor 
				return .Cantidadmaximadevaloresencomprobantesfiscales

			endif
		endwith
	endfunc

	function Tipodecupondeanulacionpordefectoparacomprobantesdesignopositivo_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'TipoDeCuponDeAnulacionPorDefectoParaComprobantesDeSignoPositivo'
					.Proyecto = 'FELINO'
					.TipoDato = 'C'
					.Default = 'AC'
					.IdUnico = '11960A58918AB1144CA1847C11552425700671'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Tipodecupondeanulacionpordefectoparacomprobantesdesignopositivo = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Tipodecupondeanulacionpordefectoparacomprobantesdesignopositivo = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Tipodecupondeanulacionpordefectoparacomprobantesdesignopositivo

			endif
		endwith
	endfunc

	function Tipodecupondeanulacionpordefectoparacomprobantesdesignopositivo_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'TipoDeCuponDeAnulacionPorDefectoParaComprobantesDeSignoPositivo'
						.Proyecto = 'FELINO'
						.TipoDato = 'C'
						.Default = 'AC'
						.IdUnico = '11960A58918AB1144CA1847C11552425700671'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Tipodecupondeanulacionpordefectoparacomprobantesdesignopositivo = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Tipodecupondeanulacionpordefectoparacomprobantesdesignopositivo = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Tipodecupondeanulacionpordefectoparacomprobantesdesignopositivo = txValor 
				return .Tipodecupondeanulacionpordefectoparacomprobantesdesignopositivo

			endif
		endwith
	endfunc

	function Tipodecupondeanulacionpordefectoparacomprobantesdesignonegativo_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'TipoDeCuponDeAnulacionPorDefectoParaComprobantesDeSignoNegativo'
					.Proyecto = 'FELINO'
					.TipoDato = 'C'
					.Default = 'AD'
					.IdUnico = '1756739DC1CDEE1467B1A78D17932833565951'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Tipodecupondeanulacionpordefectoparacomprobantesdesignonegativo = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Tipodecupondeanulacionpordefectoparacomprobantesdesignonegativo = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Tipodecupondeanulacionpordefectoparacomprobantesdesignonegativo

			endif
		endwith
	endfunc

	function Tipodecupondeanulacionpordefectoparacomprobantesdesignonegativo_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'TipoDeCuponDeAnulacionPorDefectoParaComprobantesDeSignoNegativo'
						.Proyecto = 'FELINO'
						.TipoDato = 'C'
						.Default = 'AD'
						.IdUnico = '1756739DC1CDEE1467B1A78D17932833565951'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Tipodecupondeanulacionpordefectoparacomprobantesdesignonegativo = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Tipodecupondeanulacionpordefectoparacomprobantesdesignonegativo = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Tipodecupondeanulacionpordefectoparacomprobantesdesignonegativo = txValor 
				return .Tipodecupondeanulacionpordefectoparacomprobantesdesignonegativo

			endif
		endwith
	endfunc

	function Proveedordeservicioparaobtenerferiados_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 1
					.Parametro = 'ProveedorDeServicioParaObtenerFeriados'
					.Proyecto = 'FELINO'
					.TipoDato = 'C'
					.Default = 'NoLaborables'
					.IdUnico = '10968136E13206140A51BE8411028412779581'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Proveedordeservicioparaobtenerferiados = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Proveedordeservicioparaobtenerferiados = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Proveedordeservicioparaobtenerferiados

			endif
		endwith
	endfunc

	function Proveedordeservicioparaobtenerferiados_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 1
						.Parametro = 'ProveedorDeServicioParaObtenerFeriados'
						.Proyecto = 'FELINO'
						.TipoDato = 'C'
						.Default = 'NoLaborables'
						.IdUnico = '10968136E13206140A51BE8411028412779581'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Proveedordeservicioparaobtenerferiados = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Proveedordeservicioparaobtenerferiados = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Proveedordeservicioparaobtenerferiados = txValor 
				return .Proveedordeservicioparaobtenerferiados

			endif
		endwith
	endfunc

	function Situacionfiscalempresanoalcanzado_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Situación fiscal empresa - No alcanzado'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 7
					.IdUnico = '17448FE8F16B9E14B821A22A18791837237731'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Situacionfiscalempresanoalcanzado = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Situacionfiscalempresanoalcanzado = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Situacionfiscalempresanoalcanzado

			endif
		endwith
	endfunc

	function Situacionfiscalempresanoalcanzado_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Situación fiscal empresa - No alcanzado'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 7
						.IdUnico = '17448FE8F16B9E14B821A22A18791837237731'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Situacionfiscalempresanoalcanzado = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Situacionfiscalempresanoalcanzado = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Situacionfiscalempresanoalcanzado = txValor 
				return .Situacionfiscalempresanoalcanzado

			endif
		endwith
	endfunc

	function Situacionfiscalclientenoalcanzado_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Situación fiscal cliente - No alcanzado'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 12
					.IdUnico = '1C9B326F51D0AE142071B99614112691795941'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Situacionfiscalclientenoalcanzado = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Situacionfiscalclientenoalcanzado = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Situacionfiscalclientenoalcanzado

			endif
		endwith
	endfunc

	function Situacionfiscalclientenoalcanzado_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Situación fiscal cliente - No alcanzado'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 12
						.IdUnico = '1C9B326F51D0AE142071B99614112691795941'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Situacionfiscalclientenoalcanzado = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Situacionfiscalclientenoalcanzado = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Situacionfiscalclientenoalcanzado = txValor 
				return .Situacionfiscalclientenoalcanzado

			endif
		endwith
	endfunc

	function Idsponsormercadopagopoint_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 1
					.Parametro = 'Id Sponsor MercadoPago Point'
					.Proyecto = 'FELINO'
					.TipoDato = 'C'
					.Default = '272112295'
					.IdUnico = '1C46192DB17D641488F1B4C815082962614801'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Idsponsormercadopagopoint = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Idsponsormercadopagopoint = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Idsponsormercadopagopoint

			endif
		endwith
	endfunc

	function Idsponsormercadopagopoint_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 1
						.Parametro = 'Id Sponsor MercadoPago Point'
						.Proyecto = 'FELINO'
						.TipoDato = 'C'
						.Default = '272112295'
						.IdUnico = '1C46192DB17D641488F1B4C815082962614801'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Idsponsormercadopagopoint = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Idsponsormercadopagopoint = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Idsponsormercadopagopoint = txValor 
				return .Idsponsormercadopagopoint

			endif
		endwith
	endfunc

	function Interfazsanjustoshoppingtiempoentremensajes_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Interfaz San Justo Shopping Tiempo entre mensajes'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 0.25
					.IdUnico = '1E19AB46E1E6BF1450B1A1C117892734029401'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Interfazsanjustoshoppingtiempoentremensajes = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Interfazsanjustoshoppingtiempoentremensajes = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Interfazsanjustoshoppingtiempoentremensajes

			endif
		endwith
	endfunc

	function Interfazsanjustoshoppingtiempoentremensajes_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Interfaz San Justo Shopping Tiempo entre mensajes'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 0.25
						.IdUnico = '1E19AB46E1E6BF1450B1A1C117892734029401'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Interfazsanjustoshoppingtiempoentremensajes = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Interfazsanjustoshoppingtiempoentremensajes = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Interfazsanjustoshoppingtiempoentremensajes = txValor 
				return .Interfazsanjustoshoppingtiempoentremensajes

			endif
		endwith
	endfunc

	function Interfazsanjustoshoppingcantidaddereintentos_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Interfaz San Justo Shopping Cantidad de reintentos'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 10
					.IdUnico = '1D34DFB261450114A661A07E14719803088661'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Interfazsanjustoshoppingcantidaddereintentos = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Interfazsanjustoshoppingcantidaddereintentos = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Interfazsanjustoshoppingcantidaddereintentos

			endif
		endwith
	endfunc

	function Interfazsanjustoshoppingcantidaddereintentos_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Interfaz San Justo Shopping Cantidad de reintentos'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 10
						.IdUnico = '1D34DFB261450114A661A07E14719803088661'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Interfazsanjustoshoppingcantidaddereintentos = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Interfazsanjustoshoppingcantidaddereintentos = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Interfazsanjustoshoppingcantidaddereintentos = txValor 
				return .Interfazsanjustoshoppingcantidaddereintentos

			endif
		endwith
	endfunc

	function Tipodeivaventagravadofijoreducido_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Tipo de IVA Venta - Gravado fijo reducido'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 4
					.IdUnico = '1ABC66EF71A33514AA51BF2B18278775615871'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Tipodeivaventagravadofijoreducido = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Tipodeivaventagravadofijoreducido = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Tipodeivaventagravadofijoreducido

			endif
		endwith
	endfunc

	function Tipodeivaventagravadofijoreducido_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Tipo de IVA Venta - Gravado fijo reducido'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 4
						.IdUnico = '1ABC66EF71A33514AA51BF2B18278775615871'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Tipodeivaventagravadofijoreducido = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Tipodeivaventagravadofijoreducido = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Tipodeivaventagravadofijoreducido = txValor 
				return .Tipodeivaventagravadofijoreducido

			endif
		endwith
	endfunc

	function Vigenciacambioscot_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Fecha vigencia nuevos cambios en el COT'
					.Proyecto = 'FELINO'
					.TipoDato = 'D'
					.Default = {^2019-6-3}
					.IdUnico = '146454CC2165431434D1B7C610948103619201'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Vigenciacambioscot = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Vigenciacambioscot = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Vigenciacambioscot

			endif
		endwith
	endfunc

	function Vigenciacambioscot_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Fecha vigencia nuevos cambios en el COT'
						.Proyecto = 'FELINO'
						.TipoDato = 'D'
						.Default = {^2019-6-3}
						.IdUnico = '146454CC2165431434D1B7C610948103619201'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Vigenciacambioscot = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Vigenciacambioscot = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Vigenciacambioscot = txValor 
				return .Vigenciacambioscot

			endif
		endwith
	endfunc

	function Fechadeobsolenciaparanuevapreparaciondemercaderiaenpicking_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 1
					.Parametro = 'Fecha de obsolencia para "Nueva preparación de mercadería" en picking'
					.Proyecto = 'FELINO'
					.TipoDato = 'D'
					.Default = {^2021-12-31}
					.IdUnico = '1CEB9BF6717753143EE1912817066243145101'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Fechadeobsolenciaparanuevapreparaciondemercaderiaenpicking = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Fechadeobsolenciaparanuevapreparaciondemercaderiaenpicking = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Fechadeobsolenciaparanuevapreparaciondemercaderiaenpicking

			endif
		endwith
	endfunc

	function Fechadeobsolenciaparanuevapreparaciondemercaderiaenpicking_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 1
						.Parametro = 'Fecha de obsolencia para "Nueva preparación de mercadería" en picking'
						.Proyecto = 'FELINO'
						.TipoDato = 'D'
						.Default = {^2021-12-31}
						.IdUnico = '1CEB9BF6717753143EE1912817066243145101'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Fechadeobsolenciaparanuevapreparaciondemercaderiaenpicking = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Fechadeobsolenciaparanuevapreparaciondemercaderiaenpicking = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Fechadeobsolenciaparanuevapreparaciondemercaderiaenpicking = txValor 
				return .Fechadeobsolenciaparanuevapreparaciondemercaderiaenpicking

			endif
		endwith
	endfunc

	function Estadoparametroforzarqrcontinuo_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 3
					.idNodo = 1
					.Parametro = 'Estado parámetro forzar QR continuo'
					.Proyecto = 'FELINO'
					.TipoDato = 'L'
					.Default = .T.
					.IdUnico = '1D96B4DBE1036514BFE18FAA17091364546081'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Estadoparametroforzarqrcontinuo = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Estadoparametroforzarqrcontinuo = .Sucursal.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Estadoparametroforzarqrcontinuo

			endif
		endwith
	endfunc

	function Estadoparametroforzarqrcontinuo_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 3
						.idNodo = 1
						.Parametro = 'Estado parámetro forzar QR continuo'
						.Proyecto = 'FELINO'
						.TipoDato = 'L'
						.Default = .T.
						.IdUnico = '1D96B4DBE1036514BFE18FAA17091364546081'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Estadoparametroforzarqrcontinuo = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Estadoparametroforzarqrcontinuo = .Sucursal.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Estadoparametroforzarqrcontinuo = txValor 
				return .Estadoparametroforzarqrcontinuo

			endif
		endwith
	endfunc

	function Estadoparametroforzarqrnocontinuo_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 3
					.idNodo = 1
					.Parametro = 'Estado parámetro forzar QR no continuo'
					.Proyecto = 'FELINO'
					.TipoDato = 'L'
					.Default = .F.
					.IdUnico = '155762E3917F20145251855312902933712781'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Estadoparametroforzarqrnocontinuo = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Estadoparametroforzarqrnocontinuo = .Sucursal.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Estadoparametroforzarqrnocontinuo

			endif
		endwith
	endfunc

	function Estadoparametroforzarqrnocontinuo_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 3
						.idNodo = 1
						.Parametro = 'Estado parámetro forzar QR no continuo'
						.Proyecto = 'FELINO'
						.TipoDato = 'L'
						.Default = .F.
						.IdUnico = '155762E3917F20145251855312902933712781'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Estadoparametroforzarqrnocontinuo = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Estadoparametroforzarqrnocontinuo = .Sucursal.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Estadoparametroforzarqrnocontinuo = txValor 
				return .Estadoparametroforzarqrnocontinuo

			endif
		endwith
	endfunc

	function Feuruguaymodocontingenciaactivado_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'FE Uruguay Modo contingencia activado'
					.Proyecto = 'FELINO'
					.TipoDato = 'L'
					.Default = .F.
					.IdUnico = '19C6D118415CB514E431B50118717495045761'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Feuruguaymodocontingenciaactivado = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Feuruguaymodocontingenciaactivado = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Feuruguaymodocontingenciaactivado

			endif
		endwith
	endfunc

	function Feuruguaymodocontingenciaactivado_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'FE Uruguay Modo contingencia activado'
						.Proyecto = 'FELINO'
						.TipoDato = 'L'
						.Default = .F.
						.IdUnico = '19C6D118415CB514E431B50118717495045761'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Feuruguaymodocontingenciaactivado = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Feuruguaymodocontingenciaactivado = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Feuruguaymodocontingenciaactivado = txValor 
				return .Feuruguaymodocontingenciaactivado

			endif
		endwith
	endfunc

	function Tiempodedemoradeleventoaplicarpromocionautomatica_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 3
					.idNodo = 1
					.Parametro = 'Tiempo de demora del evento aplicar promocion automatica'
					.Proyecto = 'FELINO'
					.TipoDato = 'N'
					.Default = 150
					.IdUnico = '17A124D6E1D8CE140FD1998610627356366401'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Tiempodedemoradeleventoaplicarpromocionautomatica = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Tiempodedemoradeleventoaplicarpromocionautomatica = .Sucursal.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Tiempodedemoradeleventoaplicarpromocionautomatica

			endif
		endwith
	endfunc

	function Tiempodedemoradeleventoaplicarpromocionautomatica_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 3
						.idNodo = 1
						.Parametro = 'Tiempo de demora del evento aplicar promocion automatica'
						.Proyecto = 'FELINO'
						.TipoDato = 'N'
						.Default = 150
						.IdUnico = '17A124D6E1D8CE140FD1998610627356366401'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Tiempodedemoradeleventoaplicarpromocionautomatica = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Tiempodedemoradeleventoaplicarpromocionautomatica = .Sucursal.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Tiempodedemoradeleventoaplicarpromocionautomatica = txValor 
				return .Tiempodedemoradeleventoaplicarpromocionautomatica

			endif
		endwith
	endfunc

	function Urldeventademercadolibre_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 1
					.Parametro = 'URLDeVentaDeMercadoLibre'
					.Proyecto = 'FELINO'
					.TipoDato = 'C'
					.Default = 'www.mercadolibre.com.ar/ventas/#NroDeOrden#/detalle'
					.IdUnico = '1A80786C316797143AA19EB312498715823831'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Urldeventademercadolibre = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Urldeventademercadolibre = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Urldeventademercadolibre

			endif
		endwith
	endfunc

	function Urldeventademercadolibre_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 1
						.Parametro = 'URLDeVentaDeMercadoLibre'
						.Proyecto = 'FELINO'
						.TipoDato = 'C'
						.Default = 'www.mercadolibre.com.ar/ventas/#NroDeOrden#/detalle'
						.IdUnico = '1A80786C316797143AA19EB312498715823831'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Urldeventademercadolibre = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Urldeventademercadolibre = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Urldeventademercadolibre = txValor 
				return .Urldeventademercadolibre

			endif
		endwith
	endfunc

	function Femodocaeaactivado_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'FE modo CAEA activado'
					.Proyecto = 'FELINO'
					.TipoDato = 'L'
					.Default = .F.
					.IdUnico = '16B7EA2911EE33145AA18D6B18915064604401'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Femodocaeaactivado = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Femodocaeaactivado = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Femodocaeaactivado

			endif
		endwith
	endfunc

	function Femodocaeaactivado_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'FE modo CAEA activado'
						.Proyecto = 'FELINO'
						.TipoDato = 'L'
						.Default = .F.
						.IdUnico = '16B7EA2911EE33145AA18D6B18915064604401'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Femodocaeaactivado = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Femodocaeaactivado = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Femodocaeaactivado = txValor 
				return .Femodocaeaactivado

			endif
		endwith
	endfunc

	function Actualizotipodeentregaporpuesto_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'ActualizoTipoDeEntregaPorPuesto'
					.Proyecto = 'FELINO'
					.TipoDato = 'L'
					.Default = .F.
					.IdUnico = '1904F24CB178F9144051823514656895329741'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Actualizotipodeentregaporpuesto = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Actualizotipodeentregaporpuesto = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Actualizotipodeentregaporpuesto

			endif
		endwith
	endfunc

	function Actualizotipodeentregaporpuesto_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'ActualizoTipoDeEntregaPorPuesto'
						.Proyecto = 'FELINO'
						.TipoDato = 'L'
						.Default = .F.
						.IdUnico = '1904F24CB178F9144051823514656895329741'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Actualizotipodeentregaporpuesto = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Actualizotipodeentregaporpuesto = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Actualizotipodeentregaporpuesto = txValor 
				return .Actualizotipodeentregaporpuesto

			endif
		endwith
	endfunc

	function Diasrestringidosporafipparainformarcaea_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 3
					.idNodo = 1
					.Parametro = 'Dias restringidos por AFIP para informar CAEA'
					.Proyecto = 'FELINO'
					.TipoDato = 'C'
					.Default = '1,16'
					.IdUnico = '15A7506721352F1449D1AE3419903476631361'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Diasrestringidosporafipparainformarcaea = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Diasrestringidosporafipparainformarcaea = .Sucursal.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Diasrestringidosporafipparainformarcaea

			endif
		endwith
	endfunc

	function Diasrestringidosporafipparainformarcaea_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 3
						.idNodo = 1
						.Parametro = 'Dias restringidos por AFIP para informar CAEA'
						.Proyecto = 'FELINO'
						.TipoDato = 'C'
						.Default = '1,16'
						.IdUnico = '15A7506721352F1449D1AE3419903476631361'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Diasrestringidosporafipparainformarcaea = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Diasrestringidosporafipparainformarcaea = .Sucursal.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Diasrestringidosporafipparainformarcaea = txValor 
				return .Diasrestringidosporafipparainformarcaea

			endif
		endwith
	endfunc

	function Idcomprobanteequidadarca_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'id comprobante equidad ARCA'
					.Proyecto = 'FELINO'
					.TipoDato = 'C'
					.Default = ''
					.IdUnico = '1A7C6A97119D05141D419FEB11126461315971'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Idcomprobanteequidadarca = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Idcomprobanteequidadarca = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Idcomprobanteequidadarca

			endif
		endwith
	endfunc

	function Idcomprobanteequidadarca_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'id comprobante equidad ARCA'
						.Proyecto = 'FELINO'
						.TipoDato = 'C'
						.Default = ''
						.IdUnico = '1A7C6A97119D05141D419FEB11126461315971'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Idcomprobanteequidadarca = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Idcomprobanteequidadarca = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Idcomprobanteequidadarca = txValor 
				return .Idcomprobanteequidadarca

			endif
		endwith
	endfunc


			*-----------------------------------------------------------------------------------------
			function Destroy()
				local lnCantidad as Integer, laPropiedades as array, lnTablaActual as Integer,;
				lnPropiedadActual as Integer, lcPropiedad as String, lcEliminaReferencia as String    
				dimension laPropiedades(1)

				this.lDestroy = .t.

				lnCantidad = Amembers(laPropiedades,this,0,"U" )
				for lnPropiedadActual = 1 to lnCantidad
					lcPropiedad = "this."+ alltrim(laPropiedades(lnPropiedadActual))
					if vartype ( evaluate(lcPropiedad) ) = "O"
						if pemstatus(&lcPropiedad,"release",5)
							lcEliminaReferencia = lcPropiedad + ".release"
							&lcEliminaReferencia
						endif
					endif
				endfor

			endfunc

			*-----------------------------------------------------------------------------------------
			function Release() as Void
				release this 
			endfunc 
enddefine


define class Parametros_Generadores as custom

	nNodo = 1
	lAccess = .f.
	lDestroy = .f.

	function init() as void
		with this
		endwith
	endfunc


			*-----------------------------------------------------------------------------------------
			function Destroy()
				local lnCantidad as Integer, laPropiedades as array, lnTablaActual as Integer,;
				lnPropiedadActual as Integer, lcPropiedad as String, lcEliminaReferencia as String    
				dimension laPropiedades(1)

				this.lDestroy = .t.

				lnCantidad = Amembers(laPropiedades,this,0,"U" )
				for lnPropiedadActual = 1 to lnCantidad
					lcPropiedad = "this."+ alltrim(laPropiedades(lnPropiedadActual))
					if vartype ( evaluate(lcPropiedad) ) = "O"
						if pemstatus(&lcPropiedad,"release",5)
							lcEliminaReferencia = lcPropiedad + ".release"
							&lcEliminaReferencia
						endif
					endif
				endfor

			endfunc

			*-----------------------------------------------------------------------------------------
			function Release() as Void
				release this 
			endfunc 
enddefine


define class Parametros_Nucleo as custom

	nNodo = 1
	lAccess = .f.
	lDestroy = .f.

	Seguridad = null
	Transferencias = null
	Importaciones = null
	Sc = null
	Actualizaciones = null
	Serviciorest = null
	SonidosYNotificaciones = null
	EnvioDeMails = null

	VersionDeEstructuraDeDatos = 0
	FormularioprincipalAncho = 800
	FormularioprincipalAlto = 600
	Cantidaddeitemsdedetallepordefecto = 999
	Rutaregistrosorganizacion = ''
	Minutosregistroterminal = 60000
	Cambiarelfocoalhacermas = .T.
	Timeoutdesconectarterminal = 120
	Milisegundosbascula = 1000
	Faltangenerados = .F.
	Cantidadtimerbase = 10
	Precisiontimerbase = 200
	Extensionesaceptadasparalogueomonitor = 'ZIP-TXT'
	Registrosutilizadosporautocompletar = 20
	Fechaenblancoparasqlserver = '{01/01/1900 00:00:00}'
	Version = '00.0000.0000'
	Tiempodeesperaparareintentoconexion = 0
	Numerodereintentosdeconexion = 0
	Repositorioparalogueopordefecto = 'log.err'
	Nivelparalogueopordefecto = 4
	Rutalogueopordefecto = '.\LOG\'
	Cantidadcortesrepositorioparalogueopordefecto = 2
	Volumenrepositorioparalogueopordefecto = 1000
	Rutadedisenos = '\disenos'
	Cadenadecaracteresvalidos = '1234567890ABCDEFGHIJKLMNÑOPQRSTUVWXYZ_ abcdefghijklmnñopqrstuvwxyzº\ª!@#$%&/()=?¿*{}[]<>,.;:-áéíóúÁÉÍÓÚ+-"'
	Prefijotablasauditoria = 'ADT_'
	Caracteresvalidosadicionalesparaclavesprimarias = '\/!@#$%&()*{}[]<>,;:+'
	Formularioprincipalestado = 0
	Archivoparalogueointerno = 'LogInterno.log'
	Tiempodeesperaparacerraraplicacion = 60
	Tiempodeltimerpararefrescodemensajes = 500
	Usarservicioregistroterminal = .T.
	Cadenadeletrasvalidas = 'ABCDEFGHIJKLMNÑOPQRSTUVWXYZ'
	Cadenadenumerosvalidos = '0123456789'
	Cadenadecaracteresespecialesvalidos = 'º\ª!@#$%&() =?¿*{}[]<>,;:-áéíóúÁÉÍÓÚ+"'
	Cadenadecaracteresbasicosvalidos = '-. /'
	Tamanodepapelminimoparaimprimirlistados = 5040
	Numerovistapreviacodigosugerido = 1
	Mensajeerrorcuandonosepuedehacervistaprevia = 'EXCEDE EL ANCHO A SUGERIR'
	Codigosasciiparaarmarexpresionestipostring = '39,93 ,91,34'
	Cantidaddeelementosensentenciainsql = 10000
	Ejecutarcheckpointalhacercommittransaction = .F.
	Ultimafechavalidacioncorrectabdsucursal = {  /  /    }
	Ultimafechavalidacioncorrectabdorganizacion = {  /  /    }
	Cantidaddediasultimafechavalidacioncorrectabd = 3
	Fechadehabilitaciondetrazaextendida = {  /  /    }
	Versionbasededatossucursal = ''
	Versionbasededatosorganizacion = ''
	Defaulttiempodeesperasmtp = 100
	Reintentosdeobtenciondenumerocontalonariousado = 3
	Rutaplantillasdedisenoexportacion = 'plantillas\'
	Cantidaddeelementosensegmentoaimportar = 50000
	Habilitararticulototalizador = .F.
	Usardragonfishcloud = .F.
	Cantidaddembpermitidosenelpesodelreporteparalistadosconimagenes = 2600
	Mayorprecisiondecimalencantidad = .F.
	Separadordecolumnascsv = ';'
	Delimitadordecaracterescsv = '"'
	Delimitadorinicialdeatributosparamacrosustitucion = '{'
	Delimitadorfinaldeatributosparamacrosustitucion = '}'

	function init() as void
		with this
			.Seguridad = newobject( "NUCLEO_Seguridad") 
			.Transferencias = newobject( "NUCLEO_Transferencias") 
			.Importaciones = newobject( "NUCLEO_Importaciones") 
			.Sc = newobject( "NUCLEO_Sc") 
			.Actualizaciones = newobject( "NUCLEO_Actualizaciones") 
			.Serviciorest = newobject( "NUCLEO_Serviciorest") 
			.SonidosYNotificaciones = newobject( "NUCLEO_SonidosYNotificaciones") 
			.EnvioDeMails = newobject( "NUCLEO_EnvioDeMails") 
		endwith
	endfunc

	function VersionDeEstructuraDeDatos_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Version de Estructura de Datos'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 0
					.IdUnico = '1DFF32BE71590F148441BC4815428723700761'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.VersionDeEstructuraDeDatos = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.VersionDeEstructuraDeDatos = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .VersionDeEstructuraDeDatos

			endif
		endwith
	endfunc

	function VersionDeEstructuraDeDatos_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Version de Estructura de Datos'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 0
						.IdUnico = '1DFF32BE71590F148441BC4815428723700761'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.VersionDeEstructuraDeDatos = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.VersionDeEstructuraDeDatos = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.VersionDeEstructuraDeDatos = txValor 
				return .VersionDeEstructuraDeDatos

			endif
		endwith
	endfunc

	function FormularioprincipalAncho_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'FormularioPrincipal_Ancho'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 800
					.IdUnico = '187B5A78115D40146911BBE718089750795351'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.FormularioprincipalAncho = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.FormularioprincipalAncho = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .FormularioprincipalAncho

			endif
		endwith
	endfunc

	function FormularioprincipalAncho_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'FormularioPrincipal_Ancho'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 800
						.IdUnico = '187B5A78115D40146911BBE718089750795351'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.FormularioprincipalAncho = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.FormularioprincipalAncho = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.FormularioprincipalAncho = txValor 
				return .FormularioprincipalAncho

			endif
		endwith
	endfunc

	function FormularioprincipalAlto_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'FormularioPrincipal_Alto'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 600
					.IdUnico = '1EC7ADAA617E761418B189D112578804357801'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.FormularioprincipalAlto = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.FormularioprincipalAlto = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .FormularioprincipalAlto

			endif
		endwith
	endfunc

	function FormularioprincipalAlto_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'FormularioPrincipal_Alto'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 600
						.IdUnico = '1EC7ADAA617E761418B189D112578804357801'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.FormularioprincipalAlto = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.FormularioprincipalAlto = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.FormularioprincipalAlto = txValor 
				return .FormularioprincipalAlto

			endif
		endwith
	endfunc

	function Cantidaddeitemsdedetallepordefecto_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Cantidad De Items de Detalle Por Defecto'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 999
					.IdUnico = '13A8F69EC190E71482E1803515339337823201'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Cantidaddeitemsdedetallepordefecto = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Cantidaddeitemsdedetallepordefecto = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Cantidaddeitemsdedetallepordefecto

			endif
		endwith
	endfunc

	function Cantidaddeitemsdedetallepordefecto_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Cantidad De Items de Detalle Por Defecto'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 999
						.IdUnico = '13A8F69EC190E71482E1803515339337823201'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Cantidaddeitemsdedetallepordefecto = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Cantidaddeitemsdedetallepordefecto = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Cantidaddeitemsdedetallepordefecto = txValor 
				return .Cantidaddeitemsdedetallepordefecto

			endif
		endwith
	endfunc

	function Rutaregistrosorganizacion_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'RutaRegistrosOrganizacion'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = ''
					.IdUnico = '13F2F87D914E261469E1B33316549360925311'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Rutaregistrosorganizacion = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Rutaregistrosorganizacion = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Rutaregistrosorganizacion

			endif
		endwith
	endfunc

	function Rutaregistrosorganizacion_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'RutaRegistrosOrganizacion'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = ''
						.IdUnico = '13F2F87D914E261469E1B33316549360925311'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Rutaregistrosorganizacion = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Rutaregistrosorganizacion = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Rutaregistrosorganizacion = txValor 
				return .Rutaregistrosorganizacion

			endif
		endwith
	endfunc

	function Minutosregistroterminal_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'MinutosRegistroTerminal'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 60000
					.IdUnico = '1BBBF32401B347148BF1B5CA11786171485871'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Minutosregistroterminal = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Minutosregistroterminal = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Minutosregistroterminal

			endif
		endwith
	endfunc

	function Minutosregistroterminal_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'MinutosRegistroTerminal'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 60000
						.IdUnico = '1BBBF32401B347148BF1B5CA11786171485871'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Minutosregistroterminal = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Minutosregistroterminal = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Minutosregistroterminal = txValor 
				return .Minutosregistroterminal

			endif
		endwith
	endfunc

	function Cambiarelfocoalhacermas_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'CambiarElFocoAlHacerMas'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'L'
					.Default = .T.
					.IdUnico = '1CD80F8031965F14C621A9D213760307838211'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Cambiarelfocoalhacermas = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Cambiarelfocoalhacermas = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Cambiarelfocoalhacermas

			endif
		endwith
	endfunc

	function Cambiarelfocoalhacermas_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'CambiarElFocoAlHacerMas'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'L'
						.Default = .T.
						.IdUnico = '1CD80F8031965F14C621A9D213760307838211'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Cambiarelfocoalhacermas = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Cambiarelfocoalhacermas = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Cambiarelfocoalhacermas = txValor 
				return .Cambiarelfocoalhacermas

			endif
		endwith
	endfunc

	function Timeoutdesconectarterminal_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'TimeOutDesconectarTerminal'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 120
					.IdUnico = '14898ABD11360A147121A69411683153118201'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Timeoutdesconectarterminal = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Timeoutdesconectarterminal = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Timeoutdesconectarterminal

			endif
		endwith
	endfunc

	function Timeoutdesconectarterminal_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'TimeOutDesconectarTerminal'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 120
						.IdUnico = '14898ABD11360A147121A69411683153118201'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Timeoutdesconectarterminal = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Timeoutdesconectarterminal = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Timeoutdesconectarterminal = txValor 
				return .Timeoutdesconectarterminal

			endif
		endwith
	endfunc

	function Milisegundosbascula_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Milisegundos Bascula'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 1000
					.IdUnico = '195C19A801716E14B03197A313942324441881'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Milisegundosbascula = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Milisegundosbascula = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Milisegundosbascula

			endif
		endwith
	endfunc

	function Milisegundosbascula_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Milisegundos Bascula'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 1000
						.IdUnico = '195C19A801716E14B03197A313942324441881'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Milisegundosbascula = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Milisegundosbascula = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Milisegundosbascula = txValor 
				return .Milisegundosbascula

			endif
		endwith
	endfunc

	function Faltangenerados_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 1
					.Parametro = 'faltangenerados'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'L'
					.Default = .F.
					.IdUnico = '15228EC2A1157B1446F19A3215841010527391'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Faltangenerados = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Faltangenerados = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Faltangenerados

			endif
		endwith
	endfunc

	function Faltangenerados_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 1
						.Parametro = 'faltangenerados'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'L'
						.Default = .F.
						.IdUnico = '15228EC2A1157B1446F19A3215841010527391'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Faltangenerados = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Faltangenerados = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Faltangenerados = txValor 
				return .Faltangenerados

			endif
		endwith
	endfunc

	function Cantidadtimerbase_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 1
					.Parametro = 'cantidad timer base'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 10
					.IdUnico = '1A61039ED13BE2144B01B3EE14791121698391'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Cantidadtimerbase = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Cantidadtimerbase = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Cantidadtimerbase

			endif
		endwith
	endfunc

	function Cantidadtimerbase_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 1
						.Parametro = 'cantidad timer base'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 10
						.IdUnico = '1A61039ED13BE2144B01B3EE14791121698391'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Cantidadtimerbase = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Cantidadtimerbase = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Cantidadtimerbase = txValor 
				return .Cantidadtimerbase

			endif
		endwith
	endfunc

	function Precisiontimerbase_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 1
					.Parametro = 'precision timer base'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 200
					.IdUnico = '1EC57A4C71BB9714D3E1A55C14206049870501'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Precisiontimerbase = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Precisiontimerbase = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Precisiontimerbase

			endif
		endwith
	endfunc

	function Precisiontimerbase_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 1
						.Parametro = 'precision timer base'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 200
						.IdUnico = '1EC57A4C71BB9714D3E1A55C14206049870501'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Precisiontimerbase = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Precisiontimerbase = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Precisiontimerbase = txValor 
				return .Precisiontimerbase

			endif
		endwith
	endfunc

	function Extensionesaceptadasparalogueomonitor_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 1
					.Parametro = 'ExtensionesAceptadasParaLogueoMonitor'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = 'ZIP-TXT'
					.IdUnico = '132A09E5F1A47314B651B0AC17623562337811'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Extensionesaceptadasparalogueomonitor = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Extensionesaceptadasparalogueomonitor = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Extensionesaceptadasparalogueomonitor

			endif
		endwith
	endfunc

	function Extensionesaceptadasparalogueomonitor_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 1
						.Parametro = 'ExtensionesAceptadasParaLogueoMonitor'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = 'ZIP-TXT'
						.IdUnico = '132A09E5F1A47314B651B0AC17623562337811'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Extensionesaceptadasparalogueomonitor = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Extensionesaceptadasparalogueomonitor = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Extensionesaceptadasparalogueomonitor = txValor 
				return .Extensionesaceptadasparalogueomonitor

			endif
		endwith
	endfunc

	function Registrosutilizadosporautocompletar_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 1
					.Parametro = 'Registrosutilizadosporautocompletar'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 20
					.IdUnico = '12942C0401DCE9145731890611972246340001'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Registrosutilizadosporautocompletar = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Registrosutilizadosporautocompletar = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Registrosutilizadosporautocompletar

			endif
		endwith
	endfunc

	function Registrosutilizadosporautocompletar_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 1
						.Parametro = 'Registrosutilizadosporautocompletar'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 20
						.IdUnico = '12942C0401DCE9145731890611972246340001'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Registrosutilizadosporautocompletar = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Registrosutilizadosporautocompletar = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Registrosutilizadosporautocompletar = txValor 
				return .Registrosutilizadosporautocompletar

			endif
		endwith
	endfunc

	function Fechaenblancoparasqlserver_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 1
					.Parametro = 'FechaEnBlancoParaSqlServer'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = '{01/01/1900 00:00:00}'
					.IdUnico = '11E6A603D1B81B14D461B2EE15352758930901'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Fechaenblancoparasqlserver = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Fechaenblancoparasqlserver = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Fechaenblancoparasqlserver

			endif
		endwith
	endfunc

	function Fechaenblancoparasqlserver_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 1
						.Parametro = 'FechaEnBlancoParaSqlServer'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = '{01/01/1900 00:00:00}'
						.IdUnico = '11E6A603D1B81B14D461B2EE15352758930901'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Fechaenblancoparasqlserver = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Fechaenblancoparasqlserver = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Fechaenblancoparasqlserver = txValor 
				return .Fechaenblancoparasqlserver

			endif
		endwith
	endfunc

	function Version_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 3
					.idNodo = 1
					.Parametro = 'Version'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = '00.0000.0000'
					.IdUnico = '176B7FC7017AE014C671BDC412919584619321'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Version = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Version = .Sucursal.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Version

			endif
		endwith
	endfunc

	function Version_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 3
						.idNodo = 1
						.Parametro = 'Version'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = '00.0000.0000'
						.IdUnico = '176B7FC7017AE014C671BDC412919584619321'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Version = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Version = .Sucursal.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Version = txValor 
				return .Version

			endif
		endwith
	endfunc

	function Tiempodeesperaparareintentoconexion_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Tiempo de espera para reintento conexion'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 0
					.IdUnico = '12D1F8608102C214FE318BDF10625568241501'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Tiempodeesperaparareintentoconexion = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Tiempodeesperaparareintentoconexion = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Tiempodeesperaparareintentoconexion

			endif
		endwith
	endfunc

	function Tiempodeesperaparareintentoconexion_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Tiempo de espera para reintento conexion'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 0
						.IdUnico = '12D1F8608102C214FE318BDF10625568241501'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Tiempodeesperaparareintentoconexion = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Tiempodeesperaparareintentoconexion = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Tiempodeesperaparareintentoconexion = txValor 
				return .Tiempodeesperaparareintentoconexion

			endif
		endwith
	endfunc

	function Numerodereintentosdeconexion_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Numero de reintentos de conexion'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 0
					.IdUnico = '118D9CF54110241494A1AD7E12148498500101'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Numerodereintentosdeconexion = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Numerodereintentosdeconexion = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Numerodereintentosdeconexion

			endif
		endwith
	endfunc

	function Numerodereintentosdeconexion_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Numero de reintentos de conexion'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 0
						.IdUnico = '118D9CF54110241494A1AD7E12148498500101'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Numerodereintentosdeconexion = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Numerodereintentosdeconexion = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Numerodereintentosdeconexion = txValor 
				return .Numerodereintentosdeconexion

			endif
		endwith
	endfunc

	function Repositorioparalogueopordefecto_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Repositorio para logueo por defecto'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = 'log.err'
					.IdUnico = '152DDE95D19076141831AFFF11709491422111'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Repositorioparalogueopordefecto = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Repositorioparalogueopordefecto = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Repositorioparalogueopordefecto

			endif
		endwith
	endfunc

	function Repositorioparalogueopordefecto_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Repositorio para logueo por defecto'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = 'log.err'
						.IdUnico = '152DDE95D19076141831AFFF11709491422111'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Repositorioparalogueopordefecto = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Repositorioparalogueopordefecto = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Repositorioparalogueopordefecto = txValor 
				return .Repositorioparalogueopordefecto

			endif
		endwith
	endfunc

	function Nivelparalogueopordefecto_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Nivel para logueo por defecto'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 4
					.IdUnico = '15CD5BFA31812A1427F1A37813532144233561'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Nivelparalogueopordefecto = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Nivelparalogueopordefecto = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Nivelparalogueopordefecto

			endif
		endwith
	endfunc

	function Nivelparalogueopordefecto_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Nivel para logueo por defecto'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 4
						.IdUnico = '15CD5BFA31812A1427F1A37813532144233561'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Nivelparalogueopordefecto = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Nivelparalogueopordefecto = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Nivelparalogueopordefecto = txValor 
				return .Nivelparalogueopordefecto

			endif
		endwith
	endfunc

	function Rutalogueopordefecto_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Ruta logueo por defecto'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = '.\LOG\'
					.IdUnico = '1698FFB2D1F08D146191A26811389401355701'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Rutalogueopordefecto = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Rutalogueopordefecto = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Rutalogueopordefecto

			endif
		endwith
	endfunc

	function Rutalogueopordefecto_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Ruta logueo por defecto'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = '.\LOG\'
						.IdUnico = '1698FFB2D1F08D146191A26811389401355701'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Rutalogueopordefecto = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Rutalogueopordefecto = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Rutalogueopordefecto = txValor 
				return .Rutalogueopordefecto

			endif
		endwith
	endfunc

	function Cantidadcortesrepositorioparalogueopordefecto_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Cantidad cortes repositorio para logueo por defecto'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 2
					.IdUnico = '14609D60F1F927140001AEFA11884876289551'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Cantidadcortesrepositorioparalogueopordefecto = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Cantidadcortesrepositorioparalogueopordefecto = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Cantidadcortesrepositorioparalogueopordefecto

			endif
		endwith
	endfunc

	function Cantidadcortesrepositorioparalogueopordefecto_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Cantidad cortes repositorio para logueo por defecto'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 2
						.IdUnico = '14609D60F1F927140001AEFA11884876289551'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Cantidadcortesrepositorioparalogueopordefecto = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Cantidadcortesrepositorioparalogueopordefecto = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Cantidadcortesrepositorioparalogueopordefecto = txValor 
				return .Cantidadcortesrepositorioparalogueopordefecto

			endif
		endwith
	endfunc

	function Volumenrepositorioparalogueopordefecto_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Volumen repositorio para logueo por defecto'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 1000
					.IdUnico = '1C92AEA32178BA14B5C1B90614931398010181'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Volumenrepositorioparalogueopordefecto = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Volumenrepositorioparalogueopordefecto = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Volumenrepositorioparalogueopordefecto

			endif
		endwith
	endfunc

	function Volumenrepositorioparalogueopordefecto_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Volumen repositorio para logueo por defecto'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 1000
						.IdUnico = '1C92AEA32178BA14B5C1B90614931398010181'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Volumenrepositorioparalogueopordefecto = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Volumenrepositorioparalogueopordefecto = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Volumenrepositorioparalogueopordefecto = txValor 
				return .Volumenrepositorioparalogueopordefecto

			endif
		endwith
	endfunc

	function Rutadedisenos_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Ruta de diseños'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = '\disenos'
					.IdUnico = '199DB61281F48214D0A1B80C18949524138511'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Rutadedisenos = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Rutadedisenos = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Rutadedisenos

			endif
		endwith
	endfunc

	function Rutadedisenos_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Ruta de diseños'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = '\disenos'
						.IdUnico = '199DB61281F48214D0A1B80C18949524138511'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Rutadedisenos = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Rutadedisenos = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Rutadedisenos = txValor 
				return .Rutadedisenos

			endif
		endwith
	endfunc

	function Cadenadecaracteresvalidos_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Cadena de caracteres válidos'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = '1234567890ABCDEFGHIJKLMNÑOPQRSTUVWXYZ_ abcdefghijklmnñopqrstuvwxyzº\ª!@#$%&/()=?¿*{}[]<>,.;:-áéíóúÁÉÍÓÚ+-"'
					.IdUnico = '1EB57088C1FEB5141691898B14548437494951'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Cadenadecaracteresvalidos = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Cadenadecaracteresvalidos = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Cadenadecaracteresvalidos

			endif
		endwith
	endfunc

	function Cadenadecaracteresvalidos_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Cadena de caracteres válidos'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = '1234567890ABCDEFGHIJKLMNÑOPQRSTUVWXYZ_ abcdefghijklmnñopqrstuvwxyzº\ª!@#$%&/()=?¿*{}[]<>,.;:-áéíóúÁÉÍÓÚ+-"'
						.IdUnico = '1EB57088C1FEB5141691898B14548437494951'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Cadenadecaracteresvalidos = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Cadenadecaracteresvalidos = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Cadenadecaracteresvalidos = txValor 
				return .Cadenadecaracteresvalidos

			endif
		endwith
	endfunc

	function Prefijotablasauditoria_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'PrefijoTablasAuditoria'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = 'ADT_'
					.IdUnico = '1B26F2BE61ED1A14FF91B69C13894185591641'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Prefijotablasauditoria = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Prefijotablasauditoria = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Prefijotablasauditoria

			endif
		endwith
	endfunc

	function Prefijotablasauditoria_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'PrefijoTablasAuditoria'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = 'ADT_'
						.IdUnico = '1B26F2BE61ED1A14FF91B69C13894185591641'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Prefijotablasauditoria = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Prefijotablasauditoria = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Prefijotablasauditoria = txValor 
				return .Prefijotablasauditoria

			endif
		endwith
	endfunc

	function Caracteresvalidosadicionalesparaclavesprimarias_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Caracteres Validos Adicionales Para Claves Primarias'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = '\/!@#$%&()*{}[]<>,;:+'
					.IdUnico = '1D969F2B11B17314A331ACE916503608868661'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Caracteresvalidosadicionalesparaclavesprimarias = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Caracteresvalidosadicionalesparaclavesprimarias = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Caracteresvalidosadicionalesparaclavesprimarias

			endif
		endwith
	endfunc

	function Caracteresvalidosadicionalesparaclavesprimarias_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Caracteres Validos Adicionales Para Claves Primarias'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = '\/!@#$%&()*{}[]<>,;:+'
						.IdUnico = '1D969F2B11B17314A331ACE916503608868661'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Caracteresvalidosadicionalesparaclavesprimarias = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Caracteresvalidosadicionalesparaclavesprimarias = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Caracteresvalidosadicionalesparaclavesprimarias = txValor 
				return .Caracteresvalidosadicionalesparaclavesprimarias

			endif
		endwith
	endfunc

	function Formularioprincipalestado_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 1
					.Parametro = 'Formulario Principal Estado'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 0
					.IdUnico = '12B30A16C14DBF14F67184CD15764378518501'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Formularioprincipalestado = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Formularioprincipalestado = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Formularioprincipalestado

			endif
		endwith
	endfunc

	function Formularioprincipalestado_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 1
						.Parametro = 'Formulario Principal Estado'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 0
						.IdUnico = '12B30A16C14DBF14F67184CD15764378518501'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Formularioprincipalestado = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Formularioprincipalestado = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Formularioprincipalestado = txValor 
				return .Formularioprincipalestado

			endif
		endwith
	endfunc

	function Archivoparalogueointerno_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'ArchivoParaLogueoInterno'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = 'LogInterno.log'
					.IdUnico = '1657F171C1D001142021AD6017819247240081'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Archivoparalogueointerno = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Archivoparalogueointerno = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Archivoparalogueointerno

			endif
		endwith
	endfunc

	function Archivoparalogueointerno_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'ArchivoParaLogueoInterno'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = 'LogInterno.log'
						.IdUnico = '1657F171C1D001142021AD6017819247240081'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Archivoparalogueointerno = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Archivoparalogueointerno = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Archivoparalogueointerno = txValor 
				return .Archivoparalogueointerno

			endif
		endwith
	endfunc

	function Tiempodeesperaparacerraraplicacion_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 1
					.Parametro = 'TiempoDeEsperaParaCerrarAplicacion'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 60
					.IdUnico = '1B0E59C6C12F111413F1A30014654918379011'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Tiempodeesperaparacerraraplicacion = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Tiempodeesperaparacerraraplicacion = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Tiempodeesperaparacerraraplicacion

			endif
		endwith
	endfunc

	function Tiempodeesperaparacerraraplicacion_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 1
						.Parametro = 'TiempoDeEsperaParaCerrarAplicacion'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 60
						.IdUnico = '1B0E59C6C12F111413F1A30014654918379011'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Tiempodeesperaparacerraraplicacion = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Tiempodeesperaparacerraraplicacion = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Tiempodeesperaparacerraraplicacion = txValor 
				return .Tiempodeesperaparacerraraplicacion

			endif
		endwith
	endfunc

	function Tiempodeltimerpararefrescodemensajes_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 1
					.Parametro = 'TiempoDelTimerPararefrescoDeMensajes'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 500
					.IdUnico = '125C52D19168101440518A2A11972471521831'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Tiempodeltimerpararefrescodemensajes = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Tiempodeltimerpararefrescodemensajes = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Tiempodeltimerpararefrescodemensajes

			endif
		endwith
	endfunc

	function Tiempodeltimerpararefrescodemensajes_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 1
						.Parametro = 'TiempoDelTimerPararefrescoDeMensajes'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 500
						.IdUnico = '125C52D19168101440518A2A11972471521831'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Tiempodeltimerpararefrescodemensajes = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Tiempodeltimerpararefrescodemensajes = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Tiempodeltimerpararefrescodemensajes = txValor 
				return .Tiempodeltimerpararefrescodemensajes

			endif
		endwith
	endfunc

	function Usarservicioregistroterminal_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 1
					.Parametro = 'Usar Servicio Registro Terminal'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'L'
					.Default = .T.
					.IdUnico = '163D9209315216140DE1A96D14607438843921'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Usarservicioregistroterminal = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Usarservicioregistroterminal = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Usarservicioregistroterminal

			endif
		endwith
	endfunc

	function Usarservicioregistroterminal_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 1
						.Parametro = 'Usar Servicio Registro Terminal'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'L'
						.Default = .T.
						.IdUnico = '163D9209315216140DE1A96D14607438843921'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Usarservicioregistroterminal = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Usarservicioregistroterminal = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Usarservicioregistroterminal = txValor 
				return .Usarservicioregistroterminal

			endif
		endwith
	endfunc

	function Cadenadeletrasvalidas_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Cadena de Letras Validas'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = 'ABCDEFGHIJKLMNÑOPQRSTUVWXYZ'
					.IdUnico = '1EA2F0559145D41459B1A10B14889506375201'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Cadenadeletrasvalidas = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Cadenadeletrasvalidas = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Cadenadeletrasvalidas

			endif
		endwith
	endfunc

	function Cadenadeletrasvalidas_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Cadena de Letras Validas'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = 'ABCDEFGHIJKLMNÑOPQRSTUVWXYZ'
						.IdUnico = '1EA2F0559145D41459B1A10B14889506375201'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Cadenadeletrasvalidas = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Cadenadeletrasvalidas = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Cadenadeletrasvalidas = txValor 
				return .Cadenadeletrasvalidas

			endif
		endwith
	endfunc

	function Cadenadenumerosvalidos_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Cadena de Numeros Validos'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = '0123456789'
					.IdUnico = '15C3C9DE1198171472E19F3F10505222756901'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Cadenadenumerosvalidos = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Cadenadenumerosvalidos = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Cadenadenumerosvalidos

			endif
		endwith
	endfunc

	function Cadenadenumerosvalidos_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Cadena de Numeros Validos'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = '0123456789'
						.IdUnico = '15C3C9DE1198171472E19F3F10505222756901'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Cadenadenumerosvalidos = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Cadenadenumerosvalidos = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Cadenadenumerosvalidos = txValor 
				return .Cadenadenumerosvalidos

			endif
		endwith
	endfunc

	function Cadenadecaracteresespecialesvalidos_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Cadena de Caracteres Especiales Validos'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = 'º\ª!@#$%&() =?¿*{}[]<>,;:-áéíóúÁÉÍÓÚ+"'
					.IdUnico = '1B99A9FF71688B1483D1BCE611926562133001'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Cadenadecaracteresespecialesvalidos = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Cadenadecaracteresespecialesvalidos = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Cadenadecaracteresespecialesvalidos

			endif
		endwith
	endfunc

	function Cadenadecaracteresespecialesvalidos_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Cadena de Caracteres Especiales Validos'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = 'º\ª!@#$%&() =?¿*{}[]<>,;:-áéíóúÁÉÍÓÚ+"'
						.IdUnico = '1B99A9FF71688B1483D1BCE611926562133001'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Cadenadecaracteresespecialesvalidos = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Cadenadecaracteresespecialesvalidos = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Cadenadecaracteresespecialesvalidos = txValor 
				return .Cadenadecaracteresespecialesvalidos

			endif
		endwith
	endfunc

	function Cadenadecaracteresbasicosvalidos_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Cadena de Caracteres Basicos Validos'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = '-. /'
					.IdUnico = '19B757ACF15048146A91A9AA16044389409691'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Cadenadecaracteresbasicosvalidos = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Cadenadecaracteresbasicosvalidos = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Cadenadecaracteresbasicosvalidos

			endif
		endwith
	endfunc

	function Cadenadecaracteresbasicosvalidos_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Cadena de Caracteres Basicos Validos'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = '-. /'
						.IdUnico = '19B757ACF15048146A91A9AA16044389409691'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Cadenadecaracteresbasicosvalidos = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Cadenadecaracteresbasicosvalidos = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Cadenadecaracteresbasicosvalidos = txValor 
				return .Cadenadecaracteresbasicosvalidos

			endif
		endwith
	endfunc

	function Tamanodepapelminimoparaimprimirlistados_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 1
					.Parametro = 'Tamaño de Papel Minimo para Imprimir Listados'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 5040
					.IdUnico = '19C91D819141D8149E71895E13732644228801'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Tamanodepapelminimoparaimprimirlistados = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Tamanodepapelminimoparaimprimirlistados = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Tamanodepapelminimoparaimprimirlistados

			endif
		endwith
	endfunc

	function Tamanodepapelminimoparaimprimirlistados_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 1
						.Parametro = 'Tamaño de Papel Minimo para Imprimir Listados'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 5040
						.IdUnico = '19C91D819141D8149E71895E13732644228801'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Tamanodepapelminimoparaimprimirlistados = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Tamanodepapelminimoparaimprimirlistados = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Tamanodepapelminimoparaimprimirlistados = txValor 
				return .Tamanodepapelminimoparaimprimirlistados

			endif
		endwith
	endfunc

	function Numerovistapreviacodigosugerido_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 1
					.Parametro = 'Numero para vista previa en codigo sugerido'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 1
					.IdUnico = '1AB4EE87419C9514A7D1ACB813131393924021'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Numerovistapreviacodigosugerido = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Numerovistapreviacodigosugerido = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Numerovistapreviacodigosugerido

			endif
		endwith
	endfunc

	function Numerovistapreviacodigosugerido_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 1
						.Parametro = 'Numero para vista previa en codigo sugerido'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 1
						.IdUnico = '1AB4EE87419C9514A7D1ACB813131393924021'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Numerovistapreviacodigosugerido = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Numerovistapreviacodigosugerido = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Numerovistapreviacodigosugerido = txValor 
				return .Numerovistapreviacodigosugerido

			endif
		endwith
	endfunc

	function Mensajeerrorcuandonosepuedehacervistaprevia_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 1
					.Parametro = 'Mensaje cuando se puede visualizar vistaprevia en codigo sugerido'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = 'EXCEDE EL ANCHO A SUGERIR'
					.IdUnico = '1C23E03561166014BF81946214262011810001'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Mensajeerrorcuandonosepuedehacervistaprevia = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Mensajeerrorcuandonosepuedehacervistaprevia = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Mensajeerrorcuandonosepuedehacervistaprevia

			endif
		endwith
	endfunc

	function Mensajeerrorcuandonosepuedehacervistaprevia_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 1
						.Parametro = 'Mensaje cuando se puede visualizar vistaprevia en codigo sugerido'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = 'EXCEDE EL ANCHO A SUGERIR'
						.IdUnico = '1C23E03561166014BF81946214262011810001'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Mensajeerrorcuandonosepuedehacervistaprevia = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Mensajeerrorcuandonosepuedehacervistaprevia = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Mensajeerrorcuandonosepuedehacervistaprevia = txValor 
				return .Mensajeerrorcuandonosepuedehacervistaprevia

			endif
		endwith
	endfunc

	function Codigosasciiparaarmarexpresionestipostring_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 1
					.Parametro = 'Codigos Ascii Para Armar Expresiones Tipo String'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = '39,93 ,91,34'
					.IdUnico = '10C827AA4151511441F1B11E11718171499151'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Codigosasciiparaarmarexpresionestipostring = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Codigosasciiparaarmarexpresionestipostring = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Codigosasciiparaarmarexpresionestipostring

			endif
		endwith
	endfunc

	function Codigosasciiparaarmarexpresionestipostring_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 1
						.Parametro = 'Codigos Ascii Para Armar Expresiones Tipo String'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = '39,93 ,91,34'
						.IdUnico = '10C827AA4151511441F1B11E11718171499151'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Codigosasciiparaarmarexpresionestipostring = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Codigosasciiparaarmarexpresionestipostring = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Codigosasciiparaarmarexpresionestipostring = txValor 
				return .Codigosasciiparaarmarexpresionestipostring

			endif
		endwith
	endfunc

	function Cantidaddeelementosensentenciainsql_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'CantidadDeElementosEnSentenciaINSql'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 10000
					.IdUnico = '1E8698015114F0142EE1930014755908932801'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Cantidaddeelementosensentenciainsql = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Cantidaddeelementosensentenciainsql = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Cantidaddeelementosensentenciainsql

			endif
		endwith
	endfunc

	function Cantidaddeelementosensentenciainsql_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'CantidadDeElementosEnSentenciaINSql'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 10000
						.IdUnico = '1E8698015114F0142EE1930014755908932801'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Cantidaddeelementosensentenciainsql = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Cantidaddeelementosensentenciainsql = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Cantidaddeelementosensentenciainsql = txValor 
				return .Cantidaddeelementosensentenciainsql

			endif
		endwith
	endfunc

	function Ejecutarcheckpointalhacercommittransaction_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'EjecutarCheckPointAlHacerCommitTransaction'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'L'
					.Default = .F.
					.IdUnico = '1E8698015114F0142EE1930014755908932802'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Ejecutarcheckpointalhacercommittransaction = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Ejecutarcheckpointalhacercommittransaction = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Ejecutarcheckpointalhacercommittransaction

			endif
		endwith
	endfunc

	function Ejecutarcheckpointalhacercommittransaction_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'EjecutarCheckPointAlHacerCommitTransaction'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'L'
						.Default = .F.
						.IdUnico = '1E8698015114F0142EE1930014755908932802'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Ejecutarcheckpointalhacercommittransaction = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Ejecutarcheckpointalhacercommittransaction = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Ejecutarcheckpointalhacercommittransaction = txValor 
				return .Ejecutarcheckpointalhacercommittransaction

			endif
		endwith
	endfunc

	function Ultimafechavalidacioncorrectabdsucursal_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 3
					.idNodo = 1
					.Parametro = 'UltimaFechaValidacionCorrectaBDSucursal'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'D'
					.Default = {  /  /    }
					.IdUnico = '1734418C813F25146111A76411173821743351'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Ultimafechavalidacioncorrectabdsucursal = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Ultimafechavalidacioncorrectabdsucursal = .Sucursal.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Ultimafechavalidacioncorrectabdsucursal

			endif
		endwith
	endfunc

	function Ultimafechavalidacioncorrectabdsucursal_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 3
						.idNodo = 1
						.Parametro = 'UltimaFechaValidacionCorrectaBDSucursal'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'D'
						.Default = {  /  /    }
						.IdUnico = '1734418C813F25146111A76411173821743351'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Ultimafechavalidacioncorrectabdsucursal = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Ultimafechavalidacioncorrectabdsucursal = .Sucursal.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Ultimafechavalidacioncorrectabdsucursal = txValor 
				return .Ultimafechavalidacioncorrectabdsucursal

			endif
		endwith
	endfunc

	function Ultimafechavalidacioncorrectabdorganizacion_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 1
					.Parametro = 'UltimaFechaValidacionCorrectaBDOrganizacion'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'D'
					.Default = {  /  /    }
					.IdUnico = '1734418C813F35146111A76411173821743351'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Ultimafechavalidacioncorrectabdorganizacion = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Ultimafechavalidacioncorrectabdorganizacion = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Ultimafechavalidacioncorrectabdorganizacion

			endif
		endwith
	endfunc

	function Ultimafechavalidacioncorrectabdorganizacion_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 1
						.Parametro = 'UltimaFechaValidacionCorrectaBDOrganizacion'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'D'
						.Default = {  /  /    }
						.IdUnico = '1734418C813F35146111A76411173821743351'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Ultimafechavalidacioncorrectabdorganizacion = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Ultimafechavalidacioncorrectabdorganizacion = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Ultimafechavalidacioncorrectabdorganizacion = txValor 
				return .Ultimafechavalidacioncorrectabdorganizacion

			endif
		endwith
	endfunc

	function Cantidaddediasultimafechavalidacioncorrectabd_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 1
					.Parametro = 'CantidadDeDiasUltimaFechaValidacionCorrectaBD'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 3
					.IdUnico = '17D97EA081E80014F0D19FCB19800034617001'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Cantidaddediasultimafechavalidacioncorrectabd = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Cantidaddediasultimafechavalidacioncorrectabd = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Cantidaddediasultimafechavalidacioncorrectabd

			endif
		endwith
	endfunc

	function Cantidaddediasultimafechavalidacioncorrectabd_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 1
						.Parametro = 'CantidadDeDiasUltimaFechaValidacionCorrectaBD'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 3
						.IdUnico = '17D97EA081E80014F0D19FCB19800034617001'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Cantidaddediasultimafechavalidacioncorrectabd = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Cantidaddediasultimafechavalidacioncorrectabd = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Cantidaddediasultimafechavalidacioncorrectabd = txValor 
				return .Cantidaddediasultimafechavalidacioncorrectabd

			endif
		endwith
	endfunc

	function Fechadehabilitaciondetrazaextendida_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 1
					.Parametro = 'FechaDeHabilitacionDeTrazaExtendida'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'D'
					.Default = {  /  /    }
					.IdUnico = '1DE0C55DB1F104143DF1999416405784142601'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Fechadehabilitaciondetrazaextendida = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Fechadehabilitaciondetrazaextendida = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Fechadehabilitaciondetrazaextendida

			endif
		endwith
	endfunc

	function Fechadehabilitaciondetrazaextendida_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 1
						.Parametro = 'FechaDeHabilitacionDeTrazaExtendida'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'D'
						.Default = {  /  /    }
						.IdUnico = '1DE0C55DB1F104143DF1999416405784142601'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Fechadehabilitaciondetrazaextendida = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Fechadehabilitaciondetrazaextendida = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Fechadehabilitaciondetrazaextendida = txValor 
				return .Fechadehabilitaciondetrazaextendida

			endif
		endwith
	endfunc

	function Versionbasededatossucursal_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 3
					.idNodo = 1
					.Parametro = 'VersionBaseDeDatosSucursal'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = ''
					.IdUnico = '12FE45B8C14189141F8189C212184410233711'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Versionbasededatossucursal = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Versionbasededatossucursal = .Sucursal.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Versionbasededatossucursal

			endif
		endwith
	endfunc

	function Versionbasededatossucursal_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 3
						.idNodo = 1
						.Parametro = 'VersionBaseDeDatosSucursal'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = ''
						.IdUnico = '12FE45B8C14189141F8189C212184410233711'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Versionbasededatossucursal = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Versionbasededatossucursal = .Sucursal.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Versionbasededatossucursal = txValor 
				return .Versionbasededatossucursal

			endif
		endwith
	endfunc

	function Versionbasededatosorganizacion_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 1
					.Parametro = 'VersionBaseDeDatosOrganizacion'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = ''
					.IdUnico = '1390C216618EB0141101969517680262691001'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Versionbasededatosorganizacion = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Versionbasededatosorganizacion = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Versionbasededatosorganizacion

			endif
		endwith
	endfunc

	function Versionbasededatosorganizacion_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 1
						.Parametro = 'VersionBaseDeDatosOrganizacion'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = ''
						.IdUnico = '1390C216618EB0141101969517680262691001'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Versionbasededatosorganizacion = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Versionbasededatosorganizacion = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Versionbasededatosorganizacion = txValor 
				return .Versionbasededatosorganizacion

			endif
		endwith
	endfunc

	function Defaulttiempodeesperasmtp_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 1
					.Parametro = 'DefaultTiempoDeEsperaSmtp'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 100
					.IdUnico = '1ACA42F32126F314623196EE13828493159121'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Defaulttiempodeesperasmtp = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Defaulttiempodeesperasmtp = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Defaulttiempodeesperasmtp

			endif
		endwith
	endfunc

	function Defaulttiempodeesperasmtp_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 1
						.Parametro = 'DefaultTiempoDeEsperaSmtp'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 100
						.IdUnico = '1ACA42F32126F314623196EE13828493159121'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Defaulttiempodeesperasmtp = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Defaulttiempodeesperasmtp = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Defaulttiempodeesperasmtp = txValor 
				return .Defaulttiempodeesperasmtp

			endif
		endwith
	endfunc

	function Reintentosdeobtenciondenumerocontalonariousado_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 3
					.idNodo = 1
					.Parametro = 'ReintentosDeObtencionDeNumeroConTalonarioUsado'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 3
					.IdUnico = '1ACA42F32126F31461C1985611780971338341'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Reintentosdeobtenciondenumerocontalonariousado = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Reintentosdeobtenciondenumerocontalonariousado = .Sucursal.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Reintentosdeobtenciondenumerocontalonariousado

			endif
		endwith
	endfunc

	function Reintentosdeobtenciondenumerocontalonariousado_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 3
						.idNodo = 1
						.Parametro = 'ReintentosDeObtencionDeNumeroConTalonarioUsado'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 3
						.IdUnico = '1ACA42F32126F31461C1985611780971338341'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Reintentosdeobtenciondenumerocontalonariousado = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Reintentosdeobtenciondenumerocontalonariousado = .Sucursal.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Reintentosdeobtenciondenumerocontalonariousado = txValor 
				return .Reintentosdeobtenciondenumerocontalonariousado

			endif
		endwith
	endfunc

	function Rutaplantillasdedisenoexportacion_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Ruta plantillas de diseño exportacion'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = 'plantillas\'
					.IdUnico = '1554E9A281C61F148341B05E19759947463681'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Rutaplantillasdedisenoexportacion = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Rutaplantillasdedisenoexportacion = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Rutaplantillasdedisenoexportacion

			endif
		endwith
	endfunc

	function Rutaplantillasdedisenoexportacion_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Ruta plantillas de diseño exportacion'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = 'plantillas\'
						.IdUnico = '1554E9A281C61F148341B05E19759947463681'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Rutaplantillasdedisenoexportacion = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Rutaplantillasdedisenoexportacion = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Rutaplantillasdedisenoexportacion = txValor 
				return .Rutaplantillasdedisenoexportacion

			endif
		endwith
	endfunc

	function Cantidaddeelementosensegmentoaimportar_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 1
					.Parametro = 'Cantidad de elementos en segmento a importar'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 50000
					.IdUnico = '11E9253BA1B5D5144AD1AA4714453844617261'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Cantidaddeelementosensegmentoaimportar = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Cantidaddeelementosensegmentoaimportar = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Cantidaddeelementosensegmentoaimportar

			endif
		endwith
	endfunc

	function Cantidaddeelementosensegmentoaimportar_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 1
						.Parametro = 'Cantidad de elementos en segmento a importar'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 50000
						.IdUnico = '11E9253BA1B5D5144AD1AA4714453844617261'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Cantidaddeelementosensegmentoaimportar = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Cantidaddeelementosensegmentoaimportar = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Cantidaddeelementosensegmentoaimportar = txValor 
				return .Cantidaddeelementosensegmentoaimportar

			endif
		endwith
	endfunc

	function Habilitararticulototalizador_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 1
					.Parametro = 'Habilitar articulo totalizador'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'L'
					.Default = .F.
					.IdUnico = '13DD799A4153D1145591B75B11000526556271'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Habilitararticulototalizador = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Habilitararticulototalizador = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Habilitararticulototalizador

			endif
		endwith
	endfunc

	function Habilitararticulototalizador_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 1
						.Parametro = 'Habilitar articulo totalizador'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'L'
						.Default = .F.
						.IdUnico = '13DD799A4153D1145591B75B11000526556271'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Habilitararticulototalizador = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Habilitararticulototalizador = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Habilitararticulototalizador = txValor 
				return .Habilitararticulototalizador

			endif
		endwith
	endfunc

	function Usardragonfishcloud_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 1
					.Parametro = 'Usar Dragonfish Cloud'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'L'
					.Default = .F.
					.IdUnico = '10DCDE7FD1852214A39190C419577303472591'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Usardragonfishcloud = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Usardragonfishcloud = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Usardragonfishcloud

			endif
		endwith
	endfunc

	function Usardragonfishcloud_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 1
						.Parametro = 'Usar Dragonfish Cloud'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'L'
						.Default = .F.
						.IdUnico = '10DCDE7FD1852214A39190C419577303472591'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Usardragonfishcloud = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Usardragonfishcloud = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Usardragonfishcloud = txValor 
				return .Usardragonfishcloud

			endif
		endwith
	endfunc

	function Cantidaddembpermitidosenelpesodelreporteparalistadosconimagenes_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 1
					.Parametro = 'Cantidad de MB permitidos en el peso del reporte para listados con imagenes'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 2600
					.IdUnico = '1BD1B35BC13C541462B1A25017205313598181'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Cantidaddembpermitidosenelpesodelreporteparalistadosconimagenes = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Cantidaddembpermitidosenelpesodelreporteparalistadosconimagenes = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Cantidaddembpermitidosenelpesodelreporteparalistadosconimagenes

			endif
		endwith
	endfunc

	function Cantidaddembpermitidosenelpesodelreporteparalistadosconimagenes_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 1
						.Parametro = 'Cantidad de MB permitidos en el peso del reporte para listados con imagenes'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 2600
						.IdUnico = '1BD1B35BC13C541462B1A25017205313598181'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Cantidaddembpermitidosenelpesodelreporteparalistadosconimagenes = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Cantidaddembpermitidosenelpesodelreporteparalistadosconimagenes = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Cantidaddembpermitidosenelpesodelreporteparalistadosconimagenes = txValor 
				return .Cantidaddembpermitidosenelpesodelreporteparalistadosconimagenes

			endif
		endwith
	endfunc

	function Mayorprecisiondecimalencantidad_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 1
					.Parametro = 'MayorPrecisionDecimalEnCantidad'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'L'
					.Default = .F.
					.IdUnico = '150131BA41543E14C80184F118645537428021'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Mayorprecisiondecimalencantidad = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Mayorprecisiondecimalencantidad = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Mayorprecisiondecimalencantidad

			endif
		endwith
	endfunc

	function Mayorprecisiondecimalencantidad_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 1
						.Parametro = 'MayorPrecisionDecimalEnCantidad'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'L'
						.Default = .F.
						.IdUnico = '150131BA41543E14C80184F118645537428021'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Mayorprecisiondecimalencantidad = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Mayorprecisiondecimalencantidad = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Mayorprecisiondecimalencantidad = txValor 
				return .Mayorprecisiondecimalencantidad

			endif
		endwith
	endfunc

	function Separadordecolumnascsv_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 3
					.idNodo = 1
					.Parametro = 'Separador de columnas CSV'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = ';'
					.IdUnico = '120A5CFA71576B1439D1B65E11095430003501'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Separadordecolumnascsv = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Separadordecolumnascsv = .Sucursal.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Separadordecolumnascsv

			endif
		endwith
	endfunc

	function Separadordecolumnascsv_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 3
						.idNodo = 1
						.Parametro = 'Separador de columnas CSV'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = ';'
						.IdUnico = '120A5CFA71576B1439D1B65E11095430003501'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Separadordecolumnascsv = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Separadordecolumnascsv = .Sucursal.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Separadordecolumnascsv = txValor 
				return .Separadordecolumnascsv

			endif
		endwith
	endfunc

	function Delimitadordecaracterescsv_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 3
					.idNodo = 1
					.Parametro = 'Delimitador de caracteres CSV'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = '"'
					.IdUnico = '114AC522717BA114E521B9BC13065369125811'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Delimitadordecaracterescsv = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Delimitadordecaracterescsv = .Sucursal.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Delimitadordecaracterescsv

			endif
		endwith
	endfunc

	function Delimitadordecaracterescsv_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 3
						.idNodo = 1
						.Parametro = 'Delimitador de caracteres CSV'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = '"'
						.IdUnico = '114AC522717BA114E521B9BC13065369125811'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Delimitadordecaracterescsv = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Delimitadordecaracterescsv = .Sucursal.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Delimitadordecaracterescsv = txValor 
				return .Delimitadordecaracterescsv

			endif
		endwith
	endfunc

	function Delimitadorinicialdeatributosparamacrosustitucion_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 3
					.idNodo = 1
					.Parametro = 'Delimitador inicial de atributos para macro sustitución'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = '{'
					.IdUnico = '1831652411D7A9149921814C16611268179531'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Delimitadorinicialdeatributosparamacrosustitucion = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Delimitadorinicialdeatributosparamacrosustitucion = .Sucursal.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Delimitadorinicialdeatributosparamacrosustitucion

			endif
		endwith
	endfunc

	function Delimitadorinicialdeatributosparamacrosustitucion_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 3
						.idNodo = 1
						.Parametro = 'Delimitador inicial de atributos para macro sustitución'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = '{'
						.IdUnico = '1831652411D7A9149921814C16611268179531'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Delimitadorinicialdeatributosparamacrosustitucion = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Delimitadorinicialdeatributosparamacrosustitucion = .Sucursal.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Delimitadorinicialdeatributosparamacrosustitucion = txValor 
				return .Delimitadorinicialdeatributosparamacrosustitucion

			endif
		endwith
	endfunc

	function Delimitadorfinaldeatributosparamacrosustitucion_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 3
					.idNodo = 1
					.Parametro = 'Delimitador final de atributos para macro sustitución'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = '}'
					.IdUnico = '1062BCAC9100471491319FFE15084099603001'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Delimitadorfinaldeatributosparamacrosustitucion = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Delimitadorfinaldeatributosparamacrosustitucion = .Sucursal.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Delimitadorfinaldeatributosparamacrosustitucion

			endif
		endwith
	endfunc

	function Delimitadorfinaldeatributosparamacrosustitucion_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 3
						.idNodo = 1
						.Parametro = 'Delimitador final de atributos para macro sustitución'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = '}'
						.IdUnico = '1062BCAC9100471491319FFE15084099603001'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Delimitadorfinaldeatributosparamacrosustitucion = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Delimitadorfinaldeatributosparamacrosustitucion = .Sucursal.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Delimitadorfinaldeatributosparamacrosustitucion = txValor 
				return .Delimitadorfinaldeatributosparamacrosustitucion

			endif
		endwith
	endfunc


			*-----------------------------------------------------------------------------------------
			function Destroy()
				local lnCantidad as Integer, laPropiedades as array, lnTablaActual as Integer,;
				lnPropiedadActual as Integer, lcPropiedad as String, lcEliminaReferencia as String    
				dimension laPropiedades(1)

				this.lDestroy = .t.

				lnCantidad = Amembers(laPropiedades,this,0,"U" )
				for lnPropiedadActual = 1 to lnCantidad
					lcPropiedad = "this."+ alltrim(laPropiedades(lnPropiedadActual))
					if vartype ( evaluate(lcPropiedad) ) = "O"
						if pemstatus(&lcPropiedad,"release",5)
							lcEliminaReferencia = lcPropiedad + ".release"
							&lcEliminaReferencia
						endif
					endif
				endfor

			endfunc

			*-----------------------------------------------------------------------------------------
			function Release() as Void
				release this 
			endfunc 
enddefine


define class NUCLEO_Seguridad as custom

	nNodo = 2
	lAccess = .f.
	lDestroy = .f.

	Numerodeintentosdelogueo = 5
	Ultimousuariologueado = ''
	Estadodelsistema = '_20g0sdwj1'
	Checksum = ''
	Tiempodeexpiraciondeacceso = 30
	Factormultiplicaciontiempobloqueoautomatico = 2
	Tiempodebloqueo = 1

	function init() as void
		with this
		endwith
	endfunc

	function Numerodeintentosdelogueo_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 2
					.Parametro = 'NumeroDeIntentosDeLogueo'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 5
					.IdUnico = '18E277F981DD731428A183D912008381171801'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Numerodeintentosdelogueo = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Numerodeintentosdelogueo = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Numerodeintentosdelogueo

			endif
		endwith
	endfunc

	function Numerodeintentosdelogueo_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 2
						.Parametro = 'NumeroDeIntentosDeLogueo'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 5
						.IdUnico = '18E277F981DD731428A183D912008381171801'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Numerodeintentosdelogueo = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Numerodeintentosdelogueo = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Numerodeintentosdelogueo = txValor 
				return .Numerodeintentosdelogueo

			endif
		endwith
	endfunc

	function Ultimousuariologueado_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 2
					.Parametro = 'UltimoUsuarioLogueado'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = ''
					.IdUnico = '1F800390916DB91431A1B40413907490712681'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Ultimousuariologueado = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Ultimousuariologueado = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Ultimousuariologueado

			endif
		endwith
	endfunc

	function Ultimousuariologueado_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 2
						.Parametro = 'UltimoUsuarioLogueado'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = ''
						.IdUnico = '1F800390916DB91431A1B40413907490712681'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Ultimousuariologueado = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Ultimousuariologueado = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Ultimousuariologueado = txValor 
				return .Ultimousuariologueado

			endif
		endwith
	endfunc

	function Estadodelsistema_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 2
					.Parametro = 'EstadoDelSistema'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = '_20g0sdwj1'
					.IdUnico = '1C20B7F131495214C68190E312123386117171'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Estadodelsistema = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Estadodelsistema = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Estadodelsistema

			endif
		endwith
	endfunc

	function Estadodelsistema_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 2
						.Parametro = 'EstadoDelSistema'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = '_20g0sdwj1'
						.IdUnico = '1C20B7F131495214C68190E312123386117171'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Estadodelsistema = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Estadodelsistema = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Estadodelsistema = txValor 
				return .Estadodelsistema

			endif
		endwith
	endfunc

	function Checksum_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 2
					.Parametro = 'checksum'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = ''
					.IdUnico = '163FA406B13DD7142351A25417439901175961'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Checksum = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Checksum = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Checksum

			endif
		endwith
	endfunc

	function Checksum_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 2
						.Parametro = 'checksum'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = ''
						.IdUnico = '163FA406B13DD7142351A25417439901175961'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Checksum = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Checksum = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Checksum = txValor 
				return .Checksum

			endif
		endwith
	endfunc

	function Tiempodeexpiraciondeacceso_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 2
					.Parametro = 'Tiempo de expiracion de acceso'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 30
					.IdUnico = '1CBC85C6A11C9D1422B1907612257593261801'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Tiempodeexpiraciondeacceso = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Tiempodeexpiraciondeacceso = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Tiempodeexpiraciondeacceso

			endif
		endwith
	endfunc

	function Tiempodeexpiraciondeacceso_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 2
						.Parametro = 'Tiempo de expiracion de acceso'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 30
						.IdUnico = '1CBC85C6A11C9D1422B1907612257593261801'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Tiempodeexpiraciondeacceso = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Tiempodeexpiraciondeacceso = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Tiempodeexpiraciondeacceso = txValor 
				return .Tiempodeexpiraciondeacceso

			endif
		endwith
	endfunc

	function Factormultiplicaciontiempobloqueoautomatico_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 2
					.Parametro = 'Factor Multiplicacion Tiempo Bloqueo Automatico'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 2
					.IdUnico = '137FC0A211E3D4140EA1981614685059581401'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Factormultiplicaciontiempobloqueoautomatico = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Factormultiplicaciontiempobloqueoautomatico = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Factormultiplicaciontiempobloqueoautomatico

			endif
		endwith
	endfunc

	function Factormultiplicaciontiempobloqueoautomatico_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 2
						.Parametro = 'Factor Multiplicacion Tiempo Bloqueo Automatico'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 2
						.IdUnico = '137FC0A211E3D4140EA1981614685059581401'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Factormultiplicaciontiempobloqueoautomatico = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Factormultiplicaciontiempobloqueoautomatico = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Factormultiplicaciontiempobloqueoautomatico = txValor 
				return .Factormultiplicaciontiempobloqueoautomatico

			endif
		endwith
	endfunc

	function Tiempodebloqueo_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 2
					.Parametro = 'Tiempo de Bloqueo'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 1
					.IdUnico = '1A81A5E98113EB14DC31A9CF15576939444201'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Tiempodebloqueo = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Tiempodebloqueo = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Tiempodebloqueo

			endif
		endwith
	endfunc

	function Tiempodebloqueo_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 2
						.Parametro = 'Tiempo de Bloqueo'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 1
						.IdUnico = '1A81A5E98113EB14DC31A9CF15576939444201'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Tiempodebloqueo = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Tiempodebloqueo = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Tiempodebloqueo = txValor 
				return .Tiempodebloqueo

			endif
		endwith
	endfunc


			*-----------------------------------------------------------------------------------------
			function Destroy()
				local lnCantidad as Integer, laPropiedades as array, lnTablaActual as Integer,;
				lnPropiedadActual as Integer, lcPropiedad as String, lcEliminaReferencia as String    
				dimension laPropiedades(1)

				this.lDestroy = .t.

				lnCantidad = Amembers(laPropiedades,this,0,"U" )
				for lnPropiedadActual = 1 to lnCantidad
					lcPropiedad = "this."+ alltrim(laPropiedades(lnPropiedadActual))
					if vartype ( evaluate(lcPropiedad) ) = "O"
						if pemstatus(&lcPropiedad,"release",5)
							lcEliminaReferencia = lcPropiedad + ".release"
							&lcEliminaReferencia
						endif
					endif
				endfor

			endfunc

			*-----------------------------------------------------------------------------------------
			function Release() as Void
				release this 
			endfunc 
enddefine


define class NUCLEO_Transferencias as custom

	nNodo = 3
	lAccess = .f.
	lDestroy = .f.

	Password = ''
	Forzarelusodelaaoentiempodedesarrollo = .F.
	Passwordlince = 'pirulaxia'

	function init() as void
		with this
		endwith
	endfunc

	function Password_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 3
					.Parametro = 'Password'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = ''
					.IdUnico = '17E92908111B801439A1B4B517452633378911'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Password = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Password = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Password

			endif
		endwith
	endfunc

	function Password_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 3
						.Parametro = 'Password'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = ''
						.IdUnico = '17E92908111B801439A1B4B517452633378911'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Password = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Password = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Password = txValor 
				return .Password

			endif
		endwith
	endfunc

	function Forzarelusodelaaoentiempodedesarrollo_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 3
					.Parametro = 'Forzar el uso del AAO en tiempo de desarrollo'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'L'
					.Default = .F.
					.IdUnico = '13A9B03E21A2F01431B18F5119344369302241'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Forzarelusodelaaoentiempodedesarrollo = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Forzarelusodelaaoentiempodedesarrollo = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Forzarelusodelaaoentiempodedesarrollo

			endif
		endwith
	endfunc

	function Forzarelusodelaaoentiempodedesarrollo_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 3
						.Parametro = 'Forzar el uso del AAO en tiempo de desarrollo'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'L'
						.Default = .F.
						.IdUnico = '13A9B03E21A2F01431B18F5119344369302241'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Forzarelusodelaaoentiempodedesarrollo = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Forzarelusodelaaoentiempodedesarrollo = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Forzarelusodelaaoentiempodedesarrollo = txValor 
				return .Forzarelusodelaaoentiempodedesarrollo

			endif
		endwith
	endfunc

	function Passwordlince_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 3
					.Parametro = 'Password Lince'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = 'pirulaxia'
					.IdUnico = '17A876F92164501481C1985611780971338341'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Passwordlince = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Passwordlince = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Passwordlince

			endif
		endwith
	endfunc

	function Passwordlince_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 3
						.Parametro = 'Password Lince'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = 'pirulaxia'
						.IdUnico = '17A876F92164501481C1985611780971338341'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Passwordlince = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Passwordlince = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Passwordlince = txValor 
				return .Passwordlince

			endif
		endwith
	endfunc


			*-----------------------------------------------------------------------------------------
			function Destroy()
				local lnCantidad as Integer, laPropiedades as array, lnTablaActual as Integer,;
				lnPropiedadActual as Integer, lcPropiedad as String, lcEliminaReferencia as String    
				dimension laPropiedades(1)

				this.lDestroy = .t.

				lnCantidad = Amembers(laPropiedades,this,0,"U" )
				for lnPropiedadActual = 1 to lnCantidad
					lcPropiedad = "this."+ alltrim(laPropiedades(lnPropiedadActual))
					if vartype ( evaluate(lcPropiedad) ) = "O"
						if pemstatus(&lcPropiedad,"release",5)
							lcEliminaReferencia = lcPropiedad + ".release"
							&lcEliminaReferencia
						endif
					endif
				endfor

			endfunc

			*-----------------------------------------------------------------------------------------
			function Release() as Void
				release this 
			endfunc 
enddefine


define class NUCLEO_Importaciones as custom

	nNodo = 4
	lAccess = .f.
	lDestroy = .f.

	Extensionparaarchivosconerrores = 'ERR'

	function init() as void
		with this
		endwith
	endfunc

	function Extensionparaarchivosconerrores_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 4
					.Parametro = 'ExtensionParaArchivosConErrores'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = 'ERR'
					.IdUnico = '19AFCB709151FC1443B1A00010553357262101'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Extensionparaarchivosconerrores = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Extensionparaarchivosconerrores = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Extensionparaarchivosconerrores

			endif
		endwith
	endfunc

	function Extensionparaarchivosconerrores_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 4
						.Parametro = 'ExtensionParaArchivosConErrores'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = 'ERR'
						.IdUnico = '19AFCB709151FC1443B1A00010553357262101'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Extensionparaarchivosconerrores = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Extensionparaarchivosconerrores = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Extensionparaarchivosconerrores = txValor 
				return .Extensionparaarchivosconerrores

			endif
		endwith
	endfunc


			*-----------------------------------------------------------------------------------------
			function Destroy()
				local lnCantidad as Integer, laPropiedades as array, lnTablaActual as Integer,;
				lnPropiedadActual as Integer, lcPropiedad as String, lcEliminaReferencia as String    
				dimension laPropiedades(1)

				this.lDestroy = .t.

				lnCantidad = Amembers(laPropiedades,this,0,"U" )
				for lnPropiedadActual = 1 to lnCantidad
					lcPropiedad = "this."+ alltrim(laPropiedades(lnPropiedadActual))
					if vartype ( evaluate(lcPropiedad) ) = "O"
						if pemstatus(&lcPropiedad,"release",5)
							lcEliminaReferencia = lcPropiedad + ".release"
							&lcEliminaReferencia
						endif
					endif
				endfor

			endfunc

			*-----------------------------------------------------------------------------------------
			function Release() as Void
				release this 
			endfunc 
enddefine


define class NUCLEO_Sc as custom

	nNodo = 5
	lAccess = .f.
	lDestroy = .f.

	Cantidaddeintententosfallidosalpedircodigo = 0
	Pedirscautomaticamente = .T.
	Cantidadmaximadeintentosfallidossc = 4

	function init() as void
		with this
		endwith
	endfunc

	function Cantidaddeintententosfallidosalpedircodigo_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 5
					.Parametro = 'CantidadDeIntententosFallidosAlPedirCodigo'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 0
					.IdUnico = '10AFD0E711F72F14A7319F7513250189124191'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Cantidaddeintententosfallidosalpedircodigo = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Cantidaddeintententosfallidosalpedircodigo = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Cantidaddeintententosfallidosalpedircodigo

			endif
		endwith
	endfunc

	function Cantidaddeintententosfallidosalpedircodigo_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 5
						.Parametro = 'CantidadDeIntententosFallidosAlPedirCodigo'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 0
						.IdUnico = '10AFD0E711F72F14A7319F7513250189124191'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Cantidaddeintententosfallidosalpedircodigo = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Cantidaddeintententosfallidosalpedircodigo = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Cantidaddeintententosfallidosalpedircodigo = txValor 
				return .Cantidaddeintententosfallidosalpedircodigo

			endif
		endwith
	endfunc

	function Pedirscautomaticamente_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 5
					.Parametro = 'PedirSCAutomaticamente'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'L'
					.Default = .T.
					.IdUnico = '1FB72AB3917ED814FA419FFE11549311905421'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Pedirscautomaticamente = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Pedirscautomaticamente = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Pedirscautomaticamente

			endif
		endwith
	endfunc

	function Pedirscautomaticamente_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 5
						.Parametro = 'PedirSCAutomaticamente'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'L'
						.Default = .T.
						.IdUnico = '1FB72AB3917ED814FA419FFE11549311905421'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Pedirscautomaticamente = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Pedirscautomaticamente = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Pedirscautomaticamente = txValor 
				return .Pedirscautomaticamente

			endif
		endwith
	endfunc

	function Cantidadmaximadeintentosfallidossc_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 5
					.Parametro = 'CantidadMaximaDeIntentosFallidosSC'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 4
					.IdUnico = '1245BFAF3102A614F0F1B27815177111591281'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Cantidadmaximadeintentosfallidossc = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Cantidadmaximadeintentosfallidossc = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Cantidadmaximadeintentosfallidossc

			endif
		endwith
	endfunc

	function Cantidadmaximadeintentosfallidossc_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 5
						.Parametro = 'CantidadMaximaDeIntentosFallidosSC'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 4
						.IdUnico = '1245BFAF3102A614F0F1B27815177111591281'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Cantidadmaximadeintentosfallidossc = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Cantidadmaximadeintentosfallidossc = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Cantidadmaximadeintentosfallidossc = txValor 
				return .Cantidadmaximadeintentosfallidossc

			endif
		endwith
	endfunc


			*-----------------------------------------------------------------------------------------
			function Destroy()
				local lnCantidad as Integer, laPropiedades as array, lnTablaActual as Integer,;
				lnPropiedadActual as Integer, lcPropiedad as String, lcEliminaReferencia as String    
				dimension laPropiedades(1)

				this.lDestroy = .t.

				lnCantidad = Amembers(laPropiedades,this,0,"U" )
				for lnPropiedadActual = 1 to lnCantidad
					lcPropiedad = "this."+ alltrim(laPropiedades(lnPropiedadActual))
					if vartype ( evaluate(lcPropiedad) ) = "O"
						if pemstatus(&lcPropiedad,"release",5)
							lcEliminaReferencia = lcPropiedad + ".release"
							&lcEliminaReferencia
						endif
					endif
				endfor

			endfunc

			*-----------------------------------------------------------------------------------------
			function Release() as Void
				release this 
			endfunc 
enddefine


define class NUCLEO_Actualizaciones as custom

	nNodo = 6
	lAccess = .f.
	lDestroy = .f.

	Urlparaactualizaciones = 'https://update.zoologic.com.ar/'

	function init() as void
		with this
		endwith
	endfunc

	function Urlparaactualizaciones_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 6
					.Parametro = 'URL'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = 'https://update.zoologic.com.ar/'
					.IdUnico = '154D691A11050814C6F1869A12378151431621'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Urlparaactualizaciones = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Urlparaactualizaciones = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Urlparaactualizaciones

			endif
		endwith
	endfunc

	function Urlparaactualizaciones_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 6
						.Parametro = 'URL'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = 'https://update.zoologic.com.ar/'
						.IdUnico = '154D691A11050814C6F1869A12378151431621'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Urlparaactualizaciones = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Urlparaactualizaciones = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Urlparaactualizaciones = txValor 
				return .Urlparaactualizaciones

			endif
		endwith
	endfunc


			*-----------------------------------------------------------------------------------------
			function Destroy()
				local lnCantidad as Integer, laPropiedades as array, lnTablaActual as Integer,;
				lnPropiedadActual as Integer, lcPropiedad as String, lcEliminaReferencia as String    
				dimension laPropiedades(1)

				this.lDestroy = .t.

				lnCantidad = Amembers(laPropiedades,this,0,"U" )
				for lnPropiedadActual = 1 to lnCantidad
					lcPropiedad = "this."+ alltrim(laPropiedades(lnPropiedadActual))
					if vartype ( evaluate(lcPropiedad) ) = "O"
						if pemstatus(&lcPropiedad,"release",5)
							lcEliminaReferencia = lcPropiedad + ".release"
							&lcEliminaReferencia
						endif
					endif
				endfor

			endfunc

			*-----------------------------------------------------------------------------------------
			function Release() as Void
				release this 
			endfunc 
enddefine


define class NUCLEO_Serviciorest as custom

	nNodo = 7
	lAccess = .f.
	lDestroy = .f.

	Desactivaroptimizaciondeframeworknet = .F.
	Maximacantidaddediasenlogueosrestapi = 30
	Tiempodevidaentidad = 1000

	function init() as void
		with this
		endwith
	endfunc

	function Desactivaroptimizaciondeframeworknet_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 7
					.Parametro = 'Desactivar Optimización de Framework .NET'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'L'
					.Default = .F.
					.IdUnico = '174E0651415E8B14DA41AB8714732049271401'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Desactivaroptimizaciondeframeworknet = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Desactivaroptimizaciondeframeworknet = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Desactivaroptimizaciondeframeworknet

			endif
		endwith
	endfunc

	function Desactivaroptimizaciondeframeworknet_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 7
						.Parametro = 'Desactivar Optimización de Framework .NET'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'L'
						.Default = .F.
						.IdUnico = '174E0651415E8B14DA41AB8714732049271401'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Desactivaroptimizaciondeframeworknet = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Desactivaroptimizaciondeframeworknet = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Desactivaroptimizaciondeframeworknet = txValor 
				return .Desactivaroptimizaciondeframeworknet

			endif
		endwith
	endfunc

	function Maximacantidaddediasenlogueosrestapi_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 7
					.Parametro = 'MaximaCantidadDeDiasEnLogueosRestApi'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 30
					.IdUnico = '1F6B16E8719A86143DD1B62714950845345261'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Maximacantidaddediasenlogueosrestapi = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Maximacantidaddediasenlogueosrestapi = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Maximacantidaddediasenlogueosrestapi

			endif
		endwith
	endfunc

	function Maximacantidaddediasenlogueosrestapi_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 7
						.Parametro = 'MaximaCantidadDeDiasEnLogueosRestApi'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 30
						.IdUnico = '1F6B16E8719A86143DD1B62714950845345261'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Maximacantidaddediasenlogueosrestapi = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Maximacantidaddediasenlogueosrestapi = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Maximacantidaddediasenlogueosrestapi = txValor 
				return .Maximacantidaddediasenlogueosrestapi

			endif
		endwith
	endfunc

	function Tiempodevidaentidad_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 7
					.Parametro = 'Tiempo de Vida Entidad'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'N'
					.Default = 1000
					.IdUnico = '13AD9B1C01F37C14A051ADE819924245190951'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Tiempodevidaentidad = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Tiempodevidaentidad = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Tiempodevidaentidad

			endif
		endwith
	endfunc

	function Tiempodevidaentidad_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 7
						.Parametro = 'Tiempo de Vida Entidad'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'N'
						.Default = 1000
						.IdUnico = '13AD9B1C01F37C14A051ADE819924245190951'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Tiempodevidaentidad = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Tiempodevidaentidad = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Tiempodevidaentidad = txValor 
				return .Tiempodevidaentidad

			endif
		endwith
	endfunc


			*-----------------------------------------------------------------------------------------
			function Destroy()
				local lnCantidad as Integer, laPropiedades as array, lnTablaActual as Integer,;
				lnPropiedadActual as Integer, lcPropiedad as String, lcEliminaReferencia as String    
				dimension laPropiedades(1)

				this.lDestroy = .t.

				lnCantidad = Amembers(laPropiedades,this,0,"U" )
				for lnPropiedadActual = 1 to lnCantidad
					lcPropiedad = "this."+ alltrim(laPropiedades(lnPropiedadActual))
					if vartype ( evaluate(lcPropiedad) ) = "O"
						if pemstatus(&lcPropiedad,"release",5)
							lcEliminaReferencia = lcPropiedad + ".release"
							&lcEliminaReferencia
						endif
					endif
				endfor

			endfunc

			*-----------------------------------------------------------------------------------------
			function Release() as Void
				release this 
			endfunc 
enddefine


define class NUCLEO_SonidosYNotificaciones as custom

	nNodo = 8
	lAccess = .f.
	lDestroy = .f.

	Fechaultimologueonotificacioneswindows = {^2022-1-1}

	function init() as void
		with this
		endwith
	endfunc

	function Fechaultimologueonotificacioneswindows_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 2
					.idNodo = 8
					.Parametro = 'Fecha último logueo notificaciones windows'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'D'
					.Default = {^2022-1-1}
					.IdUnico = '1F0CF7D841B7781451D1949E19924945436331'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Fechaultimologueonotificacioneswindows = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Fechaultimologueonotificacioneswindows = .Puesto.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Fechaultimologueonotificacioneswindows

			endif
		endwith
	endfunc

	function Fechaultimologueonotificacioneswindows_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 2
						.idNodo = 8
						.Parametro = 'Fecha último logueo notificaciones windows'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'D'
						.Default = {^2022-1-1}
						.IdUnico = '1F0CF7D841B7781451D1949E19924945436331'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Fechaultimologueonotificacioneswindows = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Fechaultimologueonotificacioneswindows = .Puesto.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Fechaultimologueonotificacioneswindows = txValor 
				return .Fechaultimologueonotificacioneswindows

			endif
		endwith
	endfunc


			*-----------------------------------------------------------------------------------------
			function Destroy()
				local lnCantidad as Integer, laPropiedades as array, lnTablaActual as Integer,;
				lnPropiedadActual as Integer, lcPropiedad as String, lcEliminaReferencia as String    
				dimension laPropiedades(1)

				this.lDestroy = .t.

				lnCantidad = Amembers(laPropiedades,this,0,"U" )
				for lnPropiedadActual = 1 to lnCantidad
					lcPropiedad = "this."+ alltrim(laPropiedades(lnPropiedadActual))
					if vartype ( evaluate(lcPropiedad) ) = "O"
						if pemstatus(&lcPropiedad,"release",5)
							lcEliminaReferencia = lcPropiedad + ".release"
							&lcEliminaReferencia
						endif
					endif
				endfor

			endfunc

			*-----------------------------------------------------------------------------------------
			function Release() as Void
				release this 
			endfunc 
enddefine


define class NUCLEO_EnvioDeMails as custom

	nNodo = 9
	lAccess = .f.
	lDestroy = .f.

	Iddeclienteparaenviodemailsmycrosoftapi = 'B703C014C91F92204E11B4D8296B6CD9023D5F02B109F56138BC6664B94B9D625B443AA357479F4D7B0D63BEC7F11666'

	function init() as void
		with this
		endwith
	endfunc

	function Iddeclienteparaenviodemailsmycrosoftapi_Access() as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				.lAccess = .t.
				loConsultaParametro = newobject('ConsultaParametro')
				with loConsultaParametro
					.Nivel = 1
					.idNodo = 9
					.Parametro = 'Id de cliente para envio de mails Mycrosoft Api'
					.Proyecto = 'NUCLEO'
					.TipoDato = 'C'
					.Default = 'B703C014C91F92204E11B4D8296B6CD9023D5F02B109F56138BC6664B94B9D625B443AA357479F4D7B0D63BEC7F11666'
					.IdUnico = '19063F4C81CD01142411945A15387528873181'
				endwith
				with goRegistry.oDatos
					if .ExisteConfigurador( loConsultaParametro )
						this.Iddeclienteparaenviodemailsmycrosoftapi = .ObtenerConfiguracion( loConsultaParametro )
					else
						this.Iddeclienteparaenviodemailsmycrosoftapi = .Organizacion.Obtener( loConsultaParametro )
					endif
				endwith
				.lAccess = .f.
				return .Iddeclienteparaenviodemailsmycrosoftapi

			endif
		endwith
	endfunc

	function Iddeclienteparaenviodemailsmycrosoftapi_Assign( txValor ) as void
		local loConsultaParametro as ConsultaParametro of ConsultaParametro.prg
		with this
			if .lDestroy
			else
				if .lAccess
				else
					loConsultaParametro = newobject('ConsultaParametro')
					with loConsultaParametro
						.Nivel = 1
						.idNodo = 9
						.Parametro = 'Id de cliente para envio de mails Mycrosoft Api'
						.Proyecto = 'NUCLEO'
						.TipoDato = 'C'
						.Default = 'B703C014C91F92204E11B4D8296B6CD9023D5F02B109F56138BC6664B94B9D625B443AA357479F4D7B0D63BEC7F11666'
						.IdUnico = '19063F4C81CD01142411945A15387528873181'
					endwith
					with goRegistry.oDatos
						if .ExisteConfigurador( loConsultaParametro )
							this.Iddeclienteparaenviodemailsmycrosoftapi = .SetearConfiguracion( txValor, loConsultaParametro )
						else
							this.Iddeclienteparaenviodemailsmycrosoftapi = .Organizacion.Setear( txValor, loConsultaParametro )
						endif
					endwith
				endif
				.Iddeclienteparaenviodemailsmycrosoftapi = txValor 
				return .Iddeclienteparaenviodemailsmycrosoftapi

			endif
		endwith
	endfunc


			*-----------------------------------------------------------------------------------------
			function Destroy()
				local lnCantidad as Integer, laPropiedades as array, lnTablaActual as Integer,;
				lnPropiedadActual as Integer, lcPropiedad as String, lcEliminaReferencia as String    
				dimension laPropiedades(1)

				this.lDestroy = .t.

				lnCantidad = Amembers(laPropiedades,this,0,"U" )
				for lnPropiedadActual = 1 to lnCantidad
					lcPropiedad = "this."+ alltrim(laPropiedades(lnPropiedadActual))
					if vartype ( evaluate(lcPropiedad) ) = "O"
						if pemstatus(&lcPropiedad,"release",5)
							lcEliminaReferencia = lcPropiedad + ".release"
							&lcEliminaReferencia
						endif
					endif
				endfor

			endfunc

			*-----------------------------------------------------------------------------------------
			function Release() as Void
				release this 
			endfunc 
enddefine


*-----------------------------------------------------------------------------------------
define class ConsultaParametro as custom
	Nivel = 0
	idNodo = 0
	Parametro = ''
	Proyecto = ''
	TipoDato = ''
	Default = null
	idCabecera = 0
	IdUnico = ''
enddefine