
define class Frm_MensajedemoEstilo2 as Mensajedemo of Mensajedemo.vcx
	ColControles = null
	oAspectoAplicacion = null

	icon = 'zooIcon.ico'
	*-----------------------------------------------------------------------------------------
	function oAspectoAplicacion_Access() as Void
		if (type("this.oAspectoAplicacion") <> "O" or isnull(this.oAspectoAplicacion))
			this.oAspectoAplicacion = _screen.zoo.CrearObjetoPorProducto("AspectoAplicacion")
		endif
		Return this.oAspectoAplicacion
	endfunc
	function SeteosVisuales() as boolean
		this.ColControles = newobject('collection')
		this.icon = this.oAspectoAplicacion.ObtenerIconoDeLaAplicacion()

		************* mensajedemo/78d1cp9q2/Form

		with this
			.THEMES = .T.
			.PICTURE = ''

			.HEIGHT = 192
			.LEFT = 233
			.NAME = [mensajedemo]
			.TOP = 301
			.WIDTH = 552
			.WINDOWTYPE = 0

			************* lblMensaje/Lblbase/Label
			if type( '.lblMensaje' ) # 'O'
				.newobject( 'lblMensaje', 'LBLBASE', 'LBLBASE.VCX' )
			endif

			with .lblMensaje


				.VISIBLE = .T.

			endwith


			************* OBOTONERA/Botonera/Container
			if type( '.OBOTONERA' ) # 'O'
				.newobject( 'OBOTONERA', 'BOTONERA', 'BOTONERA.prg', '', 'NO')
			endif

			with .OBOTONERA
				.PICTURE = ''


				.BACKCOLOR = 16777215
				.BACKSTYLE = 1
				.BORDERCOLOR = 0
				.BORDERWIDTH = 0
				.CACCIONB1 = [thisform.click_boton1()]
				.CACCIONB2 = [thisform.click_boton2()]
				.CCAPTIONB1 = [\<Registrar...]
				.CCAPTIONB2 = [\<Aceptar]
				.DISABLEDBACKCOLOR = 0
				.FORECOLOR = 0
				.HEIGHT = 55
				.LHABILITARB1 = .T.
				.LHABILITARB2 = .T.
				.LSEPUEDEORDENAR = .F.
				.NAME = [OBOTONERA]
				.NBACKCOLORCONFOCO = 0
				.NBACKCOLORSINFOCO = 16777215
				.NFORECOLORCONFOCO = 0
				.NFORECOLORSINFOCO = 0
				.OCONTROLESORDENADOS = null
				.SPECIALEFFECT = 0
				.TOP = 137
				.WIDTH = 552
				.VISIBLE = .T.

				************* IMGLOGOIZQUIERDO/Zooimagen/Image
				if type( '.IMGLOGOIZQUIERDO' ) # 'O'
					.newobject( 'IMGLOGOIZQUIERDO', 'ZOOIMAGEN', 'ZOOIMAGEN.prg', '', 'NO')
				endif

				with .IMGLOGOIZQUIERDO
					.THEMES = .F.
					.PICTURE = this.oAspectoAplicacion.ObtenerPieIzquierdoAbm()


					.BACKSTYLE = 0
					.BORDERCOLOR = 16771561
					.BORDERSTYLE = 0
					.CEXPRESIONRUTADINAMICA = [this.oAspectoAplicacion.ObtenerPieIzquierdoAbm()]
					.HEIGHT = 45
					.LEFT = 5
					.NAME = [IMGLOGOIZQUIERDO]
					.NBACKCOLORCONFOCO = 0
					.NFORECOLORCONFOCO = 0
					.TOP = 5
					.WIDTH = 210
					.VISIBLE = .T.

				endwith
				*------------------ Eventos IMGLOGOIZQUIERDO


				************* IMGLOGODERECHO/Zooimagen/Image
				if type( '.IMGLOGODERECHO' ) # 'O'
					.newobject( 'IMGLOGODERECHO', 'ZOOIMAGEN', 'ZOOIMAGEN.prg', '', 'NO')
				endif

				with .IMGLOGODERECHO
					.THEMES = .F.
					.PICTURE = this.oAspectoAplicacion.ObtenerPieDerechoAbm()


					.BACKSTYLE = 0
					.BORDERCOLOR = 16771561
					.BORDERSTYLE = 0
					.CEXPRESIONRUTADINAMICA = [this.oAspectoAplicacion.ObtenerPieDerechoAbm()]
					.HEIGHT = 55
					.LEFT = 365
					.NAME = [IMGLOGODERECHO]
					.NBACKCOLORCONFOCO = 0
					.NFORECOLORCONFOCO = 0
					.TOP = 0
					.WIDTH = 187
					.VISIBLE = .F.

				endwith
				*------------------ Eventos IMGLOGODERECHO


				************* CMDACEPTAR/Botonconfoco/Commandbutton
				if type( '.CMDACEPTAR' ) # 'O'
					.newobject( 'CMDACEPTAR', 'BOTONCONFOCO', 'BOTONCONFOCO.prg', '', 'NO')
				endif

				with .CMDACEPTAR
					.THEMES = .F.
					.DISABLEDPICTURE = ''
					.PICTURE = ''


					.AUTOSIZE = .F.
					.BACKCOLOR = 14999520
					.CAPTION = [\<Registrar...]
					.DISABLEDBACKCOLOR = 14999520
					.DISABLEDFORECOLOR = 10070188
					.FONTBOLD = .F.
					.FONTITALIC = .F.
					.FONTNAME = [TAHOMA]
					.FONTSIZE = 8
					.FORECOLOR = 0
					.HEIGHT = 27
					.LEFT = 354
					.NAME = [CMDACEPTAR]
					.NBACKCOLORCONFOCO = 0
					.NFORECOLORCONFOCO = 0
					.SPECIALEFFECT = 2
					.TOP = 14
					.WIDTH = 85
					.VISIBLE = .T.

				endwith
				*------------------ Eventos CMDACEPTAR


				************* CMDCANCELAR/Botonconfoco/Commandbutton
				if type( '.CMDCANCELAR' ) # 'O'
					.newobject( 'CMDCANCELAR', 'BOTONCONFOCO', 'BOTONCONFOCO.prg', '', 'NO')
				endif

				with .CMDCANCELAR
					.THEMES = .F.
					.DISABLEDPICTURE = ''
					.PICTURE = ''


					.AUTOSIZE = .F.
					.BACKCOLOR = 14999520
					.CANCEL = .T.
					.CAPTION = [\<Aceptar]
					.DISABLEDBACKCOLOR = 14999520
					.DISABLEDFORECOLOR = 10070188
					.FONTBOLD = .F.
					.FONTITALIC = .F.
					.FONTNAME = [TAHOMA]
					.FONTSIZE = 8
					.FORECOLOR = 0
					.HEIGHT = 27
					.LEFT = 453
					.NAME = [CMDCANCELAR]
					.NBACKCOLORCONFOCO = 0
					.NFORECOLORCONFOCO = 0
					.SPECIALEFFECT = 2
					.TABSTOP = .F.
					.TOP = 14
					.WIDTH = 85
					.VISIBLE = .T.

				endwith
				*------------------ Eventos CMDCANCELAR


				************* LNLLINEA/Zoolinea/Line
				if type( '.LNLLINEA' ) # 'O'
					.newobject( 'LNLLINEA', 'ZOOLINEA', 'ZOOLINEA.prg', '', 'NO')
				endif

				with .LNLLINEA


					.BORDERCOLOR = 10485760
					.BORDERSTYLE = 1
					.BORDERWIDTH = 0
					.HEIGHT = 0
					.LEFT = 0
					.NAME = [LNLLINEA]
					.NBACKCOLORCONFOCO = 0
					.NFORECOLORCONFOCO = 0
					.TOP = 0
					.WIDTH = 552
					.VISIBLE = .T.

				endwith
				*------------------ Eventos LNLLINEA


			endwith
			*------------------ Eventos OBOTONERA
			bindevent( .OBOTONERA.cmdAceptar, 'Click', .OBOTONERA, 'Aceptar', 0 ) 
			bindevent( .OBOTONERA.cmdCancelar, 'Click', .OBOTONERA, 'Cancelar', 0 ) 


		endwith


		this.AgregarBarraDeEstado()

		this.MaxButton = .f.
		this.MinButton = .t.
		this.Closable = .t.
		this.ControlBox = .t.
		this.BorderStyle = 0
		this.Showtips = .t.
		this.Autocenter = .t.

	endfunc

	function unload() as Variant
		local lcVar
		lcVar = this.cVariableRetorno 
		&lcVar = dodefault()
		return &lcVar
	endfunc

Enddefine