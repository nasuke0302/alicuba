<%-- 
    Document   : cna
    Created on : 09-abr-2018, 23:02:57
    Author     : albert
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es" data-ng-app="AppCna">

    <!-- BEGIN HEAD-->
    <head data-ng-app="AppEstudio">
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
                                            <li><a data-ng-click="estudiosPorReferencia(lastReferencia.idReferencia)" class="btn btn-primary">
                                                    <span class="glyphicon glyphicon-eye-open"></span> Ver estudios de la referencia</a>
                                            </li>
                                            <li><a data-ng-click="nuevoEstudio()" class="btn btn-primary">
                                                    <span class="glyphicon glyphicon-plus"></span> Nuevo estudio</a>
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
                                            <td><strong>Estudio</strong></td>
                                            <td><strong>Nutrientes</strong></td>
                                            <td><strong>Acciones</strong></td>
                                        </tr>
                                        <tr data-ng-repeat="e in estudioPorReferencia">
                                            <td><em>{{e.idAlimento.nombreCient}}</em>, {{e.idAlimento.nombre}},
                                                <abbr title="Variedad">{{e.idAlimento.variedad}}</abbr>, {{e.tratamiento}}, 
                                                <abbr title="{{e.idProvincia.idRegion.region}}">{{e.idProvincia.idRegion.etiqueta}}</abbr>-
                                                <abbr title="{{e.idEpoca.nombre}}">{{e.idEpoca.etiqueta}}</abbr>-
                                                <abbr title="Riego">{{e.riego}}</abbr>-
                                                <abbr title="{{e.fertilizado.fertilizado}}">{{e.fertilizado.etiqueta}}</abbr>-
                                                <abbr title="{{e.idRangoEdades.rango}}">{{e.idRangoEdades.etiqueta}}</abbr></td>
                                            <td>
                                                <table class="table">
                                                    <tr data-ng-repeat="nut in e.tablaCnaGeneralList">
                                                        <td>{{nut.nutrientes.idTiposDatosAlimentos.nombreTipoDato}}</td>
                                                        <td>
                                                             <abbr title="{{nut.nutrientes.nombre}}">{{nut.nutrientes.abreviatura}}</abbr>,
                                                            {{nut.nutrientes.idUnidadMedida.unidadMedida}}</td>
                                                        <td> {{nut.valor}}</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td>
                                                <a href="#" class="btn btn-outline btn-success btn-xs" role="button" title="Editar Estudio"><span class="glyphicon glyphicon-edit"></span></a> 
                                                <a href="#" class="btn btn-outline btn-danger btn-xs" role="button" title="Eliminar Estudio"><span class="glyphicon glyphicon-remove"></span></a> 
                                            </td> 
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--MODAL EDITAR REFERENCIA ACTUAL-->
                <div class="col-lg-12">
                    <div class="modal fade" id="modalNuevaReferencia" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <form name="formEditReferencias" role="form" data-ng-submit="saveReferencia()" method="post">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                        <h4 class="modal-title" id="H3">Editar Referencia</h4>
                                    </div>
                                    <div class="modal-body">
                                        <div class="form-group">
                                            <label>Tipo de Referencia</label>
                                            <select class="form-control" data-ng-model="selectedFuente">
                                                <option value="1">Informe</option>
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
                                                <ui-select-match placeholder="Elija al menos un autor...">
                                                    {{$item.nombre}} {{$item.apellidos}} 
                                                </ui-select-match>
                                                <ui-select-choices repeat="a in allAutores | filter: $select.search">
                                                    {{a.nombre}} {{a.apellidos}}
                                                </ui-select-choices>
                                            </ui-select> 
                                            <button class="btn btn-success" data-toggle="modal" 
                                                    data-ng-click="abrirModalAddAutor()" data-target="#modalAddOrEditAutor">
                                                <span class="glyphicon glyphicon-plus"></span>Nuevo Autor</button>
                                        </div>
                                        <div class="form-group">
                                            <label>T&iacute;tulo</label>
                                            <input name="inputTitulo" class="form-control" style="text-transform: capitalize" 
                                                   data-ng-model="referencia.title" required=""
                                                   placeholder="T&iacute;tulo de la referencia" />
                                            <div data-ng-show="formEditReferencias.inputTitulo.$invalid">
                                                <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>Nota</label>
                                            <textarea name="inputNota" class="form-control" placeholder="Breve descripci&oacute;n sobre la referencia"
                                                      data-ng-model="referencia.nota" required=""></textarea>
                                            <div data-ng-show="formEditReferencias.inputNota.$invalid">
                                                <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>A&ntilde;o</label>
                                            <input name="inputYear" class="form-control" data-ng-minlength="2" data-ng-maxlength="4"
                                                   data-ng-model="referencia.fecha" required="" placeholder="yyyy"/>
                                            <div data-ng-show="formEditReferencias.inputYear.$invalid">
                                                <span style="color:red; display: block; text-align: left;">Introduzca un valor de entre 2 y 4 digitos</span>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>P&aacute;ginas</label>
                                            <input name="inputPaginas" class="form-control" placeholder="N&uacute;mero de p&aacute;gina o rango de p&aacute;ginas"
                                                   data-ng-model="referencia.pages" required=""/>
                                            <div data-ng-show="formEditReferencias.inputPaginas.$invalid">
                                                <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label>Lugar o Pa&iacute;s</label>
                                            <input name="inputLugar" value="" class="form-control" style="text-transform: capitalize"
                                                   data-ng-model="referencia.lugar" required=""/>
                                            <div data-ng-show="formEditReferencias.inputLugar.$invalid">
                                                <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>Categor&iacute;a </label>
                                            <ui-select multiple="" data-ng-model="selectedCategoria.selected" 
                                                       theme="bootstrap" close-on-select="false">
                                                <ui-select-match placeholder="Elija al menos una categor&iacute;a...">
                                                    {{$item.categoria}}
                                                </ui-select-match>
                                                <ui-select-choices repeat="a in allCategorias | filter: $select.search">
                                                    {{a.categoria}}
                                                </ui-select-choices>
                                            </ui-select>
                                            <button class="btn btn-success" data-toggle="modal" 
                                                    data-ng-click="abrirModalAddCategoria()" data-target="#modalAddOrEditCategoria">
                                                <span class="glyphicon glyphicon-plus"></span>Nueva Categor&iacute;a</button>
                                        </div>
                                        <hr />
                                        <div class="form-group"  data-ng-show="selectedFuente === '1'">
                                            <label>Número</label>
                                            <input name="informe_num" class="form-control" maxlength="8"
                                                   data-ng-model="referencia.informeNum"/>
                                        </div>
                                        <div class="form-group"  data-ng-show="selectedFuente === '1'">
                                            <label>Tipo de Informe</label>
                                            <input name="tipo" class="form-control" style="text-transform: capitalize"
                                                   data-ng-model="referencia.informeTipo"/>
                                        </div>
                                        <div class="form-group"  data-ng-show="selectedFuente === '1'">
                                            <label>Instituci&oacute;n</label>
                                            <input name="institution" class="form-control" style="text-transform: capitalize"
                                                   data-ng-model="referencia.informeInstitution"/>
                                        </div>

                                        <div class="form-group" data-ng-show="selectedFuente === '1'">
                                            <label>T&iacute;tulo de la serie</label>
                                            <input name="title_serie" class="form-control" 
                                                   data-ng-model="referencia.informeSerie"
                                                   style="text-transform: capitalize"/>
                                        </div>
                                        <div class="form-group" data-ng-show="selectedFuente === '2'">
                                            <label>Publicaci&oacute;n</label>
                                            <input name="Publication" class="form-control" 
                                                   data-ng-model="referencia.arcPublication"/>
                                        </div>

                                        <div class="form-group" data-ng-show="selectedFuente === '2' ||
                                                                selectedFuente === '3'">
                                            <label>N&uacute;mero</label>
                                            <input name="tipo" class="form-control" 
                                                   data-ng-model="referencia.volumen"/>
                                        </div>

                                        <div class="form-group" data-ng-show="selectedFuente === '2' ||
                                                                selectedFuente === '3'">
                                            <label>Volumen o tomo</label>
                                            <input name="volumen" value="" class="form-control" 
                                                   data-ng-model="referencia.numVol"/>
                                        </div>

                                        <div class="form-group" data-ng-show="selectedFuente === '3' ||
                                                                selectedFuente === '4' || selectedFuente === '5'">
                                            <label>Editorial</label>
                                            <input name="editorial" value="" class="form-control"
                                                   data-ng-model="referencia.editorial"/>
                                        </div>
                                        <div class="form-group" data-ng-show="selectedFuente === '3' ||
                                                                selectedFuente === '4'">
                                            <label>Edici&oacute;n</label>
                                            <input name="editorial" class="form-control" 
                                                   data-ng-model="referencia.edition"/>
                                        </div>
                                        <div class="form-group" data-ng-show="selectedFuente === '4'">
                                            <label>T&iacute;tulo del Libro</label>
                                            <input name="secclTitle" class="form-control" 
                                                   data-ng-model="referencia.secclTitle"/>
                                        </div>
                                        <div class="form-group"data-ng-show="selectedFuente === '5'">
                                            <label>Universidad</label>
                                            <input name="tesisUniversidad" class="form-control"
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
                                        <button type="submit" class="btn btn-primary" data-ng-disabled="formEditReferencias.$invalid">Aceptar</button>
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                                    </div>                            
                                </div>
                            </form>
                        </div>
                    </div>
                </div> 
                <!--END MODAL EDITAR REFERENCIA ACTUAL-->
                <!--CREATE AUTOR-->
                <div class="col-lg-12">
                    <div class="modal fade" id="modalAddOrEditAutor" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    <h4 class="modal-title" id="H2">Añadir Autor</h4>
                                </div>
                                <div class="modal-body">
                                    <form role="form" data-ng-submit="addAutor()" method="post" name="formAddAutor">
                                        <div class="form-group">
                                            <label>Nombre</label>
                                            <input class="form-control" type="text" name="inputAutorNombre"
                                                   required="" data-ng-model="autor.nombre"
                                                   style=" text-transform: capitalize"/>
                                            <div data-ng-show="formAddAutor.inputAutorNombre.$invalid">
                                                <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>Segundo Nombre</label>
                                            <input class="form-control" type="text" 
                                                   data-ng-model="autor.segundoNombre"
                                                   style=" text-transform: capitalize"/>
                                        </div>
                                        <div class="form-group">
                                            <label>Apellidos</label>
                                            <input class="form-control" type="text" name="inputAutorApellidos"
                                                   required="" data-ng-model="autor.apellidos"
                                                   style=" text-transform: capitalize"/>
                                            <div data-ng-show="formAddAutor.inputAutorApellidos.$invalid">
                                                <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                            </div>
                                        </div>
                                        <div class="text-right">
                                            <button type="submit" class="btn btn-success" data-ng-disabled="formAddAutor.$invalid">Guardar</button>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--END CREATE AUTOR-->
                <!--CREATE CATEGORIA -->
                <div class="col-lg-12">
                    <div class="modal fade" id="modalAddOrEditCategoria" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    <h4 class="modal-title" id="H2">Añadir Categor&iacute;a</h4>
                                </div>
                                <div class="modal-body">
                                    <form role="form" data-ng-submit="addCategoria()" method="post" name="formAddCategoria">
                                        <div class="form-group">
                                            <label>Categor&iacute;a</label>
                                            <input class="form-control" type="text" name="inputCategoriaCategoria"
                                                   required="" data-ng-model="categoria.categoria"
                                                   style=" text-transform: capitalize"/>
                                            <div data-ng-show="formAddCategoria.inputCategoriaCategoria.$invalid">
                                                <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                            </div>
                                        </div>
                                        <div class="text-right">
                                            <button type="submit" class="btn btn-success" data-ng-disabled="formAddCategoria.$invalid">Guardar</button>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--END CREATE CATEGORIA-->
            </div>
            <!--END PAGE CONTENT -->
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

