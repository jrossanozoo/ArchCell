
define class Din_DetalleCHEQUEHistorialdetalle as detalle of detalle.prg


	nCantidadItems = 999
	cNombre = 'Historialdetalle'
	cEtiqueta = 'Historial de interacciones'
	cMensajeErrorUnicidad = 'La columna  no admite valores repetidos.'
	cNombreVisual = 'Historial de interacciones'

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
			
				.IdentificadorEntidadComprobante = this.Item[ tnItem ].IdentificadorEntidadComprobante
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'IdentificadorEntidadComprobante', .IdentificadorEntidadComprobante )
			
				.CodigoComprobante = this.Item[ tnItem ].CodigoComprobante
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodigoComprobante', .CodigoComprobante )
			
				.Cliente = this.Item[ tnItem ].Cliente
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Cliente', .Cliente )
			
				.ClienteDescripcion = this.Item[ tnItem ].ClienteDescripcion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ClienteDescripcion', .ClienteDescripcion )
			
				.Proveedor = this.Item[ tnItem ].Proveedor
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Proveedor', .Proveedor )
			
				.ProveedorDescripcion = this.Item[ tnItem ].ProveedorDescripcion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ProveedorDescripcion', .ProveedorDescripcion )
			
				.CuentaBancaria_PK = this.Item[ tnItem ].CuentaBancaria_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CuentaBancaria_PK', .CuentaBancaria_PK )
			
				.CuentaBancariaDescripcion = this.Item[ tnItem ].CuentaBancariaDescripcion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CuentaBancariaDescripcion', .CuentaBancariaDescripcion )
			
				.Vendedor = this.Item[ tnItem ].Vendedor
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Vendedor', .Vendedor )
			
				.VendedorDescripcion = this.Item[ tnItem ].VendedorDescripcion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'VendedorDescripcion', .VendedorDescripcion )
			
				.Serie = this.Item[ tnItem ].Serie
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Serie', .Serie )
			
				.Version = this.Item[ tnItem ].Version
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Version', .Version )
			
				.DestinoDeDescarga_PK = this.Item[ tnItem ].DestinoDeDescarga_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'DestinoDeDescarga_PK', .DestinoDeDescarga_PK )
			
				.DestinoDeDescargaDescripcion = this.Item[ tnItem ].DestinoDeDescargaDescripcion
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'DestinoDeDescargaDescripcion', .DestinoDeDescargaDescripcion )
			
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.Fecha = this.Item[ tnItem ].Fecha
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Fecha', .Fecha )
			
				.Hora = this.Item[ tnItem ].Hora
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Hora', .Hora )
			
				.TipoDeComprobante = this.Item[ tnItem ].TipoDeComprobante
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TipoDeComprobante', .TipoDeComprobante )
			
				.Comprobante = this.Item[ tnItem ].Comprobante
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Comprobante', .Comprobante )
			
				.Concepto_PK = this.Item[ tnItem ].Concepto_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Concepto_PK', .Concepto_PK )
			
				.ConceptoDetalle = this.Item[ tnItem ].ConceptoDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ConceptoDetalle', .ConceptoDetalle )
			
				.Tipo = this.Item[ tnItem ].Tipo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Tipo', .Tipo )
			
				.CajaEstado = this.Item[ tnItem ].CajaEstado
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CajaEstado', .CajaEstado )
			
				.CajaEstadoDetalle = this.Item[ tnItem ].CajaEstadoDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CajaEstadoDetalle', .CajaEstadoDetalle )
			
				.BaseDeOrigen = this.Item[ tnItem ].BaseDeOrigen
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'BaseDeOrigen', .BaseDeOrigen )
			
				.Estado = this.Item[ tnItem ].Estado
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Estado', .Estado )
			
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
			.IdentificadorEntidadComprobante = this.oItem.IdentificadorEntidadComprobante
			.CodigoComprobante = this.oItem.CodigoComprobante
			.Cliente = this.oItem.Cliente
			.ClienteDescripcion = this.oItem.ClienteDescripcion
			.Proveedor = this.oItem.Proveedor
			.ProveedorDescripcion = this.oItem.ProveedorDescripcion
			.CuentaBancaria_PK = this.oItem.CuentaBancaria_PK
			.CuentaBancariaDescripcion = this.oItem.CuentaBancariaDescripcion
			.Vendedor = this.oItem.Vendedor
			.VendedorDescripcion = this.oItem.VendedorDescripcion
			.Serie = this.oItem.Serie
			.Version = this.oItem.Version
			.DestinoDeDescarga_PK = this.oItem.DestinoDeDescarga_PK
			.DestinoDeDescargaDescripcion = this.oItem.DestinoDeDescargaDescripcion
			.NROITEM = this.oItem.NROITEM
			.Fecha = this.oItem.Fecha
			.Hora = this.oItem.Hora
			.TipoDeComprobante = this.oItem.TipoDeComprobante
			.Comprobante = this.oItem.Comprobante
			.Concepto_PK = this.oItem.Concepto_PK
			.ConceptoDetalle = this.oItem.ConceptoDetalle
			.Tipo = this.oItem.Tipo
			.CajaEstado = this.oItem.CajaEstado
			.CajaEstadoDetalle = this.oItem.CajaEstadoDetalle
			.BaseDeOrigen = this.oItem.BaseDeOrigen
			.Estado = this.oItem.Estado
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
			.Item[ lnItem ].IdentificadorEntidadComprobante = .oItem.IdentificadorEntidadComprobante
			.Item[ lnItem ].CodigoComprobante = .oItem.CodigoComprobante
			.Item[ lnItem ].Cliente = .oItem.Cliente
			.Item[ lnItem ].ClienteDescripcion = .oItem.ClienteDescripcion
			.Item[ lnItem ].Proveedor = .oItem.Proveedor
			.Item[ lnItem ].ProveedorDescripcion = .oItem.ProveedorDescripcion
			.Item[ lnItem ].CuentaBancaria_PK = .oItem.CuentaBancaria_PK
			.Item[ lnItem ].CuentaBancariaDescripcion = .oItem.CuentaBancariaDescripcion
			.Item[ lnItem ].Vendedor = .oItem.Vendedor
			.Item[ lnItem ].VendedorDescripcion = .oItem.VendedorDescripcion
			.Item[ lnItem ].Serie = .oItem.Serie
			.Item[ lnItem ].Version = .oItem.Version
			.Item[ lnItem ].DestinoDeDescarga_PK = .oItem.DestinoDeDescarga_PK
			.Item[ lnItem ].DestinoDeDescargaDescripcion = .oItem.DestinoDeDescargaDescripcion
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].Fecha = .oItem.Fecha
			.Item[ lnItem ].Hora = .oItem.Hora
			.Item[ lnItem ].TipoDeComprobante = .oItem.TipoDeComprobante
			.Item[ lnItem ].Comprobante = .oItem.Comprobante
			.Item[ lnItem ].Concepto_PK = .oItem.Concepto_PK
			.Item[ lnItem ].ConceptoDetalle = .oItem.ConceptoDetalle
			.Item[ lnItem ].Tipo = .oItem.Tipo
			.Item[ lnItem ].CajaEstado = .oItem.CajaEstado
			.Item[ lnItem ].CajaEstadoDetalle = .oItem.CajaEstadoDetalle
			.Item[ lnItem ].BaseDeOrigen = .oItem.BaseDeOrigen
			.Item[ lnItem ].Estado = .oItem.Estado
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemCHEQUEHistorialdetalle' )
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

		select c_Historialdetalle
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Codigo = c_Historialdetalle.Codigo
			loItem.IdentificadorEntidadComprobante = c_Historialdetalle.IdentificadorEntidadComprobante
			loItem.CodigoComprobante = c_Historialdetalle.CodigoComprobante
			loItem.Cliente = c_Historialdetalle.Cliente
			loItem.ClienteDescripcion = c_Historialdetalle.ClienteDescripcion
			loItem.Proveedor = c_Historialdetalle.Proveedor
			loItem.ProveedorDescripcion = c_Historialdetalle.ProveedorDescripcion
			loItem.CuentaBancaria_PK = c_Historialdetalle.CuentaBancaria
			loItem.CuentaBancariaDescripcion = c_Historialdetalle.CuentaBancariaDescripcion
			loItem.Vendedor = c_Historialdetalle.Vendedor
			loItem.VendedorDescripcion = c_Historialdetalle.VendedorDescripcion
			loItem.Serie = c_Historialdetalle.Serie
			loItem.Version = c_Historialdetalle.Version
			loItem.DestinoDeDescarga_PK = c_Historialdetalle.DestinoDeDescarga
			loItem.DestinoDeDescargaDescripcion = c_Historialdetalle.DestinoDeDescargaDescripcion
			loItem.NROITEM = c_Historialdetalle.NROITEM
			loItem.Fecha = goLibrerias.ObtenerFechaFormateada( c_Historialdetalle.Fecha )
			loItem.Hora = c_Historialdetalle.Hora
			loItem.TipoDeComprobante = c_Historialdetalle.TipoDeComprobante
			loItem.Comprobante = c_Historialdetalle.Comprobante
			loItem.Concepto_PK = c_Historialdetalle.Concepto
			loItem.ConceptoDetalle = c_Historialdetalle.ConceptoDetalle
			loItem.Tipo = c_Historialdetalle.Tipo
			loItem.CajaEstado = c_Historialdetalle.CajaEstado
			loItem.CajaEstadoDetalle = c_Historialdetalle.CajaEstadoDetalle
			loItem.BaseDeOrigen = c_Historialdetalle.BaseDeOrigen
			loItem.Estado = c_Historialdetalle.Estado
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
			
			if vartype( this.Item[lni].IDENTIFICADORENTIDADCOMPROBANTE) = 'C'
				if len( alltrim( this.Item[lni].IDENTIFICADORENTIDADCOMPROBANTE )) <= 3
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo IDENTIFICADORENTIDADCOMPROBANTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].IDENTIFICADORENTIDADCOMPROBANTE ))) + ' Máxima:3), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo IDENTIFICADORENTIDADCOMPROBANTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CODIGOCOMPROBANTE) = 'C'
				if len( alltrim( this.Item[lni].CODIGOCOMPROBANTE )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGOCOMPROBANTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGOCOMPROBANTE ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGOCOMPROBANTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CLIENTE) = 'C'
				if len( alltrim( this.Item[lni].CLIENTE )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CLIENTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CLIENTE ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CLIENTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CLIENTEDESCRIPCION) = 'C'
				if len( alltrim( this.Item[lni].CLIENTEDESCRIPCION )) <= 185
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CLIENTEDESCRIPCION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CLIENTEDESCRIPCION ))) + ' Máxima:185), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CLIENTEDESCRIPCION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PROVEEDOR) = 'C'
				if len( alltrim( this.Item[lni].PROVEEDOR )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo PROVEEDOR del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].PROVEEDOR ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PROVEEDOR del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].PROVEEDORDESCRIPCION) = 'C'
				if len( alltrim( this.Item[lni].PROVEEDORDESCRIPCION )) <= 60
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo PROVEEDORDESCRIPCION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].PROVEEDORDESCRIPCION ))) + ' Máxima:60), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo PROVEEDORDESCRIPCION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CUENTABANCARIA_PK) = 'C'
				if len( alltrim( this.Item[lni].CUENTABANCARIA_PK )) <= 5
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CUENTABANCARIA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CUENTABANCARIA_PK ))) + ' Máxima:5), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CUENTABANCARIA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CUENTABANCARIADESCRIPCION) = 'C'
				if len( alltrim( this.Item[lni].CUENTABANCARIADESCRIPCION )) <= 40
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CUENTABANCARIADESCRIPCION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CUENTABANCARIADESCRIPCION ))) + ' Máxima:40), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CUENTABANCARIADESCRIPCION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].VENDEDOR) = 'C'
				if len( alltrim( this.Item[lni].VENDEDOR )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo VENDEDOR del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].VENDEDOR ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo VENDEDOR del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].VENDEDORDESCRIPCION) = 'C'
				if len( alltrim( this.Item[lni].VENDEDORDESCRIPCION )) <= 60
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo VENDEDORDESCRIPCION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].VENDEDORDESCRIPCION ))) + ' Máxima:60), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo VENDEDORDESCRIPCION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].SERIE) = 'C'
				if len( alltrim( this.Item[lni].SERIE )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo SERIE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].SERIE ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo SERIE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].VERSION) = 'C'
				if len( alltrim( this.Item[lni].VERSION )) <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo VERSION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].VERSION ))) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo VERSION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].DESTINODEDESCARGA_PK) = 'C'
				if len( alltrim( this.Item[lni].DESTINODEDESCARGA_PK )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo DESTINODEDESCARGA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].DESTINODEDESCARGA_PK ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo DESTINODEDESCARGA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].DESTINODEDESCARGADESCRIPCION) = 'C'
				if len( alltrim( this.Item[lni].DESTINODEDESCARGADESCRIPCION )) <= 40
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo DESTINODEDESCARGADESCRIPCION del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].DESTINODEDESCARGADESCRIPCION ))) + ' Máxima:40), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo DESTINODEDESCARGADESCRIPCION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
			
			if inlist(vartype( this.Item[lni].FECHA),'D','T')
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo FECHA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].HORA) = 'C'
				if len( alltrim( this.Item[lni].HORA )) <= 8
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo HORA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].HORA ))) + ' Máxima:8), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo HORA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TIPODECOMPROBANTE) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].TIPODECOMPROBANTE ) ) ) 
				lnValorDelDecimal = this.Item[lni].TIPODECOMPROBANTE - int( this.Item[lni].TIPODECOMPROBANTE )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo TIPODECOMPROBANTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TIPODECOMPROBANTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].COMPROBANTE) = 'C'
				if len( alltrim( this.Item[lni].COMPROBANTE )) <= 25
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo COMPROBANTE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].COMPROBANTE ))) + ' Máxima:25), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo COMPROBANTE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CONCEPTO_PK) = 'C'
				if len( alltrim( this.Item[lni].CONCEPTO_PK )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CONCEPTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CONCEPTO_PK ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CONCEPTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CONCEPTODETALLE) = 'C'
				if len( alltrim( this.Item[lni].CONCEPTODETALLE )) <= 100
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CONCEPTODETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CONCEPTODETALLE ))) + ' Máxima:100), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CONCEPTODETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TIPO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].TIPO ) ) ) 
				lnValorDelDecimal = this.Item[lni].TIPO - int( this.Item[lni].TIPO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 1
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo TIPO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:1), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TIPO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CAJAESTADO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].CAJAESTADO ) ) ) 
				lnValorDelDecimal = this.Item[lni].CAJAESTADO - int( this.Item[lni].CAJAESTADO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo CAJAESTADO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CAJAESTADO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CAJAESTADODETALLE) = 'C'
				if len( alltrim( this.Item[lni].CAJAESTADODETALLE )) <= 40
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CAJAESTADODETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CAJAESTADODETALLE ))) + ' Máxima:40), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CAJAESTADODETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].BASEDEORIGEN) = 'C'
				if len( alltrim( this.Item[lni].BASEDEORIGEN )) <= 8
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo BASEDEORIGEN del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].BASEDEORIGEN ))) + ' Máxima:8), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo BASEDEORIGEN del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ESTADO) = 'C'
				if len( alltrim( this.Item[lni].ESTADO )) <= 5
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo ESTADO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].ESTADO ))) + ' Máxima:5), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ESTADO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Identificadorentidadcomprobante = toItemOrigen.Identificadorentidadcomprobante
		toItemDestino.Codigocomprobante = toItemOrigen.Codigocomprobante
		toItemDestino.Cliente = toItemOrigen.Cliente
		toItemDestino.Clientedescripcion = toItemOrigen.Clientedescripcion
		toItemDestino.Proveedor = toItemOrigen.Proveedor
		toItemDestino.Proveedordescripcion = toItemOrigen.Proveedordescripcion
		toItemDestino.Cuentabancaria_PK = toItemOrigen.Cuentabancaria_PK
		toItemDestino.Cuentabancariadescripcion = toItemOrigen.Cuentabancariadescripcion
		toItemDestino.Vendedor = toItemOrigen.Vendedor
		toItemDestino.Vendedordescripcion = toItemOrigen.Vendedordescripcion
		toItemDestino.Serie = toItemOrigen.Serie
		toItemDestino.Version = toItemOrigen.Version
		toItemDestino.Destinodedescarga_PK = toItemOrigen.Destinodedescarga_PK
		toItemDestino.Destinodedescargadescripcion = toItemOrigen.Destinodedescargadescripcion
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Fecha = toItemOrigen.Fecha
		toItemDestino.Hora = toItemOrigen.Hora
		toItemDestino.Tipodecomprobante = toItemOrigen.Tipodecomprobante
		toItemDestino.Comprobante = toItemOrigen.Comprobante
		toItemDestino.Concepto_PK = toItemOrigen.Concepto_PK
		toItemDestino.Conceptodetalle = toItemOrigen.Conceptodetalle
		toItemDestino.Tipo = toItemOrigen.Tipo
		toItemDestino.Cajaestado = toItemOrigen.Cajaestado
		toItemDestino.Cajaestadodetalle = toItemOrigen.Cajaestadodetalle
		toItemDestino.Basedeorigen = toItemOrigen.Basedeorigen
		toItemDestino.Estado = toItemOrigen.Estado
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

	Codigo = []
	Identificadorentidadcomprobante = []
	Codigocomprobante = []
	Cliente = []
	Clientedescripcion = []
	Proveedor = []
	Proveedordescripcion = []
	Cuentabancaria_PK = []
	Cuentabancariadescripcion = []
	Vendedor = []
	Vendedordescripcion = []
	Serie = []
	Version = []
	Destinodedescarga_PK = []
	Destinodedescargadescripcion = []
	Nroitem = 0
	Fecha = ctod( '  /  /    ' )
	Hora = []
	Tipodecomprobante = 0
	Comprobante = []
	Concepto_PK = []
	Conceptodetalle = []
	Tipo = 0
	Cajaestado = 0
	Cajaestadodetalle = []
	Basedeorigen = []
	Estado = []
	NroItem = 0

enddefine