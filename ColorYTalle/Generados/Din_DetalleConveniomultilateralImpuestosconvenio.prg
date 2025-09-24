
define class Din_DetalleCONVENIOMULTILATERALImpuestosconvenio as detalle of detalle.prg

	Sum_Porcentaje = 0

	cAtributosUnicidad = 'Impuesto_PK'
	nCantidadItems = 999
	cNombre = 'Impuestosconvenio'
	cEtiqueta = 'Impuestos'
	cMensajeErrorUnicidad = 'La columna Impuesto no admite valores repetidos.'
	cNombreVisual = 'Impuestos'

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
			
				.Codigo = this.Item[ tnItem ].Codigo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Codigo', .Codigo )
			
				.Impuesto_PK = this.Item[ tnItem ].Impuesto_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Impuesto_PK', .Impuesto_PK )
			
				.Aplicacion = this.Item[ tnItem ].Aplicacion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Aplicacion', .Aplicacion )
			
				.Tipo_PK = this.Item[ tnItem ].Tipo_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Tipo_PK', .Tipo_PK )
			
				.Jurisdiccion_PK = this.Item[ tnItem ].Jurisdiccion_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Jurisdiccion_PK', .Jurisdiccion_PK )
			
				.JurisdiccionDetalle = this.Item[ tnItem ].JurisdiccionDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'JurisdiccionDetalle', .JurisdiccionDetalle )
			
				.Resolucion = this.Item[ tnItem ].Resolucion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Resolucion', .Resolucion )
			
				.Porcentaje = this.Item[ tnItem ].Porcentaje
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Porcentaje', .Porcentaje )
			
				.Regimen = this.Item[ tnItem ].Regimen
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Regimen', .Regimen )
			
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
			.Codigo = this.oItem.Codigo
			.Impuesto_PK = this.oItem.Impuesto_PK
			.Aplicacion = this.oItem.Aplicacion
			.Tipo_PK = this.oItem.Tipo_PK
			.Jurisdiccion_PK = this.oItem.Jurisdiccion_PK
			.JurisdiccionDetalle = this.oItem.JurisdiccionDetalle
			.Resolucion = this.oItem.Resolucion
			.Porcentaje = this.oItem.Porcentaje
			.Regimen = this.oItem.Regimen
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
			.Item[ lnItem ].Codigo = .oItem.Codigo
			.Item[ lnItem ].Impuesto_PK = .oItem.Impuesto_PK
			.Item[ lnItem ].Aplicacion = .oItem.Aplicacion
			.Item[ lnItem ].Tipo_PK = .oItem.Tipo_PK
			.Item[ lnItem ].Jurisdiccion_PK = .oItem.Jurisdiccion_PK
			.Item[ lnItem ].JurisdiccionDetalle = .oItem.JurisdiccionDetalle
			.Item[ lnItem ].Resolucion = .oItem.Resolucion
			.Item[ lnItem ].Porcentaje = .oItem.Porcentaje
			.Item[ lnItem ].Regimen = .oItem.Regimen
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Sumarizar() as boolean
		local lnItem as integer, loItem as Object, lnSum_Porcentaje as Number

		with this
			lnSum_Porcentaje = 0
			if this.lEsNavegacion
				if select( 'c_Impuestosconvenio' ) > 0 and reccount( 'c_Impuestosconvenio' ) > 0
					sum Porcentaje;
						 to ;
						 lnSum_Porcentaje
				endif
				this.lEsNavegacion = .f.
			else
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							if !empty(.IMPUESTO_PK)
								lnSum_Porcentaje = lnSum_Porcentaje + .Porcentaje
							endif
						endwith
					endif
				endfor

				if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
					loItem = .oItem
					with loItem 
						lnSum_Porcentaje = lnSum_Porcentaje + .Porcentaje
					endwith
				endif
			endif

			if .Sum_Porcentaje != lnSum_Porcentaje
				.Sum_Porcentaje = lnSum_Porcentaje
				.EventoCambioSum_Porcentaje()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoCambioSum_Porcentaje() as boolean
		** Evento que se dispara cuando cambia el sumarizado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalizar( toItem as Object ) as Void
		local lnItem as integer, loItem as Object, lnSum_Porcentaje as Number

		with this
			lnSum_Porcentaje = 0
			if !this.lEsNavegacion
				for lnItem = 1 to this.count
					if .oItem.NroItem = lnItem
					else
						loItem = .Item[ lnItem ]
						with loItem 
							if !empty(.IMPUESTO_PK)
								lnSum_Porcentaje = lnSum_Porcentaje + .Porcentaje
							endif
						endwith
					endif
				endfor

			endif
			if .oItem.ValidarExistenciaCamposFijos() and .oItem.NroItem<=this.count
				loItem = .oItem
				with loItem 
					if !empty(.IMPUESTO_PK)
						lnSum_Porcentaje = lnSum_Porcentaje + .Porcentaje
					endif
				endwith
			endif

			if .Sum_Porcentaje != lnSum_Porcentaje
				.Sum_Porcentaje = lnSum_Porcentaje
				.EventoCambioSum_Porcentaje()
			endif

		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Acumular( tlForzar as Boolean, tcAtributo as String, tnValor as Decimal, tnValorAnt as Decimal ) as Void
		local lnItem as integer, loItem as Object, lnSum_Porcentaje as Number

		do case
		case tnValor = tnValorAnt
		case tcAtributo == 'Porcentaje'
			this.Sum_Porcentaje = this.Sum_Porcentaje - tnValorAnt + tnValor
			this.EventoCambioSum_Porcentaje()

		endcase
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Limpiar() as boolean
		DoDefault()
		this.Sumarizar()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'ItemCONVENIOMULTILATERALImpuestosconvenio' )
			this.enlazar( 'oItem.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oItem.EventoObtenerInformacion', 'inyectarInformacion' )
			this.oItem.inicializar()
			bindevent( this.oItem, 'AcumularSumarizado', this, 'Acumular', 0) 
			bindevent( this.oItem, 'TotalizarSumarizado', this, 'Totalizar', 0) 
			bindevent( this.oItem, 'CambioSumarizado', this, 'Sumarizar', 0) 
			bindevent( this.oItem, 'EventoDespuesDeSetear', this, 'ValidarCantidadDeItemsEnDetalle' )
		endif
		return this.oItem
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Cargar() as Void
		local loItem as object, lnI as integer, lcClave as string, lcFiltro as String 
		lnI = 1

		select c_Impuestosconvenio
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.NROITEM = c_Impuestosconvenio.NROITEM
			loItem.Codigo = c_Impuestosconvenio.Codigo
			loItem.Impuesto_PK = c_Impuestosconvenio.Impuesto
			loItem.Aplicacion = c_Impuestosconvenio.Aplicacion
			loItem.Tipo_PK = c_Impuestosconvenio.Tipo
			loItem.Jurisdiccion_PK = c_Impuestosconvenio.Jurisdiccion
			loItem.JurisdiccionDetalle = c_Impuestosconvenio.JurisdiccionDetalle
			loItem.Resolucion = c_Impuestosconvenio.Resolucion
			loItem.Porcentaje = c_Impuestosconvenio.Porcentaje
			loItem.Regimen = c_Impuestosconvenio.Regimen
			loItem.NroItem = lnI 
			this.AgregarItemPlano( loItem )
			lnI = lnI + 1
		endscan

		this.Sumarizar()

	endfunc


	*--------------------------------------------------------------------------------------------------------
	function ValidarExistenciaCamposFijosItemPlano( tnItem as integer ) as Boolean
		Local llRetorno as boolean
		llRetorno = .t.

		if  empty( this.item[ tnItem ].Impuesto_PK ) 
			llRetorno = .F.
		endif 
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
			
			if vartype( this.Item[lni].CODIGO) = 'C'
				if len( alltrim( this.Item[lni].CODIGO )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGO ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].IMPUESTO_PK) = 'C'
				if len( alltrim( this.Item[lni].IMPUESTO_PK )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo IMPUESTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].IMPUESTO_PK ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo IMPUESTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].APLICACION) = 'C'
				if len( alltrim( this.Item[lni].APLICACION )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo APLICACION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].APLICACION ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo APLICACION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TIPO_PK) = 'C'
				if len( alltrim( this.Item[lni].TIPO_PK )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TIPO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TIPO_PK ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TIPO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
				if len( alltrim( this.Item[lni].RESOLUCION )) <= 60
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo RESOLUCION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].RESOLUCION ))) + ' Máxima:60), en el detalle ' + this.cEtiqueta + '.' )
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
			
			if vartype( this.Item[lni].REGIMEN) = 'C'
				if len( alltrim( this.Item[lni].REGIMEN )) <= 50
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo REGIMEN del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].REGIMEN ))) + ' Máxima:50), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo REGIMEN del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Codigo = toItemOrigen.Codigo
		toItemDestino.Impuesto_PK = toItemOrigen.Impuesto_PK
		toItemDestino.Aplicacion = toItemOrigen.Aplicacion
		toItemDestino.Tipo_PK = toItemOrigen.Tipo_PK
		toItemDestino.Jurisdiccion_PK = toItemOrigen.Jurisdiccion_PK
		toItemDestino.Jurisdicciondetalle = toItemOrigen.Jurisdicciondetalle
		toItemDestino.Resolucion = toItemOrigen.Resolucion
		toItemDestino.Porcentaje = toItemOrigen.Porcentaje
		toItemDestino.Regimen = toItemOrigen.Regimen
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Actualizar( tcClave as String ) as Void
		DoDefault( tcClave )
		this.Sumarizar()
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
		lcRetorno = 'Impuesto_pk'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Nroitem = 0
	Codigo = []
	Impuesto_PK = []
	Aplicacion = []
	Tipo_PK = []
	Jurisdiccion_PK = []
	Jurisdicciondetalle = []
	Resolucion = []
	Porcentaje = 0
	Regimen = []
	NroItem = 0

enddefine