<%-- 
    Document   : 403
    Created on : 13-mar-2018, 14:52:12
    Author     : albert
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!--GLOBAL STYLES AND TITLE-->
        <jsp:include page="/WEB-INF/includes/globalcss.jsp"/>
        <!--END GLOBAL STYLES-->
        <!-- PAGE LEVEL STYLES -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/error.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/magic/magic.css" />   
        <!--END PAGE LEVEL STYLES -->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <!-- PAGE CONTENT --> 
        <div class="container">
            <div class="col-lg-8 col-lg-offset-2 text-center">
                <div class="logo">
                    <h1>Error 403!</h1>
                </div>
                <p class="lead text-muted">Acceso Denegado!</p>
                <div class="clearfix"></div>
                <div class="col-lg-6 col-lg-offset-3">
                    <form action="index" method="get">
                    </form>
                </div>
                <div class="clearfix"></div>
                <br/>
                <div class="col-lg-6  col-lg-offset-3">
                    <div class="btn-group btn-group-justified">
                        <a onclick="regresar()"class="btn btn-primary">Página Principal</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- END PAGE CONTENT --> 
        <script>
            function regresar() {
                window.history.back();
            }
        </script>
    </body>
</html>
