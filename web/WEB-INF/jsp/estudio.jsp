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
        <title>AliCuba</title>

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
                                <div class="panel-heading">
                                    Estudio 
                                </div>
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="form-group">
                                                <h4>Seleccione un alimento:</h4>
                                                <ui-select data-ng-model="selectedAlimento.selected" 
                                                           theme="bootstrap">
                                                    <ui-select-match placeholder="Elija un alimento...">
                                                        {{$select.selected.nombre}}
                                                    </ui-select-match>
                                                    <ui-select-choices repeat="a in allAlimentos | filter: $select.search">
                                                        <div ng-bind-html="a.nombre | highlight: $select.search"></div>
                                                        {{a.nombre}}
                                                        <small>
                                                            <strong>Nombre Cientifico: </strong> {{a.nombreCient}}
                                                            <strong>Variedad: </strong> {{a.variedad}}
                                                            <strong>Parte: </strong> {{a.parte}}
                                                        </small>
                                                    </ui-select-choices>
                                                </ui-select> 
                                            </div>
                                            <h4>
                                                <strong>Alimento: </strong> 
                                                <div data-ng-show="selectedAlimento.selected">
                                                    <em>{{selectedAlimento.selected.nombreCient}}</em>,
                                                    <em>{{selectedAlimento.selected.nombre}}</em>,
                                                    <em>{{selectedAlimento.selected.variedad}}</em>,
                                                    <em>{{selectedAlimento.selected.parte}}</em>.
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
                                                            <span class="input-group-addon">Proceso</span>
                                                            <input type="text" class="form-control">                                                  
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Mezcla</span>
                                                            <input type="text" class="form-control">                                                  
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Riego</span>
                                                            <input type="number" class="form-control">                                                  
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">N</span>
                                                            <input type="number" class="form-control">                                                  
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Npk</span>
                                                            <input type="text" class="form-control">                                                  
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Fertilizaci&oacute;n Org&aacute;nica</span>
                                                            <input type="number" class="form-control">                                                  
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Edad</span>
                                                            <input type="number" class="form-control">                                                  
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Corte</span>
                                                            <input type="text" class="form-control">                                                  
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Tecnolog&iacute;a</span>
                                                            <input type="text" class="form-control">                                                  
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Tratamiento</span>
                                                            <input type="text" class="form-control">                                                  
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Presentaci&oacute;n</span>
                                                            <input type="text" class="form-control">                                                  
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Otras Caracter&iacute;sticas</span>
                                                            <input type="text" class="form-control">                                                  
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
                                                            <ui-select class="form-control" data-ng-model="selectedPais.selected" 
                                                                       theme="bootstrap" data-ng-required='true'>
                                                                <ui-select-match placeholder="Elija un Pa&iacute;s...">
                                                                    {{$select.selected.nombre}}
                                                                </ui-select-match>
                                                                <ui-select-choices repeat="a in allPaises | filter: $select.search">
                                                                    <div ng-bind-html="a.nombre | highlight: $select.search"></div>
                                                                    {{a.nombre}}
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
                                            <div class="col-lg-12">
                                                <div class="box dark">
                                                    <header>
                                                        <div class="icons"><i class="icon-edit"></i></div>
                                                        <h5><a class="accordion-toggle minimize-box" data-toggle="collapse" href="#div-2">Weende</a></h5>
                                                        <div class="toolbar">
                                                            <ul class="nav"> 
                                                                <li>
                                                                    <a class="accordion-toggle minimize-box" data-toggle="collapse" href="#div-2">
                                                                        <i class="icon-chevron-down"></i>
                                                                    </a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </header>
                                                    <div id="div-2" class="accordion-body collapse body">
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><abbr title="Materia Seca">MS</abbr></span>
                                                            <input type="text" name="MS" class="form-control">
                                                            <span class="input-group-addon">%</span>
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><abbr title="Materia Seca">Cz</abbr></span>
                                                            <input type="text" name="Cz" class="form-control">
                                                            <span class="input-group-addon">% MS</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-12">
                                                <div class="box dark">
                                                    <header>
                                                        <div class="icons"><i class="icon-edit"></i></div>
                                                        <h5><a class="accordion-toggle minimize-box" data-toggle="collapse" href="#div-3">Digestibilidad Van Soest Rumiantes</a></h5>
                                                        <div class="toolbar">
                                                            <ul class="nav"> 
                                                                <li>
                                                                    <a class="accordion-toggle minimize-box" data-toggle="collapse" href="#div-3">
                                                                        <i class="icon-chevron-down"></i>
                                                                    </a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </header>
                                                    <div id="div-3" class="accordion-body collapse body">
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><abbr title="Digestibilidad verdadera in vitro de fibra detergente ácida en ovino">DVITFDAO</abbr></span>
                                                            <input type="text" name="DVITFDAO" class="form-control">
                                                            <span class="input-group-addon">%</span>
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><abbr title="Digestibilidad verdadera in vitro de fibra detergente ácida en ovino">DVITFDAO</abbr></span>
                                                            <input type="text" name="DVITFDAO" class="form-control">
                                                            <span class="input-group-addon">%</span>
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><abbr title="Digestibilidad verdadera in vitro de fibra detergente ácida en ovino">DVITFDAO</abbr></span>
                                                            <input type="text" name="DVITFDAO" class="form-control">
                                                            <span class="input-group-addon">%</span>
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><abbr title="Digestibilidad verdadera in vitro de fibra detergente ácida en ovino">DVITFDAO</abbr></span>
                                                            <input type="text" name="DVITFDAO" class="form-control">
                                                            <span class="input-group-addon">%</span>
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><abbr title="Digestibilidad verdadera in vitro de fibra detergente ácida en ovino">DVITFDAO</abbr></span>
                                                            <input type="text" name="DVITFDAO" class="form-control">
                                                            <span class="input-group-addon">%</span>
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><abbr title="Digestibilidad verdadera in vitro de fibra detergente ácida en ovino">DVITFDAO</abbr></span>
                                                            <input type="text" name="DVITFDAO" class="form-control">
                                                            <span class="input-group-addon">%</span>
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><abbr title="Digestibilidad verdadera in vitro de fibra detergente ácida en ovino">DVITFDAO</abbr></span>
                                                            <input type="text" name="DVITFDAO" class="form-control">
                                                            <span class="input-group-addon">%</span>
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><abbr title="Digestibilidad verdadera in vitro de fibra detergente ácida en ovino">DVITFDAO</abbr></span>
                                                            <input type="text" name="DVITFDAO" class="form-control">
                                                            <span class="input-group-addon">%</span>
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><abbr title="Digestibilidad verdadera in vitro de fibra detergente ácida en ovino">DVITFDAO</abbr></span>
                                                            <input type="text" name="DVITFDAO" class="form-control">
                                                            <span class="input-group-addon">%</span>
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><abbr title="Digestibilidad verdadera in vitro de fibra detergente ácida en ovino">DVITFDAO</abbr></span>
                                                            <input type="text" name="DVITFDAO" class="form-control">
                                                            <span class="input-group-addon">%</span>
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><abbr title="Digestibilidad verdadera in vitro de fibra detergente ácida en ovino">DVITFDAO</abbr></span>
                                                            <input type="text" name="DVITFDAO" class="form-control">
                                                            <span class="input-group-addon">%</span>
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><abbr title="Digestibilidad verdadera in vitro de fibra detergente ácida en ovino">DVITFDAO</abbr></span>
                                                            <input type="text" name="DVITFDAO" class="form-control">
                                                            <span class="input-group-addon">%</span>
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><abbr title="Digestibilidad verdadera in vitro de fibra detergente ácida en ovino">DVITFDAO</abbr></span>
                                                            <input type="text" name="DVITFDAO" class="form-control">
                                                            <span class="input-group-addon">%</span>
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><abbr title="Digestibilidad verdadera in vitro de fibra detergente ácida en ovino">DVITFDAO</abbr></span>
                                                            <input type="text" name="DVITFDAO" class="form-control">
                                                            <span class="input-group-addon">%</span>
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><abbr title="Digestibilidad verdadera in vitro de celulosa en ovino">DVITCelO</abbr></span>
                                                            <input type="text" name="DVITCelO" class="form-control">
                                                            <span class="input-group-addon">%</span>
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><abbr title="Digestibilidad aparente in vitro de hemicelulosa en ovino">DAITHemO</abbr></span>
                                                            <input type="text" name="DAITHemO" class="form-control">
                                                            <span class="input-group-addon">%</span>
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><abbr title="Digestibilidad aparente in vitro de fibra detergente neutra en ovino">DAITFDNO</abbr></span>
                                                            <input type="text" name="DAITFDNO" class="form-control">
                                                            <span class="input-group-addon">%</span>
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><abbr title="Digestibilidad aparente in vitro de fibra detergente ácida en ovino">DAITFDAO</abbr></span>
                                                            <input type="text" name="DAITFDAO" class="form-control">
                                                            <span class="input-group-addon">%</span>
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><abbr title="Digestibilidad aparente in vitro de celulosa en ovino">DAITCelO</abbr></span>
                                                            <input type="text" name="DAITCelO" class="form-control">
                                                            <span class="input-group-addon">%</span>
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><abbr title="Digestibilidad verdadera in vivo de hemicelulosa en ovino">DVIVHemO</abbr></span>
                                                            <input type="text" name="DVIVHemO" class="form-control">
                                                            <span class="input-group-addon">%</span>
                                                        </div>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><abbr title="Digestibilidad verdadera in vivo de fibra detergente neutra en ovino">DVIVFDNO</abbr></span>
                                                            <input type="text" name="DVIVFDNO" class="form-control">
                                                            <span class="input-group-addon">%</span>
                                                        </div>	
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                        <button class="icon-pencil btn btn-success" type="submit"> Guardar</button>
                                    </form> 
                                </div>                            
                            </div>
                        </div>
                    </div>              		
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Referencia 
                                </div>
                                <div class="panel-body">
                                    <p>
                                        T. R. Preston, M. B. Willis y A. Elías. (1967). Sub-producto de la caña y producción intensiva de carne. 2. Comparación entre la miel final y la miel rica como suplemento de forraje o concentrados. Cuba. Revista Cubana de Ciencias Agrícola, 1(1), 41-48.                                    
                                    </p> 
                                    <p>                                    
                                        URL: <a href="http://www.ciencia-animal.org/revista-cubana-de-ciencia-agricola/articulos/rcca-rolando.pdf">http://www.ciencia-animal.org/revista-cubana-de-ciencia-agricola/articulos/rcca-preston.pdf</a>
                                    </p>
                                    <p>                                    
                                        Archivo: <a href="http://localhost/alicuba_v/fichero/rcca-preston.pdf">rcca-preston.pdf</a>
                                    </p>
                                    <p>                                    
                                        Categor&iacute;as: RCCA, Ruminates, forrajes
                                    </p> 
                                </div>                            
                            </div>
                        </div>
                    </div>    
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
    </body>
</html>
