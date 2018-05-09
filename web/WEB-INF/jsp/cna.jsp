<%-- 
    Document   : cna
    Created on : 09-abr-2018, 23:02:57
    Author     : albert
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es" data-ng-app="AppCna">

    <!-- BEGIN HEAD-->
    <head>
        <meta charset="UTF-8" />
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <meta content="" name="description" />
        <meta content="AliCuba" name="author" />
        <!--GLOBAL STYLES AND TITLE-->
        <jsp:include page="/WEB-INF/includes/globalcss.jsp"/>
        <!--END GLOBAL STYLES-->

        <!--PAGE LEVEL STYLES-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/AngularJs/uiSelect/select.min.css">
        <!--END PAGE LEVEL STYLES-->

        <!--PAGE LEVEL SCRIPTS-->
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/uiSelect/select.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/Cna.js"></script>
        <!--END PAGE LEVEL SCRIPTS-->
    </head>
    <!-- END  HEAD-->

    <!-- BEGIN BODY-->
    <body class="padTop53" data-ng-controller="CnaController">

        <!-- MAIN WRAPPER -->
        <div id="wrap">
            <!-- HEADER SECTION -->
            <jsp:include page="/WEB-INF/includes/header.jsp"/>
            <!-- END HEADER SECTION -->
            <!-- MENU SECTION -->
            <jsp:include page="/WEB-INF/includes/menuContent.jsp"/>
            <!--END MENU SECTION -->
            <!--PAGE CONTENT -->
            <div id="content">
                <div class="inner" style="min-height:1200px;">                
                    <div class="row">
                        <div class="col-lg-12">
                            <h4 class="page-header">ESTUDIOS REGISTRADOS DE LA REFERENCIA</h4>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Referencia 
                                </div>
                                <div class="panel-body">
                                    <em id="pAutores" data-ng-repeat="autor in referencia.autoresList">
                                        {{autor.apellidos| limitTo: 1}}. {{autor.nombre}},
                                    </em>
                                    <em> ({{referencia.fecha}}). {{referencia.title}}. 
                                        2. {{referencia.nota}}. <em style="text-transform: capitalize">{{referencia.lugar}}. </em>
                                        {{referencia.idFuente.nombreFuente}}.  
                                        {{referencia.pages}}.</em>
                                    <p>                                    
                                        URL: <a href="{{referencia.url}}">{{referencia.url}}</a>
                                    </p>
                                    <p>
                                        Categor&iacute;a (s):<em data-ng-repeat="categoria in referencia.categoriaList">{{categoria.categoria}} </em>
                                    </p>
                                    <p>                                    
                                        <button class="icon-pencil btn btn-success" data-ng-click="abrirEditarModal()"
                                                data-toggle="modal" data-target="#modalNuevaReferencia"> Editar</button>
                                    </p> 
                                </div>                            
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="box dark">
                                <header>
                                    <div class="icons"><i class="icon-edit"></i></div>
                                    <h5>Estudios Registrados</h5>
                                    <div class="toolbar">
                                        <ul class="nav">  
                                            <li><a data-ng-click="estudiosPorReferencia(referencia.idReferencia)" class="btn btn-primary">
                                                    <span class="glyphicon glyphicon-eye-open"></span> Ver estudios de la referencia</a>
                                            </li>
                                            <li><a data-ng-click="nuevoEstudio()" class="btn btn-primary">
                                                    <span class="glyphicon glyphicon-plus"></span> Nuevo estudio</a>
                                            </li>
                                            <li>
                                                <a class="accordion-toggle minimize-box" data-toggle="collapse" href="#div-1">
                                                    <i class="icon-chevron-up"></i>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </header>
                                <div id="div-1" class="accordion-body collapse in body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><strong>Estudio</strong></td>
                                            <td><strong>Nutrientes</strong></td>
                                        </tr>
                                        <tr data-ng-repeat="e in estudioPorReferencia track by e.idMetadatosAlimentosG" >
                                            <!--data-ng-init="indexAlimentos = $index">-->
                                            <td><em>{{e.idAlimento.nombreCient}}</em>, {{e.idAlimento.nombre}},
                                                <abbr title="Variedad">{{e.idAlimento.variedad}}</abbr>, 
                                                <abbr title="Tratamiento">{{e.tratamiento}}</abbr>,
                                                <abbr title="Regi&oacute;n">{{e.idProvincia.idRegion.etiqueta}}</abbr>-
                                                <abbr title="&Eacute;poca">{{e.idEpoca.etiqueta}}</abbr>-
                                                <abbr title="Riego">{{e.riego}}</abbr>-
                                                <abbr title="Fertilizado">{{e.fertilizado.etiqueta}}</abbr>-
                                                <abbr title="Rango de Edad">{{e.idRangoEdades.etiqueta}}</abbr>
                                                <button class="btn btn-primary btn-xs" title="Editar alimento" data-ng-click="editarMetadatos($index)">
                                                    <i class="glyphicon glyphicon-pencil"></i></button>
                                                <button class="btn btn-danger btn-xs" data-toggle="modal" data-target="#formModalEliminarAlimento"
                                                        title="Eliminar alimento"
                                                        data-ng-click="abrirEliminarAlimentoModal($index)">
                                                    <i class="glyphicon glyphicon-trash"></i></button>
                                            </td>
                                            <td>
                                                <table class="table">
                                                    <tr data-ng-repeat="nut in e.tablaCnaGeneralList track by $index">
                                                        <td>{{nut.nutrientes.idTiposDatosAlimentos.nombreTipoDato}}</td>
                                                        <td>
                                                            <abbr title="{{nut.nutrientes.nombre}}">{{nut.nutrientes.abreviatura}}</abbr>,
                                                            {{nut.nutrientes.idUnidadMedida.unidadMedida}}</td>
                                                        <td> {{nut.valor}}</td>
                                                        <td>
                                                            <button class="btn btn-primary btn-xs" title="editar estudio">
                                                                <i class="glyphicon glyphicon-pencil"></i></button>
                                                            <button class="btn btn-danger btn-xs" data-toggle="modal" data-target="#formModalEliminar"
                                                                    title="Eliminar estudio"
                                                                    data-ng-click="abrirEliminarModal(indexAlimentos, $index)">
                                                                <i class="glyphicon glyphicon-trash"></i></button>
                                                        </td> 
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--MODAL EDITAR REFERENCIA-->
                <div class="col-lg-12">
                    <div class="modal fade" id="modalNuevaReferencia" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <form name="formAddReferencias" role="form" data-ng-submit="saveReferencia()" method="post">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                        <h4 class="modal-title" id="H3">Nueva Referencia</h4>
                                    </div>
                                    <div class="modal-body">
                                        <div class="form-group">
                                            <label>Fuente de Referencia</label>
                                            <ui-select data-ng-model="selectedFuente.selected" 
                                                       theme="bootstrap">
                                                <ui-select-match placeholder="Elija una fuente de referencia...">
                                                    {{$select.selected.nombreFuente}}
                                                </ui-select-match>
                                                <ui-select-choices repeat="a in allFuentes| filter: $select.search">
                                                    {{a.nombreFuente}}
                                                </ui-select-choices>
                                            </ui-select>   
                                        </div>
                                        <div class="form-group">
                                            <label>Autor (es)</label>
                                            <ui-select name="selectAutor" multiple="" data-ng-model="selectedAutores.selected" 
                                                       theme="bootstrap" close-on-select="false">
                                                <ui-select-match placeholder="Elija al menos un autor...">
                                                    {{$item.nombre}} {{$item.apellidos}} 
                                                </ui-select-match>
                                                <ui-select-choices repeat="a in allAutores | filter: $select.search">
                                                    {{a.nombre}} {{a.apellidos}}
                                                </ui-select-choices>
                                            </ui-select> 
                                            <button class="btn btn-success" data-toggle="modal" 
                                                    data-ng-click="abrirModalAddAutor()" data-target="#modalAddOrEditAutor">
                                                <span class="glyphicon glyphicon-plus"></span>Nuevo Autor</button>
                                        </div>
                                        <div class="form-group">
                                            <label>T&iacute;tulo</label>
                                            <input name="inputTitulo" class="form-control"
                                                   data-ng-model="referenciaEdit.title" required=""
                                                   placeholder="T&iacute;tulo de la referencia" />
                                            <div data-ng-show="formAddReferencias.inputTitulo.$invalid">
                                                <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>Nota</label>
                                            <textarea class="form-control" name="inputNota" 
                                                      placeholder="Breve descripci&oacute;n sobre la referencia"
                                                      data-ng-model="referenciaEdit.nota" required=""></textarea>
                                            <div data-ng-show="formAddReferencias.inputNota.$invalid">
                                                <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>A&ntilde;o</label>
                                            <ui-select data-ng-model="selectedYear.selected" 
                                                       theme="bootstrap">
                                                <ui-select-match placeholder="Elija un a&ntilde;o...">
                                                    {{$select.selected}}
                                                </ui-select-match>
                                                <ui-select-choices repeat="y in years| filter: $select.search">
                                                    {{y}}
                                                </ui-select-choices>
                                            </ui-select> 
                                            <div data-ng-show="formAddReferencias.inputYear.$invalid">
                                                <span style="color:red; display: block; text-align: left;">Este año es requerido</span>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>P&aacute;ginas</label>
                                            <input name="inputPaginas" class="form-control" allow-only-numbers
                                                   placeholder="N&uacute;mero de p&aacute;gina o rango de p&aacute;ginas"
                                                   data-ng-model="referenciaEdit.pages" required=""/>
                                            <div data-ng-show="formAddReferencias.inputPaginas.$invalid">
                                                <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label>Categor&iacute;a (s) </label>
                                            <ui-select multiple="" data-ng-model="selectedCategoria.selected" 
                                                       theme="bootstrap" close-on-select="false">
                                                <ui-select-match placeholder="Elija al menos una categor&iacute;a...">
                                                    {{$item.categoria}}
                                                </ui-select-match>
                                                <ui-select-choices repeat="a in allCategorias | filter: $select.search">
                                                    {{a.categoria}}
                                                </ui-select-choices>
                                            </ui-select> 
                                            <button class="btn btn-success" data-toggle="modal" 
                                                    data-ng-click="abrirModalAddCategoria()" data-target="#modalAddOrEditCategoria">
                                                <span class="glyphicon glyphicon-plus"></span>Nueva Categor&iacute;a</button>
                                        </div>
                                        <hr />
                                        <div class="form-group" data-ng-show="selectedFuente.selected.idFuente === 1">
                                            <label>Número de Informe</label>
                                            <input class="form-control" maxlength="8" name="inputNumInf"
                                                   allow-only-numbers data-ng-model="referenciaEdit.informeNum"/>
                                        </div>
                                        <div class="form-group" data-ng-show="selectedFuente.selected.idFuente === 1">
                                            <label>Tipo de Informe</label>
                                            <input class="form-control" data-ng-pattern="/^[a-zA-z]*$/"
                                                   data-ng-model="referenciaEdit.informeTipo" name="inputTipoInf"/>
                                            <div class="text-center" data-ng-show="formAddReferencias.inputTipoInf.$invalid">
                                                <span style="color:red; display: block; text-align: left;">Este campo no admite caracteres numéricos</span>
                                            </div>
                                        </div>
                                        <div class="form-group"  data-ng-show="selectedFuente.selected.idFuente === 1">
                                            <label>Instituci&oacute;n</label>
                                            <input class="form-control" data-ng-pattern="/^[a-zA-z]*$/"
                                                   data-ng-model="referenciaEdit.informeInstitution" name="inputinstiInf"/>
                                            <div class="text-center" data-ng-show="formAddReferencias.inputinstiInf.$invalid">
                                                <span style="color:red; display: block; text-align: left;">Este campo no admite caracteres numéricos</span>
                                            </div>
                                        </div>

                                        <div class="form-group"  data-ng-show="selectedFuente.selected.idFuente === 1">
                                            <label>T&iacute;tulo de la serie</label>
                                            <input class="form-control" data-ng-pattern="/^[a-zA-z]*$/"
                                                   data-ng-model="referenciaEdit.informeSerie" name="inputInformeSerie"/>
                                            <div class="text-center" data-ng-show="formAddReferencias.inputInformeSerie.$invalid">
                                                <span style="color:red; display: block; text-align: left;">Este campo no admite caracteres numéricos</span>
                                            </div>
                                        </div>
                                        <div class="form-group" data-ng-show="selectedFuente.selected.idFuente === 2">
                                            <label>Publicaci&oacute;n</label>
                                            <input class="form-control" data-ng-pattern="/^[a-zA-z]*$/"
                                                   data-ng-model="referenciaEdit.arcPublication" name="inputArcPublication"/>
                                            <div class="text-center" data-ng-show="formAddReferencias.inputArcPublication.$invalid">
                                                <span style="color:red; display: block; text-align: left;">Este campo no admite caracteres numéricos</span>
                                            </div>
                                        </div>

                                        <div class="form-group" 
                                             data-ng-show="selectedFuente.selected.idFuente === 2 ||
                                                                     selectedFuente.selected.idFuente === 3">
                                            <label>N&uacute;mero</label>
                                            <input class="form-control" allow-only-numbers
                                                   data-ng-model="referenciaEdit.volumen"/>
                                        </div>

                                        <div class="form-group" 
                                             data-ng-show="selectedFuente.selected.idFuente === 2 ||
                                                                     selectedFuente.selected.idFuente === 3">
                                            <label>Volumen o tomo</label>
                                            <input class="form-control" allow-only-numbers
                                                   data-ng-model="referenciaEdit.numVol"/>
                                        </div>

                                        <div class="form-group" 
                                             data-ng-show="selectedFuente.selected.idFuente === 3 ||
                                                                     selectedFuente.selected.idFuente === 4 ||
                                                                     selectedFuente.selected.idFuente === 5">
                                            <label>Editorial</label>
                                            <input class="form-control" data-ng-pattern="/^[a-zA-z]*$/"
                                                   data-ng-model="referenciaEdit.editorial" name="inputEditorial"/>
                                            <div class="text-center" data-ng-show="formAddReferencias.inputEditorial.$invalid">
                                                <span style="color:red; display: block; text-align: left;">Este campo no admite caracteres numéricos</span>
                                            </div>
                                        </div>
                                        <div class="form-group" data-ng-show="selectedFuente.selected.idFuente === 3 ||
                                                                selectedFuente.selected.idFuente === 4">
                                            <label>Edici&oacute;n</label>
                                            <input class="form-control" allow-only-numbers
                                                   data-ng-model="referenciaEdit.edition"/>
                                        </div>
                                        <div class="form-group" data-ng-show="selectedFuente.selected.idFuente === 4">
                                            <label>T&iacute;tulo del Libro</label>
                                            <input class="form-control" data-ng-pattern="/^[a-zA-z]*$/"
                                                   data-ng-model="referenciaEdit.secclTitle" name="inputSecclTitle"/>
                                            <div class="text-center" data-ng-show="formAddReferencias.inputSecclTitle.$invalid">
                                                <span style="color:red; display: block; text-align: left;">Este campo no admite caracteres numéricos</span>
                                            </div>
                                        </div>
                                        <div class="form-group"data-ng-show="selectedFuente.selected.idFuente === 5">
                                            <label>Universidad</label>
                                            <input class="form-control" data-ng-pattern="/^[a-zA-z]*$/"
                                                   data-ng-model="referenciaEdit.tesisUniversidad" name="inputTesisUniversidad"/>
                                            <div class="text-center" data-ng-show="formAddReferencias.inputTesisUniversidad.$invalid">
                                                <span style="color:red; display: block; text-align: left;">Este campo no admite caracteres numéricos</span>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>URL</label>
                                            <input class="form-control" type="url" data-ng-model="referenciaEdit.url"/>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="submit" class="btn btn-primary" data-ng-disabled="formAddReferencias.$invalid">Aceptar</button>
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                                    </div>                            
                                </div>
                            </form>
                        </div>
                    </div>
                </div> 
                <!--END MODAL EDITAR REFERENCIA-->
                <!--CREATE AUTOR-->
                <div class="col-lg-12">
                    <div class="modal fade" id="modalAddOrEditAutor" tabindex="-1" 
                         role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    <h4 class="modal-title" id="H2">Añadir Autor</h4>
                                </div>
                                <div class="modal-body">
                                    <form role="form" data-ng-submit="addAutor()" method="post" name="formAddAutor">
                                        <div class="form-group">
                                            <label>Nombre</label>
                                            <input class="form-control" data-ng-pattern="/^[a-zA-Z]*$/" name="inputAutorNombre"
                                                   required="" data-ng-model="autor.nombre"/>
                                            <div data-ng-show="formAddAutor.inputAutorNombre.$invalid">
                                                <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                                <span style="color:red; display: block; text-align: left;">Este campo es no admite caracteres numéricos</span>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>Segundo Nombre</label>
                                            <input class="form-control" type="text" 
                                                   data-ng-model="autor.segundoNombre"
                                                   style=" text-transform: capitalize"/>
                                        </div>
                                        <div class="form-group">
                                            <label>Apellidos</label>
                                            <input class="form-control" type="text" name="inputAutorApellidos"
                                                   required="" data-ng-model="autor.apellidos"
                                                   style=" text-transform: capitalize"/>
                                            <div data-ng-show="formAddAutor.inputAutorApellidos.$invalid">
                                                <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                            </div>
                                        </div>
                                        <div class="text-right">
                                            <button type="submit" class="btn btn-success" data-ng-disabled="formAddAutor.$invalid">Guardar</button>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--END CREATE AUTOR-->
                <!--CREATE CATEGORIA--> 
                <div class="col-lg-12">
                    <div class="modal fade" id="modalAddOrEditCategoria" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    <h4 class="modal-title" id="H2">Añadir Categor&iacute;a</h4>
                                </div>
                                <div class="modal-body">
                                    <form role="form" data-ng-submit="addCategoria()" method="post" name="formAddCategoria">
                                        <div class="form-group">
                                            <label>Categor&iacute;a</label>
                                            <input class="form-control" type="text" name="inputCategoriaCategoria"
                                                   required="" data-ng-model="categoria.categoria"
                                                   style=" text-transform: capitalize"/>
                                            <div data-ng-show="formAddCategoria.inputCategoriaCategoria.$invalid">
                                                <span style="color:red; display: block; text-align: left;">Este campo es requerido</span>
                                            </div>
                                        </div>
                                        <div class="text-right">
                                            <button type="submit" class="btn btn-success" data-ng-disabled="formAddCategoria.$invalid">Guardar</button>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--END CREATE CATEGORIA-->
                <!--DELETE ALIMENTO MODAL-->
                <div>
                    <div class="modal fade" id="formModalEliminarAlimento" role="dialog" style="display: none;">
                        <div class="modal-dialog" style="margin-top: 260.5px;">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title"><strong>¡Atenci&oacute;n!</strong></h4>
                                    <div class="modal-body">
                                        <form role="form" method="post" data-ng-submit="eliminarAlimento()" id="delete_data" class="text-right">
                                            <div class="text-left">
                                                <div class="alert alert-danger"> Al eliminar un alimento se eliminar&aacute;n también los estudios asociados a &eacute;l.</div>
                                            </div>
                                            <button type="submit" class="btn btn-danger">Eliminar</button>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                                        </form>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
                <!--END DELETE ALIMENTO MODAL-->
                <!--DELETE ESTUDIO MODAL-->
                <div>
                    <div class="modal fade" id="formModalEliminar" role="dialog" style="display: none;">
                        <div class="modal-dialog" style="margin-top: 260.5px;">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">¿Seguro que desea eliminar este estudio?</h4>
                                    <div class="modal-body">
                                        <form role="form" method="post" data-ng-submit="eliminarEstudio()" id="delete_data" class="text-right">
                                            <button type="submit" class="btn btn-danger">Eliminar</button>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                                        </form>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <!--END DELETE ESTUDIO MODAL-->
                </div>
                <!--END DLETE MODAL-->
            </div>
            <!--END PAGE CONTENT -->
        </div>
        <!--END MAIN WRAPPER -->
        <!-- FOOTER -->
        <jsp:include page="/WEB-INF/includes/footer.jsp"/>
        <!--END FOOTER -->
        <!--GLOBAL SCRIPTS-->
        <jsp:include page="/WEB-INF/includes/globalScripts.jsp"/>
        <!--END GLOBAL SCRIPTS-->
        <!--BEGIN PAGE LEVEL SCRIPT-->
        <script>
                    if (Notification.permission === "granted") {
                        var socket = new SockJS("${pageContext.request.contextPath}/websocket/configuration");
                        var stompClient = Stomp.over(socket);
                        var notify;
                        stompClient.connect({}, function (frame) {
                            stompClient.subscribe("/messages/enviar", function (res) {
                                console.log(res);
                                var msj = JSON.parse(res.body);
                                notify = new Notification("Referencia Editada", {
                                    body: msj.mensaje,
                                    icon: "/alicuba/static/IconWebSocket.png"});


                            });
                        });
                    }
        </script> 
        <!--END PAGE LEVEL SCRIPT-->
    </body>
    <!-- END BODY-->
</html>

