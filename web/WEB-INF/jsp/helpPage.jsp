<%-- 
    Document   : helpPage
    Created on : 29-abr-2018, 23:05:58
    Author     : albert
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="/WEB-INF/includes/globalcss.jsp"/>
    </head>
    <body>
        <h1>This is the help page</h1>
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/index">Go to index page!</a>
    </body>
</html>
