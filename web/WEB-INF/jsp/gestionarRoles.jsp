<%-- 
    Document   : gestionarRoles
    Created on : 08-mar-2018, 22:09:45
    Author     : albert
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html data-ng-app="AppRoles">
    <head>
        <!--GLOBAL STYLES-->
        <jsp:include page="/WEB-INF/includes/globalcss.jsp"/>
        <!-- PAGE LEVEL STYLES -->
        <link rel="stylesheet" href="<c:url value="/static/css/jquery-ui.css"/>">
        <link rel="stylesheet" href="<c:url value="/static/plugins/uniform/themes/default/css/uniform.default.css"/>">
        <link rel="stylesheet" href="<c:url value="/static/plugins/inputlimiter/jquery.inputlimiter.1.0.css"/>">
        <link rel="stylesheet" href="<c:url value="/static/plugins/chosen/chosen.min.css"/>">
        <link rel="stylesheet" href="<c:url value="/static/plugins/colorpicker/css/colorpicker.css"/>">
        <link rel="stylesheet" href="<c:url value="/static/plugins/tagsinput/jquery.tagsinput.css"/>">
        <link rel="stylesheet" href="<c:url value="/static/plugins/daterangepicker/daterangepicker-bs3.css"/>">
        <link rel="stylesheet" href="<c:url value="/static/plugins/datepicker/css/datepicker.css"/>">
        <link rel="stylesheet" href="<c:url value="/static/plugins/timepicker/css/bootstrap-timepicker.min.css"/>">
        <link rel="stylesheet" href="<c:url value="/static/plugins/switch/static/stylesheets/bootstrap-switch.css"/>">
        
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/Roles.js"></script>
        <!--END PAGE LEVEL STYLES-->

    </head>
    <body class="padTop53" data-ng-controller="RolesController">
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
                    <h1 class="text-center">Listado de Roles</h1> <br>
                    <!--ABRIR MODAL AÑADIR-->
                    <button id="añadirButton" class="btn btn-success" data-toggle="modal" data-target="#formModalCreateOrEdit">
                        <span class="glyphicon glyphicon-plus-sign"></span> Nuevo</button>
                    <!--END ABRIR NUEVO ROL-->
                    <br/>
                    <div>
                        <!--TABLA ROLES-->
                        <table class="table table-hover table-responsive">
                            <thead>
                            <th>Rol</th>
                            <th>Acciones</th>
                            </thead>
                            <tbody>
                                <tr data-ng-show="allRoles.length === 0">
                                    <td colspan="4" class="warning">No hay registros para mostrar</td>
                                </tr>
                                <tr data-ng-repeat="roles in allRoles track by $index">
                                    <td>{{roles.tipoRol}}</td>
                                    <td>
                                        <input type="hidden" value="{{roles.idRol}}"/>
                                        <button class="btn btn-primary" data-toggle="modal" 
                                                data-target="#formModalCreateOrEdit"
                                                data-ng-click="abrirEditarModal($index)">
                                            <i class="glyphicon glyphicon-pencil"></i></button>
                                        <button class="btn btn-danger" data-toggle="modal" 
                                                data-target="#formModalEliminar"
                                                data-ng-click="abrirEliminarModal($index)">
                                            <i class="glyphicon glyphicon-trash"></i></button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <!--END TABLA ROLES-->
                <!--CREATE OR EDIT MODAL-->
                <div class="col-lg-12">
                    <div class="modal fade" id="formModalCreateOrEdit" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    <h4 class="modal-title" id="H2">Editar Rol</h4>
                                </div>
                                <div class="modal-body">
                                    <form role="form" data-ng-submit="addOrEditRol()" method="post" class="text-right">
                                        <div class="form-group">
                                            <label>Rol</label>
                                            <input class="form-control" type="text" 
                                                   required="" data-ng-model="indiceRegistro.tipoRol"
                                                   style=" text-transform: capitalize"/>
                                        </div>
                                        <div class="text-right">
                                            <input type="hidden" data-ng-model="indiceRegistro.idRol"/>
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
                                    <h4 class="modal-title">¿Seguro que quiere eliminar este registro?</h4>
                                    <label>Rol</label>
                                    <input class="form-control" type="text" required=""
                                           data-ng-model="indiceRegistro.tipoRol"/>
                                    <input class="form-control" type="text" required=""
                                           data-ng-model="indiceRegistro.idRoles"/>
                                </div>
                                <div class="modal-body">
                                    <form role="form" method="post"  data-ng-submit="eliminarRol()" id="delete_data" class="text-right">
                                        <button type="submit" class="btn btn-success">Eliminar</button>
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                                    </form>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <!--END DELETE MODAL-->
            </div>
            <!--END PAGE CONTENT -->
        </div>
        <!--END MAIN WRAP-->
        <!-- FOOTER -->
        <jsp:include page="/WEB-INF/includes/footer.jsp"/>
        <!--END FOOTER -->

        <!--GLOBAL SCRIPTS-->
        <jsp:include page="/WEB-INF/includes/globalScripts.jsp"/>

        <!--END PAGE LEVEL SCRIPTS-->
        <script src="${pageContext.request.contextPath}/static/js/jquery-ui.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/plugins/uniform/jquery.uniform.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/plugins/inputlimiter/jquery.inputlimiter.1.3.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/plugins/chosen/chosen.jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/plugins/colorpicker/js/bootstrap-colorpicker.js"></script>
        <script src="${pageContext.request.contextPath}/static/plugins/tagsinput/jquery.tagsinput.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/plugins/validVal/js/jquery.validVal.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/plugins/daterangepicker/daterangepicker.js"></script>
        <script src="${pageContext.request.contextPath}/static/plugins/daterangepicker/moment.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/plugins/datepicker/js/bootstrap-datepicker.js"></script>
        <script src="${pageContext.request.contextPath}/static/plugins/timepicker/js/bootstrap-timepicker.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/plugins/switch/static/js/bootstrap-switch.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/plugins/jquery.dualListbox-1.3/jquery.dualListBox-1.3.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/plugins/autosize/jquery.autosize.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/plugins/jasny/js/bootstrap-inputmask.js"></script>
        <script src="${pageContext.request.contextPath}/static/js/formsInit.js"></script>
        <script>
                                        $(function () {
                                            formInit();
                                        });
        </script>

        <script>
            $(document).ready(function () {

            });
        </script>

        <!--END PAGE LEVEL SCRIPTS-->
    </body>
</html>
