/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.util.HashMap;
import java.util.Map;
import models.ListadoTablaGeneradas;
import models.Usuarios;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import repositorios.ListadoTablaGeneradasRepo;
import repositorios.MetadatosAlimentosTablaRepo;
import services.Trazable;

/**
 *
 * @author albert
 */
@Controller
public class MetadatosGeneradosController {

    @Autowired
    MetadatosAlimentosTablaRepo metadatosAlimentosTablaRepo;
    
    @Autowired
    ListadoTablaGeneradasRepo listadoTablaGeneradasRepo;

    @Trazable(accion = "listar", listar = true, nombre = "listarMetadatosGenerados", timeLine = "", claseEntidad = "MetadatosAlimentosTabla")
    @RequestMapping(value = "/metadatosGenerados/gestionar")
    public ModelAndView showGestionarCategorias() {
        return new ModelAndView("metadatosGenerados");
    }

    @RequestMapping(value = "/metadatosGenerados/getMetadatosGeneradosPorTablaGenerada/{id}")
    public @ResponseBody
    Map<String, ? extends Object> getMetadatosGeneradosPorTablaGenerada(@PathVariable Integer id) {
        Map<String, Object> map = new HashMap<>();
        ListadoTablaGeneradas ltg = listadoTablaGeneradasRepo.findOne(id);
        map.put("data", metadatosAlimentosTablaRepo.findByIdListadoTablaGeneradas(ltg));
        map.put("success", Boolean.TRUE);
        return map;
    }
}
