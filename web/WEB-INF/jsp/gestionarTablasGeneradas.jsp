<%-- 
    Document   : gestionarAlimentos
    Created on : 28-mar-2018, 14:32:19
    Author     : albert
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib  prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html data-ng-app="appTablasGeneradas">
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
    <body class="padTop53" data-ng-controller="TablasGeneradasController">
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
                                    <sec:authorize access="hasAuthority('Editor')">
                                        <button id="añadirButton" class="icon-plus btn btn-success" data-ng-click="abrirNuevoAlimentoModal()"
                                                data-toggle="modal" data-target="#formModalCreateOrEdit"> Generar nueva tabla</button>
                                    </sec:authorize>
                                    <!--END ABRIR MODAL AÑADIR-->
                                </div>
                                <!--TABLA Alimentos-->
                                <div class="panel-body">
                                    <div class="table-responsive">
                                        <table  datatable="ng" id="tablaAlimentos" class="table table-striped table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Acciones</th>
                                                    <th>Nombre de la Tabla</th>
                                                    <th>Fecha</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr data-ng-repeat="tg in allTablasGeneradas track by $index"> 
                                                    <td>Acciones</td>
                                                    <td>{{tg.nombre}}</td>
                                                    <td>{{tg.fechaHora}}</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="panel-footer panel-default">
                                    <a>Listado de tablas generadas</a>
                                </div>
                            </div>
                        </div>
                    </div>
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
