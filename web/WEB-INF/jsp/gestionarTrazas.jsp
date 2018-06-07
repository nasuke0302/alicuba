<%-- 
    Document   : gestionarTrazas
    Created on : 06-jun-2018, 10:38:09
    Author     : albert
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html data-ng-app="appTrazas">
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
        <script src="${pageContext.request.contextPath}/static/AngularJs/Trazas.js"></script>
        <!--END PAGE LEVEL STYLES-->
    </head>
    <body class="padTop53" data-ng-controller="trazasController">
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
                                <div class="panel-heading">
                                    <h1>Trazas</h1>
                                </div>
                                <div class="panel-body">
                                    <table datatable="ng" id="tablaTrazas" class="table table-condensed">
                                        <thead>
                                            <tr>
                                                <th>Fecha</th>
                                                <th>Url</th>
                                                <th>Usuario</th>
                                                <th>Acci&oacute;n</th>
                                                <th>Clase Entidad</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr data-ng-repeat="t in allTrazas track by $index">
                                                <td>{{t.tiempo}}</td>
                                                <td>{{t.url}}</td>
                                                <td>{{t.usuario}}</td>
                                                <td>{{t.accion}}</td>
                                                <td>{{t.claseEntidad}}</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="panel-footer">
                                    Trazas
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--END PAGE CONTENT-->
            <!--END MAIN WRAP-->
            <!-- FOOTER -->
            <jsp:include page="/WEB-INF/includes/footer.jsp"/>
            <!--END FOOTER -->
            <!--GLOBAL SCRIPTS-->
            <jsp:include page="/WEB-INF/includes/globalScripts.jsp"/>
            <!--END GLOBAL SCRIPTS-->
        </div>
    </body>
</html>
