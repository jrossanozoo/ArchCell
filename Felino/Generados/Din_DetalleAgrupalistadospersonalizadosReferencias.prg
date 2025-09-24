
define class Din_DetalleAGRUPALISTADOSPERSONALIZADOSReferencias as detalle of detalle.prg


	nCantidadItems = 999
	cNombre = 'Referencias'
	cEtiqueta = 'Referencias'
	cMensajeErrorUnicidad = 'La columna  no admite valores repetidos.'
	cNombreVisual = 'Definición del agrupamiento'

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
				.Nombre = this.Item[ tnItem ].Nombre
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Nombre', .Nombre )
			
				.IDListado = this.Item[ tnItem ].IDListado
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'IDListado', .IDListado )
			
				.Personalizacion_PK = this.Item[ tnItem ].Personalizacion_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Personalizacion_PK', .Personalizacion_PK )
			
				.EsDefault = this.Item[ tnItem ].EsDefault
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'EsDefault', .EsDefault )
			
				.NombreDelAccesoDirecto = this.Item[ tnItem ].NombreDelAccesoDirecto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NombreDelAccesoDirecto', .NombreDelAccesoDirecto )
			
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.OrdenVisual = this.Item[ tnItem ].OrdenVisual
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'OrdenVisual', .OrdenVisual )
			
				.AccesoDirecto = this.Item[ tnItem ].AccesoDirecto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'AccesoDirecto', .AccesoDirecto )
			
				.NombreListado = this.Item[ tnItem ].NombreListado
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NombreListado', .NombreListado )
			
				.NombrePersonalizacion = this.Item[ tnItem ].NombrePersonalizacion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NombrePersonalizacion', .NombrePersonalizacion )
			
				.AtributoFecha = this.Item[ tnItem ].AtributoFecha
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'AtributoFecha', .AtributoFecha )
			
				.Activado = this.Item[ tnItem ].Activado
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Activado', .Activado )
			
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
			.Nombre = this.oItem.Nombre
			.IDListado = this.oItem.IDListado
			.Personalizacion_PK = this.oItem.Personalizacion_PK
			.EsDefault = this.oItem.EsDefault
			.NombreDelAccesoDirecto = this.oItem.NombreDelAccesoDirecto
			.NROITEM = this.oItem.NROITEM
			.OrdenVisual = this.oItem.OrdenVisual
			.AccesoDirecto = this.oItem.AccesoDirecto
			.NombreListado = this.oItem.NombreListado
			.NombrePersonalizacion = this.oItem.NombrePersonalizacion
			.AtributoFecha = this.oItem.AtributoFecha
			.Activado = this.oItem.Activado
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
			.Item[ lnItem ].Nombre = .oItem.Nombre
			.Item[ lnItem ].IDListado = .oItem.IDListado
			.Item[ lnItem ].Personalizacion_PK = .oItem.Personalizacion_PK
			.Item[ lnItem ].EsDefault = .oItem.EsDefault
			.Item[ lnItem ].NombreDelAccesoDirecto = .oItem.NombreDelAccesoDirecto
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].OrdenVisual = .oItem.OrdenVisual
			.Item[ lnItem ].AccesoDirecto = .oItem.AccesoDirecto
			.Item[ lnItem ].NombreListado = .oItem.NombreListado
			.Item[ lnItem ].NombrePersonalizacion = .oItem.NombrePersonalizacion
			.Item[ lnItem ].AtributoFecha = .oItem.AtributoFecha
			.Item[ lnItem ].Activado = .oItem.Activado
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'ItemAGRUPALISTADOSPERSONALIZADOSReferencias' )
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

		select c_Referencias
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Nombre = c_Referencias.Nombre
			loItem.IDListado = c_Referencias.IDListado
			loItem.Personalizacion_PK = c_Referencias.Personalizacion
			loItem.EsDefault = c_Referencias.EsDefault
			loItem.NombreDelAccesoDirecto = c_Referencias.NombreDelAccesoDirecto
			loItem.NROITEM = c_Referencias.NROITEM
			loItem.OrdenVisual = c_Referencias.OrdenVisual
			loItem.AccesoDirecto = c_Referencias.AccesoDirecto
			loItem.NombreListado = c_Referencias.NombreListado
			loItem.NombrePersonalizacion = c_Referencias.NombrePersonalizacion
			loItem.AtributoFecha = c_Referencias.AtributoFecha
			loItem.Activado = c_Referencias.Activado
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

		if  empty( this.item[ tnItem ].Ordenvisual ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc


	*-----------------------------------------------------------------------------------------
	Function ValidarFormatoAtributos() as boolean
	local lnLargoEntero as integer, lnValorDelDecimal as integer, lnLargoDecimal as integer, llRetorno as boolean, lnI as Integer

		llRetorno = dodefault()
		for lni = 1 to this.Count
			
			if vartype( this.Item[lni].NOMBRE) = 'C'
				if len( alltrim( this.Item[lni].NOMBRE )) <= 50
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo NOMBRE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].NOMBRE ))) + ' Máxima:50), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NOMBRE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].IDLISTADO) = 'C'
				if len( alltrim( this.Item[lni].IDLISTADO )) <= 60
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo IDLISTADO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].IDLISTADO ))) + ' Máxima:60), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo IDLISTADO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PERSONALIZACION_PK) = 'C'
				if len( alltrim( this.Item[lni].PERSONALIZACION_PK )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo PERSONALIZACION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].PERSONALIZACION_PK ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PERSONALIZACION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ESDEFAULT) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ESDEFAULT del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NOMBREDELACCESODIRECTO) = 'C'
				if len( alltrim( this.Item[lni].NOMBREDELACCESODIRECTO )) <= 120
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo NOMBREDELACCESODIRECTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].NOMBREDELACCESODIRECTO ))) + ' Máxima:120), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NOMBREDELACCESODIRECTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].ORDENVISUAL) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].ORDENVISUAL ) ) ) 
				lnValorDelDecimal = this.Item[lni].ORDENVISUAL - int( this.Item[lni].ORDENVISUAL )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 3
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo ORDENVISUAL del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:3), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ORDENVISUAL del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ACCESODIRECTO) = 'C'
				if len( alltrim( this.Item[lni].ACCESODIRECTO )) <= 254
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo ACCESODIRECTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].ACCESODIRECTO ))) + ' Máxima:254), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ACCESODIRECTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NOMBRELISTADO) = 'C'
				if len( alltrim( this.Item[lni].NOMBRELISTADO )) <= 150
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo NOMBRELISTADO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].NOMBRELISTADO ))) + ' Máxima:150), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NOMBRELISTADO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NOMBREPERSONALIZACION) = 'C'
				if len( alltrim( this.Item[lni].NOMBREPERSONALIZACION )) <= 150
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo NOMBREPERSONALIZACION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].NOMBREPERSONALIZACION ))) + ' Máxima:150), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NOMBREPERSONALIZACION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ATRIBUTOFECHA) = 'C'
				if len( alltrim( this.Item[lni].ATRIBUTOFECHA )) <= 30
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo ATRIBUTOFECHA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].ATRIBUTOFECHA ))) + ' Máxima:30), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ATRIBUTOFECHA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ACTIVADO) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ACTIVADO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Nombre = toItemOrigen.Nombre
		toItemDestino.Idlistado = toItemOrigen.Idlistado
		toItemDestino.Personalizacion_PK = toItemOrigen.Personalizacion_PK
		toItemDestino.Esdefault = toItemOrigen.Esdefault
		toItemDestino.Nombredelaccesodirecto = toItemOrigen.Nombredelaccesodirecto
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Ordenvisual = toItemOrigen.Ordenvisual
		toItemDestino.Accesodirecto = toItemOrigen.Accesodirecto
		toItemDestino.Nombrelistado = toItemOrigen.Nombrelistado
		toItemDestino.Nombrepersonalizacion = toItemOrigen.Nombrepersonalizacion
		toItemDestino.Atributofecha = toItemOrigen.Atributofecha
		toItemDestino.Activado = toItemOrigen.Activado
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
		lcRetorno = 'OrdenVisual'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Nombre = []
	Idlistado = []
	Personalizacion_PK = []
	Esdefault = .F.
	Nombredelaccesodirecto = []
	Nroitem = 0
	Ordenvisual = 0
	Accesodirecto = []
	Nombrelistado = []
	Nombrepersonalizacion = []
	Atributofecha = []
	Activado = .F.
	NroItem = 0

enddefine