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
                        <div class="col-lg-12">
                            <h1 class="text-center">Administraci&oacute;n de usuarios</h1>
                            <br/>
                            <!--TABLA USUARIOS-->
                            <table datatable="ng" class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>Acciones</th>
                                        <th>Email</th>
                                        <th>Nombre y Apellidos</th>
                                        <th>Rol</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr data-ng-repeat="usuarios in allUsuarios track by $index">
                                        <td>
                                            <input type="hidden" value="{{usuarios.idUsuario}}"/>
                                            <button class="btn btn-primary" data-toggle="modal" data-target="#formModalCreateOrEdit" 
                                                    data-ng-click="abrirEditarModal($index)">
                                                <i class="glyphicon glyphicon-pencil"></i></button>
                                            <button class="btn btn-danger" data-toggle="modal" data-target="#formModalEliminar"
                                                    data-ng-click="abrirEliminarModal($index)">
                                                <i class="glyphicon glyphicon-trash"></i></button>
                                        </td>
                                        <td>{{usuarios.email}}</td>
                                        <td>{{usuarios.nombre}} {{usuarios.apellidos}}</td>
                                        <td>{{usuarios.idRol.tipoRol}}</td>
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
                            <div class="modal fade" id="formModalEliminar" role="dialog" style="display: none;">
                                <div class="modal-dialog" style="margin-top: 260.5px;">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                            <h4 class="modal-title">¿Seguro que desea eliminar este registro?</h4>
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
