package aspecto;

import services.Trazable;
import models.Traza;
import repositorios.TrazaRepo;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;


import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

@Aspect
public class TrazaAspecto {
    
    @Autowired
    HttpServletRequest request;
    
    @Autowired
    TrazaRepo repositorio;
    
    private String clase;
    
    private String claseEntidad;
    
    private String claseTimeLine;
    /**
     * Pointcut that matches all repositories, services and Web REST endpoints.
     */
    @Pointcut("@annotation(services.Trazable)")
    public void springBeanPointcut() {
        // Method is empty as this is just a Pointcut, the implementations are in the advices.
    }
    
    @AfterReturning("springBeanPointcut()")
    public void doAccessCheck(JoinPoint punto) {
        try {
            Object[] argumentos = punto.getArgs();
            String nombreMetodo = punto.getSignature().getName();
            Trazable trazable = AspectoUtil.getTrazable(punto.getTarget(), nombreMetodo);
            Authentication principal = SecurityContextHolder.getContext().getAuthentication();
            if (trazable != null) {
                String url = request.getRequestURI();
                String accion = buscarAccion(trazable, argumentos);
                if (principal.isAuthenticated()) {
                    Traza traza = new Traza(url, new Date(), accion, principal.getName(), "INFO");
                    traza.setClase(clase);
                    traza.setTimeLineClase(claseTimeLine);
                    traza.setClaseEntidad(claseEntidad);
                    repositorio.saveAndFlush(traza);
                }
            }
        } catch (Exception e) {
            Logger.getLogger(TrazaAspecto.class.getName()).log(Level.SEVERE, null, e);
        }
    }
    
    private String buscarAccion(Trazable trazable, Object[] argumentos) {
        String accion = trazable.accion();
        int caso = trazable.listar() ? 1 : trazable.insertar() ? 2 : trazable.modificar() ? 3 : trazable.eliminar() ? 4 : 5;
        claseTimeLine = trazable.timeLine();
        claseEntidad = trazable.claseEntidad();
        switch (caso) {
            case 1:
                clase = "uk-badge uk-badge-primary";
                return accion;
            case 2:
                clase = "uk-badge uk-badge-primary";
                return accion;
            case 3:
                clase = "uk-badge uk-badge-success";
                return accion;
            case 4:
                clase = "uk-badge uk-badge-danger";
                return accion;
            default:
                clase = "uk-badge uk-badge-primary";
                return accion;
        }
        
    }
}
