<%-- 
    Document   : LoginHelpPage
    Created on : 18-may-2018, 13:50:53
    Author     : Tesis
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html data-ng-app="appLoginHelpPage">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alicuba</title>
        <!--GLOBAL STYLES-->
        <link rel="stylesheet" href="<c:url value="/static/plugins/bootstrap/css/bootstrap.css"/>">
        <link rel="stylesheet" href="<c:url value="/static/css/main.css"/>">
        <link rel="stylesheet" href="<c:url value="/static/css/theme.css"/>">
        <link rel="stylesheet" href="<c:url value="/static/css/MoneAdmin.css"/>">
        <link rel="stylesheet" href="<c:url value="/static/plugins/Font-Awesome/css/font-awesome.css"/>">
        <!--END GLOBAL STYLES --> 
        <link rel="icon" href="${pageContext.request.contextPath}/static/favicon.png" type="image/png">
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/LoginHelpPage.js"></script>
    </head>
    <body data-ng-controller="LoginHelpPageController">
        <!--PAGE CONTENT -->
        <div class="text-center">
            <div class="inner" style="min-height:800px;">
                <div class="col-md-12">
                    <div class="row">
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
                        <a class="btn btn-success col-md-4" href="${pageContext.request.contextPath}/login"><span class="glyphicon glyphicon-arrow-left"></span> Regresar</a>
                    </div>
                </div>
            </div>
        </div>
        <!--END PAGE CONTENT-->
    </body>
</html>
