<%-- 
    Document   : gestionarAlimentos
    Created on : 28-mar-2018, 14:32:19
    Author     : albert
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html data-ng-app="appCategorias">
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
        <script src="${pageContext.request.contextPath}/static/AngularJs/Categorias.js"></script>
        <!--END PAGE LEVEL STYLES-->
    </head>
    <body class="padTop53" data-ng-controller="CategoriasController">
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
                                    <button id="añadirButton" class="icon-plus btn btn-success" data-ng-click="abrirNuevaCategoriaModal()"
                                            data-toggle="modal" data-target="#formModalCreateOrEdit"> Nueva Categoria</button>
                                </div>
                                <!--END ABRIR MODAL AÑADIR-->
                                <!--TABLA CATEGORIAS-->
                                <div class="panel-body">
                                    <div class="table-responsive">
                                        <table  datatable="ng" id="tablaCategorias" class="table table-striped table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Acciones</th>
                                                    <th>Categor&iacute;a</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr data-ng-repeat="cat in allCategorias track by $index">
                                                    <td>
                                                        <input type="hidden" value="{{cat.idCategoria}}"/>
                                                        <button class="btn btn-primary btn-xs" data-toggle="modal" data-target="#formModalCreateOrEdit" 
                                                                data-ng-click="abrirEditarModal($index)">
                                                            <i class="glyphicon glyphicon-pencil"></i></button>
                                                        <button class="btn btn-danger btn-xs" data-toggle="modal" data-target="#formModalEliminar"
                                                                data-ng-click="abrirEliminarModal($index)">
                                                            <i class="glyphicon glyphicon-trash"></i></button>
                                                    </td>
                                                    <td>{{cat.categoria}}</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="panel-footer panel-default">Categor&iacute;as</div>
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
                                        <h4 class="modal-title" id="H2">Categor&iacute;a</h4>
                                    </div>
                                    <div class="modal-body">
                                        <form role="form" data-ng-submit="createOrEditCategoria()" 
                                              name="formAddCategoria" method="post">
                                            <div class="form-group">
                                                <label>Categor&iacute;a</label>
                                                <input class="form-control" data-ng-pattern="/^[a-zA-z]*$/" name="inputCategorias"
                                                       required="" data-ng-model="categoria.categoria"/>
                                                <div class="text-center" data-ng-show="formAddCategoria.inputCategorias.$invalid">
                                                    <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                                    <span style="color:red; display: block; text-align: left;">Este campo no admite caracteres numéricos</span>
                                                </div>
                                                <br />
                                                <div class="text-right">
                                                    <input type="hidden" data-ng-model="categoria.idCategoria"/>
                                                    <button type="submit" class="btn btn-success" data-ng-disabled="formAddCategoria.$invalid">Guardar</button>
                                                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                                                </div>
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
                                            <form role="form" method="post" data-ng-submit="eliminarCategoria()" id="delete_data" class="text-right">
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
        <!--END PAGE CONTENT -->
        <!--END MAIN WRAP-->
        <!-- FOOTER -->
        <jsp:include page="/WEB-INF/includes/footer.jsp"/>
        <!--END FOOTER -->
        <!--GLOBAL SCRIPTS-->
        <jsp:include page="/WEB-INF/includes/globalScripts.jsp"/>
        <!--END GLOBAL SCRIPTS-->
    </body>
</html>
