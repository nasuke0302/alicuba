/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import models.Formulas;
import models.Mensaje;
import models.Usuarios;
import models.Variables;
import org.nfunk.jep.JEP;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;
import repositorios.FormulasRepo;
import repositorios.MensajeRepo;
import repositorios.MetadatosAlimentosRepo;
import repositorios.ReferenciasRepo;
import repositorios.VariablesRepo;
import services.Trazable;

/**
 *
 * @author Tesis
 */
@Controller
public class EstimacionController {

    @Autowired
    ReferenciasRepo referenciasRepo;

    @Autowired
    MetadatosAlimentosRepo metadatosAlimentosRepo;

    @Autowired
    FormulasRepo formulasRepo;

    @Autowired
    VariablesRepo variablesRepo;

    @Autowired
    SimpMessagingTemplate messagingTemplate;
    
    @Autowired
    MensajeRepo mensajeRepo;

    String username = "";
    DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");

    JEP parser = new JEP();

    @Trazable(accion = "listar", listar = true, nombre = "listarFórmulas", timeLine = "", claseEntidad = "Formulas")
    @RequestMapping(value = "/estimacion/gestionar")
    public ModelAndView showEstimacion() {
        return new ModelAndView("estimacionValores");
    }

    @RequestMapping(value = "/estimacion/getFormulas")
    public @ResponseBody
    Map<String, ? extends Object> getFormulas() {
        Map<String, Object> map = new HashMap<>();
        List<Formulas> allFormulas = formulasRepo.findAll();
        try {
            map.put("data", allFormulas);
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }

    @Trazable(accion = "insertar", insertar = true, nombre = "insertarFórmulas", timeLine = "", claseEntidad = "Formulas")
    @RequestMapping(value = "/estimacion/parseExp")
    public @ResponseBody
    Map<String, ? extends Object> parseExp(@RequestBody Formulas formula, @AuthenticationPrincipal Usuarios principal) {
        Map<String, Object> map = new HashMap<>();
        parser.setImplicitMul(true);
        parser.setAllowUndeclared(true);

        Formulas f1 = formula;
        parser.parseExpression(f1.getFormula());
        if (parser.hasError()) {
            map.put("mensaje", parser.getErrorInfo());
            map.put("success", Boolean.FALSE);
            return map;
        } else {
            //Si el id de la formula que llega esta vacio es que es una nueva
            if (formula.getIdFormula() == null) {
                //Guardo la formula que llego
                formula.setIdUsuario(principal);
                formulasRepo.saveAndFlush(f1);
                map.put("mensaje", "Expresion correcta");
                map.put("success", Boolean.TRUE);

                Mensaje mensaje = new Mensaje();
                Date fecha = new Date();
                mensaje.setFecha(dateFormat.format(fecha));
                mensaje.setLeido(Boolean.FALSE);
                mensaje.setMensaje(principal.getNombre() + " ha insertado una fórmula: " + formula.getNombreFormula());
                mensaje.setTitulo("Fórmula insertada");
                mensaje.setSender(principal.getNombre());
                mensaje.setReceiver("editores");
                mensajeRepo.saveAndFlush(mensaje);
                messagingTemplate.convertAndSend("/topic/notifications", mensaje);
            } //Si no es que se va  ahacer un actualizar
            else {
                f1.setIdUsuario(formulasRepo.findOne(formula.getIdFormula()).getIdUsuario());
                formulasRepo.saveAndFlush(f1);
                map.put("mensaje", "Expresion correcta");
                map.put("success", Boolean.TRUE);

                Mensaje mensaje = new Mensaje();
                Date fecha = new Date();
                mensaje.setFecha(dateFormat.format(fecha));
                mensaje.setLeido(Boolean.FALSE);
                mensaje.setMensaje(principal.getNombre() + " ha actualizado la fórmula: " + formula.getNombreFormula());
                mensaje.setTitulo("Fórmula editada");
                mensaje.setSender(principal.getNombre());
                mensaje.setReceiver("todos");
                mensajeRepo.saveAndFlush(mensaje);
                messagingTemplate.convertAndSend("/topic/notifications", mensaje);
            }

        }
        return map;
    }
    @Trazable(accion = "insertar", insertar = true, nombre = "insertarVariables", timeLine = "", claseEntidad = "Variables")
    @RequestMapping(value = "/estimacion/addVariables")
    public @ResponseBody
    Map<String, ? extends Object> addVariables(@RequestBody List<Variables> variablesList) {
        Map<String, Object> map = new HashMap<>();
        map.put("data", variablesRepo.save(variablesList));
        return map;
    }
    
    @Trazable(accion = "eliminar", eliminar = true, nombre = "eliminarFórmulas", timeLine = "", claseEntidad = "Formulas")
    @RequestMapping(value = "/estimacion/deleteFormulas/{id}", method = RequestMethod.DELETE)
    public ModelAndView deleteFormula(@PathVariable Integer id, ModelMap map) {
        Formulas formulaEliminar = formulasRepo.findOne(id);
        variablesRepo.delete(formulaEliminar.getVariablesList());
        formulasRepo.delete(id);
        map.put("mensaje", "Fórmula eliminada correctamente");
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }
}
