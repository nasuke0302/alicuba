<%-- 
    Document   : cna
    Created on : 09-abr-2018, 23:02:57
    Author     : albert
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es" data-ng-app="AppCna">

    <!-- BEGIN HEAD-->
    <head>
        <meta charset="UTF-8" />
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <meta content="" name="description" />
        <meta content="AliCuba" name="author" />
        <!--GLOBAL STYLES AND TITLE-->
        <jsp:include page="/WEB-INF/includes/globalcss.jsp"/>
        <!--END GLOBAL STYLES-->

        <!--PAGE LEVEL STYLES-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/AngularJs/uiSelect/select.min.css">
        <!--END PAGE LEVEL STYLES-->

        <!--PAGE LEVEL SCRIPTS-->
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/uiSelect/select.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/Cna.js"></script>
        <!--END PAGE LEVEL SCRIPTS-->
    </head>
    <!-- END  HEAD-->

    <!-- BEGIN BODY-->
    <body class="padTop53" data-ng-controller="CnaController">

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
                            <h4 class="page-header">ESTUDIOS REGISTRADOS DE LA REFERENCIA</h4>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Referencia 
                                </div>
                                <div class="panel-body">
                                    <a id="pAutores" data-ng-repeat="autor in lastReferencia.autoresList">
                                        {{autor.apellidos| limitTo: 1}}. {{autor.nombre}},
                                    </a>
                                    <a> ({{lastReferencia.fecha}}). {{lastReferencia.title}}. 2. {{lastReferencia.nota}}. {{lastReferencia.lugar}}. {{lastReferencia.idFuente.nombreFuente}}.  {{lastReferencia.pages}}.</a>
                                    <p>                                    
                                        URL: <a href="{{lastReferencia.url}}">{{lastReferencia.url}}</a>
                                    </p>
                                    <p>Categor&iacute;as:<a data-ng-repeat="categoria in lastReferencia.categoriaList">{{categoria.categoria}} </a>
                                    </p>
                                    <p>                                    
                                        <button class="icon-pencil btn btn-success" data-ng-click="abrirEditarModal()"
                                                data-toggle="modal" data-target="#modalNuevaReferencia"> Editar</button>
                                    </p> 
                                </div>                            
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="box dark">
                                <header>
                                    <div class="icons"><i class="icon-edit"></i></div>
                                    <h5>Estudios Registrados</h5>
                                    <div class="toolbar">
                                        <ul class="nav">                                        
                                            <li><a data-ng-click="nuevoEstudio()" class="btn btn-primary">
                                                    <span class="glyphicon glyphicon-plus"></span> Nuevo Estudio</a>
                                            </li>
                                            <li>
                                                <a class="accordion-toggle minimize-box" data-toggle="collapse" href="#div-1">
                                                    <i class="icon-chevron-up"></i>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </header>
                                <div id="div-1" class="accordion-body collapse in body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><strong>#</strong></td>
                                            <td><strong>Estudios</strong></td>
                                            <td><strong>Acciones</strong></td>
                                        </tr>
                                        <tr>
                                            <td>1</td>
                                            <td><em>Cynodon nlemfuensis</em>, Pasto Estrella, <abbr title="sin definir variedad">SDVar</abbr>, fresco, <abbr title="Occidente">Occ</abbr>-<abbr title="sin definir &eacute;poca">SDEpo</abbr>-<abbr title="sin definir riego">SDRie</abbr>-<abbr title="sin definir fertilizaci&oacute;n">SDFer</abbr>-<abbr title="edad entre 40 y 60 d&iacute;as">40a60</abbr></td>
                                            <td>
                                                <a href="#" class="btn btn-outline btn-success btn-xs" role="button" title="Editar Estudio"><span class="glyphicon glyphicon-edit"></span></a> 
                                                <a href="#" class="btn btn-outline btn-danger btn-xs" role="button" title="Eliminar Estudio"><span class="glyphicon glyphicon-remove"></span></a> 
                                            </td>  
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>
                                                <table class="table">
                                                    <tr>
                                                        <td class="text-info">WEENDE</td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td>MS, %</td>
                                                        <td>20.23</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Cz, %MS</td>
                                                        <td class="number text-left">0.23</td>
                                                    </tr>
                                                    <tr>
                                                        <td>PB, %MS</td>
                                                        <td>20</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-info">VAN SOEST</td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td>FDA, %MS</td>
                                                        <td>20.23</td>
                                                    </tr>
                                                    <tr>
                                                        <td>FDN, %MS</td>
                                                        <td>0.23</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-info">ENERGÍA RUMIANTES</td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td>EMB, Mcal/kg MS</td>
                                                        <td>20.23</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td>3</td>
                                            <td><em>Cynodon nlemfuensis</em>, Pasto Estrella, <abbr title="sin definir variedad">SDVar</abbr>, fresco, <abbr title="Occidente">Occ</abbr>-<abbr title="sin definir &eacute;poca">SDEpo</abbr>-<abbr title="sin definir riego">SDRie</abbr>-<abbr title="sin definir fertilizaci&oacute;n">SDFer</abbr>-<abbr title="edad entre 40 y 60 d&iacute;as">40a60</abbr></td>
                                            <td>
                                                <a href="#" class="btn btn-outline btn-success btn-xs" role="button" title="Editar Estudio"><span class="glyphicon glyphicon-edit"></span></a> 
                                                <a href="#" class="btn btn-outline btn-danger btn-xs" role="button" title="Eliminar Estudio"><span class="glyphicon glyphicon-remove"></span></a> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>
                                                <table class="table">
                                                    <tr>
                                                        <td class="text-info">WEENDE</td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td>MS, %</td>
                                                        <td>20.23</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Cz, %MS</td>
                                                        <td>0.23</td>
                                                    </tr>
                                                    <tr>
                                                        <td>PB, %MS</td>
                                                        <td>20</td>
                                                    </tr>                                    
                                                </table>
                                            </td>
                                            <td></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="box dark">
                                <header>
                                    <div class="icons"><i class="icon-edit"></i></div>
                                    <h5>Observaciones</h5>
                                    <div class="toolbar">
                                        <ul class="nav">                                        
                                            <li>
                                                <a class="accordion-toggle minimize-box" data-toggle="collapse" href="#div-2">
                                                    <i class="icon-chevron-up"></i>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </header>
                                <div id="div-2" class="accordion-body collapse in body">
                                    <form role="form" action="cna.html" method="POST">
                                        <textarea id="wysihtml5" name="wysihtml" class="form-control" rows="10"></textarea>									
                                        <div class="form-actions">
                                            <br />
                                            <input type="submit" name="Guardar" value="Guardar" class="btn btn-primary" />
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--MODAL EDITAR REFERENCIA ACTUAL-->
                <div class="col-lg-12">
                    <div class="modal fade" id="modalNuevaReferencia" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <form role="form" data-ng-submit="saveReferencia()" method="post">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                        <h4 class="modal-title" id="H3">Nueva Referencia</h4>
                                    </div>
                                    <div class="modal-body">
                                        <div class="form-group">
                                            <label>Tipo de Referencia</label>
                                            <select class="form-control" data-ng-model="selectedFuente">
                                                <option selected="" value="1">Informe</option>
                                                <option value="2">Revista Cient&iacute;fica</option>
                                                <option value="3">Libro</option>
                                                <option value="4">Secci&oacute;n de Libro</option>
                                                <option value="5">Tesis Doctoral</option>
                                                <option value="6">Otra Fuente</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label>Autor (es)</label>
                                            <ui-select class="form-control" multiple="" data-ng-model="selectedAutores.selected" 
                                                       theme="bootstrap" close-on-select="false">
                                                <ui-select-match placeholder="Elija un autor...">
                                                    {{$item.nombre}} {{$item.apellidos}} 
                                                </ui-select-match>
                                                <ui-select-choices repeat="a in allAutores | filter: $select.search">
                                                    {{a.nombre}} {{a.apellidos}}
                                                </ui-select-choices>
                                            </ui-select> 
                                        </div>
                                        <div class="form-group">
                                            <label>T&iacute;tulo</label>
                                            <input name="title" class="form-control" style="text-transform: capitalize" 
                                                   data-ng-model="referencia.title" required=""/>
                                        </div>
                                        <div class="form-group">
                                            <label>Nota</label>
                                            <textarea name="nota" class="form-control"
                                                      data-ng-model="referencia.nota" required=""></textarea>
                                        </div>
                                        <div class="form-group">
                                            <label>A&ntilde;o</label>
                                            <input name="year" value="" class="form-control" maxlength="4"
                                                   data-ng-model="referencia.fecha" required=""/>
                                        </div>
                                        <div class="form-group">
                                            <label>P&aacute;ginas</label>
                                            <input name="pages" value="" class="form-control" maxlength="4"
                                                   data-ng-model="referencia.pages" required=""/>
                                        </div> 
                                        <div class="form-group">
                                            <label>Lugar o Pa&iacute;s</label>
                                            <input name="lugar" value="" class="form-control" style="text-transform: capitalize"
                                                   data-ng-model="referencia.lugar" required=""/>
                                        </div>
                                        <div class="form-group">
                                            <label>Categor&iacute;a </label>
                                            <ui-select multiple="" data-ng-model="selectedCategoria.selected" 
                                                       theme="bootstrap" close-on-select="false">
                                                <ui-select-match placeholder="Elija una categor&iacute;a...">
                                                    {{$item.categoria}}
                                                </ui-select-match>
                                                <ui-select-choices repeat="a in allCategorias | filter: $select.search">
                                                    {{a.categoria}}
                                                </ui-select-choices>
                                            </ui-select>
                                        </div>
                                        <hr />
                                        <div class="form-group"  data-ng-show="selectedFuente === '1'">
                                            <label>Número</label>
                                            <input name="informe_num" value="" class="form-control" maxlength="8"
                                                   data-ng-model="referencia.informeNum"/>
                                        </div>
                                        <div class="form-group"  data-ng-show="selectedFuente === '1'">
                                            <label>Tipo de Informe</label>
                                            <input name="tipo" value="" class="form-control" style="text-transform: capitalize"
                                                   data-ng-model="referencia.informeTipo"/>
                                        </div>
                                        <div class="form-group"  data-ng-show="selectedFuente === '1'">
                                            <label>Instituci&oacute;n</label>
                                            <input name="institution" value="" class="form-control" style="text-transform: capitalize"
                                                   data-ng-model="referencia.informeInstitution"/>
                                        </div>

                                        <div class="form-group"  data-ng-show="selectedFuente === '1'">
                                            <label>T&iacute;tulo de la serie</label>
                                            <input name="title_serie"referencia value="" class="form-control" 
                                                   data-ng-model="referencia.informeSerie"
                                                   style="text-transform: capitalize"/>
                                        </div>
                                        <div class="form-group" data-ng-show="selectedFuente === '2'">
                                            <label>Publicaci&oacute;n</label>
                                            <input name="Publication" value="" class="form-control" 
                                                   data-ng-model="referencia.arcPublication"/>
                                        </div>

                                        <div class="form-group" data-ng-show="selectedFuente === '2' ||
                                                                selectedFuente === '3'">
                                            <label>N&uacute;mero</label>
                                            <input name="tipo" value="" class="form-control" 
                                                   data-ng-model="referencia.volumen"/>
                                        </div>

                                        <div class="form-group" data-ng-show="selectedFuente === '2' ||
                                                                selectedFuente === '3'">
                                            <label>Volumen o tomo</label>
                                            <input name="volumen" value="" class="form-control" 
                                                   data-ng-model="referencia.numVol"/>
                                        </div>

                                        <div class="form-group"  data-ng-show="selectedFuente === '3' ||
                                                                selectedFuente === '4' || selectedFuente === '5'">
                                            <label>Editorial</label>
                                            <input name="editorial" value="" class="form-control"
                                                   data-ng-model="referencia.editorial"/>
                                        </div>
                                        <div class="form-group" data-ng-show="selectedFuente === '3' ||
                                                                selectedFuente === '4'">
                                            <label>Edici&oacute;n</label>
                                            <input name="editorial" value="" class="form-control" 
                                                   data-ng-model="referencia.edition"/>
                                        </div>
                                        <div class="form-group" data-ng-show="selectedFuente === '4'">
                                            <label>T&iacute;tulo del Libro</label>
                                            <input name="secclTitle" value="" class="form-control" 
                                                   data-ng-model="referencia.secclTitle"/>
                                        </div>
                                        <div class="form-group"data-ng-show="selectedFuente === '5'">
                                            <label>Universidad</label>
                                            <input name="tesisUniversidad" value="" class="form-control"
                                                   data-ng-model="referencia.tesisUniversidad"/>
                                        </div>
                                        <div class="form-group">
                                            <label>URL</label>
                                            <input name="url" class="form-control" type="url"
                                                   data-ng-model="referencia.url"/>
                                            <input class="hidden" type="text"
                                                   data-ng-model="referencia.idReferencia"/>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                                        <button type="submit" class="btn btn-primary">Aceptar</button>
                                    </div>                            
                                </div>
                            </form>
                        </div>
                    </div>
                </div> 
                <!--END MODAL EDITAR REFERENCIA ACTUAL-->
            </div>
            <!--END PAGE CONTENT -->

            <!-- RIGHT STRIP  SECTION -->
            <div id="right">            
                <div class="well well-small">
                    <ul class="list-unstyled">
                        <li>Visitor &nbsp; : <span>23,000</span></li>
                        <li>Users &nbsp; : <span>53,000</span></li>
                        <li>Registrations &nbsp; : <span>3,000</span></li>
                    </ul>
                </div>
            </div>
            <!-- END RIGHT STRIP  SECTION -->
        </div>
        <!--END MAIN WRAPPER -->
        <!-- FOOTER -->
        <jsp:include page="/WEB-INF/includes/footer.jsp"/>
        <!--END FOOTER -->
        <!--GLOBAL SCRIPTS-->
        <jsp:include page="/WEB-INF/includes/globalScripts.jsp"/>
        <!--END GLOBAL SCRIPTS-->
        <!-- PAGE LEVEL SCRIPT-->
    </body>
    <!-- END BODY-->
</html>

