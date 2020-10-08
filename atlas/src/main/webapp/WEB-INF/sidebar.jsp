<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page pageEncoding="UTF-8" %>


<aside class="main-sidebar">

    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">

        <!-- search form -->
        <form method="get" class="sidebar-form" id="sidebar-form" style="">
            <div class="input-group">
                <input type="text" name="q" class="form-control" placeholder="Digite os dados de busca" id="search-input">
                <span class="input-group-btn">
                    <button type="submit" name="search" id="search-btn" class="btn btn-flat">
                        <i class="fa fa-search"></i>
                    </button>
                </span>
            </div>
        </form>
        <!-- /.search form -->

		<div class="panel leftpaneltitle">
			<button id="openCatalogBtn" style="text-align: left;width:85%;float:left" type="button" class="btn btn-primary btn">
				<i style="font-size: 18px;" class="fa fa-plus-circle"></i> &nbsp; Adicionar Camada
			</button>
			<button id="uploadUserDataBtn" style="float:right; width:14%" type="button" class="btn btn-primary btn">
				<i style="font-size: 18px;" class="fa fa-upload"></i>
			</button>
		</div>

		
		<div class="panel leftpaneltitle">
			<button style="text-align: left;" type="button" class="btn btn-block btn-primary btn">
				<i class="fa fa-map-o"></i> &nbsp; Camadas Ativas / Cenário
			</button>
			<div id="activeLayerContainer"  style="padding: 4px; height: 400px; background-color:#f9fafc" class="box-body"></div>
		</div>


    </section>
    <!-- /.sidebar -->
</aside>
