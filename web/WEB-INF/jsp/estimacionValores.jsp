<%-- 
    Document   : estimacionValores
    Created on : 23-may-2018, 10:54:00
    Author     : Tesis
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib  prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html data-ng-app="appEstimacion">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--GLOBAL STYLES AND TITLE-->
        <jsp:include page="/WEB-INF/includes/globalcss.jsp"/>
        <!--END GLOBAL STYLES-->

        <!--PAGE LEVEL STYLES-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/AngularJs/uiSelect/select.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/AngularJs/loadingBar/loading-bar.min.css">
        <!--END PAGE LEVEL STYLES-->

        <!--PAGE LEVEL SCRIPTS-->
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/uiSelect/select.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular-sanitize-1.2.19.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/loadingBar/loading-bar.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/EstimacionValores.js"></script>
        <!--END PAGE LEVEL SCRIPTS-->
    </head>
    <body class="padTop53" data-ng-controller="EstimacionController">
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
                            <br />
                            <div class="panel panel-default">
                                <!--ABRIR MODAL AÑADIR-->
                                <div class="panel-heading  ">
                                    <button id="añadirButton" class="icon-plus btn btn-success" data-ng-click="abrirNuevaFormulaModal()"
                                            data-toggle="modal" data-target="#formModalCreateOrEditFormula"> Nueva F&oacute;rmula</button>
                                </div>
                                <!--END ABRIR MODAL AÑADIR-->
                                <div class="panel-body">
                                    <!--BEGIN TABLE FORMULAS-->
                                    <table class="table table-condensed table-hover">
                                        <thead>
                                            <tr>
                                                <th>Acciones</th>
                                                <th>Nombre</th>
                                                <th>Nutriente resultado</th>
                                                <th>F&oacute;rmula</th>
                                                <th>Variables</th>
                                                <th>Colaborador</th>
                                            <tr>
                                        </thead>
                                        <tbody>
                                            <tr data-ng-repeat="f in allFormulas track by $index">
                                                <td>
                                                    <input type="hidden" value="{{f.idFormula}}"/>
                                                    <button class="btn btn-primary btn-xs"
                                                            <sec:authorize access="hasAuthority('Colaborador')"> 
                                                                data-ng-show="f.idUsuario.email === principal"
                                                            </sec:authorize>
                                                            data-toggle="modal" data-target="#formModalCreateOrEditFormula" 
                                                            data-ng-click="abrirEditarModal($index)">
                                                        <i class="glyphicon glyphicon-pencil"></i>
                                                    </button>
                                                    <button class="btn btn-danger btn-xs" data-toggle="modal" 
                                                            data-ng-show="f.idUsuario.email === principal"
                                                            data-target="#formModalEliminarFormula"
                                                            data-ng-click="abrirEliminarModal($index)">
                                                        <i class="glyphicon glyphicon-trash"></i>
                                                    </button>
                                                </td>
                                                <td>{{f.nombreFormula}}</td>
                                                <td>{{f.idNutriente.abreviatura}}, <small>{{f.idNutriente.nombre}}</small></td>
                                                <td>{{f.formula}}</td>
                                                <td>
                                                    <span data-ng-repeat="v in f.variablesList">
                                                        <strong> {{v.nombreVariable}}: </strong>
                                                        {{v.idNutriente.abreviatura}} - <small>{{v.idNutriente.nombre}}</small>
                                                        <br>
                                                    </span>
                                                </td>
                                                <td>{{f.idUsuario.nombre}} {{f.idUsuario.segundoNombre}} {{f.idUsuario.apellidos}}<br/>
                                                    <small>{{f.idUsuario.email}}</small>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <!--END TABLE FORMULAS-->
                                    <!--CREATE OR EDIT MODAL-->
                                    <div class="modal fade" id="formModalCreateOrEditFormula" tabindex="-1" 
                                         role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                    <h4 class="modal-title" id="H2">F&oacute;rmula</h4>
                                                </div>
                                                <div class="modal-body">
                                                    <button class="btn btn-success" data-ng-click="addVariable()">
                                                        <span class="glyphicon glyphicon-plus"></span>Agregar Variable
                                                    </button>
                                                    <br />
                                                    <br />
                                                    <div ng-repeat="vari in arregloVars">
                                                        <label>{{vari.nombreVariable}} =</label>
                                                        <ui-select data-ng-model="vari.idNutriente" 
                                                                   theme="bootstrap">
                                                            <ui-select-match placeholder="Elija un nutriente...">
                                                                {{$select.selected.abreviatura}}
                                                            </ui-select-match>
                                                            <ui-select-choices repeat="a in allNutrientes| filter: $select.search">
                                                                {{a.abreviatura}}
                                                                <small>{{a.nombre}}</small>
                                                            </ui-select-choices>
                                                        </ui-select> 
                                                        <br />
                                                    </div>
                                                    <form role="form" data-ng-submit="parseExp()" 
                                                          name="formAddFormula" method="post">
                                                        <div class="form-group">
                                                            <label>Nombre de la f&oacute;rmula: </label>
                                                            <input class="form-control" required="" data-ng-model="nuevaFormula.nombreFormula"/>
                                                            <br />
                                                            <label>Nutriente:</label>
                                                            <ui-select data-ng-model="nuevaFormula.idNutriente" 
                                                                       theme="bootstrap">
                                                                <ui-select-match placeholder="Elija un nutriente...">
                                                                    {{$select.selected.abreviatura}}
                                                                </ui-select-match>
                                                                <ui-select-choices repeat="a in allNutrientes| filter: $select.search">
                                                                    {{a.abreviatura}}
                                                                    <small>{{a.nombre}}</small>
                                                                </ui-select-choices>
                                                            </ui-select> 
                                                            <div data-ng-show="nuevaFormula.idNutriente === ''">
                                                                <span style="color:red; display: block; text-align: center;">
                                                                    Seleccione un nutriente</span>
                                                            </div>
                                                            <br />
                                                            <label>F&oacute;rmula:</label>
                                                            <input id="inputFormula" class="form-control" type="text"
                                                                   placeholder="Introduzca una f&oacute;rmula aqui"
                                                                   data-ng-model="nuevaFormula.formula" required=""/>
                                                            <br />
                                                            <div class="text-right">
                                                                <input type="hidden" data-ng-model="nuevaFormula.idFormula"/>
                                                                <input class="btn btn-success" type="submit" value="Evaluar y guardar"
                                                                       data-ng-disabled="formAddFormula.$invalid || formAddFormula.$pristine
                                                                                           || nuevaFormula.idNutriente === ''"/>
                                                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--END EDIT MODAL-->
                                    <!--DELETE MODAL-->
                                    <div class="modal fade" id="formModalEliminarFormula" role="dialog" style="display: none;">
                                        <div class="modal-dialog" style="margin-top: 260.5px;">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                    <h4 class="modal-title">¿Seguro que desea eliminar este registro?</h4>
                                                    <div class="modal-body">
                                                        <form role="form" method="post" data-ng-submit="eliminarFormula()" id="delete_data" class="text-right">
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
                </div>
                <!--END PAGE CONTENT -->
            </div>
            <!--END MAIN WRAP-->
            <jsp:include page="/WEB-INF/includes/footer.jsp"/>
            <jsp:include page="/WEB-INF/includes/globalScripts.jsp"/>
        </div>
    </body>
</html>
