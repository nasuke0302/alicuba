<%-- 
    Document   : helpPage
    Created on : 29-abr-2018, 23:05:58
    Author     : albert
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html data-ng-app='appHelpPage'>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--TITLE-->
        <title>Alicuba</title>
        <!--END TITLE-->
        <!--GLOBAL STYLES-->
        <link rel="stylesheet" href="<c:url value="/static/plugins/bootstrap/css/bootstrap.css"/>">
        <link rel="stylesheet" href="<c:url value="/static/css/main.css"/>">
        <link rel="stylesheet" href="<c:url value="/static/css/theme.css"/>">
        <link rel="stylesheet" href="<c:url value="/static/css/MoneAdmin.css"/>">
        <link rel="stylesheet" href="<c:url value="/static/plugins/Font-Awesome/css/font-awesome.css"/>">
        <!--END GLOBAL STYLES --> 
        <link rel="icon" href="${pageContext.request.contextPath}/static/favicon.png" type="image/png">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/AngularJs/loadingBar/loading-bar.min.css">

        <script src="${pageContext.request.contextPath}/static/AngularJs/angular.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/loadingBar/loading-bar.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/HelpPage.js"></script>
    </head>
    <body class="padTop53" data-ng-controller="helpPageController">
        <!--MAIN WRAP-->
        <div id="wrap">
            <!-- HEADER SECTION -->
            <jsp:include page="/WEB-INF/includes/header.jsp"/>
            <!-- END HEADER SECTION -->
            <!-- MENU SECTION -->
            <jsp:include page="/WEB-INF/includes/menuContent.jsp"/>
            <!--END MENU SECTION -->
            <!--PAGE CONTENT -->
            <div id="content">
                <div class="inner" style="min-height:800px;">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="text-center">
                                <img src="${pageContext.request.contextPath}/static/AlicubaLogo.png" style="width: 300px; height: 110px;"/>
                                <h1 style="color: #009933">Página de ayuda y contacto</h1>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <p><strong>Administradores</strong></p>
                                </div>
                                <div class="panel-body">
                                    <div class="col-md-4" data-ng-repeat="u in usuariosAdmins">
                                        <div class="panel panel-primary">
                                            <div class="panel-heading">
                                                <p>{{u.nombre}} {{u.segundoNombre}} {{u.apellidos}} <p>
                                            </div>
                                            <div class="panel-body">
                                                <p> Email: {{u.email}}</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <p><strong>Editores</strong></p>
                                </div>
                                <div class="panel-body">
                                    <div class="col-md-4" data-ng-repeat="u in usuariosEditores">
                                        <div class="panel panel-primary">
                                            <div class="panel-heading">
                                                <p>{{u.nombre}} {{u.segundoNombre}} {{u.apellidos}} <p>
                                            </div>
                                            <div class="panel-body">
                                                <p> Email: {{u.email}}</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--END PAGE CONTENT-->
        </div>
        <script>
                    function regresar() {
                        window.history.back();
                    }
        </script>
        <!-- FOOTER -->
        <jsp:include page="/WEB-INF/includes/footer.jsp"/>
        <!--END FOOTER -->
        <!--GLOBAL SCRIPTS-->
        <jsp:include page="/WEB-INF/includes/globalScripts.jsp"/>
        <!--END GLOBAL SCRIPTS-->
    </body>
</html>
