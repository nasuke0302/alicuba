<%-- 
    Document   : metadatosGenerados
    Created on : 08-jun-2018, 22:18:48
    Author     : albert
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html data-ng-app="appMetadatosGenerados">
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
        <script src="${pageContext.request.contextPath}/static/AngularJs/MetadatosGenerados.js"></script>
        <!--END PAGE LEVEL STYLES-->
    </head>
    <body class="padTop53" data-ng-controller="MetadatosGeneradosController">
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
                            <div class="panel panel-primary">
                                <div class="panel-heading">Tabla Seleccionada</div>
                                <div class="panel-body">
                                    <strong>Nombre de Tabla:</strong><p>{{tablaGenerada.nombre}}</p>
                                    <strong>Fecha y hora:</strong><p>{{tablaGenerada.fechaHora}}</p>
                                    <strong>Editor creador: </strong>
                                    <p>
                                        {{tablaGenerada.idUsuario.nombre}} {{tablaGenerada.idUsuario.apellidos}} -
                                        <strong><small>{{tablaGenerada.idUsuario.email}}</small></strong>
                                    </p>
                                    <button class="btn btn-primary" data-toggle="modal" data-target="#formModalEdit">
                                        <span class="glyphicon glyphicon-pencil"></span>
                                        Editar
                                    </button>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading  ">
                                    <h5>Alimentos de la tabla seleccionada</h6>
                                </div>
                                <!--TABLA METADATOS GENERADOS-->
                                <div class="panel-body">
                                    <div class="table-responsive">
                                        <table  datatable="ng" id="tablaCategorias" class="table table-striped table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Datos</th>
                                                    <th>Alimento</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr data-ng-repeat="mg in allMetadatosGenerados track by $index">
                                                    <td>
                                                        <button id="añadirButton" class="icon-eye-open btn btn-success" 
                                                                data-ng-click="verDatos($index)"></button>
                                                    </td>
                                                    <td>
                                                       <strong> {{mg.idAlimento.nombreCient}}</strong> - 
                                                               <strong>{{mg.idAlimento.nombre}}</strong>
                                                        {{mg.idEpoca.etiqueta}} - {{mg.fertilizado.etiqueta}} - 
                                                        {{mg.calidad.etiqueta}} - {{mg.idNivelFert.etiqueta}} - 
                                                        {{mg.idRangoEdades.etiqueta}} - {{mg.idRegion.etiqueta}} - 
                                                        {{mg.import1.pais}}
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="panel-footer panel-default">Tabla Seleccionada</div>
                            </div>
                        </div>
                    </div>
                    <!--EDIT MODAL-->
                    <div class="col-lg-12">
                        <div class="modal fade" id="formModalEdit" tabindex="-1" 
                             role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                        <h4 class="modal-title" id="H2">Tabla</h4>
                                    </div>
                                    <div class="modal-body">
                                        <form role="form" data-ng-submit="editTabla()" 
                                              name="formEditTabla" method="post">
                                            <div class="form-group">
                                                <label>Nombre</label>
                                                <input class="form-control" name="inputNombreTabla"
                                                       required="" data-ng-model="tablaGeneradaEdit.nombre"/>
                                                <div class="text-center" data-ng-show="formEditTabla.inputNombreTabla.$invalid">
                                                    <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                                </div>
                                                <br />
                                                <div class="text-right">
                                                    <input type="hidden" data-ng-model="tablaGeneradaEdit.idListadoTablaGeneradas"/>
                                                    <button type="submit" class="btn btn-success" data-ng-disabled="formEditTabla.$invalid">Guardar</button>
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
