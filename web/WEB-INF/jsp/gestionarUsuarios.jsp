<%-- 
    Document   : gestionarUsuarios
    Created on : 08-mar-2018, 21:46:32
    Author     : albert
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html data-ng-app="appUsuarios">
    <head>
        <!--GLOBAL STYLES-->
        <jsp:include page="/WEB-INF/includes/globalcss.jsp"/>
        <!-- PAGE LEVEL STYLES -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/jquery-ui.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/uniform/themes/default/css/uniform.default.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/inputlimiter/jquery.inputlimiter.1.0.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/chosen/chosen.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/colorpicker/css/colorpicker.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/tagsinput/jquery.tagsinput.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/daterangepicker/daterangepicker-bs3.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/datepicker/css/datepicker.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/timepicker/css/bootstrap-timepicker.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/switch/static/stylesheets/bootstrap-switch.css" />
        
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/Usuarios.js"></script>
        <!--END PAGE LEVEL STYLES-->
    </head>
    <body class="padTop53" data-ng-controller="UsuariosController">

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
                            <h1 class="text-center">Gestionar Usuarios</h1>
                            <!--ABRIR MODAL AÑADIR-->
                            <button id="añadirButton" class="btn btn-success" data-toggle="modal" data-target="#formModalCreateOrEdit">
                                <span class="glyphicon glyphicon-plus-sign" data-ng-click="getRoles()"></span> Nuevo</button>
                            <!--END ABRIR MODAL AÑADIR-->
                            <br/>
                            <!--TABLA USUARIOS-->
                            <table class="table table-hover table-responsive table-bordered">
                                <thead>
                                <th>Email</th>
                                <th>Nombre</th>
                                <th>Rol</th>
                                <th>Acciones</th>
                                </thead>
                                <tbody>
                                    <tr data-ng-show="allUsuarios.length === 0">
                                        <td colspan="4" class="warning">No hay registros para mostrar</td>
                                    </tr>
                                    <tr data-ng-repeat="usuarios in allUsuarios track by $index">
                                        <td>{{usuarios.email}}</td>
                                        <td>{{usuarios.nombre}} {{usuarios.apellidos}}</td>
                                        <td>{{usuarios.idRol.tipoRol}}</td>
                                        <td>
                                            <input type="hidden" value="{{usuarios.idUsuario}}"/>
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
                        </div>
                        <!--CREATE OR EDIT MODAL-->
                        <div class="col-lg-12">
                            <div class="modal fade" id="formModalCreateOrEdit" tabindex="-1" 
                                 role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="H2">Editar Usuario</h4>
                                        </div>
                                        <div class="modal-body">
                                            <form role="form" data-ng-submit="addOrEditUsuario()" method="post">
                                                <div class="form-group">
                                                    <label>Email</label>
                                                    <input class="form-control" type="text" 
                                                           required="" data-ng-model="indiceRegistro.email"/>
                                                    <label>Nombre</label>
                                                    <input class="form-control" type="text" 
                                                           required="" data-ng-model="indiceRegistro.nombre"
                                                           style=" text-transform: capitalize"/>
                                                    <label>Apellidos</label>
                                                    <input class="form-control" type="text" 
                                                           required="" data-ng-model="indiceRegistro.apellidos"
                                                           style=" text-transform: capitalize"/>
                                                    <label>Rol</label>
                                                    <br>
                                                    <select class="form-control" 
                                                            ng-model="selectedRol" 
                                                            ng-options="rol.tipoRol for rol in allRoles">
                                                    </select>
                                                </div>
                                                <div class="text-right">
                                                    <input type="hidden" data-ng-model="indiceRegistro.idUsuario"/>
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
                                            <input class="form-control" type="text" required=""
                                                   data-ng-model="indiceRegistro.email"/>
                                            <div class="modal-body">
                                                <form role="form" method="post" data-ng-submit="eliminarUsuario()" id="delete_data" class="text-right">
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
        <!--END GLOBAL SCRIPTS-->
        <!--PAGE LEVEL SCRIPTS-->
        <!--END PAGE LEVEL SCRIPTS-->
    </body>
</html>
