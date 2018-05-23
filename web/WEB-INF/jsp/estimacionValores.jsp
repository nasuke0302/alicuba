<%-- 
    Document   : estimacionValores
    Created on : 23-may-2018, 10:54:00
    Author     : Tesis
--%>

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
        <!--END PAGE LEVEL STYLES-->

        <!--PAGE LEVEL SCRIPTS-->
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/uiSelect/select.min.js"></script>
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
                                <div class="panel-heading">
                                    <p>Estimar</p>
                                </div>
                                <div class="panel-body">
                                    <div class="form-group">
                                        <label>Alimentos con metadatos insertados</label>
                                        <ui-select data-ng-model="selectedMetadato.selected" 
                                                   theme="bootstrap">
                                            <ui-select-match placeholder="Elija un metadato...">
                                                {{$select.selected.idAlimento.nombre}}
                                            </ui-select-match>
                                            <ui-select-choices repeat="a in allMetadatos| filter: $select.search">
                                                {{a.idAlimento.nombre}}
                                            </ui-select-choices>
                                        </ui-select>   
                                    </div>
                                    <p>Nutrientes insertados del alimento seleccionado</p>
                                    <ul data-ng-repeat="a in selectedMetadato.selected.tablaCnaGeneralList">
                                        <li>{{a.nutrientes.nombre}}, valor: {{a.valor}}</li>
                                    </ul>
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
