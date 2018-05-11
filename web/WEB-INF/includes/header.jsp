<%-- 
    Document   : header
    Created on : 10-mar-2018, 16:41:57
    Author     : albert
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="seg" uri="http://www.springframework.org/security/tags" %>
<script>
    var notification = {};
    var msj = {};
    var socket = new SockJS("../alicuba/websocket/configuration");
    var stompClient = Stomp.over(socket);
    var notify;
    stompClient.connect({}, function (frame) {
        stompClient.subscribe("/user/queue/enviar", function (res) {
            notification = JSON.parse(res.body);
            notify = new Notification(notification.titulo, {
                body: notification.mensaje,
                icon: "/alicuba/static/IconWebSocket.png"});
            setTimeout(notification.close(), 1 * 1000);
        });

        stompClient.subscribe("/topic/notifications", function (res) {
            msj = JSON.parse(res.body);
        });
        
        stompClient.send("/topic/getMessages", {}, "dame mis notificaciones hijueputa");
    });
</script>

<div id="top">
    <nav class="navbar navbar-inverse navbar-fixed-top " style="padding-top: 10px;">
        <a data-original-title="Show/Hide Menu" data-placement="bottom" 
           data-tooltip="tooltip" class="accordion-toggle btn btn-primary btn-sm visible-xs" 
           data-toggle="collapse" href="#menu" id="menu-toggle">
            <i class="icon-align-justify"></i>
        </a>
        <!--LOGO SECTION--> 
        <header class="navbar-header">
            <a href="${pageContext.request.contextPath}/helpPage" class="navbar-brand">
                <img src="${pageContext.request.contextPath}/static/AlicubaLogo.png" style="width: 100px; height: 36px;"/>
            </a>
        </header>
        <!--END LOGO SECTION--> 
        <ul class="nav navbar-top-links navbar-right">
            <!--EGIN NOTIFICATIONS SECTION-->
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <span class="label label-success">2</span>
                    <i class="icon-envelope-alt"></i>&nbsp; <i class="icon-chevron-down"></i>
                </a>
                <ul class="dropdown-menu dropdown-messages">
                    <li>
                        <a href="#">
                            <div>
                                <strong>{{msj.titulo}}</strong>
                                <span class="pull-right text-muted">
                                    <em>{{msj.fecha}}</em>
                                </span>
                            </div>
                            <div>{{msj.mensaje}}</div>
                        </a>
                    </li>
                    <li class="divider"></li>
                </ul>
            </li>
            <!--END NOTIFICATIONS SECTION-->
            <!--ADMIN SETTINGS SECTIONS--> 
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="icon-user "> <seg:authentication property="principal.username"></seg:authentication>${user}</i>&nbsp; <i class="icon-chevron-down "></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="${pageContext.request.contextPath}/editarPerfil/show"><i class="icon-user"></i> Editar mi perfil </a></li>
                    <!--<li class="divider"></li>-->
                    <li><a href="${pageContext.request.contextPath}/logout"><i class="icon-signout"></i> Cerrar Sesi&oacute;n</a></li>
                    <li class="divider"></li>
                    <li><a href="${pageContext.request.contextPath}/helpPage"><i class="icon-question"></i> Acerca de...</a></li>
                </ul>
            </li>
            <!--END ADMIN SETTINGS SECTIONS--> 
        </ul>
    </nav>
</div>
