<%-- 
    Document   : gestionarAlimentos
    Created on : 28-mar-2018, 14:32:19
    Author     : albert
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html data-ng-app="appAlimentos">
    <head>
        <jsp:include page="/WEB-INF/includes/globalcss.jsp"/>
        <!-- PAGE LEVEL STYLES -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/jquery-ui.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/uniform/themes/default/css/uniform.default.css" />

        
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/Alimentos.js"></script>
        <!--END PAGE LEVEL STYLES-->
    </head>
    <body class="padTop53" data-ng-controller="AlimentosController">
        <!--MAIN WRAP-->
        <div id="wrap">
            <!-- HEADER SECTION -->
            <jsp:include page="/WEB-INF/includes/header.jsp"/>
            <!-- END HEADER SECTION -->
            <!-- MENU SECTION -->
            <jsp:include page="/WEB-INF/includes/menuContent.jsp"/>
            <!--END MENU SECTION -->
            <!--END MENU SECTION -->
            <!--PAGE CONTENT -->
            <div id="content">
                <div class="inner" style="min-height:800px;">
                    <div class="row">
                        <div class="col-lg-12">
                            <br />
                            <div class="panel panel-default">
                                <!--ABRIR MODAL AÑADIR-->
                                <div class="panel-heading  ">
                                    <button id="añadirButton" class="btn btn-success" data-toggle="modal" data-target="#formModalCreateOrEdit">
                                        <span class="glyphicon glyphicon-plus-sign"></span> Nuevo</button>
                                    <!--END ABRIR MODAL AÑADIR-->
                                    <a> PONER AQUI LA REFERENCIA EN CUESTION</a>
                                </div>
                                <!--TABLA ROLES-->
                                <div class="panel-body">
