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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/AngularJs/angular-datatables.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/AngularJs/datatables.bootstrap.min.css">


        <script src="${pageContext.request.contextPath}/static/AngularJs/jQuery-3.3.1.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/jquery.dataTables.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular-datatables.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular-datatables.bootstrap.min.js"></script>
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
                                    <button id="añadirButton" class="icon-plus btn btn-success" data-ng-click="abrirNuevoAlimentoModal()"
                                            data-toggle="modal" data-target="#formModalCreateOrEdit"> Nuevo Alimento</button>
                                    <!--END ABRIR MODAL AÑADIR-->
                                </div>
                                <!--TABLA Alimentos-->
                                <div class="panel-body">
                                    <div class="table-responsive">
                                        <table  datatable="ng" id="tablaAlimentos" class="table table-striped table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Acciones</th>
                                                    <th>Nombre Cient&iacute;fico</th>
                                                    <th>Nombre</th>
                                                    <th>Variedad</th>
                                                    <th>Parte</th>
                                                    <th>Proceso</th>
                                                    <th>Mezcla</th>
                                                    <th>Usuario</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr data-ng-repeat="alimento in allAlimentos track by $index">
                                                    <td>
                                                        <input type="hidden" value="{{alimento.idAlimento}}"/>
                                                        <button class="btn btn-primary btn-xs" data-toggle="modal" data-target="#formModalCreateOrEdit" 
                                                                data-ng-click="abrirEditarModal($index)">
                                                            <i class="glyphicon glyphicon-pencil"></i></button>
                                                        <button class="btn btn-danger btn-xs" data-toggle="modal" data-target="#formModalEliminar"
                                                                data-ng-click="abrirEliminarModal($index)">
                                                            <i class="glyphicon glyphicon-trash"></i></button>
                                                    </td>
                                                    <td>{{alimento.nombreCient}}</td>
                                                    <td>{{alimento.nombre}}</td>
                                                    <td>{{alimento.variedad}}</td>
                                                    <td>{{alimento.parte}}</td>
                                                    <td>{{alimento.proceso}}</td>
                                                    <td>{{alimento.mezcla}}</td>
                                                    <td>{{alimento.idUsuario.nombre}}</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="panel-footer panel-default">
                                    <a>Alimentos</a>
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
                                        <h4 class="modal-title" id="H2">Alimento</h4>
                                    </div>
                                    <div class="modal-body">
                                        <form role="form" data-ng-submit="createOrEditAlimento()" 
                                              name="formAddAlimento" method="post">
                                            <div class="form-group">
                                                <label>Nombre Cient&iacute;fico</label>
                                                <input class="form-control" data-ng-pattern="/^[a-zA-z]*$/" name="inputNombreCient"
                                                       required="" data-ng-model="indiceRegistro.nombreCient"/>
                                                <div class="text-center" data-ng-show="formAddAlimento.inputNombreCient.$invalid">
                                                    <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                                    <span style="color:red; display: block; text-align: left;">Este campo no admite caracteres numéricos</span>
                                                </div>
                                                <label>Nombre</label>
                                                <input class="form-control" data-ng-pattern="/^[a-zA-z]*$/" name="inputNombre"
                                                       required="" data-ng-model="indiceRegistro.nombre"/>
                                                <div class="text-center" data-ng-show="formAddAlimento.inputNombre.$invalid">
                                                    <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                                    <span style="color:red; display: block; text-align: left;">Este campo no admite caracteres numéricos</span>
                                                </div>
                                                <label>Variedad</label>
                                                <input class="form-control" data-ng-pattern="/^[a-zA-z]*$/" name="inputVariedad"
                                                       required="" data-ng-model="indiceRegistro.variedad"/>
                                                <div class="text-center" data-ng-show="formAddAlimento.inputVariedad.$invalid">
                                                    <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                                    <span style="color:red; display: block; text-align: left;">Este campo no admite caracteres numéricos</span>
                                                </div>
                                                <label>Parte</label>
                                                <input class="form-control" data-ng-pattern="/^[a-zA-z]*$/" name="inputParte"
                                                       required="" data-ng-model="indiceRegistro.parte"/>
                                                <div class="text-center" data-ng-show="formAddAlimento.inputParte.$invalid">
                                                    <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                                    <span style="color:red; display: block; text-align: left;">Este campo no admite caracteres numéricos</span>
                                                </div>
                                                <label>Proceso</label>
                                                <input class="form-control" data-ng-pattern="/^[a-zA-z]*$/" name="inputProceso"
                                                       required="" data-ng-model="indiceRegistro.proceso"/>
                                                <div class="text-center" data-ng-show="formAddAlimento.inputProceso.$invalid">
                                                    <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                                    <span style="color:red; display: block; text-align: left;">Este campo no admite caracteres numéricos</span>
                                                </div>
                                                <label>Mezcla</label>
                                                <input class="form-control" data-ng-pattern="/^[a-zA-z]*$/" name="inputMezcla"
                                                       required="" data-ng-model="indiceRegistro.mezcla"/>
                                                <div class="text-center" data-ng-show="formAddAlimento.inputMezcla.$invalid">
                                                    <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                                    <span style="color:red; display: block; text-align: left;">Este campo no admite caracteres numéricos</span>
                                                </div>
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
                                                <button type="submit" class="btn btn-success" data-ng-disabled="formAddAlimento.$invalid">Guardar</button>
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
