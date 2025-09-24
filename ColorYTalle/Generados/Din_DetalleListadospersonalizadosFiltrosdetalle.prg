
define class Din_DetalleLISTADOSPERSONALIZADOSFiltrosdetalle as detalle of detalle.prg


	nCantidadItems = 999
	cNombre = 'Filtrosdetalle'
	cEtiqueta = 'Filtros'
	cMensajeErrorUnicidad = 'La columna  no admite valores repetidos.'
	cNombreVisual = 'Detalle de filtros'

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
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.BLOQUEARREGISTRO = this.Item[ tnItem ].BLOQUEARREGISTRO
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'BLOQUEARREGISTRO', .BLOQUEARREGISTRO )
			
				.codigo = this.Item[ tnItem ].codigo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'codigo', .codigo )
			
				.Identificador = this.Item[ tnItem ].Identificador
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Identificador', .Identificador )
			
				.idCampo = this.Item[ tnItem ].idCampo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'idCampo', .idCampo )
			
				.ValorDesde = this.Item[ tnItem ].ValorDesde
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ValorDesde', .ValorDesde )
			
				.SoloLecturaDesde = this.Item[ tnItem ].SoloLecturaDesde
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'SoloLecturaDesde', .SoloLecturaDesde )
			
				.ValorHasta = this.Item[ tnItem ].ValorHasta
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ValorHasta', .ValorHasta )
			
				.SoloLecturaHasta = this.Item[ tnItem ].SoloLecturaHasta
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'SoloLecturaHasta', .SoloLecturaHasta )
			
				.nOrden = this.Item[ tnItem ].nOrden
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'nOrden', .nOrden )
			
				.Activado = this.Item[ tnItem ].Activado
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Activado', .Activado )
			
				.CriterioDeInicializacion = this.Item[ tnItem ].CriterioDeInicializacion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CriterioDeInicializacion', .CriterioDeInicializacion )
			
				.DiasHaciaAtras = this.Item[ tnItem ].DiasHaciaAtras
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'DiasHaciaAtras', .DiasHaciaAtras )
			
				.ValorNumericoInicial_Desde = this.Item[ tnItem ].ValorNumericoInicial_Desde
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ValorNumericoInicial_Desde', .ValorNumericoInicial_Desde )
			
				.ValorNumericoInicial_Hasta = this.Item[ tnItem ].ValorNumericoInicial_Hasta
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ValorNumericoInicial_Hasta', .ValorNumericoInicial_Hasta )
			
				.ValorCaracterInicial_Desde = this.Item[ tnItem ].ValorCaracterInicial_Desde
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ValorCaracterInicial_Desde', .ValorCaracterInicial_Desde )
			
				.ValorCaracterInicial_Hasta = this.Item[ tnItem ].ValorCaracterInicial_Hasta
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ValorCaracterInicial_Hasta', .ValorCaracterInicial_Hasta )
			
				.ValorBooleanoInicial = this.Item[ tnItem ].ValorBooleanoInicial
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ValorBooleanoInicial', .ValorBooleanoInicial )
			
				.ValorSiNoInicial = this.Item[ tnItem ].ValorSiNoInicial
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ValorSiNoInicial', .ValorSiNoInicial )
			
				.SoloLectura = this.Item[ tnItem ].SoloLectura
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'SoloLectura', .SoloLectura )
			
				.NoInformar = this.Item[ tnItem ].NoInformar
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NoInformar', .NoInformar )
			
				.NoMostrar = this.Item[ tnItem ].NoMostrar
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NoMostrar', .NoMostrar )
			
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
			.NROITEM = this.oItem.NROITEM
			.BLOQUEARREGISTRO = this.oItem.BLOQUEARREGISTRO
			.codigo = this.oItem.codigo
			.Identificador = this.oItem.Identificador
			.idCampo = this.oItem.idCampo
			.ValorDesde = this.oItem.ValorDesde
			.SoloLecturaDesde = this.oItem.SoloLecturaDesde
			.ValorHasta = this.oItem.ValorHasta
			.SoloLecturaHasta = this.oItem.SoloLecturaHasta
			.nOrden = this.oItem.nOrden
			.Activado = this.oItem.Activado
			.CriterioDeInicializacion = this.oItem.CriterioDeInicializacion
			.DiasHaciaAtras = this.oItem.DiasHaciaAtras
			.ValorNumericoInicial_Desde = this.oItem.ValorNumericoInicial_Desde
			.ValorNumericoInicial_Hasta = this.oItem.ValorNumericoInicial_Hasta
			.ValorCaracterInicial_Desde = this.oItem.ValorCaracterInicial_Desde
			.ValorCaracterInicial_Hasta = this.oItem.ValorCaracterInicial_Hasta
			.ValorBooleanoInicial = this.oItem.ValorBooleanoInicial
			.ValorSiNoInicial = this.oItem.ValorSiNoInicial
			.SoloLectura = this.oItem.SoloLectura
			.NoInformar = this.oItem.NoInformar
			.NoMostrar = this.oItem.NoMostrar
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
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].BLOQUEARREGISTRO = .oItem.BLOQUEARREGISTRO
			.Item[ lnItem ].codigo = .oItem.codigo
			.Item[ lnItem ].Identificador = .oItem.Identificador
			.Item[ lnItem ].idCampo = .oItem.idCampo
			.Item[ lnItem ].ValorDesde = .oItem.ValorDesde
			.Item[ lnItem ].SoloLecturaDesde = .oItem.SoloLecturaDesde
			.Item[ lnItem ].ValorHasta = .oItem.ValorHasta
			.Item[ lnItem ].SoloLecturaHasta = .oItem.SoloLecturaHasta
			.Item[ lnItem ].nOrden = .oItem.nOrden
			.Item[ lnItem ].Activado = .oItem.Activado
			.Item[ lnItem ].CriterioDeInicializacion = .oItem.CriterioDeInicializacion
			.Item[ lnItem ].DiasHaciaAtras = .oItem.DiasHaciaAtras
			.Item[ lnItem ].ValorNumericoInicial_Desde = .oItem.ValorNumericoInicial_Desde
			.Item[ lnItem ].ValorNumericoInicial_Hasta = .oItem.ValorNumericoInicial_Hasta
			.Item[ lnItem ].ValorCaracterInicial_Desde = .oItem.ValorCaracterInicial_Desde
			.Item[ lnItem ].ValorCaracterInicial_Hasta = .oItem.ValorCaracterInicial_Hasta
			.Item[ lnItem ].ValorBooleanoInicial = .oItem.ValorBooleanoInicial
			.Item[ lnItem ].ValorSiNoInicial = .oItem.ValorSiNoInicial
			.Item[ lnItem ].SoloLectura = .oItem.SoloLectura
			.Item[ lnItem ].NoInformar = .oItem.NoInformar
			.Item[ lnItem ].NoMostrar = .oItem.NoMostrar
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemLISTADOSPERSONALIZADOSFiltrosdetalle' )
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

		select c_Filtrosdetalle
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.NROITEM = c_Filtrosdetalle.NROITEM
			loItem.BLOQUEARREGISTRO = c_Filtrosdetalle.BLOQUEARREGISTRO
			loItem.codigo = c_Filtrosdetalle.codigo
			loItem.Identificador = c_Filtrosdetalle.Identificador
			loItem.idCampo = c_Filtrosdetalle.idCampo
			loItem.ValorDesde = c_Filtrosdetalle.ValorDesde
			loItem.SoloLecturaDesde = c_Filtrosdetalle.SoloLecturaDesde
			loItem.ValorHasta = c_Filtrosdetalle.ValorHasta
			loItem.SoloLecturaHasta = c_Filtrosdetalle.SoloLecturaHasta
			loItem.nOrden = c_Filtrosdetalle.nOrden
			loItem.Activado = c_Filtrosdetalle.Activado
			loItem.CriterioDeInicializacion = c_Filtrosdetalle.CriterioDeInicializacion
			loItem.DiasHaciaAtras = c_Filtrosdetalle.DiasHaciaAtras
			loItem.ValorNumericoInicial_Desde = c_Filtrosdetalle.ValorNumericoInicial_Desde
			loItem.ValorNumericoInicial_Hasta = c_Filtrosdetalle.ValorNumericoInicial_Hasta
			loItem.ValorCaracterInicial_Desde = c_Filtrosdetalle.ValorCaracterInicial_Desde
			loItem.ValorCaracterInicial_Hasta = c_Filtrosdetalle.ValorCaracterInicial_Hasta
			loItem.ValorBooleanoInicial = c_Filtrosdetalle.ValorBooleanoInicial
			loItem.ValorSiNoInicial = c_Filtrosdetalle.ValorSiNoInicial
			loItem.SoloLectura = c_Filtrosdetalle.SoloLectura
			loItem.NoInformar = c_Filtrosdetalle.NoInformar
			loItem.NoMostrar = c_Filtrosdetalle.NoMostrar
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

		return llRetorno

	endfunc


	*-----------------------------------------------------------------------------------------
	Function ValidarFormatoAtributos() as boolean
	local lnLargoEntero as integer, lnValorDelDecimal as integer, lnLargoDecimal as integer, llRetorno as boolean, lnI as Integer

		llRetorno = dodefault()
		for lni = 1 to this.Count
			
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
			
			if vartype( this.Item[lni].VALORDESDE) = 'C'
				if len( alltrim( this.Item[lni].VALORDESDE )) <= 250
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo VALORDESDE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].VALORDESDE ))) + ' Máxima:250), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo VALORDESDE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].SOLOLECTURADESDE) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo SOLOLECTURADESDE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].VALORHASTA) = 'C'
				if len( alltrim( this.Item[lni].VALORHASTA )) <= 250
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo VALORHASTA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].VALORHASTA ))) + ' Máxima:250), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo VALORHASTA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].SOLOLECTURAHASTA) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo SOLOLECTURAHASTA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NORDEN) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].NORDEN ) ) ) 
				lnValorDelDecimal = this.Item[lni].NORDEN - int( this.Item[lni].NORDEN )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 8
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo NORDEN del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:8), en el detalle ' + this.cEtiqueta + '.' )
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
			
			if vartype( this.Item[lni].CRITERIODEINICIALIZACION) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].CRITERIODEINICIALIZACION ) ) ) 
				lnValorDelDecimal = this.Item[lni].CRITERIODEINICIALIZACION - int( this.Item[lni].CRITERIODEINICIALIZACION )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo CRITERIODEINICIALIZACION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CRITERIODEINICIALIZACION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].DIASHACIAATRAS) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].DIASHACIAATRAS ) ) ) 
				lnValorDelDecimal = this.Item[lni].DIASHACIAATRAS - int( this.Item[lni].DIASHACIAATRAS )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 4
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo DIASHACIAATRAS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:4), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo DIASHACIAATRAS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].VALORNUMERICOINICIAL_DESDE) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].VALORNUMERICOINICIAL_DESDE ) ) ) 
				lnValorDelDecimal = this.Item[lni].VALORNUMERICOINICIAL_DESDE - int( this.Item[lni].VALORNUMERICOINICIAL_DESDE )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo VALORNUMERICOINICIAL_DESDE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo VALORNUMERICOINICIAL_DESDE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].VALORNUMERICOINICIAL_HASTA) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].VALORNUMERICOINICIAL_HASTA ) ) ) 
				lnValorDelDecimal = this.Item[lni].VALORNUMERICOINICIAL_HASTA - int( this.Item[lni].VALORNUMERICOINICIAL_HASTA )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo VALORNUMERICOINICIAL_HASTA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo VALORNUMERICOINICIAL_HASTA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].VALORCARACTERINICIAL_DESDE) = 'C'
				if len( alltrim( this.Item[lni].VALORCARACTERINICIAL_DESDE )) <= 250
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo VALORCARACTERINICIAL_DESDE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].VALORCARACTERINICIAL_DESDE ))) + ' Máxima:250), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo VALORCARACTERINICIAL_DESDE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].VALORCARACTERINICIAL_HASTA) = 'C'
				if len( alltrim( this.Item[lni].VALORCARACTERINICIAL_HASTA )) <= 250
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo VALORCARACTERINICIAL_HASTA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].VALORCARACTERINICIAL_HASTA ))) + ' Máxima:250), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo VALORCARACTERINICIAL_HASTA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].VALORBOOLEANOINICIAL) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].VALORBOOLEANOINICIAL ) ) ) 
				lnValorDelDecimal = this.Item[lni].VALORBOOLEANOINICIAL - int( this.Item[lni].VALORBOOLEANOINICIAL )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo VALORBOOLEANOINICIAL del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo VALORBOOLEANOINICIAL del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].VALORSINOINICIAL) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].VALORSINOINICIAL ) ) ) 
				lnValorDelDecimal = this.Item[lni].VALORSINOINICIAL - int( this.Item[lni].VALORSINOINICIAL )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo VALORSINOINICIAL del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo VALORSINOINICIAL del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].SOLOLECTURA) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo SOLOLECTURA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NOINFORMAR) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NOINFORMAR del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NOMOSTRAR) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NOMOSTRAR del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Bloquearregistro = toItemOrigen.Bloquearregistro
		toItemDestino.Codigo = toItemOrigen.Codigo
		toItemDestino.Identificador = toItemOrigen.Identificador
		toItemDestino.Idcampo = toItemOrigen.Idcampo
		toItemDestino.Valordesde = toItemOrigen.Valordesde
		toItemDestino.Sololecturadesde = toItemOrigen.Sololecturadesde
		toItemDestino.Valorhasta = toItemOrigen.Valorhasta
		toItemDestino.Sololecturahasta = toItemOrigen.Sololecturahasta
		toItemDestino.Norden = toItemOrigen.Norden
		toItemDestino.Activado = toItemOrigen.Activado
		toItemDestino.Criteriodeinicializacion = toItemOrigen.Criteriodeinicializacion
		toItemDestino.Diashaciaatras = toItemOrigen.Diashaciaatras
		toItemDestino.Valornumericoinicial_desde = toItemOrigen.Valornumericoinicial_desde
		toItemDestino.Valornumericoinicial_hasta = toItemOrigen.Valornumericoinicial_hasta
		toItemDestino.Valorcaracterinicial_desde = toItemOrigen.Valorcaracterinicial_desde
		toItemDestino.Valorcaracterinicial_hasta = toItemOrigen.Valorcaracterinicial_hasta
		toItemDestino.Valorbooleanoinicial = toItemOrigen.Valorbooleanoinicial
		toItemDestino.Valorsinoinicial = toItemOrigen.Valorsinoinicial
		toItemDestino.Sololectura = toItemOrigen.Sololectura
		toItemDestino.Noinformar = toItemOrigen.Noinformar
		toItemDestino.Nomostrar = toItemOrigen.Nomostrar
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


enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Nroitem = 0
	Bloquearregistro = .F.
	Codigo = []
	Identificador = []
	Idcampo = 0
	Valordesde = []
	Sololecturadesde = .F.
	Valorhasta = []
	Sololecturahasta = .F.
	Norden = 0
	Activado = .F.
	Criteriodeinicializacion = 0
	Diashaciaatras = 0
	Valornumericoinicial_desde = 0
	Valornumericoinicial_hasta = 0
	Valorcaracterinicial_desde = []
	Valorcaracterinicial_hasta = []
	Valorbooleanoinicial = 0
	Valorsinoinicial = 0
	Sololectura = .F.
	Noinformar = .F.
	Nomostrar = .F.
	NroItem = 0

enddefine