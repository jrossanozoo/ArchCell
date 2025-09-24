
define class Din_DetalleMODELODEPRODUCCIONModelomaquinas as DetalleBaseproduccion of DetalleBaseproduccion.Prg


	nCantidadItems = 999
	cNombre = 'Modelomaquinas'
	cEtiqueta = 'Maquinarias'
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
				.Codigo = this.Item[ tnItem ].Codigo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Codigo', .Codigo )
			
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.Proceso_PK = this.Item[ tnItem ].Proceso_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Proceso_PK', .Proceso_PK )
			
				.Maquina_PK = this.Item[ tnItem ].Maquina_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Maquina_PK', .Maquina_PK )
			
				.MaquinaDetalle = this.Item[ tnItem ].MaquinaDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'MaquinaDetalle', .MaquinaDetalle )
			
				.TipoMaquinaria = this.Item[ tnItem ].TipoMaquinaria
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TipoMaquinaria', .TipoMaquinaria )
			
				.UnidadDeTiempo = this.Item[ tnItem ].UnidadDeTiempo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'UnidadDeTiempo', .UnidadDeTiempo )
			
				.Tiempo = this.Item[ tnItem ].Tiempo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Tiempo', .Tiempo )
			
				.Desperdicio = this.Item[ tnItem ].Desperdicio
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Desperdicio', .Desperdicio )
			
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
			.Codigo = this.oItem.Codigo
			.NROITEM = this.oItem.NROITEM
			.Proceso_PK = this.oItem.Proceso_PK
			.Maquina_PK = this.oItem.Maquina_PK
			.MaquinaDetalle = this.oItem.MaquinaDetalle
			.TipoMaquinaria = this.oItem.TipoMaquinaria
			.UnidadDeTiempo = this.oItem.UnidadDeTiempo
			.Tiempo = this.oItem.Tiempo
			.Desperdicio = this.oItem.Desperdicio
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
			.Item[ lnItem ].Codigo = .oItem.Codigo
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].Proceso_PK = .oItem.Proceso_PK
			.Item[ lnItem ].Maquina_PK = .oItem.Maquina_PK
			.Item[ lnItem ].MaquinaDetalle = .oItem.MaquinaDetalle
			.Item[ lnItem ].TipoMaquinaria = .oItem.TipoMaquinaria
			.Item[ lnItem ].UnidadDeTiempo = .oItem.UnidadDeTiempo
			.Item[ lnItem ].Tiempo = .oItem.Tiempo
			.Item[ lnItem ].Desperdicio = .oItem.Desperdicio
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'ItemMODELODEPRODUCCIONModelomaquinas' )
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

		select c_Modelomaquinas
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Codigo = c_Modelomaquinas.Codigo
			loItem.NROITEM = c_Modelomaquinas.NROITEM
			loItem.Proceso_PK = c_Modelomaquinas.Proceso
			loItem.Maquina_PK = c_Modelomaquinas.Maquina
			loItem.MaquinaDetalle = c_Modelomaquinas.MaquinaDetalle
			loItem.TipoMaquinaria = c_Modelomaquinas.TipoMaquinaria
			loItem.UnidadDeTiempo = c_Modelomaquinas.UnidadDeTiempo
			loItem.Tiempo = c_Modelomaquinas.Tiempo
			loItem.Desperdicio = c_Modelomaquinas.Desperdicio
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

		if  empty( this.item[ tnItem ].Proceso_PK ) 
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
				if len( alltrim( this.Item[lni].CODIGO )) <= 15
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGO ))) + ' Máxima:15), en el detalle ' + this.cEtiqueta + '.' )
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
			
			if vartype( this.Item[lni].PROCESO_PK) = 'C'
				if len( alltrim( this.Item[lni].PROCESO_PK )) <= 15
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo PROCESO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].PROCESO_PK ))) + ' Máxima:15), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PROCESO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MAQUINA_PK) = 'C'
				if len( alltrim( this.Item[lni].MAQUINA_PK )) <= 15
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo MAQUINA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].MAQUINA_PK ))) + ' Máxima:15), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MAQUINA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MAQUINADETALLE) = 'C'
				if len( alltrim( this.Item[lni].MAQUINADETALLE )) <= 100
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo MAQUINADETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].MAQUINADETALLE ))) + ' Máxima:100), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MAQUINADETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TIPOMAQUINARIA) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].TIPOMAQUINARIA ) ) ) 
				lnValorDelDecimal = this.Item[lni].TIPOMAQUINARIA - int( this.Item[lni].TIPOMAQUINARIA )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo TIPOMAQUINARIA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TIPOMAQUINARIA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].UNIDADDETIEMPO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].UNIDADDETIEMPO ) ) ) 
				lnValorDelDecimal = this.Item[lni].UNIDADDETIEMPO - int( this.Item[lni].UNIDADDETIEMPO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo UNIDADDETIEMPO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo UNIDADDETIEMPO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TIEMPO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].TIEMPO ) ) ) 
				lnValorDelDecimal = this.Item[lni].TIEMPO - int( this.Item[lni].TIEMPO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 4
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo TIEMPO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:4), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TIEMPO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].DESPERDICIO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].DESPERDICIO ) ) ) 
				lnValorDelDecimal = this.Item[lni].DESPERDICIO - int( this.Item[lni].DESPERDICIO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 4
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo DESPERDICIO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:4), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo DESPERDICIO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Proceso_PK = toItemOrigen.Proceso_PK
		toItemDestino.Maquina_PK = toItemOrigen.Maquina_PK
		toItemDestino.Maquinadetalle = toItemOrigen.Maquinadetalle
		toItemDestino.Tipomaquinaria = toItemOrigen.Tipomaquinaria
		toItemDestino.Unidaddetiempo = toItemOrigen.Unidaddetiempo
		toItemDestino.Tiempo = toItemOrigen.Tiempo
		toItemDestino.Desperdicio = toItemOrigen.Desperdicio
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
		lcRetorno = 'Proceso_pk'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Codigo = []
	Nroitem = 0
	Proceso_PK = []
	Maquina_PK = []
	Maquinadetalle = []
	Tipomaquinaria = 0
	Unidaddetiempo = 0
	Tiempo = 0
	Desperdicio = 0
	NroItem = 0

enddefine