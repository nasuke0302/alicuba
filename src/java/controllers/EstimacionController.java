/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.util.HashMap;
import java.util.Map;
import org.nfunk.jep.JEP;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import repositorios.FormulasRepo;
import repositorios.MetadatosAlimentosRepo;
import repositorios.ReferenciasRepo;

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

    JEP parser = new JEP();

    @RequestMapping(value = "/estimacion/gestionar")
    public ModelAndView showEstimacion() {
        return new ModelAndView("estimacionValores");
    }

    @RequestMapping(value = "/estimacion/getFormulas")
    public @ResponseBody
    Map<String, ? extends Object> getFormulas() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", formulasRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("fail", Boolean.FALSE);
        }
        return map;
    }

    @RequestMapping(value = "/estimacion/parseExp")
    public @ResponseBody
    Map<String, ? extends Object> parseExp(@RequestBody String expression) {
        Map<String, Object> map = new HashMap<>();
        parser.setImplicitMul(true);
        parser.parseExpression(expression);
        if (parser.hasError()) {
            map.put("mensaje", parser.getErrorInfo());
            map.put("success", Boolean.FALSE);
            return map;
        } else {
            double result = parser.getValue();
            map.put("mensaje", "Expresion correcta");
            map.put("data", result);
            map.put("success", Boolean.TRUE);
        }
        return map;
    }
}
