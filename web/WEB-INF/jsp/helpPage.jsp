<%-- 
    Document   : helpPage
    Created on : 29-abr-2018, 23:05:58
    Author     : albert
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
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
    </head>
    <body>
        <sec:authorize access="hasAnyAuthority('Colaborador', 'Editor', 'Administrador')">
            <br />
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/index">Go to index page!</a>
        </sec:authorize>
        <h1>This is the help page</h1>
    </body>
</html>
