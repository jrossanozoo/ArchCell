
define class Din_DetalleCLIENTEPercepciones as detalle of detalle.prg


	cAtributosUnicidad = 'Jurisdiccion_PK'
	nCantidadItems = 999
	cNombre = 'Percepciones'
	cEtiqueta = 'Percepciones'
	cMensajeErrorUnicidad = 'La columna Jurisdicción no admite valores repetidos.'
	cNombreVisual = 'Ingresos Brutos'

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
			
				.Jurisdiccion_PK = this.Item[ tnItem ].Jurisdiccion_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Jurisdiccion_PK', .Jurisdiccion_PK )
			
				.CodigoPadronIIBB = this.Item[ tnItem ].CodigoPadronIIBB
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodigoPadronIIBB', .CodigoPadronIIBB )
			
				.JurisdiccionDetalle = this.Item[ tnItem ].JurisdiccionDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'JurisdiccionDetalle', .JurisdiccionDetalle )
			
				.Resolucion = this.Item[ tnItem ].Resolucion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Resolucion', .Resolucion )
			
				.Porcentaje = this.Item[ tnItem ].Porcentaje
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Porcentaje', .Porcentaje )
			
				.FechaExpiracion = this.Item[ tnItem ].FechaExpiracion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'FechaExpiracion', .FechaExpiracion )
			
				.Excluido = this.Item[ tnItem ].Excluido
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Excluido', .Excluido )
			
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
			.Jurisdiccion_PK = this.oItem.Jurisdiccion_PK
			.CodigoPadronIIBB = this.oItem.CodigoPadronIIBB
			.JurisdiccionDetalle = this.oItem.JurisdiccionDetalle
			.Resolucion = this.oItem.Resolucion
			.Porcentaje = this.oItem.Porcentaje
			.FechaExpiracion = this.oItem.FechaExpiracion
			.Excluido = this.oItem.Excluido
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
			.Item[ lnItem ].Jurisdiccion_PK = .oItem.Jurisdiccion_PK
			.Item[ lnItem ].CodigoPadronIIBB = .oItem.CodigoPadronIIBB
			.Item[ lnItem ].JurisdiccionDetalle = .oItem.JurisdiccionDetalle
			.Item[ lnItem ].Resolucion = .oItem.Resolucion
			.Item[ lnItem ].Porcentaje = .oItem.Porcentaje
			.Item[ lnItem ].FechaExpiracion = .oItem.FechaExpiracion
			.Item[ lnItem ].Excluido = .oItem.Excluido
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'ItemCLIENTEPercepciones' )
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

		select c_Percepciones
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.codigo = c_Percepciones.codigo
			loItem.NROITEM = c_Percepciones.NROITEM
			loItem.Jurisdiccion_PK = c_Percepciones.Jurisdiccion
			loItem.CodigoPadronIIBB = c_Percepciones.CodigoPadronIIBB
			loItem.JurisdiccionDetalle = c_Percepciones.JurisdiccionDetalle
			loItem.Resolucion = c_Percepciones.Resolucion
			loItem.Porcentaje = c_Percepciones.Porcentaje
			loItem.FechaExpiracion = goLibrerias.ObtenerFechaFormateada( c_Percepciones.FechaExpiracion )
			loItem.Excluido = c_Percepciones.Excluido
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

		if  empty( this.item[ tnItem ].Jurisdiccion_PK ) 
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
				if len( alltrim( this.Item[lni].CODIGO )) <= 5
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGO ))) + ' Máxima:5), en el detalle ' + this.cEtiqueta + '.' )
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
			
			if vartype( this.Item[lni].JURISDICCION_PK) = 'C'
				if len( alltrim( this.Item[lni].JURISDICCION_PK )) <= 8
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo JURISDICCION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].JURISDICCION_PK ))) + ' Máxima:8), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo JURISDICCION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CODIGOPADRONIIBB) = 'C'
				if len( alltrim( this.Item[lni].CODIGOPADRONIIBB )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGOPADRONIIBB del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGOPADRONIIBB ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGOPADRONIIBB del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].JURISDICCIONDETALLE) = 'C'
				if len( alltrim( this.Item[lni].JURISDICCIONDETALLE )) <= 50
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo JURISDICCIONDETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].JURISDICCIONDETALLE ))) + ' Máxima:50), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo JURISDICCIONDETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].RESOLUCION) = 'C'
				if len( alltrim( this.Item[lni].RESOLUCION )) <= 50
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo RESOLUCION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].RESOLUCION ))) + ' Máxima:50), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo RESOLUCION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PORCENTAJE) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].PORCENTAJE ) ) ) 
				lnValorDelDecimal = this.Item[lni].PORCENTAJE - int( this.Item[lni].PORCENTAJE )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 4
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo PORCENTAJE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:4), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PORCENTAJE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if inlist(vartype( this.Item[lni].FECHAEXPIRACION),'D','T')
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo FECHAEXPIRACION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].EXCLUIDO) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo EXCLUIDO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Jurisdiccion_PK = toItemOrigen.Jurisdiccion_PK
		toItemDestino.Codigopadroniibb = toItemOrigen.Codigopadroniibb
		toItemDestino.Jurisdicciondetalle = toItemOrigen.Jurisdicciondetalle
		toItemDestino.Resolucion = toItemOrigen.Resolucion
		toItemDestino.Porcentaje = toItemOrigen.Porcentaje
		toItemDestino.Fechaexpiracion = toItemOrigen.Fechaexpiracion
		toItemDestino.Excluido = toItemOrigen.Excluido
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
		lcRetorno = 'Jurisdiccion_pk'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Codigo = []
	Nroitem = 0
	Jurisdiccion_PK = []
	Codigopadroniibb = []
	Jurisdicciondetalle = []
	Resolucion = []
	Porcentaje = 0
	Fechaexpiracion = ctod( '  /  /    ' )
	Excluido = .F.
	NroItem = 0

enddefine