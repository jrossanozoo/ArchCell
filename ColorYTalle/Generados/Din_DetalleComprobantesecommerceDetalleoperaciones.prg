
define class Din_DetalleCOMPROBANTESECOMMERCEDetalleoperaciones as detalle of detalle.prg


	nCantidadItems = 999
	cNombre = 'Detalleoperaciones'
	cEtiqueta = 'Detalle comprobantes'
	cMensajeErrorUnicidad = 'La columna  no admite valores repetidos.'
	cNombreVisual = 'Operaciones'

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
				.Numero = this.Item[ tnItem ].Numero
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Numero', .Numero )
			
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.NumeroOperacion = this.Item[ tnItem ].NumeroOperacion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NumeroOperacion', .NumeroOperacion )
			
				.Cantidad = this.Item[ tnItem ].Cantidad
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Cantidad', .Cantidad )
			
				.Monto = this.Item[ tnItem ].Monto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Monto', .Monto )
			
				.Cliente_PK = this.Item[ tnItem ].Cliente_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Cliente_PK', .Cliente_PK )
			
				.ClienteDescripcion = this.Item[ tnItem ].ClienteDescripcion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ClienteDescripcion', .ClienteDescripcion )
			
				.ClienteDragon_PK = this.Item[ tnItem ].ClienteDragon_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ClienteDragon_PK', .ClienteDragon_PK )
			
				.Envio = this.Item[ tnItem ].Envio
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Envio', .Envio )
			
				.FullEnvios = this.Item[ tnItem ].FullEnvios
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'FullEnvios', .FullEnvios )
			
				.Cancelada = this.Item[ tnItem ].Cancelada
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Cancelada', .Cancelada )
			
				.TipoComprobante = this.Item[ tnItem ].TipoComprobante
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TipoComprobante', .TipoComprobante )
			
				.ClienteNombre = this.Item[ tnItem ].ClienteNombre
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ClienteNombre', .ClienteNombre )
			
				.Operacion_PK = this.Item[ tnItem ].Operacion_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Operacion_PK', .Operacion_PK )
			
				.Pagado = this.Item[ tnItem ].Pagado
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Pagado', .Pagado )
			
				.FaltaArt = this.Item[ tnItem ].FaltaArt
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'FaltaArt', .FaltaArt )
			
				.Buzon = this.Item[ tnItem ].Buzon
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Buzon', .Buzon )
			
				.Plataforma = this.Item[ tnItem ].Plataforma
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Plataforma', .Plataforma )
			
				.BaseDeDatos = this.Item[ tnItem ].BaseDeDatos
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'BaseDeDatos', .BaseDeDatos )
			
				.NumeroComprobante = this.Item[ tnItem ].NumeroComprobante
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NumeroComprobante', .NumeroComprobante )
			
				.UtilizaStockOtraBase = this.Item[ tnItem ].UtilizaStockOtraBase
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'UtilizaStockOtraBase', .UtilizaStockOtraBase )
			
				.BDOrigenStock = this.Item[ tnItem ].BDOrigenStock
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'BDOrigenStock', .BDOrigenStock )
			
				.CbteTentativoParaCancelacion = this.Item[ tnItem ].CbteTentativoParaCancelacion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CbteTentativoParaCancelacion', .CbteTentativoParaCancelacion )
			
				.ComprobanteAfectado = this.Item[ tnItem ].ComprobanteAfectado
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ComprobanteAfectado', .ComprobanteAfectado )
			
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
			.Numero = this.oItem.Numero
			.NROITEM = this.oItem.NROITEM
			.NumeroOperacion = this.oItem.NumeroOperacion
			.Cantidad = this.oItem.Cantidad
			.Monto = this.oItem.Monto
			.Cliente_PK = this.oItem.Cliente_PK
			.ClienteDescripcion = this.oItem.ClienteDescripcion
			.ClienteDragon_PK = this.oItem.ClienteDragon_PK
			.Envio = this.oItem.Envio
			.FullEnvios = this.oItem.FullEnvios
			.Cancelada = this.oItem.Cancelada
			.TipoComprobante = this.oItem.TipoComprobante
			.ClienteNombre = this.oItem.ClienteNombre
			.Operacion_PK = this.oItem.Operacion_PK
			.Pagado = this.oItem.Pagado
			.FaltaArt = this.oItem.FaltaArt
			.Buzon = this.oItem.Buzon
			.Plataforma = this.oItem.Plataforma
			.BaseDeDatos = this.oItem.BaseDeDatos
			.NumeroComprobante = this.oItem.NumeroComprobante
			.UtilizaStockOtraBase = this.oItem.UtilizaStockOtraBase
			.BDOrigenStock = this.oItem.BDOrigenStock
			.CbteTentativoParaCancelacion = this.oItem.CbteTentativoParaCancelacion
			.ComprobanteAfectado = this.oItem.ComprobanteAfectado
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
			.Item[ lnItem ].Numero = .oItem.Numero
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].NumeroOperacion = .oItem.NumeroOperacion
			.Item[ lnItem ].Cantidad = .oItem.Cantidad
			.Item[ lnItem ].Monto = .oItem.Monto
			.Item[ lnItem ].Cliente_PK = .oItem.Cliente_PK
			.Item[ lnItem ].ClienteDescripcion = .oItem.ClienteDescripcion
			.Item[ lnItem ].ClienteDragon_PK = .oItem.ClienteDragon_PK
			.Item[ lnItem ].Envio = .oItem.Envio
			.Item[ lnItem ].FullEnvios = .oItem.FullEnvios
			.Item[ lnItem ].Cancelada = .oItem.Cancelada
			.Item[ lnItem ].TipoComprobante = .oItem.TipoComprobante
			.Item[ lnItem ].ClienteNombre = .oItem.ClienteNombre
			.Item[ lnItem ].Operacion_PK = .oItem.Operacion_PK
			.Item[ lnItem ].Pagado = .oItem.Pagado
			.Item[ lnItem ].FaltaArt = .oItem.FaltaArt
			.Item[ lnItem ].Buzon = .oItem.Buzon
			.Item[ lnItem ].Plataforma = .oItem.Plataforma
			.Item[ lnItem ].BaseDeDatos = .oItem.BaseDeDatos
			.Item[ lnItem ].NumeroComprobante = .oItem.NumeroComprobante
			.Item[ lnItem ].UtilizaStockOtraBase = .oItem.UtilizaStockOtraBase
			.Item[ lnItem ].BDOrigenStock = .oItem.BDOrigenStock
			.Item[ lnItem ].CbteTentativoParaCancelacion = .oItem.CbteTentativoParaCancelacion
			.Item[ lnItem ].ComprobanteAfectado = .oItem.ComprobanteAfectado
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'ItemCOMPROBANTESECOMMERCEDetalleoperaciones' )
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

		select c_Detalleoperaciones
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Numero = c_Detalleoperaciones.Numero
			loItem.NROITEM = c_Detalleoperaciones.NROITEM
			loItem.NumeroOperacion = c_Detalleoperaciones.NumeroOperacion
			loItem.Cantidad = c_Detalleoperaciones.Cantidad
			loItem.Monto = c_Detalleoperaciones.Monto
			loItem.Cliente_PK = c_Detalleoperaciones.Cliente
			loItem.ClienteDescripcion = c_Detalleoperaciones.ClienteDescripcion
			loItem.ClienteDragon_PK = c_Detalleoperaciones.ClienteDragon
			loItem.Envio = c_Detalleoperaciones.Envio
			loItem.FullEnvios = c_Detalleoperaciones.FullEnvios
			loItem.Cancelada = c_Detalleoperaciones.Cancelada
			loItem.TipoComprobante = c_Detalleoperaciones.TipoComprobante
			loItem.ClienteNombre = c_Detalleoperaciones.ClienteNombre
			loItem.Operacion_PK = c_Detalleoperaciones.Operacion
			loItem.Pagado = c_Detalleoperaciones.Pagado
			loItem.Buzon = c_Detalleoperaciones.Buzon
			loItem.Plataforma = c_Detalleoperaciones.Plataforma
			loItem.BaseDeDatos = c_Detalleoperaciones.BaseDeDatos
			loItem.NumeroComprobante = c_Detalleoperaciones.NumeroComprobante
			loItem.UtilizaStockOtraBase = c_Detalleoperaciones.UtilizaStockOtraBase
			loItem.BDOrigenStock = c_Detalleoperaciones.BDOrigenStock
			loItem.ComprobanteAfectado = c_Detalleoperaciones.ComprobanteAfectado
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

		if  empty( this.item[ tnItem ].Numerooperacion ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc


	*-----------------------------------------------------------------------------------------
	Function ValidarFormatoAtributos() as boolean
	local lnLargoEntero as integer, lnValorDelDecimal as integer, lnLargoDecimal as integer, llRetorno as boolean, lnI as Integer

		llRetorno = dodefault()
		for lni = 1 to this.Count
			
			if vartype( this.Item[lni].NUMERO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].NUMERO ) ) ) 
				lnValorDelDecimal = this.Item[lni].NUMERO - int( this.Item[lni].NUMERO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo NUMERO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NUMERO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].NUMEROOPERACION) = 'C'
				if len( alltrim( this.Item[lni].NUMEROOPERACION )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo NUMEROOPERACION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].NUMEROOPERACION ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NUMEROOPERACION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CANTIDAD) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].CANTIDAD ) ) ) 
				lnValorDelDecimal = this.Item[lni].CANTIDAD - int( this.Item[lni].CANTIDAD )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 8
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo CANTIDAD del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:8), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CANTIDAD del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if vartype( this.Item[lni].CLIENTE_PK) = 'C'
				if len( alltrim( this.Item[lni].CLIENTE_PK )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CLIENTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CLIENTE_PK ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CLIENTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CLIENTEDESCRIPCION) = 'C'
				if len( alltrim( this.Item[lni].CLIENTEDESCRIPCION )) <= 40
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CLIENTEDESCRIPCION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CLIENTEDESCRIPCION ))) + ' Máxima:40), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CLIENTEDESCRIPCION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CLIENTEDRAGON_PK) = 'C'
				if len( alltrim( this.Item[lni].CLIENTEDRAGON_PK )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CLIENTEDRAGON del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CLIENTEDRAGON_PK ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CLIENTEDRAGON del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ENVIO) = 'C'
				if len( alltrim( this.Item[lni].ENVIO )) <= 100
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo ENVIO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].ENVIO ))) + ' Máxima:100), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ENVIO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].FULLENVIOS) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo FULLENVIOS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CANCELADA) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CANCELADA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TIPOCOMPROBANTE) = 'C'
				if len( alltrim( this.Item[lni].TIPOCOMPROBANTE )) <= 30
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo TIPOCOMPROBANTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].TIPOCOMPROBANTE ))) + ' Máxima:30), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TIPOCOMPROBANTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CLIENTENOMBRE) = 'C'
				if len( alltrim( this.Item[lni].CLIENTENOMBRE )) <= 50
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CLIENTENOMBRE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CLIENTENOMBRE ))) + ' Máxima:50), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CLIENTENOMBRE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].OPERACION_PK) = 'C'
				if len( alltrim( this.Item[lni].OPERACION_PK )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo OPERACION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].OPERACION_PK ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo OPERACION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PAGADO) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PAGADO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].BUZON) = 'C'
				if len( alltrim( this.Item[lni].BUZON )) <= 30
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo BUZON del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].BUZON ))) + ' Máxima:30), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo BUZON del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PLATAFORMA) = 'C'
				if len( alltrim( this.Item[lni].PLATAFORMA )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo PLATAFORMA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].PLATAFORMA ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PLATAFORMA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].BASEDEDATOS) = 'C'
				if len( alltrim( this.Item[lni].BASEDEDATOS )) <= 50
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo BASEDEDATOS del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].BASEDEDATOS ))) + ' Máxima:50), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo BASEDEDATOS del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NUMEROCOMPROBANTE) = 'C'
				if len( alltrim( this.Item[lni].NUMEROCOMPROBANTE )) <= 30
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo NUMEROCOMPROBANTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].NUMEROCOMPROBANTE ))) + ' Máxima:30), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NUMEROCOMPROBANTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].UTILIZASTOCKOTRABASE) = 'L'
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo UTILIZASTOCKOTRABASE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].BDORIGENSTOCK) = 'C'
				if len( alltrim( this.Item[lni].BDORIGENSTOCK )) <= 11
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo BDORIGENSTOCK del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].BDORIGENSTOCK ))) + ' Máxima:11), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo BDORIGENSTOCK del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].COMPROBANTEAFECTADO) = 'C'
				if len( alltrim( this.Item[lni].COMPROBANTEAFECTADO )) <= 100
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo COMPROBANTEAFECTADO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].COMPROBANTEAFECTADO ))) + ' Máxima:100), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo COMPROBANTEAFECTADO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Numero = toItemOrigen.Numero
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Numerooperacion = toItemOrigen.Numerooperacion
		toItemDestino.Cantidad = toItemOrigen.Cantidad
		toItemDestino.Monto = toItemOrigen.Monto
		toItemDestino.Cliente_PK = toItemOrigen.Cliente_PK
		toItemDestino.Clientedescripcion = toItemOrigen.Clientedescripcion
		toItemDestino.Clientedragon_PK = toItemOrigen.Clientedragon_PK
		toItemDestino.Envio = toItemOrigen.Envio
		toItemDestino.Fullenvios = toItemOrigen.Fullenvios
		toItemDestino.Cancelada = toItemOrigen.Cancelada
		toItemDestino.Tipocomprobante = toItemOrigen.Tipocomprobante
		toItemDestino.Clientenombre = toItemOrigen.Clientenombre
		toItemDestino.Operacion_PK = toItemOrigen.Operacion_PK
		toItemDestino.Pagado = toItemOrigen.Pagado
		toItemDestino.Faltaart = toItemOrigen.Faltaart
		toItemDestino.Buzon = toItemOrigen.Buzon
		toItemDestino.Plataforma = toItemOrigen.Plataforma
		toItemDestino.Basededatos = toItemOrigen.Basededatos
		toItemDestino.Numerocomprobante = toItemOrigen.Numerocomprobante
		toItemDestino.Utilizastockotrabase = toItemOrigen.Utilizastockotrabase
		toItemDestino.Bdorigenstock = toItemOrigen.Bdorigenstock
		toItemDestino.Cbtetentativoparacancelacion = toItemOrigen.Cbtetentativoparacancelacion
		toItemDestino.Comprobanteafectado = toItemOrigen.Comprobanteafectado
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
		lcRetorno = 'NumeroOperacion'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Numero = 0
	Nroitem = 0
	Numerooperacion = []
	Cantidad = 0
	Monto = 0
	Cliente_PK = []
	Clientedescripcion = []
	Clientedragon_PK = []
	Envio = []
	Fullenvios = .F.
	Cancelada = .F.
	Tipocomprobante = []
	Clientenombre = []
	Operacion_PK = []
	Pagado = .F.
	Faltaart = .F.
	Buzon = []
	Plataforma = []
	Basededatos = []
	Numerocomprobante = []
	Utilizastockotrabase = .F.
	Bdorigenstock = []
	Cbtetentativoparacancelacion = []
	Comprobanteafectado = []
	NroItem = 0

enddefine