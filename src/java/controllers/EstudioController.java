/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.util.HashMap;
import java.util.Map;
import models.Alimentos;
import models.MetadatosAlimentosG;
import models.Nutrientes;
import models.TablaCnaGeneral;
import models.TablaCnaGeneralPK;
import models.Usuarios;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;
import repositorios.AlimentosRepo;
import repositorios.CalidadRepo;
import repositorios.EpocasRepo;
import repositorios.FertilizadoRepo;
import repositorios.MesesRepo;
import repositorios.MetadatosAlimentosRepo;
import repositorios.NivelFertRepo;
import repositorios.NutrientesRepo;
import repositorios.PaisesRepo;
import repositorios.ProvinciaRepo;
import repositorios.RangoEdadesRepo;
import repositorios.TablaCnaGeneralRepo;
import repositorios.TiposDatosAlimentosRepo;
import repositorios.UnidadesMedidaRepo;

/**
 *
 * @author Tesis
 */
@Controller
public class EstudioController {

    @Autowired
    MetadatosAlimentosRepo metadatosAlimentosRepo;

    @Autowired
    CalidadRepo calidadRepo;

    @Autowired
    EpocasRepo epocasRepo;

    @Autowired
    FertilizadoRepo fertilizadoRepo;

    @Autowired
    MesesRepo mesesRepo;

    @Autowired
    NivelFertRepo nivelFertRepo;

    @Autowired
    PaisesRepo paisesRepo;

    @Autowired
    ProvinciaRepo provinciaRepo;

    @Autowired
    RangoEdadesRepo rangoEdadesRepo;

    @Autowired
    TiposDatosAlimentosRepo datosAlimentosRepo;

    @Autowired
    NutrientesRepo nutrientesRepo;

    @Autowired
    UnidadesMedidaRepo unidadesMedidaRepo;

    @Autowired
    AlimentosRepo alimentosRepo;

    @Autowired
    TablaCnaGeneralRepo tablaCnaGeneralRepo;

    @RequestMapping(value = "/estudio/gestionar")
    public ModelAndView showEstudio() {
        return new ModelAndView("estudio");
    }

    @RequestMapping(value = "/estudio/getMetadatos")
    public @ResponseBody
    Map<String, ? extends Object> getMetadatos() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", metadatosAlimentosRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("fail", Boolean.FALSE);
        }
        return map;
    }

    @RequestMapping(value = "/estudio/getCalidades")
    public @ResponseBody
    Map<String, ? extends Object> getCalidades() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", calidadRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("fail", Boolean.FALSE);
        }
        return map;
    }

    @RequestMapping(value = "/estudio/getEpocas")
    public @ResponseBody
    Map<String, ? extends Object> getEpocas() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", epocasRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("fail", Boolean.FALSE);
        }
        return map;
    }

    @RequestMapping(value = "/estudio/getFertilizado")
    public @ResponseBody
    Map<String, ? extends Object> getFertilizado() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", fertilizadoRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("fail", Boolean.FALSE);
        }
        return map;
    }

    @RequestMapping(value = "/estudio/getMeses")
    public @ResponseBody
    Map<String, ? extends Object> getMeses() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", mesesRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("fail", Boolean.FALSE);
        }
        return map;
    }

    @RequestMapping(value = "/estudio/getNivelFert")
    public @ResponseBody
    Map<String, ? extends Object> getNivelFert() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", nivelFertRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("fail", Boolean.FALSE);
        }
        return map;
    }

    @RequestMapping(value = "/estudio/getPaises")
    public @ResponseBody
    Map<String, ? extends Object> getPaises() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", paisesRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("fail", Boolean.FALSE);
        }
        return map;
    }

    @RequestMapping(value = "/estudio/getProvincias")
    public @ResponseBody
    Map<String, ? extends Object> getProvincias() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", provinciaRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("fail", Boolean.FALSE);
        }
        return map;
    }

    @RequestMapping(value = "/estudio/getRangoEdades")
    public @ResponseBody
    Map<String, ? extends Object> getRangoEdades() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", rangoEdadesRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("fail", Boolean.FALSE);
        }
        return map;
    }

    @RequestMapping(value = "/estudio/getTipoDatosAlimentos")
    public @ResponseBody
    Map<String, ? extends Object> getTipoDatosAlimentos() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", datosAlimentosRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("fail", Boolean.FALSE);
        }
        return map;
    }

    @RequestMapping(value = "/estudio/getNutrientes")
    public @ResponseBody
    Map<String, ? extends Object> getNutrientes() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", nutrientesRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("fail", Boolean.FALSE);
        }
        return map;
    }

    @RequestMapping(value = "/estudio/getUnidadesMedida")
    public @ResponseBody
    Map<String, ? extends Object> getUnidadesMedida() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", unidadesMedidaRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("fail", Boolean.FALSE);
        }
        return map;
    }

    @ResponseBody
    @RequestMapping(value = "/estudio/addAlimento")
    public ModelAndView addAlimento(@RequestBody Alimentos a, ModelMap map) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        a.setIdUsuario((Usuarios) principal);
        alimentosRepo.saveAndFlush(a);
        map.put("mensaje", "Alimento insertado correctamente");
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

    @ResponseBody
    @RequestMapping(value = "/estudio/addNutriente")
    public ModelAndView addNutriente(@RequestBody Nutrientes n, ModelMap map) {
        try {
            nutrientesRepo.saveAndFlush(n);
            map.put("mensaje", "Nutriente insertado correctamente");
        } catch (Exception e) {
            map.put("mensaje", "Error al insertar Nutriente");
            map.put("Error", e);
        }
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

    @RequestMapping(value = "/estudio/getOneTipoDatoAlimento/{id}")
    public ModelAndView getOneTipoDatoAlimento(@PathVariable Integer id, ModelMap map) {
        map.put("success", datosAlimentosRepo.findOne(id));
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

    @ResponseBody
    @RequestMapping(value = "/estudio/addEstudio")
    public ModelAndView addEstudio(@RequestBody MetadatosAlimentosG mag, ModelMap map) {
        try {
            metadatosAlimentosRepo.saveAndFlush(mag);
            map.put("mensaje", "Estudio insertado correctamente");
        } catch (Exception e) {
            map.put("mensaje", "Error al insertar Estudio");
            map.put("Error", e);
        }
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

    @ResponseBody
    @RequestMapping(value = "/estudio/addTablaCnaGeneral/{valor}")
    public ModelAndView addTablaCnaGeneral(@RequestBody TablaCnaGeneralPK cnaGeneralPK,
            @PathVariable Float valor, ModelMap map) {
        try {
            TablaCnaGeneral cnaGeneral = new TablaCnaGeneral();
            cnaGeneral.setTablaCnaGeneralPK(cnaGeneralPK);
            cnaGeneral.setValor(valor);
            tablaCnaGeneralRepo.saveAndFlush(cnaGeneral);
            map.put("nutriente", nutrientesRepo.findOne(cnaGeneralPK.getIdNutriente()));
            map.put("valor", cnaGeneral);
            map.put("mensaje", "Valor insertado correctamente");
        } catch (Exception e) {
            map.put("mensaje", "Error al insertar valor");
            map.put("Error", e);
        }
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

    @RequestMapping(value = "/estudio/getLastEstudio")
    public ModelAndView getLastEstudio(ModelMap map) {
        map.put("data", metadatosAlimentosRepo.findTopByOrderByIdMetadatosAlimentosGDesc());
        map.put("success", Boolean.TRUE);
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }
}
