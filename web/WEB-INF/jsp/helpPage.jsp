<%-- 
    Document   : helpPage
    Created on : 29-abr-2018, 23:05:58
    Author     : albert
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="/WEB-INF/includes/globalcss.jsp"/>
    </head>
    <body>
        <h1>This is the help page</h1>
        <sec:authorize access="hasAnyAuthority('Colaborador', 'Editor')">
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/index">Go to index page!</a>
        </sec:authorize>

        <sec:authorize access="hasAuthority('Administrador')">
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/usuarios/gestionar">Go to admin page!</a>
        </sec:authorize>
    </body>
</html>
