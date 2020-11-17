<!-- PLATAFORMAS -->
<div id="plataformasMenuBox" class="toolBarMenuBox">
	<div class="box-body">
		<div class="table-responsive">
			<table id="plataformasMenuTable" class="table"
				style="margin-bottom: 0px; width: 100%">
				<tr>
					<td class="layerTable"><img
						src="/resources/img/plataforma.png"
						style="width: 15px; height: 15px;"> &nbsp;<b>Plataformas
							de Petróleo</b></td>
					<td style="width: 5px; padding: 0px;"><a title="Fechar"
						href="#" onClick="cancelPlataformaSolution();"
						class="text-light-blue pull-right"><i
							class="fa fa-close"></i></a></td>
				</tr>
				<tr style="border-bottom: 2px solid #3c8dbc">
					<td class="layerTable" colspan="2"><span
						style="font-size: 11px"><i>Clique em uma
								plataforma para verificar área de segurança.</i></span></td>
				</tr>
				<tr>
					<td class="layerTable">Raio de Segurança (mn)</td>
					<td class="layerTable" style="text-align: right;"><input
						value="0.5" class="pull-right"
						style="text-align: right; height: 17px; width: 50px; font-family: Consolas;"
						id="platSecurityRadius"></td>
				</tr>
			</table>
		</div>
	</div>
</div>



<!-- ROTA -->
<div id="routeMenuBox" class="toolBarMenuBox">
	<div class="box-body">
		<div class="table-responsive">
			<table id="routeMenuTable" class="table"
				style="margin-bottom: 0px; width: 100%">
				<tr>
					<td class="layerTable"><i class="fa fa-automobile"></i>
						&nbsp;<b>Ferramenta de Rota</b></td>
					<td style="width: 5px; padding: 0px;"><a title="Fechar"
						href="#" onClick="closeRouteToolBarMenu();"
						class="text-light-blue pull-right"><i
							class="fa fa-close"></i></a></td>
				</tr>
				<tr style="border-bottom: 2px solid #3c8dbc">
					<td class="layerTable" colspan="2"><span
						style="font-size: 11px"><i>Use o botão direito do
								mouse para abrir as opções.</i></span></td>
				</tr>
				<tr>
					<td class="layerTable">Sugerir Rota Alternativa (mais
						lento)</td>
					<td class="layerTable" style="text-align: right;"><input
						id="allowAlternatives" type="checkbox" class="pull-right"></td>
				</tr>
				<tr>
					<td class="layerTable">Raio do Bloqueio de Rota (metros)</td>
					<td class="layerTable" style="text-align: right;"><input
						value="5" class="pull-right"
						style="text-align: right; height: 17px; width: 50px; font-family: Consolas;"
						id="barrierRadius"></td>
				</tr>
				<tr>
					<td class="layerTable">Bloqueio tem precedência sobre
						Obrigatoriedade</td>
					<td class="layerTable" style="text-align: right;"><input
						id="blockRoutePrecedence" checked type="checkbox"
						class="pull-right"></td>
				</tr>
			</table>
		</div>
	</div>
</div>





