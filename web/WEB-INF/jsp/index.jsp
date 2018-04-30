<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib  prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
                        <br />
                        <div class="col-lg-12">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <p>{{referencia}}</p>
                                            <sec:authorize access="hasAuthority('Colaborador')">
                                                <div class="btn-group">
                                                    <button class="icon-plus btn btn-success" data-ng-click="abrirNuevoModal()"
                                                            data-toggle="modal" data-target="#modalNuevaReferencia"> Nueva referencia</button>
                                                </div>
                                            </sec:authorize>
                                        </div>
                                        <div class="panel-body">
                                            <div class="table-responsive">
                                                <table datatable="ng" id="tablaReferencias" class="table table-striped table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>Acciones</th>
                                                            <th>Autor(es)</th>
                                                            <th>Referencia</th>
                                                            <th>Fuente</th>
                                                            <th>Categor&iacute;a(s)</th>
                                                                <sec:authorize access="hasAuthority('Editor')">
                                                                <th>Colaborador</th>
                                                                </sec:authorize>
                                                            <th>Fecha de adici&oacute;n</th>
                                                            <th>Fecha de modificaci&oacute;n</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr data-ng-repeat="r in allReferencias track by $index">
                                                            <td>
                                                                <button class="btn btn-primary btn-xs" data-ng-click="abrirEditarModal($index)"
                                                                        data-toggle="modal" data-target="#modalNuevaReferencia">
                                                                    <i class="glyphicon glyphicon-pencil"></i>
                                                                </button>
                                                                <sec:authorize access="hasAuthority('Colaborador')">
                                                                    <button class="btn btn-danger btn-xs" data-toggle="modal" data-target="#formModalEliminar"
                                                                            data-ng-click="abrirEliminarModal($index)">
                                                                        <i class="glyphicon glyphicon-trash"></i>
                                                                    </button>
                                                                </sec:authorize>
                                                            </td>
                                                            <td>
                                                                <small data-ng-repeat="a in r.autoresList">
                                                                    {{a.apellidos| limitTo : 1}}. {{a.nombre}};</small>

                                                            </td>
                                                            <td>
                                                                <small>({{r.fecha}}). {{r.title}}</small>
                                                            </td>
                                                            <td><small>{{r.idFuente.nombreFuente}}</small></td>
                                                            <td>
                                                                <span data-ng-repeat="c in r.categoriaList">
                                                                    {{c.categoria}}</span>
                                                            </td>
                                                            <sec:authorize access="hasAuthority('Editor')">
                                                                <td>
                                                                    <abbr title="{{r.idUsuario.email}}">{{r.idUsuario.nombre}}</abbr>
                                                                </td>
                                                            </sec:authorize>
                                                            <td><small> {{r.fechaAd| date: 'dd-MM-yyyy hh:mm a'}}</small></td>
                                                            <td><small> {{r.fechaMod| date: 'dd-MM-yyyy hh:mm a'}}</small></td>
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
                                                <form name="formAddReferencias" role="form" data-ng-submit="createOrEditReferencia()" method="post">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                            <h4 class="modal-title" id="H3">Nueva Referencia</h4>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="form-group">
                                                                <label>Fuente de Referencia</label>
                                                                <ui-select data-ng-model="selectedFuente.selected" 
                                                                           theme="bootstrap">
                                                                    <ui-select-match placeholder="Elija una fuente de referencia...">
                                                                        {{$select.selected.nombreFuente}}
                                                                    </ui-select-match>
                                                                    <ui-select-choices repeat="a in allFuentes| filter: $select.search">
                                                                        {{a.nombreFuente}}
                                                                    </ui-select-choices>
                                                                </ui-select>   
                                                            </div>
                                                            <div class="form-group">
                                                                <label>Autor (es)</label>
                                                                <ui-select name="selectAutor" multiple="" data-ng-model="selectedAutores.selected" 
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
                                                                <div data-ng-show="formAddReferencias.inputTitulo.$invalid">
                                                                    <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label>Nota</label>
                                                                <textarea class="form-control" name="inputNota" placeholder="Breve descripci&oacute;n sobre la referencia"
                                                                          data-ng-model="referencia.nota" required=""></textarea>
                                                                <div data-ng-show="formAddReferencias.inputNota.$invalid">
                                                                    <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label>A&ntilde;o</label>
                                                                <input name="inputYear" class="form-control" data-ng-minlength="2" data-ng-maxlength="4"
                                                                       data-ng-model="referencia.fecha" required="" placeholder="yyyy"/>
                                                                <div data-ng-show="formAddReferencias.inputYear.$invalid">
                                                                    <span style="color:red; display: block; text-align: left;">Introduzca un valor de entre 2 y 4 digitos</span>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label>P&aacute;ginas</label>
                                                                <input name="inputPaginas" class="form-control" placeholder="N&uacute;mero de p&aacute;gina o rango de p&aacute;ginas"
                                                                       data-ng-model="referencia.pages" required=""/>
                                                                <div data-ng-show="formAddReferencias.inputPaginas.$invalid">
                                                                    <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                                                </div>
                                                            </div> 
                                                            <div class="form-group">
                                                                <label>Lugar o Pa&iacute;s</label>
                                                                <input name="inputLugar" class="form-control" style="text-transform: capitalize"
                                                                       data-ng-model="referencia.lugar" required=""/>
                                                                <div data-ng-show="formAddReferencias.inputLugar.$invalid">
                                                                    <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label>Categor&iacute;a (s) </label>
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
                                                            <div class="form-group"  data-ng-show="selectedFuente.selected.idFuente === 1">
                                                                <label>Número de Informe</label>
                                                                <input class="form-control" maxlength="8" data-ng-model="referencia.informeNum"/>
                                                            </div>
                                                            <div class="form-group"  data-ng-show="selectedFuente.selected.idFuente === 1">
                                                                <label>Tipo de Informe</label>
                                                                <input class="form-control" style="text-transform: capitalize"
                                                                       data-ng-model="referencia.informeTipo"/>
                                                            </div>
                                                            <div class="form-group"  data-ng-show="selectedFuente.selected.idFuente === 1">
                                                                <label>Instituci&oacute;n</label>
                                                                <input class="form-control" style="text-transform: capitalize"
                                                                       data-ng-model="referencia.informeInstitution"/>
                                                            </div>

                                                            <div class="form-group"  data-ng-show="selectedFuente.selected.idFuente === 1">
                                                                <label>T&iacute;tulo de la serie</label>
                                                                <input class="form-control" style="text-transform: capitalize"
                                                                       data-ng-model="referencia.informeSerie"/>
                                                            </div>
                                                            <div class="form-group" data-ng-show="selectedFuente.selected.idFuente === 2">
                                                                <label>Publicaci&oacute;n</label>
                                                                <input class="form-control" data-ng-model="referencia.arcPublication"/>
                                                            </div>

                                                            <div class="form-group" 
                                                                 data-ng-show="selectedFuente.selected.idFuente === 2 ||
                                                                                         selectedFuente.selected.idFuente === 3">
                                                                <label>N&uacute;mero</label>
                                                                <input class="form-control" data-ng-model="referencia.volumen"/>
                                                            </div>

                                                            <div class="form-group" 
                                                                 data-ng-show="selectedFuente.selected.idFuente === 2 ||
                                                                                         selectedFuente.selected.idFuente === 3">
                                                                <label>Volumen o tomo</label>
                                                                <input class="form-control" data-ng-model="referencia.numVol"/>
                                                            </div>

                                                            <div class="form-group" 
                                                                 data-ng-show="selectedFuente.selected.idFuente === 3 ||
                                                                                         selectedFuente.selected.idFuente === 4 ||
                                                                                         selectedFuente.selected.idFuente === 5">
                                                                <label>Editorial</label>
                                                                <input class="form-control" data-ng-model="referencia.editorial"/>
                                                            </div>
                                                            <div class="form-group" data-ng-show="selectedFuente.selected.idFuente === 3 ||
                                                                                    selectedFuente.selected.idFuente === 4">
                                                                <label>Edici&oacute;n</label>
                                                                <input class="form-control" data-ng-model="referencia.edition"/>
                                                            </div>
                                                            <div class="form-group" data-ng-show="selectedFuente.selected.idFuente === 4">
                                                                <label>T&iacute;tulo del Libro</label>
                                                                <input class="form-control" data-ng-model="referencia.secclTitle"/>
                                                            </div>
                                                            <div class="form-group"data-ng-show="selectedFuente.selected.idFuente === 5">
                                                                <label>Universidad</label>
                                                                <input class="form-control" data-ng-model="referencia.tesisUniversidad"/>
                                                            </div>
                                                            <div class="form-group">
                                                                <label>URL</label>
                                                                <input class="form-control" type="url" data-ng-model="referencia.url"/>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="submit" class="btn btn-primary" data-ng-disabled="formAddReferencias.$invalid">Aceptar</button>
                                                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
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
                                                            <form role="form" method="delete" data-ng-submit="eliminarReferencia()" id="delete_data" class="text-right">
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