<!--                                    <div class="col-md-3">
                                        <select id="selectPaginas" class="form-control">
                                            <option>5 Registros por P&aacute;gina</option>
                                            <option>10 Registros por P&aacute;gina</option>
                                            <option>20 Registros por P&aacute;gina</option>
                                        </select>
                                    </div>
                                    <br />   <br />-->
                                    <table class="table table-hover table-responsive table-bordered">
                                        <thead style="background-color: #f3f3f3">
                                        <th>Nombre Cient&iacute;fico</th>
                                        <th>Nombre</th>
                                        <th>Variedad</th>
                                        <th>Parte</th>
                                        <th>Tipo Cuba</th>
                                        <th>Tipo FAO</th>
                                        <th>Tipo NRC</th>
                                        <th>Usuario</th>
                                        <th>Acciones</th>
                                        </thead>
                                        <tbody>
                                            <tr data-ng-show="allAlimentos.length === 0">
                                                <td colspan="4" class="warning">No hay registros para mostrar</td>
                                            </tr>
                                            <tr data-ng-repeat="alimento in allAlimentos track by $index">
                                                <td>{{alimento.nombreCient}}</td>
                                                <td>{{alimento.nombre}}</td>
                                                <td>{{alimento.variedad}}</td>
                                                <td>{{alimento.parte}}</td>
                                                <td>{{alimento.idTipoCuba.tipoCuba}}</td>
                                                <td>{{alimento.idTipoFao.tipoFao}}</td>
                                                <td>{{alimento.idTipoNrc.tipoNrc}}</td>
                                                <td>{{alimento.idUsuario.nombre}}</td>
                                                <td>
                                                    <input type="hidden" value="{{alimento.idAlimento}}"/>
                                                    <button class="btn btn-success" data-ng-click="abrirEditarModal($index)">
                                                        <i class="glyphicon glyphicon-eye-open"></i></button>
                                                    <button class="btn btn-primary" data-toggle="modal" data-target="#formModalCreateOrEdit" 
                                                            data-ng-click="abrirEditarModal($index)">
                                                        <i class="glyphicon glyphicon-pencil"></i></button>
                                                    <button class="btn btn-danger" data-toggle="modal" data-target="#formModalEliminar"
                                                            data-ng-click="abrirEliminarModal($index)">
                                                        <i class="glyphicon glyphicon-trash"></i></button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>

                                    <!--PAGINACION BOTONES-->
                                    <div class="text-center">
                                        <div class="btn-group">
                                            <a id="botonAnterior" class="btn btn-default" data-ng-click="previousPage()">Anterior</a>
                                            <a class="btn-primary btn">{{paginaActual}}</a>
                                            <a  class="btn btn-default" data-ng-click="nextPage()">Siguiente</a>
                                        </div>
                                    </div>
                                    <!--END PAGINACION BOTONES-->
                                </div>
                                <div class="panel-footer panel-default">
                                    <a>PONER ALGO AQUI</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--CREATE OR EDIT MODAL-->
                    <div class="col-lg-12">
                        <div class="modal fade" id="formModalCreateOrEdit" tabindex="-1" 
                             role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                        <h4 class="modal-title" id="H2">Editar Alimento</h4>
                                    </div>
                                    <div class="modal-body">
                                        <form role="form" data-ng-submit="createOrEditAlimento()" method="post">
                                            <div class="form-group">
                                                <label>Nombre Cient&iacute;fico</label>
                                                <input class="form-control" type="text" 
                                                       required="" data-ng-model="indiceRegistro.nombreCient"
                                                       style="text-transform: capitalize"/>
                                                <label>Nombre</label>
                                                <input class="form-control" type="text" 
                                                       required="" data-ng-model="indiceRegistro.nombre"
                                                       style=" text-transform: capitalize"/>
                                                <label>Variedad</label>
                                                <input class="form-control" type="text" 
                                                       required="" data-ng-model="indiceRegistro.variedad"
                                                       style=" text-transform: capitalize"/>
                                                <label>Parte</label>
                                                <input class="form-control" type="text" 
                                                       required="" data-ng-model="indiceRegistro.parte"
                                                       style=" text-transform: capitalize"/>
                                                <label>Tipo en Cuba</label>
                                                <br>
                                                <select class="form-control" 
                                                        ng-model="selectedTipoCuba" 
                                                        ng-options="tipoCuba.idTipoCuba as tipoCuba.tipoCuba for tipoCuba in allTipoCuba">
                                                </select>
                                                <label>Tipo en FAO</label>
                                                <br>
                                                <select class="form-control" 
                                                        ng-model="selectedTipoFao" 
                                                        ng-options="tipoFao.idTipoFao as tipoFao.tipoFao for tipoFao in allTipoFao">
                                                </select>
                                                <label>Tipo en NRC</label>
                                                <br>
                                                <select class="form-control" 
                                                        ng-model="selectedTipoNrc" 
                                                        ng-options="tipoNrc.idTipoNrc as tipoNrc.tipoNrc for tipoNrc in allTipoNrc">
                                                </select>
                                            </div>
                                            <div class="text-right">
                                                <input type="hidden" data-ng-model="indiceRegistro.idAlimento"/>
                                                <button type="submit" class="btn btn-success">Guardar</button>
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--END EDIT MODAL-->
                    <!--DELETE MODAL-->
                    <div>
                        <div class="modal fade" id="formModalEliminar" role="dialog" style="display: none;">
                            <div class="modal-dialog" style="margin-top: 260.5px;">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                        <h4 class="modal-title">¿Seguro que desea eliminar este registro?</h4>
                                        <label>Email</label>
                                        <div class="modal-body">
                                            <form role="form" method="post" data-ng-submit="eliminarAlimento()" id="delete_data" class="text-right">
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
        <!--END PAGE CONTENT -->
        <!--END MAIN WRAP-->
        <!-- FOOTER -->
        <jsp:include page="/WEB-INF/includes/footer.jsp"/>
        <!--END FOOTER -->

        <!--GLOBAL SCRIPTS-->
        <jsp:include page="/WEB-INF/includes/globalScripts.jsp"/>
        <!--END GLOBAL SCRIPTS-->
        <!--PAGE LEVEL SCRIPTS-->
        <!--END PAGE LEVEL SCRIPTS-->
    </body>
</html>
