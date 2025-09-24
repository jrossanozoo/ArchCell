
define class Din_DetalleASIENTOTIPOAsientotipodetalle as detalle of detalle.prg


	nCantidadItems = 999
	cNombre = 'Asientotipodetalle'
	cEtiqueta = 'Asientotipodetalle'
	cMensajeErrorUnicidad = 'La columna  no admite valores repetidos.'
	cNombreVisual = ''

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
			
				.HabilitaDebe = this.Item[ tnItem ].HabilitaDebe
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'HabilitaDebe', .HabilitaDebe )
			
				.HabilitaHaber = this.Item[ tnItem ].HabilitaHaber
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'HabilitaHaber', .HabilitaHaber )
			
				.CodigoConcepto = this.Item[ tnItem ].CodigoConcepto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodigoConcepto', .CodigoConcepto )
			
				.Concepto = this.Item[ tnItem ].Concepto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Concepto', .Concepto )
			
				.PlanDeCuentasDebe_PK = this.Item[ tnItem ].PlanDeCuentasDebe_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PlanDeCuentasDebe_PK', .PlanDeCuentasDebe_PK )
			
				.PlanDeCuentasDebeDetalle = this.Item[ tnItem ].PlanDeCuentasDebeDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PlanDeCuentasDebeDetalle', .PlanDeCuentasDebeDetalle )
			
				.PlanDeCuentasHaber_PK = this.Item[ tnItem ].PlanDeCuentasHaber_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PlanDeCuentasHaber_PK', .PlanDeCuentasHaber_PK )
			
				.PlanDeCuentasHaberDetalle = this.Item[ tnItem ].PlanDeCuentasHaberDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PlanDeCuentasHaberDetalle', .PlanDeCuentasHaberDetalle )
			
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
			.HabilitaDebe = this.oItem.HabilitaDebe
			.HabilitaHaber = this.oItem.HabilitaHaber
			.CodigoConcepto = this.oItem.CodigoConcepto
			.Concepto = this.oItem.Concepto
			.PlanDeCuentasDebe_PK = this.oItem.PlanDeCuentasDebe_PK
			.PlanDeCuentasDebeDetalle = this.oItem.PlanDeCuentasDebeDetalle
			.PlanDeCuentasHaber_PK = this.oItem.PlanDeCuentasHaber_PK
			.PlanDeCuentasHaberDetalle = this.oItem.PlanDeCuentasHaberDetalle
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
			.Item[ lnItem ].HabilitaDebe = .oItem.HabilitaDebe
			.Item[ lnItem ].HabilitaHaber = .oItem.HabilitaHaber
			.Item[ lnItem ].CodigoConcepto = .oItem.CodigoConcepto
			.Item[ lnItem ].Concepto = .oItem.Concepto
			.Item[ lnItem ].PlanDeCuentasDebe_PK = .oItem.PlanDeCuentasDebe_PK
			.Item[ lnItem ].PlanDeCuentasDebeDetalle = .oItem.PlanDeCuentasDebeDetalle
			.Item[ lnItem ].PlanDeCuentasHaber_PK = .oItem.PlanDeCuentasHaber_PK
			.Item[ lnItem ].PlanDeCuentasHaberDetalle = .oItem.PlanDeCuentasHaberDetalle
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'ItemASIENTOTIPOAsientotipodetalle' )
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

		select c_Asientotipodetalle
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.NROITEM = c_Asientotipodetalle.NROITEM
			loItem.Codigo = c_Asientotipodetalle.Codigo
			loItem.HabilitaDebe = c_Asientotipodetalle.HabilitaDebe
			loItem.HabilitaHaber = c_Asientotipodetalle.HabilitaHaber
			loItem.CodigoConcepto = c_Asientotipodetalle.CodigoConcepto
			loItem.Concepto = c_Asientotipodetalle.Concepto
			loItem.PlanDeCuentasDebe_PK = c_Asientotipodetalle.PlanDeCuentasDebe
			loItem.PlanDeCuentasDebeDetalle = c_Asientotipodetalle.PlanDeCuentasDebeDetalle
			loItem.PlanDeCuentasHaber_PK = c_Asientotipodetalle.PlanDeCuentasHaber
			loItem.PlanDeCuentasHaberDetalle = c_Asientotipodetalle.PlanDeCuentasHaberDetalle
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

		if  empty( this.item[ tnItem ].Concepto ) 
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
			
			if vartype( this.Item[lni].HABILITADEBE) = 'C'
				if len( alltrim( this.Item[lni].HABILITADEBE )) <= 1
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo HABILITADEBE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].HABILITADEBE ))) + ' Máxima:1), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo HABILITADEBE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].HABILITAHABER) = 'C'
				if len( alltrim( this.Item[lni].HABILITAHABER )) <= 1
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo HABILITAHABER del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].HABILITAHABER ))) + ' Máxima:1), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo HABILITAHABER del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CODIGOCONCEPTO) = 'C'
				if len( alltrim( this.Item[lni].CODIGOCONCEPTO )) <= 15
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGOCONCEPTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGOCONCEPTO ))) + ' Máxima:15), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGOCONCEPTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CONCEPTO) = 'C'
				if len( alltrim( this.Item[lni].CONCEPTO )) <= 23
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CONCEPTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CONCEPTO ))) + ' Máxima:23), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CONCEPTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PLANDECUENTASDEBE_PK) = 'C'
				if len( alltrim( this.Item[lni].PLANDECUENTASDEBE_PK )) <= 30
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo PLANDECUENTASDEBE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].PLANDECUENTASDEBE_PK ))) + ' Máxima:30), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PLANDECUENTASDEBE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PLANDECUENTASDEBEDETALLE) = 'C'
				if len( alltrim( this.Item[lni].PLANDECUENTASDEBEDETALLE )) <= 80
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo PLANDECUENTASDEBEDETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].PLANDECUENTASDEBEDETALLE ))) + ' Máxima:80), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PLANDECUENTASDEBEDETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PLANDECUENTASHABER_PK) = 'C'
				if len( alltrim( this.Item[lni].PLANDECUENTASHABER_PK )) <= 30
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo PLANDECUENTASHABER del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].PLANDECUENTASHABER_PK ))) + ' Máxima:30), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PLANDECUENTASHABER del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PLANDECUENTASHABERDETALLE) = 'C'
				if len( alltrim( this.Item[lni].PLANDECUENTASHABERDETALLE )) <= 90
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo PLANDECUENTASHABERDETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].PLANDECUENTASHABERDETALLE ))) + ' Máxima:90), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PLANDECUENTASHABERDETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Habilitadebe = toItemOrigen.Habilitadebe
		toItemDestino.Habilitahaber = toItemOrigen.Habilitahaber
		toItemDestino.Codigoconcepto = toItemOrigen.Codigoconcepto
		toItemDestino.Concepto = toItemOrigen.Concepto
		toItemDestino.Plandecuentasdebe_PK = toItemOrigen.Plandecuentasdebe_PK
		toItemDestino.Plandecuentasdebedetalle = toItemOrigen.Plandecuentasdebedetalle
		toItemDestino.Plandecuentashaber_PK = toItemOrigen.Plandecuentashaber_PK
		toItemDestino.Plandecuentashaberdetalle = toItemOrigen.Plandecuentashaberdetalle
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
		lcRetorno = 'Concepto'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Nroitem = 0
	Codigo = []
	Habilitadebe = []
	Habilitahaber = []
	Codigoconcepto = []
	Concepto = []
	Plandecuentasdebe_PK = []
	Plandecuentasdebedetalle = []
	Plandecuentashaber_PK = []
	Plandecuentashaberdetalle = []
	NroItem = 0

enddefine