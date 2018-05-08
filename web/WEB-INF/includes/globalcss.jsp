<%-- 
    Document   : globalCss
    Created on : 10-mar-2018, 15:19:02
    Author     : albert
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--TITLE-->
<title>Alicuba</title>
<link rel="icon" href="${pageContext.request.contextPath}/static/favicon.png" type="image/png">

<!--END TITLE-->
<!--GLOBAL STYLES-->
<link rel="stylesheet" href="<c:url value="/static/plugins/bootstrap/css/bootstrap.css"/>">
<link rel="stylesheet" href="<c:url value="/static/css/main.css"/>">
<link rel="stylesheet" href="<c:url value="/static/css/theme.css"/>">
<link rel="stylesheet" href="<c:url value="/static/css/MoneAdmin.css"/>">
<link rel="stylesheet" href="<c:url value="/static/plugins/Font-Awesome/css/font-awesome.css"/>">

<script src="${pageContext.request.contextPath}/static/WebSockets/sockjs.js"></script>
<script src="${pageContext.request.contextPath}/static/WebSockets/stomp.js"></script>
<script>
    var socket = new SockJS("${pageContext.request.contextPath}/websocket/configuration");
    var stompClient = Stomp.over(socket);
    stompClient.connect({}, function (frame) {
        stompClient.subscribe("/messages/enviar", function (result) {
            console.log(result);
        });
    });
</script>
<!--END GLOBAL STYLES --> 
