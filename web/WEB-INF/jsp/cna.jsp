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
                                    <table class="table">
                                        <tr>
                                            <td><strong>Estudio</strong></td>
                                        </tr>
                                        <tr data-ng-repeat="e in estudioPorReferencia" data-ng-init="indexAlimentos = $index">
                                            <td>
                                                <div class="panel panel-default">
                                                    <div class="panel-heading">
                                                        <em>{{e.idAlimento.nombreCient}}</em>, {{e.idAlimento.nombre}},
                                                        <abbr title="Variedad">{{e.idAlimento.variedad}}</abbr>, 
                                                        <abbr title="Regi&oacute;n">{{e.idProvincia.idRegion.etiqueta}}</abbr>-
                                                        <abbr title="&Eacute;poca">{{e.idEpoca.etiqueta}}</abbr>-
                                                        <abbr title="Riego">{{e.riego}}</abbr>-
                                                        <abbr title="Fertilizado">{{e.fertilizado.etiqueta}}</abbr>-
                                                        <abbr title="Rango de Edad">{{e.idRangoEdades.etiqueta}}</abbr>
                                                        <button class="btn btn-primary btn-xs" title="Editar alimento" 
                                                                data-toggle="modal" data-target="#formModalEditAlimento"
                                                                data-ng-click="abrirModalEditarMetadatos($index)">
                                                            <i class="glyphicon glyphicon-pencil"></i></button>
                                                        <button class="btn btn-danger btn-xs" data-toggle="modal" data-target="#formModalEliminarAlimento"
                                                                title="Eliminar alimento"
                                                                data-ng-click="abrirEliminarAlimentoModal($index)">
                                                            <i class="glyphicon glyphicon-trash"></i>
                                                        </button>
                                                    </div>
                                                    <div class="panel-body">
                                                        <table class="table">
                                                            <tr>
                                                                <td>
                                                                    <button class="btn btn-success" value="A&ntilde;adir nutriente"
                                                                            data-toggle="modal" data-target="#formModalCreateNutriente"
                                                                            data-ng-click="abrirNuevoNutrienteModal(indexAlimentos)">
                                                                        Nuevo nutriente
                                                                    </button>
                                                                </td>
                                                            </tr>
                                                            <tr data-ng-repeat="nut in e.tablaCnaGeneralList track by $index">
                                                                <td>
                                                                    <abbr title="{{nut.nutrientes.nombre}}">{{nut.nutrientes.abreviatura}}</abbr>,
                                                                    {{nut.nutrientes.idUnidadMedida.unidadMedida}}</td>
                                                                <td> {{nut.valor}}</td>
                                                                <td>
                                                                    <button class="btn btn-primary btn-xs" title="Editar estudio"
                                                                            data-toggle="modal" data-target="#formModalEditNutriente" data-ng-click="abrirEditarNutrienteModal($parent.$index, $index)">
                                                                        <i class="glyphicon glyphicon-pencil"></i></button>
                                                                    <button class="btn btn-danger btn-xs" data-toggle="modal" data-target="#formModalEliminar"
                                                                            title="Eliminar estudio"
                                                                            data-ng-click="abrirEliminarModal($parent.$index, $index)">
                                                                        <i class="glyphicon glyphicon-trash"></i></button>
                                                                </td> 
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </div>
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
                    <div style="overflow-y: auto" class="modal fade" id="modalNuevaReferencia" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
                                        <button type="submit" class="btn btn-primary" data-ng-disabled="formAddReferencias.$invalid || formAddReferencias.$pristine">Aceptar</button>
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
                    <div style="overflow-y: auto" class="modal fade" id="modalAddOrEditAutor" tabindex="-1" 
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
                                            <button type="submit" class="btn btn-success" data-ng-disabled="formAddAutor.$invalid || formAddAutor.$pristine">Guardar</button>
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
                    <div style="overflow-y: auto" class="modal fade" id="modalAddOrEditCategoria" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
                                            <button type="submit" class="btn btn-success" 
                                                    data-ng-disabled="formAddCategoria.$invalid || formAddCategoria.$pristine">Guardar</button>
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
                <div style="overflow-y: auto" class="modal fade" id="formModalEliminarAlimento" role="dialog" style="display: none;">
                    <div style="overflow-y: auto" class="modal-dialog" style="margin-top: 260.5px;">
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
                <!--END DELETE ALIMENTO MODAL-->
                <!--DELETE ESTUDIO MODAL-->
                <div style="overflow-y: auto" class="modal fade" id="formModalEliminar" role="dialog" style="display: none;">
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
                <!--BEGIN CREATE NUTRIENTE-->
                <div class="col-lg-12">
                    <div style="overflow-y: auto" class="modal fade" id="formModalCreateNutriente" tabindex="-1" 
                         role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    <h4 class="modal-title" id="H2">Nutriente</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <div >
                                            <div>
                                                <h4> Seleccione un Tipo de Datos</h4>
                                                <ui-select data-ng-model="selectedNutriente.selected"
                                                           theme="bootstrap" name="selectNutriente">
                                                    <ui-select-match placeholder="Elija un Nutriente...">
                                                        <strong>{{$select.selected.abreviatura}} </strong>
                                                        {{$select.selected.nombre}} 
                                                        <small><strong>Tipo de Dato: </strong>
                                                            {{$select.selected.idTiposDatosAlimentos.nombreTipoDato}}
                                                        </small>
                                                    </ui-select-match>
                                                    <ui-select-choices repeat="a in allNutrientes| filter: $select.search" 
                                                                       group-by="groupByNombreTipoDato"> 
                                                        <strong>{{a.abreviatura}} </strong>
                                                        {{a.nombre}}
                                                    </ui-select-choices>
                                                </ui-select> 
                                            </div>
                                            <br/>
                                            <div data-ng-show="selectedNutriente.selected">
                                                <form data-ng-submit="addTablaCnaGeneral()" method="post" name="formAddTablaCnaGeneral">
                                                    <div class="input-group tooltip-demo">
                                                        <span class="input-group-addon" data-toggle="tooltip" data-placement="left" 
                                                              title="{{selectedNutriente.selected.nombre}}">{{selectedNutriente.selected.abreviatura}}</span>
                                                        <input type="text" class="form-control" data-ng-model="tablaCnaGeneral.valor" required
                                                               allow-decimal-numbers/>
                                                        <span class="input-group-addon">{{selectedNutriente.selected.idUnidadMedida.unidadMedida}}</span>
                                                    </div>
                                                    <br />
                                                    <button class="icon-pencil btn btn-success" type="submit" 
                                                            data-ng-disabled="formAddTablaCnaGeneral.$invalid || formAddTablaCnaGeneral.$pristine"> Guardar</button> 
                                                </form>
                                            </div>
                                        </div>
                                        <div class="text-right">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--END CREATE NUTRIENTE-->
                <!--BEGIN EDIT NUTRIENTE-->
                <div class="col-lg-12">
                    <div style="overflow-y: auto" class="modal fade" id="formModalEditNutriente" tabindex="-1" 
                         role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    <h4 class="modal-title" id="H2">Nutriente</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <div>
                                            <form data-ng-submit="editTablaCnaGeneral()" method="post" name="formEditTablaCnaGeneral">
                                                <div class="input-group tooltip-demo">
                                                    <span class="input-group-addon" data-toggle="tooltip" data-placement="left" 
                                                          title="{{estudioToEdit.nutrientes.nombre}}">{{estudioToEdit.nutrientes.abreviatura}}</span>
                                                    <input type="text" class="form-control" data-ng-model="estudioToEdit.valor" required=""/>
                                                    <span class="input-group-addon">{{estudioToEdit.nutrientes.idUnidadMedida.unidadMedida}}</span>
                                                </div>
                                                <br />
                                                <button class="icon-pencil btn btn-success" type="submit" 
                                                        data-ng-disabled="formEditTablaCnaGeneral.$invalid || formEditTablaCnaGeneral.$pristine"> Guardar</button> 
                                            </form>
                                            <div class="text-right">
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--END EDIT NUTRIENTE-->
                <!--BEGIN EDIT ALIMENTO-->
                <div class="col-lg-12">
                    <div style="overflow-y: auto" class="modal fade" id="formModalEditAlimento" tabindex="-1" 
                         role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    <h4 class="modal-title" id="H2">Editar alimento</h4>
                                </div>
                                <div class="modal-body">
                                    <form name="formEditEstudio" role="form" method="POST" data-ng-submit="editMetadatosAlimentosG()">
                                        <div class="form-group">
                                            <h4>
                                                <strong>Alimento: </strong> 
                                                <br />
                                                <em data-toggle="tooltip" data-placement="top" title="Nombre cient&iacute;fico">{{metadatoActual.idAlimento.nombreCient}}</em>,
                                                <em data-toggle="tooltip" data-placement="top" title="Nombre com&uacute;n">{{metadatoActual.idAlimento.nombre}}</em>,
                                                <em data-toggle="tooltip" data-placement="top" title="Variedad">{{metadatoActual.idAlimento.variedad}}</em>,
                                                <em data-toggle="tooltip" data-placement="top" title="Parte">{{metadatoActual.idAlimento.parte}}</em>.
                                                <em data-toggle="tooltip" data-placement="top" title="Proceso">{{metadatoActual.idAlimento.proceso}}</em>.
                                                <em data-toggle="tooltip" data-placement="top" title="Mezcla">{{metadatoActual.idAlimento.mezcla}}</em>.
                                                <em data-toggle="tooltip" data-placement="top" title="Clasificaci&oacute;n en Cuba">{{metadatoActual.idAlimento.idTipoCuba.tipoCuba}}</em>.
                                                <em data-toggle="tooltip" data-placement="top" title="Clasificaci&oacute;n en la FAO">{{metadatoActual.idAlimento.idTipoFao.tipoFao}}</em>.
                                                <em data-toggle="tooltip" data-placement="top" title="Clasificaci&oacute;n en NRC">{{metadatoActual.idAlimento.idTipoNrc.tipoNrc}}</em>.
                                            </h4>

                                            <div id="div-1" class="accordion-body collapse in body">
                                                <div class="input-group">
                                                    <span class="input-group-addon">Riego</span>
                                                    <select class="form-control" data-ng-model="metadatoActual.riego" 
                                                            data-ng-options="tipo for tipo in tiposRiego">
                                                    </select>
                                                </div>
                                                <div class="input-group">
                                                    <span class="input-group-addon">N</span>
                                                    <input type="number" class="form-control" min="0"
                                                           data-ng-model="metadatoActual.n"/>                                                  
                                                </div>
                                                <div class="input-group">
                                                    <span class="input-group-addon">N-P-K</span>
                                                    <input type="number" min="0" data-ng-model="npk.n" /> -
                                                    <input type="number" min="0" data-ng-model="npk.p" /> -                                                 
                                                    <input type="number" min="0" data-ng-model="npk.k" />                                                  
                                                </div>
                                                <div class="input-group">
                                                    <span class="input-group-addon">Edad</span>
                                                    <input type="number" class="form-control" min="0" data-ng-model="metadatoActual.edad"/>                                                  
                                                </div>
                                                <div class="input-group">
                                                    <span class="input-group-addon">Corte</span>
                                                    <input type="text" class="form-control" data-ng-model="metadatoActual.corte">                                                  
                                                </div>
                                                <div class="input-group">
                                                    <span class="input-group-addon">Tecnolog&iacute;a</span>
                                                    <input type="text" class="form-control" data-ng-model="metadatoActual.tecnolog">                                                  
                                                </div>
                                                <div class="input-group">
                                                    <span class="input-group-addon">Tratamiento</span>
                                                    <input type="text" class="form-control" data-ng-model="metadatoActual.tratamiento"/>                                                  
                                                </div>
                                                <div class="input-group">
                                                    <span class="input-group-addon">Presentaci&oacute;n</span>
                                                    <input type="text" class="form-control" data-ng-model="metadatoActual.presentation">                                                  
                                                </div>
                                                <div class="input-group">
                                                    <span class="input-group-addon">Otras Caracter&iacute;sticas</span>
                                                    <input type="text" class="form-control" data-ng-model="metadatoActual.otrasCaract">                                                  
                                                </div>
                                                <div class="input-group">
                                                    <span class="input-group-addon">Calidad</span>
                                                    <select class="form-control" data-ng-options="c.idCalidad as c.calidad for c in allCalidades" 
                                                            data-ng-model="metadatoActual.calidad.idCalidad" required="">
                                                    </select>
                                                </div>
                                                <div class="input-group">
                                                    <span class="input-group-addon">&Eacute;poca</span>
                                                    <select class="form-control" data-ng-options="e.idEpoca as e.nombre for e in allEpocas" 
                                                            data-ng-model="metadatoActual.idEpoca.idEpoca" required="">
                                                    </select>
                                                </div>
                                                <div class="input-group">
                                                    <span class="input-group-addon">Fertilizado</span>
                                                    <select class="form-control" data-ng-options="f.idFertilizado as f.fertilizado for f in allFertilizado" 
                                                            data-ng-model="metadatoActual.fertilizado.idFertilizado" required="">
                                                    </select>
                                                </div>
                                                <div class="input-group">
                                                    <span class="input-group-addon">Mes de Inicio</span>
                                                    <select class="form-control" data-ng-options="m.idMes as m.mes for m in allMeses" 
                                                            data-ng-model="metadatoActual.mesIni.idMes" required="">
                                                    </select>
                                                </div>
                                                <div class="input-group">
                                                    <span class="input-group-addon">Mes de Finalizaci&oacute;n</span>
                                                    <select class="form-control" data-ng-options="m.idMes as m.mes for m in allMeses" 
                                                            data-ng-model="metadatoActual.mesFin.idMes" required="">
                                                    </select>
                                                </div>
                                                <div class="input-group">
                                                    <span class="input-group-addon">Nivel de Fertilizaci&oacute;n</span>
                                                    <select class="form-control" data-ng-options="nF.idNivelFert as nF.nivel for nF in allNivelFert" 
                                                            data-ng-model="metadatoActual.idNivelFert.idNivelFert" required="">
                                                    </select>
                                                </div>
                                                <div class="input-group">
                                                    <span class="input-group-addon">Pa&iacute;s de importaci&oacute;n</span>
                                                    <ui-select data-ng-model="metadatoActual.import1" 
                                                               theme="bootstrap">
                                                        <ui-select-match placeholder="Elija un pa&iacute;s...">
                                                            {{$select.selected.pais}}
                                                        </ui-select-match>
                                                        <ui-select-choices repeat="a in allPaises| filter: $select.search">
                                                            {{a.pais}}
                                                            <small> &LT;{{a.alpha2}}&GT;</small>
                                                        </ui-select-choices>
                                                    </ui-select>  
                                                </div>
                                                <div class="input-group">
                                                    <span class="input-group-addon">Provincia</span>
                                                    <select class="form-control" data-ng-options="p.idProvincia as p.provinciaNombre for p in allProvincias" 
                                                            data-ng-model="metadatoActual.idProvincia.idProvincia" required="">
                                                    </select>
                                                </div>
                                                <div class="input-group">
                                                    <span class="input-group-addon">Rango de Edades</span>
                                                    <select class="form-control" data-ng-options="rE.idRangoEdades as rE.rango for rE in allRangoEdades" 
                                                            data-ng-model="metadatoActual.idRangoEdades.idRangoEdades" required="">
                                                    </select>
                                                </div>
                                            </div>
                                            <br />
                                            <div class="text-right">
                                                <button type="submit" class="btn btn-success"
                                                        data-ng-disabled="formEditEstudio.$invalid || formEditEstudio.$pristine">Guardar</button>
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--END EDIT ALIMENTO-->
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
        <!--END PAGE LEVEL SCRIPT-->
    </body>
    <!-- END BODY-->
</html>