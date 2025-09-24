
define class Frm_VistadecajaEstilo2 as Vistadecaja of Vistadecaja.vcx
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

		************* vistadecaja/78d1cqate/Form

		with this
			.THEMES = .T.
			.PICTURE = ''

			.HEIGHT = 307
			.LEFT = 13
			.NAME = [vistadecaja]
			.TOP = 243
			.WIDTH = 992
			.WINDOWTYPE = 0

			************* grdValores/Grdbase/Grid
			if type( '.grdValores' ) # 'O'
				.newobject( 'grdValores', 'GRDBASE', 'GRDBASE.VCX' )
			endif

			with .grdValores
				.THEMES = .T.


				.VISIBLE = .T.

				************* COLUMN2/Column/Column

				with .COLUMN2


					.FONTNAME = [TAHOMA]
					.FONTSIZE = 8
					.NAME = [COLUMN2]
					.VISIBLE = .T.

					************* Header1/Header/Header
					if type( '.Header1' ) # 'O'
						.newobject( 'Header1', 'HEADER' )
					endif

					with .Header1
						.PICTURE = ''


						.FONTNAME = [TAHOMA]
						.FONTSIZE = 8

					endwith


					************* Text1/Textbox/Textbox
					if type( '.Text1' ) # 'O'
						.newobject( 'Text1', 'TEXTBOX' )
					endif

					with .Text1
						.THEMES = .T.


						.FONTNAME = [TAHOMA]
						.FONTSIZE = 8
						.VISIBLE = .T.

					endwith


				endwith


			endwith


			************* grdTotales/Grdbase/Grid
			if type( '.grdTotales' ) # 'O'
				.newobject( 'grdTotales', 'GRDBASE', 'GRDBASE.VCX' )
			endif

			with .grdTotales
				.THEMES = .T.


				.VISIBLE = .T.

			endwith


			************* lblTotalCaja/Lblbase/Label
			if type( '.lblTotalCaja' ) # 'O'
				.newobject( 'lblTotalCaja', 'LBLBASE', 'LBLBASE.VCX' )
			endif

			with .lblTotalCaja


				.VISIBLE = .T.

			endwith


			************* txtTotalCaja/Txtbox/Textbox
			if type( '.txtTotalCaja' ) # 'O'
				.newobject( 'txtTotalCaja', 'TXTBOX', 'TXTBASE.VCX' )
			endif

			with .txtTotalCaja
				.THEMES = .T.


				.VISIBLE = .T.

			endwith


			************* scrollbar/Olecontrol/Olecontrol
			if type( '.scrollbar' ) # 'O'
				.addObject( 'scrollbar', 'OLECONTROL', 'MSCOMCTL2.FLATSCROLLBAR.2' )
			endif

			with .scrollbar

				.HEIGHT = 20
				.LEFT = 8
				.TOP = 202
				.WIDTH = 959
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
				.CCAPTIONB1 = [Salir]
				.CCAPTIONB2 = [Cancelar]
				.DISABLEDBACKCOLOR = 0
				.FORECOLOR = 0
				.HEIGHT = 55
				.LHABILITARB1 = .T.
				.LHABILITARB2 = .F.
				.LSEPUEDEORDENAR = .F.
				.NAME = [OBOTONERA]
				.NBACKCOLORCONFOCO = 0
				.NBACKCOLORSINFOCO = 16777215
				.NFORECOLORCONFOCO = 0
				.NFORECOLORSINFOCO = 0
				.OCONTROLESORDENADOS = null
				.SPECIALEFFECT = 0
				.TOP = 252
				.WIDTH = 992
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
					.LEFT = 805
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
					.CAPTION = [Salir]
					.DISABLEDBACKCOLOR = 14999520
					.DISABLEDFORECOLOR = 10070188
					.FONTBOLD = .F.
					.FONTITALIC = .F.
					.FONTNAME = [TAHOMA]
					.FONTSIZE = 8
					.FORECOLOR = 0
					.HEIGHT = 27
					.LEFT = 919
					.NAME = [CMDACEPTAR]
					.NBACKCOLORCONFOCO = 0
					.NFORECOLORCONFOCO = 0
					.SPECIALEFFECT = 2
					.TOP = 14
					.WIDTH = 59
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
					.CAPTION = [Cancelar]
					.DISABLEDBACKCOLOR = 14999520
					.DISABLEDFORECOLOR = 10070188
					.FONTBOLD = .F.
					.FONTITALIC = .F.
					.FONTNAME = [TAHOMA]
					.FONTSIZE = 8
					.FORECOLOR = 0
					.HEIGHT = 27
					.LEFT = 919
					.NAME = [CMDCANCELAR]
					.NBACKCOLORCONFOCO = 0
					.NFORECOLORCONFOCO = 0
					.SPECIALEFFECT = 2
					.TABSTOP = .F.
					.TOP = 14
					.WIDTH = 59
					.VISIBLE = .F.

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
					.WIDTH = 992
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