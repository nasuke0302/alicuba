package controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import models.Mensaje;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.MessagingException;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import repositorios.MensajeRepo;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author Tesis
 */
@Controller
public class HeaderController {

    @Autowired
    MensajeRepo mensajeRepo;
    @Autowired
    SimpMessagingTemplate messagingTemplate;
    
    @RequestMapping(value = "/notifications/get")
    public @ResponseBody
    Map<String, ? extends Object> getNotifications() {
        Map<String, Object> map = new HashMap<>();
        try {
            List<Mensaje> notificaciones = mensajeRepo.findAll();
            map.put("data", notificaciones);
            map.put("success", Boolean.TRUE);
            for (int i = 0; i < notificaciones.size(); i++) {
                messagingTemplate.convertAndSendToUser(notificaciones.get(i).getReceiver().toLowerCase(),
                        "/queue/notifications", notificaciones.get(i));
            }
        } catch (MessagingException e) {
            map.put("success", Boolean.FALSE);
            map.put("error", e);
        }
        return map;
    }
}
