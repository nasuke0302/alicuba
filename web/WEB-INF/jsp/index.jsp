<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html data-ng-app="AppIndex">
    <head>
        <!--GLOBAL STYLES AND TITLE-->
        <jsp:include page="/WEB-INF/includes/globalcss.jsp"/>
        <!--END GLOBAL STYLES-->

        <!-- PAGE LEVEL STYLES -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/AngularJs/uiSelect/select.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/AngularJs/angular-datatables.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/AngularJs/datatables.bootstrap.min.css">

        <!--END PAGE LEVEL STYLES-->

        <!-- PAGE LEVEL SCRIPTS-->
        <script src="${pageContext.request.contextPath}/static/AngularJs/jQuery-3.3.1.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/jquery.dataTables.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular-datatables.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular-datatables.bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/uiSelect/select.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/Index.js"></script>
        <!--END PAGE LEVEL SCRIPTS-->
    </head>

    <body class="padTop53" data-ng-controller="IndexController">
        <!--MAIN WRAP-->
        <div id="wrap">
            <!-- HEADER SECTION -->
            <jsp:include page="/WEB-INF/includes/header.jsp"/>
            <!-- END HEADER SECTION -->
            <!-- MENU SECTION -->
            <jsp:include page="/WEB-INF/includes/menuContent.jsp"/>
            <!--END MENU SECTION -->
            <!--PAGE CONTENT -->
            <div id="content">
                <div class="inner" style="min-height:800px;">
                    <div class="row">
                        <div class="col-lg-12">
                            <h2>Contribuciones</h2>
                        </div>
                        <div class="col-lg-12">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <div class="btn-group">
                                                <button class="icon-plus btn btn-success" data-ng-click="abrirNuevoModal()"
                                                        data-toggle="modal" data-target="#modalNuevaReferencia"> Nueva referencia</button>
                                            </div>
                                        </div>
                                        <div class="panel-body">
                                            <div class="table-responsive">
                                                <table datatable="ng" id="tablaReferencias" class="table table-striped table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>Acciones</th>
                                                            <th>Referencia</th>
                                                            <th>Tipo</th>
                                                            <th>Categor&iacute;a</th>
                                                            <th>Fecha de adici&oacute;n</th>
                                                            <th>Fecha de modificaci&oacute;n</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr data-ng-repeat="referencia in allReferencias track by $index">
                                                            <td>
                                                                <button class="btn btn-primary" data-ng-click="abrirEditarModal($index)"
                                                                        <button class="btn btn-primary"
                                                                        data-toggle="modal" data-target="#modalNuevaReferencia">
                                                                        <i class="glyphicon glyphicon-pencil"></i></button>
                                                                    <button class="btn btn-danger" data-toggle="modal" data-target="#formModalEliminar"
                                                                            data-ng-click="abrirEliminarModal($index)">
                                                                        <i class="glyphicon glyphicon-trash"></i></button>
                                                            </td>
                                                            <td>
                                                                <span data-ng-repeat="autoRes in referencia.autoresList">
                                                                    {{autoRes.nombre}} {{autoRes.apellidos| limitTo : 1}};</span>
                                                                ({{referencia.fecha}}). {{referencia.title}},
                                                                {{referencia.pages}}</td>
                                                            <td>{{referencia.idFuente.nombreFuente}}</td>
                                                            <td>{{referencia.idCategoria.categoria}}</td>
                                                            <td>{{referencia.fechaAd| date: 'dd-MM-yyyy hh:mm'}}</td>
                                                            <td>{{referencia.fechaMod| date: 'dd-MM-yyyy hh:mm'}}</td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <div class="panel-footer">Referencias</div>
                                    </div>
                                    <!--MODAL NUEVO-->
                                    <div class="col-lg-12">
                                        <div class="modal fade" id="modalNuevaReferencia" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <form role="form" data-ng-submit="createOrEditReferencia()" method="post">
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
                                                                        {{a.nombre}} ({{a.apellidos}})
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
                                                                <button class="btn btn-success glyphicon glyphicon-plus"></button>
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
                                    <!--END MODAL NUEVO-->

                                    <!--DELETE MODAL-->
                                    <div>
                                        <div class="modal fade" id="formModalEliminar" role="dialog" style="display: none;">
                                            <div class="modal-dialog" style="margin-top: 260.5px;">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                        <h4 class="modal-title">¿Seguro que desea eliminar este registro?</h4>
                                                        <div class="modal-body">
                                                            <form role="form" method="post" data-ng-submit="eliminarReferencia()" id="delete_data" class="text-right">
                                                                <button type="submit" class="btn btn-danger">Eliminar</button>
                                                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                                                            </form>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                        <!--END DELETE MODAL-->
                                    </div>
                                    <!--END DLETE MODAL-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--END PAGE CONTENT -->
        </div>
        <!--END MAIN WRAP-->
        <!-- FOOTER -->
        <jsp:include page="/WEB-INF/includes/footer.jsp"/>
        <!--END FOOTER -->

        <!--GLOBAL SCRIPTS-->
        <jsp:include page="/WEB-INF/includes/globalScripts.jsp"/>

    </body>
</html>
