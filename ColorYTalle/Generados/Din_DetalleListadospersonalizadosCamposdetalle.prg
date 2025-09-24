
define class Din_DetalleLISTADOSPERSONALIZADOSCamposdetalle as detalle of detalle.prg


	nCantidadItems = 999
	cNombre = 'Camposdetalle'
	cEtiqueta = 'Campos'
	cMensajeErrorUnicidad = 'La columna  no admite valores repetidos.'
	cNombreVisual = 'Detalle de campos'

	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function _CargarItem( tnItem as integer )
		Local loEx as Excepcion, llVacio as Boolean
		if tnItem <= 0
			loEx = Newobject( 'ZooException', 'ZooException.prg' )
			With loEx
				.Message = 'El item está fuera del rango'
				.Grabar()
				.Throw()
			EndWith
		EndIf
		With this.oItem
			Try
				.lCargando = .t.
				.NroItem = tnItem
				llVacio = .t.
				.codigo = this.Item[ tnItem ].codigo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'codigo', .codigo )
			
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.BLOQUEARREGISTRO = this.Item[ tnItem ].BLOQUEARREGISTRO
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'BLOQUEARREGISTRO', .BLOQUEARREGISTRO )
			
				.Identificador = this.Item[ tnItem ].Identificador
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Identificador', .Identificador )
			
				.idCampo = this.Item[ tnItem ].idCampo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'idCampo', .idCampo )
			
				.EtiquetaReporte = this.Item[ tnItem ].EtiquetaReporte
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'EtiquetaReporte', .EtiquetaReporte )
			
				.LongitudReporte = this.Item[ tnItem ].LongitudReporte
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'LongitudReporte', .LongitudReporte )
			
				.DecimalesReporte = this.Item[ tnItem ].DecimalesReporte
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'DecimalesReporte', .DecimalesReporte )
			
				.MostrarCeros = this.Item[ tnItem ].MostrarCeros
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MostrarCeros', .MostrarCeros )
			
				.GrupoVisual = this.Item[ tnItem ].GrupoVisual
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'GrupoVisual', .GrupoVisual )
			
				.Expresion = this.Item[ tnItem ].Expresion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Expresion', .Expresion )
			
				.ExpresionNueva_PK = this.Item[ tnItem ].ExpresionNueva_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ExpresionNueva_PK', .ExpresionNueva_PK )
			
				.TipoCalculo = this.Item[ tnItem ].TipoCalculo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TipoCalculo', .TipoCalculo )
			
				.nOrden = this.Item[ tnItem ].nOrden
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'nOrden', .nOrden )
			
				.activado = this.Item[ tnItem ].activado
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'activado', .activado )
			
				.LineaVertical = this.Item[ tnItem ].LineaVertical
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'LineaVertical', .LineaVertical )
			
				.PuedeCrecer = this.Item[ tnItem ].PuedeCrecer
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PuedeCrecer', .PuedeCrecer )
			
				.OcultaRepetido = this.Item[ tnItem ].OcultaRepetido
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'OcultaRepetido', .OcultaRepetido )
			
				.TamañoOriginalImagen = this.Item[ tnItem ].TamañoOriginalImagen
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TamañoOriginalImagen', .TamañoOriginalImagen )
			
				.AnchoImagen = this.Item[ tnItem ].AnchoImagen
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'AnchoImagen', .AnchoImagen )
			
				.AltoImagen = this.Item[ tnItem ].AltoImagen
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'AltoImagen', .AltoImagen )
			
				.lCargando = .f.
				if llVacio
					this.oItem.SetearValoresSugeridos()
				endif
			Finally
				.lCargando = .f.
			EndTry
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function AplanarItem() as Object
		local loRetorno as object
		loRetorno = createobject('ItemAuxiliar')

		with loRetorno
			.codigo = this.oItem.codigo
			.NROITEM = this.oItem.NROITEM
			.BLOQUEARREGISTRO = this.oItem.BLOQUEARREGISTRO
			.Identificador = this.oItem.Identificador
			.idCampo = this.oItem.idCampo
			.EtiquetaReporte = this.oItem.EtiquetaReporte
			.LongitudReporte = this.oItem.LongitudReporte
			.DecimalesReporte = this.oItem.DecimalesReporte
			.MostrarCeros = this.oItem.MostrarCeros
			.GrupoVisual = this.oItem.GrupoVisual
			.Expresion = this.oItem.Expresion
			.ExpresionNueva_PK = this.oItem.ExpresionNueva_PK
			.TipoCalculo = this.oItem.TipoCalculo
			.nOrden = this.oItem.nOrden
			.activado = this.oItem.activado
			.LineaVertical = this.oItem.LineaVertical
			.PuedeCrecer = this.oItem.PuedeCrecer
			.OcultaRepetido = this.oItem.OcultaRepetido
			.TamañoOriginalImagen = this.oItem.TamañoOriginalImagen
			.AnchoImagen = this.oItem.AnchoImagen
			.AltoImagen = this.oItem.AltoImagen
			.NroItem = iif( this.oItem.NroItem = 0, this.Count + 1, this.oItem.NroItem )
		endwith

		return loRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function Modificar() as void
	local lnItem as integer, loEx as Exception

	with this
		if .ValidarItem()
			lnItem = .oItem.NroItem
			if lnItem <= 0
				.AgregarInformacion( 'Debe cargar un item para poder modificar' )
				goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
			endif

			if .oItem.ValidarExistenciaCamposFijos()
			else
				.oItem.Limpiar( .t. )
			endif

			.oItem.NroItem = lnItem
			.Item[ lnItem ].codigo = .oItem.codigo
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].BLOQUEARREGISTRO = .oItem.BLOQUEARREGISTRO
			.Item[ lnItem ].Identificador = .oItem.Identificador
			.Item[ lnItem ].idCampo = .oItem.idCampo
			.Item[ lnItem ].EtiquetaReporte = .oItem.EtiquetaReporte
			.Item[ lnItem ].LongitudReporte = .oItem.LongitudReporte
			.Item[ lnItem ].DecimalesReporte = .oItem.DecimalesReporte
			.Item[ lnItem ].MostrarCeros = .oItem.MostrarCeros
			.Item[ lnItem ].GrupoVisual = .oItem.GrupoVisual
			.Item[ lnItem ].Expresion = .oItem.Expresion
			.Item[ lnItem ].ExpresionNueva_PK = .oItem.ExpresionNueva_PK
			.Item[ lnItem ].TipoCalculo = .oItem.TipoCalculo
			.Item[ lnItem ].nOrden = .oItem.nOrden
			.Item[ lnItem ].activado = .oItem.activado
			.Item[ lnItem ].LineaVertical = .oItem.LineaVertical
			.Item[ lnItem ].PuedeCrecer = .oItem.PuedeCrecer
			.Item[ lnItem ].OcultaRepetido = .oItem.OcultaRepetido
			.Item[ lnItem ].TamañoOriginalImagen = .oItem.TamañoOriginalImagen
			.Item[ lnItem ].AnchoImagen = .oItem.AnchoImagen
			.Item[ lnItem ].AltoImagen = .oItem.AltoImagen
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemLISTADOSPERSONALIZADOSCamposdetalle' )
			this.enlazar( 'oItem.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oItem.EventoObtenerInformacion', 'inyectarInformacion' )
			this.oItem.inicializar()
			bindevent( this.oItem, 'EventoDespuesDeSetear', this, 'ValidarCantidadDeItemsEnDetalle' )
		endif
		return this.oItem
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Cargar() as Void
		local loItem as object, lnI as integer, lcClave as string, lcFiltro as String 
		lnI = 1

		select c_Camposdetalle
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.codigo = c_Camposdetalle.codigo
			loItem.NROITEM = c_Camposdetalle.NROITEM
			loItem.BLOQUEARREGISTRO = c_Camposdetalle.BLOQUEARREGISTRO
			loItem.Identificador = c_Camposdetalle.Identificador
			loItem.idCampo = c_Camposdetalle.idCampo
			loItem.EtiquetaReporte = c_Camposdetalle.EtiquetaReporte
			loItem.LongitudReporte = c_Camposdetalle.LongitudReporte
			loItem.DecimalesReporte = c_Camposdetalle.DecimalesReporte
			loItem.MostrarCeros = c_Camposdetalle.MostrarCeros
			loItem.GrupoVisual = c_Camposdetalle.GrupoVisual
			loItem.Expresion = c_Camposdetalle.Expresion
			loItem.ExpresionNueva_PK = c_Camposdetalle.ExpresionNueva
			loItem.TipoCalculo = c_Camposdetalle.TipoCalculo
			loItem.nOrden = c_Camposdetalle.nOrden
			loItem.activado = c_Camposdetalle.activado
			loItem.LineaVertical = c_Camposdetalle.LineaVertical
			loItem.PuedeCrecer = c_Camposdetalle.PuedeCrecer
			loItem.OcultaRepetido = c_Camposdetalle.OcultaRepetido
			loItem.TamañoOriginalImagen = c_Camposdetalle.TamañoOriginalImagen
			loItem.AnchoImagen = c_Camposdetalle.AnchoImagen
			loItem.AltoImagen = c_Camposdetalle.AltoImagen
			loItem.NroItem = lnI 
			this.AgregarItemPlano( loItem )
			lnI = lnI + 1
		endscan

		this.CambioSumarizado()

	endfunc


	*--------------------------------------------------------------------------------------------------------
	function ValidarExistenciaCamposFijosItemPlano( tnItem as integer ) as Boolean
		Local llRetorno as boolean
		llRetorno = .t.

		if  empty( this.item[ tnItem ].Idcampo ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc


	*-----------------------------------------------------------------------------------------
	Function ValidarFormatoAtributos() as boolean
	local lnLargoEntero as integer, lnValorDelDecimal as integer, lnLargoDecimal as integer, llRetorno as boolean, lnI as Integer

		llRetorno = dodefault()
		for lni = 1 to this.Count
			
			if vartype( this.Item[lni].CODIGO) = 'C'
				if len( alltrim( this.Item[lni].CODIGO )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGO ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NROITEM) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].NROITEM ) ) ) 
				lnValorDelDecimal = this.Item[lni].NROITEM - int( this.Item[lni].NROITEM )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 5
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo NROITEM del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:5), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NROITEM del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].BLOQUEARREGISTRO) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo BLOQUEARREGISTRO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].IDENTIFICADOR) = 'C'
				if len( alltrim( this.Item[lni].IDENTIFICADOR )) <= 200
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo IDENTIFICADOR del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].IDENTIFICADOR ))) + ' Máxima:200), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo IDENTIFICADOR del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].IDCAMPO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].IDCAMPO ) ) ) 
				lnValorDelDecimal = this.Item[lni].IDCAMPO - int( this.Item[lni].IDCAMPO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 8
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo IDCAMPO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:8), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo IDCAMPO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ETIQUETAREPORTE) = 'C'
				if len( alltrim( this.Item[lni].ETIQUETAREPORTE )) <= 40
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo ETIQUETAREPORTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].ETIQUETAREPORTE ))) + ' Máxima:40), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ETIQUETAREPORTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].LONGITUDREPORTE) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].LONGITUDREPORTE ) ) ) 
				lnValorDelDecimal = this.Item[lni].LONGITUDREPORTE - int( this.Item[lni].LONGITUDREPORTE )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 3
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo LONGITUDREPORTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:3), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo LONGITUDREPORTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].DECIMALESREPORTE) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].DECIMALESREPORTE ) ) ) 
				lnValorDelDecimal = this.Item[lni].DECIMALESREPORTE - int( this.Item[lni].DECIMALESREPORTE )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo DECIMALESREPORTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo DECIMALESREPORTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MOSTRARCEROS) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MOSTRARCEROS ) ) ) 
				lnValorDelDecimal = this.Item[lni].MOSTRARCEROS - int( this.Item[lni].MOSTRARCEROS )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 1
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MOSTRARCEROS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:1), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MOSTRARCEROS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].GRUPOVISUAL) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].GRUPOVISUAL ) ) ) 
				lnValorDelDecimal = this.Item[lni].GRUPOVISUAL - int( this.Item[lni].GRUPOVISUAL )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo GRUPOVISUAL del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo GRUPOVISUAL del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].EXPRESION) = 'C'
				if len( alltrim( this.Item[lni].EXPRESION )) <= 225
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo EXPRESION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].EXPRESION ))) + ' Máxima:225), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo EXPRESION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].EXPRESIONNUEVA_PK) = 'C'
				if len( alltrim( this.Item[lni].EXPRESIONNUEVA_PK )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo EXPRESIONNUEVA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].EXPRESIONNUEVA_PK ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo EXPRESIONNUEVA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TIPOCALCULO) = 'C'
				if len( alltrim( this.Item[lni].TIPOCALCULO )) <= 15
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TIPOCALCULO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TIPOCALCULO ))) + ' Máxima:15), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TIPOCALCULO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NORDEN) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].NORDEN ) ) ) 
				lnValorDelDecimal = this.Item[lni].NORDEN - int( this.Item[lni].NORDEN )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 12
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo NORDEN del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:12), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NORDEN del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ACTIVADO) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ACTIVADO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].LINEAVERTICAL) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo LINEAVERTICAL del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PUEDECRECER) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PUEDECRECER del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].OCULTAREPETIDO) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo OCULTAREPETIDO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TAMAÑOORIGINALIMAGEN) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TAMAÑOORIGINALIMAGEN del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ANCHOIMAGEN) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].ANCHOIMAGEN ) ) ) 
				lnValorDelDecimal = this.Item[lni].ANCHOIMAGEN - int( this.Item[lni].ANCHOIMAGEN )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo ANCHOIMAGEN del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ANCHOIMAGEN del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ALTOIMAGEN) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].ALTOIMAGEN ) ) ) 
				lnValorDelDecimal = this.Item[lni].ALTOIMAGEN - int( this.Item[lni].ALTOIMAGEN )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo ALTOIMAGEN del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ALTOIMAGEN del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
		EndFor
		Return llRetorno 
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function CrearItemAuxiliar() as Object
		return createobject( 'itemAuxiliar' )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ClonarItemAuxiliar( tnItem as Integer ) as Object
		loItemOrigen = this.Item[tnItem]
		loRetorno = createobject( 'itemAuxiliar' )
		this.CopiarItemaItem( loItemOrigen, loRetorno ) 

		return loRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function CopiarItemaItem( toItemOrigen as Object, toItemDestino as Object ) as Object
		toItemDestino.Codigo = toItemOrigen.Codigo
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Bloquearregistro = toItemOrigen.Bloquearregistro
		toItemDestino.Identificador = toItemOrigen.Identificador
		toItemDestino.Idcampo = toItemOrigen.Idcampo
		toItemDestino.Etiquetareporte = toItemOrigen.Etiquetareporte
		toItemDestino.Longitudreporte = toItemOrigen.Longitudreporte
		toItemDestino.Decimalesreporte = toItemOrigen.Decimalesreporte
		toItemDestino.Mostrarceros = toItemOrigen.Mostrarceros
		toItemDestino.Grupovisual = toItemOrigen.Grupovisual
		toItemDestino.Expresion = toItemOrigen.Expresion
		toItemDestino.Expresionnueva_PK = toItemOrigen.Expresionnueva_PK
		toItemDestino.Tipocalculo = toItemOrigen.Tipocalculo
		toItemDestino.Norden = toItemOrigen.Norden
		toItemDestino.Activado = toItemOrigen.Activado
		toItemDestino.Lineavertical = toItemOrigen.Lineavertical
		toItemDestino.Puedecrecer = toItemOrigen.Puedecrecer
		toItemDestino.Ocultarepetido = toItemOrigen.Ocultarepetido
		toItemDestino.Tamañooriginalimagen = toItemOrigen.Tamañooriginalimagen
		toItemDestino.Anchoimagen = toItemOrigen.Anchoimagen
		toItemDestino.Altoimagen = toItemOrigen.Altoimagen
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function VerificarSiElAtributoEstaVacio( tcAtributo as String, txValor as Variant ) as Boolean
		local llRetorno as boolean
		llRetorno = .t.
		if this.ElAtributoEsVerificableComoVacio( tcAtributo )
			llRetorno = empty( txValor )
		endif
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ElAtributoEsVerificableComoVacio( tcAtributo as String ) as Boolean
		Return dodefault( tcAtributo ) 
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerFiltro( ) as String
		local lcRetorno as String
		lcRetorno = '.T.'
		return lcRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerCampoInicialYOBligatorioDelDetalle() as String
	local lcRetorno as string
		lcRetorno = 'idCampo'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Codigo = []
	Nroitem = 0
	Bloquearregistro = .F.
	Identificador = []
	Idcampo = 0
	Etiquetareporte = []
	Longitudreporte = 0
	Decimalesreporte = 0
	Mostrarceros = 0
	Grupovisual = 0
	Expresion = []
	Expresionnueva_PK = []
	Tipocalculo = []
	Norden = 0
	Activado = .F.
	Lineavertical = .F.
	Puedecrecer = .F.
	Ocultarepetido = .F.
	Tamañooriginalimagen = .F.
	Anchoimagen = 0
	Altoimagen = 0
	NroItem = 0

enddefine