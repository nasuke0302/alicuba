<%-- 
    Document   : gestionarAlimentos
    Created on : 28-mar-2018, 14:32:19
    Author     : albert
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib  prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html data-ng-app="appTablasGeneradas">
    <head>
        <jsp:include page="/WEB-INF/includes/globalcss.jsp"/>
        <!-- PAGE LEVEL STYLES -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/AngularJs/angular-datatables.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/AngularJs/datatables.bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/AngularJs/loadingBar/loading-bar.min.css">

        <script src="${pageContext.request.contextPath}/static/AngularJs/jQuery-3.3.1.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/jquery.dataTables.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular-datatables.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular-datatables.bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/loadingBar/loading-bar.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/TablasGeneradas.js"></script>
        <!--END PAGE LEVEL STYLES-->
    </head>
    <body class="padTop53" data-ng-controller="TablasGeneradasController">
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
                                    <button id="añadirButton" class="icon-plus btn btn-success" data-ng-click="abrirNuevaTablaGeneradaModal()"
                                            data-toggle="modal" data-target="#formModalCreate"> Generar nueva tabla</button>
                                    <!--END ABRIR MODAL AÑADIR-->
                                </div>
                                <!--TABLA Alimentos-->
                                <div class="panel-body">
                                    <div class="table-responsive">
                                        <table  datatable="ng" id="tablaAlimentos" class="table table-striped table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Acciones</th>
                                                    <th>Nombre de la Tabla</th>
                                                    <th>Fecha</th>
                                                    <th>Editor</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr data-ng-repeat="tg in allTablasGeneradas track by $index"> 
                                                    <td>
                                                        <input type="hidden" value="{{tg.idListadoTablasGeneradas}}"/>
                                                        <button class="btn btn-primary btn-xs" data-ng-click="editarTablaG($index)">
                                                            <i class="glyphicon glyphicon-pencil"></i></button>
                                                        <button class="btn btn-danger btn-xs" data-toggle="modal" data-target="#formModalEliminar"
                                                                data-ng-click="abrirEliminarModal($index)">
                                                            <i class="glyphicon glyphicon-trash"></i></button>
                                                    </td>
                                                    <td>{{tg.nombre}}</td>
                                                    <td>{{tg.fechaHora}}</td>
                                                    <td>{{tg.idUsuario.nombre}}</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="panel-footer panel-default">Listado de tablas generadas</div>
                                <!--CREATE MODAL-->
                                <div class="col-lg-12">
                                    <div class="modal fade" id="formModalCreate" tabindex="-1" 
                                         role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                    <h4 class="modal-title" id="H2">Tabla</h4>
                                                </div>
                                                <div class="modal-body">
                                                    <form role="form" data-ng-submit="createTablaG()" 
                                                          name="formAddTablaG" method="post">
                                                        <div class="form-group">
                                                            <label>Nombre</label>
                                                            <input class="form-control" name="inputNombre"
                                                                   required="" data-ng-model="tablaGenerada.nombre"/>
                                                            <div class="text-center" data-ng-show="formAddTablaG.inputNombre.$invalid">
                                                                <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                                            </div>
                                                            <br />
                                                            <div class="text-right">
                                                                <input type="hidden" data-ng-model="tablaGenerada.idListadoTablaGeneradas"/>
                                                                <input type="hidden" data-ng-model="tablaGenerada.idUsuario"/>
                                                                <button type="submit" class="btn btn-success" data-ng-disabled="formAddTablaG.$invalid">Guardar</button>
                                                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--END CREATE MODAL-->
                                <!--DELETE MODAL-->
                                <div>
                                    <div class="modal fade" id="formModalEliminar" role="dialog" style="display: none;">
                                        <div class="modal-dialog" style="margin-top: 260.5px;">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                    <h4 class="modal-title">¿Seguro que desea eliminar este registro?</h4>
                                                    <div class="modal-body">
                                                        <form role="form" method="post" data-ng-submit="eliminarTablaGenerada()" id="delete_data" class="text-right">
                                                            <p>{{tablaGenerada.nombre}}
                                                                {{tablaGenerada.fechaHora}}</p>
                                                            <button type="submit" class="btn btn-danger">Eliminar</button>
                                                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--END DELETE MODAL-->
                            </div>
                        </div>
                    </div>
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
