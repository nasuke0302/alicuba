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
        <script src="${pageContext.request.contextPath}/static/AngularJs/jquery.dataTables.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular-datatables.bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular-datatables.min.js"></script>
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
                                    <button class="btn btn-primary" data-toggle="modal" data-target="#formModalEdit"
                                            data-ng-click="abrirEditarModal()">
                                        <span class="glyphicon glyphicon-pencil"></span>
                                        Editar
                                    </button>
                                    <hr />
                                    <div class="table-responsive">
                                        <table datatable="ng" id="tablaCategorias" class="table table-bordered table-striped table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Ver Datos</th>
                                                    <th>Nombre Cient&iacute;fico</th>
                                                    <th>Nombre Com&uacute;n</th>
                                                    <th>Variedad</th>
                                                    <th>Parte</th>
                                                    <th>Proceso</th>
                                                    <th>Mezcla</th>
                                                    <th>Otros</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr data-ng-repeat="mg in allMetadatosGenerados track by $index">
                                                    <td>
                                                        <a class="btn btn-success" href="#tabla1"
                                                           data-ng-click="verDatos($index)">
                                                            <span class="glyphicon glyphicon-eye-open"></span>
                                                        </a>
                                                    </td>
                                                    <td>{{mg.idAlimento.nombreCient}}</td>
                                                    <td>{{mg.idAlimento.nombre}}</td>
                                                    <td>{{mg.idAlimento.variedad}}</td>
                                                    <td>{{mg.idAlimento.parte}}</td>
                                                    <td>{{mg.idAlimento.proceso}}</td>
                                                    <td>{{mg.idAlimento.mezcla}}</td>
                                                    <td>
                                                        {{mg.idEpoca.etiqueta}} - {{mg.fertilizado.etiqueta}} - 
                                                        {{mg.calidad.etiqueta}} - {{mg.idNivelFert.etiqueta}} - 
                                                        {{mg.idRangoEdades.etiqueta}} - {{mg.idRegion.etiqueta}} - 
                                                        {{mg.import1.pais}}
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <br />
                                    <div class="panel panel-default">
                                        <div class="panel-heading"> 
                                            Alimento Seleccionado: 
                                        </div>
                                        <div class="panel-body">
                                            <strong>Nombre Cient&iacute;fico: </strong>
                                            {{metadatoGenerado.idAlimento.nombreCient}}
                                            <br />
                                            <strong>Nombre Com&uacute;n: </strong>
                                            {{metadatoGenerado.idAlimento.nombre}}
                                            <br />
                                            <strong>Variedad: </strong>
                                            {{metadatoGenerado.idAlimento.variedad}}
                                            <br />
                                            <strong>Parte: </strong>
                                            {{metadatoGenerado.idAlimento.parte}}
                                            <br />
                                            <strong>Proceso: </strong>
                                            {{metadatoGenerado.idAlimento.proceso}}
                                            <br />
                                            <strong>Mezcla: </strong>
                                            {{metadatoGenerado.idAlimento.mezcla}}
                                            <br />
                                            <strong>Otros: </strong>
                                            <em data-toggle="tooltip" data-placement="top" title="Presentaci&oacute;n">{{metadatoGenerado.presentation}}</em>-
                                            <em data-toggle="tooltip" data-placement="top" title="{{metadatoGenerado.idEpoca.nombre}}">{{metadatoGenerado.idEpoca.etiqueta}}</em> - 
                                            <em data-toggle="tooltip" data-placement="top" title="{{metadatoGenerado.fertilizado.fertilizado}}">{{metadatoGenerado.fertilizado.etiqueta}}</em> - 
                                            <em data-toggle="tooltip" data-placement="top" title="{{metadatoGenerado.calidad.calidad}}">{{metadatoGenerado.calidad.etiqueta}}</em> - 
                                            <em data-toggle="tooltip" data-placement="top" title="{{metadatoGenerado.idNivelFert.nivel}}">{{metadatoGenerado.idNivelFert.etiqueta}}</em> - 
                                            <em data-toggle="tooltip" data-placement="top" title="{{metadatoGenerado.idRangoEdades.rango}}">{{metadatoGenerado.idRangoEdades.etiqueta}}</em> - 
                                            <em data-toggle="tooltip" data-placement="top" title="{{metadatoGenerado.idRegion.region}}">{{metadatoGenerado.idRegion.etiqueta}}</em> - 
                                            <em data-toggle="tooltip" data-placement="top" title="Corte">{{metadatoGenerado.corte}}</em> - 
                                            <em data-toggle="tooltip" data-placement="top" title="Nitrógeno">{{metadatoGenerado.n}}</em> - 
                                            <em data-toggle="tooltip" data-placement="top" title="N-P-K">({{metadatoGenerado.npk}})</em> - 
                                            <em data-toggle="tooltip" data-placement="top" title="{{metadatoGenerado.import1.pais}}">{{metadatoGenerado.import1.alpha3}}</em> - 
                                            <em data-toggle="tooltip" data-placement="top" title="Tratamiento">{{metadatoGenerado.tratamiento}}</em> - 
                                            <em data-toggle="tooltip" data-placement="top" title="Tecnología">{{metadatoGenerado.tecnolog}}</em>
                                            <br />
                                            <table id="tabla1" class="table table-hover table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>Nutriente</th>
                                                        <th>Total</th>
                                                        <th>M&iacute;nimo</th>
                                                        <th>M&aacute;ximo</th>
                                                        <th>Promedio</th>
                                                        <th>Desviaci&oacute;n Est&aacute;ndar</th>
                                                        <th>Varianza</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr data-ng-repeat="tc in metadatoGenerado.tablaCnaFinalList track by $index">
                                                        <td title="{{tc.nutrientes.nombre}}">
                                                            {{tc.nutrientes.abreviatura}}
                                                            {{tc.nutrientes.idUnidadMedida.unidadMedida}}

                                                        </td>
                                                        <td>{{tc.total}}</td>
                                                        <td>{{tc.minimo}}</td>
                                                        <td>{{tc.maximo}}</td>
                                                        <td>{{tc.promedio| limitTo: 4}}</td>
                                                        <td>{{tc.desvEst| limitTo: 4 }}</td>
                                                        <td>{{tc.varianza| limitTo: 4}}</td>
                                                    </tr>
                                                </tbody>
                                            </table>                                    
                                        </div>
                                        <div class="panel-footer"> Datos del Alimento</div>
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
