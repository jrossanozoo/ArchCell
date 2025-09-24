
define class Din_DetalleVALEDECAMBIOComprobantedetalle as detalle of detalle.prg


	nCantidadItems = 999
	cNombre = 'Comprobantedetalle'
	cEtiqueta = 'Comprobantes afectantes'
	cMensajeErrorUnicidad = 'La columna  no admite valores repetidos.'
	cNombreVisual = '-'

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
			
				.CodigoComprobanteDestino = this.Item[ tnItem ].CodigoComprobanteDestino
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodigoComprobanteDestino', .CodigoComprobanteDestino )
			
				.TipoDeComprobanteDestino = this.Item[ tnItem ].TipoDeComprobanteDestino
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TipoDeComprobanteDestino', .TipoDeComprobanteDestino )
			
				.LetraDestino = this.Item[ tnItem ].LetraDestino
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'LetraDestino', .LetraDestino )
			
				.PuntoDeVentaDestino = this.Item[ tnItem ].PuntoDeVentaDestino
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'PuntoDeVentaDestino', .PuntoDeVentaDestino )
			
				.NumeroDestino = this.Item[ tnItem ].NumeroDestino
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NumeroDestino', .NumeroDestino )
			
				.ComprobanteDestino = this.Item[ tnItem ].ComprobanteDestino
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ComprobanteDestino', .ComprobanteDestino )
			
				.ClienteDestino = this.Item[ tnItem ].ClienteDestino
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ClienteDestino', .ClienteDestino )
			
				.FechaDestino = this.Item[ tnItem ].FechaDestino
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'FechaDestino', .FechaDestino )
			
				.Monto = this.Item[ tnItem ].Monto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Monto', .Monto )
			
				.SerieDestino = this.Item[ tnItem ].SerieDestino
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'SerieDestino', .SerieDestino )
			
				.UsuarioDestino = this.Item[ tnItem ].UsuarioDestino
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'UsuarioDestino', .UsuarioDestino )
			
				.BDDestino = this.Item[ tnItem ].BDDestino
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'BDDestino', .BDDestino )
			
				.SignoDeMovimientoDestino = this.Item[ tnItem ].SignoDeMovimientoDestino
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'SignoDeMovimientoDestino', .SignoDeMovimientoDestino )
			
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
			.CodigoComprobanteDestino = this.oItem.CodigoComprobanteDestino
			.TipoDeComprobanteDestino = this.oItem.TipoDeComprobanteDestino
			.LetraDestino = this.oItem.LetraDestino
			.PuntoDeVentaDestino = this.oItem.PuntoDeVentaDestino
			.NumeroDestino = this.oItem.NumeroDestino
			.ComprobanteDestino = this.oItem.ComprobanteDestino
			.ClienteDestino = this.oItem.ClienteDestino
			.FechaDestino = this.oItem.FechaDestino
			.Monto = this.oItem.Monto
			.SerieDestino = this.oItem.SerieDestino
			.UsuarioDestino = this.oItem.UsuarioDestino
			.BDDestino = this.oItem.BDDestino
			.SignoDeMovimientoDestino = this.oItem.SignoDeMovimientoDestino
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
			.Item[ lnItem ].CodigoComprobanteDestino = .oItem.CodigoComprobanteDestino
			.Item[ lnItem ].TipoDeComprobanteDestino = .oItem.TipoDeComprobanteDestino
			.Item[ lnItem ].LetraDestino = .oItem.LetraDestino
			.Item[ lnItem ].PuntoDeVentaDestino = .oItem.PuntoDeVentaDestino
			.Item[ lnItem ].NumeroDestino = .oItem.NumeroDestino
			.Item[ lnItem ].ComprobanteDestino = .oItem.ComprobanteDestino
			.Item[ lnItem ].ClienteDestino = .oItem.ClienteDestino
			.Item[ lnItem ].FechaDestino = .oItem.FechaDestino
			.Item[ lnItem ].Monto = .oItem.Monto
			.Item[ lnItem ].SerieDestino = .oItem.SerieDestino
			.Item[ lnItem ].UsuarioDestino = .oItem.UsuarioDestino
			.Item[ lnItem ].BDDestino = .oItem.BDDestino
			.Item[ lnItem ].SignoDeMovimientoDestino = .oItem.SignoDeMovimientoDestino
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemVALEDECAMBIOComprobantedetalle' )
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

		select c_Comprobantedetalle
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.NROITEM = c_Comprobantedetalle.NROITEM
			loItem.Codigo = c_Comprobantedetalle.Codigo
			loItem.CodigoComprobanteDestino = c_Comprobantedetalle.CodigoComprobanteDestino
			loItem.TipoDeComprobanteDestino = c_Comprobantedetalle.TipoDeComprobanteDestino
			loItem.LetraDestino = c_Comprobantedetalle.LetraDestino
			loItem.PuntoDeVentaDestino = c_Comprobantedetalle.PuntoDeVentaDestino
			loItem.NumeroDestino = c_Comprobantedetalle.NumeroDestino
			loItem.ComprobanteDestino = c_Comprobantedetalle.ComprobanteDestino
			loItem.ClienteDestino = c_Comprobantedetalle.ClienteDestino
			loItem.FechaDestino = goLibrerias.ObtenerFechaFormateada( c_Comprobantedetalle.FechaDestino )
			loItem.Monto = c_Comprobantedetalle.Monto
			loItem.SerieDestino = c_Comprobantedetalle.SerieDestino
			loItem.UsuarioDestino = c_Comprobantedetalle.UsuarioDestino
			loItem.BDDestino = c_Comprobantedetalle.BDDestino
			loItem.SignoDeMovimientoDestino = c_Comprobantedetalle.SignoDeMovimientoDestino
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

		if  empty( this.item[ tnItem ].Codigo ) 
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
				if len( alltrim( this.Item[lni].CODIGO )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGO ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CODIGOCOMPROBANTEDESTINO) = 'C'
				if len( alltrim( this.Item[lni].CODIGOCOMPROBANTEDESTINO )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGOCOMPROBANTEDESTINO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGOCOMPROBANTEDESTINO ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGOCOMPROBANTEDESTINO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TIPODECOMPROBANTEDESTINO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].TIPODECOMPROBANTEDESTINO ) ) ) 
				lnValorDelDecimal = this.Item[lni].TIPODECOMPROBANTEDESTINO - int( this.Item[lni].TIPODECOMPROBANTEDESTINO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo TIPODECOMPROBANTEDESTINO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TIPODECOMPROBANTEDESTINO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].LETRADESTINO) = 'C'
				if len( alltrim( this.Item[lni].LETRADESTINO )) <= 1
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo LETRADESTINO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].LETRADESTINO ))) + ' Máxima:1), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo LETRADESTINO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PUNTODEVENTADESTINO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].PUNTODEVENTADESTINO ) ) ) 
				lnValorDelDecimal = this.Item[lni].PUNTODEVENTADESTINO - int( this.Item[lni].PUNTODEVENTADESTINO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 4
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo PUNTODEVENTADESTINO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:4), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PUNTODEVENTADESTINO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NUMERODESTINO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].NUMERODESTINO ) ) ) 
				lnValorDelDecimal = this.Item[lni].NUMERODESTINO - int( this.Item[lni].NUMERODESTINO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 8
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo NUMERODESTINO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:8), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NUMERODESTINO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].COMPROBANTEDESTINO) = 'C'
				if len( alltrim( this.Item[lni].COMPROBANTEDESTINO )) <= 50
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo COMPROBANTEDESTINO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].COMPROBANTEDESTINO ))) + ' Máxima:50), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo COMPROBANTEDESTINO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CLIENTEDESTINO) = 'C'
				if len( alltrim( this.Item[lni].CLIENTEDESTINO )) <= 200
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CLIENTEDESTINO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CLIENTEDESTINO ))) + ' Máxima:200), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CLIENTEDESTINO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if inlist(vartype( this.Item[lni].FECHADESTINO),'D','T')
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo FECHADESTINO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTO ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTO - int( this.Item[lni].MONTO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].SERIEDESTINO) = 'C'
				if len( alltrim( this.Item[lni].SERIEDESTINO )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo SERIEDESTINO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].SERIEDESTINO ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo SERIEDESTINO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].USUARIODESTINO) = 'C'
				if len( alltrim( this.Item[lni].USUARIODESTINO )) <= 100
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo USUARIODESTINO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].USUARIODESTINO ))) + ' Máxima:100), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo USUARIODESTINO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].BDDESTINO) = 'C'
				if len( alltrim( this.Item[lni].BDDESTINO )) <= 8
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo BDDESTINO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].BDDESTINO ))) + ' Máxima:8), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo BDDESTINO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].SIGNODEMOVIMIENTODESTINO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].SIGNODEMOVIMIENTODESTINO ) ) ) 
				lnValorDelDecimal = this.Item[lni].SIGNODEMOVIMIENTODESTINO - int( this.Item[lni].SIGNODEMOVIMIENTODESTINO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo SIGNODEMOVIMIENTODESTINO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo SIGNODEMOVIMIENTODESTINO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Codigocomprobantedestino = toItemOrigen.Codigocomprobantedestino
		toItemDestino.Tipodecomprobantedestino = toItemOrigen.Tipodecomprobantedestino
		toItemDestino.Letradestino = toItemOrigen.Letradestino
		toItemDestino.Puntodeventadestino = toItemOrigen.Puntodeventadestino
		toItemDestino.Numerodestino = toItemOrigen.Numerodestino
		toItemDestino.Comprobantedestino = toItemOrigen.Comprobantedestino
		toItemDestino.Clientedestino = toItemOrigen.Clientedestino
		toItemDestino.Fechadestino = toItemOrigen.Fechadestino
		toItemDestino.Monto = toItemOrigen.Monto
		toItemDestino.Seriedestino = toItemOrigen.Seriedestino
		toItemDestino.Usuariodestino = toItemOrigen.Usuariodestino
		toItemDestino.Bddestino = toItemOrigen.Bddestino
		toItemDestino.Signodemovimientodestino = toItemOrigen.Signodemovimientodestino
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
	Codigo = []
	Codigocomprobantedestino = []
	Tipodecomprobantedestino = 0
	Letradestino = []
	Puntodeventadestino = 0
	Numerodestino = 0
	Comprobantedestino = []
	Clientedestino = []
	Fechadestino = ctod( '  /  /    ' )
	Monto = 0
	Seriedestino = []
	Usuariodestino = []
	Bddestino = []
	Signodemovimientodestino = 0
	NroItem = 0

enddefine