<!-- PCN -->
<div id="pcnMenuBox" class="toolBarMenuBox">
	<div class="box-body">
		<div class="table-responsive">
			<table id="pcnMenuTable" class="table"
				style="margin-bottom: 0px; width: 100%">
				<tr>
					<td class="layerTable"><img
						src="/resources/img/pcn.png"
						style="width: 15px; height: 15px;"> &nbsp;<b>Busca por PCN</b></td>
					<td style="width: 5px; padding: 0px;"><a title="Fechar"
						href="#" onClick="closePCNToolBarMenu();"
						class="text-light-blue pull-right"><i
							class="fa fa-close"></i></a></td>
				</tr>
				<tr style="border-bottom: 2px solid #3c8dbc">
					<td class="layerTable" colspan="2"><span
						style="font-size: 11px"><i>Localiza pistas de pouso por critério de PCN.</i></span></td>
				</tr>
				<tr>
					<td class="layerTable">Largura Mínima (m)</td>
					<td class="layerTable" style="text-align: right;">
						<input value="" class="pull-right" style="text-align: right; height: 17px; width: 150px; font-family: Consolas;" id="searchPCNWidth">
					</td>
				</tr>
				<tr>
					<td class="layerTable">Comprimento Mínimo (m)</td>
					<td class="layerTable" style="text-align: right;">
						<input value="" class="pull-right" style="text-align: right; height: 17px; width: 150px; font-family: Consolas;" id="searchPCNLength">
					</td>
				</tr>
				<tr>
					<td class="layerTable">Classe PCN</td>
					<td class="layerTable" style="text-align: right;">
						<input value="" class="pull-right" style="text-align: right; height: 17px; width: 150px; font-family: Consolas;" id="searchPCNClass">
					</td>
				</tr>
				<tr>
					<td class="layerTable">Tipo de Pavimento</td>
					<td class="layerTable" style="text-align: right;">
						<select class="pull-right" style="text-align: right; height: 17px; width: 150px; font-family: Consolas;" id="searchPCNPavement" >
		                    <option value="*" selected>Indiferente</option>
		                    <option value="R">[R] - Rígido</option>
		                    <option value="F">[F] - Flexível</option>
		                </select>											
					</td>
				</tr>
				<tr>
					<td class="layerTable">Resistência</td>
					<td class="layerTable" style="text-align: right;">
						<select class="pull-right" style="text-align: right; height: 17px; width: 150px; font-family: Consolas;" id="searchPCNResistence" >
		                    <option value="*" selected>Indiferente</option>
		                    <option value="A">[A] - Alta</option>
		                    <option value="B">[B] - Média</option>
		                    <option value="C">[C] - Baixa</option>
		                    <option value="D">[D] - Ultrabaixa</option>
		                </select>											
					</td>
				</tr>
				<tr>
					<td class="layerTable">Pressão dos Pneus</td>
					<td class="layerTable" style="text-align: right;">
						<select class="pull-right" style="text-align: right; height: 17px; width: 150px; font-family: Consolas;" id="searchPCNPressure" >
		                    <option value="*" selected>Indiferente</option>
		                    <option value="W">[W] - Alta</option>
		                    <option value="X">[X] - Média</option>
		                    <option value="Y">[Y] - Baixa</option>
		                    <option value="Z">[Z] - Muito Baixa</option>
		                </select>											
					</td>
				</tr>
				<tr>
					<td class="layerTable">Método de Avaliação</td>
					<td class="layerTable" style="text-align: right;">
						<select class="pull-right" style="text-align: right; height: 17px; width: 150px; font-family: Consolas;" id="searchPCNAval" >
		                    <option value="*" selected>Indiferente</option>
		                    <option value="T">[T] - Análise Técnica</option>
		                    <option value="U">[U] - Análise Prática</option>
		                    <option value="O">[O] - Outros</option>
		                </select>											
					</td>
				</tr>
				<tr>
					<td class="layerTable">ICAO (Opcional)</td>
					<td class="layerTable" style="text-align: right;">
						<input value="" class="pull-right" style="text-align: right; height: 17px; width: 150px; font-family: Consolas;" id="searchICAO">
					</td>
				</tr>
				
				
				<tr>
					<td class="layerTable" style="width:50%">
						<button onclick="searchPCNRunwaysBtn();" id="searchPCNRunwaysBtn" type="button" class="btn btn-block btn-primary btn-xs btn-flat">Mapa</button>
					</td>
					<td class="layerTable" style="width:50%">	
						<button onclick="searchPCNRunwaysBtnR();" id="searchPCNRunwaysBtnR" type="button" class="btn btn-block btn-primary btn-xs btn-flat">Relatório</button>
					</td>
				</tr>
				
			</table>
		</div>
	</div>
</div>
						