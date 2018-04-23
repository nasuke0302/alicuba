<%-- 
    Document   : estudio
    Created on : 10-abr-2018, 17:14:59
    Author     : Tesis
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html data-ng-app="AppEstudio">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--GLOBAL STYLES AND TITLE-->
        <jsp:include page="/WEB-INF/includes/globalcss.jsp"/>
        <!--END GLOBAL STYLES-->

        <!--PAGE LEVEL STYLES-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/AngularJs/uiSelect/select.min.css">
        <!--END PAGE LEVEL STYLES-->

        <!--PAGE LEVEL SCRIPTS-->
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/uiSelect/select.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/Estudio.js"></script>
        <!--END PAGE LEVEL SCRIPTS-->
    </head>

    <body class="padTop53" data-ng-controller="EstudioController">
        <!-- MAIN WRAPPER -->
        <div id="wrap">
            <!-- HEADER SECTION -->
            <jsp:include page="/WEB-INF/includes/header.jsp"/>
            <!-- END HEADER SECTION -->
            <!-- MENU SECTION -->
            <jsp:include page="/WEB-INF/includes/menuContent.jsp"/>
            <!--END MENU SECTION -->
            <!--PAGE CONTENT -->
            <div id="content">
                <div class="inner" style="min-height:1200px;">                
                    <div class="row">
                        <div class="col-lg-12">
                            <h4 class="page-header">ESTUDIO DE LA REFERENCIA</h4>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="panel panel-primary">
                                <div class="panel-heading">Alimento de la Referencia</div>
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <em id="pAutores" data-ng-repeat="autor in lastReferencia.autoresList">
                                                {{autor.apellidos| limitTo: 1}}. {{autor.nombre}},
                                            </em>
                                            <em> ({{lastReferencia.fecha}}). {{lastReferencia.title}}. 
                                                2. {{lastReferencia.nota}}. <em style="text-transform: capitalize">{{lastReferencia.lugar}}. </em>
                                                {{lastReferencia.idFuente.nombreFuente}}.  
                                                {{lastReferencia.pages}}.</em>
                                            <p>                                    
                                                URL: <a href="{{lastReferencia.url}}">{{lastReferencia.url}}</a>
                                            </p>
                                            <p>
                                                Categor&iacute;a (s):<em data-ng-repeat="categoria in lastReferencia.categoriaList">{{categoria.categoria}} </em>
                                            </p>
                                            <div class="form-group">
                                                <h4>Seleccione un alimento:</h4>
                                                <ui-select data-ng-model="selectedAlimento.selected" 
                                                           theme="bootstrap">
                                                    <ui-select-match placeholder="Elija un alimento...">
                                                        {{$select.selected.nombre}}
                                                    </ui-select-match>
                                                    <ui-select-choices repeat="a in allAlimentos | filter: $select.search">
                                                        {{a.nombre}}
                                                        <small>
                                                            <strong>Nombre Cientifico: </strong> {{a.nombreCient}}
                                                            <strong>Variedad: </strong> {{a.variedad}}
                                                            <strong>Parte: </strong> {{a.parte}}
                                                            <strong>Proceso: </strong> {{a.proceso}}
                                                            <strong>Mezcla: </strong> {{a.mezcla}}
                                                        </small>
                                                    </ui-select-choices>
                                                </ui-select> 
                                                <button class="btn btn-success" data-ng-click="abrirNuevoAlimentoModal()"
                                                        data-toggle="modal" data-target="#modalNuevoAlimento">
                                                    <span class="glyphicon glyphicon-plus"></span>Nuevo Alimento</button>
                                            </div>
                                            <h4>
                                                <strong>Alimento:</strong> 
                                                <div data-ng-show="selectedAlimento.selected" class="tooltip-demo">
                                                    <em data-toggle="tooltip" data-placement="top" title="Nombre cient&iacute;fico">{{selectedAlimento.selected.nombreCient}}</em>,
                                                    <em data-toggle="tooltip" data-placement="top" title="Nombre com&uacute;n">{{selectedAlimento.selected.nombre}}</em>,
                                                    <em data-toggle="tooltip" data-placement="top" title="Variedad">{{selectedAlimento.selected.variedad}}</em>,
                                                    <em data-toggle="tooltip" data-placement="top" title="Parte">{{selectedAlimento.selected.parte}}</em>.
                                                    <em data-toggle="tooltip" data-placement="top" title="Proceso">{{selectedAlimento.selected.proceso}}</em>.
                                                    <em data-toggle="tooltip" data-placement="top" title="Mezcla">{{selectedAlimento.selected.mezcla}}</em>.
                                                    <em data-toggle="tooltip" data-placement="top" title="Clasificaci&oacute;n en Cuba">{{selectedAlimento.selected.idTipoCuba.tipoCuba}}</em>.
                                                    <em data-toggle="tooltip" data-placement="top" title="Clasificaci&oacute;n en la FAO">{{selectedAlimento.selected.idTipoFao.tipoFao}}</em>.
                                                    <em data-toggle="tooltip" data-placement="top" title="Clasificaci&oacute;n en NRC">{{selectedAlimento.selected.idTipoNrc.tipoNrc}}</em>.
                                                </div>
                                            </h4>
                                        </div>    
                                    </div>
                                    <form role="form" method="POST" data-ng-submit="addEstudio()">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <div class="box dark">
                                                    <header>
                                                        <div class="icons"><i class="icon-edit"></i></div>
                                                        <h5><a class="accordion-toggle minimize-box" data-toggle="collapse" href="#div-1">Metadatos</a></h5>
                                                        <div class="toolbar">
                                                            <ul class="nav"> 
                                                                <li>
                                                                    <a class="accordion-toggle minimize-box" data-toggle="collapse" href="#div-1">
                                                                        <i class="icon-chevron-up"></i>
                                                                    </a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </header>
                                                    <div id="div-1" class="accordion-body collapse in body">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Riego</span>
                                                            <input type="number" class="form-control" data-ng-model="estudio.riego" />                                                  
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">N</span>
                                                            <input type="number" class="form-control" data-ng-model="estudio.n"/>                                                  
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">N-P-K</span>
                                                            <input type="text" class="form-control" data-ng-model="estudio.npk"/>                                                  
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Edad</span>
                                                            <input type="number" class="form-control" data-ng-model="estudio.edad"/>                                                  
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Corte</span>
                                                            <input type="text" class="form-control" data-ng-model="estudio.corte">                                                  
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Tecnolog&iacute;a</span>
                                                            <input type="text" class="form-control" data-ng-model="estudio.tecnolog">                                                  
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Tratamiento</span>
                                                            <input type="text" class="form-control" data-ng-model="estudio.tratamiento"/>                                                  
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Presentaci&oacute;n</span>
                                                            <input type="text" class="form-control" data-ng-model="estudio.presentation">                                                  
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Otras Caracter&iacute;sticas</span>
                                                            <input type="text" class="form-control" data-ng-model="estudio.otrasCaract">                                                  
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Calidad</span>
                                                            <select class="form-control" data-ng-options="calidad.idCalidad as calidad.calidad for calidad in allCalidades" 
                                                                    data-ng-model="selectedCalidad" required="">
                                                            </select>
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">&Eacute;poca</span>
                                                            <select class="form-control" data-ng-options="epoca.idEpoca as epoca.nombre for epoca in allEpocas" 
                                                                    data-ng-model="selectedEpoca" required="">
                                                            </select>
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Fertilizado</span>
                                                            <select class="form-control" data-ng-options="fer.idFertilizado as fer.fertilizado for fer in allFertilizado" 
                                                                    data-ng-model="selectedFertilizado" required="">
                                                            </select>
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Mes de Inicio</span>
                                                            <select class="form-control" data-ng-options="m.idMes as m.mes for m in allMeses" 
                                                                    data-ng-model="selectedMesIni" required="">
                                                            </select>
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Mes de Finalizaci&oacute;n</span>
                                                            <select class="form-control" data-ng-options="m.idMes as m.mes for m in allMeses" 
                                                                    data-ng-model="selectedMesFin" required="">
                                                            </select>
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Nivel de Fertilizaci&oacute;n</span>
                                                            <select class="form-control" data-ng-options="nivelFert.idNivelFert as nivelFert.nivel for nivelFert in allNivelFert" 
                                                                    data-ng-model="selectedNivelFert" required="">
                                                            </select>
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Pa&iacute;s de importaci&oacute;n</span>
                                                            <ui-select data-ng-model="selectedPais.selected" 
                                                                       theme="bootstrap">
                                                                <ui-select-match placeholder="Elija un pa&iacute;s...">
                                                                    {{$select.selected.pais}}
                                                                </ui-select-match>
                                                                <ui-select-choices repeat="a in allPaises| filter: $select.search">
                                                                    {{a.pais}}
                                                                    <small> &LT;{{a.alpha2}}&GT;</small>
                                                                </ui-select-choices>
                                                            </ui-select>  
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Provincia</span>
                                                            <select class="form-control" data-ng-options="prov.idProvincia as prov.provinciaNombre for prov in allProvincias" 
                                                                    data-ng-model="selectedProvincia" required="">
                                                            </select>
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Rango de Edades</span>
                                                            <select class="form-control" data-ng-options="ranEd.idRangoEdades as ranEd.rango for ranEd in allRangoEdades" 
                                                                    data-ng-model="selectedRangoEdad" required="">
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div>
                                                <h4> Seleccione un Tipo de Datos</h4>
                                                <ui-select data-ng-model="selectedTDA.selected" 
                                                           theme="bootstrap">
                                                    <ui-select-match placeholder="Elija un Tipo de Datos...">
                                                        {{$select.selected.nombreTipoDato}}
                                                    </ui-select-match>
                                                    <ui-select-choices repeat="a in allTipoDatosAlimentos| filter: $select.search">
                                                        {{a.nombreTipoDato}}
                                                    </ui-select-choices>
                                                </ui-select> 
                                            </div>
                                            <div data-ng-repeat="nut in allNutrientes">
                                                <div data-ng-show="nut.abreviatura==='zzzzzzz'">{{tablaCnaGeneral.idNutriente = nut}}</div>
                                                <div data-ng-show="selectedTDA.selected.idTiposDatosAlimentos === nut.idTiposDatosAlimentos.idTiposDatosAlimentos"
                                                     class="input-group tooltip-demo">
                                                    <span class="input-group-addon" data-toggle="tooltip" data-placement="left" title="{{nut.nombre}}">{{nut.abreviatura}}</span>
                                                    <input type="text" class="form-control" data-ng-model="tablaCnaGeneral.valor"/>
                                                    <span class="input-group-addon">{{nut.idUnidadMedida.unidadMedida}}</span>
                                                </div>
                                            </div>
                                            <!--                                            <div class="col-lg-12" data-ng-repeat="tda in allTipoDatosAlimentos track by $index">
                                                                                            <div class="box dark">
                                                                                                <header>
                                                                                                    <div class="icons"><i class="icon-edit"></i></div>
                                                                                                    <h5>
                                                                                                        <a class="accordion-toggle minimize-box" data-toggle="collapse" 
                                                                                                           href="#div{{tda.idTiposDatosAlimentos}}">{{tda.nombreTipoDato}}
                                                                                                        </a>
                                                                                                    </h5>
                                                                                                    <div class="toolbar">
                                                                                                        <ul class="nav"> 
                                                                                                            <li>
                                                                                                                <a class="accordion-toggle minimize-box" data-toggle="collapse" href="#div{{tda.idTiposDatosAlimentos}}">
                                                                                                                    <i id="flecha" class="icon-chevron-down"></i>
                                                                                                                </a>
                                                                                                            </li>
                                                                                                        </ul>
                                                                                                    </div>
                                                                                                </header>
                                                                                                <div id="{{'div' + tda.idTiposDatosAlimentos}}" class="accordion-body collapse body">
                                                                                                    <div data-ng-repeat="nut in tda.nutrientesList" class="input-group tooltip-demo">
                                                                                                        <span class="input-group-addon" data-toggle="tooltip" data-placement="left" title="{{nut.nombre}}">{{nut.abreviatura}}</span>
                                                                                                        <input type="text" class="form-control"/>
                                                                                                        <span class="input-group-addon">{{nut.idUnidadMedida.unidadMedida}}</span>
                                                                                                    </div>
                                                                                                    <br />
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>-->
                                        </div>
                                        <button class="icon-pencil btn btn-success" type="submit"> Guardar</button>
                                    </form> 
                                </div>                            
                            </div>
                        </div>
                    </div>              		
                    <!--MODAL NUEVO ALIMENTO-->
                    <div class="col-lg-12">
                        <div class="modal fade" id="modalNuevoAlimento" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <form role="form" data-ng-submit="createNuevoAlimento()" method="post" name="formAddAlimento">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="H3">Nuevo Alimento</h4>
                                        </div>
                                        <div class="modal-body">
                                            <div class="form-group">
                                                <label>Nombre Cient&iacute;fico</label>
                                                <input class="form-control" style="text-transform: capitalize" name="inputNombreCientAlimento"
                                                       data-ng-model="alimento.nombreCient" required=""/>
                                                <div data-ng-show="formAddAlimento.inputNombreCientAlimento.$invalid">
                                                    <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label>Nombre Com&uacute;n</label>
                                                <input class="form-control" style="text-transform: capitalize" name="inputNombreAlimento"
                                                       data-ng-model="alimento.nombre" required="" />
                                                <div data-ng-show="formAddAlimento.inputNombreAlimento.$invalid">
                                                    <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label>Variedad</label>
                                                <input class="form-control" style="text-transform: capitalize" name="inputVariedadAlimento"
                                                       data-ng-model="alimento.variedad" required="" />
                                                <div data-ng-show="formAddAlimento.inputVariedadAlimento.$invalid">
                                                    <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label>Parte</label>
                                                <input class="form-control" style="text-transform: capitalize" name="inputParteAlimento"
                                                       data-ng-model="alimento.parte" required="" />
                                                <div data-ng-show="formAddAlimento.inputParteAlimento.$invalid">
                                                    <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label>Proceso</label>
                                                <input class="form-control" style="text-transform: capitalize" name="inputProcesoAlimento"
                                                       data-ng-model="alimento.proceso" required="" />
                                                <div data-ng-show="formAddAlimento.inputprocesoAlimento.$invalid">
                                                    <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label>Mezla</label>
                                                <input class="form-control" style="text-transform: capitalize" name="inputMezclaAlimento"
                                                       data-ng-model="alimento.mezcla" required="" />
                                                <div data-ng-show="formAddAlimento.inputMezclaAlimento.$invalid">
                                                    <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                                </div>
                                            </div>
                                            <label>Tipo en Cuba</label>
                                            <br>
                                            <select class="form-control"
                                                    data-ng-model="selectedTipoCuba" 
                                                    data-ng-options="tipoCuba.idTipoCuba as tipoCuba.tipoCuba for tipoCuba in allTipoCuba">
                                            </select>
                                            <label>Tipo en FAO</label>
                                            <br>
                                            <select class="form-control"
                                                    data-ng-model="selectedTipoFao" 
                                                    data-ng-options="tipoFao.idTipoFao as tipoFao.tipoFao for tipoFao in allTipoFao">
                                            </select>
                                            <label>Tipo en NRC</label>
                                            <br>
                                            <select class="form-control" 
                                                    data-ng-model="selectedTipoNrc" 
                                                    data-ng-options="tipoNrc.idTipoNrc as tipoNrc.tipoNrc for tipoNrc in allTipoNrc">
                                            </select>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="submit" class="btn btn-primary" data-ng-disabled="formAddAlimento.$invalid">Aceptar</button>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                                        </div>                            
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div> 
                    <!--END MODAL NUEVO ALIMENTO-->
                </div>
            </div>
        </div>
        <!--END PAGE CONTENT -->
        <!-- FOOTER -->
        <jsp:include page="/WEB-INF/includes/footer.jsp"/>
        <!--END FOOTER -->
        <!--GLOBAL SCRIPTS-->
        <jsp:include page="/WEB-INF/includes/globalScripts.jsp"/>
        <!--END GLOBAL SCRIPTS-->
        <!--PAGE LEVEL SCRIPTS-->
        <script src="${pageContext.request.contextPath}/static/js/notifications.js"></script>
        <script>
                                                $(function () {
                                                Notifications();
                                                });
        </script>
        <!--END PAGE LEVEL SCRIPTS-->
    </body>
</html>
