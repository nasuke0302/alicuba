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
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/HelpPage.js"></script>
    </head>
    <body data-ng-controller="helpPageController">
        <br />
        <div class="col-md-12">
            <div class="row">
                <button class="btn btn-success col-md-offset-1" onclick="regresar()">
                    <span class="glyphicon glyphicon-arrow-left"></span> Regresar</button>
                <div class="text-center">
                    <img src="${pageContext.request.contextPath}/static/AlicubaLogo.png" style="width: 300px; height: 110px;"/>
                    <h1 style="color: #009933">Página de ayuda y contacto</h1>
                </div>
                <div>
                    <p data-ng-repeat="u in usuariosAdmins">
                        {{u.email}}
                    </p>
                </div>
            </div>
        </div>
        <script>
                    function regresar() {
                        window.history.back();
                    }
        </script>
    </body>
</html>
