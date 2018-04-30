<%-- 
    Document   : gestionarAlimentos
    Created on : 28-mar-2018, 14:32:19
    Author     : albert
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html data-ng-app="appAutores">
    <head>
        <jsp:include page="/WEB-INF/includes/globalcss.jsp"/>
        <!-- PAGE LEVEL STYLES -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/AngularJs/angular-datatables.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/AngularJs/datatables.bootstrap.min.css">


        <script src="${pageContext.request.contextPath}/static/AngularJs/jQuery-3.3.1.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/jquery.dataTables.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular-datatables.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular-datatables.bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/Autores.js"></script>
        <!--END PAGE LEVEL STYLES-->
    </head>
    <body class="padTop53" data-ng-controller="AutoresController">
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
                                    <button id="añadirButton" class="icon-plus btn btn-success" data-ng-click="abrirNuevoAutorModal()"
                                            data-toggle="modal" data-target="#formModalCreateOrEdit"> Nuevo Autor</button>
                                    <!--END ABRIR MODAL AÑADIR-->
                                </div>
                                <!--TABLA AUTORES-->
                                <div class="panel-body">
                                    <div class="table-responsive">
                                        <table  datatable="ng" id="tablaAutores" class="table table-striped table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Acciones</th>
                                                    <th>Nombre (y Segundo Nombre)</th>
                                                    <th>Apellidos</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr data-ng-repeat="a in allAutores track by $index">
                                                    <td>
                                                        <input type="hidden" value="{{a.idAutor}}"/>
                                                        <button class="btn btn-primary btn-xs" data-toggle="modal" data-target="#formModalCreateOrEdit" 
                                                                data-ng-click="abrirEditarModal($index)">
                                                            <i class="glyphicon glyphicon-pencil"></i></button>
                                                        <button class="btn btn-danger btn-xs" data-toggle="modal" data-target="#formModalEliminar"
                                                                data-ng-click="abrirEliminarModal($index)">
                                                            <i class="glyphicon glyphicon-trash"></i></button>
                                                    </td>
                                                    <td>{{a.nombre}} {{a.segundoNombre}}</td>
                                                    <td>{{a.apellidos}}</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="panel-footer panel-default">
                                    <a>Autores</a>
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
                                        <h4 class="modal-title" id="H2">Autor</h4>
                                    </div>
                                    <div class="modal-body">
                                        <form role="form" data-ng-submit="createOrEditAutor()" method="post">
                                            <div class="form-group">
                                                <label>Nombre</label>
                                                <input class="form-control" type="text" 
                                                       required="" data-ng-model="autor.nombre"/>
                                                <label>Segundo Nombre</label>
                                                <input class="form-control" type="text" 
                                                       data-ng-model="autor.segundoNombre"/>
                                                <label>Apellidos</label>
                                                <input class="form-control" type="text" 
                                                       required="" data-ng-model="autor.apellidos"/>
                                            </div>
                                            <div class="text-right">
                                                <input type="hidden" data-ng-model="autor.idAutor"/>
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
                                            <form role="form" method="post" data-ng-submit="eliminarAutor()" id="delete_data" class="text-right">
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
