<%-- 
    Document   : gestionarUsuarios
    Created on : 08-mar-2018, 21:46:32
    Author     : albert
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib  prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html data-ng-app="appUsuarios">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--GLOBAL STYLES-->
        <jsp:include page="/WEB-INF/includes/globalcss.jsp"/>
        <!-- PAGE LEVEL STYLES -->
        
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/AngularJs/angular-datatables.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/AngularJs/datatables.bootstrap.min.css">

        <script src="${pageContext.request.contextPath}/static/AngularJs/jQuery-3.3.1.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/jquery.dataTables.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular-datatables.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular-datatables.bootstrap.min.js"></script>
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
                        <div class="col-md-12">
                            <br />
                            <!--TABLA USUARIOS-->
                            <div class="panel panel-default">
                                <div class="panel-heading">Administraci&oacute;n de usuarios</div>
                                <div class="panel-body">
                                    <div class="table-responsive">
                                        <table datatable="ng" id="tablaUsuarios" class="table table-striped table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Acciones</th>
                                                    <th>Email</th>
                                                    <th>Nombre y Apellidos</th>
                                                    <th>Rol</th>
                                                    <th>Estado</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr data-ng-repeat="usuarios in allUsuarios track by $index">
                                                    <td>
                                                        <input type="hidden" value="{{usuarios.idUsuario}}"/>
                                                        <button class="btn btn-primary" data-toggle="modal" data-target="#formModalCreateOrEdit" 
                                                                data-ng-click="abrirEditarModal($index)">
                                                            <i class="glyphicon glyphicon-pencil"></i></button>
                                                        <button class="btn btn-danger" data-toggle="modal" data-target="#formModalLockUser"
                                                                data-ng-click="abrirEliminarModal($index)"
                                                                data-ng-show="usuarios.activo">
                                                            <i class="glyphicon glyphicon-lock"></i></button>
                                                        <button class="btn btn-success" data-toggle="modal" data-target="#formModalLockUser"
                                                                data-ng-click="abrirEliminarModal($index)"
                                                                data-ng-show="!usuarios.activo">
                                                            <i class="glyphicon glyphicon-ok"></i></button>
                                                    </td>
                                                    <td>{{usuarios.email}}</td>
                                                    <td>{{usuarios.nombre}} {{usuarios.apellidos}}</td>
                                                    <td>{{usuarios.idRol.tipoRol}}</td>
                                                    <td class="text-center">
                                                        <span class="label label-success" data-ng-show="usuarios.activo">Habilitado</span>
                                                        <span class="label label-danger" data-ng-show="!usuarios.activo">Bloqueado</span>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="panel-default panel-footer">Usuarios</div>
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
                                            <h4 class="modal-title" id="H2">Cambiar rol a usuario</h4>
                                        </div>
                                        <div class="modal-body">
                                            <form role="form" data-ng-submit="addOrEditUsuario()" method="post">
                                                <div class="form-group">
                                                    <label>Rol</label>
                                                    <br>
                                                    <select class="form-control" 
                                                            ng-model="selectedRol" 
                                                            ng-options="rol.idRoles as rol.tipoRol for rol in allRoles">
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
                            <div class="modal fade" id="formModalLockUser" role="dialog" style="display: none;">
                                <div class="modal-dialog" style="margin-top: 260.5px;">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                            <h4 class="modal-title" data-ng-show="indiceRegistro.activo">
                                                ¿Bloquear la cuenta de este usuario?
                                            </h4>
                                            <h4 class="modal-title" data-ng-show="!indiceRegistro.activo">
                                                ¿Habilitar la cuenta este usuario?
                                            </h4>
                                            <div class="modal-body">
                                                <p>{{indiceRegistro.nombre}} {{indiceRegistro.apellidos}}</p>
                                                <p>email: {{indiceRegistro.email}} </p>
                                                <form role="form" method="post" data-ng-submit="lockUser()" id="delete_data" class="text-right">
                                                    <button type="submit" class="btn btn-danger"data-ng-show="indiceRegistro.activo">Bloquear cuenta</button>
                                                    <button type="submit" class="btn btn-success" data-ng-show="!indiceRegistro.activo">Habilitar cuenta</button>
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
